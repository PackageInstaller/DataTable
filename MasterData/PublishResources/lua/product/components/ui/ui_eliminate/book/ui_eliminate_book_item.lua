_class("UIEliminateBookItem", UICustomWidget)
UIEliminateBookItem = UIEliminateBookItem

function UIEliminateBookItem:Constructor()
  self._isSelect = false
end

function UIEliminateBookItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIEliminateBookItem:_GetComponents()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._rect = self:GetUIComponent("RectTransform", "Root")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "Root")
  self._selectObj = self:GetGameObject("select")
  self._playerChooseObj = self:GetGameObject("playerChoose")
end

function UIEliminateBookItem:SetSelect(isSelect)
  if isSelect == self._isSelect then
    return
  end
  self._isSelect = isSelect
  self._selectObj:SetActive(isSelect)
end

function UIEliminateBookItem:SetUse(isUse)
  self._playerChooseObj:SetActive(isUse)
end

function UIEliminateBookItem:SetData(cfg, index, callback)
  self._cfg = cfg
  self._index = index
  self._callback = callback
  self._icon.gameObject:SetActive(false)
  self._selectObj:SetActive(false)
  self._playerChooseObj:SetActive(false)
  self._isSelect = false
  if self._cfg then
    self._icon.gameObject:SetActive(true)
    self:_InitComponents()
  end
end

function UIEliminateBookItem:GetID()
  if self._cfg then
    return self._cfg.ID
  end
  return nil
end

function UIEliminateBookItem:GetCfg()
  return self._cfg
end

function UIEliminateBookItem:GetIndex()
  return self._index
end

function UIEliminateBookItem:_InitComponents()
  local cfg = Cfg.cfg_item[self._cfg.ItemID]
  self._icon:LoadImage(cfg.Icon)
end

function UIEliminateBookItem:PlayFadeInAnim()
  if not tolua.isnull(self._anim) then
    self._anim:Play("uieff_UIEliminateBookItem_in")
  end
end

function UIEliminateBookItem:ResetInAnim()
  self._canvasGroup.alpha = 0
  self._rect.anchoredPosition = Vector2(0, -22)
end

function UIEliminateBookItem:BtnOnClick()
  if not self._cfg then
    return
  end
  if self._callback then
    self._callback(self)
  end
end
