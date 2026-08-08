public class CDProcessor
{
	public static SimContext mSimContext;

	internal static void Initialize(SimContext simContext)
	{
		mSimContext = simContext;
	}

	internal static void Shutdown()
	{
		mSimContext = null;
	}

	public static bool GetMaxCDAndMaxUseCount(SimEntity simEntity, int abilityID, out int maxCD, out int maxUseCount)
	{
		maxCD = 0;
		maxUseCount = 0;
		if (!ConfigProcessor.TryGetCDConfig(simEntity, abilityID, out var cd, out var maxUseCount2))
		{
			return false;
		}
		if (!simEntity.entityCD.mAbilityMaxCD.TryGetValue(abilityID, out var value))
		{
			maxCD = cd;
		}
		else
		{
			maxCD = (value.baseValue + value.deltaValue) * (1000 + value.deltaPercent) / 1000;
		}
		if (!simEntity.entityCD.mAbilityMaxUse.TryGetValue(abilityID, out maxUseCount))
		{
			maxUseCount = maxUseCount2;
		}
		return true;
	}

	public static void SetMaxUse(SimEntity simEntity, int abilityID, int maxUse)
	{
		if (simEntity.hasEntityCD)
		{
			simEntity.entityCD.mAbilityMaxUse[abilityID] = maxUse;
		}
	}

	public static bool InCD(SimEntity simEntity, int abilityID)
	{
		if (!simEntity.hasEntityCD)
		{
			return false;
		}
		if (!GetMaxCDAndMaxUseCount(simEntity, abilityID, out var _, out var maxUseCount))
		{
			return false;
		}
		if (GetCD(simEntity, abilityID, out var abilityCD))
		{
			return maxUseCount <= abilityCD.UsedCount;
		}
		return false;
	}

	public static bool HasAward(SimEntity simEntity, int abilityID)
	{
		if (simEntity.hasEntityCD)
		{
			return simEntity.entityCD.mAward.Contains(abilityID);
		}
		return false;
	}

	public static void SetAward(SimEntity simEntity, int abilityID, bool isAward)
	{
		if (simEntity.hasEntityCD)
		{
			if (isAward)
			{
				simEntity.entityCD.mAward.Add(abilityID);
			}
			else
			{
				simEntity.entityCD.mAward.Remove(abilityID);
			}
		}
	}

	public static bool IsIgnore(SimEntity simEntity, int abilityID)
	{
		if (simEntity.hasEntityCD)
		{
			return simEntity.entityCD.mIgnore.Contains(abilityID);
		}
		return false;
	}

	public static void SetIgnore(SimEntity simEntity, int abilityID, bool isIgnore)
	{
		if (simEntity.hasEntityCD)
		{
			if (isIgnore)
			{
				simEntity.entityCD.mIgnore.Add(abilityID);
			}
			else
			{
				simEntity.entityCD.mIgnore.Remove(abilityID);
			}
		}
	}

	public static void UpdateCD(SimEntity simEntity)
	{
		for (int num = simEntity.entityCD.mAbilityCD.Count - 1; num >= 0; num--)
		{
			AbilityCD abilityCD = simEntity.entityCD.mAbilityCD[num];
			if (!abilityCD.IsPause)
			{
				if (abilityCD.UsedCount <= 0)
				{
					simEntity.entityCD.mAbilityCD.RemoveAt(num);
				}
				else
				{
					abilityCD.CD -= mSimContext.simStatus.runtimeSetting.kSimTickPeriodMS;
					if (abilityCD.CD <= 0)
					{
						abilityCD.UsedCount--;
						if (abilityCD.UsedCount > 0 && GetMaxCDAndMaxUseCount(simEntity, abilityCD.AbilityID, out var maxCD, out var _))
						{
							abilityCD.CD = maxCD;
							simEntity.entityCD.mAbilityCD[num] = abilityCD;
						}
						else
						{
							simEntity.entityCD.mAbilityCD.RemoveAt(num);
						}
						mSimContext.GetSimInterface().mCDEndEvent?.Invoke(simEntity.creationIndex, abilityCD);
					}
					else
					{
						simEntity.entityCD.mAbilityCD[num] = abilityCD;
					}
				}
			}
		}
	}

	public static void AddCD(SimEntity simEntity, int mAbilityID)
	{
		if (HasAward(simEntity, mAbilityID) || !GetMaxCDAndMaxUseCount(simEntity, mAbilityID, out var maxCD, out var _))
		{
			return;
		}
		if (maxCD < 0)
		{
			maxCD = 0;
		}
		bool flag = true;
		bool flag2 = IsIgnore(simEntity, mAbilityID);
		for (int i = 0; i < simEntity.entityCD.mAbilityCD.Count; i++)
		{
			if (mAbilityID == simEntity.entityCD.mAbilityCD[i].AbilityID)
			{
				AbilityCD value = simEntity.entityCD.mAbilityCD[i];
				if (flag2)
				{
					value.CD += maxCD;
					value.MaxCD = maxCD;
				}
				else
				{
					value.UsedCount++;
					value.MaxCD = maxCD;
				}
				simEntity.entityCD.mAbilityCD[i] = value;
				flag = false;
				break;
			}
		}
		if (flag)
		{
			simEntity.entityCD.mAbilityCD.Add(new AbilityCD
			{
				AbilityID = mAbilityID,
				CD = maxCD,
				MaxCD = maxCD,
				UsedCount = 1,
				IsPause = false
			});
		}
	}

	public static void RemoveCD(SimEntity simEntity, int abilityID)
	{
		for (int i = 0; i < simEntity.entityCD.mAbilityCD.Count; i++)
		{
			if (simEntity.entityCD.mAbilityCD[i].AbilityID == abilityID)
			{
				simEntity.entityCD.mAbilityCD.RemoveAt(i);
				break;
			}
		}
	}

	public static void SetCD(SimEntity simEntity, int abilityID, int cd, int usedCount)
	{
		if (cd < 0)
		{
			cd = 0;
		}
		for (int i = 0; i < simEntity.entityCD.mAbilityCD.Count; i++)
		{
			if (simEntity.entityCD.mAbilityCD[i].AbilityID == abilityID)
			{
				AbilityCD value = simEntity.entityCD.mAbilityCD[i];
				value.CD = cd;
				value.UsedCount = usedCount;
				simEntity.entityCD.mAbilityCD[i] = value;
				break;
			}
		}
	}

	internal static void ProcessCDReturn(SimEntity simEntity, int mAbilityID, int returnValue)
	{
		int num = -1;
		for (int i = 0; i < simEntity.entityCD.mAbilityCD.Count; i++)
		{
			if (simEntity.entityCD.mAbilityCD[i].AbilityID == mAbilityID)
			{
				num = i;
				break;
			}
		}
		if (num < 0)
		{
			return;
		}
		AbilityCD value = simEntity.entityCD.mAbilityCD[num];
		GetMaxCDAndMaxUseCount(simEntity, mAbilityID, out var maxCD, out var maxUseCount);
		int num2 = IntMath.Divide(value.MaxCD * returnValue, 100);
		if (maxUseCount > 1)
		{
			if (value.CD > num2)
			{
				value.CD -= num2;
			}
			else
			{
				if (maxCD > num2)
				{
					value.CD += maxCD - num2;
				}
				value.UsedCount--;
			}
		}
		else
		{
			value.CD -= num2;
			value.CD = ((value.CD >= 0) ? value.CD : 0);
		}
		simEntity.entityCD.mAbilityCD[num] = value;
	}

	public static void ShareCD(SimEntity simEntity, int abilityID, int shareAbilityID)
	{
		GetCD(simEntity, abilityID, out var abilityCD);
		abilityCD.AbilityID = shareAbilityID;
		for (int i = 0; i < simEntity.entityCD.mAbilityCD.Count; i++)
		{
			if (simEntity.entityCD.mAbilityCD[i].AbilityID == shareAbilityID)
			{
				simEntity.entityCD.mAbilityCD[i] = abilityCD;
				return;
			}
		}
		simEntity.entityCD.mAbilityCD.Add(abilityCD);
	}

	public static bool GetCD(SimEntity simEntity, int abilityID, out AbilityCD abilityCD)
	{
		for (int i = 0; i < simEntity.entityCD.mAbilityCD.Count; i++)
		{
			if (simEntity.entityCD.mAbilityCD[i].AbilityID == abilityID)
			{
				abilityCD = simEntity.entityCD.mAbilityCD[i];
				return true;
			}
		}
		abilityCD = default(AbilityCD);
		return false;
	}

	public static void SetPauseCD(SimEntity simEntity, int abilityID, bool isPause)
	{
		for (int i = 0; i < simEntity.entityCD.mAbilityCD.Count; i++)
		{
			if (simEntity.entityCD.mAbilityCD[i].AbilityID == abilityID)
			{
				AbilityCD value = simEntity.entityCD.mAbilityCD[i];
				value.IsPause = isPause;
				simEntity.entityCD.mAbilityCD[i] = value;
				break;
			}
		}
	}

	public static void CleanCDList(SimEntity simEntity)
	{
		if (simEntity.hasEntityCD)
		{
			for (int i = 0; i < simEntity.entityCD.mAbilityCD.Count; i++)
			{
				SetCD(simEntity, simEntity.entityCD.mAbilityCD[i].AbilityID, 0, simEntity.entityCD.mAbilityCD[i].UsedCount);
			}
		}
	}

	public static void CleanAllCD(SimEntity simEntity)
	{
		if (simEntity.hasEntityCD)
		{
			simEntity.entityCD.Reset(simEntity);
		}
	}

	public static int CheckAbilityIsAvoid(int abilityID)
	{
		if (ConfigProcessor.IsAvoid(abilityID))
		{
			return ConfigProcessor.GetAvaoidCommonID(abilityID);
		}
		return abilityID;
	}

	public static int GetSourceSpaceAvoidCD()
	{
		if (mSimContext == null)
		{
			return 0;
		}
		SimEntity entitySourceSpaceEntity = mSimContext.entitySourceSpaceEntity;
		if (entitySourceSpaceEntity == null)
		{
			return 0;
		}
		return mSimContext.entitySourceSpace?.LimitDodgeCD ?? 0;
	}
}
