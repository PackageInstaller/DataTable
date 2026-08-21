using System;
using UnityEngine;

[Serializable]
public class OpenCondition
{
	public int conditionType;

	public int taskId;

	[SerializeField]
	public int taskStateValueIndex;

	public string taskStateIndexValue = "00";

	public CheckType checkType;

	public int checkValue;

	public int copyOpenMin;

	public int copyOpenMax;
}
