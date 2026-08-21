_class("UIWorldBossElement", UICustomWidget)
UIWorldBossElement = UIWorldBossElement

function UIWorldBossElement:OnShow(uiParams)
  self:InitWidget()
  self._atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
end

function UIWorldBossElement:InitWidget()
  self._element1 = self:GetUIComponent("Image", "e1")
end

function UIWorldBossElement:SetData(cfg_monster)
  if cfg_monster then
    local element = cfg_monster.ElementType
    local spr = UIPropertyHelper:GetInstance():GetColorBlindSprite(ElementIcon[element])
    if self._element1 and spr and self._atlasProperty and self.view then
      self._element1.sprite = self._atlasProperty:GetSprite(spr)
    end
  end
end
