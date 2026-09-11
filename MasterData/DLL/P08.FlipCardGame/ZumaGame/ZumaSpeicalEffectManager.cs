using System.Collections.Generic;

namespace ZumaGame;

public class ZumaSpeicalEffectManager
{
	public float stopDuration;

	public float aimDuration;

	public Dictionary<int, float> backProgress = new Dictionary<int, float>();

	public float oneStopDuration = 5f;

	public float oneAimDuration = 5f;

	public float oneBackProgress = 10f;

	public float aimAddShootSpeed = 5f;

	public float backBallSpeed = 10f;

	public void InitEffectValue()
	{
		stopDuration = 0f;
		aimDuration = 0f;
		backProgress.Clear();
		float num = ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectFloatValue(ZumaEffectType.StopBallEffectUp) + (float)ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectValue(ZumaEffectType.EndlessMapEffectC) / 100f;
		oneStopDuration = 5f * (1f + num);
		oneAimDuration = 5f * (1f + ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectFloatValue(ZumaEffectType.AimBallEffectUp));
		float num2 = ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectFloatValue(ZumaEffectType.BackBallEffectUp) + (float)ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectValue(ZumaEffectType.EndlessMapEffectD) / 100f;
		oneBackProgress = 10f * (1f + num2);
		aimAddShootSpeed = 5f;
		backBallSpeed = 10f;
	}

	public void StrikeBallEffect(BallEffctType effectType, int trackID)
	{
		switch (effectType)
		{
		case BallEffctType.BACK:
			ZumaAudioManager.Instance.PlayZumaAudio(ZumaAudioEnum.BackBegin);
			UpdateBackProgressValue(trackID, oneBackProgress);
			break;
		case BallEffctType.AIM:
			ZumaAudioManager.Instance.PlayZumaAudio(ZumaAudioEnum.AimBall);
			aimDuration += oneAimDuration;
			break;
		case BallEffctType.STOP:
			if (!ZumaGameManager.GetInstance().zumaSkillManager.CheckIsInSkill(SkillType.StopMove))
			{
				if (stopDuration <= 0f)
				{
					ZumaAudioManager.Instance.PlayZumaAudio(ZumaAudioEnum.StopBegin);
				}
				stopDuration += oneStopDuration;
				LuaHelper.CallFunction("ZumaToLuaBridge.ZumaStop", true);
			}
			break;
		}
	}

	private void UpdateBackProgressValue(int trackID, float value)
	{
		if (!backProgress.ContainsKey(trackID))
		{
			backProgress[trackID] = 0f;
		}
		backProgress[trackID] += value;
	}

	public void StrikeComboEffect(int commboLv, int trackID)
	{
		float value = ZumaGameConst.CountComboBackPower(commboLv);
		UpdateBackProgressValue(trackID, value);
	}

	public float GetBackProgressMaxValue()
	{
		float num = 0f;
		foreach (float value in backProgress.Values)
		{
			if (value > num)
			{
				num = value;
			}
		}
		return num;
	}

	public void UpdateStrikeEffectValue(BallEffctType effectType, float changeValue, int trackID)
	{
		switch (effectType)
		{
		case BallEffctType.BACK:
			UpdateBackProgressValue(trackID, 0f - changeValue);
			if (backProgress[trackID] < 0f)
			{
				backProgress[trackID] = 0f;
			}
			break;
		case BallEffctType.AIM:
			aimDuration -= changeValue;
			if (aimDuration < 0f)
			{
				aimDuration = 0f;
			}
			break;
		case BallEffctType.STOP:
		{
			float num = stopDuration;
			stopDuration -= changeValue;
			if (stopDuration < 0f)
			{
				stopDuration = 0f;
				if (num > 0f)
				{
					LuaHelper.CallFunction("ZumaToLuaBridge.ZumaStop", false);
				}
			}
			break;
		}
		}
	}

	public float GetTrackEffectValue(BallEffctType effectType, int trackID = -1)
	{
		switch (effectType)
		{
		case BallEffctType.BACK:
			if (backProgress.ContainsKey(trackID))
			{
				return backProgress[trackID];
			}
			return 0f;
		case BallEffctType.AIM:
			return aimDuration;
		case BallEffctType.STOP:
			return stopDuration;
		default:
			return 0f;
		}
	}

	public bool IsMeetTrackEffect(BallEffctType effectType, int trackID)
	{
		if (GetTrackEffectValue(effectType, trackID) > 0f)
		{
			return true;
		}
		return false;
	}

	public float GetStrikeEffectValueSpeed(BallEffctType effectType)
	{
		switch (effectType)
		{
		case BallEffctType.BACK:
			return backBallSpeed;
		case BallEffctType.AIM:
			return aimAddShootSpeed;
		default:
			_ = 3;
			return 0f;
		}
	}
}
