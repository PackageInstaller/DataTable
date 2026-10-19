using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Security.Claims;

namespace System.Security.Principal;

[Serializable]
[ComVisible(true)]
public class WindowsIdentity : ClaimsIdentity, IIdentity, IDeserializationCallback, ISerializable, IDisposable
{
	private IntPtr _token;

	private string _type;

	private WindowsAccountType _account;

	private bool _authenticated;

	private string _name;

	private SerializationInfo _info;

	private static IntPtr invalidWindows = IntPtr.Zero;

	public sealed override string AuthenticationType => _type;

	public override bool IsAuthenticated => _authenticated;

	public override string Name
	{
		get
		{
			if (_name == null)
			{
				_name = GetTokenName(_token);
			}
			return _name;
		}
	}

	public WindowsIdentity(IntPtr userToken, string type, WindowsAccountType acctType, bool isAuthenticated)
	{
		_type = type;
		_account = acctType;
		_authenticated = isAuthenticated;
		_name = null;
		SetToken(userToken);
	}

	public WindowsIdentity(SerializationInfo info, StreamingContext context)
	{
		_info = info;
	}

	internal WindowsIdentity(ClaimsIdentity claimsIdentity, IntPtr userToken)
		: base(claimsIdentity)
	{
		if (userToken != IntPtr.Zero && userToken.ToInt64() > 0)
		{
			SetToken(userToken);
		}
	}

	[ComVisible(false)]
	public void Dispose()
	{
		_token = IntPtr.Zero;
	}

	public static WindowsIdentity GetCurrent()
	{
		return new WindowsIdentity(GetCurrentToken(), null, WindowsAccountType.Normal, isAuthenticated: true);
	}

	public virtual WindowsImpersonationContext Impersonate()
	{
		return new WindowsImpersonationContext(_token);
	}

	void IDeserializationCallback.OnDeserialization(object sender)
	{
		_token = (IntPtr)_info.GetValue("m_userToken", typeof(IntPtr));
		_name = _info.GetString("m_name");
		if (_name != null)
		{
			if (GetTokenName(_token) != _name)
			{
				throw new SerializationException("Token-Name mismatch.");
			}
		}
		else
		{
			_name = GetTokenName(_token);
			if (_name == null)
			{
				throw new SerializationException("Token doesn't match a user.");
			}
		}
		_type = _info.GetString("m_type");
		_account = (WindowsAccountType)_info.GetValue("m_acctType", typeof(WindowsAccountType));
		_authenticated = _info.GetBoolean("m_isAuthenticated");
	}

	void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
	{
		info.AddValue("m_userToken", _token);
		info.AddValue("m_name", _name);
		info.AddValue("m_type", _type);
		info.AddValue("m_acctType", _account);
		info.AddValue("m_isAuthenticated", _authenticated);
	}

	internal ClaimsIdentity CloneAsBase()
	{
		return base.Clone();
	}

	internal IntPtr GetTokenInternal()
	{
		return _token;
	}

	private void SetToken(IntPtr token)
	{
		if (Environment.IsUnix)
		{
			_token = token;
			if (_type == null)
			{
				_type = "POSIX";
			}
			if (_token == IntPtr.Zero)
			{
				_account = WindowsAccountType.System;
			}
		}
		else
		{
			if (token == invalidWindows && _account != WindowsAccountType.Anonymous)
			{
				throw new ArgumentException("Invalid token");
			}
			_token = token;
			if (_type == null)
			{
				_type = "NTLM";
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern IntPtr GetCurrentToken();

	[MethodImpl((MethodImplOptions)4096)]
	private static extern string GetTokenName(IntPtr token);
}
