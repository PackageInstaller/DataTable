using ACT.Battle;
using ACT.BluePrint;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT;

internal class CleanupEntities : WorldLoadStepOperation
{
	private bool _isWaiting = true;

	internal override void OnStart()
	{
		CleanupScene().Forget();
	}

	internal override void OnUpdate()
	{
		if (!_isWaiting)
		{
			State = OptionState.Succeed;
		}
	}

	private async UniTaskVoid CleanupScene()
	{
		BPCommon[] array = Object.FindObjectsByType<BPCommon>(FindObjectsInactive.Include, FindObjectsSortMode.None);
		for (int i = 0; i < array.Length; i++)
		{
			Object.Destroy(array[i].gameObject);
		}
		foreach (Entity allEntity in GameManager.entities.GetAllEntities())
		{
			MonoECS.instance.TryRemoveBehave(allEntity);
		}
		await UniTask.DelayFrame(2, PlayerLoopTiming.LastPostLateUpdate);
		GameManager.effectSystem?.CleanAllEffect();
		_isWaiting = false;
	}
}
