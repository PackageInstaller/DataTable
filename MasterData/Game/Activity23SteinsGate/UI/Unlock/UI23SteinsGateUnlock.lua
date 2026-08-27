local UI23SteinsGateUnlock = class("UI23SteinsGateUnlock", UIBaseWindow)
local base = UIBaseWindow
local CS_DOTween = CS.DG.Tweening.DOTween
local ActCommonEnum = require("Game.Common.Activity.ActCommonEnum")
local eActInteract23SteinsGate = require("Game.ActivityLobby.Activity.2023SteinsGate.eActInteract")

function UI23SteinsGateUnlock:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseUnlock, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Check, self, self.OnClickJump)
  UIUtil.AddButtonListener(self.ui.btn_BG, self, self.OnClickBG)
  self.__posbtn_Check = self.ui.btn_Check.transform.localPosition
  self.__posNoticeObj = self.ui.NoticeObj.localPosition
  self.__posUnlock = self.ui.Unlock.localPosition
  self.__posTitle = self.ui.Title.localPosition
end

function UI23SteinsGateUnlock:Init23SteinsGateUnlock(unlockInfo, actId, lobbyId, callback)
  self._unlockInfo = unlockInfo
  self._actId = actId
  self._lobbyId = lobbyId
  self._callback = callback
  self._unlockList = self._unlockInfo:GetActUnlockInfoList()
  self._index = 0
  self:ShowNext()
end

function UI23SteinsGateUnlock:Bind23SteinsGateUnlockFunc(repeatDgCheckFunc, repeatDgJumpFunc, cardSetCheckFunc, cardSetJumpFunc)
  self._repeatDgCheckFunc = repeatDgCheckFunc
  self._repeatDgJumpFunc = repeatDgJumpFunc
  self._cardSetCheckFunc = cardSetCheckFunc
  self._cardSetJumpFunc = cardSetJumpFunc
end

function UI23SteinsGateUnlock:ShowNext()
  self._index = self._index + 1
  local unlockElemt = self._unlockList[self._index]
  if unlockElemt.unlockType == ActCommonEnum.ActUnlockType.InteractId then
    self._unlockId = unlockElemt.unlockId
    local actionCfg = ConfigData.activity_lobby_interact_action[self._lobbyId][self._unlockId]
    local actionName = LanguageUtil.GetLocaleText(actionCfg.obj_func_name)
    self.ui.tex_Unlock:SetIndex(0, actionName)
    self:__PlayTween()
    self:__RecordUnlockIsLooked()
  else
    self._unlockId = nil
    self:OnClickBG()
  end
end

function UI23SteinsGateUnlock:__PlayTween()
  if self.sequence ~= nil then
    self.sequence:Complete(true)
    self.sequence = nil
  end
  self.ui.cg_Main.alpha = 0
  self.ui.btn_Check.transform.localPosition = self.__posbtn_Check
  self.ui.NoticeObj.localPosition = self.__posNoticeObj
  self.ui.Unlock.localPosition = self.__posUnlock
  self.ui.Title.localPosition = self.__posTitle
  self.sequence = CS_DOTween.Sequence():AppendInterval(0.4):Append(self.ui.cg_Main:DOFade(1, 0.35)):Join(self.ui.btn_Check.transform:DOLocalMoveY(-20, 0.5):From():SetRelative(true)):Join(self.ui.NoticeObj:DOLocalMoveY(-50, 0.5):From():SetRelative(true)):Join(self.ui.Unlock:DOLocalMoveY(-20, 0.5):From():SetRelative(true)):Join(self.ui.Title:DOLocalMoveY(20, 0.5):From():SetRelative(true)):SetLink(self.gameObject)
end

function UI23SteinsGateUnlock:OnClickJump()
  self._unlockInfo:ClearFirstActUnlockInfo()
  if self._unlockInfo:IsExistActUnlockInfo() then
    self:Hide()
  else
    UIUtil.OnClickBackByUiTab(self)
  end
  if self._unlockId == eActInteract23SteinsGate.eLbIntrctEntityId.RepeatDg then
    if self._repeatDgCheckFunc ~= nil and self._repeatDgCheckFunc() and self._repeatDgJumpFunc ~= nil then
      self._repeatDgJumpFunc()
    end
  elseif self._unlockId == eActInteract23SteinsGate.eLbIntrctEntityId.CardSet and self._cardSetCheckFunc ~= nil and self._cardSetCheckFunc() and self._cardSetJumpFunc ~= nil then
    self._cardSetJumpFunc()
  end
  self._unlockId = nil
end

function UI23SteinsGateUnlock:OnClickBG()
  if self._index < #self._unlockList then
    self:ShowNext()
  else
    UIUtil.OnClickBackByUiTab(self)
  end
end

function UI23SteinsGateUnlock:__RecordUnlockIsLooked()
  if self._unlockId ~= nil and self._actId ~= nil then
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    if self._unlockId == eActInteract23SteinsGate.eLbIntrctEntityId.RepeatDg then
      saveUserData:SetSteinsGateRepeatLooked(self._actId)
    elseif self._unlockId == eActInteract23SteinsGate.eLbIntrctEntityId.CardSet then
      saveUserData:SetSteinsGateCardSetLooked(self._actId)
    end
  end
end

function UI23SteinsGateUnlock:OnCloseUnlock()
  self._unlockInfo:ClearActUnlockInfo()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

return UI23SteinsGateUnlock
