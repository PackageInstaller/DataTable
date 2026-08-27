local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local UINFactoryHeroListCard = class("UINFactoryHeroListCard", UINHeroCardItem)
local base = UINHeroCardItem
local UINFactoryHeroListCardAccItem = require("Game.Factory.UI.FactoryHeroList.UINFactoryHeroListCardAccItem")

function UINFactoryHeroListCard:OnInit()
  base.OnInit(self)
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.accItemPool = UIItemPool.New(UINFactoryHeroListCardAccItem, self.ui.additionItem)
  self.ui.additionItem:SetActive(false)
end

function UINFactoryHeroListCard:InitHeroCardItem(heroData, resloader, clickedAction, customDataDic)
  local cardData
  if customDataDic == nil then
    cardData = nil
  else
    cardData = customDataDic[heroData.dataId]
  end
  base.InitHeroCardItem(self, heroData, resloader, clickedAction)
  self:RefreshFactoryUI(cardData)
end

function UINFactoryHeroListCard:RefreshFactoryUI(cardData)
  self.cardData = cardData
  if cardData == nil then
    self.ui.obj_dispatchNode:SetActive(false)
    self.ui.obj_custom_OnSelect:SetActive(false)
    return
  end
  if cardData.num ~= nil then
    local levelRate, friendshipRate, RankRate = self.factoryController:GetOneHeroAccrateDetail(cardData.roomIndex, self.heroData.dataId)
    local oringinalSpeed = self.factoryController:GetRoomEnegeyBaseSpeedByIndex(cardData.roomIndex)
    local rateList = {}
    table.insert(rateList, levelRate)
    table.insert(rateList, friendshipRate)
    table.insert(rateList, RankRate)
    self.accItemPool:HideAll()
    for i = 1, 3 do
      local item = self.accItemPool:GetOne()
      item:SetValue(i - 1, oringinalSpeed, rateList[i])
    end
    self.ui.obj_dispatchNode:SetActive(false)
    self.ui.obj_custom_OnSelect:SetActive(true)
    self.ui.tex_FactoryNum.text = tostring(cardData.num)
    self.ui.tex_HeroName.text = self.heroData:GetName()
  else
    self.ui.obj_custom_OnSelect:SetActive(false)
    if cardData.isInOtherFactory then
      self.ui.obj_dispatchNode:SetActive(true)
    else
      self.ui.obj_dispatchNode:SetActive(false)
    end
  end
end

function UINFactoryHeroListCard:OnDelete()
  base.OnDelete(self)
end

return UINFactoryHeroListCard
