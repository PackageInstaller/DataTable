local UINLtrResultHeroConvert = class("UINLtrResultHeroConvert", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINLtrResultHeroConvert:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.rewardItem:SetActive(false)
  self.itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.rewardItem)
end

function UINLtrResultHeroConvert:HideAllChild()
  self.itemPool:HideAll()
end

function UINLtrResultHeroConvert:GetOneChlid(itemCfg, num, resLoader)
  local item = self.itemPool:GetOne()
  item:InitItemWithCount(itemCfg, num)
  self.resLoader = resLoader
end

function UINLtrResultHeroConvert:ShowHeroConvertFx()
  for _, item in ipairs(self.itemPool.listItem) do
    local isGreatItem = ConfigData.game_config.itemWithGreatFxDic[item.itemCfg.id]
    if isGreatItem then
      item:LoadGetGreatRewardFx(self.resLoader)
    end
  end
end

function UINLtrResultHeroConvert:OnDelete()
  self.itemPool:DeleteAll()
  base.OnDelete(self)
end

return UINLtrResultHeroConvert
