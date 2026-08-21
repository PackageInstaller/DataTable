using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading;
using Mono.Interop;

namespace System.Globalization;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
[ComVisible(true)]
public class CultureInfo : ICloneable, IFormatProvider
{
	private struct Data
	{
		public int ansi;

		public int ebcdic;

		public int mac;

		public int oem;

		public bool right_to_left;

		public byte list_sep;
	}

	private delegate void OnCultureInfoChangedDelegate([MarshalAs(UnmanagedType.LPWStr)] string language);

	private static volatile CultureInfo invariant_culture_info = new CultureInfo(127, useUserOverride: false, read_only: true);

	private static object shared_table_lock = new object();

	private static CultureInfo default_current_culture;

	private bool m_isReadOnly;

	private int cultureID;

	[NonSerialized]
	private int parent_lcid;

	[NonSerialized]
	private int datetime_index;

	[NonSerialized]
	private int number_index;

	[NonSerialized]
	private int default_calendar_type;

	private bool m_useUserOverride;

	internal volatile NumberFormatInfo numInfo;

	internal volatile DateTimeFormatInfo dateTimeInfo;

	private volatile TextInfo textInfo;

	internal string m_name;

	[NonSerialized]
	private string englishname;

	[NonSerialized]
	private string nativename;

	[NonSerialized]
	private string iso3lang;

	[NonSerialized]
	private string iso2lang;

	[NonSerialized]
	private string win3lang;

	[NonSerialized]
	private string territory;

	[NonSerialized]
	private string[] native_calendar_names;

	private volatile CompareInfo compareInfo;

	[NonSerialized]
	private unsafe readonly void* textinfo_data;

	private int m_dataItem;

	private Calendar calendar;

	[NonSerialized]
	private CultureInfo parent_culture;

	[NonSerialized]
	private bool constructed;

	[NonSerialized]
	internal byte[] cached_serialized_form;

	[NonSerialized]
	internal CultureData m_cultureData;

	[NonSerialized]
	internal bool m_isInherited;

	internal const int InvariantCultureId = 127;

	private const int CalendarTypeBits = 8;

	internal const int LOCALE_INVARIANT = 127;

	private const string MSG_READONLY = "This instance is read only";

	private static volatile CultureInfo s_DefaultThreadCurrentUICulture;

	private static volatile CultureInfo s_DefaultThreadCurrentCulture;

	private static Dictionary<int, CultureInfo> shared_by_number;

	private static Dictionary<string, CultureInfo> shared_by_name;

	private static CultureInfo s_UserPreferredCultureInfoInAppX;

	internal static readonly bool IsTaiwanSku;

	internal CultureData _cultureData => m_cultureData;

	internal bool _isInherited => m_isInherited;

	public static CultureInfo InvariantCulture => invariant_culture_info;

	public static CultureInfo CurrentCulture
	{
		get
		{
			return Thread.CurrentThread.CurrentCulture;
		}
		set
		{
			Thread.CurrentThread.CurrentCulture = value;
		}
	}

	public static CultureInfo CurrentUICulture
	{
		get
		{
			return Thread.CurrentThread.CurrentUICulture;
		}
		set
		{
			Thread.CurrentThread.CurrentUICulture = value;
		}
	}

	internal string Territory => territory;

	internal string _name => m_name;

	[ComVisible(false)]
	public CultureTypes CultureTypes
	{
		get
		{
			CultureTypes cultureTypes = (CultureTypes)0;
			foreach (CultureTypes value in Enum.GetValues(typeof(CultureTypes)))
			{
				if (Array.IndexOf(GetCultures(value), this) >= 0)
				{
					cultureTypes |= value;
				}
			}
			return cultureTypes;
		}
	}

	[ComVisible(false)]
	public string IetfLanguageTag
	{
		get
		{
			string name = Name;
			if (!(name == "zh-CHS"))
			{
				if (name == "zh-CHT")
				{
					return "zh-Hant";
				}
				return Name;
			}
			return "zh-Hans";
		}
	}

	[ComVisible(false)]
	public virtual int KeyboardLayoutId
	{
		get
		{
			switch (LCID)
			{
			case 4:
				return 2052;
			case 1034:
				return 3082;
			case 31748:
				return 1028;
			case 31770:
				return 2074;
			default:
				if (LCID >= 1024)
				{
					return LCID;
				}
				return LCID + 1024;
			}
		}
	}

	public virtual int LCID => cultureID;

	public virtual string Name => m_name;

	public virtual string NativeName
	{
		get
		{
			if (!constructed)
			{
				Construct();
			}
			return nativename;
		}
	}

