using UnityEngine;

namespace Ase;

public class CampaignAirWallNode
{
	public CampaignAirWallData Data { get; }

	public GameObject GameObject { get; private set; }

	public CampaignAirWallNode(CampaignAirWallData data)
	{
		Data = data;
	}

	public void Bind(GameObject gameObject)
	{
		GameObject = gameObject;
	}

	public void SetActive(bool active)
	{
		if (GameObject != null)
		{
			GameObject.SetActive(active);
		}
	}

	public void Destroy()
	{
		if (!(GameObject == null))
		{
			GameObject.SetActive(value: false);
			Object.Destroy(GameObject);
			GameObject = null;
		}
	}
}
