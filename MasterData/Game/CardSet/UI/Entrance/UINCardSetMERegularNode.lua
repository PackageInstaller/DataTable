local UINCardSetMERegularNode = class("UINCardSetMERegularNode", UIBaseNode)
local base = UIBaseNode
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")

function UINCardSetMERegularNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Jump, self, self.__OpenCardSet)
  UIUtil.AddButtonListener(self.ui.btn_Rewind, self, self.__OnClickRewind)
  UIUtil.AddButtonListener(self.ui.btn_BpRerward, self, self.__OnClickBpRerward)
end

function UINCardSetMERegularNode:InitCardSetMENode(cardSetCtrl)
  self.cardSetCtrl = cardSetCtrl
  self:RefreshCardSetMERegularMode()
  self:__InitReddotListern()
end

function UINCardSetMERegularNode:RefreshCardSetMERegularMode()
  local cardSetData = self.cardSetCtrl:GetCardSetData(CardSetEnum.eSetType.normal)
  local curRound = cardSetData:GetCardSetCurRound()
  local curBattleNum = cardSetData:GetCardSetCurBattleNum()
  self.ui.tex_RoundNum:SetIndex(0, tostring(curRound), tostring(curBattleNum + 1))
  self:_UpdRewind()
  local cdStActData = self.cardSetCtrl:GetCdStActData()
  self.ui.btn_BpRerward.gameObject:SetActive(cdStActData:GetCsRewardBpCfg() ~= nil)
end

function UINCardSetMERegularNode:_UpdRewind()
  local rewindCardSetData = self.cardSetCtrl:GetCardSetData(CardSetEnum.eSetType.rewind)
  local actCardSetData = rewindCardSetData:GetActCardSetData()
  local rewindUnlock = actCardSetData:IsUnlockActCardSetRewind()
  self.ui.obj_LockRewind:SetActive(not rewindUnlock)
  self.ui.btn_Rewind.gameObject:SetActive(rewindUnlock)
  local curRewindId = rewindCardSetData:GetCardSetCurRound()
  self.ui.tex_RewindRound.gameObject:SetActive(false)
  if rewindUnlock then
    if 0 < curRewindId then
      self.ui.tex_RewindRound:SetIndex(0, tostring(curRewindId))
      self.ui.tex_RewindRound.gameObject:SetActive(true)
    end
  else
    self.ui.tex_RewindLock.text = actCardSetData:GetUnlockDesActCardSetRewind()
  end
end

function UINCardSetMERegularNode:OpenCardRegularMode()
  self:__OpenCardSet()
end

function UINCardSetMERegularNode:__OpenCardSet()
  UIManager:HideWindow(UIWindowTypeID.CardSetEntrance)
  self.cardSetCtrl:OpenCardSetUI(CardSetEnum.eSetType.normal, function()
    UIManager:ShowWindowOnly(UIWindowTypeID.CardSetEntrance)
  end)
end

function UINCardSetMERegularNode:OpenCardRewindMode()
  self:__OnClickRewind(true)
end

function UINCardSetMERegularNode:__OnClickRewind(isReturn)
  self.cardSetCtrl:SetCardSetPlayType(CardSetEnum.eSetType.rewind)
  UIManager:HideWindow(UIWindowTypeID.CardSetEntrance)
  UIManager:ShowWindowAsync(UIWindowTypeID.CardSetRewind, function(win)
    if win == nil then
      return
    end
    win:InitCardSetRewind(self.cardSetCtrl, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.CardSetEntrance)
    end, isReturn)
  end)
end

function UINCardSetMERegularNode:__OnClickBpRerward()
  UIManager:ShowWindowAsync(UIWindowTypeID.CardSetReward, function(win)
    if win == nil then
      return
    end
    UIManager:HideWindow(UIWindowTypeID.CardSetEntrance)
    win:InitCardSetReward(self.cardSetCtrl, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.CardSetEntrance)
    end)
  end)
end

function UINCardSetMERegularNode:__InitReddotListern()
  local cardSetActData = self.cardSetCtrl:GetCdStActData()
  self.redDotRoot = cardSetActData:GetActivityReddot()
  if self.redDotRoot ~= nil then
    self._reddotFunc = BindCallback(self, self.__RefreshReddot)
    RedDotController:AddListener(self.redDotRoot.nodePath, self._reddotFunc)
    self:__RefreshReddot()
  end
end

function UINCardSetMERegularNode:__RefreshReddot()
  self:__RefreshRewardBlueOrRedDot()
end

function UINCardSetMERegularNode:__RefreshRewardBlueOrRedDot()
  local redDotRoot = self.redDotRoot
  local node = redDotRoot:GetChild(CardSetEnum.reddotType.bpReward)
  if node ~= nil and node:GetRedDotCount() > 0 then
    self.ui.reward_RedDot:SetActive(true)
    return
  end
  self.ui.reward_RedDot:SetActive(false)
end

function UINCardSetMERegularNode:OnDelete()
  if self.redDotRoot ~= nil then
    RedDotController:RemoveListener(self.redDotRoot.nodePath, self._reddotFunc)
    self.redDotRoot = nil
  end
  base.OnDelete(self)
end

return UINCardSetMERegularNode