	internal string NativeCalendarName
	{
		get
		{
			if (!constructed)
			{
				Construct();
			}
			return native_calendar_names[(default_calendar_type >> 8) - 1];
		}
	}

	public virtual Calendar Calendar
	{
		get
		{
			if (calendar == null)
			{
				if (!constructed)
				{
					Construct();
				}
				calendar = CreateCalendar(default_calendar_type);
			}
			return calendar;
		}
	}

	[MonoLimitation("Optional calendars are not supported only default calendar is returned")]
	public virtual Calendar[] OptionalCalendars => new Calendar[1] { Calendar };

	public virtual CultureInfo Parent
	{
		get
		{
			if (parent_culture == null)
			{
				if (!constructed)
				{
					Construct();
				}
				if (parent_lcid == cultureID)
				{
					if (parent_lcid == 31748 && EnglishName[EnglishName.Length - 1] == 'y')
					{
						return parent_culture = new CultureInfo("zh-Hant");
					}
					if (parent_lcid == 4 && EnglishName[EnglishName.Length - 1] == 'y')
					{
						return parent_culture = new CultureInfo("zh-Hans");
					}
					return null;
				}
				if (parent_lcid == 127)
				{
					parent_culture = InvariantCulture;
				}
				else if (cultureID == 127)
				{
					parent_culture = this;
				}
				else if (cultureID == 1028)
				{
					parent_culture = new CultureInfo("zh-CHT");
				}
				else
				{
					parent_culture = new CultureInfo(parent_lcid);
				}
			}
			return parent_culture;
		}
	}

	public virtual TextInfo TextInfo
	{
		get
		{
			if (textInfo == null)
			{
				if (!constructed)
				{
					Construct();
				}
				lock (this)
				{
					if (textInfo == null)
					{
						textInfo = CreateTextInfo(m_isReadOnly);
					}
				}
			}
			return textInfo;
		}
	}

	public virtual string ThreeLetterISOLanguageName
	{
		get
		{
			if (!constructed)
			{
				Construct();
			}
			return iso3lang;
		}
	}

	public virtual string ThreeLetterWindowsLanguageName
	{
		get
		{
			if (!constructed)
			{
				Construct();
			}
			return win3lang;
		}
	}

	public virtual string TwoLetterISOLanguageName
	{
		get
		{
			if (!constructed)
			{
				Construct();
			}
			return iso2lang;
		}
	}

	public bool UseUserOverride => m_useUserOverride;

	public virtual CompareInfo CompareInfo
	{
		get
		{
			if (compareInfo == null)
			{
				if (!constructed)
				{
					Construct();
				}
				lock (this)
				{
					if (compareInfo == null)
					{
						compareInfo = new CompareInfo(this);
					}
				}
			}
			return compareInfo;
		}
	}

	public virtual bool IsNeutralCulture
	{
		get
		{
			if (cultureID == 127)
			{
				return false;
			}
			if (!constructed)
			{
				Construct();
			}
			return territory == null;
		}
	}

	public virtual NumberFormatInfo NumberFormat
	{
		get
		{
			if (numInfo == null)
			{
				NumberFormatInfo numberFormatInfo = new NumberFormatInfo(m_cultureData);
				numberFormatInfo.isReadOnly = m_isReadOnly;
				numInfo = numberFormatInfo;
			}
			return numInfo;
		}
		set
		{
			if (!constructed)
			{
				Construct();
			}
			if (m_isReadOnly)
			{
				throw new InvalidOperationException("This instance is read only");
			}
			if (value == null)
			{
				throw new ArgumentNullException("NumberFormat");
			}
			numInfo = value;
		}
	}

	public virtual DateTimeFormatInfo DateTimeFormat
	{
		get
		{
			if (dateTimeInfo != null)
			{
				return dateTimeInfo;
			}
			if (!constructed)
			{
				Construct();
			}
			CheckNeutral();
			DateTimeFormatInfo dateTimeFormatInfo = ((!GlobalizationMode.Invariant) ? new DateTimeFormatInfo(m_cultureData, Calendar) : new DateTimeFormatInfo());
			dateTimeFormatInfo._isReadOnly = m_isReadOnly;
			Thread.MemoryBarrier();
			dateTimeInfo = dateTimeFormatInfo;
			return dateTimeInfo;
		}
		set
		{
			if (!constructed)
			{
				Construct();
			}
			if (m_isReadOnly)
			{
				throw new InvalidOperationException("This instance is read only");
			}
			if (value == null)
			{
				throw new ArgumentNullException("DateTimeFormat");
			}
			dateTimeInfo = value;
		}
	}

