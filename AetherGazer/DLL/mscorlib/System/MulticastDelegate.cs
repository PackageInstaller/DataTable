using System.Reflection;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
[ComVisible(true)]
public abstract class MulticastDelegate : Delegate
{
	private Delegate[] delegates;

	internal bool HasSingleTarget => delegates == null;

	protected MulticastDelegate(object target, string method)
		: base(target, method)
	{
	}

	protected MulticastDelegate(Type target, string method)
		: base(target, method)
	{
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
	}

	protected sealed override object DynamicInvokeImpl(object[] args)
	{
		if (delegates == null)
		{
			return base.DynamicInvokeImpl(args);
		}
		int num = 0;
		int num2 = delegates.Length;
		object result;
		do
		{
			result = delegates[num].DynamicInvoke(args);
		}
		while (++num < num2);
		return result;
	}

	public sealed override bool Equals(object obj)
	{
		if (!base.Equals(obj))
		{
			return false;
		}
		if (!(obj is MulticastDelegate multicastDelegate))
		{
			return false;
		}
		if (delegates == null && multicastDelegate.delegates == null)
		{
			return true;
		}
		if ((delegates == null) ^ (multicastDelegate.delegates == null))
		{
			return false;
		}
		if (delegates.Length != multicastDelegate.delegates.Length)
		{
			return false;
		}
		for (int i = 0; i < delegates.Length; i++)
		{
			if (!delegates[i].Equals(multicastDelegate.delegates[i]))
			{
				return false;
			}
		}
		return true;
	}

	public sealed override int GetHashCode()
	{
		return base.GetHashCode();
	}

	protected override MethodInfo GetMethodImpl()
	{
		if (delegates != null)
		{
			return delegates[delegates.Length - 1].Method;
		}
		return base.GetMethodImpl();
	}

	public sealed override Delegate[] GetInvocationList()
	{
		if (delegates != null)
		{
			return (Delegate[])delegates.Clone();
		}
		return new Delegate[1] { this };
	}

	protected sealed override Delegate CombineImpl(Delegate follow)
	{
		if ((object)follow == null)
		{
			return this;
		}
		MulticastDelegate multicastDelegate = (MulticastDelegate)follow;
		MulticastDelegate multicastDelegate2 = Delegate.AllocDelegateLike_internal(this);
		if (delegates == null && multicastDelegate.delegates == null)
		{
			multicastDelegate2.delegates = new Delegate[2] { this, multicastDelegate };
		}
		else if (delegates == null)
		{
			multicastDelegate2.delegates = new Delegate[1 + multicastDelegate.delegates.Length];
			multicastDelegate2.delegates[0] = this;
			Array.Copy(multicastDelegate.delegates, 0, multicastDelegate2.delegates, 1, multicastDelegate.delegates.Length);
		}
		else if (multicastDelegate.delegates == null)
		{
			multicastDelegate2.delegates = new Delegate[delegates.Length + 1];
			Array.Copy(delegates, 0, multicastDelegate2.delegates, 0, delegates.Length);
			multicastDelegate2.delegates[multicastDelegate2.delegates.Length - 1] = multicastDelegate;
		}
		else
		{
			multicastDelegate2.delegates = new Delegate[delegates.Length + multicastDelegate.delegates.Length];
			Array.Copy(delegates, 0, multicastDelegate2.delegates, 0, delegates.Length);
			Array.Copy(multicastDelegate.delegates, 0, multicastDelegate2.delegates, delegates.Length, multicastDelegate.delegates.Length);
		}
		return multicastDelegate2;
	}

	private int LastIndexOf(Delegate[] haystack, Delegate[] needle)
	{
		if (haystack.Length < needle.Length)
		{
			return -1;
		}
		if (haystack.Length == needle.Length)
		{
			for (int i = 0; i < haystack.Length; i++)
			{
				if (!haystack[i].Equals(needle[i]))
				{
					return -1;
				}
			}
			return 0;
		}
		int num = haystack.Length - needle.Length;
		while (num >= 0)
		{
			int j;
			for (j = 0; needle[j].Equals(haystack[num]); j++)
			{
				if (j == needle.Length - 1)
				{
					return num - j;
				}
				num++;
			}
			num -= j + 1;
		}
		return -1;
	}

	protected sealed override Delegate RemoveImpl(Delegate value)
	{
		if ((object)value == null)
		{
			return this;
		}
		MulticastDelegate multicastDelegate = (MulticastDelegate)value;
		if (delegates == null && multicastDelegate.delegates == null)
		{
			if (!Equals(multicastDelegate))
			{
				return this;
			}
			return null;
		}
		if (delegates == null)
		{
			Delegate[] array = multicastDelegate.delegates;
			foreach (Delegate obj in array)
			{
				if (Equals(obj))
				{
					return null;
				}
			}
			return this;
		}
		if (multicastDelegate.delegates == null)
		{
			int num = Array.LastIndexOf(delegates, multicastDelegate);
			if (num == -1)
			{
				return this;
			}
			if (delegates.Length <= 1)
			{
				throw new InvalidOperationException();
			}
			if (delegates.Length == 2)
			{
				return delegates[(num == 0) ? 1u : 0u];
			}
			MulticastDelegate multicastDelegate2 = Delegate.AllocDelegateLike_internal(this);
			multicastDelegate2.delegates = new Delegate[delegates.Length - 1];
			Array.Copy(delegates, multicastDelegate2.delegates, num);
			Array.Copy(delegates, num + 1, multicastDelegate2.delegates, num, delegates.Length - num - 1);
			return multicastDelegate2;
		}
		if (delegates.Equals(multicastDelegate.delegates))
		{
			return null;
		}
		int num2 = LastIndexOf(delegates, multicastDelegate.delegates);
		if (num2 == -1)
		{
			return this;
		}
		MulticastDelegate multicastDelegate3 = Delegate.AllocDelegateLike_internal(this);
		multicastDelegate3.delegates = new Delegate[delegates.Length - multicastDelegate.delegates.Length];
		Array.Copy(delegates, multicastDelegate3.delegates, num2);
		Array.Copy(delegates, num2 + multicastDelegate.delegates.Length, multicastDelegate3.delegates, num2, delegates.Length - num2 - multicastDelegate.delegates.Length);
		return multicastDelegate3;
	}

	public static bool operator ==(MulticastDelegate d1, MulticastDelegate d2)
	{
		return d1?.Equals(d2) ?? ((object)d2 == null);
	}

	public static bool operator !=(MulticastDelegate d1, MulticastDelegate d2)
	{
		if ((object)d1 == null)
		{
			return (object)d2 != null;
		}
		return !d1.Equals(d2);
	}
}
