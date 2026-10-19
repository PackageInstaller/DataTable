using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.World.Asset;
using Cysharp.Threading.Tasks;
using UnityEngine.Pool;

namespace ACT.MissionSystem;

public class SetInteractableStatesAction : MissionAction
{
	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		SetInteractableStatesActionParam setInteractableStatesActionParam = Param as SetInteractableStatesActionParam;
		StateChangeInfo[] array = new StateChangeInfo[setInteractableStatesActionParam.interactableStates.Count];
		for (int i = 0; i < setInteractableStatesActionParam.interactableStates.Count; i++)
		{
			SetInteractableStatesActionParam.InteractableStateData interactableStateData = setInteractableStatesActionParam.interactableStates[i];
			array[i] = new StateChangeInfo
			{
				uid = interactableStateData.interactableId,
				stateId = interactableStateData.state
			};
		}
		bool haveResult = false;
		MonoECS.instance.ruleManager.SharedChangeStates(array, (bool result) =>
		{
			haveResult = true;
		});
		UniTask item = UniTask.WaitUntil(() => haveResult, PlayerLoopTiming.Update, token);
		UniTask item2 = UniTask.WaitForSeconds(5, ignoreTimeScale: false, PlayerLoopTiming.Update, token);
		List<UniTask> taskList = CollectionPool<List<UniTask>, UniTask>.Get();
		taskList.Add(item);
		taskList.Add(item2);
		await UniTask.WhenAny(taskList);
		CollectionPool<List<UniTask>, UniTask>.Release(taskList);
	}
}
