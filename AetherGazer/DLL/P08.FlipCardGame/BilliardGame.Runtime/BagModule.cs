using BilliardGame.Spell;
using UnityEngine;

namespace BilliardGame.Runtime;

public class BagModule : IMechanismTrigger
{
	private EntityMechanism mech;

	private BTEnv env;

	private BilliardGameEffect effect;

	private Collider2D col;

	public BagModule(int buffId, EntityMechanism m)
	{
		mech = m;
		env = BilliardGameSpellManager.Instance.CastBuff(buffId, mech);
		col = mech.go.GetComponent<Collider2D>();
	}

	public void BeCollision(BilliardGameEntityBase other)
	{
		if (other is EntityPlayer)
		{
			env.AddPlayer("TargetEntity", (BilliardGameEntityBase)(other as EntityPlayer), false);
			env.Run();
			BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_portal");
			mech.Dead = true;
			mech.go.SetActive(value: false);
		}
	}

	public void OnRoundStart()
	{
		if (null != effect)
		{
			effect.Die();
		}
		col.isTrigger = true;
	}
}
