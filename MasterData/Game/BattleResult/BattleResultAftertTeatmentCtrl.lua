local BattleResultAftertTeatmentCtrl = class("BattleResultAftertTeatmentCtrl", ControllerBase)
local base = ControllerBase
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function BattleResultAftertTeatmentCtrl:OnInit()
  self.__TryShowExtraReward = BindCallback(self, self._TryShowExtraReward)
  self.__TryShowDungeonAutoFightReward = BindCallback(self, self._TryShowDungeonAutoFightReward)
  self.__TryShowStOCareerRewar = BindCallback(self, self._TryShowStOCareerRewar)
  self.__TryShowInfinityJumpLevelReward = BindCallback(self, self._TryShowInfinityJumpLevelReward)
  self.__TryShowChallengeModeReward = BindCallback(self, self._TryShowChallengeModeReward)
  self.__TryShowNewHeroReward = BindCallback(self, self._TryShowNewHeroReward)
  self.__TryShowSkinPlay = BindCallback(self, self._TryShowSkinPlay)
  self.processTable = {
    self.__TryShowNewHeroReward,
    self.__TryShowDungeonAutoFightReward,
    self.__TryShowInfinityJumpLevelReward,
    self.__TryShowExtraReward,
    self.__TryShowStOCareerRewar,
    self.__TryShowChallengeModeReward,
    self.__TryShowSkinPlay
  }
  self.__isStartReward = false
  self.__afterActions = {}
  self.___NextContinue = BindCallback(self, self._NextContinue)
end

function BattleResultAftertTeatmentCtrl:AddShowReward(rewardDic)
  if rewardDic == nil or table.count(rewardDic) == 0 then
    return
  end
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_FirstEnterHome) then
    return
  end
  self.extraShowRwardDic = self.extraShowRwardDic or {}
  for id, count in pairs(rewardDic) do
    local oriCount = self.extraShowRwardDic[id] or 0
    self.extraShowRwardDic[id] = oriCount + count
  end
end

function BattleResultAftertTeatmentCtrl:AddNewHeroReward(newHeroIdDic)
  self.newHeroIdList = self.newHeroIdList or {}
  for heroId, _ in pairs(newHeroIdDic) do
    table.insert(self.newHeroIdList, heroId)
  end
end

function BattleResultAftertTeatmentCtrl:AddShowStOCareerReward(StOCareerRewardDic)
  if StOCareerRewardDic == nil or table.count(StOCareerRewardDic) == 0 then
    return
  end
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1) then
    return
  end
  self.StOCareerRewardDic = self.StOCareerRewardDic or {}
  for id, count in pairs(StOCareerRewardDic) do
    self.StOCareerRewardDic[id] = (self.StOCareerRewardDic[id] or 0) + count
  end
end

function BattleResultAftertTeatmentCtrl:AddDungeonAutoFightReward(dInterfaceData, rewardDic, athRewardDic, battleCount)
  self.dungeonAutoFightTable = self.dungeonAutoFightTable or {
    dInterfaceData = dInterfaceData,
    count = battleCount,
    reward = {},
    ath = {}
  }
  self.dungeonAutoFightTable.count = battleCount
  if rewardDic ~= nil and table.count(rewardDic) > 0 then
    for id, count in pairs(rewardDic) do
      local oriCount = self.dungeonAutoFightTable.reward[id] or 0
      self.dungeonAutoFightTable.reward[id] = oriCount + count
    end
  end
  if athRewardDic ~= nil and table.count(athRewardDic) then
    for _, uid in pairs(athRewardDic) do
      self.dungeonAutoFightTable.ath[uid] = uid
    end
  end
end

function BattleResultAftertTeatmentCtrl:IsStartShowReward()
  return self.__isStartReward
end

function BattleResultAftertTeatmentCtrl:BindResultAfterAction(action)
  if action == nil or self.__afterActions == nil then
    return
  end
  table.insert(self.__afterActions, action)
end

function BattleResultAftertTeatmentCtrl:TeatmentBengin()
  if self.__isStartReward then
    return
  end
  self.__isStartReward = true
  if GuideManager.inGuide then
    self.__waitGuideTimer = TimerManager:StartTimer(1, function()
      if not self.__isStartReward then
        TimerManager:StopTimer(self.__waitGuideTimer)
        return
      end
      if not GuideManager.inGuide then
        TimerManager:StopTimer(self.__waitGuideTimer)
        self:_NextContinue(true)
      end
    end, nil, false, true)
    return
  end
  self:_NextContinue(true)
end

