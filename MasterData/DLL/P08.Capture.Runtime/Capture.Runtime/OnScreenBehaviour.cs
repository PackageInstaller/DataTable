using System.Collections.Generic;
using Capture.Library;

namespace Capture.Runtime;

public class OnScreenBehaviour : BehaviourBase
{
	public override void ExecuteBehaviour()
	{
		CaptureGameDataForExchange gameContext = WorldManager.Instance.GetGameContext();
		ComponentAccessor<OBBComponent> obbComponents = gameContext.componentMgr.obbComponents;
		HashSet<int> containsArchEntities = gameContext.levelContainer.GetContainsArchEntities(ComponentChunkEnum.OBBChunk);
		if (containsArchEntities == null)
		{
			return;
		}
		bool flag = true;
		int num = 4;
		int num2 = 0;
		foreach (int item in containsArchEntities)
		{
			CaptureEntity entity = gameContext.levelContainer.GetEntity(item);
			entity.GetComponent(ComponentConst.TransformComponentType, out var id);
			int componentIndex = obbComponents.GetComponentIndex(id);
			_ = entity.obj.transform;
			num2 = 0;
			entity.isOnScreen = true;
			Rect3D rect = obbComponents.ComponentList[componentIndex].clipSpace.rect;
			for (int i = 0; i < 8; i++)
			{
				flag = rect[i].x <= 1f && rect[i].x >= -1f && rect[i].y <= 1f && rect[i].y >= -1f && rect[i].z <= 1f && rect[i].z >= -1f;
				num2 += ((!flag) ? 1 : 0);
				if (num2 > num)
				{
					entity.isOnScreen = false;
					break;
				}
			}
		}
	}
}
