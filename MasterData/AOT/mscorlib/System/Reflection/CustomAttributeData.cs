using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;

namespace System.Reflection;

[Serializable]
[ComVisible(true)]
public class CustomAttributeData
{
	private class LazyCAttrData
	{
		internal Assembly assembly;

		internal IntPtr data;

		internal uint data_length;
	}

	private ConstructorInfo ctorInfo;

	private IList<CustomAttributeTypedArgument> ctorArgs;

	private IList<CustomAttributeNamedArgument> namedArgs;

	private LazyCAttrData lazyData;

	[ComVisible(true)]
	public virtual ConstructorInfo Constructor => ctorInfo;

	[ComVisible(true)]
	public virtual IList<CustomAttributeTypedArgument> ConstructorArguments
	{
		get
		{
			ResolveArguments();
			return ctorArgs;
		}
	}

	public virtual IList<CustomAttributeNamedArgument> NamedArguments
	{
		get
		{
			ResolveArguments();
			return namedArgs;
		}
	}

	public Type AttributeType => ctorInfo.DeclaringType;

	protected CustomAttributeData()
	{
	}

	internal CustomAttributeData(ConstructorInfo ctorInfo, Assembly assembly, IntPtr data, uint data_length)
	{
		this.ctorInfo = ctorInfo;
		lazyData = new LazyCAttrData();
		lazyData.assembly = assembly;
		lazyData.data = data;
		lazyData.data_length = data_length;
	}

	internal CustomAttributeData(ConstructorInfo ctorInfo)
		: this(ctorInfo, Array.Empty<CustomAttributeTypedArgument>(), Array.Empty<CustomAttributeNamedArgument>())
	{
	}

	internal CustomAttributeData(ConstructorInfo ctorInfo, IList<CustomAttributeTypedArgument> ctorArgs, IList<CustomAttributeNamedArgument> namedArgs)
	{
		this.ctorInfo = ctorInfo;
		this.ctorArgs = ctorArgs;
		this.namedArgs = namedArgs;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void ResolveArgumentsInternal(ConstructorInfo ctor, Assembly assembly, IntPtr data, uint data_length, out object[] ctorArgs, out object[] namedArgs);

	private void ResolveArguments()
	{
		if (lazyData != null)
		{
			ResolveArgumentsInternal(ctorInfo, lazyData.assembly, lazyData.data, lazyData.data_length, out var array, out var array2);
			ctorArgs = Array.AsReadOnly((array != null) ? UnboxValues<CustomAttributeTypedArgument>(array) : Array.Empty<CustomAttributeTypedArgument>());
			namedArgs = Array.AsReadOnly((array2 != null) ? UnboxValues<CustomAttributeNamedArgument>(array2) : Array.Empty<CustomAttributeNamedArgument>());
			lazyData = null;
		}
	}

	public static IList<CustomAttributeData> GetCustomAttributes(Assembly target)
	{
		return MonoCustomAttrs.GetCustomAttributesData(target);
	}

	public static IList<CustomAttributeData> GetCustomAttributes(MemberInfo target)
	{
		return MonoCustomAttrs.GetCustomAttributesData(target);
	}

	internal static IList<CustomAttributeData> GetCustomAttributesInternal(RuntimeType target)
	{
		return MonoCustomAttrs.GetCustomAttributesData(target);
	}

	public static IList<CustomAttributeData> GetCustomAttributes(Module target)
	{
		return MonoCustomAttrs.GetCustomAttributesData(target);
	}

	public static IList<CustomAttributeData> GetCustomAttributes(ParameterInfo target)
	{
		return MonoCustomAttrs.GetCustomAttributesData(target);
	}

	public override string ToString()
	{
		ResolveArguments();
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("[" + ctorInfo.DeclaringType.FullName + "(");
		for (int i = 0; i < ctorArgs.Count; i++)
		{
			stringBuilder.Append(ctorArgs[i].ToString());
			if (i + 1 < ctorArgs.Count)
			{
				stringBuilder.Append(", ");
			}
		}
		if (namedArgs.Count > 0)
		{
			stringBuilder.Append(", ");
		}
		for (int j = 0; j < namedArgs.Count; j++)
		{
			stringBuilder.Append(namedArgs[j].ToString());
			if (j + 1 < namedArgs.Count)
			{
				stringBuilder.Append(", ");
			}
		}
		stringBuilder.AppendFormat(")]");
		return stringBuilder.ToString();
	}

	private static T[] UnboxValues<T>(object[] values)
	{
		T[] array = new T[values.Length];
		for (int i = 0; i < values.Length; i++)
		{
			array[i] = (T)values[i];
		}
		return array;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is CustomAttributeData customAttributeData) || customAttributeData.ctorInfo != ctorInfo || customAttributeData.ctorArgs.Count != ctorArgs.Count || customAttributeData.namedArgs.Count != namedArgs.Count)
		{
			return false;
		}
		for (int i = 0; i < ctorArgs.Count; i++)
		{
			if (ctorArgs[i].Equals(customAttributeData.ctorArgs[i]))
			{
				return false;
			}
		}
		for (int j = 0; j < namedArgs.Count; j++)
		{
			bool flag = false;
			for (int k = 0; k < customAttributeData.namedArgs.Count; k++)
			{
				if (namedArgs[j].Equals(customAttributeData.namedArgs[k]))
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				return false;
			}
		}
		return true;
	}

	public override int GetHashCode()
	{
		int num = ((ctorInfo == null) ? 13 : (ctorInfo.GetHashCode() << 16));
		if (ctorArgs != null)
		{
			for (int i = 0; i < ctorArgs.Count; i++)
			{
				num += num ^ (7 + ctorArgs[i].GetHashCode() << i * 4);
			}
		}
		if (namedArgs != null)
		{
			for (int j = 0; j < namedArgs.Count; j++)
			{
				num += namedArgs[j].GetHashCode() << 5;
			}
		}
		return num;
	}
}
