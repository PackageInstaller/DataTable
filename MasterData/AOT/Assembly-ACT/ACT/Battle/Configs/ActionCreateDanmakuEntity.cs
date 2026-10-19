using System.Collections.Generic;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("创建弹幕实体", "Action", new string[] { "create", "danmaku", "entity", "state", "status", "tag" })]
public class ActionCreateDanmakuEntity : ConfigAction
{
	[SerializeReference]
	public TransformsPattern transformsPattern;

	public ActionCreatFlexibleEntity flexibleEntity;

	public ConfigFunction<float> intervalTime;

	public override void Do(ActionMemory memory)
	{
		List<(Vector3, Vector3)> list = ListPool<(Vector3, Vector3)>.Get();
		transformsPattern.GetPositionsAndRotation(memory, list);
		float realInterval = ((intervalTime == null) ? 0f : intervalTime.Return(memory));
		CreateDanmakuAsync(memory, list, realInterval).Forget();
	}

	private async UniTaskVoid CreateDanmakuAsync(ActionMemory memory, List<(Vector3, Vector3)> positionsAndRotations, float realInterval)
	{
		foreach (var positionsAndRotation in positionsAndRotations)
		{
			MonoECS.instance.SpawnFlexibleEntity(flexibleEntity.GetParams(positionsAndRotation.Item1, Quaternion.LookRotation(positionsAndRotation.Item2)), memory.target.entity, memory.ability);
			float time = realInterval;
			CompTime compTime = memory.owner.GetCompTime();
			while (time > 0f)
			{
				if (memory.owner.IsValid)
				{
					if (memory.ability != null)
					{
						ConfigAbility config = memory.ability.config;
						if (config != null && config.timeScale == TimeScale.NoScale)
						{
							time -= Time.fixedDeltaTime;
							goto IL_0129;
						}
					}
					time -= compTime.fixedDeltaTime;
				}
				else
				{
					time -= Time.fixedDeltaTime;
				}
				goto IL_0129;
				IL_0129:
				await UniTask.WaitForFixedUpdate();
			}
		}
		ListPool<(Vector3, Vector3)>.Release(positionsAndRotations);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		flexibleEntity?.CacheActionList(list, ab);
	}
}
