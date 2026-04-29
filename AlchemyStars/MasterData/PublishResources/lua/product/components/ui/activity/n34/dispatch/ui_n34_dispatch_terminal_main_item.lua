N34TerminalItemStatus = {
  NotStart = 0,
  Going = 1,
  End = 2,
  Unlock = 3
}
_enum("N34TerminalItemStatus", N34TerminalItemStatus)
_class("UIN34DispatchTerminalMainItem", UICustomWidget)
UIN34DispatchTerminalMainItem = UIN34DispatchTerminalMainItem

function UIN34DispatchTerminalMainItem:OnShow(uiParams)
  self:InitWidget()
end

function UIN34DispatchTerminalMainItem:InitWidget()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._award = self:GetUIComponent("Image", "Award")
  self._state = self:GetUIComponent("Image", "state")
  self._select = self:GetUIComponent("Image", "Select")
  self._atlas = self:GetAsset("UIN34Dispatch.spriteatlas", LoadType.SpriteAtlas)
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "Canvas")
end

function UIN34DispatchTerminalMainItem:SetData(Info, ID, name, AwardClick, ItemSelect, lock)
  self.info = Info
  self.id = ID
  self.name = name
  self.awardClick = AwardClick
  self.itemSelect = ItemSelect
  self.lock = lock
  self._title:SetText(StringTable.Get(self.name))
  self:SetStatus(self.info)
end

function UIN34DispatchTerminalMainItem:SetStatus(Info)
  if not Info then
    if self.lock then
      self._status = N34TerminalItemStatus.Unlock
    else
      self._status = N34TerminalItemStatus.NotStart
    end
  else
    self._status = Info.status
  end
  if self._status == N34TerminalItemStatus.NotStart then
    self._state.sprite = self._atlas:GetSprite("n34_pqtc_task03")
  elseif self._status == N34TerminalItemStatus.Going or self._status == N34TerminalItemStatus.Unlock then
    self._state.sprite = self._atlas:GetSprite("n34_pqtc_task01")
  elseif self._status == N34TerminalItemStatus.End then
    self._state.sprite = self._atlas:GetSprite("n34_pqtc_task02")
  end
end

function UIN34DispatchTerminalMainItem:PlayAnimIn(time)
  self:StartTask(function(TT)
    YIELD(TT, time * 60)
    if not self.view then
      return
    end
    self._anim:Play("uieff_UIN34DispatchTerminalMainItem_in")
  end)
end

function UIN34DispatchTerminalMainItem:SetCanvasGroup()
  self._canvasGroup.alpha = 0
end

function UIN34DispatchTerminalMainItem:SetSelected(bool)
  self._select.gameObject:SetActive(bool)
end

function UIN34DispatchTerminalMainItem:GetDispatchID()
  return self.id
end

function UIN34DispatchTerminalMainItem:GetStatus()
  return self._status
end

function UIN34DispatchTerminalMainItem:AwardOnClick(go)
  if self.awardClick then
    self.awardClick(self.id, go.transform.position)
  end
  self:SelectBtnOnClick()
end

function UIN34DispatchTerminalMainItem:SelectBtnOnClick()
  if self.itemSelect then
    self:itemSelect(self)
  end
end
