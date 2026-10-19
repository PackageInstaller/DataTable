using System;
using ACT.Battle;
using ACT.Battle.ECS.System.SystemNPC;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.NPC.Actions;

[Serializable]
public class ActionLoadVirtualNpc : NpcInteractAction
{
	private static readonly Vector3 LeftPoint1PositionOffset = new Vector3(-0.6f, 0f, 0.6f);

	private static readonly Vector3 LeftPoint2PositionOffset = new Vector3(-1.3f, 0f, -0.6f);

	private static readonly Vector3 RightPoint1PositionOffset = new Vector3(0.6f, 0f, 0.6f);

	private static readonly Vector3 RightPoint2PositionOffset = new Vector3(1.3f, 0f, -0.6f);

	private static readonly Vector3 LeftRotation = new Vector3(0f, 90f, 0f);

	private static readonly Vector3 RightRotation = new Vector3(0f, -90f, 0f);

	public int virtualNpcConfigUid1;

	public int virtualNpcConfigUid2;

	public override int ActionId => NpcInteractActionIds.LoadVirtualNpc;

	protected override UniTask DoAction()
	{
		if (!Singleton<RuntimeNpcManager>.HasInstance())
		{
			return UniTask.CompletedTask;
		}
		MonoECS instance = MonoECS.instance;
		if (instance == null || !instance.mainEntity.IsValid || !Context.Npc.IsValid)
		{
			return UniTask.CompletedTask;
		}
		Transform rootTransform = instance.mainEntity.GetRootTransform();
		Transform rootTransform2 = Context.Npc.GetRootTransform();
		if (rootTransform == null || rootTransform2 == null)
		{
			return UniTask.CompletedTask;
		}
		bool flag = rootTransform.position.x <= rootTransform2.position.x;
		Vector3 worldRotation = (flag ? LeftRotation : RightRotation);
		Vector3 position = rootTransform.position;
		Singleton<RuntimeNpcManager>.instance.ForceShowDialogueVirtualNpc(virtualNpcConfigUid1, position + GetPoint1PositionOffset(flag), worldRotation);
		Singleton<RuntimeNpcManager>.instance.ForceShowDialogueVirtualNpc(virtualNpcConfigUid2, position + GetPoint2PositionOffset(flag), worldRotation);
		return UniTask.CompletedTask;
	}

	private static Vector3 GetPoint1PositionOffset(bool playerIsAtTargetNpcLeft)
	{
		if (!playerIsAtTargetNpcLeft)
		{
			return RightPoint1PositionOffset;
		}
		return LeftPoint1PositionOffset;
	}

	private static Vector3 GetPoint2PositionOffset(bool playerIsAtTargetNpcLeft)
	{
		if (!playerIsAtTargetNpcLeft)
		{
			return RightPoint2PositionOffset;
		}
		return LeftPoint2PositionOffset;
	}
}
