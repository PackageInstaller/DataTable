using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.UI;

namespace NodeCanvas.Tasks.Conditions;

[Category("UGUI")]
public class ButtonClicked : ConditionTask
{
	[RequiredField]
	public BBParameter<Button> button;

	protected override string info => $"Button {button.ToString()} Clicked";

	protected override string OnInit()
	{
		button.value.onClick.AddListener(OnClick);
		return null;
	}

	protected override bool OnCheck()
	{
		return false;
	}

	private void OnClick()
	{
		YieldReturn(value: true);
	}
}
