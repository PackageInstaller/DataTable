using UnityEngine;

[DisallowMultipleComponent]
public class ChessBoardGridDataEditorItem : MonoBehaviour
{
	public int typeID;

	public int status;

	[HideInInspector]
	public short x;

	[HideInInspector]
	public short z;

	[HideInInspector]
	public string prefab;

	public bool[] banDir = new bool[6];

	public bool[] banDirIsHide = new bool[6];

	public GameObject[] banDirMarkGameObjectList = new GameObject[6];

	public int enterParam;

	public int exitParam;

	public int startMoveParam;

	public int endMoveParam;

	[HideInInspector]
	public string thingPrefab;

	public GameObject thingGameObject;

	public int thingTypeID;

	public int thingEnterParam;

	public int thingExitParam;

	public int thingStartMoveParam;

	public int thingEndMoveParam;
}
