using System.Collections.Generic;
using BilliardGame.Spell;
using UnityEngine;

namespace BilliardGame.Runtime;

public class EntityPhysicalBullet : BilliardGameEntityBase
{
	private float checkTime;

	public BilliardGameEntityBase owner;

	protected int remainATK;

	public BilliardGamePhysicalBullet logic;

	protected int lastCol;

	protected int buffID;

	protected int sourceBuffID;

	protected BTEnv env;

	protected string effectName;

	protected string dieAudio;

	private List<BTEnv> inheritedBuffList = new List<BTEnv>();

	public bool Dead => lastCol <= 0;

	public int ATK
	{
		get
		{
			int num = remainATK;
			if (env != null && env.ContainKey("add_hit_damage"))
			{
				if (env.ContainKey("level"))
				{
					int num2 = env.GetStruct<int>("level");
					num += num2 * env.GetStruct<int>("add_hit_damage");
				}
				else
				{
					num += env.GetStruct<int>("add_hit_damage");
				}
			}
			return num;
		}
	}

	public bool isIgnoreEnemyCollision
	{
		get
		{
			for (int i = 0; i < inheritedBuffList.Count; i++)
			{
				if (inheritedBuffList[i].ContainKey("ignore_enemy_collision"))
				{
					return inheritedBuffList[i].GetStruct<bool>("ignore_enemy_collision");
				}
			}
			return false;
		}
	}

	public Dictionary<int, int> SpeedChangeBuff
	{
		get
		{
			Dictionary<int, int> result = new Dictionary<int, int>();
			for (int i = 0; i < inheritedBuffList.Count; i++)
			{
				if (inheritedBuffList[i].ContainKey("speed_change_buff"))
				{
					result = inheritedBuffList[i].GetLinkedStruct<int, int>("speed_change_buff");
				}
			}
			return result;
		}
	}

	public EntityPhysicalBullet(int entityID, GameObject go, int atk, int lastCol, int buffID, BilliardGameEntityBase owner, int sourceBuffID)
		: base(entityID, go)
	{
		remainATK = atk;
		logic = base.go.GetComponent<BilliardGamePhysicalBullet>();
		this.lastCol = lastCol;
		this.buffID = buffID;
		this.sourceBuffID = sourceBuffID;
		this.owner = owner;
		if (buffID != 0)
		{
			env = BilliardGameSpellManager.Instance.CastBuff(this.buffID, this);
			if (owner is EntityEnemy)
			{
				env.AddPlayer("shootOwner", owner as EntityEnemy);
			}
			else if (owner is EntityPlayer)
			{
				env.AddPlayer("shootOwner", owner as EntityPlayer);
			}
			else if (owner is EntityMechanism)
			{
				env.AddPlayer("shootOwner", owner as EntityMechanism);
			}
		}
	}

	public override void Tick()
	{
		checkTime += Time.deltaTime;
		if (checkTime > 1f)
		{
			if (logic.CheckStop())
			{
				BeDestory();
			}
			checkTime = 0f;
		}
	}

	public bool CheckBuffDispose()
	{
		if (env != null && (!env.ContainKey("WaitForDispose") || !env.GetStruct<bool>("WaitForDispose")))
		{
			return !env.isRunning;
		}
		return true;
	}

	public void OnCollisionPot(BilliardGameEntityBase otherEntity)
	{
		if (!CheckBuffDispose() && env.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.OnTeammateCollision)
		{
			env.AddPlayer("TargetEntity", (BilliardGameEntityBase)(otherEntity as EntityMechanism), false);
			env.Run();
		}
	}

	public void OnCollisionEnemy(BilliardGameEntityBase otherEntity)
	{
		if (!(otherEntity is EntityEnemy { Dead: false } entityEnemy))
		{
			return;
		}
		for (int num = inheritedBuffList.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = inheritedBuffList[num];
			if (bTEnv.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.OnCollision)
			{
				bTEnv.AddPlayer("TargetEntity", (BilliardGameEntityBase)entityEnemy, false);
				bTEnv.Run();
			}
		}
		if (!CheckBuffDispose() && env.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.OnCollision)
		{
			env.AddPlayer("TargetEntity", (BilliardGameEntityBase)entityEnemy, false);
			env.Run();
		}
		if (owner is EntityPlayer)
		{
			(owner as EntityPlayer).OnPhysicalBulletCollsionEnemy(sourceBuffID, entityEnemy);
		}
	}

	public void OnPenetrate(BilliardGameEntityBase otherEntity)
	{
		if (!(otherEntity is EntityEnemy { Dead: false } entityEnemy))
		{
			return;
		}
		for (int num = inheritedBuffList.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = inheritedBuffList[num];
			if (bTEnv.GetStruct<BuffExecuteMode>("BuffExecuteMode") == BuffExecuteMode.OnPenetrate)
			{
				bTEnv.AddPlayer("TargetEntity", (BilliardGameEntityBase)entityEnemy, false);
				bTEnv.Run();
			}
		}
	}

	public void BeDestory()
	{
		if (dieAudio != null && dieAudio != "")
		{
			BilliardGameAudioManager.PlayAudioByName(dieAudio);
		}
		BilliardGameLogicManager.Instance.MakeEffectGo("JueSe/5_1/pinball_fade", base.go, 1f, delegate
		{
			base.go.SetActive(value: false);
			lastCol = 0;
			logic.ClearVelocity();
		});
	}

	public override void Dispose()
	{
		BilliardGameObjectPool.Instance.PushObject(base.go);
	}

	public void SetBoomEffect(string name)
	{
		effectName = name;
	}

	public void SetDieAudio(string name)
	{
		dieAudio = name;
	}

	public override BTEnv GetBuff(int buffID)
	{
		BTEnv bTEnv = inheritedBuffList.Find((BTEnv e) => e.ContainKey("BuffId") && e.GetStruct<int>("BuffId") == buffID);
		if (bTEnv == null)
		{
			return null;
		}
		return bTEnv;
	}

	public void SetInheritedBuff(List<BTEnv> buffList)
	{
		for (int num = inheritedBuffList.Count - 1; num >= 0; num--)
		{
			BTEnv bTEnv = inheritedBuffList[num];
			if ((bTEnv.ContainKey("WaitForDispose") && bTEnv.GetStruct<bool>("WaitForDispose")) || !bTEnv.isRunning)
			{
				inheritedBuffList.RemoveAt(num);
			}
		}
		foreach (BTEnv buff in buffList)
		{
			BTEnv bTEnv2 = BilliardGameSpellManager.Instance.CastBuff(buff.GetStruct<int>("BuffId"), this);
			if (bTEnv2 != null)
			{
				inheritedBuffList.Add(bTEnv2);
			}
		}
	}
}
