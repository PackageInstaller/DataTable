namespace System;

internal class TypeNames
{
	internal abstract class ATypeName : TypeName, IEquatable<TypeName>
	{
		public abstract string DisplayName { get; }

		public bool Equals(TypeName other)
		{
			if (other != null)
			{
				return DisplayName == other.DisplayName;
			}
			return false;
		}

		public override int GetHashCode()
		{
			return DisplayName.GetHashCode();
		}

		public override bool Equals(object other)
		{
			return Equals(other as TypeName);
		}
	}
}
