_class("UIN48HardBlackNode", UICustomWidget)
UIN48HardBlackNode = UIN48HardBlackNode

function UIN48HardBlackNode:PlayAnim(index)
end

function UIN48HardBlackNode:SetData(data, callback)
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

function UIN48HardBlackNode:SetVisible(status)
  self:GetGameObject():SetActive(status)
end

function UIN48HardBlackNode:_SetRectTransform(pos)
  local rect = self:GetGameObject():GetComponent("RectTransform")
  rect.anchorMax = Vector2(0, 0.5)
  rect.anchorMin = Vector2(0, 0.5)
  rect.sizeDelta = Vector2.zero
  rect.anchoredPosition = pos
end

function UIN48HardBlackNode:_SetName()
  UIWidgetHelper.SetLocalizationText(self, "_name", self._data:GetNodeName())
end

function UIN48HardBlackNode:_SetIcon()
  local url = self._data:GetOpenIcon()
  UIWidgetHelper.SetRawImage(self, "_icon", url)
end

function UIN48HardBlackNode:_SetCup()
  local isShow = self._data:IsOpen()
  self:GetGameObject("_cup"):SetActive(isShow)
  local cupDatas = self._data:GetCupDatas()
  local completCount = self._data:GetCompleteCupCount()
  UIWidgetHelper.SetLocalizationText(self, "_cupText", completCount .. "/" .. #cupDatas)
end

function UIN48HardBlackNode:_SetLock()
  local isShow = not self._data:IsOpen()
  self:GetGameObject("_lock"):SetActive(isShow)
  if isShow then
    self:SetBlack()
  end
end

function UIN48HardBlackNode:SetBlack()
  local rawImage = self:GetUIComponent("RawImage", "_icon")
  rawImage.color = Color(0.5019607843137255, 0.5019607843137255, 0.5019607843137255, 255)
end

function UIN48HardBlackNode:_SetComplete()
  local isComplete = self._data:IsComplete()
  self:GetGameObject("_pass"):SetActive(isComplete)
  if isComplete then
    self:SetBlack()
  end
end

function UIN48HardBlackNode:BtnOnClick(go)
  if not self._data:IsOpen() then
    ToastManager.ShowToast(StringTable.Get("str_cn12_n41_hard_lock_tips", self._data:GetLastNodeName()))
    return
  end
  self._callback(self._data)
end

function UIN48HardBlackNode:PlayAnime_In()
  local animation = self:GetUIComponent("Animation", "_anim")
  animation:Play("uieff_UIN48Hard_LineNode_in")
end

function UIN48HardBlackNode:PlayAnime_Out()
  local animation = self:GetUIComponent("Animation", "_anim")
  animation:Play("uieff_UIN48Hard_LineNode_out")
end

function UIN48HardBlackNode:OnHide()
  self:PlayAnime_Out()
end
