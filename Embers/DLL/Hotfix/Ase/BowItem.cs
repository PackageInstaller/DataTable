using UnityEngine;

namespace Ase;

public class BowItem : MonoBehaviour
{
	public GameObject active;

	public void SetLayerActive(bool active)
	{
		this.active.SetActive(active);
	}
}
