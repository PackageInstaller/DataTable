using System.Text;

namespace System.Reflection;

internal sealed class SignatureConstructedGenericType : SignatureType
{
	private readonly Type _genericTypeDefinition;

	private readonly Type[] _genericTypeArguments;

	public sealed override bool IsTypeDefinition => false;

	public sealed override bool IsGenericTypeDefinition => false;

	public sealed override bool IsByRefLike => _genericTypeDefinition.IsByRefLike;

	public sealed override bool IsSZArray => false;

	public sealed override bool IsVariableBoundArray => false;

	public sealed override bool IsConstructedGenericType => true;

	public sealed override bool IsGenericParameter => false;

	public sealed override bool IsGenericTypeParameter => false;

	public sealed override bool IsGenericMethodParameter => false;

	public sealed override bool ContainsGenericParameters
	{
		get
		{
			for (int i = 0; i < _genericTypeArguments.Length; i++)
			{
				if (_genericTypeArguments[i].ContainsGenericParameters)
				{
					return true;
				}
			}
			return false;
		}
	}

	internal sealed override SignatureType ElementType => null;

	public sealed override Type[] GenericTypeArguments => (Type[])_genericTypeArguments.Clone();

	public sealed override int GenericParameterPosition
	{
		get
		{
			throw new InvalidOperationException("Method may only be called on a Type for which Type.IsGenericParameter is true.");
		}
	}

	public sealed override string Name => _genericTypeDefinition.Name;

	public sealed override string Namespace => _genericTypeDefinition.Namespace;

	internal SignatureConstructedGenericType(Type genericTypeDefinition, Type[] typeArguments)
	{
		if (genericTypeDefinition == null)
		{
			throw new ArgumentNullException("genericTypeDefinition");
		}
		if (typeArguments == null)
		{
			throw new ArgumentNullException("typeArguments");
		}
		typeArguments = (Type[])typeArguments.Clone();
		for (int i = 0; i < typeArguments.Length; i++)
		{
			if (typeArguments[i] == null)
			{
				throw new ArgumentNullException("typeArguments");
			}
		}
		_genericTypeDefinition = genericTypeDefinition;
		_genericTypeArguments = typeArguments;
	}

	protected sealed override bool HasElementTypeImpl()
	{
		return false;
	}

	protected sealed override bool IsArrayImpl()
	{
		return false;
	}

	protected sealed override bool IsByRefImpl()
	{
		return false;
	}

	protected sealed override bool IsPointerImpl()
	{
		return false;
	}

	public sealed override int GetArrayRank()
	{
		throw new ArgumentException("Must be an array type.");
	}

	public sealed override Type GetGenericTypeDefinition()
	{
		return _genericTypeDefinition;
	}

	public sealed override Type[] GetGenericArguments()
	{
		return GenericTypeArguments;
	}

	public sealed override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(_genericTypeDefinition.ToString());
		stringBuilder.Append('[');
		for (int i = 0; i < _genericTypeArguments.Length; i++)
		{
			if (i != 0)
			{
				stringBuilder.Append(',');
			}
			stringBuilder.Append(_genericTypeArguments[i].ToString());
		}
		stringBuilder.Append(']');
		return stringBuilder.ToString();
	}
}
