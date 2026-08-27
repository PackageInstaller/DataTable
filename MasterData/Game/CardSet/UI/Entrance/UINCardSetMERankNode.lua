local UINCardSetMERankNode = class("UINCardSetMERankNode", UIBaseNode)
local base = UIBaseNode
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local cs_MessageCommon = CS.MessageCommon

function UINCardSetMERankNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Jump, self, self.__OpenCardSet)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self.__OnClickRank)
  UIUtil.AddButtonListener(self.ui.btn_Reward, self, self.__OnClickReward)
end

function UINCardSetMERankNode:InitCardSetMENode(cardSetCtrl, csmeWin)
  self.cardSetCtrl = cardSetCtrl
  self.csmeWin = csmeWin
  local cardSetActData = cardSetCtrl:GetCdStActData()
  self._cardSetActData = cardSetActData
  local score = cardSetActData:GetActCardSetRankHighestScore()
  self.ui.tex_Point.text = tostring(score)
  self:_UpdUnlcok()
  local taskList = cardSetActData:GetActCardSetRewardTaskIdList()
  if taskList == nil or #taskList <= 0 then
    self.ui.btn_Reward.gameObject:SetActive(false)
  end
  local cardSetData = self.cardSetCtrl:GetCardSetData(CardSetEnum.eSetType.rank)
  self.ui.tex_JumpBtn:SetIndex(cardSetData:IsCardSetMoreRankRound() and 1 or 0)
  self:__InitReddotListern()
end

function UINCardSetMERankNode:_UpdUnlcok()
  local cardSetActData = self.cardSetCtrl:GetCdStActData()
  local unlock = cardSetActData:IsUnlockActCardSetRank()
  self.ui.obj_Lock:SetActive(not unlock)
  self.ui.obj_totalPoint:SetActive(unlock)
  self.ui.tex_TipDes.gameObject:SetActive(not unlock)
  self.ui.btn_Jump.gameObject:SetActive(unlock)
  if not unlock then
    self.ui.tex_TipDes.text = cardSetActData:GetUnlockDesActCardSetRank()
    local ok, startTs = cardSetActData:GetUnlockActCardSetRankTs()
    if ok and startTs > PlayerDataCenter.timestamp then
      local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
      self._unlockEventId = timePassCtrl:AddEventTimer(startTs, BindCallback(self, self._UpdUnlcok))
    end
  end
end

function UINCardSetMERankNode:OpenCardRankMode()
  self:__OpenCardSet(true)
end

function UINCardSetMERankNode:__OpenCardSet(isReturn)
  if not self._cardSetActData:IsUnlockActCardSetRank() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2207))
    return
  end
  local cardSetData = self.cardSetCtrl:GetCardSetData(CardSetEnum.eSetType.rank)
  if cardSetData:IsCardSetMoreRankRound() then
    UIManager:ShowWindowAsync(UIWindowTypeID.CardSetRankMode, function(win)
      if win == nil then
        return
      end
      win:InitCardSetRankMode(self.cardSetCtrl, isReturn)
    end)
    return
  end
  UIManager:HideWindow(UIWindowTypeID.CardSetEntrance)
  self.cardSetCtrl:OpenCardSetUI(CardSetEnum.eSetType.rank, function()
    UIManager:ShowWindowOnly(UIWindowTypeID.CardSetEntrance)
  end)
end

function UINCardSetMERankNode:__OnClickRank()
  local rankId = self._cardSetActData:GetActCardSetRankId()
  UIManager:HideWindow(UIWindowTypeID.CardSetEntrance)
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRank, function(rankWindow)
    if rankWindow == nil then
      return
    end
    rankWindow:InitCommonRank(rankId, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.CardSetEntrance)
    end)
  end)
end

function UINCardSetMERankNode:__OnClickReward()
  UIManager:ShowWindowAsync(UIWindowTypeID.CardSetMEReward, function(win)
    if win == nil then
      return
    end
    win:InitCSMERewardNode(self._cardSetActData)
  end)
end

function UINCardSetMERankNode:__InitReddotListern()
  local cardSetActData = self.cardSetCtrl:GetCdStActData()
  self.redDotRoot = cardSetActData:GetActivityReddot()
  if self.redDotRoot ~= nil then
    self._reddotFunc = BindCallback(self, self.__RefreshReddot)
    RedDotController:AddListener(self.redDotRoot.nodePath, self._reddotFunc)
    self:__RefreshReddot()
  end
end

function UINCardSetMERankNode:__RefreshReddot()
  self:__RefreshRewardBlueOrRedDot()
end

function UINCardSetMERankNode:__RefreshRewardBlueOrRedDot()
  local redDotRoot = self.redDotRoot
  local taskCompleteNode = redDotRoot:GetChild(CardSetEnum.reddotType.rankTask)
  if taskCompleteNode ~= nil and taskCompleteNode:GetRedDotCount() > 0 then
    self.ui.reward_RedDot:SetActive(true)
    self.ui.reward_BlueDot:SetActive(false)
    return
  end
  local taskfirstNode = redDotRoot:GetChild(CardSetEnum.reddotType.firstEnterTaskBlue)
  if taskfirstNode ~= nil and taskfirstNode:GetRedDotCount() > 0 then
    self.ui.reward_RedDot:SetActive(false)
    self.ui.reward_BlueDot:SetActive(true)
    return
  end
  self.ui.reward_RedDot:SetActive(false)
  self.ui.reward_BlueDot:SetActive(false)
end

function UINCardSetMERankNode:OnDelete()
  local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  timePassCtrl:RemoveEventTimer(self._unlockEventId)
  if self.redDotRoot ~= nil then
    RedDotController:RemoveListener(self.redDotRoot.nodePath, self._reddotFunc)
    self.redDotRoot = nil
  end
  base.OnDelete(self)
end

return UINCardSetMERankNode
