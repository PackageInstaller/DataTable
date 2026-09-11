using System;
using System.Buffers;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Microsoft.Win32.SafeHandles;

namespace Microsoft.Win32;

public sealed class RegistryKey : MarshalByRefObject, IDisposable
{
	[Flags]
	private enum StateFlags
	{
		Dirty = 1,
		SystemKey = 2,
		WriteAccess = 4,
		PerfData = 8
	}

	internal static readonly IntPtr HKEY_CLASSES_ROOT = new IntPtr(int.MinValue);

	internal static readonly IntPtr HKEY_CURRENT_USER = new IntPtr(-2147483647);

	internal static readonly IntPtr HKEY_LOCAL_MACHINE = new IntPtr(-2147483646);

	internal static readonly IntPtr HKEY_USERS = new IntPtr(-2147483645);

	internal static readonly IntPtr HKEY_PERFORMANCE_DATA = new IntPtr(-2147483644);

	internal static readonly IntPtr HKEY_CURRENT_CONFIG = new IntPtr(-2147483643);

	internal static readonly IntPtr HKEY_DYN_DATA = new IntPtr(-2147483642);

	private static readonly string[] s_hkeyNames = new string[7] { "HKEY_CLASSES_ROOT", "HKEY_CURRENT_USER", "HKEY_LOCAL_MACHINE", "HKEY_USERS", "HKEY_PERFORMANCE_DATA", "HKEY_CURRENT_CONFIG", "HKEY_DYN_DATA" };

	private volatile SafeRegistryHandle _hkey;

	private volatile string _keyName;

	private volatile bool _remoteKey;

	private volatile StateFlags _state;

	private volatile RegistryKeyPermissionCheck _checkMode;

	private volatile RegistryView _regView;

	private void ClosePerfDataKey()
	{
		Interop.Advapi32.RegCloseKey(HKEY_PERFORMANCE_DATA);
	}

	private static RegistryKey OpenBaseKeyCore(RegistryHive hKeyHive, RegistryView view)
	{
		IntPtr intPtr = (IntPtr)(int)hKeyHive;
		int num = (int)intPtr & 0xFFFFFFF;
		bool flag = intPtr == HKEY_PERFORMANCE_DATA;
		return new RegistryKey(new SafeRegistryHandle(intPtr, flag), writable: true, systemkey: true, remoteKey: false, flag, view)
		{
			_checkMode = RegistryKeyPermissionCheck.Default,
			_keyName = s_hkeyNames[num]
		};
	}

	private RegistryKey InternalOpenSubKeyCore(string name, bool writable, bool throwOnPermissionFailure)
	{
		SafeRegistryHandle hkResult = null;
		int num = Interop.Advapi32.RegOpenKeyEx(_hkey, name, 0, GetRegistryKeyAccess(writable) | (int)_regView, out hkResult);
		if (num == 0 && !hkResult.IsInvalid)
		{
			return new RegistryKey(hkResult, writable, systemkey: false, _remoteKey, isPerfData: false, _regView)
			{
				_checkMode = GetSubKeyPermissionCheck(writable),
				_keyName = _keyName + "\\" + name
			};
		}
		if (throwOnPermissionFailure && (num == 5 || num == 1346))
		{
			ThrowHelper.ThrowSecurityException("Requested registry access is not allowed.");
		}
		return null;
	}

	private int InternalSubKeyCountCore()
	{
		int lpcSubKeys = 0;
		int lpcValues = 0;
		int num = Interop.Advapi32.RegQueryInfoKey(_hkey, null, null, IntPtr.Zero, ref lpcSubKeys, null, null, ref lpcValues, null, null, null, null);
		if (num != 0)
		{
			Win32Error(num, null);
		}
		return lpcSubKeys;
	}

