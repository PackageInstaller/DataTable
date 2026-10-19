using UnityEngine;

namespace ACT.UI;

public class CvMenuItemGroup : MonoBehaviour
{
	[SerializeField]
	public ActToggleGroup toggleGroup;

	[SerializeField]
	public float interva;

	public void Enter(int index = 0)
	{
		if (!gameObject.activeSelf)
		{
			gameObject.SetActive(value: true);
		}
		toggleGroup.Init(index);
		if (interva > 0f)
		{
			toggleGroup.SetClickInterval(interva);
		}
	}

	public void UnFreeze()
	{
		gameObject.SetActive(value: true);
	}

	public void Freeze()
	{
		gameObject.SetActive(value: false);
	}
}
