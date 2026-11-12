using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/特殊实体/轨道(自旋转，跟随)")]
[DisallowMultipleComponent]
public class OrbitEntity : LogicEntity, ISpecialEntity
{
	public List<OrbitNodeCfg> orbitNodeCfgs = new List<OrbitNodeCfg>();

	public FP searchRange = 10;

	public FP LeftTime;

	private FP additionLeftTime;

	private OrbitState orbitState;

	private TeleportState teleportState;

	private FP curLeftTime;

	private List<OrbitNode> orbitNodes = new List<OrbitNode>();

	private AdventureActor _owner;

	private LogicEntity _atkTarget;

	public FP FinalLeftTime => LeftTime + additionLeftTime;

	public AdventureActor Owner => _owner;

	public LogicEntity atkTarget
	{
		get
		{
			if (_atkTarget == null)
			{
				return null;
			}
			if (_atkTarget is AdventureActor adventureActor)
			{
				if (!adventureActor.isSneak && !adventureActor.isBattleOut && !adventureActor.searchedImmunity && !adventureActor.isPenetrate && adventureActor.actorHealthInfo.isAlive)
				{
					return _atkTarget;
				}
				return null;
			}
			return null;
		}
		set
		{
			_atkTarget = value;
		}
	}

	public bool EnableRot { get; set; }

	protected override void OnInit()
	{
		base.OnInit();
	}

	protected override void OnActive()
	{
		base.OnActive();
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		DisableLogicUpdate();
		_owner = null;
		orbitNodes.Clear();
	}

	public void Setup(AdventureActor owner)
	{
		additionLeftTime = 0;
		curLeftTime = 0;
		_owner = owner;
		_atkTarget = owner.attackTarget;
		orbitState = OrbitState.Spawn;
		teleportState = TeleportState.None;
		EnableRot = false;
		EnableLogicUpdate();
		for (int i = 0; i < orbitNodeCfgs.Count; i++)
		{
			OrbitNodeCfg orbitNodeCfg = orbitNodeCfgs.get_Item(i);
			FP radius = (_atkTarget as MonsterAdventureActor).GetRadius();
			OrbitNode orbitNode = new OrbitNode(orbitNodeCfg.radius + radius, orbitNodeCfg.rotSpeed);
			orbitNode.Init(this);
			orbitNode.attachNodes = new List<AttachNode>();
			orbitNodes.Add(orbitNode);
			for (int j = 0; j < orbitNodeCfg.attachOffsetRot.Count; j++)
			{
				FP attachOffsetRot = orbitNodeCfg.attachOffsetRot.get_Item(j);
				AttachNode attachNode = new AttachNode
				{
					attachOffsetRot = attachOffsetRot
				};
				orbitNode.attachNodes.Add(attachNode);
				SummonAttach(orbitNodeCfg.monsterId, orbitNodeCfg.summonCfg, orbitNode, attachNode);
			}
		}
	}

	private void SummonAttach(int monsterId, SummonCfg summonCfg, OrbitNode orbitNode, AttachNode attachNode)
	{
		var (pos, _, dir) = orbitNode.CalcTRS(attachNode);
		ILRuntimeAPI.SummonMonster(Owner, 0, monsterId, pos, dir, summonCfg, null, (MonsterAdventureActor entity) =>
		{
			attachNode.attachEntity = entity;
		});
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		curLeftTime += LogicDeltaTime;
		if (curLeftTime > FinalLeftTime)
		{
			Finish();
			return;
		}
		GetNewTarget();
		if (atkTarget != null)
		{
			tsTransform.Position = atkTarget.tsTransform.Position;
		}
		if (orbitState == OrbitState.Spawn)
		{
			bool flag = true;
			for (int i = 0; i < orbitNodes.Count; i++)
			{
				OrbitNode orbitNode = orbitNodes.get_Item(i);
				orbitNode.Update();
				flag &= orbitNode.CheckSpawnCompleted();
			}
			if (flag)
			{
				orbitState = OrbitState.Update;
				EnableRot = true;
			}
		}
		else if (orbitState == OrbitState.Teleport)
		{
			if (teleportState == TeleportState.FadeOut)
			{
				EnableRot = false;
				for (int j = 0; j < orbitNodes.Count; j++)
				{
					OrbitNode orbitNode2 = orbitNodes.get_Item(j);
					orbitNode2.ResetAtkTarget();
					orbitNode2.FadeOut();
				}
				teleportState = TeleportState.FadeOuting;
			}
			else if (teleportState == TeleportState.FadeOuting)
			{
				bool flag2 = true;
				for (int k = 0; k < orbitNodes.Count; k++)
				{
					OrbitNode orbitNode3 = orbitNodes.get_Item(k);
					flag2 &= orbitNode3.CheckFadeOutCompleted();
				}
				if (flag2)
				{
					for (int l = 0; l < orbitNodes.Count; l++)
					{
						orbitNodes.get_Item(l).UpdateAttachs(forceSync: true, updateAtkTarget: false);
					}
					teleportState = TeleportState.FadeIn;
				}
			}
			else if (teleportState == TeleportState.FadeIn)
			{
				for (int m = 0; m < orbitNodes.Count; m++)
				{
					orbitNodes.get_Item(m).FadeIn();
				}
				teleportState = TeleportState.FadeIning;
			}
			else if (teleportState == TeleportState.FadeIning)
			{
				bool flag3 = true;
				for (int n = 0; n < orbitNodes.Count; n++)
				{
					OrbitNode orbitNode4 = orbitNodes.get_Item(n);
					orbitNode4.Update(updateAtkTarget: false);
					flag3 &= orbitNode4.CheckFadeInCompleted();
				}
				if (flag3)
				{
					EnableRot = true;
					teleportState = TeleportState.End;
					orbitState = OrbitState.Update;
				}
			}
		}
		else
		{
			if (orbitState != OrbitState.Update)
			{
				return;
			}
			if (atkTarget != null)
			{
				for (int num = 0; num < orbitNodes.Count; num++)
				{
					orbitNodes.get_Item(num).Update();
				}
			}
			else
			{
				Finish();
			}
		}
	}

	public void GetNewTarget()
	{
		if (!(atkTarget == null))
		{
			return;
		}
		if (Owner.attackTarget != null)
		{
			atkTarget = Owner.attackTarget;
		}
		else
		{
			List<LogicEntity> list = ILRuntimeAPI.SearchByRangeAndPosition(Owner, Owner.tsTransform.Position, searchRange, null, isConfront: true);
			if (list.Count > 0)
			{
				atkTarget = list.get_Item(0);
			}
		}
		if (atkTarget != null)
		{
			teleportState = TeleportState.FadeOut;
			orbitState = OrbitState.Teleport;
		}
	}

	public void Finish()
	{
		for (int i = 0; i < orbitNodes.Count; i++)
		{
			orbitNodes.get_Item(i).Finish();
		}
		SceneSingleton<SpecialEntityManager>.Instance.Despawn(transform);
	}

	public void AddLeftTime(FP addTime)
	{
		additionLeftTime += addTime;
	}
}
