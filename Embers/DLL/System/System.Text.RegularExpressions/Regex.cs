using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Reflection;
using System.Reflection.Emit;
using System.Runtime.CompilerServices;
using System.Runtime.Serialization;
using System.Threading;
using Unity;

namespace System.Text.RegularExpressions;

public class Regex : ISerializable
{
	internal readonly struct CachedCodeEntryKey(RegexOptions options, string cultureKey, string pattern) : IEquatable<CachedCodeEntryKey>
	{
		private readonly RegexOptions _options = options;

		private readonly string _cultureKey = cultureKey;

		private readonly string _pattern = pattern;

		public override bool Equals(object obj)
		{
			if (obj is CachedCodeEntryKey)
			{
				return Equals((CachedCodeEntryKey)obj);
			}
			return false;
		}

		public bool Equals(CachedCodeEntryKey other)
		{
			if (_pattern.Equals(other._pattern) && _options == other._options)
			{
				return _cultureKey.Equals(other._cultureKey);
			}
			return false;
		}

		public static bool operator ==(CachedCodeEntryKey left, CachedCodeEntryKey right)
		{
			return left.Equals(right);
		}

		public override int GetHashCode()
		{
			return (int)((uint)_options ^ (uint)_cultureKey.GetHashCode()) ^ _pattern.GetHashCode();
		}
	}

	internal sealed class CachedCodeEntry
	{
		public CachedCodeEntry Next;

		public CachedCodeEntry Previous;

		public readonly CachedCodeEntryKey Key;

		public RegexCode Code;

		public readonly Hashtable Caps;

		public readonly Hashtable Capnames;

		public readonly string[] Capslist;

		public readonly int Capsize;

		public readonly ExclusiveReference Runnerref;

		public readonly WeakReference<RegexReplacement> ReplRef;

		public CachedCodeEntry(CachedCodeEntryKey key, Hashtable capnames, string[] capslist, RegexCode code, Hashtable caps, int capsize, ExclusiveReference runner, WeakReference<RegexReplacement> replref)
		{
			Key = key;
			Capnames = capnames;
			Capslist = capslist;
			Code = code;
			Caps = caps;
			Capsize = capsize;
			Runnerref = runner;
			ReplRef = replref;
		}
	}

	private const int CacheDictionarySwitchLimit = 10;

	private static int s_cacheSize;

	private static readonly Dictionary<CachedCodeEntryKey, CachedCodeEntry> s_cache;

	private static int s_cacheCount;

	private static CachedCodeEntry s_cacheFirst;

	private static CachedCodeEntry s_cacheLast;

	private static readonly TimeSpan s_maximumMatchTimeout;

	private const string DefaultMatchTimeout_ConfigKeyName = "REGEX_DEFAULT_MATCH_TIMEOUT";

	internal static readonly TimeSpan s_defaultMatchTimeout;

	public static readonly TimeSpan InfiniteMatchTimeout;

	protected internal TimeSpan internalMatchTimeout;

	internal const int MaxOptionShift = 10;

	protected internal string pattern;

	protected internal RegexOptions roptions;

	protected internal RegexRunnerFactory factory;

	protected internal Hashtable caps;

	protected internal Hashtable capnames;

	protected internal string[] capslist;

	protected internal int capsize;

	internal ExclusiveReference _runnerref;

	internal WeakReference<RegexReplacement> _replref;

	internal RegexCode _code;

	internal bool _refsInitialized;

	public static int CacheSize
	{
		get
		{
			return s_cacheSize;
		}
		set
		{
			if (value < 0)
			{
				throw new ArgumentOutOfRangeException("value");
			}
			lock (s_cache)
			{
				for (s_cacheSize = value; s_cacheCount > s_cacheSize; s_cacheCount--)
				{
					CachedCodeEntry cachedCodeEntry = s_cacheLast;
					if (s_cacheCount >= 10)
					{
						s_cache.Remove(cachedCodeEntry.Key);
					}
					s_cacheLast = cachedCodeEntry.Next;
					if (cachedCodeEntry.Next != null)
					{
						cachedCodeEntry.Next.Previous = null;
					}
					else
					{
						s_cacheFirst = null;
					}
				}
			}
		}
	}

	public TimeSpan MatchTimeout => internalMatchTimeout;

	[CLSCompliant(false)]
	protected IDictionary Caps
	{
		get
		{
			return caps;
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			caps = (value as Hashtable) ?? new Hashtable(value);
		}
	}

