using System;

namespace Unity.VisualScripting.FullSerializer.Internal;

public struct fsVersionedType
{
	public fsVersionedType[] Ancestors;

	public string VersionString;

	public Type ModelType;

	public object Migrate(object ancestorInstance)
	{
		return Activator.CreateInstance(ModelType, ancestorInstance);
	}

	public override string ToString()
	{
		return "fsVersionedType [ModelType=" + ModelType?.ToString() + ", VersionString=" + VersionString + ", Ancestors.Length=" + Ancestors.Length + "]";
	}

	public static bool operator ==(fsVersionedType a, fsVersionedType b)
	{
		return a.ModelType == b.ModelType;
	}

	public static bool operator !=(fsVersionedType a, fsVersionedType b)
	{
		return a.ModelType != b.ModelType;
	}

	public override bool Equals(object obj)
	{
		if (obj is fsVersionedType)
		{
			return ModelType == ((fsVersionedType)obj).ModelType;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return ModelType.GetHashCode();
	}
}
