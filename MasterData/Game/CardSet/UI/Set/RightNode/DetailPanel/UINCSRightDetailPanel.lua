local UINCSRightDetailPanel = class("UINCSRightDetailPanel", UIBaseNode)
local base = UIBaseNode
local UINCSRightDetailInfoList = require("Game.CardSet.UI.Set.RightNode.DetailPanel.UINCSRightDetailInfoList")

function UINCSRightDetailPanel:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.infoNode = UINCSRightDetailInfoList.New()
  self.infoNode:Init(self.ui.infoDetailsList)
end

function UINCSRightDetailPanel:InitCSRightDetailPanel(cardSetCtrl)
  self.cardSetCtrl = cardSetCtrl
  self.infoNode:SetCardSetCtrl(self.cardSetCtrl)
end

function UINCSRightDetailPanel:RefreshDetailAllCardData(cardSetData, cardData)
  self.infoNode:ShowDetailForAllCardData(cardSetData, cardData)
end

function UINCSRightDetailPanel:PlayShowTweenCSRightDt(isShow)
  self.ui.rootCanvas:DOKill()
  if isShow then
    self:Show()
    self.ui.rootCanvas.alpha = 0
    self.ui.rootCanvas:DOFade(1, 0.33):SetLink(self.gameObject)
  else
    self.ui.rootCanvas.alpha = 1
    self.ui.rootCanvas:DOFade(0, 0.33):OnComplete(function()
      self:Hide()
    end):SetLink(self.gameObject)
  end
end

function UINCSRightDetailPanel:OnDelete()
  base.OnDelete(self)
  self.infoNode:Delete()
end

return UINCSRightDetailPanel