	public virtual string DisplayName => EnglishName;

	public virtual string EnglishName
	{
		get
		{
			if (!constructed)
			{
				Construct();
			}
			return englishname;
		}
	}

	public static CultureInfo InstalledUICulture => ConstructCurrentCulture();

	public bool IsReadOnly => m_isReadOnly;

	internal int CalendarType => (default_calendar_type >> 8) switch
	{
		1 => 1, 
		2 => 7, 
		3 => 23, 
		4 => 6, 
		_ => throw new NotImplementedException("CalendarType"), 
	};

	public static CultureInfo DefaultThreadCurrentCulture
	{
		get
		{
			return s_DefaultThreadCurrentCulture;
		}
		set
		{
			s_DefaultThreadCurrentCulture = value;
		}
	}

	public static CultureInfo DefaultThreadCurrentUICulture
	{
		get
		{
			return s_DefaultThreadCurrentUICulture;
		}
		set
		{
			s_DefaultThreadCurrentUICulture = value;
		}
	}

	internal string SortName => m_name;

	internal static CultureInfo UserDefaultUICulture => ConstructCurrentUICulture();

	internal static CultureInfo UserDefaultCulture => ConstructCurrentCulture();

	internal bool HasInvariantCultureName => Name == InvariantCulture.Name;

	internal static CultureInfo ConstructCurrentCulture()
	{
		if (default_current_culture != null)
		{
			return default_current_culture;
		}
		if (GlobalizationMode.Invariant)
		{
			return InvariantCulture;
		}
		string current_locale_name = get_current_locale_name();
		CultureInfo cultureInfo = null;
		if (current_locale_name != null)
		{
			try
			{
				cultureInfo = CreateSpecificCulture(current_locale_name);
			}
			catch
			{
			}
		}
		if (cultureInfo == null)
		{
			cultureInfo = InvariantCulture;
		}
		else
		{
			cultureInfo.m_isReadOnly = true;
			cultureInfo.m_useUserOverride = true;
		}
		default_current_culture = cultureInfo;
		return cultureInfo;
	}

	internal static CultureInfo ConstructCurrentUICulture()
	{
		return ConstructCurrentCulture();
	}

	[ComVisible(false)]
	public CultureInfo GetConsoleFallbackUICulture()
	{
		switch (Name)
		{
		case "ar":
		case "ar-BH":
		case "ar-EG":
		case "ar-IQ":
		case "ar-JO":
		case "ar-KW":
		case "ar-LB":
		case "ar-LY":
		case "ar-QA":
		case "ar-SA":
		case "ar-SY":
		case "ar-AE":
		case "ar-YE":
		case "dv":
		case "dv-MV":
		case "fa":
		case "fa-IR":
		case "gu":
		case "gu-IN":
		case "he":
		case "he-IL":
		case "hi":
		case "hi-IN":
		case "kn":
		case "kn-IN":
		case "kok":
		case "kok-IN":
		case "mr":
		case "mr-IN":
		case "pa":
		case "pa-IN":
		case "sa":
		case "sa-IN":
		case "syr":
		case "syr-SY":
		case "ta":
		case "ta-IN":
		case "te":
		case "te-IN":
		case "th":
		case "th-TH":
		case "ur":
		case "ur-PK":
		case "vi":
		case "vi-VN":
			return GetCultureInfo("en");
		case "ar-DZ":
		case "ar-MA":
		case "ar-TN":
			return GetCultureInfo("fr");
		default:
			if ((CultureTypes & CultureTypes.WindowsOnlyCultures) == 0)
			{
				return this;
			}
			return InvariantCulture;
		}
	}

	public void ClearCachedData()
	{
		lock (shared_table_lock)
		{
			shared_by_number = null;
			shared_by_name = null;
		}
		default_current_culture = null;
		RegionInfo.ClearCachedData();
		TimeZone.ClearCachedData();
		TimeZoneInfo.ClearCachedData();
	}

	public virtual object Clone()
	{
		if (!constructed)
		{
			Construct();
		}
		CultureInfo cultureInfo = (CultureInfo)MemberwiseClone();
		cultureInfo.m_isReadOnly = false;
		cultureInfo.cached_serialized_form = null;
		if (!IsNeutralCulture)
		{
			cultureInfo.NumberFormat = (NumberFormatInfo)NumberFormat.Clone();
			cultureInfo.DateTimeFormat = (DateTimeFormatInfo)DateTimeFormat.Clone();
		}
		return cultureInfo;
	}

