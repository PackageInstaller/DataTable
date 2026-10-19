using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public abstract class RespawnPromptCell : UIBehaviour
{
	[SerializeField]
	private int _systemOpenId;

	[SerializeField]
	private Slider _slider;

	public virtual void Init()
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(_systemOpenId))
		{
			gameObject.SetActive(value: false);
			return;
		}
		gameObject.SetActive(value: false);
		UpdateContent();
	}

	protected virtual void UpdateContent()
	{
	}

	protected void UpdateSlider(float val)
	{
		_slider.value = val;
	}
}
