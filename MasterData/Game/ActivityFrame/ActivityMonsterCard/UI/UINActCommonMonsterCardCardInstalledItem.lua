local base = UIBaseNode
local UINActCommonMonsterCardCardInstalledItem = class("UINActCommonMonsterCardCardInstalledItem", base)
local UINActCommonMonsterCardCardItem = require("Game.ActivityFrame.ActivityMonsterCard.UI.UINActCommonMonsterCardCardItem")

function UINActCommonMonsterCardCardInstalledItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.cardItem = UINActCommonMonsterCardCardItem.New()
  self.cardItem:Init(self.ui.UINMonsterCardItem)
  self.cardItem:Hide()
  self.__isInstalled = false
end

function UINActCommonMonsterCardCardInstalledItem:Refresh_ACMCCII(monsterCardPlayData, cardData, onClickFunc, resloader)
  self.cardItem:Refresh_ACMCCI(monsterCardPlayData, cardData, onClickFunc, true, resloader)
end

function UINActCommonMonsterCardCardInstalledItem:PlayInstallTween_ACMCCII(isInstall, isNeedTween)
  local transform = self.cardItem.transform
  local move = transform.rect.height
  transform.localPosition = Vector2.zero
  self.ui.cg_UINMonsterCardItem.alpha = 1
  if isInstall then
    if self.__isInstalled then
      return
    end
    self.cardItem:Show()
    self.__isInstalled = true
    if isNeedTween then
      transform:DOLocalMoveY(move, 0.2):From(true):SetLink(self.gameObject)
      self.ui.cg_UINMonsterCardItem:DOFade(0, 0.2):From():SetLink(self.gameObject)
    end
  else
    if not self.__isInstalled then
      return
    end
    if isNeedTween then
      transform:DOLocalMoveY(move, 0.2):SetLink(self.gameObject)
      self.ui.cg_UINMonsterCardItem:DOFade(0, 0.2):SetLink(self.gameObject):OnComplete(function()
        self.__isInstalled = false
        self.cardItem:Hide()
      end)
    else
      self.cardItem:Hide()
    end
  end
end

function UINActCommonMonsterCardCardInstalledItem:OnDelete()
  base.OnDelete(self)
end

return UINActCommonMonsterCardCardInstalledItem
