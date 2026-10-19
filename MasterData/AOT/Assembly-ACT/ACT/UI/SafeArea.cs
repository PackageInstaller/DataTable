using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class SafeArea : MonoBehaviour
{
	private RectTransform _rectTransform;

	private void Awake()
	{
		SettingsManager.Instance.RuntimeSettings.GetSettingFloat("Other.UIBorder").AddApplyListener(OnUIBorderChanged);
	}

	private void OnDestroy()
	{
		if (!(SettingsManager.Instance == null))
		{
			SettingsManager.Instance.RuntimeSettings.GetSettingFloat("Other.UIBorder").RemoveApplyListener(OnUIBorderChanged);
		}
	}

	private void OnEnable()
	{
		SetSafeArea();
	}

	private void OnUIBorderChanged(float obj)
	{
		SetSafeArea();
	}

	private void SetSafeArea()
	{
		if (MonoECS.instance.ispc)
		{
			SetOffsetX(-40f);
			return;
		}
		float offsetX = SettingsManager.Instance.RuntimeSettings.GetSettingFloat("Other.UIBorder").GetValue() - 84f;
		SetOffsetX(offsetX);
	}

	public void SetOffsetX(float x)
	{
		if (_rectTransform == null)
		{
			_rectTransform = GetComponent<RectTransform>();
		}
		_rectTransform.offsetMin = new Vector2(x, _rectTransform.offsetMin.y);
		_rectTransform.offsetMax = new Vector2(0f - x, _rectTransform.offsetMax.y);
	}
}
