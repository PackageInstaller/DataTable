local base = UIBaseWindow
local UIWarChessTimeRewind = class("UIWarChessTimeRewind", base)
local UINWarChessTimeRewindItem = require("Game.WarChess.UI.TimeRewind.UINWarChessTimeRewindItem")

function UIWarChessTimeRewind:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.__OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.__OnClickCancel)
  UIUtil.AddButtonListener(self.ui.btn_Rewind, self, self.__OnClickReturnBattleBefore)
  self.turnItemPool = UIItemPool.New(UINWarChessTimeRewindItem, self.ui.obj_turn)
  self.ui.obj_turn:SetActive(false)
  self.__onSelectTurnItem = BindCallback(self, self.__OnSelectTurnItem)
  self.__selectedTurnItem = nil
  self.ui.scrollRect.onValueChanged:AddListener(BindCallback(self, self.__OnValueChange))
end

function UIWarChessTimeRewind:InitWCTimeRewind()
  self._returnBattleBeforeFunc = nil
  self._turnBackFunc = nil
  self.ui.rewind:SetActive(false)
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local curTurnNum = wcCtrl.turnCtrl:GetWCTurnNum()
  self.__eSize = 1 / (curTurnNum - 1)
  self.turnItemPool:HideAll()
  for turnNum = 1, curTurnNum do
    local turnItem = self.turnItemPool:GetOne(true)
    local isCur = curTurnNum == turnNum
    turnItem:InitWCTRTurnItem(turnNum, isCur, self.__onSelectTurnItem)
    if isCur then
      self:__OnSelectTurnItem(turnItem)
    end
  end
  local rewindTotalTime, rewindLeftTime = wcCtrl.turnCtrl:GetWCRewindTimes()
  self.ui.tex_Turn.text = tostring(rewindLeftTime) .. "/" .. tostring(rewindTotalTime)
end

function UIWarChessTimeRewind:InitWCTimeRewindInBattle(turnBackFunc, returnBattleBeforeFunc)
  self:InitWCTimeRewind()
  self._returnBattleBeforeFunc = returnBattleBeforeFunc
  self._turnBackFunc = turnBackFunc
  self.ui.rewind:SetActive(true)
  local rightOffset = self.ui.turnGroup.padding.right
  self.ui.turnGroup.padding.right = rightOffset - 320
end

function UIWarChessTimeRewind:__OnSelectTurnItem(turnItem)
  if self.__selectedTurnItem ~= nil then
    self.__selectedTurnItem:SetIsSelected(false)
  end
  self.__selectedTurnItem = turnItem
  self.__selectedTurnItem:SetIsSelected(true)
  local rewindTurnNum = self.__selectedTurnItem.turnNum
  self.ui.scrollRect.horizontalNormalizedPosition = self.__eSize * (rewindTurnNum - 1)
end

function UIWarChessTimeRewind:__OnValueChange()
  local rate = self.ui.scrollRect.horizontalNormalizedPosition
end

function UIWarChessTimeRewind:__OnClickConfirm()
  if self.__selectedTurnItem == nil then
    return
  end
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local wid = wcCtrl:GetWCId()
  local rewindTurnNum = self.__selectedTurnItem.turnNum
  if self._turnBackFunc ~= nil then
    self._turnBackFunc(wid, rewindTurnNum)
  else
    wcCtrl.wcNetworkCtrl:CS_WarChess_ResetTheRound(wid, rewindTurnNum, function()
      self:Delete()
    end)
  end
end

function UIWarChessTimeRewind:__OnClickCancel()
  self:Delete()
end

function UIWarChessTimeRewind:__OnClickReturnBattleBefore()
  self:Delete()
  if self._returnBattleBeforeFunc ~= nil then
    self._returnBattleBeforeFunc()
  end
end

function UIWarChessTimeRewind:OnDelete()
end

return UIWarChessTimeRewind
