_class("UIDiffNodeBase", UICustomWidget)
UIDiffNodeBase = UIDiffNodeBase

function UIDiffNodeBase:Constructor()
  self._uiModule = GameGlobal.GetUIModule(DifficultyMissionModule)
end

function UIDiffNodeBase:OnShow()
  self:GetComponents()
  self:GetUIComponentEff()
  self:AttachEvent(GameEventType.DiscoveryShowHideUIStage, self.Highlight)
end

function UIDiffNodeBase:OnHide()
  self:DetachEvent(GameEventType.DiscoveryShowHideUIStage, self.Highlight)
end

function UIDiffNodeBase:GetComponents()
  self._go = self:GetGameObject()
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._monster = self:GetUIComponent("RawImageLoader", "monster")
  self._cupNum = self:GetUIComponent("UILocalizationText", "cupNum")
  self._texTip = self:GetUIComponent("UILocalizationText", "txtTip")
  self._texName = self:GetUIComponent("UILocalizationText", "txtName")
end

function UIDiffNodeBase:GetUIComponentEff()
  self.eff = self:GetGameObject("eff")
  self.animEff = self:GetUIComponent("Animation", "eff")
end

function UIDiffNodeBase:SetData(node, callback)
  if not node then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._node = node
  self:SetInfo()
  self:SetPos()
  self._callback = callback
  self.eff:SetActive(false)
end

function UIDiffNodeBase:SetInfo()
end

function UIDiffNodeBase:SetPos()
  local pos = self._node:Pos()
  self._rectTransform.anchoredPosition = pos
end

function UIDiffNodeBase:btnBgOnClick()
  self:ClickItem()
  self:PlayAnimMapTrainIn()
end

function UIDiffNodeBase:PlayAnimMapTrainIn()
  self:StartTask(function(TT)
    local key = "UIMapNodeItemBasePlayAnimMapTrainIn"
    self:Lock(key)
    self.animEff:Play("uieff_MapTrainHard_in")
    YIELD(TT, 500)
    self.animEff:Play("uieff_MapTrainHard_loop")
    self:UnLock(key)
  end, self)
end

function UIDiffNodeBase:ClickItem()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryShowHideUIStage, true, self._node:ID())
  if self._callback then
    self._callback(self._node)
  end
end

function UIDiffNodeBase:Highlight(isHighlight, nodeId)
  if isHighlight then
    if nodeId == self._node:ID() then
      self.eff:SetActive(true)
    else
      self.eff:SetActive(false)
    end
  else
    self.eff:SetActive(false)
  end
end

function UIDiffNodeBase:GetRectTransform()
  return self._rectTransform
end
