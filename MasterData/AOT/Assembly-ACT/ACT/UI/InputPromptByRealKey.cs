using ACT.Battle;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;

namespace ACT.UI;

public class InputPromptByRealKey : UIBehaviour
{
	[SerializeField]
	public string BindingEffectPath;

	public BImage InputIcon;

	protected override void Start()
	{
		base.Start();
		MonoECS.instance.onInputModeChange.AddListener(OnInputDeviceChange);
		Refresh();
	}

	protected override void OnDestroy()
	{
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputDeviceChange);
	}

	private void OnInputDeviceChange(DeviceInputMode arg0)
	{
		Refresh();
	}

	public void SetBindingEffectPath(string path)
	{
		BindingEffectPath = path;
		Refresh();
	}

	public void Refresh()
	{
		MonoECS.CorrectBindingPath(BindingEffectPath, out var _, out var path);
		MonoECS.instance.GetInputBindingIcon(path, OnGetInputIcon);
	}

	private void OnGetInputIcon(bool success, Sprite sprite, InputDevice device)
	{
		InputIcon.icon.sprite = sprite;
		InputIcon.icon.gameObject.SetActive(success);
		InputIcon.icon.SetNativeSize();
	}
}
