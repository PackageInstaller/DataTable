using ACT.Battle;
using ACT.Battle.ECS.System.SystemNPC;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.NPC.BehaviorTree.Action;

[TaskCategory("NPC")]
[TaskDescription("等到对话结束")]
public class WaitUntilDialogueFinish : NpcActionBase
{
	private static readonly int State1 = Animator.StringToHash("state");

	private bool _isWaiting;

	public override TaskStatus OnUpdate()
	{
		if (!Singleton<GameState>.instance.InInteractObjectProcessing)
		{
			_isWaiting = false;
			return TaskStatus.Failure;
		}
		CompNpc compNpc = OwnerEntity.GetCompNpc();
		if (Singleton<RuntimeNpcManager>.instance.CurrentDialogueNpc != compNpc)
		{
			return TaskStatus.Failure;
		}
		if (!_isWaiting)
		{
			compNpc?.Animator.SetInteger(State1, -1);
			Transform modelTrans = OwnerEntity.GetModelTrans();
			Vector3 vector = MonoECS.instance.mainEntity.GetModelTrans().position - modelTrans.position;
			vector.y = 0f;
			if (vector != Vector3.zero)
			{
				Quaternion rotation = Quaternion.LookRotation(vector);
				modelTrans.rotation = rotation;
			}
			_isWaiting = true;
		}
		return TaskStatus.Success;
	}
}
