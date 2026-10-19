using System.Threading;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;

namespace ACT.Battle;

public class TriggerActionStartImageVideoTip : TriggerActionBase
{
	public int tutorialId;

	public override UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		if (MonoECS.instance.playState == PlayState.UnBattle)
		{
			Model<GuideModel>.Interface.OpenImageVideoTips(tutorialId);
		}
		return UniTask.CompletedTask;
	}
}
