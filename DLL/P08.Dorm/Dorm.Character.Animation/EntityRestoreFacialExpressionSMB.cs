using UnityEngine;

namespace Dorm.Character.Animation;

internal class EntityRestoreFacialExpressionSMB : DormEntityStateEventBehaviour
{
	public override void InvokeEvent(DormComplexEntity entity, in AnimatorStateInfo stateInfo, int layerIndex)
	{
		entity.sdChara.sheetFaceId = entity.DefaultMouth;
	}
}
