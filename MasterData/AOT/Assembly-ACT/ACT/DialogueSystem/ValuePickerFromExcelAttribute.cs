using UnityEngine;

namespace ACT.DialogueSystem;

public class ValuePickerFromExcelAttribute : PropertyAttribute
{
	public enum ValueType
	{
		Int,
		Long,
		Float,
		Double,
		String
	}

	public string excelName;

	public string sheetName;

	public string idCol;

	public string valueCol;

	public ValueType valueType;

	public string nameCol;

	public ValuePickerFromExcelAttribute(string excelName, string sheetName, string idCol, string valueCol, ValueType valueType)
	{
		this.excelName = excelName;
		this.sheetName = sheetName;
		this.idCol = idCol;
		this.valueCol = valueCol;
		this.valueType = valueType;
	}
}
