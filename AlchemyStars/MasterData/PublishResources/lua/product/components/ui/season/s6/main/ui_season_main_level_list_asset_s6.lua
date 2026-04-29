_class("UISeasonMainLevelListAssetS6", UICustomWidget)
UISeasonMainLevelListAssetS6 = UISeasonMainLevelListAssetS6

function UISeasonMainLevelListAssetS6:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMainLevelListAssetS6:InitWidget()
  self.icon = self:GetUIComponent("Image", "icon")
  self.count = self:GetUIComponent("UILocalizationText", "count")
end

function UISeasonMainLevelListAssetS6:SetData(id, count)
  local zeros
  if 9999 < count then
    Log.exception("奖励数量不可超过4位:", count)
  elseif count < 1000 and 99 < count then
    zeros = "0"
  elseif count < 100 and 9 < count then
    zeros = "00"
  elseif count < 10 and 0 < count then
    zeros = "000"
  end
  if string.isnullorempty(zeros) then
    self.count:SetText(count)
  else
    self.count:SetText(zeros .. count)
  end
  local cfg = Cfg.cfg_top_tips[id]
  local atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self.icon.sprite = atlas:GetSprite(cfg.Icon)
end
