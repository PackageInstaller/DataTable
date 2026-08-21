using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("切换对话按钮状态", 0)]
[Description("根据按钮 ID 切换对话按钮的状态。")]
[Category("✫ DragonLost/Interactive")]
public class ChangeDialogueButtonStateAction : ActionTaskBase
{
	[Name("按钮ID (DialogButton表ID)", 0)]
	[Description("要切换状态的对话按钮的唯一标识符。")]
	public BBParameter<int> dialogueButtonId;

	[Name("按钮状态", 0)]
	[Description("要设置的对话按钮的新状态。")]
	[PopupField(new object[] { "lock", "unlock", "active", "inactive" })]
	public BBParameter<string> dialogueButtonState = new BBParameter<string>();

	protected override void OnExecute()
	{
		base.OnExecute();
		GetOwnerEntity().GetComponent<DialogChainComponent>()?.ChangeDialogueButtonState(dialogueButtonId.value, dialogueButtonState.value);
		OnActionFinish();
	}
}
