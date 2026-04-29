_class("UIN0CookRewardItem", UICustomWidget)
UIN0CookRewardItem = UIN0CookRewardItem

function UIN0CookRewardItem:OnShow(uiParams)
  self._atlas = self:GetAsset("CookGame.spriteatlas", LoadType.SpriteAtlas)
  self:InitWidget()
end

function UIN0CookRewardItem:InitWidget()
  self.num = self:GetUIComponent("UILocalizationText", "num")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
end

function UIN0CookRewardItem:SetData(tplId, num, clickCall)
  self.num:SetText(num)
  local cfg = Cfg.cfg_item[tplId]
  if cfg then
    self.icon:LoadImage(cfg.Icon)
  end
  self.tplId = tplId
  self.clickCall = clickCall
end

function UIN0CookRewardItem:RootOnClick(go)
  if self.clickCall then
    local pos = go.transform.position
    self.clickCall(self.tplId, pos)
  end
end
