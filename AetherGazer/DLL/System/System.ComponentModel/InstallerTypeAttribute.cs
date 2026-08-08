namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.Class)]
public class InstallerTypeAttribute : Attribute
{
	private string _typeName;

	public InstallerTypeAttribute(string typeName)
	{
		_typeName = typeName;
	}

	public override bool Equals(object obj)
	{
		if (obj == this)
		{
			return true;
		}
		if (obj is InstallerTypeAttribute installerTypeAttribute)
		{
			return installerTypeAttribute._typeName == _typeName;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}
}
