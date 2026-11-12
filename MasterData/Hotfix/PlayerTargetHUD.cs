using UnityEngine;

[DisallowMultipleComponent]
[RequireComponent(typeof(HUDTargetMark))]
public class PlayerTargetHUD : MonoBehaviour, IAdventureHUD
{
	private HUDTargetMark _targetMark;

	public Canvas rootCanvas { get; set; }

	private void Awake()
	{
		_targetMark = gameObject.AddOrGetComponent<HUDTargetMark>();
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

	public void HUDUpdate(float dt)
	{
		_targetMark?.HUDUpdate(dt);
	}
}
