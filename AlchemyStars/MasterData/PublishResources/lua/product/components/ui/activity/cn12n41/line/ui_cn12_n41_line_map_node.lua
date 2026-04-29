_class("UICN12N41LineMapNode", UICustomWidget)
UICN12N41LineMapNode = UICN12N41LineMapNode

function UICN12N41LineMapNode:OnShow(uiParams)
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
end

function UICN12N41LineMapNode:Destroy()
  self._matReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq)
end

function UICN12N41LineMapNode:SetData(lineCfg, passInfo, cb)
  self._missionID = lineCfg.CampaignMissionId
  self._callback = cb
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if not missionCfg then
    Log.exception("cfg_campaign_mission中找不到配置:", self._missionID)
  end
  self:_SetRectTransform(lineCfg)
  self:_SetState(missionCfg.Type)
  self:_SetName(missionCfg.Type, StringTable.Get(missionCfg.Name))
  self:_SetStar(passInfo)
  self:_SetPlay(passInfo)
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
end

function UICN12N41LineMapNode:_SetRectTransform(lineCfg)
  self._rectTransform.anchorMax = Vector2(0, 0.5)
  self._rectTransform.anchorMin = Vector2(0, 0.5)
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = Vector2(lineCfg.MapPosX, lineCfg.MapPosY)
end

function UICN12N41LineMapNode:_SetName(state, text)
  local tb = {
    "name",
    "name",
    "name"
  }
  UIWidgetHelper.SetLocalizationText(self, tb[state], text)
end

function UICN12N41LineMapNode:_SetName_TMP(state, text)
  local tb = {
    "_txtNameNormal",
    "_txtNameBoss",
    "_txtNamePlot"
  }
  local tb2 = {
    "uieff_uin19_line_normal.mat",
    "uieff_uin19_line_boss.mat",
    "uieff_uin19_line_plot.mat"
  }
  self._matReq = UIWidgetHelper.SetLocalizedTMPMaterial(self, tb[state], tb2[state], nil)
  UIWidgetHelper.SetLocalizedTMPText(self, tb[state], text)
end

function UICN12N41LineMapNode:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {
      "bg_normal",
      "star_normal"
    },
    {"bg_boss", "star_boss"},
    {"bg_plot"}
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UICN12N41LineMapNode:_SetStar(passInfo)
  local missionModule = self:GetModule(MissionModule)
  local stars = passInfo and missionModule:ParseStarInfo(passInfo.star) or 0
  local normaltb = {
    "normal_Star1",
    "normal_Star2",
    "normal_Star3"
  }
  for i = 1, 3 do
    local pass = i <= stars
    self:GetGameObject(normaltb[i]):SetActive(pass)
  end
  local bosstb = {
    "boss_Star1",
    "boss_Star2",
    "boss_Star3"
  }
  for i = 1, 3 do
    local pass = stars >= i
    self:GetGameObject(bosstb[i]):SetActive(pass)
  end
end

function UICN12N41LineMapNode:_SetPlay(passInfo)
  local isShow = passInfo and passInfo.pass_without_help ~= 0
  self:GetGameObject("_play"):SetActive(not isShow)
  self:GetGameObject("_playFin"):SetActive(isShow)
end

function UICN12N41LineMapNode:BtnOnClick(go)
  self._callback(self._missionID, self._isStoryNode, self._rectTransform.position)
end