	[CLSCompliant(false)]
	protected IDictionary CapNames
	{
		get
		{
			return capnames;
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			capnames = (value as Hashtable) ?? new Hashtable(value);
		}
	}

	public RegexOptions Options => roptions;

	public bool RightToLeft => UseOptionR();

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	private CachedCodeEntry GetCachedCode(CachedCodeEntryKey key, bool isToAdd)
	{
		CachedCodeEntry cachedCodeEntry = s_cacheFirst;
		if (cachedCodeEntry != null && cachedCodeEntry.Key == key)
		{
			return cachedCodeEntry;
		}
		if (s_cacheSize == 0)
		{
			return null;
		}
		return GetCachedCodeEntryInternal(key, isToAdd);
	}

	private CachedCodeEntry GetCachedCodeEntryInternal(CachedCodeEntryKey key, bool isToAdd)
	{
		lock (s_cache)
		{
			CachedCodeEntry cachedCodeEntry = LookupCachedAndPromote(key);
			if (((cachedCodeEntry == null) & isToAdd) && s_cacheSize != 0)
			{
				cachedCodeEntry = new CachedCodeEntry(key, capnames, capslist, _code, caps, capsize, _runnerref, _replref);
				if (s_cacheFirst != null)
				{
					s_cacheFirst.Next = cachedCodeEntry;
					cachedCodeEntry.Previous = s_cacheFirst;
				}
				s_cacheFirst = cachedCodeEntry;
				s_cacheCount++;
				if (s_cacheCount >= 10)
				{
					if (s_cacheCount == 10)
					{
						FillCacheDictionary();
					}
					else
					{
						s_cache.Add(key, cachedCodeEntry);
					}
				}
				if (s_cacheLast == null)
				{
					s_cacheLast = cachedCodeEntry;
				}
				else if (s_cacheCount > s_cacheSize)
				{
					CachedCodeEntry cachedCodeEntry2 = s_cacheLast;
					if (s_cacheCount >= 10)
					{
						s_cache.Remove(cachedCodeEntry2.Key);
					}
					cachedCodeEntry2.Next.Previous = null;
					s_cacheLast = cachedCodeEntry2.Next;
					s_cacheCount--;
				}
			}
			return cachedCodeEntry;
		}
	}

	private void FillCacheDictionary()
	{
		s_cache.Clear();
		for (CachedCodeEntry previous = s_cacheFirst; previous != null; previous = previous.Previous)
		{
			s_cache.Add(previous.Key, previous);
		}
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	private static bool TryGetCacheValue(CachedCodeEntryKey key, out CachedCodeEntry entry)
	{
		if (s_cacheCount >= 10)
		{
			return s_cache.TryGetValue(key, out entry);
		}
		return TryGetCacheValueSmall(key, out entry);
	}

	private static bool TryGetCacheValueSmall(CachedCodeEntryKey key, out CachedCodeEntry entry)
	{
		for (entry = s_cacheFirst?.Previous; entry != null; entry = entry.Previous)
		{
			if (entry.Key == key)
			{
				return true;
			}
		}
		return false;
	}

	private static CachedCodeEntry LookupCachedAndPromote(CachedCodeEntryKey key)
	{
		CachedCodeEntry cachedCodeEntry = s_cacheFirst;
		if (cachedCodeEntry != null && cachedCodeEntry.Key == key)
		{
			return s_cacheFirst;
		}
		if (TryGetCacheValue(key, out var entry))
		{
			if (s_cacheLast == entry)
			{
				s_cacheLast = entry.Next;
			}
			else
			{
				entry.Previous.Next = entry.Next;
			}
			entry.Next.Previous = entry.Previous;
			s_cacheFirst.Next = entry;
			entry.Previous = s_cacheFirst;
			entry.Next = null;
			s_cacheFirst = entry;
		}
		return entry;
	}

	public static bool IsMatch(string input, string pattern)
	{
		return IsMatch(input, pattern, RegexOptions.None, s_defaultMatchTimeout);
	}

	public static bool IsMatch(string input, string pattern, RegexOptions options)
	{
		return IsMatch(input, pattern, options, s_defaultMatchTimeout);
	}

	public static bool IsMatch(string input, string pattern, RegexOptions options, TimeSpan matchTimeout)
	{
		return new Regex(pattern, options, matchTimeout, addToCache: true).IsMatch(input);
	}

	public bool IsMatch(string input)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		return IsMatch(input, UseOptionR() ? input.Length : 0);
	}

