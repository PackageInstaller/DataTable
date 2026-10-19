namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMString_Children
{
	public static HUMString.Data.SpaceBetweenLowercaseAnd And(this HUMString.Data.SpaceBetweenLowercase lowercase)
	{
		return new HUMString.Data.SpaceBetweenLowercaseAnd(lowercase);
	}

	public static HUMString.Data.SpaceBetween Between(this HUMString.Data.Space space)
	{
		return new HUMString.Data.SpaceBetween(space);
	}

	public static HUMString.Data.SpaceBefore Before(this HUMString.Data.Space space)
	{
		return new HUMString.Data.SpaceBefore(space);
	}

	public static string Letter(this HUMString.Data.CapitalizeFirst capitalizeFirst)
	{
		return capitalizeFirst.capitalize.text[0].ToString().ToUpper() + capitalizeFirst.capitalize.text.Remove(0, 1);
	}

	public static HUMString.Data.Space Space(this HUMString.Data.Add add)
	{
		return new HUMString.Data.Space(add);
	}

	public static string Text(this HUMString.Data.SpaceBefore before, int amount = 1)
	{
		string text = string.Empty;
		for (int i = 0; i < amount; i++)
		{
			text += " ";
		}
		return text + before.space.add.text;
	}

	public static HUMString.Data.SpaceBetweenLowercase Lowercase(this HUMString.Data.SpaceBetween between)
	{
		return new HUMString.Data.SpaceBetweenLowercase(between);
	}

	public static HUMString.Data.CapitalizeFirst First(this HUMString.Data.Capitalize capitalize)
	{
		return new HUMString.Data.CapitalizeFirst(capitalize);
	}

	public static string Uppercase(this HUMString.Data.SpaceBetweenLowercaseAnd and)
	{
		string text = string.Empty;
		string text2 = string.Empty;
		string text3 = and.lowercase.between.space.add.text;
		for (int i = 0; i < text3.Length; i++)
		{
			bool flag = false;
			if (!string.IsNullOrEmpty(text) && text3[i].ToString() == text3[i].ToString().ToUpper() && text == text.ToString().ToLower())
			{
				flag = true;
			}
			if (flag)
			{
				text2 += " ";
			}
			text2 += text3[i];
			text = text3[i].ToString();
		}
		return text2;
	}

	public static string Uppercase(this HUMString.Data.SpaceBetweenLowercaseAnd and, int fromIndex, int toIndex)
	{
		string text = string.Empty;
		string text2 = string.Empty;
		string text3 = and.lowercase.between.space.add.text;
		for (int i = fromIndex; i < toIndex; i++)
		{
			bool flag = false;
			if (!string.IsNullOrEmpty(text) && text3[i].ToString() == text3[i].ToString().ToUpper() && text == text.ToString().ToLower())
			{
				flag = true;
			}
			if (flag)
			{
				text2 += " ";
			}
			text2 += text3[i];
			text = text3[i].ToString();
		}
		return text2;
	}

	public static string Last(this HUMString.Data.Remove remove)
	{
		return remove.text.Remove(remove.text.LastIndexOf(remove.remove), remove.text.Length - 1);
	}
}
