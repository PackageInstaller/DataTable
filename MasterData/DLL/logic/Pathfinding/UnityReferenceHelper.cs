using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

[ExecuteInEditMode]
[HelpURL("http://arongranberg.com/astar/docs/class_pathfinding_1_1_unity_reference_helper.php")]
public class UnityReferenceHelper : MonoBehaviour
{
	[SerializeField]
	[HideInInspector]
	private string guid;

	public string GetGUID()
	{
		return guid;
	}

	public void Awake()
	{
		Reset();
	}

	public void Reset()
	{
		if (string.IsNullOrEmpty(guid))
		{
			guid = Guid.NewGuid().ToString();
			Debug.Log((object)("Created new GUID - " + guid));
			return;
		}
		UnityReferenceHelper[] array = Object.FindObjectsOfType(typeof(UnityReferenceHelper)) as UnityReferenceHelper[];
		foreach (UnityReferenceHelper unityReferenceHelper in array)
		{
			if ((Object)(object)unityReferenceHelper != (Object)(object)this && guid == unityReferenceHelper.guid)
			{
				guid = Guid.NewGuid().ToString();
				Debug.Log((object)("Created new GUID - " + guid));
				break;
			}
		}
	}
}
