using UnityEngine;

namespace Dorm.Character.Animation;

internal class EntitySetFacialExpressionSMB : DormEntityStateEventBehaviour
{
	public int face;

	public override void InvokeEvent(DormComplexEntity entity, in AnimatorStateInfo stateInfo, int layerIndex)
	{
		entity.sdChara.sheetFaceId = face;
	}
}
