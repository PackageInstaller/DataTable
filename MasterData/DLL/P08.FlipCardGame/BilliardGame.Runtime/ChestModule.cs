using BilliardGame.Spell;

namespace BilliardGame.Runtime;

public class ChestModule : IMechanismTrigger
{
	public enum ChestType
	{
		Skill = 40320011,
		Shield,
		Speed,
		Attack
	}

	private EntityMechanism mech;

	private BTEnv env;

	private int buffID;

	private ChestType chestType;

	protected int lastCol;

	protected bool isOpen;

	private string GetColor()
	{
		return chestType switch
		{
			ChestType.Skill => "tong", 
			ChestType.Shield => "lan", 
			ChestType.Speed => "zi", 
			ChestType.Attack => "hong", 
			_ => "tong", 
		};
	}

	public ChestModule(int buffID, EntityMechanism m, int chestType, int colNum)
	{
		mech = m;
		this.buffID = buffID;
		this.chestType = (ChestType)chestType;
		env = BilliardGameSpellManager.Instance.CastBuff(this.buffID, mech);
		env.AddStruct("chest_type", chestType);
		lastCol = colNum;
		isOpen = false;
		mech.logic.ChangeAniState(GetColor() + "_close", isLoop: true);
	}

	public void BeCollision(BilliardGameEntityBase other)
	{
		if (isOpen)
		{
			return;
		}
		lastCol--;
		if (lastCol <= 0)
		{
			BilliardGameAudioManager.PlayAudioByName("minigame_activity_4_3_marble_box");
			env.AddPlayer("TargetEntity", (BilliardGameEntityBase)(other as EntityPlayer), false);
			isOpen = true;
			mech.logic.ChangeAniState(GetColor() + "_open", isLoop: false);
			mech.logic.AddAniState(GetColor() + "_empty", isLoop: true, delegate
			{
				mech.Dead = true;
				mech.go.SetActive(value: false);
			});
			env.Run();
			env.Dispose();
			BilliardGameLogicManager.Instance.MakeEffectGo("JiGuan/nya_pinball_jiguan_baoxiang_dakai_" + GetColor(), mech.go, 1f);
		}
	}

	public void OnRoundStart()
	{
	}
}
