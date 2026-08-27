local UINEventNoviceSignItemII = class("UINEventNoviceSignItemII", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINEventNoviceSignItemII:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._item = UINBaseItemWithCount.New()
  self._item:Init(self.ui.obj_RewardItem)
end

function UINEventNoviceSignItemII:InitNoviceSignItemII(day, itemId, itemCount)
  local itemCfg = ConfigData.item[itemId]
  self._item:InitItemWithCount(itemCfg, itemCount)
  self.ui.img_date:SetIndex(day - 1)
  self.ui.obj_Received:SetActive(false)
  self.ui.tex_ItemName.text = LanguageUtil.GetLocaleText(itemCfg.name)
end

function UINEventNoviceSignItemII:SetNoviceSignItemIIReviced(flag)
  self.ui.obj_Received:SetActive(flag)
end

return UINEventNoviceSignItemII
