using System.Collections.Generic;
using Capture.Library;
using UnityEngine;

namespace Capture.Runtime;

public class OBBBehaviour : BehaviourBase
{
	public override void ExecuteBehaviour()
	{
		CaptureGameDataForExchange gameContext = WorldManager.Instance.GetGameContext();
		ComponentAccessor<OBBComponent> obbComponents = gameContext.componentMgr.obbComponents;
		HashSet<int> containsArchEntities = gameContext.levelContainer.GetContainsArchEntities(ComponentChunkEnum.OBBChunk);
		OBBComponent value = default(OBBComponent);
		Vector4 vector = new Vector4(0f, 0f, 0f, 1f);
		Rect3D rect = default(Rect3D);
		if (containsArchEntities == null)
		{
			return;
		}
		Camera main = Camera.main;
		Matrix4x4 matrix4x = GL.GetGPUProjectionMatrix(main.projectionMatrix, renderIntoTexture: false) * main.worldToCameraMatrix;
		foreach (int item in containsArchEntities)
		{
			CaptureEntity entity = gameContext.levelContainer.GetEntity(item);
			if (entity.obbCalculator.hasOBB)
			{
				entity.GetComponent(ComponentConst.OBBComponentType, out var id);
				int componentIndex = obbComponents.GetComponentIndex(id);
				value.obb = entity.obbCalculator.CalculateOBB();
				for (int i = 0; i < 8; i++)
				{
					vector.x = value.obb.rect[i].x;
					vector.y = value.obb.rect[i].y;
					vector.z = value.obb.rect[i].z;
					vector.w = 1f;
					vector = matrix4x * vector;
					vector /= vector.w;
					rect[i] = vector;
				}
				value.clipSpace.rect = rect;
				value.clipSpace.XAxis = (matrix4x * value.obb.XAxis).normalized;
				value.clipSpace.YAxis = (matrix4x * value.obb.YAxis).normalized;
				value.clipSpace.ZAxis = (matrix4x * value.obb.ZAxis).normalized;
				obbComponents.ComponentList[componentIndex] = value;
			}
		}
	}
}
