_class("UIN29ShopData", CampaignDataBase)
UIN29ShopData = UIN29ShopData

function UIN29ShopData:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.componentIdLottery = ECampaignN29ComponentID.ECAMPAIGN_N29_LOTTERY
  self:Init()
end

function UIN29ShopData:Init()
end

function UIN29ShopData.CheckCode(res)
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

function UIN29ShopData:CheckRedShop()
  local state = self:GetStateShop()
  if state == UISummerOneEnterBtnState.Normal then
    local lp = self:GetLocalProcess()
    local redFixTeam = self.mCampaign:CheckComponentRed(lp, self.componentIdLottery)
    return redFixTeam
  end
  return false
end

function UIN29ShopData:GetComponentShop()
  local c = self.activityCampaign:GetComponent(self.componentIdLottery)
  return c
end

function UIN29ShopData:GetComponentInfoShop()
  local cInfo = self.activityCampaign:GetComponentInfo(self.componentIdLottery)
  return cInfo
end

function UIN29ShopData:GetState(cInfo)
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

function UIN29ShopData:GetStateShop()
  local c = self.activityCampaign:GetComponentInfo(self.componentIdLottery)
  if c then
    return self:GetState(c)
  end
end

function UIN29ShopData:GetPools()
  local cInfoLottery = self:GetComponentInfoShop()
  return cInfoLottery.m_jackpots
end

function UIN29ShopData:GetPoolAwards(index)
  local pools = self:GetPools()
  local awards = pools[index]
  return awards
end

function UIN29ShopData:IsPoolUnlock(index)
  local cLottery = self:GetComponentShop()
  if cLottery then
    return cLottery:IsLotteryJackpotUnlock(index)
  end
  return false
end

function UIN29ShopData:IsPoolEmpty(index)
  local cLottery = self:GetComponentShop()
  if cLottery then
    return cLottery:IsLotteryJeckpotEmpty(index)
  end
  return false
end

function UIN29ShopData:GetPoolLeftDrawCount(index)
  local canDrawCardCount = 0
  local awards = self:GetPoolAwards(index)
  for index, award in ipairs(awards) do
    if award.m_lottery_count and 0 < award.m_lottery_count then
      canDrawCardCount = canDrawCardCount + award.m_lottery_count
    end
  end
  return canDrawCardCount, canDrawCardCount <= 0
end

function UIN29ShopData:GetCostCount()
  local cInfoLottery = self:GetComponentInfoShop()
  local totalNum = ClientCampaignDrawShop.GetMoney(cInfoLottery.m_cost_item_id)
  return totalNum
end

function UIN29ShopData:IsCostEnough(drawCount)
  local totalNum = self:GetCostCount()
  local cInfoLottery = self:GetComponentInfoShop()
  local isEnough = totalNum >= cInfoLottery.m_cost_count * drawCount
  return isEnough
end

function UIN29ShopData:GotAllBigAward()
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

function UIN29ShopData.GetPstId()
  local mRole = GameGlobal.GetModule(RoleModule)
  return mRole:GetPstId()
end

function UIN29ShopData.GetPrefsKey(str)
  local playerPrefsKey = UIN29ShopData.GetPstId() .. str
  return playerPrefsKey
end

function UIN29ShopData.GetPrefsKeyMain()
  return UIN29ShopData.GetPrefsKey("UIN23DataPrefsKeyMain")
end

function UIN29ShopData.GetPrefsKeyShop()
  return UIN29ShopData.GetPrefsKey("UIN23DataPrefsKeyShop")
end

function UIN29ShopData.HasPrefsMain()
  return UnityEngine.PlayerPrefs.HasKey(UIN29ShopData.GetPrefsKeyMain())
end

function UIN29ShopData.SetPrefsMain()
  UnityEngine.PlayerPrefs.SetInt(UIN29ShopData.GetPrefsKeyMain(), 1)
end

function UIN29ShopData.HasPrefsShop()
  return UnityEngine.PlayerPrefs.HasKey(UIN29ShopData.GetPrefsKeyShop())
end

function UIN29ShopData.SetPrefsShop()
  UnityEngine.PlayerPrefs.SetInt(UIN29ShopData.GetPrefsKeyShop(), 1)
end
