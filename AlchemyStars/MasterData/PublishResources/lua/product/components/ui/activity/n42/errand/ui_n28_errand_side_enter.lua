_class("UIN28ErrandSideEnter", UICustomWidget)
UIN28ErrandSideEnter = UIN28ErrandSideEnter

function UIN28ErrandSideEnter:Constructor()
end

function UIN28ErrandSideEnter:OnShow(uiParams)
  self:_GetComponents()
end

function UIN28ErrandSideEnter:_GetComponents()
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self._bg = self:GetUIComponent("RawImageLoader", "bg")
  self._red = self:GetGameObject("red")
  self._new = self:GetGameObject("new")
end

function UIN28ErrandSideEnter:SetData()
end

function UIN28ErrandSideEnter:BtnOnClick(go)
  local open = self._campaign:CheckCampaignOpen()
  if not open then
    self.root:SetActive(open)
    self._setShowCallback(open)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    return
  end
  self:SwitchState(UIStateType.UIN28Errand)
  self:SetNewValue()
end

function UIN28ErrandSideEnter:OnSideEnterLoad(TT, setShowCallback, setNewRedCallback)
  self._setShowCallback = setShowCallback
  self._setNewRedCallback = setNewRedCallback
  self.root = self:GetGameObject()
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self:Lock("UIN28ErrandSideEnter")
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_LINE_MISSION, ECampaignLineMissionComponentID.ECAMPAIGN_LINE_MISSION)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._line_component = self._campaign:GetComponent(ECampaignLineMissionComponentID.ECAMPAIGN_LINE_MISSION)
  self._lineMissionComponentInfo = self._campaign:GetComponentInfo(ECampaignLineMissionComponentID.ECAMPAIGN_LINE_MISSION)
  self._pass_mission_list = self._lineMissionComponentInfo.m_pass_mission_info
  self:UnLock("UIN28ErrandSideEnter")
  if res and not res:GetSucc() then
    self.root:SetActive(false)
    self._setShowCallback(false)
    return
  end
  self.root:SetActive(true)
  self._setShowCallback(true)
  self.localdbKey = "UIN28ErrandSideEnter"
  local new, red = self:CheckNewAndRed()
  self._red:SetActive(red)
  self._new:SetActive(new)
  self._setNewRedCallback(new, red)
end

function UIN28ErrandSideEnter:SetNewValue()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local key = self.localdbKey .. openID
  LocalDB.SetInt(key, 1)
  self._new:SetActive(false)
end

function UIN28ErrandSideEnter:GetNewValue()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local key = self.localdbKey .. openID
  local val = LocalDB.GetInt(key, 0)
  return val == 0
end

function UIN28ErrandSideEnter:GetRedValue()
  local dayRed = false
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local missionRed = false
  local allUnLockMissionList = {}
  local cmpID = self._line_component:GetComponentCfgId()
  local missionCfgs_temp = Cfg.cfg_component_line_mission({ComponentID = cmpID})
  self._allMissionCfgs = {}
  for _, cfg in pairs(missionCfgs_temp) do
    local needMissoinID = cfg.NeedMissionId
    local missionID = cfg.CampaignMissionId
    local unlock = false
    if needMissoinID and 0 < needMissoinID then
      if self._pass_mission_list[needMissoinID] then
        unlock = true
      end
    else
      unlock = true
    end
    if unlock then
      table.insert(allUnLockMissionList, missionID)
    end
  end
  local localdbMissionKey = "UIN28ErrandSideEnter_Mission"
  for i = 1, #allUnLockMissionList do
    local id = allUnLockMissionList[i]
    local mission_key = localdbMissionKey .. id .. openID
    local mission_val = LocalDB.GetInt(mission_key, 0)
    if mission_val == 0 then
      missionRed = true
      break
    end
  end
  return dayRed or missionRed
end

function UIN28ErrandSideEnter:CheckNewAndRed()
  local new = self:GetNewValue()
  local red = self:GetRedValue()
  return new, red
end

function UIN28ErrandSideEnter:GetSideEnterRawImage()
  return "dbg_zjm_ent"
end
