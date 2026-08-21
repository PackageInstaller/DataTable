using System.Collections.Generic;

namespace System.Dynamic;

internal class ExpandoClass
{
	private readonly string[] _keys;

	private readonly int _hashCode;

	private Dictionary<int, List<WeakReference>> _transitions;

	internal static readonly ExpandoClass Empty = new ExpandoClass();

	internal string[] Keys => _keys;

	internal ExpandoClass()
	{
		_hashCode = 6551;
		_keys = Array.Empty<string>();
	}

	internal ExpandoClass(string[] keys, int hashCode)
	{
		_hashCode = hashCode;
		_keys = keys;
	}

	internal ExpandoClass FindNewClass(string newKey)
	{
		int hashCode = _hashCode ^ newKey.GetHashCode();
		lock (this)
		{
			List<WeakReference> transitionList = GetTransitionList(hashCode);
			for (int i = 0; i < transitionList.Count; i++)
			{
				if (!(transitionList[i].Target is ExpandoClass expandoClass))
				{
					transitionList.RemoveAt(i);
					i--;
				}
				else if (string.Equals(expandoClass._keys[expandoClass._keys.Length - 1], newKey, StringComparison.Ordinal))
				{
					return expandoClass;
				}
			}
			string[] array = new string[_keys.Length + 1];
			Array.Copy(_keys, 0, array, 0, _keys.Length);
			array[_keys.Length] = newKey;
			ExpandoClass expandoClass2 = new ExpandoClass(array, hashCode);
			transitionList.Add(new WeakReference(expandoClass2));
			return expandoClass2;
		}
	}

	private List<WeakReference> GetTransitionList(int hashCode)
	{
		if (_transitions == null)
		{
			_transitions = new Dictionary<int, List<WeakReference>>();
		}
		if (!_transitions.TryGetValue(hashCode, out var value))
		{
			value = (_transitions[hashCode] = new List<WeakReference>());
		}
		return value;
	}

	internal int GetValueIndex(string name, bool caseInsensitive, ExpandoObject obj)
	{
		if (caseInsensitive)
		{
			return GetValueIndexCaseInsensitive(name, obj);
		}
		return GetValueIndexCaseSensitive(name);
	}

	internal int GetValueIndexCaseSensitive(string name)
	{
		for (int i = 0; i < _keys.Length; i++)
		{
			if (string.Equals(_keys[i], name, StringComparison.Ordinal))
			{
				return i;
			}
		}
		return -1;
	}

	private int GetValueIndexCaseInsensitive(string name, ExpandoObject obj)
	{
		int num = -1;
		lock (obj.LockObject)
		{
			for (int num2 = _keys.Length - 1; num2 >= 0; num2--)
			{
				if (string.Equals(_keys[num2], name, StringComparison.OrdinalIgnoreCase) && !obj.IsDeletedMember(num2))
				{
					if (num != -1)
					{
						return -2;
					}
					num = num2;
				}
			}
			return num;
		}
	}
}
