using System.Threading;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;

namespace ACT.Battle;

public class TriggerActionStartGuide : TriggerActionBase
{
	public int guideId;

	public override UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		if (MonoECS.instance.playState == PlayState.UnBattle)
		{
			Model<GuideModel>.Interface.StartGuide(guideId);
		}
		return UniTask.CompletedTask;
	}
}
