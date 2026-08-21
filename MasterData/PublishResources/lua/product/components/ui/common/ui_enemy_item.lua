_class("UIEnemyItem", UICustomWidget)
UIEnemyItem = UIEnemyItem

function UIEnemyItem:OnShow(uiParams)
  self:InitWidget()
end

function UIEnemyItem:InitWidget()
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self.iconLoader = self:GetUIComponent("RawImageLoader", "UIEnemyItem")
  self.bossGo = self:GetGameObject("bossGo")
  self.eliteGo = self:GetGameObject("eliteGo")
  self.element = self:GetUIComponent("Image", "element")
  self.elementIcons = {
    [1] = "bing_color",
    [2] = "huo_color",
    [3] = "sen_color",
    [4] = "lei_color"
  }
end

function UIEnemyItem:SetData(monsterID, idx, onClick)
  self._id = monsterID
  self._idx = idx
  self._onClick = onClick
  local cfg = Cfg.cfg_monster[monsterID]
  if cfg then
    local cfgClass = Cfg.cfg_monster_class[cfg.ClassID]
    if cfgClass.EnemyStaticBody then
      self.iconLoader:LoadImage(cfgClass.EnemyStaticBody)
    end
    self.element.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(self.elementIcons[cfg.ElementType]))
    local isElite = false
    if cfg.EliteID and table.count(cfg.EliteID) > 0 then
      isElite = true
    end
    self.eliteGo:SetActive(isElite)
    self.bossGo:SetActive(cfgClass.MonsterType == MonsterType.Boss)
  else
    Log.fatal("###cfg is nil ! monster id  is ", monsterID)
  end
end

function UIEnemyItem:clickAreaOnClick(go)
  if self._onClick then
    self._onClick(self._idx)
  end
end
