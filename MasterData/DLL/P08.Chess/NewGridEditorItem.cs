using UnityEngine;

[DisallowMultipleComponent]
public class NewGridEditorItem : MonoBehaviour
{
	public int typeID;

	public int status;

	[HideInInspector]
	public short x;

	[HideInInspector]
	public short z;

	[HideInInspector]
	public string prefab;

	public int[] enterParamList;

	public int[] clickParamList;

	public int[] exitParamList;

	[HideInInspector]
	public string ObjectPrefab;

	public GameObject ObjectGameObject;

	public int ObjectTypeID;

	public int[] ObjectEnterParamList;

	public int[] ObjectClickParamList;

	public int[] ObjectExitParamList;

	public int[] ObjectFarClickParamList;
}
