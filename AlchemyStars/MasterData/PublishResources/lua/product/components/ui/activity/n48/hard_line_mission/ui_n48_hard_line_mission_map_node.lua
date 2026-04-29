_class("UIN48HardLineNode", UICustomWidget)
UIN48HardLineNode = UIN48HardLineNode

function UIN48HardLineNode:PlayAnim(index)
end

function UIN48HardLineNode:SetData(lineCfg, passInfo, callback)
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

function UIN48HardLineNode:_SetState(state)
  local widgetGroup = {
    [UIActivityHardLineNodeState.Lock] = {"_lock"},
    [UIActivityHardLineNodeState.Open] = {},
    [UIActivityHardLineNodeState.Pass] = {"_pass"}
  }
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, widgetGroup, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIN48HardLineNode:_SetIcon(state)
  local raw = UIActivityHardLineHelper.GetIconByState(self._missionId, state)
  UIWidgetHelper.SetRawImage(self, "_icon", raw)
  UIWidgetHelper.SetLocalizationText(self, "_name", self._name)
end

function UIN48HardLineNode:_SetRectTransform(lineCfg)
  local rect = self:GetGameObject():GetComponent("RectTransform")
  rect.anchorMax = Vector2(0, 0.5)
  rect.anchorMin = Vector2(0, 0.5)
  rect.sizeDelta = Vector2.zero
  rect.anchoredPosition = Vector2(lineCfg.MapPosX, lineCfg.MapPosY)
end

function UIN48HardLineNode:_SetComplete()
  local isComplete = false
  if self._state == UIActivityHardLineNodeState.Pass then
    isComplete = true
  end
  if self._state ~= UIActivityHardLineNodeState.Lock then
    self:GetGameObject("_pass"):SetActive(isComplete)
  else
    local tips = StringTable.Get("str_N48_pass_level_unlock", self._needName)
    UIWidgetHelper.SetLocalizationText(self, "_lockText", tips)
  end
end

function UIN48HardLineNode:BtnOnClick(go)
  if self._state == UIActivityHardLineNodeState.Lock then
    ToastManager.ShowToast(StringTable.Get("str_cn12_n41_hard_lock_tips", self._needName))
    return
  end
  self._callback(self._missionId, self._isStory)
end

function UIN48HardLineNode:PlayAnime_In()
  local animation = self:GetUIComponent("Animation", "_anim")
  animation:Play("uieff_UIN48Hard_LineNode_in")
end

function UIN48HardLineNode:PlayAnime_Out()
  local animation = self:GetUIComponent("Animation", "_anim")
  animation:Play("uieff_UIN48Hard_LineNode_out")
end

function UIN48HardLineNode:OnHide()
  self:PlayAnime_Out()
end
