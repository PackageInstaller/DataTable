using UnityEngine;
using UnityEngine.EventSystems;

public class P08StoryQTEButton : P08StoryQTEUI, IPointerDownHandler, IEventSystemHandler
{
	private GameObject _anxia_go;

	private GameObject _daiji_go;

	private void Awake()
	{
		_anxia_go = GetGoFromCfg("_anxia_glow");
		_daiji_go = GetGoFromCfg("_daiji");
		_daiji_go.SetActive(value: true);
		_anxia_go.SetActive(value: false);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		_daiji_go.SetActive(value: false);
		if (_anxia_go != null)
		{
			_anxia_go.SetActive(value: true);
		}
	}

	public override void Dispose(float delay)
	{
		base.gameObject.GetComponent<Animation>()?.Play();
		base.Dispose(delay);
	}
}
