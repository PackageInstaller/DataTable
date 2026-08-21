using BilliardGame.Spell;

namespace BilliardGame.Runtime;

public class SpeedBumpModule : IMechanismTrigger
{
	private EntityMechanism mech;

	private BTEnv env;

	private int buffID;

	private int nowInvokeNum;

	private int createRound;

	private int totalInvokeNum;

	private int maxRound;

	private BilliardGameEffect effect;

	public SpeedBumpModule(int buffID, EntityMechanism m, int totalInvokeNum, int maxRound)
	{
		mech = m;
		this.buffID = buffID;
		this.totalInvokeNum = totalInvokeNum;
		this.maxRound = maxRound;
		createRound = BilliardGameLogicManager.Instance.CurRound;
		env = BilliardGameSpellManager.Instance.CastBuff(this.buffID, mech);
	}

	public void BeCollision(BilliardGameEntityBase other)
	{
		if (other is EntityPlayer)
		{
			env.AddPlayer("TargetEntity", other);
			env.Run();
			nowInvokeNum++;
			if (nowInvokeNum >= totalInvokeNum)
			{
				mech.Dead = true;
				mech.go.SetActive(value: false);
				effect = BilliardGameLogicManager.Instance.MakeEffectWorld("GuaiWu/5_1/monster_slow_end", mech.position, 1f);
			}
		}
	}

	public void OnRoundStart()
	{
		if (BilliardGameLogicManager.Instance.CurRound - createRound >= maxRound)
		{
			mech.Dead = true;
			mech.go.SetActive(value: false);
			effect = BilliardGameLogicManager.Instance.MakeEffectWorld("GuaiWu/5_1/monster_slow_end", mech.position, 1f);
		}
	}
}
