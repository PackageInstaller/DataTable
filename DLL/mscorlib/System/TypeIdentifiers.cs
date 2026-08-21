namespace System;

internal class TypeIdentifiers
{
	private class Display : TypeNames.ATypeName, TypeIdentifier, TypeName, IEquatable<TypeName>
	{
		private string displayName;

		private string internal_name;

		public override string DisplayName => displayName;

		public string InternalName
		{
			get
			{
				if (internal_name == null)
				{
					internal_name = GetInternalName();
				}
				return internal_name;
			}
		}

		internal Display(string displayName)
		{
			this.displayName = displayName;
			internal_name = null;
		}

		private string GetInternalName()
		{
			return TypeSpec.UnescapeInternalName(displayName);
		}
	}

	internal static TypeIdentifier FromDisplay(string displayName)
	{
		return new Display(displayName);
	}
}
