using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.Reflection;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
public abstract class Module : ICustomAttributeProvider, ISerializable, _Module
{
	public static readonly TypeFilter FilterTypeName = FilterTypeNameImpl;

	public static readonly TypeFilter FilterTypeNameIgnoreCase = FilterTypeNameIgnoreCaseImpl;

	private const BindingFlags DefaultLookup = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public;

	public virtual Assembly Assembly
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public virtual Guid ModuleVersionId
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public virtual string ScopeName
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public ModuleHandle ModuleHandle => GetModuleHandleImpl();

	internal virtual ModuleHandle GetModuleHandleImpl()
	{
		return ModuleHandle.EmptyHandle;
	}

	public virtual bool IsResource()
	{
		throw NotImplemented.ByDesign;
	}

	public virtual bool IsDefined(Type attributeType, bool inherit)
	{
		throw NotImplemented.ByDesign;
	}

	public virtual object[] GetCustomAttributes(bool inherit)
	{
		throw NotImplemented.ByDesign;
	}

	public virtual object[] GetCustomAttributes(Type attributeType, bool inherit)
	{
		throw NotImplemented.ByDesign;
	}

	public virtual void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		throw NotImplemented.ByDesign;
	}

	public override bool Equals(object o)
	{
		return base.Equals(o);
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public static bool operator ==(Module left, Module right)
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

	public override string ToString()
	{
		return ScopeName;
	}

	private static bool FilterTypeNameImpl(Type cls, object filterCriteria)
	{
		if (filterCriteria == null || !(filterCriteria is string))
		{
			throw new InvalidFilterCriteriaException("A String must be provided for the filter criteria.");
		}
		string text = (string)filterCriteria;
		if (text.Length > 0 && text[text.Length - 1] == '*')
		{
			text = text.Substring(0, text.Length - 1);
			return cls.Name.StartsWith(text, StringComparison.Ordinal);
		}
		return cls.Name.Equals(text);
	}

	private static bool FilterTypeNameIgnoreCaseImpl(Type cls, object filterCriteria)
	{
		if (filterCriteria == null || !(filterCriteria is string))
		{
			throw new InvalidFilterCriteriaException("A String must be provided for the filter criteria.");
		}
		string text = (string)filterCriteria;
		if (text.Length > 0 && text[text.Length - 1] == '*')
		{
			text = text.Substring(0, text.Length - 1);
			string name = cls.Name;
			if (name.Length >= text.Length)
			{
				return string.Compare(name, 0, text, 0, text.Length, StringComparison.OrdinalIgnoreCase) == 0;
			}
			return false;
		}
		return string.Compare(text, cls.Name, StringComparison.OrdinalIgnoreCase) == 0;
	}

	internal virtual Guid GetModuleVersionId()
	{
		throw new NotImplementedException();
	}
}
