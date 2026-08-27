local UINChallengeInfoItem = class("UINChallengeInfoItem", UIBaseNode)
local base = UIBaseNode
local PeridicChallengeEnum = require("Game.PeriodicChallenge.PeridicChallengeEnum")

function UINChallengeInfoItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.netxRefreshTimeStamp = nil
  self.dailyChallengeId = nil
  self.__Refresh = BindCallback(self, self.OnTimeRefresh)
  MsgCenter:AddListener(eMsgEventId.ChallengeOutOfData, self.__Refresh)
  MsgCenter:AddListener(eMsgEventId.GiveUncompleteExploration, self.__Refresh)
end

function UINChallengeInfoItem:InitChallengeInfoItem(eChallengeType, infoTransform)
  self.eChallengeType = eChallengeType
  self:SetChallengeType(eChallengeType)
  if infoTransform ~= nil then
    self:SetParent2Node(infoTransform)
  end
  self.dailyChallengeId = PlayerDataCenter.periodicChallengeData:GetChallengeId(eChallengeType)
  if eChallengeType == PeridicChallengeEnum.eChallengeType.daliy then
    local counterElem = PlayerDataCenter.periodicChallengeData:GetChallengeCounterElem(eChallengeType)
    if counterElem ~= nil then
      self.netxRefreshTimeStamp = counterElem.nextExpiredTm
      self:SetRemaindTime()
    end
    if self.dailyChallengeId ~= nil then
      local cfg = ConfigData.daily_challenge[self.dailyChallengeId]
      self:SetReward(cfg, counterElem)
      self:SetLevelName(cfg)
    end
  end
end

function UINChallengeInfoItem:OnTimeRefresh()
  self:InitChallengeInfoItem(self.eChallengeType)
end

function UINChallengeInfoItem:SetChallengeType(eChallengeType)
  self.ui.tex_TypeTile:SetIndex(eChallengeType)
end

function UINChallengeInfoItem:SetLevelName(cfg)
  self.ui.text_LevelName.text = LanguageUtil.GetLocaleText(cfg.name)
end

function UINChallengeInfoItem:SetInEp(flag)
  self.ui.obj_Continue:SetActive(flag)
end

function UINChallengeInfoItem:SetReward(cfg, counterElem)
  local itemCfg = ConfigData.item[ConstGlobalItem.PaidSubItem]
  self.ui.tex_RewardName.text = LanguageUtil.GetLocaleText(itemCfg.name)
  local pickedNum = 0
  local isFinish, stageNumber, maxReward = PlayerDataCenter.periodicChallengeData:GetDailyChallengeStage()
  if isFinish then
    pickedNum = maxReward
  else
    pickedNum = stageNumber
  end
  if isFinish then
    self.ui.tex_TimeTitle:SetIndex(1)
    self.ui.obj_passMarker:SetActive(true)
  else
    self.ui.tex_TimeTitle:SetIndex(0)
    self.ui.obj_passMarker:SetActive(false)
  end
  self.ui.tex_RewardNum:SetIndex(0, tostring(pickedNum), tostring(maxReward))
end

function UINChallengeInfoItem:SetRemaindTime()
  if self.netxRefreshTimeStamp == nil then
    if self.timerId ~= nil then
      return
    end
    return
  end
  if self.timerId ~= nil then
    return
  else
    self:__RefreshRemaindTime()
  end
  self.timerId = TimerManager:StartTimer(3, self.__RefreshRemaindTime, self, false, false, false)
end

function UINChallengeInfoItem:__RefreshRemaindTime()
  local remaindTime = math.max(math.floor(self.netxRefreshTimeStamp - PlayerDataCenter.timestamp), 0)
  local _, hour, min, _ = TimeUtil:TimestampToTimeInter(remaindTime)
  if hour <= 0 then
    self.ui.tex_Timer:SetIndex(1, tostring(min))
  else
    self.ui.tex_Timer:SetIndex(0, tostring(hour), tostring(min))
  end
end

function UINChallengeInfoItem:SetParent2Node(parentTransform)
  self.transform:SetParent(parentTransform)
end

function UINChallengeInfoItem:OnDelete()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.ChallengeOutOfData, self.__Refresh)
  MsgCenter:RemoveListener(eMsgEventId.GiveUncompleteExploration, self.__Refresh)
  base.OnDelete(self)
end

return UINChallengeInfoItem
