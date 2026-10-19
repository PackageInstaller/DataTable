using System;
using System.Threading;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行闪现施法者到位置", "Action", new string[] { "flash", "caster", "to", "position", "move", "movement", "velocity" })]
public class ActionFlashCasterToPosition : ConfigAction
{
	public Vector3 offset;

	public bool useOwner;

	[Tooltip("默认为True即可")]
	public bool cancelAfterDie = true;

	public float delay;

	public bool fixPositionByTarget;

	protected override AbilityAuth defaultAuth => AbilityAuth.Owner;

	public override void Do(ActionMemory memory)
	{
		DelayFlash(memory).Forget();
	}

	private async UniTaskVoid DelayFlash(ActionMemory memory)
	{
		Entity owner = memory.owner;
		Entity entity = (useOwner ? memory.owner : memory.caster);
		CompPhysics compPhysics = memory.caster.GetCompPhysics();
		Vector3 local = compPhysics.WorldToPathLocal(offset);
		CompTransform compTransform = owner.GetCompTransform();
		Vector3 world = compTransform.rotation * Vector3.forward;
		if (compPhysics.WorldToPathLocal(world).z < 0f)
		{
			local.z *= -1f;
		}
		Vector3 ownerPosition = compTransform.physicsPosition;
		Vector3 targetPoint = ownerPosition + compPhysics.PathLocalToWorld(local);
		if (cancelAfterDie)
		{
			CancellationToken token = memory.owner.GetCompAbility().GetCancellationTokenOnDie();
			await UniTask.Delay(TimeSpan.FromSeconds(delay), ignoreTimeScale: false, PlayerLoopTiming.Update, token);
			if (!token.IsCancellationRequested && entity.IsActive() && entity.IsAlive())
			{
				Resolve();
				entity.Teleport(targetPoint);
			}
			return;
		}
		if (delay > 0f)
		{
			await UniTask.Delay(TimeSpan.FromSeconds(delay));
		}
		if (entity.IsActive() && entity.IsAlive())
		{
			Resolve();
			entity.Teleport(targetPoint);
		}
		void Resolve()
		{
			targetPoint = ResolveOffset(ownerPosition, targetPoint - ownerPosition, entity.GetCompTransform().size);
			Vector3 physicsPosition = memory.target.entity.GetCompTransform().physicsPosition;
			targetPoint = ResolveOffset(physicsPosition, targetPoint - physicsPosition, entity.GetCompTransform().size);
			if (fixPositionByTarget)
			{
				targetPoint = ResolvePosition(targetPoint, memory.target.entity, entity);
			}
		}
	}

	private Vector3 ResolvePosition(Vector3 position, Entity target, Entity owner)
	{
		if (!target.IsValid)
		{
			return position;
		}
		CompTransform compTransform = target.GetCompTransform();
		CompTransform compTransform2 = owner.GetCompTransform();
		Vector3 resolveOffset = Vector3.Project(position - compTransform.physicsPosition, compTransform.FaceRotation * Vector3.forward).normalized * compTransform2.size.x;
		return ResolveOffset(position, resolveOffset, compTransform2.size);
	}

	private Vector3 ResolveOffset(Vector3 position, Vector3 resolveOffset, Vector2 size)
	{
		if (!PhysicsUtility.CapsuleCast(position + new Vector3(0f, size.y / 2f, 0f), size, resolveOffset, resolveOffset.magnitude, out var hit))
		{
			return position + resolveOffset;
		}
		return position + hit.distance * resolveOffset.normalized;
	}
}
