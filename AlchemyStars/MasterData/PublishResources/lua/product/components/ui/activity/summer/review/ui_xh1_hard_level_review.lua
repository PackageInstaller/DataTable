_class("UIXH1HardLevelReview", UIController)
UIXH1HardLevelReview = UIXH1HardLevelReview

function UIXH1HardLevelReview:LoadDataOnEnter(TT, res)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_REVIEW_N3, ECampaignReviewN3ComponentID.ECAMPAIGN_REVIEW_ReviewN3_STAGE2_LINE_MISSION)
  if res and res:GetSucc() then
    self._line_component = self._campaign:GetComponent(ECampaignReviewN3ComponentID.ECAMPAIGN_REVIEW_ReviewN3_STAGE2_LINE_MISSION)
    self._line_info = self._line_component:GetComponentInfo()
    local openTime = self._line_info.m_unlock_time
    local closeTime = self._line_info.m_close_time
    local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
    if openTime > now then
      res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
      campaignModule:ShowErrorToast(res.m_result, true)
      return
    elseif closeTime < now then
      res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
      campaignModule:ShowErrorToast(res.m_result, true)
      return
    end
    if not self._line_info.m_b_unlock then
      res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_UNLOCK
      local cfgv = Cfg.cfg_campaign_mission[self._line_info.m_need_mission_id]
      if cfgv then
        local lvName = StringTable.Get(cfgv.Name)
        local msg = StringTable.Get("str_activity_summer_i_will_open_after_clearance", lvName)
        ToastManager.ShowToast(msg)
      end
      return
    end
  end
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIXH1HardLevelReview:OnShow(uiParams)
  self:InitWidget()
  self.topButtonWidget = self.topbuttons:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    self:SwitchState(UIStateType.UISummer1Review)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
  UIXH1HardLevelReview.LevelCfg = {
    [1] = {
      normal = "summer_guanqia_btn1",
      close = "summer_guanqia_btn4"
    },
    [2] = {
      normal = "summer_guanqia_btn9",
      close = "summer_guanqia_btn12"
    },
    [3] = {
      normal = "summer_guanqia_btn5",
      close = "summer_guanqia_btn8"
    },
    [4] = {
      normal = "summer_guanqia_btn13",
      close = "summer_guanqia_btn16"
    },
    [5] = {
      normal = "summer_guanqia_btn17",
      close = "summer_guanqia_btn20"
    },
    [6] = {
      normal = "summer_guanqia_btn21",
      close = "summer_guanqia_btn24"
    },
    [7] = {
      normal = "summer_guanqia_btnhard1",
      close = "summer_guanqia_btnhard2"
    },
    [8] = {
      normal = "summer_guanqia_btnhard5",
      close = "summer_guanqia_btnhard6"
    },
    [9] = {
      normal = "summer_guanqia_btnhard3",
      close = "summer_guanqia_btnhard4"
    },
    [10] = {
      normal = "summer_guanqia_btnhard7",
      close = "summer_guanqia_btnhard8"
    },
    [11] = {
      normal = "summer_guanqia_btnhard9",
      close = "summer_guanqia_btnhard10"
    },
    [12] = {
      normal = "summer_guanqia_btnhard11",
      close = "summer_guanqia_btnhard12"
    }
  }
  self._atlas = self:GetAsset("UIXH1HardLevel.spriteatlas", LoadType.SpriteAtlas)
  self._levelCpt = self._campaign:GetComponent(ECampaignReviewN3ComponentID.ECAMPAIGN_REVIEW_ReviewN3_STAGE2_LINE_MISSION)
  self._levelCptInfo = self._levelCpt:GetComponentInfo()
  local cptID = self._levelCpt:GetComponentCfgId()
  local allMissions = Cfg.cfg_component_line_mission({ComponentID = cptID})
  table.sort(allMissions, function(a, b)
    return a.SortId < b.SortId
  end)
  if #allMissions ~= 6 then
    Log.exception("夏活1高难关的数量必须是6")
  end
  self._passInfo = self._levelCptInfo.m_pass_mission_info
  self._levelCfgs = allMissions
  local cur = 1
  for i, cfg in ipairs(allMissions) do
    if cfg.CampaignMissionId == self._levelCptInfo.m_cur_mission then
      cur = i + 1
    end
  end
  self._curIndex = cur
  self:refreshPoint()
end

function UIXH1HardLevelReview:OnHide()
  UIXH1HardLevelReview.LevelCfg = nil
end

function UIXH1HardLevelReview:InitWidget()
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self._levels = {}
  for i = 1, 6 do
    self._levels[i] = UIXH1HardLevelItemReview:New(self:GetUIComponent("UIView", "Level" .. i))
  end
  self._scale = 1.2
end

function UIXH1HardLevelReview:enterLevel(idx)
  if idx < 1 and 6 < idx then
    return
  end
  local levelIndex = idx
  local missionID = self._levelCfgs[levelIndex].CampaignMissionId
  if levelIndex > self._curIndex then
    ToastManager.ShowToast(StringTable.Get("str_activity_summer_i_locked"))
    return
  end
  self:ShowDialog("UIActivityLevelStageNew", missionID, self._line_info.m_pass_mission_info[missionID], self._line_component, false, nil)
end

function UIXH1HardLevelReview:refreshPoint()
  for i = 1, 6 do
    local idx = i
    self._levels[i]:SetData(idx, self._levelCfgs[idx], self._passInfo[self._levelCfgs[idx].CampaignMissionId], self._curIndex, self._atlas)
  end
end

function UIXH1HardLevelReview:press1OnClick()
  self:enterLevel(1)
end

function UIXH1HardLevelReview:press2OnClick()
  self:enterLevel(2)
end

function UIXH1HardLevelReview:press3OnClick()
  self:enterLevel(3)
end

function UIXH1HardLevelReview:press4OnClick()
  self:enterLevel(4)
end

function UIXH1HardLevelReview:press5OnClick()
  self:enterLevel(5)
end

function UIXH1HardLevelReview:press6OnClick()
  self:enterLevel(6)
end
