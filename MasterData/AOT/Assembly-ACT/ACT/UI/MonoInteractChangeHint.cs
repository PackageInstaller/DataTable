using ACT.Battle;
using ACT.Model;
using UnityEngine;

namespace ACT.UI;

public class MonoInteractChangeHint : MonoBehaviour
{
	[SerializeField]
	private CanvasGroup _pcChangeHint;

	[SerializeField]
	private CanvasGroup _psAndXboxChangeHint;

	[SerializeField]
	private CanvasGroup _changeHintRoot;

	private void Awake()
	{
		Init();
	}

	public void Init()
	{
		MonoECS.instance.onInputModeChange.AddListener(InternalOnInputDeviceChange);
		Model<InteractModel>.Interface.UpdateHintRoot += SetHintRoot;
		SetHintRoot(Model<InteractModel>.Interface.NeedShowHint);
	}

	private void InternalOnInputDeviceChange(DeviceInputMode type)
	{
		_pcChangeHint.alpha = ((type == DeviceInputMode.KeyboardAndMouse) ? 1 : 0);
		_psAndXboxChangeHint.alpha = ((type != DeviceInputMode.KeyboardAndMouse) ? 1 : 0);
	}

	public void SetHintRoot(bool active)
	{
		if (!MonoECS.instance.ispc)
		{
			_changeHintRoot.alpha = 0f;
			return;
		}
		_changeHintRoot.alpha = (active ? 1 : 0);
		InternalOnInputDeviceChange(MonoECS.instance.InputMode);
	}

	private void OnDestroy()
	{
		MonoECS.instance.onInputModeChange.RemoveListener(InternalOnInputDeviceChange);
		Model<InteractModel>.Interface.UpdateHintRoot -= SetHintRoot;
	}
}
