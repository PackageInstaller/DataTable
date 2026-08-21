using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("关闭气泡框", 0)]
[Category("✫ DragonLost/Story")]
[Description("关闭指定ID的播放气泡框。")]
public class CloseStoryTipAction : ActionTaskBase
{
	[Name("气泡框ID", 0)]
	[Description("要播放的气泡框的ID。")]
	public BBParameter<int> tipID;

	protected override async void OnExecute()
	{
		base.OnExecute();
		GetOwnerEntity().GetSystem<BattleSystem>().GetSystem<BattleSystem>().CloseNPCBubble(tipID.value);
		OnActionFinish();
	}
}