function BattleResultAftertTeatmentCtrl:_TryShowExtraReward()
  if self.extraShowRwardDic == nil or table.count(self.extraShowRwardDic) == 0 then
    self:_NextContinue()
    return
  end
  
  local function ShowWinFunc(window)
    local CRData = CommonRewardData.CreateCRDataUseDic(self.extraShowRwardDic):SetCRShowOverFunc(self.___NextContinue)
    window:AddAndTryShowReward(CRData)
  end
  
  local rewardWin = UIManager:GetWindow(UIWindowTypeID.CommonReward)
  if rewardWin ~= nil then
    ShowWinFunc(rewardWin)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      ShowWinFunc(window)
    end)
  end
end

function BattleResultAftertTeatmentCtrl:_TryShowNewHeroReward()
  if self.newHeroIdList == nil or table.count(self.newHeroIdList) == 0 then
    self:_NextContinue()
    return
  end
  local allNewDic = {}
  for index, _ in ipairs(self.newHeroIdList) do
    allNewDic[index] = true
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.GetHero, function(window)
    if window == nil then
      return
    end
    window:InitGetHeroList(self.newHeroIdList, false, true, allNewDic, function()
      AudioManager:PlayAudioById(1115)
      UIManager:DeleteWindow(UIWindowTypeID.GetHero)
      self:_NextContinue()
    end)
    self.newHeroIdList = nil
  end)
end

function BattleResultAftertTeatmentCtrl:SetShowChallengeModeReward(rewardDic, fromNum, toNum, totalNum)
  if rewardDic == nil then
    return
  end
  self.challengeModeCRData = CommonRewardData.CreateCRDataUseDic(rewardDic):SetCRTitle(ConfigData:GetTipContent(962)):SetCRShowOverFunc(self.___NextContinue):SetCRChallengeTask(fromNum, toNum, totalNum)
end

function BattleResultAftertTeatmentCtrl:_TryShowChallengeModeReward()
  if self.challengeModeCRData == nil then
    self:_NextContinue()
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    window:AddAndTryShowReward(self.challengeModeCRData)
  end)
end

function BattleResultAftertTeatmentCtrl:_TryShowDungeonAutoFightReward()
  if self.dungeonAutoFightTable == nil then
    self:_NextContinue()
    return
  end
  UIManager:CreateWindowAsync(UIWindowTypeID.BattleAutoMode, function(window)
    window:InitDungeonAutoRes(self.dungeonAutoFightTable.dInterfaceData, self.dungeonAutoFightTable.count, self.dungeonAutoFightTable.reward, self.dungeonAutoFightTable.ath, function()
      self:_NextContinue()
    end)
  end)
end

function BattleResultAftertTeatmentCtrl:_TryShowStOCareerRewar()
  self:_NextContinue()
  if self.StOCareerRewardDic == nil or table.count(self.StOCareerRewardDic) == 0 then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageSide, function(window)
    if window == nil then
      return
    end
    for itemId, num in pairs(self.StOCareerRewardDic) do
      window:ShowTips({itemId = itemId, num = num}, 2, eMessageSideType.ecParameter)
    end
  end)
end

function BattleResultAftertTeatmentCtrl:SetShowSkinPlay(skinCfg)
  if skinCfg == nil then
    return
  end
  self.skinCfg = skinCfg
end

function BattleResultAftertTeatmentCtrl:_TryShowSkinPlay()
  if self.skinCfg == nil then
    self:_NextContinue()
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.GetHeroSkin, function(window)
    if window == nil then
      return
    end
    window:InitGetHeroSkin(self.skinCfg, function()
      self:_NextContinue()
    end)
  end)
end

function BattleResultAftertTeatmentCtrl:SaveSectorId(sectorId)
  self.sectorId = sectorId
end

function BattleResultAftertTeatmentCtrl:_TryShowInfinityJumpLevelReward()
  if self.sectorId == nil then
    self:_NextContinue()
    return
  end
  local items = PlayerDataCenter.infinityData:GetJumpLevelReward(self.sectorId)
  PlayerDataCenter.infinityData:CleanJumpLevelReward(self.sectorId)
  if items == nil then
    self:_NextContinue()
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    local CRData = CommonRewardData.CreateCRDataUseDic(items):SetCRShowOverFunc(self.___NextContinue)
    window:AddAndTryShowReward(CRData)
  end)
end

function BattleResultAftertTeatmentCtrl:_NextContinue(isFirst)
  if isFirst then
    self.processIndex = 0
  end
  self.processIndex = self.processIndex + 1
  if self.processIndex > #self.processTable then
    self.__isStartReward = false
    for k, action in pairs(self.__afterActions) do
      action()
    end
    self:Delete()
    return
  end
  self.processTable[self.processIndex]()
end

function BattleResultAftertTeatmentCtrl:OnDelete()
  self.__isStartReward = false
  TimerManager:StopTimer(self.__waitGuideTimer)
  self.__afterActions = nil
  base.OnDelete(self)
end

return BattleResultAftertTeatmentCtrl
