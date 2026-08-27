local UINFmtFairyBtn = class("UINFmtFairyBtn", UIBaseNode)
local base = UIBaseNode
local UINFairyCultivateCardItem = require("Game.Fairy.UI.UINFairyCultivateCardItem")

function UINFmtFairyBtn:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Fairy, self, self.__OnClick)
  self.fairyItemNode = UINFairyCultivateCardItem.New()
  self.fairyItemNode:Init(self.ui.obj_Select)
  self.fairyItemNode:Hide()
end

function UINFmtFairyBtn:SetCurFmtFairy(fairyData, resloader, clickCallback)
  self.clickCallback = clickCallback
  if fairyData == nil then
    self.fairyItemNode:Hide()
    self.ui.obj_infoGroup:SetActive(true)
    return
  end
  self.ui.obj_infoGroup:SetActive(false)
  self.fairyItemNode:Show()
  self.fairyItemNode:InitFairyCultivateCardItem(fairyData, nil, resloader, nil)
end

function UINFmtFairyBtn:__OnClick()
  if self.clickCallback ~= nil then
    self.clickCallback()
  end
end

function UINFmtFairyBtn:OnDelete()
end

return UINFmtFairyBtn
