_class("UISeasonMainLevelListAsset", UICustomWidget)
UISeasonMainLevelListAsset = UISeasonMainLevelListAsset

function UISeasonMainLevelListAsset:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMainLevelListAsset:InitWidget()
  self.icon = self:GetUIComponent("Image", "icon")
  self.count = self:GetUIComponent("UILocalizationText", "count")
end

function UISeasonMainLevelListAsset:SetData(id, count)
  local zeros
  if 99999 < count then
    Log.exception("奖励数量不可超过5位:", count)
  elseif count < 10000 and 999 < count then
    zeros = "0"
  elseif count < 1000 and 99 < count then
    zeros = "00"
  elseif count < 100 and 9 < count then
    zeros = "000"
  elseif count < 10 and 0 < count then
    zeros = "0000"
  end
  if string.isnullorempty(zeros) then
    self.count:SetText(count)
  else
    self.count:SetText("<color=#51504e>" .. zeros .. "</color>" .. count)
  end
  local cfg = Cfg.cfg_top_tips[id]
  local atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self.icon.sprite = atlas:GetSprite(cfg.Icon)
end