	public override bool Equals(object value)
	{
		if (value is CultureInfo cultureInfo && cultureInfo.cultureID == cultureID)
		{
			return cultureInfo.m_name == m_name;
		}
		return false;
	}

	public static CultureInfo[] GetCultures(CultureTypes types)
	{
		bool num = (types & CultureTypes.NeutralCultures) != 0;
		bool specific = (types & CultureTypes.SpecificCultures) != 0;
		bool installed = (types & CultureTypes.InstalledWin32Cultures) != 0;
		CultureInfo[] array = internal_get_cultures(num, specific, installed);
		int i = 0;
		if (num && array.Length != 0 && array[0] == null)
		{
			array[i++] = (CultureInfo)InvariantCulture.Clone();
		}
		for (; i < array.Length; i++)
		{
			CultureInfo cultureInfo = array[i];
			Data textInfoData = cultureInfo.GetTextInfoData();
			CultureInfo obj = array[i];
			string name = cultureInfo.m_name;
			int datetimeIndex = cultureInfo.datetime_index;
			int calendarType = cultureInfo.CalendarType;
			int numberIndex = cultureInfo.number_index;
			string text = cultureInfo.iso2lang;
			int ansi = textInfoData.ansi;
			int oem = textInfoData.oem;
			int mac = textInfoData.mac;
			int ebcdic = textInfoData.ebcdic;
			bool right_to_left = textInfoData.right_to_left;
			char list_sep = (char)textInfoData.list_sep;
			obj.m_cultureData = CultureData.GetCultureData(name, useUserOverride: false, datetimeIndex, calendarType, numberIndex, text, ansi, oem, mac, ebcdic, right_to_left, list_sep.ToString());
		}
		return array;
	}

	private unsafe Data GetTextInfoData()
	{
		return *(Data*)textinfo_data;
	}

	public override int GetHashCode()
	{
		return cultureID.GetHashCode();
	}

	public static CultureInfo ReadOnly(CultureInfo ci)
	{
		if (ci == null)
		{
			throw new ArgumentNullException("ci");
		}
		if (ci.m_isReadOnly)
		{
			return ci;
		}
		CultureInfo cultureInfo = (CultureInfo)ci.Clone();
		cultureInfo.m_isReadOnly = true;
		if (cultureInfo.numInfo != null)
		{
			cultureInfo.numInfo = NumberFormatInfo.ReadOnly(cultureInfo.numInfo);
		}
		if (cultureInfo.dateTimeInfo != null)
		{
			cultureInfo.dateTimeInfo = DateTimeFormatInfo.ReadOnly(cultureInfo.dateTimeInfo);
		}
		if (cultureInfo.textInfo != null)
		{
			cultureInfo.textInfo = TextInfo.ReadOnly(cultureInfo.textInfo);
		}
		return cultureInfo;
	}

	public override string ToString()
	{
		return m_name;
	}

	private void CheckNeutral()
	{
	}

	public virtual object GetFormat(Type formatType)
	{
		object result = null;
		if (formatType == typeof(NumberFormatInfo))
		{
			result = NumberFormat;
		}
		else if (formatType == typeof(DateTimeFormatInfo))
		{
			result = DateTimeFormat;
		}
		return result;
	}

