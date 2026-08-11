using System;
using UnityEngine.UI;

namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerIndirectToggle : DebugUIHandlerWidget
{
	public Text nameLabel;

	public Toggle valueToggle;

	public Image checkmarkImage;

	public Func<int, bool> getter;

	public Action<int, bool> setter;

	internal int index;

	public void Init()
	{
		UpdateValueLabel();
		valueToggle.onValueChanged.AddListener(OnToggleValueChanged);
	}

	private void OnToggleValueChanged(bool value)
	{
		setter(index, value);
	}

	public override bool OnSelection(bool fromNext, DebugUIHandlerWidget previous)
	{
		nameLabel.color = colorSelected;
		checkmarkImage.color = colorSelected;
		return true;
	}

	public override void OnDeselection()
	{
		nameLabel.color = colorDefault;
		checkmarkImage.color = colorDefault;
	}

	public override void OnAction()
	{
		bool arg = !getter(index);
		setter(index, arg);
		UpdateValueLabel();
	}

	internal void UpdateValueLabel()
	{
		if (valueToggle != null)
		{
			valueToggle.isOn = getter(index);
		}
	}
}
