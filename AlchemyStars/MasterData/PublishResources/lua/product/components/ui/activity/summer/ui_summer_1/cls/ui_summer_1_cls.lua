_class("Summer1Data", Object)
Summer1Data = Summer1Data

function Summer1Data:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self._campaign = nil
end

function Summer1Data:RequestCampaign(TT)
  local res = AsyncRequestRes:New()
  if not self._campaign then
    self._campaign = UIActivityCampaign:New()
    self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_SUMMER_I)
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and res:GetSucc() then
  else
    Log.fatal("### [RequestCampaign]CampaignComProtoLoadInfo failed.")
  end
end

function Summer1Data:GetCampaign()
  return self._campaign
end

function Summer1Data:GetCampaignId()
  return self._campaign._id
end

function Summer1Data:GetCampaignLocalProgress()
  return self._campaign:GetLocalProcess()
end

function Summer1Data:CheckRedAward()
  local lp = self:GetCampaignLocalProgress()
  local red = self.mCampaign:CheckComponentRed(lp, ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_CUMULATIVE_LOGIN)
  return red
end

function Summer1Data:CheckRedNormal()
  local state = self:GetStateNormal()
  if state == UISummerOneEnterBtnState.Normal then
    local lp = self:GetCampaignLocalProgress()
    local redActionPoint = self.mCampaign:CheckComponentRed(lp, ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_ACTION_POINT)
    local redFixTeam = self.mCampaign:CheckComponentRed(lp, ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_FIXTEAM)
    return redActionPoint or redFixTeam
  end
  return false
end

function Summer1Data:CheckRedGame()
  local state = self:GetStateGame()
  if state == UISummerOneEnterBtnState.Normal then
    local lp = self:GetCampaignLocalProgress()
    local red = self.mCampaign:CheckComponentRed(lp, ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_SHAVING_ICE)
    return red
  end
  return false
end

function Summer1Data:GetCampaignSummerI()
  local cSummerI = self.mCampaign:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_SUMMER_I)
  return cSummerI
end

function Summer1Data:GetComponent(ecampaignSummerIComponentID)
  local cSummerI = self:GetCampaignSummerI()
  if not cSummerI then
    Log.fatal("### GetCampaignSummerI failed.")
    return
  end
  local cInfo = cSummerI:GetComponentInfo(ecampaignSummerIComponentID)
  return cInfo
end

function Summer1Data:GetComponentNormal()
  local cInfo = self:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_COMMON)
  return cInfo
end

function Summer1Data:GetComponentHard()
  local cInfo = self:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_HARD)
  return cInfo
end

function Summer1Data:GetComponentGame()
  local cInfo = self:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_SHAVING_ICE)
  return cInfo
end

function Summer1Data:GetState(cInfo)
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

function Summer1Data:GetStateNormal()
  local cInfo = self:GetComponentNormal()
  if not cInfo then
    Log.fatal("### GetComponentHard failed.")
    return
  end
  return self:GetState(cInfo)
end

function Summer1Data:GetStateHard()
  local cHardInfo = self:GetComponentHard()
  if not cHardInfo then
    Log.fatal("### GetComponentHard failed.")
    return
  end
  return self:GetState(cHardInfo)
end

function Summer1Data:GetStateGame()
  local cCameInfo = self:GetComponentGame()
  if not cCameInfo then
    Log.fatal("### GetComponentGame failed.")
    return
  end
  return self:GetState(cCameInfo)
end

function Summer1Data:CheckMiniGameNewStage()
  local mLogin = GameGlobal.GetModule(LoginModule)
  local str = LocalDB.GetString("MiniGameNewStage" .. mLogin:GetRoleShowID())
  local ids = string.split(str, ",")
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  local componentInfo = self:GetComponentGame()
  local list = componentInfo.mission_info_list
  local newStage = false
  for i = 1, #list do
    if nowTimestamp >= list[i].unlock_time then
      local record = false
      for j = 1, #ids do
        if ids[j] == tostring(i) then
          record = true
          break
        end
      end
      if not record then
        newStage = true
        break
      end
    end
  end
  return newStage
end

function Summer1Data.GetPstId()
  local mRole = GameGlobal.GetModule(RoleModule)
  return mRole:GetPstId()
end

function Summer1Data.GetPrefsKey(str)
  local playerPrefsKey = Summer1Data.GetPstId() .. str
  return playerPrefsKey
end

function Summer1Data.GetPrefsKeyMain()
  return Summer1Data.GetPrefsKey("UISummer1PrefsKeyMain")
end

function Summer1Data.GetPrefsKeyHard()
  return Summer1Data.GetPrefsKey("UISummer1PrefsKeyHard")
end

function Summer1Data.GetPrefsKeyGame()
  return Summer1Data.GetPrefsKey("UISummer1PrefsKeyGame")
end

function Summer1Data.HasPrefsMain()
  return UnityEngine.PlayerPrefs.HasKey(Summer1Data.GetPrefsKeyMain())
end

function Summer1Data.HasPrefsHard()
  return UnityEngine.PlayerPrefs.HasKey(Summer1Data.GetPrefsKeyHard())
end

function Summer1Data.HasPrefsGame()
  return UnityEngine.PlayerPrefs.HasKey(Summer1Data.GetPrefsKeyGame())
end

function Summer1Data.SetPrefsMain()
  UnityEngine.PlayerPrefs.SetInt(Summer1Data.GetPrefsKeyMain(), 1)
end

function Summer1Data.SetPrefsHard()
  UnityEngine.PlayerPrefs.SetInt(Summer1Data.GetPrefsKeyHard(), 1)
end

function Summer1Data.SetPrefsGame()
  UnityEngine.PlayerPrefs.SetInt(Summer1Data.GetPrefsKeyGame(), 1)
end

local UISummerOneEnterBtnState = {
  NotOpen = 1,
  Locked = 2,
  Closed = 3,
  Normal = 4
}
_enum("UISummerOneEnterBtnState", UISummerOneEnterBtnState)
