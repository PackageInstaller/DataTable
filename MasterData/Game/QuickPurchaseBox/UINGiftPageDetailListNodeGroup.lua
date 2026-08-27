local UINGiftPageDetailListNodeGroup = class("UINGiftPageDetail", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINGiftPageDetailListNodeGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_viewHero, self, self.OnClickBtnView)
  self.rewardItem = UINBaseItemWithCount.New()
  self.rewardItem:Init(self.ui.uiNBaseItem)
end

function UINGiftPageDetailListNodeGroup:InitGiftPageDetailListNodeGroup(itemCfg, count)
  self.rewardItem:InitItemWithCount(itemCfg, count)
  self.ui.tex_ItemName.text = LanguageUtil.GetLocaleText(itemCfg.name)
end

function UINGiftPageDetailListNodeGroup:SetRaffleItemWeight(weight)
  if weight then
    self.ui.tex_Rate.gameObject:SetActive(true)
    self.ui.tex_Rate.text = tostring(weight) .. "%"
  else
    self.ui.tex_Rate.gameObject:SetActive(false)
  end
end

function UINGiftPageDetailListNodeGroup:SetItemView(itemCfg, callback)
  local isSkin = itemCfg.type == eItemType.Skin
  self.ui.obj_checkView:SetActive(isSkin)
  local hasRate = self.ui.tex_Rate.gameObject.activeSelf
  self.ui.obj_checkLine:SetActive(hasRate and isSkin)
  if isSkin and callback ~= nil then
    self.clickItemCfg = itemCfg
    self.clickFunc = callback
  end
end

function UINGiftPageDetailListNodeGroup:OnClickBtnView()
  if self.clickFunc ~= nil then
    self.clickFunc(self.clickItemCfg)
  end
end

return UINGiftPageDetailListNodeGroup
