local base = UIBaseNode
local UINReinforceCardDunCardInfoNode = class("UINReinforceCardDunCardInfoNode", base)
local UINRfCardFacSmall = require("Game.Reinforce.UI.FactorCard.UINRfCardFacSmall")

function UINReinforceCardDunCardInfoNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListenerWithArg(self.ui.Btn_CheckDetails, self, self.OnclickSelectFactCard, true)
  UIUtil.AddButtonListener(self.ui.Btn_self, self, self.OnclickSelectFactCard)
  self.cardNode = UINRfCardFacSmall.New()
  self.cardNode:Init(self.ui.UINRfCardFacSmall)
end

function UINReinforceCardDunCardInfoNode:BindActData(actData, resloader, showSelectFactCard)
  self.actData = actData
  self.resloader = resloader
  self.showSelectFactCard = showSelectFactCard
end

function UINReinforceCardDunCardInfoNode:RefreshCardInfoNode(factCardData)
  if factCardData == nil then
    self.ui.NoSet:SetActive(true)
    self.ui.IsSet:SetActive(false)
    return
  end
  self.ui.NoSet:SetActive(false)
  self.ui.IsSet:SetActive(true)
  self.cardNode:InitRfCardFacSmall(factCardData, self.resloader, true)
end

function UINReinforceCardDunCardInfoNode:OnclickSelectFactCard(isShowCurDetail)
  if self.showSelectFactCard ~= nil then
    self.showSelectFactCard(isShowCurDetail)
  end
end

function UINReinforceCardDunCardInfoNode:OnDelete()
  base.OnDelete(self)
end

return UINReinforceCardDunCardInfoNode
