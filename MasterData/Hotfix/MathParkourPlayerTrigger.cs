using UnityEngine;

public class MathParkourPlayerTrigger : MonoBehaviour
{
	private MathParkourLevelController levelController;

	public void SetLevelController(MathParkourLevelController levelController)
	{
		this.levelController = levelController;
	}

	private void OnTriggerEnter(Collider other)
	{
		if (!(levelController == null) && (!(other != null) || !other.transform.IsChildOf(transform.root)))
		{
			levelController.TryStartCollisionCombat(other);
			levelController.TryCollectBuffItem(other);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (!(levelController == null))
		{
			levelController.TryEndCollisionCombat(other);
		}
	}
}
