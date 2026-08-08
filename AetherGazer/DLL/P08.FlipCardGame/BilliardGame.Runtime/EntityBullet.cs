using BilliardGame.Spell;
using UnityEngine;

namespace BilliardGame.Runtime;

public class EntityBullet : BilliardGameEntityBase
{
	private float saveTime;

	public BilliardGameEntityBase owner;

	protected int remainATK;

	protected BilliardGameBullet logic;

	protected int lastCol;

	protected int buffID;

	protected BTEnv env;

	protected string effectName;

	protected string dieAudio;

	public bool canColWall;

	public int ATK => remainATK;

	public bool Dead => lastCol <= 0;

	public EntityBullet(int entityID, GameObject go, int atk, int lastCol, int buffID, BilliardGameEntityBase owner, bool canColWall)
		: base(entityID, go)
	{
		saveTime = 0f;
		remainATK = atk;
		logic = base.go.GetComponent<BilliardGameBullet>();
		this.lastCol = lastCol;
		this.buffID = buffID;
		this.owner = owner;
		this.canColWall = canColWall;
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
		saveTime += Time.deltaTime;
		if (saveTime > 7f)
		{
			BeDestory();
		}
	}

	public void OnCollision(BilliardGameEntityBase otherEntity)
	{
		lastCol--;
		if (effectName != null && effectName != "")
		{
			BilliardGameLogicManager.Instance.MakeEffectWorld(effectName, base.position, 1f);
		}
		if (buffID != 0)
		{
			if (otherEntity != null)
			{
				if (owner is EntityEnemy && otherEntity is EntityPlayer)
				{
					env.AddPlayer("TargetEntity", (BilliardGameEntityBase)(otherEntity as EntityPlayer), false);
					env.Run();
				}
				if (owner is EntityEnemy && otherEntity is EntityMechanism)
				{
					env.AddPlayer("TargetEntity", (BilliardGameEntityBase)(otherEntity as EntityMechanism), false);
					env.Run();
				}
				if ((owner is EntityPlayer || owner is EntityMechanism) && otherEntity is EntityEnemy)
				{
					env.AddPlayer("TargetEntity", (BilliardGameEntityBase)(otherEntity as EntityEnemy), false);
					env.Run();
				}
			}
			else
			{
				env.Run();
			}
		}
		if (lastCol <= 0)
		{
			BeDestory();
		}
	}

	public void BeDestory()
	{
		if (dieAudio != null && dieAudio != "")
		{
			BilliardGameAudioManager.PlayAudioByName(dieAudio);
		}
		base.go.SetActive(value: false);
		lastCol = 0;
		logic.ClearVelocity();
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
}
