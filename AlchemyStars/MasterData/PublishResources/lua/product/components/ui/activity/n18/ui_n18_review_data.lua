_class("N18ReviewData", CampaignDataBase)
N18ReviewData = N18ReviewData

function N18ReviewData:Constructor()
  self._redDotModule = GameGlobal.GetModule(RedDotModule)
end

function N18ReviewData:CheckRedLevelFixteam()
  return nil
end

function N18ReviewData:CheckRedNormal()
  local red_level = self.activityCampaign:CheckComponentRed(ECampaignReviewN18ComponentID.ECAMPAIGN_REVIEW_ReviewN18_LINE_MISSION)
  return red_level
end

function N18ReviewData:GetComponentInfoNormal()
  local cInfo = self.activityCampaign:GetComponentInfo(ECampaignReviewN18ComponentID.ECAMPAIGN_REVIEW_ReviewN18_LINE_MISSION)
  return cInfo
end

function N18ReviewData:GetState(cInfo)
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  if nowTimestamp < cInfo.m_unlock_time then
    return UIN18BtnState.NotOpen
  elseif nowTimestamp > cInfo.m_close_time then
    return UIN18BtnState.Closed
  elseif cInfo.m_b_unlock then
    return UIN18BtnState.Normal
  else
    local cfgv = Cfg.cfg_campaign_mission[cInfo.m_need_mission_id]
    if cfgv then
      return UIN18BtnState.Locked
    else
      return UIN18BtnState.Normal
    end
  end
end

function N18ReviewData:GetStateNormal()
  local cInfo = self:GetComponentInfoNormal()
  if not cInfo then
    Log.fatal("### GetComponentHard failed.")
    return
  end
  return self:GetState(cInfo)
end

function N18ReviewData.GetPstId()
  local mRole = GameGlobal.GetModule(RoleModule)
  return mRole:GetPstId()
end

function N18ReviewData.GetPrefsKey(str)
  local playerPrefsKey = N18ReviewData.GetPstId() .. str
  return playerPrefsKey
end

function N18ReviewData.GetPrefsKeyMain()
  return N18ReviewData.GetPrefsKey("UIN18ReviewDataPrefsKeyMain")
end

function N18ReviewData.GetPrefsKeyHard()
  return N18ReviewData.GetPrefsKey("UIN18ReviewDataPrefsKeyHard")
end

function N18ReviewData.GetPrefsKeyMiniGame()
  return N18ReviewData.GetPrefsKey("UIN18ReviewDataPrefsKeyMiniGame")
end

function N18ReviewData.HasPrefsMain()
  return UnityEngine.PlayerPrefs.HasKey(N18ReviewData.GetPrefsKeyMain())
end

function N18ReviewData.HasPrefsHard()
  return UnityEngine.PlayerPrefs.HasKey(N18ReviewData.GetPrefsKeyHard())
end

function N18ReviewData.HasPrefsMiniGame()
  return UnityEngine.PlayerPrefs.HasKey(N18ReviewData.GetPrefsKeyMiniGame())
end

function N18ReviewData.SetPrefsMain()
  UnityEngine.PlayerPrefs.SetInt(N18ReviewData.GetPrefsKeyMain(), 1)
end

function N18ReviewData.SetPrefsHard()
  UnityEngine.PlayerPrefs.SetInt(N18ReviewData.GetPrefsKeyHard(), 1)
end

function N18ReviewData.SetPrefsMiniGame()
  UnityEngine.PlayerPrefs.SetInt(N18ReviewData.GetPrefsKeyMiniGame(), 1)
end

local UIN18BtnState = {
  NotOpen = 1,
  Locked = 2,
  Closed = 3,
  Normal = 4
}
_enum("UIN18BtnState", UIN18BtnState)
