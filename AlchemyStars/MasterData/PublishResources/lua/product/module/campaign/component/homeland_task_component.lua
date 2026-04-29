_class("HomelandTaskComponent", ICampaignComponent)
HomelandTaskComponent = HomelandTaskComponent
local Enum_CMP_HomelandTaskState = {
  EPTS_Unlock = 1,
  EPTS_UnComplete = 2,
  EPTS_UnHave = 3,
  EPTS_HaveGet = 4
}
_enum("Enum_CMP_HomelandTaskState", Enum_CMP_HomelandTaskState)

function HomelandTaskComponent:Constructor()
  self._componentInfo = HomlandTaskComponentInfo:New()
end

function HomelandTaskComponent:ComponentInfo()
  if not self._componentInfo then
    self._componentInfo = HomlandTaskComponentInfo:New()
  end
  return self._componentInfo
end

function HomelandTaskComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function HomelandTaskComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_HOMELAND_TASK
end

function HomelandTaskComponent:InitComponentInfo(a_load_info)
  self.quest_mod = GameGlobal.GameLogic():GetModule(QuestModule)
  self.login_mod = GameGlobal.GameLogic():GetModule(LoginModule)
  self.time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  self.cam_mod = GameGlobal.GameLogic():GetModule(CampaignModule)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self._componentInfo)
  return ret
end

function HomelandTaskComponent:HandlePangolinGet(TT, asyncRes, id)
  local request = HomlandTaskComponentGetReq:New()
  request.id = id
  local response = HomlandTaskComponentGetReply:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CumulateLogin] HandlePangolinGet ret:", asyncRes.m_result)
    return asyncRes.m_result
  end
  table.insert(self._componentInfo.m_id, id)
  return asyncRes.m_result
end

function HomelandTaskComponent:GetCfgMap()
  local ComponentInfo = self:ComponentInfo()
  if ComponentInfo == nil then
    return nil
  end
  local componentId = self:GetComponentCfgId()
  local cfgMap = Cfg.cfg_component_homeland_task({ComponentID = componentId})
  return cfgMap
end

function HomelandTaskComponent:GetTaskState(id)
  local ComponentInfo = self:ComponentInfo()
  if ComponentInfo == nil then
    return nil
  end
  local componentId = self:GetComponentCfgId()
  local cfg = Cfg.cfg_component_homeland_task[id]
  if cfg == nil or cfg.ComponentID ~= componentId then
    return nil
  end
  local nowTime = self.time_mod:GetServerTime() * 0.001
  for k, v in pairs(self._componentInfo.m_id) do
    if v == id then
      return Enum_CMP_HomelandTaskState.EPTS_HaveGet
    end
  end
  local endTime = self.login_mod:GetTimeStampByTimeStr(cfg.UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  if nowTime >= endTime then
    if self.quest_mod:IsTakeStatus(cfg.TaskID, QuestStatus.QUEST_Completed) == true or self.quest_mod:IsTakeStatus(cfg.TaskID, QuestStatus.QUEST_Taken) == true then
      return Enum_CMP_HomelandTaskState.EPTS_UnHave
    else
      return Enum_CMP_HomelandTaskState.EPTS_UnComplete
    end
  else
    return Enum_CMP_HomelandTaskState.EPTS_Unlock
  end
  return nil
end

function HomelandTaskComponent:SetDB(id, capName, funcName)
  capName = self:GetCapNameAuto(capName)
  funcName = funcName or "red"
  self.cam_mod:SetDB(id, capName, funcName)
end

function HomelandTaskComponent:GetDB(id, capName, funcName)
  capName = self:GetCapNameAuto(capName)
  funcName = funcName or "red"
  return self.cam_mod:GetDB(id, capName, funcName)
end

function HomelandTaskComponent:NewTaskRed(capName, funcName)
  local cfgMap = self:GetCfgMap()
  if cfgMap == nil then
    return 0
  end
  local num = 0
  for k, v in pairs(cfgMap) do
    if self:GetDB(v.ID, capName, funcName) == 0 and self:GetTaskState(v.ID) ~= Enum_CMP_HomelandTaskState.EPTS_Unlock and self:GetTaskState(v.ID) <= Enum_CMP_HomelandTaskState.EPTS_UnComplete then
      num = num + 1
    end
  end
  return num
end

function HomelandTaskComponent:GetNewKey(capName)
  capName = self:GetCapNameAuto(capName)
  local mRole = GameGlobal.GetModule(RoleModule)
  return mRole:GetPstId() .. capName .. "New"
end

function HomelandTaskComponent:GetPrefsComponentNew(capName)
  return LocalDB.GetInt(self:GetNewKey(capName), 0)
end

function HomelandTaskComponent:SetPrefsComponentNew(capName)
  return LocalDB.SetInt(self:GetNewKey(capName), 1)
end

function HomelandTaskComponent:GetCapNameAuto(capName)
  if not string.isnullorempty(capName) then
    return capName
  end
  local id = self:GetComponentCfgId()
  local tb = {
    [106402503] = "N19TaskComp"
  }
  return tb[id] or "HomelandTaskCompoent_" .. id
end
