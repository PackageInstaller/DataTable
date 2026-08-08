using System.Collections.Generic;
using UnityEngine;

namespace Capture.Runtime;

public class TransformBehviour : BehaviourBase
{
	public override void ExecuteBehaviour()
	{
		CaptureGameDataForExchange gameContext = WorldManager.Instance.GetGameContext();
		ComponentAccessor<TransformComponent> transformComponents = gameContext.componentMgr.transformComponents;
		HashSet<int> containsArchEntities = gameContext.levelContainer.GetContainsArchEntities(ComponentChunkEnum.TransformChunk);
		TransformComponent value = default(TransformComponent);
		if (containsArchEntities == null)
		{
			return;
		}
		foreach (int item in containsArchEntities)
		{
			CaptureEntity entity = gameContext.levelContainer.GetEntity(item);
			entity.GetComponent(ComponentConst.TransformComponentType, out var id);
			int componentIndex = transformComponents.GetComponentIndex(id);
			Transform transform = entity.obj.transform;
			if (transformComponents.ComponentList[componentIndex].trans == null || transformComponents.ComponentList[componentIndex].trans != transform)
			{
				value.trans = transform;
				transformComponents.ComponentList[componentIndex] = value;
			}
		}
	}
}
