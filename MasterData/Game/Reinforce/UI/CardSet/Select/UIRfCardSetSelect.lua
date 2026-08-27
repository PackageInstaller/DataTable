local base = UIBaseWindow
local UIRfCardSetSelect = class("UIRfCardSetSelect", base)
local UINRfCardSetSelectSetNode = require("Game.Reinforce.UI.CardSet.Select.SetNode.UINRfCardSetSelectSetNode")
local UINRfCardSetSelectDunNode = require("Game.Reinforce.UI.CardSet.Select.UINRfCardSetSelectDunNode")
local cs_ResLoader = CS.ResLoader
local cs_DoTween = CS.DG.Tweening.DOTween

function UIRfCardSetSelect:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnClickBackground)
  self._resLoader = cs_ResLoader.Create()
  self.SetNode = UINRfCardSetSelectSetNode.New()
  self.SetNode:Init(self.ui.SetNode)
  self.dunNode = UINRfCardSetSelectDunNode.New()
  self.dunNode:Init(self.ui.DungeonNode)
end

function UIRfCardSetSelect:OnShow()
  self:PlaySelectWinOpenTween()
end

function UIRfCardSetSelect:InitRfCardSetSelect(dataAll, alSelectList, actLongId, facIndex, supportFacIndex)
  self.SetNode:Show()
  self.dunNode:Hide()
  self.SetNode:InitSetNode(self, dataAll, alSelectList, actLongId, facIndex, supportFacIndex)
end

function UIRfCardSetSelect:InitRfCardSetSingleSelect(dataAll, selectData, onFactCardChangeFunc, isShowCurDetail)
  self.isSingleSelect = true
  self.onFactCardChangeFunc = onFactCardChangeFunc
  self.SetNode:Hide()
  self.dunNode:Show()
  self.dunNode:InitNRFCardSetDunNode(self, dataAll, selectData, onFactCardChangeFunc, isShowCurDetail)
end

function UIRfCardSetSelect:PlaySelectWinOpenTween()
  if self.selectWinOpenSeq ~= nil then
    self.selectWinOpenSeq:Restart()
    return
  end
  self.selectWinOpenSeq = cs_DoTween.Sequence()
  self.selectWinOpenSeq:SetAutoKill(false)
  self.selectWinOpenSeq:Append(self.ui.img_background:DOFade(0, 0.5):From()):Join(self.ui.SetNode.transform:DOAnchorPosX(1380, 0.5):From()):Join(self.ui.DungeonNode.transform:DOAnchorPosX(1380, 0.5):From()):Join(self.ui.group_setNode:DOFade(0, 0.5):From()):Join(self.ui.group_dungeonNode:DOFade(0, 0.5):From()):Join(self.ui.group_left:DOFade(0, 0.5):From())
end

function UIRfCardSetSelect:PlaySelectWinCloseTween()
  self.selectWinCloseSeq = cs_DoTween.Sequence()
  self.selectWinCloseSeq:Append(self.ui.img_background:DOFade(0, 0.5)):Join(self.ui.SetNode.transform:DOAnchorPosX(1380, 0.5)):Join(self.ui.DungeonNode.transform:DOAnchorPosX(1380, 0.5)):Join(self.ui.group_setNode:DOFade(0, 0.5)):Join(self.ui.group_dungeonNode:DOFade(0, 0.5)):Join(self.ui.group_left:DOFade(0, 0.5)):AppendCallback(function()
    self:Delete()
  end)
end

function UIRfCardSetSelect:SetDetailWin(itemBase, win)
  if self.selectedDetailItem ~= nil then
    self.selectedDetailItem:CloseCheck()
  end
  self.selectedDetailItem = itemBase
  win.transform:SetParent(self.ui.holder)
  self.ui.obj_titleBg:SetActive(true)
end

function UIRfCardSetSelect:OnClickBackground()
  local closeSuccess = self:CloseDetailWin()
  if closeSuccess then
    return
  end
  UIUtil.OnClickBackByWinId(UIWindowTypeID.UIReinforceCardSetSelect)
end

function UIRfCardSetSelect:CloseDetailWin()
  local isCloseSuccess = false
  local win = UIManager:GetWindow(UIWindowTypeID.UIReinforceCardDetailSys)
  if win then
    UIManager:DeleteWindow(UIWindowTypeID.UIReinforceCardDetailSys)
    isCloseSuccess = true
  end
  win = UIManager:GetWindow(UIWindowTypeID.UIReinforceCardDetailFac)
  if win then
    UIManager:DeleteWindow(UIWindowTypeID.UIReinforceCardDetailFac)
    isCloseSuccess = true
  end
  if isCloseSuccess then
    self.ui.obj_titleBg:SetActive(false)
    if self.selectedDetailItem then
      self.selectedDetailItem:CloseCheck()
      self.selectedDetailItem = nil
    end
  end
  return isCloseSuccess
end

function UIRfCardSetSelect:BackAction(toHome)
  if not toHome then
    self:PlaySelectWinCloseTween()
  end
end

function UIRfCardSetSelect:OnDelete()
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  self:CloseDetailWin()
  self.SetNode:Delete()
  self.dunNode:Delete()
  if self.selectWinOpenSeq ~= nil then
    self.selectWinOpenSeq:Kill()
    self.selectWinOpenSeq = nil
  end
  if self.selectWinCloseSeq ~= nil then
    self.selectWinCloseSeq:Kill()
    self.selectWinCloseSeq = nil
  end
  base.OnDelete(self)
end

return UIRfCardSetSelect
