local UINSupportHeroAth = class("UINSupportHeroAth", UIBaseNode)
local base = UIBaseNode
local AthUtil = require("Game.Arithmetic.AthUtil")

function UINSupportHeroAth:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.athItem = {
    obj = self.ui.areaItem,
    ui = {}
  }
  UIUtil.LuaUIBindingTable(self.athItem.obj.transform, self.athItem.ui)
end

function UINSupportHeroAth:InitAth(index, space, slotDic)
  self.ui.img_Icon:SetIndex(index - 1)
  if space > #self.athItem.ui.arry_AthSlot then
    space = #self.athItem.ui.arry_AthSlot
  end
  local gridUnlockList = ConfigData.game_config.athGridUnlockList
  local unlockGridDic = {}
  for pos, gridId in ipairs(gridUnlockList) do
    if pos <= space then
      unlockGridDic[gridId] = self.athItem.ui.color_unlocked
    end
  end
  if slotDic ~= nil then
    for gridId, itemId in pairs(slotDic) do
      local itemCfg = ConfigData.item[itemId]
      local athCfg = ConfigData.arithmetic[itemId]
      if itemCfg ~= nil and athCfg ~= nil then
        local gridList = AthUtil.GetAthGridIdListBySize(athCfg.size, gridId)
        local color = ItemQualityColor[itemCfg.quality]
        for _, eqGrid in ipairs(gridList) do
          unlockGridDic[eqGrid] = color
        end
      end
    end
  end
  for i = 1, #self.athItem.ui.arry_AthSlot do
    local gridId = AthUtil.AthUseGridList[i]
    local color = unlockGridDic[gridId]
    self.athItem.ui.arry_AthSlot[i].color = color ~= nil and color or self.athItem.ui.color_locked
  end
end

return UINSupportHeroAth