	private string[] InternalGetSubKeyNamesCore(int subkeys)
	{
		List<string> list = new List<string>(subkeys);
		char[] array = ArrayPool<char>.Shared.Rent(256);
		try
		{
			int lpcbName = array.Length;
			int num;
			while ((num = Interop.Advapi32.RegEnumKeyEx(_hkey, list.Count, array, ref lpcbName, null, null, null, null)) != 259)
			{
				if (num == 0)
				{
					list.Add(new string(array, 0, lpcbName));
					lpcbName = array.Length;
				}
				else
				{
					Win32Error(num, null);
				}
			}
		}
		finally
		{
			ArrayPool<char>.Shared.Return(array);
		}
		return list.ToArray();
	}

	private object InternalGetValueCore(string name, object defaultValue, bool doNotExpand)
	{
		object obj = defaultValue;
		int lpType = 0;
		int lpcbData = 0;
		int num = Interop.Advapi32.RegQueryValueEx(_hkey, name, (int[])null, ref lpType, (byte[])null, ref lpcbData);
		if (num != 0)
		{
			if (IsPerfDataKey())
			{
				int num2 = 65000;
				int lpcbData2 = num2;
				byte[] array = new byte[num2];
				int num3;
				while (234 == (num3 = Interop.Advapi32.RegQueryValueEx(_hkey, name, null, ref lpType, array, ref lpcbData2)))
				{
					if (num2 == int.MaxValue)
					{
						Win32Error(num3, name);
					}
					else
					{
						num2 = ((num2 <= 1073741823) ? (num2 * 2) : int.MaxValue);
					}
					lpcbData2 = num2;
					array = new byte[num2];
				}
				if (num3 != 0)
				{
					Win32Error(num3, name);
				}
				return array;
			}
			if (num != 234)
			{
				return obj;
			}
		}
		if (lpcbData < 0)
		{
			lpcbData = 0;
		}
		switch (lpType)
		{
		case 0:
		case 3:
		case 5:
		{
			byte[] array4 = new byte[lpcbData];
			num = Interop.Advapi32.RegQueryValueEx(_hkey, name, null, ref lpType, array4, ref lpcbData);
			obj = array4;
			break;
		}
		case 11:
			if (lpcbData <= 8)
			{
				long lpData = 0L;
				num = Interop.Advapi32.RegQueryValueEx(_hkey, name, null, ref lpType, ref lpData, ref lpcbData);
				obj = lpData;
				break;
			}
			goto case 0;
		case 4:
			if (lpcbData <= 4)
			{
				int lpData2 = 0;
				num = Interop.Advapi32.RegQueryValueEx(_hkey, name, null, ref lpType, ref lpData2, ref lpcbData);
				obj = lpData2;
				break;
			}
			goto case 11;
		case 1:
		{
			if (lpcbData % 2 == 1)
			{
				try
				{
					lpcbData = checked(lpcbData + 1);
				}
				catch (OverflowException innerException2)
				{
					throw new IOException("RegistryKey.GetValue does not allow a String that has a length greater than Int32.MaxValue.", innerException2);
				}
			}
			char[] array5 = new char[lpcbData / 2];
			num = Interop.Advapi32.RegQueryValueEx(_hkey, name, null, ref lpType, array5, ref lpcbData);
			obj = ((array5.Length == 0 || array5[array5.Length - 1] != 0) ? new string(array5) : new string(array5, 0, array5.Length - 1));
			break;
		}
		case 2:
		{
			if (lpcbData % 2 == 1)
			{
				try
				{
					lpcbData = checked(lpcbData + 1);
				}
				catch (OverflowException innerException3)
				{
					throw new IOException("RegistryKey.GetValue does not allow a String that has a length greater than Int32.MaxValue.", innerException3);
				}
			}
			char[] array6 = new char[lpcbData / 2];
			num = Interop.Advapi32.RegQueryValueEx(_hkey, name, null, ref lpType, array6, ref lpcbData);
			obj = ((array6.Length == 0 || array6[array6.Length - 1] != 0) ? new string(array6) : new string(array6, 0, array6.Length - 1));
			if (!doNotExpand)
			{
				obj = Environment.ExpandEnvironmentVariables((string)obj);
			}
			break;
		}
		case 7:
		{
			if (lpcbData % 2 == 1)
			{
				try
				{
					lpcbData = checked(lpcbData + 1);
				}
				catch (OverflowException innerException)
				{
					throw new IOException("RegistryKey.GetValue does not allow a String that has a length greater than Int32.MaxValue.", innerException);
				}
			}
			char[] array2 = new char[lpcbData / 2];
			num = Interop.Advapi32.RegQueryValueEx(_hkey, name, null, ref lpType, array2, ref lpcbData);
			if (array2.Length != 0 && array2[array2.Length - 1] != 0)
			{
				Array.Resize(ref array2, array2.Length + 1);
			}
			string[] array3 = Array.Empty<string>();
			int num4 = 0;
			int num5 = 0;
			int num6 = array2.Length;
			while (num == 0 && num5 < num6)
			{
				int i;
				for (i = num5; i < num6 && array2[i] != 0; i++)
				{
				}
				string text = null;
				if (i < num6)
				{
					if (i - num5 > 0)
					{
						text = new string(array2, num5, i - num5);
					}
					else if (i != num6 - 1)
					{
						text = string.Empty;
					}
				}
				else
				{
					text = new string(array2, num5, num6 - num5);
				}
				num5 = i + 1;
				if (text != null)
				{
					if (array3.Length == num4)
					{
						Array.Resize(ref array3, (num4 > 0) ? (num4 * 2) : 4);
					}
					array3[num4++] = text;
				}
			}
			Array.Resize(ref array3, num4);
			obj = array3;
			break;
		}
		}
		return obj;
	}

