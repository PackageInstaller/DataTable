using System;
using UnityEngine.UI;

namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerIndirectFloatField : DebugUIHandlerWidget
{
	public Text nameLabel;

	public Text valueLabel;

	public Func<float> getter;

	public Action<float> setter;

	public Func<float> incStepGetter;

	public Func<float> incStepMultGetter;

	public Func<float> decimalsGetter;

	public void Init()
	{
		UpdateValueLabel();
	}

	public override bool OnSelection(bool fromNext, DebugUIHandlerWidget previous)
	{
		nameLabel.color = colorSelected;
		valueLabel.color = colorSelected;
		return true;
	}

	public override void OnDeselection()
	{
		nameLabel.color = colorDefault;
		valueLabel.color = colorDefault;
	}

	public override void OnIncrement(bool fast)
	{
		ChangeValue(fast, 1f);
	}

	public override void OnDecrement(bool fast)
	{
		ChangeValue(fast, -1f);
	}

	private void ChangeValue(bool fast, float multiplier)
	{
		float num = getter();
		num += incStepGetter() * (fast ? incStepMultGetter() : 1f) * multiplier;
		setter(num);
		UpdateValueLabel();
	}

	private void UpdateValueLabel()
	{
		if (valueLabel != null)
		{
			valueLabel.text = getter().ToString("N" + decimalsGetter());
		}
	}
}
