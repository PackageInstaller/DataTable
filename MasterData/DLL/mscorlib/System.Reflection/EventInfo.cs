using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Mono;
using Unity;

namespace System.Reflection;

[Serializable]
public abstract class EventInfo : MemberInfo, _EventInfo
{
	private delegate void AddEventAdapter(object _this, Delegate dele);

	private AddEventAdapter cached_add_event;

	public override MemberTypes MemberType => MemberTypes.Event;

	public abstract EventAttributes Attributes { get; }

	public bool IsSpecialName => (Attributes & EventAttributes.SpecialName) != 0;

	public virtual MethodInfo AddMethod => GetAddMethod(nonPublic: true);

	public virtual MethodInfo RemoveMethod => GetRemoveMethod(nonPublic: true);

	public virtual MethodInfo RaiseMethod => GetRaiseMethod(nonPublic: true);

	public virtual bool IsMulticast
	{
		get
		{
			Type eventHandlerType = EventHandlerType;
			return typeof(MulticastDelegate).IsAssignableFrom(eventHandlerType);
		}
	}

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

	public MethodInfo[] GetOtherMethods()
	{
		return GetOtherMethods(nonPublic: false);
	}

	public virtual MethodInfo[] GetOtherMethods(bool nonPublic)
	{
		throw NotImplemented.ByDesign;
	}

	public MethodInfo GetAddMethod()
	{
		return GetAddMethod(nonPublic: false);
	}

	public MethodInfo GetRemoveMethod()
	{
		return GetRemoveMethod(nonPublic: false);
	}

	public MethodInfo GetRaiseMethod()
	{
		return GetRaiseMethod(nonPublic: false);
	}

	public abstract MethodInfo GetAddMethod(bool nonPublic);

	public abstract MethodInfo GetRemoveMethod(bool nonPublic);

	public abstract MethodInfo GetRaiseMethod(bool nonPublic);

	[DebuggerStepThrough]
	[DebuggerHidden]
	public virtual void RemoveEventHandler(object target, Delegate handler)
	{
		MethodInfo removeMethod = GetRemoveMethod(nonPublic: false);
		if (removeMethod == null)
		{
			throw new InvalidOperationException("Cannot remove the event handler since no public remove method exists for the event.");
		}
		removeMethod.Invoke(target, new object[1] { handler });
	}

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

	[DebuggerStepThrough]
	[DebuggerHidden]
	public virtual void AddEventHandler(object target, Delegate handler)
	{
		MethodInfo addMethod = GetAddMethod();
		if (addMethod == null)
		{
			throw new InvalidOperationException("Cannot add the event handler since no public add method exists for the event.");
		}
		if (target == null && !addMethod.IsStatic)
		{
			throw new TargetException("Cannot add a handler to a non static event with a null target");
		}
		addMethod.Invoke(target, new object[1] { handler });
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

	void _EventInfo.GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	Type _EventInfo.GetType()
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}

	void _EventInfo.GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _EventInfo.GetTypeInfoCount(out uint pcTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _EventInfo.Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr)
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
