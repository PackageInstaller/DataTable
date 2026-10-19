using System.Runtime.CompilerServices;
using Mono;

namespace System.Reflection;

[Serializable]
public abstract class EventInfo : MemberInfo
{
	private delegate void AddEventAdapter(object _this, Delegate dele);

	private AddEventAdapter cached_add_event;

	public override MemberTypes MemberType => MemberTypes.Event;

	public virtual Type EventHandlerType
	{
		get
		{
			ParameterInfo[] parametersInternal = GetAddMethod(nonPublic: true).GetParametersInternal();
			Type typeFromHandle = typeof(Delegate);
			for (int i = 0; i < parametersInternal.Length; i++)
			{
				Type parameterType = parametersInternal[i].ParameterType;
				if (parameterType.IsSubclassOf(typeFromHandle))
				{
					return parameterType;
				}
			}
			return null;
		}
	}

	public MethodInfo GetAddMethod()
	{
		return GetAddMethod(nonPublic: false);
	}

	public MethodInfo GetRemoveMethod()
	{
		return GetRemoveMethod(nonPublic: false);
	}

	public abstract MethodInfo GetAddMethod(bool nonPublic);

	public abstract MethodInfo GetRemoveMethod(bool nonPublic);

	public abstract MethodInfo GetRaiseMethod(bool nonPublic);

	public override bool Equals(object obj)
	{
		return base.Equals(obj);
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public static bool operator ==(EventInfo left, EventInfo right)
	{
		if ((object)left == right)
		{
			return true;
		}
		if ((object)left == null || (object)right == null)
		{
			return false;
		}
		return left.Equals(right);
	}

	public static bool operator !=(EventInfo left, EventInfo right)
	{
		return !(left == right);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern EventInfo internal_from_handle_type(IntPtr event_handle, IntPtr type_handle);

	internal static EventInfo GetEventFromHandle(RuntimeEventHandle handle, RuntimeTypeHandle reflectedType)
	{
		if (handle.Value == IntPtr.Zero)
		{
			throw new ArgumentException("The handle is invalid.");
		}
		EventInfo eventInfo = internal_from_handle_type(handle.Value, reflectedType.Value);
		if (eventInfo == null)
		{
			throw new ArgumentException("The event handle and the type handle are incompatible.");
		}
		return eventInfo;
	}
}
