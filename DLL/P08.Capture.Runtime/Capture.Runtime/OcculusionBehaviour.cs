using System.Collections.Generic;
using Capture.Library;
using UnityEngine;

namespace Capture.Runtime;

public class OcculusionBehaviour : BehaviourBase
{
	public override void ExecuteBehaviour()
	{
		CaptureGameDataForExchange gameContext = WorldManager.Instance.GetGameContext();
		ComponentsManager componentMgr = gameContext.componentMgr;
		ComponentAccessor<OcculusionComponent> occulusionComponents = componentMgr.occulusionComponents;
		ComponentAccessor<OBBComponent> obbComponents = componentMgr.obbComponents;
		_ = componentMgr.occuluderComponents;
		HashSet<int> containsArchEntities = gameContext.levelContainer.GetContainsArchEntities(ComponentChunkEnum.OcculusionChunk);
		HashSet<int> containsArchEntities2 = gameContext.levelContainer.GetContainsArchEntities(ComponentChunkEnum.OccluderChunk);
		if (containsArchEntities == null || containsArchEntities2 == null)
		{
			return;
		}
		OcculusionComponent occulusionComponent = default(OcculusionComponent);
		OBB obb = new OBB
		{
			XAxis = Vector3.right,
			YAxis = Vector3.up,
			ZAxis = Vector3.forward
		};
		foreach (int item in containsArchEntities2)
		{
			gameContext.levelContainer.GetEntity(item).GetComponent(ComponentConst.OBBComponentType, out var id);
			int componentIndex = obbComponents.GetComponentIndex(id);
			OBB clipSpace = obbComponents.ComponentList[componentIndex].clipSpace;
			Vector2 zero = Vector2.zero;
			Vector2 one = Vector2.one;
			float num = 1f;
			for (int i = 0; i < 8; i++)
			{
				num = Mathf.Min(num, Mathf.Max(0f, clipSpace.rect[i].z));
				zero.x = Mathf.Max(zero.x, clipSpace.rect[i].x);
				zero.y = Mathf.Max(zero.y, clipSpace.rect[i].y);
				one.x = Mathf.Min(one.x, clipSpace.rect[i].x);
				one.y = Mathf.Min(one.y, clipSpace.rect[i].y);
			}
			obb.rect[0] = new Vector3(one.x, one.y, num);
			obb.rect[1] = new Vector3(one.x, zero.y, num);
			obb.rect[2] = new Vector3(zero.x, one.y, num);
			obb.rect[3] = new Vector3(zero.x, zero.y, num);
			obb.rect[4] = new Vector3(one.x, one.y, -1f);
			obb.rect[5] = new Vector3(one.x, zero.y, -1f);
			obb.rect[6] = new Vector3(zero.x, one.y, -1f);
			obb.rect[7] = new Vector3(zero.x, zero.y, -1f);
			foreach (int item2 in containsArchEntities)
			{
				CaptureEntity entity = gameContext.levelContainer.GetEntity(item2);
				entity.GetComponent(ComponentConst.OBBComponentType, out var id2);
				int componentIndex2 = obbComponents.GetComponentIndex(id2);
				entity.GetComponent(ComponentConst.OcclusionComponentType, out var id3);
				int componentIndex3 = occulusionComponents.GetComponentIndex(id3);
				occulusionComponent = occulusionComponents.ComponentList[componentIndex3];
				bool flag = false;
				flag = !entity.isOnScreen || obb.OverlapOBB(obbComponents.ComponentList[componentIndex2].clipSpace);
				occulusionComponent.isOcculuded = flag;
				occulusionComponents.ComponentList[componentIndex3] = occulusionComponent;
			}
		}
	}
}
