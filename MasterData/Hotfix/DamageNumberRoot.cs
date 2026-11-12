using UnityEngine;

public class DamageNumberRoot : MonoBehaviour
{
	private Canvas _canvas;

	private void Awake()
	{
		_canvas = GetComponent<Canvas>();
		if (_canvas != null && _canvas.worldCamera == null)
		{
			_canvas.worldCamera = SceneSingleton<AdventurePlayerController>.Instance.hudCamera;
		}
	}
}
