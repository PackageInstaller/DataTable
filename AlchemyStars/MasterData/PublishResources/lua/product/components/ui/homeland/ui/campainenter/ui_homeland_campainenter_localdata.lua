_class("UICampainEnterLocalData", CampaignDataBase)
UICampainEnterLocalData = UICampainEnterLocalData

function UICampainEnterLocalData:Constructor()
  self._redDotModule = GameGlobal.GetModule(RedDotModule)
end

function UICampainEnterLocalData:GetState(cInfo)
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

function UICampainEnterLocalData:GetStateNormal()
  local cInfo = self:GetComponentInfoNormal()
  if not cInfo then
    Log.fatal("### GetComponentHard failed.")
    return
  end
  return self:GetState(cInfo)
end

function UICampainEnterLocalData:GetStateHard()
  local cHardInfo = self:GetComponentInfoHard()
  if not cHardInfo then
    Log.fatal("### GetComponentHard failed.")
    return
  end
  return self:GetState(cHardInfo)
end

function UICampainEnterLocalData.GetPstId()
  local mRole = GameGlobal.GetModule(RoleModule)
  return mRole:GetPstId()
end

function UICampainEnterLocalData.GetPrefsKey(str)
  local playerPrefsKey = UICampainEnterLocalData.GetPstId() .. str
  return playerPrefsKey
end

function UICampainEnterLocalData.GetPrefsKeyStr(keyword)
  return UICampainEnterLocalData.GetPrefsKey("UICampainEnterLocalData" .. keyword)
end

function UICampainEnterLocalData.HasPrefsKeyStr(keyword)
  return UnityEngine.PlayerPrefs.HasKey(UICampainEnterLocalData.GetPrefsKeyStr(keyword))
end

function UICampainEnterLocalData.SetPrefsKeyStr(keyword)
  UnityEngine.PlayerPrefs.SetInt(UICampainEnterLocalData.GetPrefsKeyStr(keyword), 1)
end

function UICampainEnterLocalData.GetRedPoint()
  return
end

function UICampainEnterLocalData.GetNewPoint()
  return UICampainEnterLocalData.GetPrefsKeyStr("NewPoint")
end

function UICampainEnterLocalData.SetNewPoint()
  if not UICampainEnterLocalData.HasPrefsKeyStr("NewPoint") then
    UICampainEnterLocalData.SetPrefsKeyStr("NewPoint")
  end
end
