local base = require("Game.WarChess.UI.Info.Info.UINWarChessInfoInfoBase")
local UINWarChessInfoMonsterDrop = class("UINWarChessInfoMonsterDrop", base)
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UINWarChessInfoMonsterDrop:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__iconList = {}
  self.__iconRecycleList = {}
  self.itemPool = UIItemPool.New(UINBaseItem, self.ui.uINBaseItem)
  self.ui.uINBaseItem:SetActive(false)
end

function UINWarChessInfoMonsterDrop:RefreshWCMonsterDropIcons(monsterDropIconList)
  self.itemPool:HideAll()
  for index, itemId in ipairs(monsterDropIconList) do
    local itemCfg = ConfigData.item[itemId]
    local baseItem = self.itemPool:GetOne()
    if itemCfg == nil then
      error("monster drop itme not exist, item id:" .. tostring(itemId))
      return
    end
    baseItem:InitBaseItem(itemCfg)
  end
end

function UINWarChessInfoMonsterDrop:OnDelete()
  base.OnDelete(self)
end

return UINWarChessInfoMonsterDrop
