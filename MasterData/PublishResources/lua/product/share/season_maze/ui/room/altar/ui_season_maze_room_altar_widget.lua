_class("UISeasonMazeRoom_AltarWidget", UICustomWidget)
UISeasonMazeRoom_AltarWidget = UISeasonMazeRoom_AltarWidget

function UISeasonMazeRoom_AltarWidget:InitWidget()
  self._cardPool = self:GetUIComponent("UISelectObjectPath", "cardPool")
  self._DelBtn = self:GetGameObject("DelBtn")
  self._ResetBtn = self:GetGameObject("ResetBtn")
  self._DelPrice = self:GetUIComponent("UILocalizationText", "DelPrice")
  self._ResetPrice = self:GetUIComponent("UILocalizationText", "ResetPrice")
end

function UISeasonMazeRoom_AltarWidget:OnShow(uiParams)
  self:InitWidget()
  self:AttachEvent(GameEventType.OnSeasonMazeAltarStateChange, self.ChanegState)
end

function UISeasonMazeRoom_AltarWidget:OnHide()
end

function UISeasonMazeRoom_AltarWidget:CardAnim(animName)
  if self._cardWidget and animName then
    self._cardWidget:PlayAnim(animName)
  end
end

function UISeasonMazeRoom_AltarWidget:SetData(idx, card, deletePrice, resetPrice, callback)
  self._callback = callback
  self._idx = idx
  self._card = card
  self._deletePrice = deletePrice
  self._resetPrice = resetPrice
  self._DelPrice:SetText(self._deletePrice)
  self._ResetPrice:SetText(self._resetPrice)
  self._cardWidget = self._cardPool:SpawnObject("UISeasonMazeCardItem")
  self._cardWidget:SetData(1, self._card)
end

function UISeasonMazeRoom_AltarWidget:ChanegState(state)
  self._DelBtn:SetActive(state == UISeasonMazeAltarType.Delete)
  self._ResetBtn:SetActive(state == UISeasonMazeAltarType.Reset)
end

function UISeasonMazeRoom_AltarWidget:ResetBtnOnClick()
  if self._callback then
    self._callback(self._idx)
  end
end

function UISeasonMazeRoom_AltarWidget:DelBtnOnClick()
  if self._callback then
    self._callback(self._idx)
  end
end
