using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace Unity.VisualScripting;

public abstract class ReflectedCloner : Cloner<object>
{
	private readonly Dictionary<Type, MemberInfo[]> accessors = new Dictionary<Type, MemberInfo[]>();

	private readonly Dictionary<Type, IOptimizedAccessor[]> optimizedAccessors = new Dictionary<Type, IOptimizedAccessor[]>();

	public override bool Handles(Type type)
	{
		return false;
	}

	public override void FillClone(Type type, ref object clone, object original, CloningContext context)
	{
		if (PlatformUtility.supportsJit)
		{
			IOptimizedAccessor[] array = GetOptimizedAccessors(type);
			foreach (IOptimizedAccessor optimizedAccessor in array)
			{
				if (context.tryPreserveInstances)
				{
					object clone2 = optimizedAccessor.GetValue(clone);
					Cloning.CloneInto(context, ref clone2, optimizedAccessor.GetValue(original));
					optimizedAccessor.SetValue(clone, clone2);
				}
				else
				{
					optimizedAccessor.SetValue(clone, Cloning.Clone(context, optimizedAccessor.GetValue(original)));
				}
			}
			return;
		}
		MemberInfo[] array2 = GetAccessors(type);
		foreach (MemberInfo memberInfo in array2)
		{
			if (memberInfo is FieldInfo)
			{
				FieldInfo fieldInfo = (FieldInfo)memberInfo;
				if (context.tryPreserveInstances)
				{
					object clone3 = fieldInfo.GetValue(clone);
					Cloning.CloneInto(context, ref clone3, fieldInfo.GetValue(original));
					fieldInfo.SetValue(clone, clone3);
				}
				else
				{
					fieldInfo.SetValue(clone, Cloning.Clone(context, fieldInfo.GetValue(original)));
				}
			}
			else if (memberInfo is PropertyInfo)
			{
				PropertyInfo propertyInfo = (PropertyInfo)memberInfo;
				if (context.tryPreserveInstances)
				{
					object clone4 = propertyInfo.GetValue(clone, null);
					Cloning.CloneInto(context, ref clone4, propertyInfo.GetValue(original, null));
					propertyInfo.SetValue(clone, clone4, null);
				}
				else
				{
					propertyInfo.SetValue(clone, Cloning.Clone(context, propertyInfo.GetValue(original, null)), null);
				}
			}
		}
	}

	private MemberInfo[] GetAccessors(Type type)
	{
		if (!accessors.ContainsKey(type))
		{
			accessors.Add(type, GetMembers(type).ToArray());
		}
		return accessors[type];
	}

	private IOptimizedAccessor[] GetOptimizedAccessors(Type type)
	{
		if (!optimizedAccessors.ContainsKey(type))
		{
			List<IOptimizedAccessor> list = new List<IOptimizedAccessor>();
			foreach (MemberInfo member in GetMembers(type))
			{
				if (member is FieldInfo)
				{
					list.Add(((FieldInfo)member).Prewarm());
				}
				else if (member is PropertyInfo)
				{
					list.Add(((PropertyInfo)member).Prewarm());
				}
			}
			optimizedAccessors.Add(type, list.ToArray());
		}
		return optimizedAccessors[type];
	}

	protected virtual IEnumerable<MemberInfo> GetMembers(Type type)
	{
		BindingFlags bindingAttr = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic;
		return LinqUtility.Concat<MemberInfo>(new IEnumerable[2]
		{
			type.GetFields(bindingAttr).Where(IncludeField),
			type.GetProperties(bindingAttr).Where(IncludeProperty)
		});
	}

	protected virtual bool IncludeField(FieldInfo field)
	{
		return false;
	}

	protected virtual bool IncludeProperty(PropertyInfo property)
	{
		return false;
	}
}
