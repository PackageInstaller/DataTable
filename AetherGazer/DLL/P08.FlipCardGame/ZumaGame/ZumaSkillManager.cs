namespace ZumaGame;

public class ZumaSkillManager
{
	public SkillType useSkill;

	private int totalUseTimes;

	public int remainUseTimes;

	private int meetChargeValue;

	public int nowChargeValue;

	private int chargeNumsLimit = 3;

	public int chargeNums;

	private float duration;

	public float remainDuration;

	private bool noCountLimit;

	public void InitSkillType(SkillType skillType)
	{
		useSkill = skillType;
		InitSkillData(skillType);
	}

	private void InitSkillData(SkillType skillType)
	{
		if (useSkill != SkillType.Empty)
		{
			noCountLimit = false;
			totalUseTimes = ZumaGameManager.GetInstance().zumaEffectDataManager.GetSkillEffectValue(skillType, ZumaEffectType.SkillUseTimes) + ZumaGameManager.GetInstance().zumaEffectDataManager.GetSkillEffectValue(skillType, ZumaEffectType.SkillTimesAdd);
			if (ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectIsExist(ZumaEffectType.EndlessUseSkillInEndless) && ZumaGameManager.GetInstance().zumaEndlessManager.isEndless)
			{
				noCountLimit = true;
			}
			remainUseTimes = totalUseTimes;
			if (noCountLimit)
			{
				remainUseTimes = 99999;
			}
			meetChargeValue = ZumaGameManager.GetInstance().zumaEffectDataManager.GetSkillEffectValue(skillType, ZumaEffectType.SkillChargeBaseValue) - ZumaGameManager.GetInstance().zumaEffectDataManager.GetSkillEffectValue(skillType, ZumaEffectType.SkillChargeReduce);
			nowChargeValue = 0;
			chargeNums = ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectValue(ZumaEffectType.EndlessStartHaveChargeTimes);
			duration = ZumaGameManager.GetInstance().zumaEffectDataManager.GetSkillEffectValue(skillType, ZumaEffectType.SkillBaseDuration) + ZumaGameManager.GetInstance().zumaEffectDataManager.GetSkillEffectValue(skillType, ZumaEffectType.SkillDurationAdd);
			remainDuration = 0f;
			UpdateSkillUI();
		}
	}

	public bool CheckIsCanUseSkill()
	{
		if (!noCountLimit && remainUseTimes <= 0)
		{
			return false;
		}
		if (chargeNums <= 0)
		{
			return false;
		}
		if (CheckIsInSkill(useSkill))
		{
			return false;
		}
		if (useSkill == SkillType.StopMove && ZumaGameManager.GetInstance().zumaSpeicalEffectManager.GetTrackEffectValue(BallEffctType.STOP) > 0f)
		{
			return false;
		}
		return true;
	}

	public void SkillStart()
	{
		if (!ZumaGameManager.GetInstance().zumaGamePlay.IsGameTrackIsAllOver() && (noCountLimit || remainUseTimes > 0) && chargeNums > 0)
		{
			remainUseTimes--;
			chargeNums--;
			remainDuration = duration;
			if (useSkill == SkillType.ClearScreen)
			{
				int effectValue = ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectValue(ZumaEffectType.ClearScreenAgain);
				remainDuration = (float)effectValue + remainDuration;
			}
			if (useSkill == SkillType.StopMove || useSkill == SkillType.BulletShooterBall)
			{
				LuaHelper.CallFunction("ZumaToLuaBridge.ZumaSkillUseStateUpdate", true, (int)useSkill);
			}
			if (useSkill == SkillType.BulletShooterBall)
			{
				AudioManager.Instance.Play("effect", "minigame_activity_3_11", "minigame_activity_3_11_zuma_skill01", useStream: false);
			}
			else if (useSkill == SkillType.StopMove)
			{
				AudioManager.Instance.Play("effect", "minigame_activity_3_0", "minigame_activity_3_0_zuma_time_start", useStream: false);
			}
			UpdateSkillUI();
		}
	}

	public void UpdateSkillTimes(float times)
	{
		float num = remainDuration;
		remainDuration -= times;
		if (num > 0f && remainDuration <= 0f && (useSkill == SkillType.StopMove || useSkill == SkillType.BulletShooterBall))
		{
			LuaHelper.CallFunction("ZumaToLuaBridge.ZumaSkillUseStateUpdate", false, (int)useSkill);
		}
		if (remainDuration < 0f)
		{
			remainDuration = 0f;
		}
	}

	public SkillType GetUseSkillID()
	{
		return useSkill;
	}

	public void UpdateSkillChargeValue(int value)
	{
		if (remainUseTimes <= 0 || chargeNums >= chargeNumsLimit || CheckIsInSkill(useSkill))
		{
			return;
		}
		nowChargeValue += value;
		if (nowChargeValue >= meetChargeValue)
		{
			nowChargeValue -= meetChargeValue;
			chargeNums++;
			if (chargeNums >= chargeNumsLimit)
			{
				nowChargeValue = 0;
			}
		}
		UpdateSkillUI();
	}

	public bool CheckIsInSkill(SkillType skillType)
	{
		if (useSkill != skillType)
		{
			return false;
		}
		if (remainDuration <= 0f)
		{
			return false;
		}
		return true;
	}

	public bool CheckIsMeetSkillEffect(SkillType skillType, ZumaEffectType effectType)
	{
		if (CheckIsInSkill(skillType))
		{
			return ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectIsExist(effectType);
		}
		return false;
	}

	public float GetRemainDuration()
	{
		return remainDuration;
	}

	public float GetRemainProgress()
	{
		return remainDuration / duration;
	}

	private void UpdateSkillUI()
	{
		LuaHelper.CallFunction("ZumaToLuaBridge.ZumaSkillUpdate", remainUseTimes, chargeNums, (float)nowChargeValue / (float)meetChargeValue, totalUseTimes - remainUseTimes);
	}
}
