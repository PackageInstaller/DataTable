local UINStcChallengeInfo = class("UINStcChallengeInfo", UIBaseNode)
local base = UIBaseNode
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local UINStcChallengeInfoRewardNode = require("Game.PeriodicChallenge.UI.UINStcChallengeInfoRewardNode")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function UINStcChallengeInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINStcChallengeInfo:InitDailyDgEnterBtn()
  self.detailType = SectorLevelDetailEnum.eDetailType.DailyDungeon
  self.ui.tex_TypeTile:SetIndex(0)
  self.ui.tex_TypeTileEn:SetIndex(0)
  self.ui.imageIcon:SetIndex(0)
  self:RefreshDailyDgEnterBtn()
end

function UINStcChallengeInfo:InitWeeklyChallenge(isSectorBtn)
  self.detailType = SectorLevelDetailEnum.eDetailType.WeeklyChallenge
  self.ui.rewardNode:SetActive(true)
  if self.__RewardNode == nil then
    self.__RewardNode = UINStcChallengeInfoRewardNode.New()
    self.__RewardNode:Init(self.ui.rewardNode)
  end
  self.isSectorBtn = isSectorBtn
  self.ui.tex_TypeTile:SetIndex(1)
  self.ui.tex_TypeTileEn:SetIndex(1)
  self.ui.imageIcon:SetIndex(1)
  self:RefreshWeeklyChallenge()
end

function UINStcChallengeInfo:InitDungoneTowerBtn()
  self.detailType = SectorLevelDetailEnum.eDetailType.DungeonTower
  self.ui.tex_TypeTile:SetIndex(2)
  self.ui.tex_TypeTileEn:SetIndex(2)
  self.ui.imageIcon:SetIndex(2)
  self.ui.obj_Continue:SetActive(false)
  self.ui.obj_passMarker:SetActive(false)
  self.ui.tex_TimeTitle:SetIndex(2)
  self:RefreshDungeonTowerBtn()
  if self._dunTowerListener == nil then
    function self._dunTowerListener(node)
      local active = node:GetRedDotCount() > 0
      
      self.ui.redDot:SetActive(active)
    end
    
    local _, dunTowerNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonTower)
    RedDotController:AddListener(dunTowerNode.nodePath, self._dunTowerListener)
    self._dunTowerListener(dunTowerNode)
  end
end

function UINStcChallengeInfo:RefreshStcChallengeInfo()
  if self.detailType == SectorLevelDetailEnum.eDetailType.DailyDungeon then
    self:RefreshDailyDgEnterBtn()
  elseif self.detailType == SectorLevelDetailEnum.eDetailType.WeeklyChallenge then
    self:RefreshWeeklyChallenge()
  end
end

function UINStcChallengeInfo:RefreshDailyDgEnterBtn()
  local isFinish, inDungeon = PlayerDataCenter.dungeonDyncData:GetDailyDungeonState()
  self.ui.obj_Continue:SetActive(inDungeon)
  local dungeonDyncElem = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
  local isNew = dungeonDyncElem.isDailyDungeonNew
  self.ui.blueDot:SetActive(isNew)
  local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleRefreshableDungeon, eDungeonEnum.eMatDungeonGroup.DailyDungeon)
  if counterElem ~= nil then
    self.netxRefreshTimeStamp = counterElem.nextExpiredTm
    self:SetRemaindTime()
  end
  if isFinish then
    self.ui.tex_TimeTitle:SetIndex(1)
    self.ui.obj_passMarker:SetActive(true)
  else
    self.ui.tex_TimeTitle:SetIndex(0)
    self.ui.obj_passMarker:SetActive(false)
  end
  self:RefreshDailyDgEnterBtnDouble()
end

function UINStcChallengeInfo:RefreshDailyDgEnterBtnDouble()
  local dungeonDyncElem = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
  local hasDouble = dungeonDyncElem:DgDyncIsHaveMultReward()
  self.ui.obj_double:SetActive(hasDouble)
end

function UINStcChallengeInfo:RefreshWeeklyChallenge()
  local _, _, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
  local isInEp = moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
  self.ui.obj_Continue:SetActive(isInEp)
  local counterElem = PlayerDataCenter.allWeeklyChallengeData:GetCounterElem()
  if counterElem ~= nil then
    self.netxRefreshTimeStamp = counterElem.nextExpiredTm
    self:SetRemaindTime()
  end
  local isFinish, baseReward, baseRewardMax, extraReward, extraRewardMax = PlayerDataCenter.allWeeklyChallengeData:GetWeeklyChallengeReward()
  if self.__RewardNode ~= nil then
    self.__RewardNode:RefreshChallengeReward()
  end
  if isFinish then
    self.ui.tex_TimeTitle:SetIndex(1)
    self.ui.obj_passMarker:SetActive(true)
  else
    self.ui.tex_TimeTitle:SetIndex(0)
    self.ui.obj_passMarker:SetActive(false)
  end
end

function UINStcChallengeInfo:RefreshDungeonTowerBtn()
  self.ui.blueDot:SetActive(false)
  local curLevel = PlayerDataCenter.dungeonTowerSData:GetDefaultTowerCompleteLevel()
  local totalLevel = PlayerDataCenter.dungeonTowerSData:GetDefaultTowerTotalLevel()
  self.ui.tex_Timer:SetIndex(2, tostring(curLevel), tostring(totalLevel))
  self.ui.blueDot:SetActive(PlayerDataCenter.dungeonTowerSData:HasNewDunTower())
end

function UINStcChallengeInfo:SetRemaindTime()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  if self.netxRefreshTimeStamp == nil or self.netxRefreshTimeStamp <= PlayerDataCenter.timestamp then
    return
  end
  self:RefreshRemaindTime()
  self.timerId = TimerManager:StartTimer(1, self.RefreshRemaindTime, self, false, false, false)
end

function UINStcChallengeInfo:RefreshRemaindTime()
  local remaindTime = math.max(math.floor(self.netxRefreshTimeStamp - PlayerDataCenter.timestamp), 0)
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
  local hStr = 10 <= h and tostring(h) or "0" .. tostring(h)
  local mStr = 10 <= m and tostring(m) or "0" .. tostring(m)
  local sStr = 10 <= s and tostring(s) or "0" .. tostring(s)
  if 0 < d then
    self.ui.tex_Timer:SetIndex(0, tostring(d), hStr, mStr, sStr)
  else
    self.ui.tex_Timer:SetIndex(1, hStr, mStr, sStr)
  end
  if remaindTime <= 0 and self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
end

function UINStcChallengeInfo:OnDelete()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  if self.__RewardNode ~= nil then
    self.__RewardNode:Delete()
  end
  if self._dunTowerListener ~= nil then
    local _, dunTowerNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceChallenge, RedDotStaticTypeId.DungeonTower)
    RedDotController:RemoveListener(dunTowerNode.nodePath, self._dunTowerListener)
  end
  base.OnDelete(self)
end

return UINStcChallengeInfo
