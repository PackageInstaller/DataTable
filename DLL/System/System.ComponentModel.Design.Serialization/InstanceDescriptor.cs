using System.Collections;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace System.ComponentModel.Design.Serialization;

public sealed class InstanceDescriptor
{
	[CompilerGenerated]
	private readonly bool _003CIsComplete_003Ek__BackingField;

	public ICollection Arguments { get; }

	public MemberInfo MemberInfo { get; }

	public InstanceDescriptor(MemberInfo member, ICollection arguments)
		: this(member, arguments, isComplete: true)
	{
	}

	public InstanceDescriptor(MemberInfo member, ICollection arguments, bool isComplete)
	{
		MemberInfo = member;
		_003CIsComplete_003Ek__BackingField = isComplete;
		if (arguments == null)
		{
			Arguments = Array.Empty<object>();
		}
		else
		{
			object[] array = new object[arguments.Count];
			arguments.CopyTo(array, 0);
			Arguments = array;
		}
		if (member is FieldInfo)
		{
			if (!((FieldInfo)member).IsStatic)
			{
				throw new ArgumentException("Parameter must be static.");
			}
			if (Arguments.Count != 0)
			{
				throw new ArgumentException("Length mismatch.");
			}
		}
		else if (member is ConstructorInfo)
		{
			ConstructorInfo constructorInfo = (ConstructorInfo)member;
			if (constructorInfo.IsStatic)
			{
				throw new ArgumentException("Parameter cannot be static.");
			}
			if (Arguments.Count != constructorInfo.GetParameters().Length)
			{
				throw new ArgumentException("Length mismatch.");
			}
		}
		else if (member is MethodInfo)
		{
			MethodInfo methodInfo = (MethodInfo)member;
			if (!methodInfo.IsStatic)
			{
				throw new ArgumentException("Parameter must be static.");
			}
			if (Arguments.Count != methodInfo.GetParameters().Length)
			{
				throw new ArgumentException("Length mismatch.");
			}
		}
		else if (member is PropertyInfo)
		{
			PropertyInfo obj = (PropertyInfo)member;
			if (!obj.CanRead)
			{
				throw new ArgumentException("Parameter must be readable.");
			}
			MethodInfo getMethod = obj.GetGetMethod();
			if (getMethod != null && !getMethod.IsStatic)
			{
				throw new ArgumentException("Parameter must be static.");
			}
		}
	}

	public object Invoke()
	{
		object[] array = new object[Arguments.Count];
		Arguments.CopyTo(array, 0);
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i] is InstanceDescriptor)
			{
				array[i] = ((InstanceDescriptor)array[i]).Invoke();
			}
		}
		if (MemberInfo is ConstructorInfo)
		{
			return ((ConstructorInfo)MemberInfo).Invoke(array);
		}
		if (MemberInfo is MethodInfo)
		{
			return ((MethodInfo)MemberInfo).Invoke(null, array);
		}
		if (MemberInfo is PropertyInfo)
		{
			return ((PropertyInfo)MemberInfo).GetValue(null, array);
		}
		if (MemberInfo is FieldInfo)
		{
			return ((FieldInfo)MemberInfo).GetValue(null);
		}
		return null;
	}
}
