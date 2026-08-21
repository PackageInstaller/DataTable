using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public class HideIfAttribute : DrawerAttribute
{
	public readonly string fieldName;

	public readonly int checkValue;

	public readonly int checkValue2;

	public override bool isDecorator => true;

	public override int priority => 1;

	public HideIfAttribute(string fieldName, bool checkValue)
	{
		this.fieldName = fieldName;
		this.checkValue = (checkValue ? 1 : 0);
		checkValue2 = 0;
	}

	public HideIfAttribute(string fieldName, int checkValue)
	{
		this.fieldName = fieldName;
		this.checkValue = checkValue;
		checkValue2 = 0;
	}

	public HideIfAttribute(string fieldName, bool checkValue, bool checkValue2)
	{
		this.fieldName = fieldName;
		this.checkValue = (checkValue ? 1 : 0);
		this.checkValue2 = (checkValue2 ? 1 : 0);
	}

	public HideIfAttribute(string fieldName, int checkValue, int checkValue2)
	{
		this.fieldName = fieldName;
		this.checkValue = checkValue;
		this.checkValue2 = checkValue2;
	}
}
