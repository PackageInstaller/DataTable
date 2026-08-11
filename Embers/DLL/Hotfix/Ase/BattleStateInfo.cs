using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine.Pool;

namespace Ase;

public class BattleStateInfo : IReference
{
	public HashSet<int> HitEntityId = CollectionPool<HashSet<int>, int>.Get();

	public HashSet<int> AttackEntityId = CollectionPool<HashSet<int>, int>.Get();

	public MonsterEntity BattleBoss;

	public bool ForceBattle;

	private bool battleStateResult;

	public bool BattleStateResult
	{
		get
		{
			return battleStateResult;
		}
		set
		{
			battleStateResult = value;
		}
	}

	public void Clear()
	{
		HitEntityId.Clear();
		AttackEntityId.Clear();
		BattleBoss = null;
		ForceBattle = false;
		BattleStateResult = false;
	}
}
