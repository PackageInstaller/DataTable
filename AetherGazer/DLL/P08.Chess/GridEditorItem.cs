using UnityEngine;

[DisallowMultipleComponent]
public class GridEditorItem : MonoBehaviour
{
	public int typeID;

	public int status;

	[HideInInspector]
	public short x;

	[HideInInspector]
	public short z;

	[HideInInspector]
	public string prefab;

	public int[] paramList;
}