	private void Construct()
	{
		construct_internal_locale_from_lcid(cultureID);
		constructed = true;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern bool construct_internal_locale_from_lcid(int lcid);

	[MethodImpl((MethodImplOptions)4096)]
	private extern bool construct_internal_locale_from_name(string name);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern string get_current_locale_name();

	[MethodImpl((MethodImplOptions)4096)]
	private static extern CultureInfo[] internal_get_cultures(bool neutral, bool specific, bool installed);

	private void ConstructInvariant(bool read_only)
	{
		cultureID = 127;
		numInfo = NumberFormatInfo.InvariantInfo;
		if (!read_only)
		{
			numInfo = (NumberFormatInfo)numInfo.Clone();
		}
		textInfo = TextInfo.Invariant;
		m_name = string.Empty;
		englishname = (nativename = "Invariant Language (Invariant Country)");
		iso3lang = "IVL";
		iso2lang = "iv";
		win3lang = "IVL";
		default_calendar_type = 257;
	}

	private TextInfo CreateTextInfo(bool readOnly)
	{
		TextInfo obj = new TextInfo(m_cultureData);
		obj.SetReadOnlyState(readOnly);
		return obj;
	}

	public CultureInfo(int culture)
		: this(culture, useUserOverride: true)
	{
	}

	public CultureInfo(int culture, bool useUserOverride)
		: this(culture, useUserOverride, read_only: false)
	{
	}

	private CultureInfo(int culture, bool useUserOverride, bool read_only)
	{
		if (culture < 0)
		{
			throw new ArgumentOutOfRangeException("culture", "Positive number required.");
		}
		constructed = true;
		m_isReadOnly = read_only;
		m_useUserOverride = useUserOverride;
		if (culture == 127)
		{
			m_cultureData = CultureData.Invariant;
			ConstructInvariant(read_only);
			return;
		}
		if (!construct_internal_locale_from_lcid(culture))
		{
			string message = string.Format(InvariantCulture, "Culture ID {0} (0x{1}) is not a supported culture.", culture.ToString(InvariantCulture), culture.ToString("X4", InvariantCulture));
			throw new CultureNotFoundException("culture", message);
		}
		Data textInfoData = GetTextInfoData();
		string name = m_name;
		bool useUserOverride2 = m_useUserOverride;
		int datetimeIndex = datetime_index;
		int calendarType = CalendarType;
		int numberIndex = number_index;
		string text = iso2lang;
		int ansi = textInfoData.ansi;
		int oem = textInfoData.oem;
		int mac = textInfoData.mac;
		int ebcdic = textInfoData.ebcdic;
		bool right_to_left = textInfoData.right_to_left;
		char list_sep = (char)textInfoData.list_sep;
		m_cultureData = CultureData.GetCultureData(name, useUserOverride2, datetimeIndex, calendarType, numberIndex, text, ansi, oem, mac, ebcdic, right_to_left, list_sep.ToString());
	}

	public CultureInfo(string name)
		: this(name, useUserOverride: true)
	{
	}

	public CultureInfo(string name, bool useUserOverride)
		: this(name, useUserOverride, read_only: false)
	{
	}

	private CultureInfo(string name, bool useUserOverride, bool read_only)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		constructed = true;
		m_isReadOnly = read_only;
		m_useUserOverride = useUserOverride;
		m_isInherited = GetType() != typeof(CultureInfo);
		if (name.Length == 0)
		{
			m_cultureData = CultureData.Invariant;
			ConstructInvariant(read_only);
			return;
		}
		if (!ConstructLocaleFromName(name.ToLowerInvariant()))
		{
			throw CreateNotFoundException(name);
		}
		Data textInfoData = GetTextInfoData();
		string name2 = m_name;
		int datetimeIndex = datetime_index;
		int calendarType = CalendarType;
		int numberIndex = number_index;
		string text = iso2lang;
		int ansi = textInfoData.ansi;
		int oem = textInfoData.oem;
		int mac = textInfoData.mac;
		int ebcdic = textInfoData.ebcdic;
		bool right_to_left = textInfoData.right_to_left;
		char list_sep = (char)textInfoData.list_sep;
		m_cultureData = CultureData.GetCultureData(name2, useUserOverride, datetimeIndex, calendarType, numberIndex, text, ansi, oem, mac, ebcdic, right_to_left, list_sep.ToString());
	}

	private CultureInfo()
	{
		constructed = true;
	}

	private static void insert_into_shared_tables(CultureInfo c)
	{
		if (shared_by_number == null)
		{
			shared_by_number = new Dictionary<int, CultureInfo>();
			shared_by_name = new Dictionary<string, CultureInfo>();
		}
		shared_by_number[c.cultureID] = c;
		shared_by_name[c.m_name] = c;
	}

	public static CultureInfo GetCultureInfo(int culture)
	{
		if (culture < 1)
		{
			throw new ArgumentOutOfRangeException("culture", "Positive number required.");
		}
		lock (shared_table_lock)
		{
			if (shared_by_number != null && shared_by_number.TryGetValue(culture, out var value))
			{
				return value;
			}
			value = new CultureInfo(culture, useUserOverride: false, read_only: true);
			insert_into_shared_tables(value);
			return value;
		}
	}

