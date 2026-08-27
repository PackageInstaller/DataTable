local UIAthReplaceHero = class("UIAthReplaceHero", UIBaseWindow)
local base = UIBaseWindow
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")

function UIAthReplaceHero:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.__OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.__OnClickCancel)
end

function UIAthReplaceHero:InitAthReplaceHero(heroId, replaceHeroId, confirmFunc, resLoader)
  self.confirmFunc = confirmFunc
  local beforItem = UINHeroHeadItem.New()
  beforItem:Init(self.ui.beforHeadItem)
  local beforHeroData = PlayerDataCenter.heroDic[replaceHeroId]
  beforItem:InitHeroHeadItem(beforHeroData, resLoader)
  self.beforItem = beforItem
  local afterItem = UINHeroHeadItem.New()
  afterItem:Init(self.ui.afterHeadItem)
  local afterHeroData = PlayerDataCenter.heroDic[heroId]
  afterItem:InitHeroHeadItem(afterHeroData, resLoader)
  self.afterItem = afterItem
end

function UIAthReplaceHero:__OnClickConfirm()
  if self.confirmFunc ~= nil then
    self.confirmFunc()
  end
  self:CloseWindow()
end

function UIAthReplaceHero:__OnClickCancel()
  self:CloseWindow()
end

function UIAthReplaceHero:CloseWindow()
  UIManager:DeleteWindow(self.__typeID, true)
end

function UIAthReplaceHero:OnDelete()
  self.beforItem:Delete()
  self.afterItem:Delete()
end

return UIAthReplaceHero
