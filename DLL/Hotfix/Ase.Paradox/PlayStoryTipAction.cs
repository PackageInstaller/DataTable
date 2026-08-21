using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("播放气泡框", 0)]
[Category("✫ DragonLost/Story")]
[Description("播放指定ID的播放气泡框。")]
public class PlayStoryTipAction : ActionTaskBase
{
	[Name("气泡框ID", 0)]
	[Description("要播放的气泡框的ID。")]
	public BBParameter<int> tipID;

	protected override async void OnExecute()
	{
		base.OnExecute();
		if (tipID.value == 0)
		{
			OnActionFinish();
			return;
		}
		GetOwnerEntity().GetSystem<BattleSystem>().GetSystem<BattleSystem>().ShowNPCBubble(tipID.value, tipID.value, GetOwnerEntity().transform.position + new Vector3(0f, 1.8f, 0f));
		OnActionFinish();
	}
}
