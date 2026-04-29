_class("UIDantangLineMissionMapNode", UICustomWidget)
UIDantangLineMissionMapNode = UIDantangLineMissionMapNode

function UIDantangLineMissionMapNode:OnShow(uiParams)
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._animation = self:GetGameObject():GetComponent("Animation")
end

function UIDantangLineMissionMapNode:Destroy()
end

function UIDantangLineMissionMapNode:SetData(lineCfg, passInfo, isUnlock, cb)
  self._missionID = lineCfg.CampaignMissionId
  self._callback = cb
  self._isLock = not isUnlock
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if not missionCfg then
    Log.exception("cfg_campaign_mission中找不到配置:", self._missionID)
  end
  self:_SetRectTransform(lineCfg)
  self:_SetState(missionCfg.Type)
  self:_SetName(missionCfg.Type, StringTable.Get(missionCfg.Name))
  self:_SetStar(passInfo)
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  self:GetGameObject("lock"):SetActive(self._isLock)
  if lineCfg.MapPosX > 0 then
    self._animation:Play("uieff_UIDantangLineMission_MapNode_01")
  else
    self._animation:Play("uieff_UIDantangLineMission_MapNode_02")
  end
end

function UIDantangLineMissionMapNode:_SetRectTransform(lineCfg)
  self._rectTransform.anchorMax = Vector2(0.5, 1)
  self._rectTransform.anchorMin = Vector2(0.5, 1)
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = Vector2(lineCfg.MapPosX, lineCfg.MapPosY)
end

function UIDantangLineMissionMapNode:_SetName(state, text)
  UIWidgetHelper.SetLocalizationText(self, "_txtNameNormal", text)
end

function UIDantangLineMissionMapNode:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"_normal", "star"},
    {"_boss", "star"},
    {"_plot"}
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIDantangLineMissionMapNode:_SetStar(passInfo)
  local missionModule = self:GetModule(MissionModule)
  local stars = passInfo and missionModule:ParseStarInfo(passInfo.star) or 0
  local tb = {
    "Star1",
    "Star2",
    "Star3"
  }
  for i = 1, 3 do
    local pass = i <= stars
    self:GetGameObject(tb[i]):SetActive(pass)
  end
end

function UIDantangLineMissionMapNode:BtnOnClick(go)
  if self._isLock then
    ToastManager.ShowToast(StringTable.Get("str_activity_common_clear_mission_to_unlock"))
    return
  end
  self._callback(self._missionID, self._isStoryNode, self._rectTransform.position)
end
