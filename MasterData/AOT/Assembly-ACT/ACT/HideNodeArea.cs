using ACT.World.Modules;
using UnityEngine;

namespace ACT;

public class HideNodeArea : MonoBehaviour
{
	[SerializeField]
	private GameObject[] _hideNodes;

	private void OnTriggerEnter(Collider other)
	{
		if (SceneTriggerEntry.ITriggerCallback.IsMainEntity(other))
		{
			UpdateControlledNodesActive(active: false);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (SceneTriggerEntry.ITriggerCallback.IsMainEntity(other))
		{
			UpdateControlledNodesActive(active: true);
		}
	}

	private void UpdateControlledNodesActive(bool active)
	{
		GameObject[] hideNodes = _hideNodes;
		for (int i = 0; i < hideNodes.Length; i++)
		{
			hideNodes[i]?.SetActive(active);
		}
	}
}
