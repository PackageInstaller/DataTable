using System.Collections;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Security.Permissions;

namespace System.Security;

[Serializable]
[MonoTODO("CAS support is experimental (and unsupported).")]
[ComVisible(true)]
public class PermissionSet : ISecurityEncodable, ICollection, IEnumerable, IDeserializationCallback
{
	private static object[] psUnrestricted = new object[1] { PermissionState.Unrestricted };

	private PermissionState state;

	private ArrayList list;

	private bool _declsec;

	private bool _readOnly;

	private bool[] _ignored;

	private static object[] action = new object[1] { (SecurityAction)0 };

	public virtual int Count => list.Count;

	public virtual bool IsSynchronized => list.IsSynchronized;

	public virtual object SyncRoot => this;

	internal PermissionSet()
	{
		list = new ArrayList();
	}

	public PermissionSet(PermissionState state)
		: this()
	{
		this.state = CodeAccessPermission.CheckPermissionState(state, allowUnrestricted: true);
	}

	public PermissionSet(PermissionSet permSet)
		: this()
	{
		if (permSet == null)
		{
			return;
		}
		state = permSet.state;
		foreach (IPermission item in permSet.list)
		{
			list.Add(item);
		}
	}

	internal PermissionSet(IPermission perm)
		: this()
	{
		if (perm != null)
		{
			list.Add(perm);
		}
	}

	public virtual PermissionSet Copy()
	{
		return new PermissionSet(this);
	}

	public virtual void CopyTo(Array array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (list.Count > 0)
		{
			if (array.Rank > 1)
			{
				throw new ArgumentException(Locale.GetText("Array has more than one dimension"));
			}
			if (index < 0 || index >= array.Length)
			{
				throw new IndexOutOfRangeException("index");
			}
			list.CopyTo(array, index);
		}
	}

	public void Demand()
	{
		if (IsEmpty())
		{
			return;
		}
		int count = list.Count;
		if (_ignored == null || _ignored.Length != count)
		{
			_ignored = new bool[count];
		}
		bool flag = IsUnrestricted();
		for (int i = 0; i < count; i++)
		{
			IPermission permission = (IPermission)list[i];
			if (permission.GetType().IsSubclassOf(typeof(CodeAccessPermission)))
			{
				_ignored[i] = false;
				flag = true;
			}
			else
			{
				_ignored[i] = true;
				permission.Demand();
			}
		}
		if (flag && SecurityManager.SecurityEnabled)
		{
			CasOnlyDemand(_declsec ? 5 : 3);
		}
	}

	internal void CasOnlyDemand(int skip)
	{
		if (_ignored == null)
		{
			_ignored = new bool[list.Count];
		}
	}

	public IEnumerator GetEnumerator()
	{
		return list.GetEnumerator();
	}

	public bool IsEmpty()
	{
		if (state == PermissionState.Unrestricted)
		{
			return false;
		}
		if (list == null || list.Count == 0)
		{
			return true;
		}
		foreach (IPermission item in list)
		{
			if (!item.IsSubsetOf(null))
			{
				return false;
			}
		}
		return true;
	}

	public bool IsUnrestricted()
	{
		return state == PermissionState.Unrestricted;
	}

	public override string ToString()
	{
		return ToXml().ToString();
	}

	public virtual SecurityElement ToXml()
	{
		SecurityElement securityElement = new SecurityElement("PermissionSet");
		securityElement.AddAttribute("class", GetType().FullName);
		securityElement.AddAttribute("version", 1.ToString());
		if (state == PermissionState.Unrestricted)
		{
			securityElement.AddAttribute("Unrestricted", "true");
		}
		foreach (IPermission item in list)
		{
			securityElement.AddChild(item.ToXml());
		}
		return securityElement;
	}

	[MonoTODO("may not be required")]
	void IDeserializationCallback.OnDeserialization(object sender)
	{
	}

	[ComVisible(false)]
	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (!(obj is PermissionSet permissionSet))
		{
			return false;
		}
		if (state != permissionSet.state)
		{
			return false;
		}
		if (list.Count != permissionSet.Count)
		{
			return false;
		}
		for (int i = 0; i < list.Count; i++)
		{
			bool flag = false;
			int num = 0;
			while (i < permissionSet.list.Count)
			{
				if (list[i].Equals(permissionSet.list[num]))
				{
					flag = true;
					break;
				}
				num++;
			}
			if (!flag)
			{
				return false;
			}
		}
		return true;
	}

	[ComVisible(false)]
	public override int GetHashCode()
	{
		if (list.Count != 0)
		{
			return base.GetHashCode();
		}
		return (int)state;
	}

	internal void SetReadOnly(bool value)
	{
		_readOnly = value;
	}
}