	public static CultureInfo GetCultureInfo(string name)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		lock (shared_table_lock)
		{
			if (shared_by_name != null && shared_by_name.TryGetValue(name, out var value))
			{
				return value;
			}
			value = new CultureInfo(name, useUserOverride: false, read_only: true);
			insert_into_shared_tables(value);
			return value;
		}
	}

	[MonoTODO("Currently it ignores the altName parameter")]
	public static CultureInfo GetCultureInfo(string name, string altName)
	{
		if (name == null)
		{
			throw new ArgumentNullException("null");
		}
		if (altName == null)
		{
			throw new ArgumentNullException("null");
		}
		return GetCultureInfo(name);
	}

	public static CultureInfo GetCultureInfoByIetfLanguageTag(string name)
	{
		if (!(name == "zh-Hans"))
		{
			if (name == "zh-Hant")
			{
				return GetCultureInfo("zh-CHT");
			}
			return GetCultureInfo(name);
		}
		return GetCultureInfo("zh-CHS");
	}

	internal static CultureInfo CreateCulture(string name, bool reference)
	{
		bool flag = name.Length == 0;
		bool useUserOverride;
		bool read_only;
		if (reference)
		{
			useUserOverride = !flag;
			read_only = false;
		}
		else
		{
			read_only = false;
			useUserOverride = !flag;
		}
		return new CultureInfo(name, useUserOverride, read_only);
	}

	public static CultureInfo CreateSpecificCulture(string name)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		if (name.Length == 0)
		{
			return InvariantCulture;
		}
		string name2 = name;
		name = name.ToLowerInvariant();
		CultureInfo cultureInfo = new CultureInfo();
		if (!cultureInfo.ConstructLocaleFromName(name))
		{
			throw CreateNotFoundException(name2);
		}
		if (cultureInfo.IsNeutralCulture)
		{
			cultureInfo = CreateSpecificCultureFromNeutral(cultureInfo.Name);
		}
		Data textInfoData = cultureInfo.GetTextInfoData();
		CultureInfo cultureInfo2 = cultureInfo;
		string name3 = cultureInfo.m_name;
		int datetimeIndex = cultureInfo.datetime_index;
		int calendarType = cultureInfo.CalendarType;
		int numberIndex = cultureInfo.number_index;
		string text = cultureInfo.iso2lang;
		int ansi = textInfoData.ansi;
		int oem = textInfoData.oem;
		int mac = textInfoData.mac;
		int ebcdic = textInfoData.ebcdic;
		bool right_to_left = textInfoData.right_to_left;
		char list_sep = (char)textInfoData.list_sep;
		cultureInfo2.m_cultureData = CultureData.GetCultureData(name3, useUserOverride: false, datetimeIndex, calendarType, numberIndex, text, ansi, oem, mac, ebcdic, right_to_left, list_sep.ToString());
		return cultureInfo;
	}

	private bool ConstructLocaleFromName(string name)
	{
		if (construct_internal_locale_from_name(name))
		{
			return true;
		}
		int num = name.Length - 1;
		if (num > 0)
		{
			while ((num = name.LastIndexOf('-', num - 1)) > 0)
			{
				if (construct_internal_locale_from_name(name.Substring(0, num)))
				{
					return true;
				}
			}
		}
		return false;
	}

	private static CultureInfo CreateSpecificCultureFromNeutral(string name)
	{
		int culture;
		switch (name.ToLowerInvariant())
		{
		case "af":
			culture = 1078;
			break;
		case "am":
			culture = 1118;
			break;
		case "ar":
			culture = 1025;
			break;
		case "arn":
			culture = 1146;
			break;
		case "as":
			culture = 1101;
			break;
		case "az":
			culture = 1068;
			break;
		case "az-cyrl":
			culture = 2092;
			break;
		case "az-latn":
			culture = 1068;
			break;
		case "ba":
			culture = 1133;
			break;
		case "be":
			culture = 1059;
			break;
		case "bg":
			culture = 1026;
			break;
		case "bn":
			culture = 1093;
			break;
		case "bo":
			culture = 1105;
			break;
		case "br":
			culture = 1150;
			break;
		case "bs":
			culture = 5146;
			break;
		case "bs-cyrl":
			culture = 8218;
			break;
		case "bs-latn":
			culture = 5146;
			break;
		case "ca":
			culture = 1027;
			break;
		case "co":
			culture = 1155;
			break;
		case "cs":
			culture = 1029;
			break;
		case "cy":
			culture = 1106;
			break;
		case "da":
			culture = 1030;
			break;
		case "de":
			culture = 1031;
			break;
		case "dsb":
			culture = 2094;
			break;
		case "dv":
			culture = 1125;
			break;
		case "el":
			culture = 1032;
			break;
		case "en":
			culture = 1033;
			break;
		case "es":
			culture = 3082;
			break;
		case "et":
			culture = 1061;
			break;
		case "eu":
			culture = 1069;
			break;
		case "fa":
			culture = 1065;
			break;
		case "fi":
			culture = 1035;
			break;
		case "fil":
			culture = 1124;
			break;
		case "fo":
			culture = 1080;
			break;
		case "fr":
			culture = 1036;
			break;
		case "fy":
			culture = 1122;
			break;
		case "ga":
			culture = 2108;
			break;
		case "gd":
			culture = 1169;
			break;
		case "gl":
			culture = 1110;
			break;
		case "gsw":
			culture = 1156;
			break;
		case "gu":
			culture = 1095;
			break;
		case "ha":
			culture = 1128;
			break;
		case "ha-latn":
			culture = 1128;
			break;
		case "he":
			culture = 1037;
			break;
		case "hi":
			culture = 1081;
			break;
		case "hr":
			culture = 1050;
			break;
		case "hsb":
			culture = 1070;
			break;
		case "hu":
			culture = 1038;
			break;
		case "hy":
			culture = 1067;
			break;
		case "id":
			culture = 1057;
			break;
		case "ig":
			culture = 1136;
			break;
		case "ii":
			culture = 1144;
			break;
		case "is":
			culture = 1039;
			break;
		case "it":
			culture = 1040;
			break;
		case "iu":
			culture = 2141;
			break;
		case "iu-cans":
			culture = 1117;
			break;
		case "iu-latn":
			culture = 2141;
			break;
		case "ja":
			culture = 1041;
			break;
		case "ka":
			culture = 1079;
			break;
		case "kk":
			culture = 1087;
			break;
		case "kl":
			culture = 1135;
			break;
		case "km":
			culture = 1107;
			break;
		case "kn":
			culture = 1099;
			break;
		case "ko":
			culture = 1042;
			break;
		case "kok":
			culture = 1111;
			break;
		case "ky":
			culture = 1088;
			break;
		case "lb":
			culture = 1134;
			break;
		case "lo":
			culture = 1108;
			break;
		case "lt":
			culture = 1063;
			break;
		case "lv":
			culture = 1062;
			break;
		case "mi":
			culture = 1153;
			break;
		case "mk":
			culture = 1071;
			break;
		case "ml":
			culture = 1100;
			break;
		case "mn":
			culture = 1104;
			break;
		case "mn-cyrl":
			culture = 1104;
			break;
		case "mn-mong":
			culture = 2128;
			break;
		case "moh":
			culture = 1148;
			break;
		case "mr":
			culture = 1102;
			break;
		case "ms":
			culture = 1086;
			break;
		case "mt":
			culture = 1082;
			break;
		case "nb":
			culture = 1044;
			break;
		case "ne":
			culture = 1121;
			break;
		case "nl":
			culture = 1043;
			break;
		case "nn":
			culture = 2068;
			break;
		case "no":
			culture = 1044;
			break;
		case "nso":
			culture = 1132;
			break;
		case "oc":
			culture = 1154;
			break;
		case "or":
			culture = 1096;
			break;
		case "pa":
			culture = 1094;
			break;
		case "pl":
			culture = 1045;
			break;
		case "prs":
			culture = 1164;
			break;
		case "ps":
			culture = 1123;
			break;
		case "pt":
			culture = 1046;
			break;
		case "qut":
			culture = 1158;
			break;
		case "quz":
			culture = 1131;
			break;
		case "rm":
			culture = 1047;
			break;
		case "ro":
			culture = 1048;
			break;
		case "ru":
			culture = 1049;
			break;
		case "rw":
			culture = 1159;
			break;
		case "sa":
			culture = 1103;
			break;
		case "sah":
			culture = 1157;
			break;
		case "se":
			culture = 1083;
			break;
		case "si":
			culture = 1115;
			break;
		case "sk":
			culture = 1051;
			break;
		case "sl":
			culture = 1060;
			break;
		case "sma":
			culture = 7227;
			break;
		case "smj":
			culture = 5179;
			break;
		case "smn":
			culture = 9275;
			break;
		case "sms":
			culture = 8251;
			break;
		case "sq":
			culture = 1052;
			break;
		case "sr":
			culture = 9242;
			break;
		case "sr-cyrl":
			culture = 10266;
			break;
		case "sr-latn":
			culture = 9242;
			break;
		case "sv":
			culture = 1053;
			break;
		case "sw":
			culture = 1089;
			break;
		case "syr":
			culture = 1114;
			break;
		case "ta":
			culture = 1097;
			break;
		case "te":
			culture = 1098;
			break;
		case "tg":
			culture = 1064;
			break;
		case "tg-cyrl":
			culture = 1064;
			break;
		case "th":
			culture = 1054;
			break;
		case "tk":
			culture = 1090;
			break;
		case "tn":
			culture = 1074;
			break;
		case "tr":
			culture = 1055;
			break;
		case "tt":
			culture = 1092;
			break;
		case "tzm":
			culture = 2143;
			break;
		case "tzm-latn":
			culture = 2143;
			break;
		case "ug":
			culture = 1152;
			break;
		case "uk":
			culture = 1058;
			break;
		case "ur":
			culture = 1056;
			break;
		case "uz":
			culture = 1091;
			break;
		case "uz-cyrl":
			culture = 2115;
			break;
		case "uz-latn":
			culture = 1091;
			break;
		case "vi":
			culture = 1066;
			break;
		case "wo":
			culture = 1160;
			break;
		case "xh":
			culture = 1076;
			break;
		case "yo":
			culture = 1130;
			break;
		case "zh":
			culture = 2052;
			break;
		case "zh-chs":
		case "zh-hans":
			culture = 2052;
			break;
		case "zh-cht":
		case "zh-hant":
			culture = 3076;
			break;
		case "zu":
			culture = 1077;
			break;
		default:
			throw new NotImplementedException("Mapping for neutral culture " + name);
		}
		return new CultureInfo(culture);
	}

	private static Calendar CreateCalendar(int calendarType)
	{
		string text = null;
		switch (calendarType >> 8)
		{
		case 1:
			return new GregorianCalendar((GregorianCalendarTypes)(calendarType & 0xFF));
		case 2:
			text = "System.Globalization.ThaiBuddhistCalendar";
			break;
		case 3:
			text = "System.Globalization.UmAlQuraCalendar";
			break;
		case 4:
			text = "System.Globalization.HijriCalendar";
			break;
		default:
			throw new NotImplementedException("Unknown calendar type: " + calendarType);
		}
		Type type = Type.GetType(text, throwOnError: false);
		if (type == null)
		{
			return new GregorianCalendar(GregorianCalendarTypes.Localized);
		}
		return (Calendar)Activator.CreateInstance(type);
	}

	private static Exception CreateNotFoundException(string name)
	{
		return new CultureNotFoundException("name", "Culture name " + name + " is not supported.");
	}

	[DllImport("__Internal")]
	private static extern void InitializeUserPreferredCultureInfoInAppX(OnCultureInfoChangedDelegate onCultureInfoChangedInAppX);

	[DllImport("__Internal")]
	private static extern void SetUserPreferredCultureInfoInAppX([MarshalAs(UnmanagedType.LPWStr)] string name);

	[MonoPInvokeCallback(typeof(OnCultureInfoChangedDelegate))]
	private static void OnCultureInfoChangedInAppX([MarshalAs(UnmanagedType.LPWStr)] string language)
	{
		if (language != null)
		{
			s_UserPreferredCultureInfoInAppX = new CultureInfo(language);
		}
		else
		{
			s_UserPreferredCultureInfoInAppX = null;
		}
	}

	internal static CultureInfo GetCultureInfoForUserPreferredLanguageInAppX()
	{
		if (s_UserPreferredCultureInfoInAppX == null)
		{
			InitializeUserPreferredCultureInfoInAppX(OnCultureInfoChangedInAppX);
		}
		return s_UserPreferredCultureInfoInAppX;
	}

	internal static void SetCultureInfoForUserPreferredLanguageInAppX(CultureInfo cultureInfo)
	{
		if (s_UserPreferredCultureInfoInAppX == null)
		{
			InitializeUserPreferredCultureInfoInAppX(OnCultureInfoChangedInAppX);
		}
		SetUserPreferredCultureInfoInAppX(cultureInfo.Name);
		s_UserPreferredCultureInfoInAppX = cultureInfo;
	}

	internal static void CheckDomainSafetyObject(object obj, object container)
	{
		if (obj.GetType().Assembly != typeof(CultureInfo).Assembly)
		{
			throw new InvalidOperationException(string.Format(CurrentCulture, Environment.GetResourceString("Cannot set sub-classed {0} object to {1} object."), obj.GetType(), container.GetType()));
		}
	}

	internal static bool VerifyCultureName(string cultureName, bool throwException)
	{
		foreach (char c in cultureName)
		{
			if (!char.IsLetterOrDigit(c) && c != '-' && c != '_')
			{
				if (throwException)
				{
					throw new ArgumentException(Environment.GetResourceString("The given culture name '{0}' cannot be used to locate a resource file. Resource filenames must consist of only letters, numbers, hyphens or underscores.", cultureName));
				}
				return false;
			}
		}
		return true;
	}

	internal static bool VerifyCultureName(CultureInfo culture, bool throwException)
	{
		if (!culture.m_isInherited)
		{
			return true;
		}
		return VerifyCultureName(culture.Name, throwException);
	}
}
