using GameFramework;
using UnityEngine;

namespace Ase;

public class MsgPlayerInput : IReference
{
	public Vector2 inputUV;

	public HeroSkillTypeEnum optionCode;

	public Vector2 skillJoyUv;

	public int SkillState;

	public int Tick;

	public bool AutoFight;

	public bool AutoUseProp;

	public int Actor { get; set; }

	public bool IsValid()
	{
		if (optionCode == HeroSkillTypeEnum.None && skillJoyUv == Vector2.zero && SkillState == 0)
		{
			return false;
		}
		return true;
	}

	public void Clear()
	{
		Tick = 0;
		Actor = 0;
		inputUV = Vector2.zero;
		skillJoyUv = Vector2.zero;
		optionCode = HeroSkillTypeEnum.None;
		SkillState = 0;
		AutoFight = false;
		AutoUseProp = false;
	}

	public void RefreshData(OneBattleFrameMessage oneBattleFrameMessage, int executeTick)
	{
		Actor = oneBattleFrameMessage.Actor;
		inputUV = oneBattleFrameMessage.inputUV.ToVector2();
		optionCode = (HeroSkillTypeEnum)oneBattleFrameMessage.optionCode;
		skillJoyUv = oneBattleFrameMessage.skillJoyUv.ToVector2();
		SkillState = oneBattleFrameMessage.SkillState;
		Tick = executeTick;
		AutoFight = oneBattleFrameMessage.AutoFight;
		AutoUseProp = oneBattleFrameMessage.AutoUseProp;
	}

	public void RefreshData(SingleBattleFrameMessage oneBattleFrameMessage, int executeTick)
	{
		if (oneBattleFrameMessage != null)
		{
			Actor = oneBattleFrameMessage.Actor;
			optionCode = (HeroSkillTypeEnum)oneBattleFrameMessage.optionCode;
			SkillState = oneBattleFrameMessage.SkillState;
			if (oneBattleFrameMessage.inputUV != null)
			{
				inputUV = oneBattleFrameMessage.inputUV.ToVector2();
			}
			if (oneBattleFrameMessage.skillJoyUv != null)
			{
				skillJoyUv = oneBattleFrameMessage.skillJoyUv.ToVector2();
			}
			AutoFight = oneBattleFrameMessage.AutoFight;
			AutoUseProp = oneBattleFrameMessage.AutoUseProp;
		}
		Tick = executeTick;
	}

	public void OnDispose()
	{
		ReferencePool.Release(this);
	}
}
