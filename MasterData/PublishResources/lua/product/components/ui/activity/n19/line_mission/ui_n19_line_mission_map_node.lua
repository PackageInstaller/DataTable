_class("UIN19LineMissionMapNode", UICustomWidget)
UIN19LineMissionMapNode = UIN19LineMissionMapNode

function UIN19LineMissionMapNode:OnShow(uiParams)
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
end

function UIN19LineMissionMapNode:Destroy()
  self._matReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq)
end

function UIN19LineMissionMapNode:SetData(lineCfg, passInfo, cb)
  self._missionID = lineCfg.CampaignMissionId
  self._callback = cb
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if not missionCfg then
    Log.exception("cfg_campaign_mission中找不到配置:", self._missionID)
  end
  self:_SetRectTransform(lineCfg)
  self:_SetState(missionCfg.Type)
  self:_SetName_TMP(missionCfg.Type, StringTable.Get(missionCfg.Name))
  self:_SetStar(passInfo)
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  local id = lineCfg.MapPosY >= 0 and "uieff_UIXH1MissionNode_belowin" or "uieff_UIXH1MissionNode_topin"
  UIWidgetHelper.SetAnimationPlay(self, "anim", id)
end

function UIN19LineMissionMapNode:_SetRectTransform(lineCfg)
  self._rectTransform.anchorMax = Vector2(0, 0.5)
  self._rectTransform.anchorMin = Vector2(0, 0.5)
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = Vector2(lineCfg.MapPosX, lineCfg.MapPosY)
end

function UIN19LineMissionMapNode:_SetName(state, text)
  local tb = {
    "name_normal",
    "name_boss",
    "name_plot"
  }
  UIWidgetHelper.SetLocalizationText(self, tb[state], text)
end

function UIN19LineMissionMapNode:_SetName_TMP(state, text)
  local tb = {
    "name_normal",
    "name_boss",
    "name_plot"
  }
  local tb2 = {
    "uieff_uin19_line_normal.mat",
    "uieff_uin19_line_boss.mat",
    "uieff_uin19_line_plot.mat"
  }
  self._matReq = UIWidgetHelper.SetLocalizedTMPMaterial(self, tb[state], tb2[state], nil)
  UIWidgetHelper.SetLocalizedTMPText(self, tb[state], text)
end

function UIN19LineMissionMapNode:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {
      "bg_normal",
      "name_normal",
      "star"
    },
    {
      "bg_boss",
      "name_boss",
      "star"
    },
    {"bg_plot", "name_plot"}
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIN19LineMissionMapNode:_SetStar(passInfo)
  local missionModule = self:GetModule(MissionModule)
  local stars = passInfo and missionModule:ParseStarInfo(passInfo.star) or 0
  local tb = {
    self:GetGameObject("Star1"),
    self:GetGameObject("Star2"),
    self:GetGameObject("Star3")
  }
  for i = 1, 3 do
    local pass = stars >= i
    tb[i]:SetActive(pass)
  end
end

function UIN19LineMissionMapNode:BtnOnClick(go)
  self._callback(self._missionID, self._isStoryNode, self._rectTransform.position)
end
