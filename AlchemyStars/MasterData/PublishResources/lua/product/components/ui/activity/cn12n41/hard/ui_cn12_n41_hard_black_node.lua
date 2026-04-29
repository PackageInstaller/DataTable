_class("UICN12N41HardBlackNode", UICustomWidget)
UICN12N41HardBlackNode = UICN12N41HardBlackNode

function UICN12N41HardBlackNode:PlayAnim(index)
end

function UICN12N41HardBlackNode:SetData(data, callback)
  self._data = data
  self._callback = callback
  self:SetVisible(true)
  self:_SetRectTransform(self._data:GetPosition())
  self:_SetName()
  self:_SetIcon()
  self:_SetCup()
  self:_SetLock()
  self:_SetComplete()
  self:PlayAnim()
end

function UICN12N41HardBlackNode:SetVisible(status)
  self:GetGameObject():SetActive(status)
end

function UICN12N41HardBlackNode:_SetRectTransform(pos)
  local rect = self:GetGameObject():GetComponent("RectTransform")
  rect.anchorMax = Vector2(0, 0.5)
  rect.anchorMin = Vector2(0, 0.5)
  rect.sizeDelta = Vector2.zero
  rect.anchoredPosition = pos
end

function UICN12N41HardBlackNode:_SetName()
  UIWidgetHelper.SetLocalizationText(self, "_name", self._data:GetNodeName())
end

function UICN12N41HardBlackNode:_SetIcon()
  local url = self._data:GetOpenIcon()
  UIWidgetHelper.SetRawImage(self, "_icon", url)
end

function UICN12N41HardBlackNode:_SetCup()
end

function UICN12N41HardBlackNode:_SetLock()
  local isShow = not self._data:IsOpen()
  self:GetGameObject("_lock"):SetActive(isShow)
end

function UICN12N41HardBlackNode:_SetComplete()
  local isComplete = false
  if self._state == UIActivityHardLineNodeState.Pass then
    isComplete = true
  end
  if self._state ~= UIActivityHardLineNodeState.Lock then
    self:GetGameObject("_pass"):SetActive(isComplete)
    UIWidgetHelper.SetLocalizationText(self, "_passText", Cfg.str_cn12_n41.str_cn12_n41_diff_pass_level)
  end
end

function UICN12N41HardBlackNode:BtnOnClick(go)
  if not self._data:IsOpen() then
    ToastManager.ShowToast(StringTable.Get("str_cn12_n41_hard_lock_tips", self._needName))
    return
  end
  self._callback(self._data)
end

function UICN12N41HardBlackNode:PlayAnime_In()
  local animation = self:GetUIComponent("Animation", "_anim")
  animation:Play("uieff_UINCN12N41DiffLevelNode_in")
end
