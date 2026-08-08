using UnityEngine;

public class ControllerCompareData
{
	public GameObject go;

	public ControllerProperty property;

	public ControllerCompareData(GameObject go, ControllerProperty property)
	{
		this.go = go;
		this.property = property;
	}
}