	private void Win32Error(int errorCode, string str)
	{
		switch (errorCode)
		{
		case 5:
			throw (str != null) ? new UnauthorizedAccessException(SR.Format("Access to the registry key '{0}' is denied.", str)) : new UnauthorizedAccessException();
		case 6:
			if (!IsPerfDataKey())
			{
				_hkey.SetHandleAsInvalid();
				_hkey = null;
			}
			break;
		case 2:
			throw new IOException("The specified registry key does not exist.", errorCode);
		}
		throw new IOException(Interop.Kernel32.GetMessage(errorCode), errorCode);
	}

	private static int GetRegistryKeyAccess(bool isWritable)
	{
		if (!isWritable)
		{
			return 131097;
		}
		return 131103;
	}

	private RegistryKey(SafeRegistryHandle hkey, bool writable, bool systemkey, bool remoteKey, bool isPerfData, RegistryView view)
	{
		ValidateKeyView(view);
		_hkey = hkey;
		_keyName = "";
		_remoteKey = remoteKey;
		_regView = view;
		if (systemkey)
		{
			_state |= StateFlags.SystemKey;
		}
		if (writable)
		{
			_state |= StateFlags.WriteAccess;
		}
		if (isPerfData)
		{
			_state |= StateFlags.PerfData;
		}
	}

	public void Dispose()
	{
		if (_hkey == null)
		{
			return;
		}
		if (!IsSystemKey())
		{
			try
			{
				_hkey.Dispose();
				return;
			}
			catch (IOException)
			{
				return;
			}
			finally
			{
				_hkey = null;
			}
		}
		if (IsPerfDataKey())
		{
			ClosePerfDataKey();
		}
	}

	public static RegistryKey OpenBaseKey(RegistryHive hKey, RegistryView view)
	{
		ValidateKeyView(view);
		return OpenBaseKeyCore(hKey, view);
	}

	public RegistryKey OpenSubKey(string name, bool writable)
	{
		ValidateKeyName(name);
		EnsureNotDisposed();
		name = FixupName(name);
		return InternalOpenSubKeyCore(name, writable, throwOnPermissionFailure: true);
	}

	private int InternalSubKeyCount()
	{
		EnsureNotDisposed();
		return InternalSubKeyCountCore();
	}

	public string[] GetSubKeyNames()
	{
		return InternalGetSubKeyNames();
	}

