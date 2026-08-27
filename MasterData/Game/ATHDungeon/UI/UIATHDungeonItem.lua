local UINDungeonItemBase = require("Game.CommonUI.DungeonPanelWidgets.UINDungeonItemBase")
local UIATHDungeonItem = class("UIATHDungeonItem", UINDungeonItemBase)
local base = UINDungeonItemBase

function UIATHDungeonItem:OnDelete()
  base.OnDelete(self)
end

function UIATHDungeonItem:InitDungeonItem(dungeonData, resLoader, clickEvent)
  base.InitDungeonItem(self, dungeonData, resLoader, clickEvent)
  local dungeonCfg = dungeonData:GetDungeonCfg()
  self.index = (tonumber(dungeonCfg.item_icon) or 1) - 1
  local path = PathConsts:GetMaterailDungeonPicPath(dungeonCfg.dungeon_img)
  if not string.IsNullOrEmpty(path) then
    self.bannerTexture = resLoader:LoadABAsset(path)
  end
  if not IsNull(self.ui.img_SelectBG) then
    self.ui.img_SelectBG:SetIndex(dungeonCfg.img_bottom_idx)
  end
  self:_UpdBlueDot(dungeonData)
end

function UIATHDungeonItem:_UpdBlueDot(dungeonData)
  local dungeonType = dungeonData.dungeonTypeData.dungeonType
  local dungeonId = dungeonData.dungeonId
  local ok, dotNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceSrcDun, dungeonType, dungeonId)
  self:ShowAthDgItemeBlueDot(ok and dotNode:GetBlueDotCount() > 0)
end

function UIATHDungeonItem:ShowAthDgItemeBlueDot(isShow)
  self.ui.obj_blueDot:SetActive(isShow)
  self._bluedotShow = isShow
end

function UIATHDungeonItem:IsShowAthDgItemeBlueDot()
  return self._bluedotShow
end

return UIATHDungeonItem
