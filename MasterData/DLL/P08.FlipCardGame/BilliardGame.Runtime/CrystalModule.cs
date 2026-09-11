using BilliardGame.Spell;

namespace BilliardGame.Runtime;

public class CrystalModule : IMechanismTrigger
{
	private EntityMechanism mech;

	private BTEnv env;

	private int maxCount;

	private int lastCount;

	private int buffID;

	public CrystalModule(int buffID, EntityMechanism m, int maxCount)
	{
		mech = m;
		this.maxCount = maxCount;
		lastCount = maxCount;
		this.buffID = buffID;
		env = BilliardGameSpellManager.Instance.CastBuff(this.buffID, mech);
	}

	public void BeCollision(BilliardGameEntityBase other)
	{
		env.AddPlayer("TargetEntity", (BilliardGameEntityBase)(other as EntityPlayer), false);
		env.Run();
		lastCount--;
		if (lastCount <= 0)
		{
			BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_break");
			mech.go.SetActive(value: false);
		}
	}

	public void OnRoundStart()
	{
		lastCount = maxCount;
		mech.go.SetActive(value: true);
	}
}
