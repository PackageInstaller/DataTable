using System;
using ACT.Battle;
using Bamboo.Chronos;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.StateObject;

public interface IAttackEntrySetting : ICommonInteractEntrySetting
{
	int AttackableId { get; }

	string[] Abilities { get; }

	Alliance Alliance { get; }

	Vector3 Size { get; }

	Vector3 PosOffset { get; }

	bool IsAttachCollider { get; }

	Collider AttachCollider { get; }

	bool SyncAttackablePosition { get; }

	InteractActionList OnHitedActionList { get; }

	Action<Entity> onSpawnAttackable { get; set; }

	ChallangeType ChallengeInteractType { get; }

	int ComboCountNeed { get; }

	int TimeNeed { get; }

	int TimeNow { get; set; }

	ComboStateParam ComboStateParam1 { get; }

	ComboStateParam ComboStateParam2 { get; }

	ComboStateParam ComboStateParam3 { get; }

	bool NeedLog { get; }

	int ComboCount { get; set; }

	Tweener Timer { get; set; }

	Entity AttackableER { get; set; }

	IDisposable SyncAttackablePositionDisposable { get; set; }

	Action<int, int> onHPChangeInteract { get; set; }

	Action<Entity> onHitInteract { get; set; }

	Action<int> onComboChallengeInteract { get; set; }
}
