using UnityEngine;

public class HpBarKeepSelfRotation : MonoBehaviour, IAdventureHUD
{
	private Vector3 angle;

	private void Awake()
	{
		angle = transform.eulerAngles;
	}

	private void OnEnable()
	{
		SceneSingleton<AdventureHUDController>.Instance.AddHud(this);
	}

	private void OnDisable()
	{
		SceneSingleton<AdventureHUDController>.Instance?.RemoveHud(this);
	}

	public void HUDUpdate(float dt)
	{
		transform.eulerAngles = angle;
	}
}
