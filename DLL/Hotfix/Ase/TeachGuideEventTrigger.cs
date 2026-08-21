using System;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

[Trigger("新手引导触发器")]
public class TeachGuideEventTrigger : BaseEventTriggerNode, IObserverHandler
{
	public string SelectTeachGuideType;

	private BattleObserverEventEnum _battleObserverEventEnum;

	public int TeachGuideId;

	public override string TriggerName => "新手引导触发器";

	public override void OnInited(object data = null)
	{
		base.OnInited(data);
		_battleObserverEventEnum = Enum.Parse<BattleObserverEventEnum>(SelectTeachGuideType);
		sceneSystem.GetSystem<BattleObserverSystem>().Attach(_battleObserverEventEnum, this);
		if (_battleObserverEventEnum == BattleObserverEventEnum.TeachAIXpEnergy)
		{
			sceneSystem.GetSystem<BattleSystem>().OpenTeachAIXp();
		}
	}

	protected override void DoExecute()
	{
		base.DoExecute();
	}

	public async void OnNotify(IObserverParams param)
	{
		ObserverTeachGuideParams observerTeachGuideParams = param as ObserverTeachGuideParams;
		Transform frameTrans = observerTeachGuideParams.FrameTrans;
		await UniTask.WaitForSeconds(delayTimer);
		sceneSystem.GetSystem<TeachGuideSystem>().OpenTeachGuideWindow(TeachGuideId, delayShow: false, frameTrans);
	}
}
