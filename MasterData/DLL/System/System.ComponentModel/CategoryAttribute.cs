namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.All)]
public class CategoryAttribute : Attribute
{
	private static volatile CategoryAttribute appearance;

	private static volatile CategoryAttribute asynchronous;

	private static volatile CategoryAttribute behavior;

	private static volatile CategoryAttribute data;

	private static volatile CategoryAttribute design;

	private static volatile CategoryAttribute action;

	private static volatile CategoryAttribute format;

	private static volatile CategoryAttribute layout;

	private static volatile CategoryAttribute mouse;

	private static volatile CategoryAttribute key;

	private static volatile CategoryAttribute focus;

	private static volatile CategoryAttribute windowStyle;

	private static volatile CategoryAttribute dragDrop;

	private static volatile CategoryAttribute defAttr;

	private bool localized;

	private string categoryValue;

	public static CategoryAttribute Action
	{
		get
		{
			if (action == null)
			{
				action = new CategoryAttribute("Action");
			}
			return action;
		}
	}

	public static CategoryAttribute Appearance
	{
		get
		{
			if (appearance == null)
			{
				appearance = new CategoryAttribute("Appearance");
			}
			return appearance;
		}
	}

	public static CategoryAttribute Asynchronous
	{
		get
		{
			if (asynchronous == null)
			{
				asynchronous = new CategoryAttribute("Asynchronous");
			}
			return asynchronous;
		}
	}

	public static CategoryAttribute Behavior
	{
		get
		{
			if (behavior == null)
			{
				behavior = new CategoryAttribute("Behavior");
			}
			return behavior;
		}
	}

	public static CategoryAttribute Data
	{
		get
		{
			if (data == null)
			{
				data = new CategoryAttribute("Data");
			}
			return data;
		}
	}

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

	public static CategoryAttribute Design
	{
		get
		{
			if (design == null)
			{
				design = new CategoryAttribute("Design");
			}
			return design;
		}
	}

	public static CategoryAttribute DragDrop
	{
		get
		{
			if (dragDrop == null)
			{
				dragDrop = new CategoryAttribute("DragDrop");
			}
			return dragDrop;
		}
	}

	public static CategoryAttribute Focus
	{
		get
		{
			if (focus == null)
			{
				focus = new CategoryAttribute("Focus");
			}
			return focus;
		}
	}

	public static CategoryAttribute Format
	{
		get
		{
			if (format == null)
			{
				format = new CategoryAttribute("Format");
			}
			return format;
		}
	}

	public static CategoryAttribute Key
	{
		get
		{
			if (key == null)
			{
				key = new CategoryAttribute("Key");
			}
			return key;
		}
	}

	public static CategoryAttribute Layout
	{
		get
		{
			if (layout == null)
			{
				layout = new CategoryAttribute("Layout");
			}
			return layout;
		}
	}

	public static CategoryAttribute Mouse
	{
		get
		{
			if (mouse == null)
			{
				mouse = new CategoryAttribute("Mouse");
			}
			return mouse;
		}
	}

	public static CategoryAttribute WindowStyle
	{
		get
		{
			if (windowStyle == null)
			{
				windowStyle = new CategoryAttribute("WindowStyle");
			}
			return windowStyle;
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
