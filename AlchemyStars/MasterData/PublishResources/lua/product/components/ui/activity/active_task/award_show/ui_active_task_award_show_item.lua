_class("UIActiveTaskAwardShowItem", UICustomWidget)
UIActiveTaskAwardShowItem = UIActiveTaskAwardShowItem

function UIActiveTaskAwardShowItem:OnShow()
  self._gridSize = Vector2(135, 135)
  self._atlas = self:GetAsset("ActiveTask.spriteatlas", LoadType.SpriteAtlas)
  self:_GetComponent()
end

function UIActiveTaskAwardShowItem:OnHide()
end

function UIActiveTaskAwardShowItem:_GetComponent()
  self._itemNum = self:GetUIComponent("UILocalizationText", "itemNum")
  self._itemNumSmall = self:GetUIComponent("UILocalizationText", "itemNum_s")
  self._remain = self:GetUIComponent("UILocalizationText", "remain")
  self._remainSmall = self:GetUIComponent("UILocalizationText", "remainsmall")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._iconRect = self:GetUIComponent("RectTransform", "Icon")
  self._allGet = self:GetUIComponent("Image", "allGet")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._getRect = self:GetUIComponent("RectTransform", "parent")
  self._allGetObj = self:GetGameObject("allGet")
  self._itemNumObj = self:GetGameObject("ItemNumBg")
  self._itemNumSmallObj = self:GetGameObject("ItemNumBg_s")
end

function UIActiveTaskAwardShowItem:SetData(id, data, clickCallback)
  self._id = id
  self._data = data
  self._clickCallback = clickCallback
  self:InitComponent()
end

function UIActiveTaskAwardShowItem:InitComponent()
  self._cfg = Cfg.cfg_component_turn_card_item[self._id]
  local rewards = self._cfg.Reward
  self._icon:LoadImage(self._cfg.ItemEntireIcon)
  self._remain:SetText(StringTable.Get("str_n32_turn_card_remain", self._data))
  self._remainSmall:SetText(StringTable.Get("str_n32_turn_card_remain", self._data))
  self._allGetObj:SetActive(self._data == 0)
  self._height = self._gridSize.y
  self._width = self._gridSize.x
  self._remain.transform.gameObject:SetActive(self._cfg.RewardLevel ~= 3)
  self._remainSmall.transform.gameObject:SetActive(self._cfg.RewardLevel == 3)
  if self._cfg.RewardLevel == 1 then
    self._height = self._gridSize.y * 2
    self._width = self._gridSize.x * 2
    self._itemNumObj:SetActive(true)
    self._itemNumSmallObj:SetActive(false)
    self._allGet.sprite = self._atlas:GetSprite("N32_hywf_mask01")
    self._getRect.localScale = Vector3(1, 1, 1)
  elseif self._cfg.RewardLevel == 2 then
    self._width = self._gridSize.x * 2
    self._itemNumObj:SetActive(true)
    self._itemNumSmallObj:SetActive(false)
    self._allGet.sprite = self._atlas:GetSprite("N32_hywf_mask03")
    self._getRect.localScale = Vector3(0.7, 0.7, 0.7)
  elseif self._cfg.RewardLevel == 3 then
    self._itemNumObj:SetActive(false)
    self._itemNumSmallObj:SetActive(true)
    self._allGet.sprite = self._atlas:GetSprite("N32_hywf_mask04")
    self._getRect.localScale = Vector3(0.7, 0.7, 0.7)
  end
  self._iconRect.sizeDelta = Vector2(self._width, self._height)
  if 1 < #rewards then
    self._itemNum:SetText("1")
    self._itemNumSmall:SetText("1")
  else
    local reward = rewards[1]
    local num = reward[2]
    self._itemNum:SetText(num)
    self._itemNumSmall:SetText(num)
  end
end

function UIActiveTaskAwardShowItem:IconBtnOnClick()
  if self._clickCallback then
    self._clickCallback(self)
  end
end

function UIActiveTaskAwardShowItem:GetItemInfo()
  return StringTable.Get(self._cfg.ItemInfo)
end

function UIActiveTaskAwardShowItem:GetPosition()
  local pos = Vector2(self._allGetObj.transform.position.x, self._allGetObj.transform.position.y)
  pos = Vector2(pos.x + self._width * 0.001, pos.y - self._height * 8.0E-4)
  return pos
end

function UIActiveTaskAwardShowItem:Close()
  self._anim:Play("uieff_UIActiveTaskAwardShowItem_out")
end
