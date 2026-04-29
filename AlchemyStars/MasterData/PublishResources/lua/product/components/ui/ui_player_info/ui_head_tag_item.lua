_class("UIHeadTagItem", UICustomWidget)
UIHeadTagItem = UIHeadTagItem

function UIHeadTagItem:OnShow(uiParams)
  self._atlas = self:GetAsset("UIPlayerInfo.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.OnChangeHeadTagBtnClick, self.OnChangeHeadTagBtnClick)
end

function UIHeadTagItem:SetData(cfg, currTag, callback)
  self:_GetComponents()
  self._tag = cfg.Tag
  self._name = cfg.Name
  self.select = currTag == self._tag
  self._callback = callback
  self:_OnValue()
end

function UIHeadTagItem:OnHide()
  self:DetachEvent(GameEventType.OnChangeHeadTagBtnClick, self.OnChangeHeadTagBtnClick)
end

function UIHeadTagItem:_GetComponents()
  self._select = self:GetGameObject("select")
  self._nameTex = self:GetUIComponent("UILocalizationText", "name")
  self._tagRed = self:GetGameObject("tagRed")
  self._tagRed:SetActive(false)
end

function UIHeadTagItem:_OnValue()
  self._nameTex:SetText(StringTable.Get(self._name))
  self:Select(self.select)
end

function UIHeadTagItem:bgOnClick()
  if self._callback then
    self._callback(self._tag)
  end
end

function UIHeadTagItem:OnChangeHeadTagBtnClick(tag)
  self:Select(tag == self._tag)
end

function UIHeadTagItem:Select(select)
  self._select:SetActive(select)
end

function UIHeadTagItem:ShowRed(red)
  self._tagRed:SetActive(red)
end
