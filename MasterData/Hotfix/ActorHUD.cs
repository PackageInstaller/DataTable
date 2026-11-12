using UnityEngine;

[DisallowMultipleComponent]
[RequireComponent(typeof(HUDFollowTarget))]
public class ActorHUD : MonoBehaviour, IAdventureHUD
{
	private HUDFollowTarget _followTarget;

	public Canvas rootCanvas { get; set; }

	private void Awake()
	{
		_followTarget = gameObject.AddOrGetComponent<HUDFollowTarget>();
		rootCanvas = GetComponent<Canvas>();
		if (rootCanvas != null && rootCanvas.worldCamera == null)
		{
			rootCanvas.worldCamera = SceneSingleton<AdventurePlayerController>.Instance.hudCamera;
		}
	}

	private void OnEnable()
	{
		SceneSingleton<AdventureHUDController>.Instance.AddHud(this);
	}

	private void OnDisable()
	{
		SceneSingleton<AdventureHUDController>.Instance?.RemoveHud(this);
	}

	public void SetFollowTarget(Transform target, Vector3 positionOffset)
	{
		_followTarget?.SetFollowTarget(target, positionOffset);
	}

	public void HUDUpdate(float dt)
	{
		_followTarget?.HUDUpdate(dt);
	}
}