	public bool IsMatch(string input, int startat)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		return Run(quick: true, -1, input, 0, input.Length, startat) == null;
	}

	public static Match Match(string input, string pattern)
	{
		return Match(input, pattern, RegexOptions.None, s_defaultMatchTimeout);
	}

	public static Match Match(string input, string pattern, RegexOptions options)
	{
		return Match(input, pattern, options, s_defaultMatchTimeout);
	}

	public static Match Match(string input, string pattern, RegexOptions options, TimeSpan matchTimeout)
	{
		return new Regex(pattern, options, matchTimeout, addToCache: true).Match(input);
	}

	public Match Match(string input)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		return Match(input, UseOptionR() ? input.Length : 0);
	}

	public Match Match(string input, int startat)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		return Run(quick: false, -1, input, 0, input.Length, startat);
	}

	public Match Match(string input, int beginning, int length)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		return Run(quick: false, -1, input, beginning, length, UseOptionR() ? (beginning + length) : beginning);
	}

	public static MatchCollection Matches(string input, string pattern)
	{
		return Matches(input, pattern, RegexOptions.None, s_defaultMatchTimeout);
	}

	public static MatchCollection Matches(string input, string pattern, RegexOptions options)
	{
		return Matches(input, pattern, options, s_defaultMatchTimeout);
	}

	public static MatchCollection Matches(string input, string pattern, RegexOptions options, TimeSpan matchTimeout)
	{
		return new Regex(pattern, options, matchTimeout, addToCache: true).Matches(input);
	}

	public MatchCollection Matches(string input)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		return Matches(input, UseOptionR() ? input.Length : 0);
	}

	public MatchCollection Matches(string input, int startat)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		return new MatchCollection(this, input, 0, input.Length, startat);
	}

	public static string Replace(string input, string pattern, string replacement)
	{
		return Replace(input, pattern, replacement, RegexOptions.None, s_defaultMatchTimeout);
	}

	public static string Replace(string input, string pattern, string replacement, RegexOptions options)
	{
		return Replace(input, pattern, replacement, options, s_defaultMatchTimeout);
	}

	public static string Replace(string input, string pattern, string replacement, RegexOptions options, TimeSpan matchTimeout)
	{
		return new Regex(pattern, options, matchTimeout, addToCache: true).Replace(input, replacement);
	}

	public string Replace(string input, string replacement)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		return Replace(input, replacement, -1, UseOptionR() ? input.Length : 0);
	}

	public string Replace(string input, string replacement, int count)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		return Replace(input, replacement, count, UseOptionR() ? input.Length : 0);
	}

	public string Replace(string input, string replacement, int count, int startat)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		if (replacement == null)
		{
			throw new ArgumentNullException("replacement");
		}
		return RegexReplacement.GetOrCreate(_replref, replacement, caps, capsize, capnames, roptions).Replace(this, input, count, startat);
	}

	public static string Replace(string input, string pattern, MatchEvaluator evaluator)
	{
		return Replace(input, pattern, evaluator, RegexOptions.None, s_defaultMatchTimeout);
	}

	public static string Replace(string input, string pattern, MatchEvaluator evaluator, RegexOptions options)
	{
		return Replace(input, pattern, evaluator, options, s_defaultMatchTimeout);
	}

	public static string Replace(string input, string pattern, MatchEvaluator evaluator, RegexOptions options, TimeSpan matchTimeout)
	{
		return new Regex(pattern, options, matchTimeout, addToCache: true).Replace(input, evaluator);
	}

	public string Replace(string input, MatchEvaluator evaluator)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		return Replace(input, evaluator, -1, UseOptionR() ? input.Length : 0);
	}

	public string Replace(string input, MatchEvaluator evaluator, int count)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		return Replace(input, evaluator, count, UseOptionR() ? input.Length : 0);
	}

	public string Replace(string input, MatchEvaluator evaluator, int count, int startat)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		return Replace(evaluator, this, input, count, startat);
	}

	private static string Replace(MatchEvaluator evaluator, Regex regex, string input, int count, int startat)
	{
		if (evaluator == null)
		{
			throw new ArgumentNullException("evaluator");
		}
		if (count < -1)
		{
			throw new ArgumentOutOfRangeException("count", "Count cannot be less than -1.");
		}
		if (startat < 0 || startat > input.Length)
		{
			throw new ArgumentOutOfRangeException("startat", "Start index cannot be less than 0 or greater than input length.");
		}
		if (count == 0)
		{
			return input;
		}
		Match match = regex.Match(input, startat);
		if (!match.Success)
		{
			return input;
		}
		StringBuilder stringBuilder = System.Text.StringBuilderCache.Acquire();
		if (!regex.RightToLeft)
		{
			int num = 0;
			do
			{
				if (match.Index != num)
				{
					stringBuilder.Append(input, num, match.Index - num);
				}
				num = match.Index + match.Length;
				stringBuilder.Append(evaluator(match));
				if (--count == 0)
				{
					break;
				}
				match = match.NextMatch();
			}
			while (match.Success);
			if (num < input.Length)
			{
				stringBuilder.Append(input, num, input.Length - num);
			}
		}
		else
		{
			List<string> list = new List<string>();
			int num2 = input.Length;
			do
			{
				if (match.Index + match.Length != num2)
				{
					list.Add(input.Substring(match.Index + match.Length, num2 - match.Index - match.Length));
				}
				num2 = match.Index;
				list.Add(evaluator(match));
				if (--count == 0)
				{
					break;
				}
				match = match.NextMatch();
			}
			while (match.Success);
			if (num2 > 0)
			{
				stringBuilder.Append(input, 0, num2);
			}
			for (int num3 = list.Count - 1; num3 >= 0; num3--)
			{
				stringBuilder.Append(list[num3]);
			}
		}
		return System.Text.StringBuilderCache.GetStringAndRelease(stringBuilder);
	}

	public static string[] Split(string input, string pattern)
	{
		return Split(input, pattern, RegexOptions.None, s_defaultMatchTimeout);
	}

	public static string[] Split(string input, string pattern, RegexOptions options)
	{
		return Split(input, pattern, options, s_defaultMatchTimeout);
	}

	public static string[] Split(string input, string pattern, RegexOptions options, TimeSpan matchTimeout)
	{
		return new Regex(pattern, options, matchTimeout, addToCache: true).Split(input);
	}

	public string[] Split(string input)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		return Split(input, 0, UseOptionR() ? input.Length : 0);
	}

	public string[] Split(string input, int count)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		return Split(this, input, count, UseOptionR() ? input.Length : 0);
	}

	public string[] Split(string input, int count, int startat)
	{
		if (input == null)
		{
			throw new ArgumentNullException("input");
		}
		return Split(this, input, count, startat);
	}

	private static string[] Split(Regex regex, string input, int count, int startat)
	{
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Count cannot be less than -1.");
		}
		if (startat < 0 || startat > input.Length)
		{
			throw new ArgumentOutOfRangeException("startat", "Start index cannot be less than 0 or greater than input length.");
		}
		if (count == 1)
		{
			return new string[1] { input };
		}
		count--;
		Match match = regex.Match(input, startat);
		if (!match.Success)
		{
			return new string[1] { input };
		}
		List<string> list = new List<string>();
		if (!regex.RightToLeft)
		{
			int num = 0;
			do
			{
				list.Add(input.Substring(num, match.Index - num));
				num = match.Index + match.Length;
				for (int i = 1; i < match.Groups.Count; i++)
				{
					if (match.IsMatched(i))
					{
						list.Add(match.Groups[i].ToString());
					}
				}
				if (--count == 0)
				{
					break;
				}
				match = match.NextMatch();
			}
			while (match.Success);
			list.Add(input.Substring(num, input.Length - num));
		}
		else
		{
			int num2 = input.Length;
			do
			{
				list.Add(input.Substring(match.Index + match.Length, num2 - match.Index - match.Length));
				num2 = match.Index;
				for (int j = 1; j < match.Groups.Count; j++)
				{
					if (match.IsMatched(j))
					{
						list.Add(match.Groups[j].ToString());
					}
				}
				if (--count == 0)
				{
					break;
				}
				match = match.NextMatch();
			}
			while (match.Success);
			list.Add(input.Substring(0, num2));
			list.Reverse(0, list.Count);
		}
		return list.ToArray();
	}

	static Regex()
	{
		s_cacheSize = 15;
		s_cache = new Dictionary<CachedCodeEntryKey, CachedCodeEntry>(s_cacheSize);
		s_cacheCount = 0;
		s_maximumMatchTimeout = TimeSpan.FromMilliseconds(2147483646.0);
		InfiniteMatchTimeout = Timeout.InfiniteTimeSpan;
		s_defaultMatchTimeout = InitDefaultMatchTimeout();
	}

	protected internal static void ValidateMatchTimeout(TimeSpan matchTimeout)
	{
		if (InfiniteMatchTimeout == matchTimeout || (TimeSpan.Zero < matchTimeout && matchTimeout <= s_maximumMatchTimeout))
		{
			return;
		}
		throw new ArgumentOutOfRangeException("matchTimeout");
	}

	private static TimeSpan InitDefaultMatchTimeout()
	{
		object data = AppDomain.CurrentDomain.GetData("REGEX_DEFAULT_MATCH_TIMEOUT");
		if (data == null)
		{
			return InfiniteMatchTimeout;
		}
		if (data is TimeSpan timeSpan)
		{
			try
			{
				ValidateMatchTimeout(timeSpan);
				return timeSpan;
			}
			catch (ArgumentOutOfRangeException)
			{
				throw new ArgumentOutOfRangeException(global::SR.Format("AppDomain data '{0}' contains an invalid value or object for specifying a default matching timeout for System.Text.RegularExpressions.Regex.", "REGEX_DEFAULT_MATCH_TIMEOUT", timeSpan));
			}
		}
		throw new InvalidCastException(global::SR.Format("AppDomain data '{0}' contains an invalid value or object for specifying a default matching timeout for System.Text.RegularExpressions.Regex.", "REGEX_DEFAULT_MATCH_TIMEOUT", data));
	}

	protected Regex()
	{
		internalMatchTimeout = s_defaultMatchTimeout;
	}

	public Regex(string pattern)
		: this(pattern, RegexOptions.None, s_defaultMatchTimeout, addToCache: false)
	{
	}

	public Regex(string pattern, RegexOptions options)
		: this(pattern, options, s_defaultMatchTimeout, addToCache: false)
	{
	}

	public Regex(string pattern, RegexOptions options, TimeSpan matchTimeout)
		: this(pattern, options, matchTimeout, addToCache: false)
	{
	}

	protected Regex(SerializationInfo info, StreamingContext context)
		: this(info.GetString("pattern"), (RegexOptions)info.GetInt32("options"))
	{
		throw new PlatformNotSupportedException();
	}

	void ISerializable.GetObjectData(SerializationInfo si, StreamingContext context)
	{
		throw new PlatformNotSupportedException();
	}

	private Regex(string pattern, RegexOptions options, TimeSpan matchTimeout, bool addToCache)
	{
		if (pattern == null)
		{
			throw new ArgumentNullException("pattern");
		}
		if (options < RegexOptions.None || (int)options >> 10 != 0)
		{
			throw new ArgumentOutOfRangeException("options");
		}
		if ((options & RegexOptions.ECMAScript) != RegexOptions.None && (options & ~(RegexOptions.IgnoreCase | RegexOptions.Multiline | RegexOptions.Compiled | RegexOptions.ECMAScript | RegexOptions.CultureInvariant)) != RegexOptions.None)
		{
			throw new ArgumentOutOfRangeException("options");
		}
		ValidateMatchTimeout(matchTimeout);
		this.pattern = pattern;
		roptions = options;
		internalMatchTimeout = matchTimeout;
		CachedCodeEntryKey key = new CachedCodeEntryKey(options, ((options & RegexOptions.CultureInvariant) != RegexOptions.None) ? CultureInfo.InvariantCulture.ToString() : CultureInfo.CurrentCulture.ToString(), pattern);
		CachedCodeEntry cachedCode = GetCachedCode(key, isToAdd: false);
		if (cachedCode == null)
		{
			RegexTree regexTree = RegexParser.Parse(pattern, roptions);
			capnames = regexTree.CapNames;
			capslist = regexTree.CapsList;
			_code = RegexWriter.Write(regexTree);
			caps = _code.Caps;
			capsize = _code.CapSize;
			InitializeReferences();
			regexTree = null;
			if (addToCache)
			{
				cachedCode = GetCachedCode(key, isToAdd: true);
			}
		}
		else
		{
			caps = cachedCode.Caps;
			capnames = cachedCode.Capnames;
			capslist = cachedCode.Capslist;
			capsize = cachedCode.Capsize;
			_code = cachedCode.Code;
			_runnerref = cachedCode.Runnerref;
			_replref = cachedCode.ReplRef;
			_refsInitialized = true;
		}
	}

	public static string Escape(string str)
	{
		if (str == null)
		{
			throw new ArgumentNullException("str");
		}
		return RegexParser.Escape(str);
	}

	public static string Unescape(string str)
	{
		if (str == null)
		{
			throw new ArgumentNullException("str");
		}
		return RegexParser.Unescape(str);
	}

	public override string ToString()
	{
		return pattern;
	}

	public string[] GetGroupNames()
	{
		string[] array;
		if (capslist == null)
		{
			int num = capsize;
			array = new string[num];
			for (int i = 0; i < num; i++)
			{
				array[i] = Convert.ToString(i, CultureInfo.InvariantCulture);
			}
		}
		else
		{
			array = new string[capslist.Length];
			Array.Copy(capslist, 0, array, 0, capslist.Length);
		}
		return array;
	}

	public int[] GetGroupNumbers()
	{
		int[] array;
		if (caps == null)
		{
			array = new int[capsize];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = i;
			}
		}
		else
		{
			array = new int[caps.Count];
			IDictionaryEnumerator enumerator = caps.GetEnumerator();
			while (enumerator.MoveNext())
			{
				array[(int)enumerator.Value] = (int)enumerator.Key;
			}
		}
		return array;
	}

	public string GroupNameFromNumber(int i)
	{
		if (capslist == null)
		{
			if (i >= 0 && i < capsize)
			{
				return i.ToString(CultureInfo.InvariantCulture);
			}
			return string.Empty;
		}
		if (caps != null && !caps.TryGetValue<int>(i, out i))
		{
			return string.Empty;
		}
		if (i >= 0 && i < capslist.Length)
		{
			return capslist[i];
		}
		return string.Empty;
	}

	public int GroupNumberFromName(string name)
	{
		int value = -1;
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		if (capnames != null)
		{
			if (!capnames.TryGetValue<int>(name, out value))
			{
				return -1;
			}
			return value;
		}
		value = 0;
		foreach (char c in name)
		{
			if (c > '9' || c < '0')
			{
				return -1;
			}
			value *= 10;
			value += c - 48;
		}
		if (value >= 0 && value < capsize)
		{
			return value;
		}
		return -1;
	}

	protected void InitializeReferences()
	{
		if (_refsInitialized)
		{
			throw new NotSupportedException("This operation is only allowed once per object.");
		}
		_refsInitialized = true;
		_runnerref = new ExclusiveReference();
		_replref = new WeakReference<RegexReplacement>(null);
	}

	internal Match Run(bool quick, int prevlen, string input, int beginning, int length, int startat)
	{
		if (startat < 0 || startat > input.Length)
		{
			throw new ArgumentOutOfRangeException("startat", "Start index cannot be less than 0 or greater than input length.");
		}
		if (length < 0 || length > input.Length)
		{
			throw new ArgumentOutOfRangeException("length", "Length cannot be less than 0 or exceed input length.");
		}
		RegexRunner regexRunner = _runnerref.Get();
		if (regexRunner == null)
		{
			regexRunner = ((factory == null) ? new RegexInterpreter(_code, UseOptionInvariant() ? CultureInfo.InvariantCulture : CultureInfo.CurrentCulture) : factory.CreateInstance());
		}
		try
		{
			return regexRunner.Scan(this, input, beginning, beginning + length, startat, prevlen, quick, internalMatchTimeout);
		}
		finally
		{
			_runnerref.Release(regexRunner);
		}
	}

	protected bool UseOptionC()
	{
		return false;
	}

	protected internal bool UseOptionR()
	{
		return (roptions & RegexOptions.RightToLeft) != 0;
	}

	internal bool UseOptionInvariant()
	{
		return (roptions & RegexOptions.CultureInvariant) != 0;
	}

	public static void CompileToAssembly(RegexCompilationInfo[] regexinfos, AssemblyName assemblyname)
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}

	public static void CompileToAssembly(RegexCompilationInfo[] regexinfos, AssemblyName assemblyname, CustomAttributeBuilder[] attributes)
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}

	public static void CompileToAssembly(RegexCompilationInfo[] regexinfos, AssemblyName assemblyname, CustomAttributeBuilder[] attributes, string resourceFile)
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
