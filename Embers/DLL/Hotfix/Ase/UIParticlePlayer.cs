using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class UIParticlePlayer : MonoBehaviour
{
	[SerializeField]
	private GameObject particleObj;

	[SerializeField]
	private List<GameObject> particleObjList;

	public void Play()
	{
		if (particleObj == null)
		{
			foreach (GameObject particleObj in particleObjList)
			{
				particleObj.SetActive(value: false);
			}
			base.gameObject.SetActive(value: true);
			{
				foreach (GameObject particleObj2 in particleObjList)
				{
					particleObj2.SetActive(value: true);
				}
				return;
			}
		}
		this.particleObj.SetActive(value: false);
		this.particleObj.SetActive(value: true);
	}

	public void Hide()
	{
		if (particleObj == null)
		{
			foreach (GameObject particleObj in particleObjList)
			{
				particleObj.SetActive(value: false);
			}
			return;
		}
		this.particleObj.SetActive(value: false);
	}
}
