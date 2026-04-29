_class("UICN12N41HardLineNode", UICustomWidget)
UICN12N41HardLineNode = UICN12N41HardLineNode

function UICN12N41HardLineNode:PlayAnim(index)
end

function UICN12N41HardLineNode:SetData(lineCfg, passInfo, callback)
  self._missionId = lineCfg.CampaignMissionId
  local missionCfg = UIActivityHardLineHelper.GetMissionCfg(self._missionId)
  self._isStory = missionCfg.Type == DiscoveryStageType.Plot
  self._name = UIActivityHardLineHelper.GetMissionName(self._missionId)
  self._needName = UIActivityHardLineHelper.GetMissionName(lineCfg.NeedMissionId)
  self._callback = callback
  local state = UIActivityHardLineHelper.CheckNodeState(lineCfg, passInfo)
  self._state = state
  self:_SetRectTransform(lineCfg)
  self:_SetState(state)
  self:_SetIcon(state)
  self:_SetComplete()
end

function UICN12N41HardLineNode:_SetState(state)
  local widgetGroup = {
    [UIActivityHardLineNodeState.Lock] = {"_lock"},
    [UIActivityHardLineNodeState.Open] = {},
    [UIActivityHardLineNodeState.Pass] = {"_pass"}
  }
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, widgetGroup, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UICN12N41HardLineNode:_SetIcon(state)
  local raw = UIActivityHardLineHelper.GetIconByState(self._missionId, state)
  UIWidgetHelper.SetRawImage(self, "_icon", raw)
  UIWidgetHelper.SetLocalizationText(self, "_name", self._name)
end

function UICN12N41HardLineNode:_SetRectTransform(lineCfg)
  local rect = self:GetGameObject():GetComponent("RectTransform")
  rect.anchorMax = Vector2(0, 0.5)
  rect.anchorMin = Vector2(0, 0.5)
  rect.sizeDelta = Vector2.zero
  rect.anchoredPosition = Vector2(lineCfg.MapPosX, lineCfg.MapPosY)
end

function UICN12N41HardLineNode:_SetComplete()
  local isComplete = false
  if self._state == UIActivityHardLineNodeState.Pass then
    isComplete = true
  end
  if self._state ~= UIActivityHardLineNodeState.Lock then
    self:GetGameObject("_pass"):SetActive(isComplete)
    UIWidgetHelper.SetLocalizationText(self, "_passText", Cfg.str_cn12_n41.str_cn12_n41_diff_pass_level)
  end
end

function UICN12N41HardLineNode:BtnOnClick(go)
  if self._state == UIActivityHardLineNodeState.Lock then
    ToastManager.ShowToast(StringTable.Get("str_cn12_n41_hard_lock_tips", self._needName))
    return
  end
  self._callback(self._missionId, self._isStory)
end

function UICN12N41HardLineNode:PlayAnime_In()
  local animation = self:GetUIComponent("Animation", "_anim")
  animation:Play("uieff_UINCN12N41DiffLevelNode_in")
end
