local UIFactoryHeroListCover = class("UIFactoryHeroListCover", UIBaseWindow)
local base = UIBaseWindow
local UINFactoryHeroList = require("Game.Factory.UI.FactoryHeroList.UINFactoryHeroList")
local cs_MessageCommon = CS.MessageCommon

function UIFactoryHeroListCover:OnInit()
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.factoryHeroList = UINFactoryHeroList.New()
  self.factoryHeroList:Init(self.ui.uI_HeroList)
  self.factoryHeroList:SetCallback(BindCallback(self, self.UpdateEnergyAddUI), BindCallback(self, self.OnConfirm))
  self.baseAccRate = 0
end

function UIFactoryHeroListCover:InitSelectHero(roomIndex, closeCallback)
  self.roomIndex = roomIndex
  self.closeCallback = closeCallback
  UIUtil.SetTopStatus(self, self.OnReturnClicked)
  self.factoryHeroList:InitFactoryHeroList(roomIndex)
end

function UIFactoryHeroListCover:UpdateEnergyAddUI(heroIdList, isInit)
  local accRate = self.factoryController:GetHeroEnterAccrate(self.roomIndex, heroIdList)
  local baseSpeed = self.factoryController:GetRoomEnegeyBaseSpeedByIndex(self.roomIndex)
  if 0 < #heroIdList then
    self.ui.tex_TipsContent:SetIndex(0, GetPreciseDecimalStr(baseSpeed * 3600, 1), GetPreciseDecimalStr(baseSpeed * (1 + accRate) * 3600, 1))
  else
    self.ui.tex_TipsContent:SetIndex(1, GetPreciseDecimalStr(baseSpeed * 3600, 1))
  end
end

function UIFactoryHeroListCover:OnConfirm()
  cs_MessageCommon.ShowMessageTips((ConfigData:GetTipContent(TipContent.Factory_HeroEnterSuccess)))
  self:OnReturnClicked()
  UIUtil.OnClickBackByUiTab(self)
end

function UIFactoryHeroListCover:OnReturnClicked()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self:Hide()
end

function UIFactoryHeroListCover:OnDelete()
  self.factoryHeroList:OnDelete()
  base.OnDelete(self)
end

return UIFactoryHeroListCover
