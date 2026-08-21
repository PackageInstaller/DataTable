_class("UIACtivityCN9LevelAwardOneItem", UICustomWidget)
UIACtivityCN9LevelAwardOneItem = UIACtivityCN9LevelAwardOneItem

function UIACtivityCN9LevelAwardOneItem:OnShow(uiParams)
  self:InitWidget()
end

function UIACtivityCN9LevelAwardOneItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "Icon")
  self.got = self:GetGameObject("Got")
  self._Count = self:GetUIComponent("UILocalizationText", "Count")
end

function UIACtivityCN9LevelAwardOneItem:SetData(award, ClickCB)
  self.award = award
  self.id = self.award[1]
  self.click = ClickCB
  self:_SetIcon()
end

function UIACtivityCN9LevelAwardOneItem:_SetIcon()
  local itemId = self.award[1]
  local count = self.award[2]
  self._cfg_item = Cfg.cfg_item[itemId]
  if self._cfg_item == nil then
    Log.fatal("[quest] error --> cfg_item is nil ! id --> " .. itemId)
    return
  end
  local icon = self._cfg_item.Icon
  self.icon:LoadImage(icon)
  self._Count:SetText(count)
end

function UIACtivityCN9LevelAwardOneItem:ClickBtnOnClick(go)
  if self.click then
    self.click(self.id)
  end
end

function UIACtivityCN9LevelAwardOneItem:SetPass(pass)
  self.got:SetActive(pass)
end
