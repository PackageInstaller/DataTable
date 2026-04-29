_class("N24Data", CampaignDataBase)
N24Data = N24Data

function N24Data:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.componentIdLottery = ECampaignN24ComponentID.ECAMPAIGN_N24_LOTTERY
  self:Init()
end

function N24Data:Init()
end

function N24Data.CheckCode(res)
  local result = res:GetResult()
  if result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    return true
  end
  local msg = StringTable.Get("str_activity_error_" .. result)
  ToastManager.ShowToast(msg)
  if result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED or result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  end
  return false
end

function N24Data:CheckRedShop()
  local state = self:GetStateShop()
  if state == UISummerOneEnterBtnState.Normal then
    local lp = self:GetLocalProcess()
    local redFixTeam = self.mCampaign:CheckComponentRed(lp, self.componentIdLottery)
    return redFixTeam
  end
  return false
end

function N24Data:GetComponentShop()
  local c = self.activityCampaign:GetComponent(self.componentIdLottery)
  return c
end

function N24Data:GetComponentInfoShop()
  local cInfo = self.activityCampaign:GetComponentInfo(self.componentIdLottery)
  return cInfo
end

function N24Data:GetState(cInfo)
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  if nowTimestamp < cInfo.m_unlock_time then
    return UISummerOneEnterBtnState.NotOpen
  elseif nowTimestamp > cInfo.m_close_time then
    return UISummerOneEnterBtnState.Closed
  elseif cInfo.m_b_unlock then
    return UISummerOneEnterBtnState.Normal
  else
    local cfgv = Cfg.cfg_campaign_mission[cInfo.m_need_mission_id]
    if cfgv then
      return UISummerOneEnterBtnState.Locked
    else
      return UISummerOneEnterBtnState.Normal
    end
  end
end

function N24Data:GetStateShop()
  local c = self.activityCampaign:GetComponentInfo(self.componentIdLottery)
  if c then
    return self:GetState(c)
  end
end

function N24Data:GetPools()
  local cInfoLottery = self:GetComponentInfoShop()
  return cInfoLottery.m_jackpots
end

function N24Data:GetPoolAwards(index)
  local pools = self:GetPools()
  local awards = pools[index]
  return awards
end

function N24Data:IsPoolUnlock(index)
  local cLottery = self:GetComponentShop()
  if cLottery then
    return cLottery:IsLotteryJackpotUnlock(index)
  end
  return false
end

function N24Data:IsPoolEmpty(index)
  local cLottery = self:GetComponentShop()
  if cLottery then
    return cLottery:IsLotteryJeckpotEmpty(index)
  end
  return false
end

function N24Data:GetPoolLeftDrawCount(index)
  local canDrawCardCount = 0
  local awards = self:GetPoolAwards(index)
  for index, award in ipairs(awards) do
    if award.m_lottery_count and 0 < award.m_lottery_count then
      canDrawCardCount = canDrawCardCount + award.m_lottery_count
    end
  end
  return canDrawCardCount, canDrawCardCount <= 0
end

function N24Data:GetCostCount()
  local cInfoLottery = self:GetComponentInfoShop()
  local totalNum = ClientCampaignDrawShop.GetMoney(cInfoLottery.m_cost_item_id)
  return totalNum
end

function N24Data:IsCostEnough(drawCount)
  local totalNum = self:GetCostCount()
  local cInfoLottery = self:GetComponentInfoShop()
  local isEnough = totalNum >= cInfoLottery.m_cost_count * drawCount
  return isEnough
end

function N24Data:GotAllBigAward()
  local pools = self:GetPools()
  for key, pool in pairs(pools) do
    for key, award in pairs(pool) do
      if award.m_is_big_reward and award.m_lottery_count > 0 then
        return false
      end
    end
  end
  return true
end

function N24Data.GetPstId()
  local mRole = GameGlobal.GetModule(RoleModule)
  return mRole:GetPstId()
end

function N24Data.GetPrefsKey(str)
  local playerPrefsKey = N24Data.GetPstId() .. str
  return playerPrefsKey
end

function N24Data.GetPrefsKeyMain()
  return N24Data.GetPrefsKey("UIN23DataPrefsKeyMain")
end

function N24Data.GetPrefsKeyShop()
  return N24Data.GetPrefsKey("UIN23DataPrefsKeyShop")
end

function N24Data.HasPrefsMain()
  return UnityEngine.PlayerPrefs.HasKey(N24Data.GetPrefsKeyMain())
end

function N24Data.SetPrefsMain()
  UnityEngine.PlayerPrefs.SetInt(N24Data.GetPrefsKeyMain(), 1)
end

function N24Data.HasPrefsShop()
  return UnityEngine.PlayerPrefs.HasKey(N24Data.GetPrefsKeyShop())
end

function N24Data.SetPrefsShop()
  UnityEngine.PlayerPrefs.SetInt(N24Data.GetPrefsKeyShop(), 1)
end