	private string[] InternalGetSubKeyNames()
	{
		EnsureNotDisposed();
		int num = InternalSubKeyCount();
		if (num <= 0)
		{
			return Array.Empty<string>();
		}
		return InternalGetSubKeyNamesCore(num);
	}

	public object GetValue(string name, object defaultValue, RegistryValueOptions options)
	{
		if (options < RegistryValueOptions.None || options > RegistryValueOptions.DoNotExpandEnvironmentNames)
		{
			throw new ArgumentException(SR.Format("Illegal enum value: {0}.", (int)options), "options");
		}
		bool doNotExpand = options == RegistryValueOptions.DoNotExpandEnvironmentNames;
		return InternalGetValue(name, defaultValue, doNotExpand, checkSecurity: true);
	}

	private object InternalGetValue(string name, object defaultValue, bool doNotExpand, bool checkSecurity)
	{
		if (checkSecurity)
		{
			EnsureNotDisposed();
		}
		return InternalGetValueCore(name, defaultValue, doNotExpand);
	}

	public override string ToString()
	{
		EnsureNotDisposed();
		return _keyName;
	}

	private static string FixupName(string name)
	{
		if (name.IndexOf('\\') == -1)
		{
			return name;
		}
		StringBuilder stringBuilder = new StringBuilder(name);
		FixupPath(stringBuilder);
		int num = stringBuilder.Length - 1;
		if (num >= 0 && stringBuilder[num] == '\\')
		{
			stringBuilder.Length = num;
		}
		return stringBuilder.ToString();
	}

	private static void FixupPath(StringBuilder path)
	{
		int length = path.Length;
		bool flag = false;
		char c = '\uffff';
		int i;
		for (i = 1; i < length - 1; i++)
		{
			if (path[i] == '\\')
			{
				i++;
				while (i < length && path[i] == '\\')
				{
					path[i] = c;
					i++;
					flag = true;
				}
			}
		}
		if (!flag)
		{
			return;
		}
		i = 0;
		int num = 0;
		while (i < length)
		{
			if (path[i] == c)
			{
				i++;
				continue;
			}
			path[num] = path[i];
			i++;
			num++;
		}
		path.Length += num - i;
	}

	private void EnsureNotDisposed()
	{
		if (_hkey == null)
		{
			ThrowHelper.ThrowObjectDisposedException(_keyName, "Cannot access a closed registry key.");
		}
	}

	private RegistryKeyPermissionCheck GetSubKeyPermissionCheck(bool subkeyWritable)
	{
		if (_checkMode == RegistryKeyPermissionCheck.Default)
		{
			return _checkMode;
		}
		if (subkeyWritable)
		{
			return RegistryKeyPermissionCheck.ReadWriteSubTree;
		}
		return RegistryKeyPermissionCheck.ReadSubTree;
	}

	private static void ValidateKeyName(string name)
	{
		if (name == null)
		{
			ThrowHelper.ThrowArgumentNullException("name");
		}
		int num = name.IndexOf("\\", StringComparison.OrdinalIgnoreCase);
		int num2 = 0;
		while (num != -1)
		{
			if (num - num2 > 255)
			{
				ThrowHelper.ThrowArgumentException("Registry key names should not be greater than 255 characters.", "name");
			}
			num2 = num + 1;
			num = name.IndexOf("\\", num2, StringComparison.OrdinalIgnoreCase);
		}
		if (name.Length - num2 > 255)
		{
			ThrowHelper.ThrowArgumentException("Registry key names should not be greater than 255 characters.", "name");
		}
	}

	private static void ValidateKeyView(RegistryView view)
	{
		if (view != RegistryView.Default && view != RegistryView.Registry32 && view != RegistryView.Registry64)
		{
			ThrowHelper.ThrowArgumentException("The specified RegistryView value is invalid.", "view");
		}
	}

	private bool IsSystemKey()
	{
		return (_state & StateFlags.SystemKey) != 0;
	}

	private bool IsPerfDataKey()
	{
		return (_state & StateFlags.PerfData) != 0;
	}
}
