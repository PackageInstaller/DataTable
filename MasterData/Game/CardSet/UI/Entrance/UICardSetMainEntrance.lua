local UICardSetMainEntrance = class("UICardSetMainEntrance", UIBaseWindow)
local base = UIBaseWindow
local UINCardSetMERankNode = require("Game.CardSet.UI.Entrance.UINCardSetMERankNode")
local UINCardSetMERegularNode = require("Game.CardSet.UI.Entrance.UINCardSetMERegularNode")
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")

function UICardSetMainEntrance:OnInit()
  self.regNode = UINCardSetMERegularNode.New()
  self.regNode:Init(self.ui.regularMode)
  self.rankNode = UINCardSetMERankNode.New()
  self.rankNode:Init(self.ui.rankMode)
end

function UICardSetMainEntrance:InitCardSetEntrance(cardSetCtrl, isReturn, closeFunc)
  self.actCardData = cardSetCtrl:GetCdStActData()
  local resList = self.actCardData:GetActCardSetMainResIdList()
  local tipGuideId = self.actCardData:GetActCardSetTipsId()
  local topData = UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__BcakAction):SetTopStatusVisible(true):SetTopStatusResData(resList)
  if 0 < tipGuideId then
    topData:SetTopStatusInfoFunc(function()
      GuidePicture.OpenGuidePicture(tipGuideId, nil)
    end)
  end
  topData:PushTopStatusDataToBackStack()
  self.cardSetCtrl = cardSetCtrl
  self.regNode:InitCardSetMENode(cardSetCtrl)
  self.rankNode:InitCardSetMENode(cardSetCtrl, self)
  self._closeFunc = closeFunc
  if isReturn then
    local actCardSetData = cardSetCtrl:GetCdStActData()
    local playMode = actCardSetData:GetActCdStLastPlayMode()
    if playMode == CardSetEnum.eSetType.normal then
      self.regNode:OpenCardRegularMode()
    elseif playMode == CardSetEnum.eSetType.rank then
      self.rankNode:OpenCardRankMode()
    elseif playMode == CardSetEnum.eSetType.rewind then
      self.regNode:OpenCardRewindMode()
    end
  end
  self:_InitActTime()
  self.ui.tex_TopDes.text = LanguageUtil.GetLocaleText(ConfigData:GetTipContent(2218))
end

function UICardSetMainEntrance:UpdCardSetEntrance()
  self.regNode:RefreshCardSetMERegularMode()
end

function UICardSetMainEntrance:_InitActTime()
  local actCardSetData = self.cardSetCtrl:GetCdStActData()
  self._endTs = actCardSetData:GetActivityEndTime()
  self.ui.tex_Timer.text = TimeUtil:TimestampToDateString(self._endTs, false, true, ConfigData:GetTipContent(6052))
  TimerManager:StopTimer(self._endTimerId)
  if self:_UpdEndTimer() then
    self._endTimerId = TimerManager:StartTimer(1, self._UpdEndTimer, self, false)
  end
end

function UICardSetMainEntrance:_UpdEndTimer()
  local timeStr, diff = ActivityFrameUtil.GetCountdownTimeStr(self._endTs)
  if diff < 0 then
    TimerManager:StopTimer(self._endTimerId)
    self.ui.tex_Days.transform.parent.gameObject:SetActive(false)
    return false
  end
  self.ui.tex_Days.text = timeStr
  return true
end

function UICardSetMainEntrance:__BcakAction()
  if self._closeFunc then
    self._closeFunc()
  end
  self:Delete()
end

function UICardSetMainEntrance:OnDelete()
  TimerManager:StopTimer(self._endTimerId)
  self.regNode:Delete()
  self.rankNode:Delete()
  base.OnDelete(self)
end

return UICardSetMainEntrance
