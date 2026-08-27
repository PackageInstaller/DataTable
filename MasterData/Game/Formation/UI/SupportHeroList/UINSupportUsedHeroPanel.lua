local UINSupportUsedHeroPanel = class("UINSupportUsedHeroPanel", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")

function UINSupportUsedHeroPanel:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self.__OnClickClose)
  self.headPool = UIItemPool.New(UINHeroHeadItem, self.ui.heroHeadItem)
  self.ui.heroHeadItem:SetActive(false)
end

function UINSupportUsedHeroPanel:InitUsedSupportHero(assistHeroTime)
  self.headPool:HideAll()
  if assistHeroTime == nil then
    return
  end
  for heroId, usedTimes in pairs(assistHeroTime) do
    if 0 < usedTimes then
      local headItem = self.headPool:GetOne()
      headItem:InitHeroHeadItemWithId(heroId, nil)
    end
  end
end

function UINSupportUsedHeroPanel:BackAction()
  self:Hide()
end

function UINSupportUsedHeroPanel:__OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UINSupportUsedHeroPanel:OnShow()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  UIUtil.HideTopStatus()
end

function UINSupportUsedHeroPanel:OnHide()
  UIUtil.ReShowTopStatus()
end

function UINSupportUsedHeroPanel:OnDelete()
  base.OnDelete(self)
end

return UINSupportUsedHeroPanel
