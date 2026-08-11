namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.All)]
public class CategoryAttribute : Attribute
{
	private static volatile CategoryAttribute defAttr;

	private bool localized;

	private string categoryValue;

	public static CategoryAttribute Default
	{
		get
		{
			if (defAttr == null)
			{
				defAttr = new CategoryAttribute();
			}
			return defAttr;
		}
	}

	public string Category
	{
		get
		{
			if (!localized)
			{
				localized = true;
				string localizedString = GetLocalizedString(categoryValue);
				if (localizedString != null)
				{
					categoryValue = localizedString;
				}
			}
			return categoryValue;
		}
	}

	public CategoryAttribute()
		: this("Default")
	{
	}

	public CategoryAttribute(string category)
	{
		categoryValue = category;
		localized = false;
	}

	public override bool Equals(object obj)
	{
		if (obj == this)
		{
			return true;
		}
		if (obj is CategoryAttribute)
		{
			return Category.Equals(((CategoryAttribute)obj).Category);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return Category.GetHashCode();
	}

	protected virtual string GetLocalizedString(string value)
	{
		return value switch
		{
			"Action" => "Action", 
			"Appearance" => "Appearance", 
			"Behavior" => "Behavior", 
			"Data" => "Data", 
			"DDE" => "DDE", 
			"Design" => "Design", 
			"Focus" => "Focus", 
			"Font" => "Font", 
			"Key" => "Key", 
			"List" => "List", 
			"Layout" => "Layout", 
			"Mouse" => "Mouse", 
			"Position" => "Position", 
			"Text" => "Text", 
			"Scale" => "Scale", 
			"Config" => "Configurations", 
			_ => value, 
		};
	}

	public override bool IsDefaultAttribute()
	{
		return Category.Equals(Default.Category);
	}
}
