using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public class ShowIfAttribute : DrawerAttribute
{
	public readonly string fieldName;

	public readonly int checkValue;

	public readonly string fieldName2;

	public readonly int checkValue2;

	public readonly int[] checkArr;

	public readonly bool IsCompositeCondition;

	public readonly string[] checkName;

	public readonly int[] checkValues;

	public override bool isDecorator => true;

	public override int priority => 1;

	public ShowIfAttribute(string fieldName, int checkValue)
	{
		this.fieldName = fieldName;
		this.checkValue = checkValue;
		fieldName2 = "";
		checkValue2 = 0;
	}

	public ShowIfAttribute(string fieldName, bool checkValue)
	{
		this.fieldName = fieldName;
		this.checkValue = (checkValue ? 1 : 0);
		fieldName2 = "";
		checkValue2 = 0;
	}

	public ShowIfAttribute(string fieldName, int checkValue, string fieldName2, int checkValue2)
	{
		this.fieldName = fieldName;
		this.checkValue = checkValue;
		this.fieldName2 = fieldName2;
		this.checkValue2 = checkValue2;
	}

	public ShowIfAttribute(string[] checkName, int[] checkValue)
	{
		if (checkName.Length == checkValue.Length)
		{
			IsCompositeCondition = true;
			this.checkName = checkName;
			checkValues = checkValue;
		}
	}

	public ShowIfAttribute(string fieldName, params int[] checkArr)
	{
		this.fieldName = fieldName;
		this.checkArr = checkArr;
	}
}
