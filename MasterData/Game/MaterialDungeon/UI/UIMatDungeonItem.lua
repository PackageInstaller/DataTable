local UINDungeonItemBase = require("Game.CommonUI.DungeonPanelWidgets.UINDungeonItemBase")
local UIMatDungeonItem = class("UIMatDungeonItem", UINDungeonItemBase)
local base = UINDungeonItemBase

function UIMatDungeonItem:OnDelete()
  base.OnDelete(self)
end

function UIMatDungeonItem:InitDungeonItem(dungeonData, resLoader, clickEvent)
  base.InitDungeonItem(self, dungeonData, resLoader, clickEvent)
  local dungeonCfg = dungeonData:GetDungeonCfg()
  self.ui.img_Icon.sprite = AtlasUtil.GetSpriteFromAtlas("CommonDungeon", dungeonCfg.item_icon, resLoader)
  local path = PathConsts:GetMaterialDungeonBGIconPath(dungeonCfg.dungeon_icon)
  if not string.IsNullOrEmpty(path) then
    self.iconTexture = resLoader:LoadABAsset(path)
  end
  path = PathConsts:GetMaterailDungeonPicPath(dungeonCfg.dungeon_img)
  if not string.IsNullOrEmpty(path) then
    self.bannerTexture = resLoader:LoadABAsset(path)
  end
end

return UIMatDungeonItem
