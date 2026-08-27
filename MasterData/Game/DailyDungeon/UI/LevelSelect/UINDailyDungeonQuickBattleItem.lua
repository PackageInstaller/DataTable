local UINDailyDungeonQuickBattleItem = class("UINDailyDungeonQuickBattleItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINDailyDungeonQuickBattleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
  self.ui.uINBaseItemWithCount:SetActive(false)
end

function UINDailyDungeonQuickBattleItem:InitDailyQuickBattleItem(dungeonStageCfg, index, isDouble, rewardDic)
  self.ui.tex_CNName.text = LanguageUtil.GetLocaleText(dungeonStageCfg.name)
  self.ui.tex_ENName:SetIndex(0, tostring(index))
  self.ui.obj_DoubleDrop:SetActive(isDouble)
  self._itemPool:HideAll()
  if rewardDic ~= nil then
    for itemId, itemCount in pairs(rewardDic) do
      local itemCfg = ConfigData.item[itemId]
      local item = self._itemPool:GetOne()
      item:InitItemWithCount(itemCfg, itemCount)
    end
  end
end

function UINDailyDungeonQuickBattleItem:ShowDailyQuickBattleItem(flag)
  self.ui.root:SetActive(flag)
end

return UINDailyDungeonQuickBattleItem
