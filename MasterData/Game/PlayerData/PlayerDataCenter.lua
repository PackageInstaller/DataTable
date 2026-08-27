local cs_playerData = CS.PlayerDataCenter.Instance
local PlayerDataCenter = setmetatable({}, {__index = cs_playerData})
local cs_MicaSDKManager = CS.MicaSDKManager.Instance
local FormationUtil = require("Game.Formation.FormationUtil")
local FormationData = require("Game.PlayerData.FormationData")
local AllBuildingData = require("Game.PlayerData.AllBuildingData")
local AllTaskData = require("Game.PlayerData.AllTaskData")
local StaminaData = require("Game.PlayerData.StaminaData")
local SectorStageData = require("Game.PlayerData.SectorStageData")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local ItemData = require("Game.PlayerData.Item.ItemData")
local DynLimitTimeItemData = require("Game.PlayerData.Item.DynLimitTimeItemData")
local PlayerLevelData = require("Game.PlayerData.PlayerLevelData")
local AchivLevelData = require("Game.PlayerData.AchivLevel.AchivLevelData")
local AllAthData = require("Game.PlayerData.Arithmetic.AllAthData")
local TrainingSlotData = require("Game.Training.Data.TrainingSlotData")
local AllEffectorData = require("Game.Effector.Data.AllEffectorData")
local FriendshipData = require("Game.PlayerData.FriendshipData")
local AttributeBonus = require("Game.PlayerData.AttributeBonus")
local HeroAttrChecker = require("Game.Debug.HeroAttrChecker")
local PlayerBonus = require("Game.PlayerData.PlayerBonus.PlayerBonus")
local CacheSaveData = require("Game.PlayerData.CacheSaveData")
local PeriodicChallengeData = require("Game.PlayerData.PeriodicChallengeData")
local AllBattlePassData = require("Game.BattlePass.Data.AllBattlePassData")
local DailySignInData = require("Game.DailySignIn.DailySignInData")
local AllSkinData = require("Game.Skin.AllSkinData")
local AllWeeklyChallengeData = require("Game.WeeklyChallenge.AllWeeklyChallenge")
local AllActivityStarUpData = require("Game.ActivityStarUp.AllActivityStarUpData")
local AllLtrPoolData = require("Game.Lottery.Data.AllLtrPoolData")
local AllEventNoviceSignData = require("Game.EventNoviceSign.AllEventNoviceSignData")
local InfinityData = require("Game.PlayerData.InfinityData")
local HomeChatDataCenter = require("Game.Chat.HomeChatDataCenter")
local UserInfoData = require("Game.User.UserInfoData")
local FriendDataCenter = require("Game.Friend.FriendDataCenter")
local CheckerConditionRegister = require("Game.Common.CheckCondition.CheckerConditionRegister")
local DungeonDyncData = require("Game.Dungeon.Dync.DungeonDyncData")
local DormBriefData = require("Game.Dorm.Data.DormBriefData")
local SupportHeroData = require("Game.PlayerData.SupportHeroData")
local AllTimingProduct = require("Game.PlayerData.TimingProduct.AllTimingProduct")
local HeroBackOffData = require("Game.PlayerData.HeroBackOffData")
local AllSpecWeaponData = require("Game.SpecWeapon.AllSpecWeaponData")
local GameSettingData = require("Game.Setting.Data.GameSettingData")
local DungeonCenterData = require("Game.DungeonCenter.Data.DungeonCenterData")
local ShopEnum = require("Game.Shop.ShopEnum")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local AllActivitySectorIData = require("Game.ActivitySectorI.AllActivitySectorIData")
local SectorEntranceHandler = require("Game.Sector.SectorEntranceHandler")
local AllHeroTalentData = require("Game.HeroTalent.AllHeroTalentData")
local DungeonTowerDynData = require("Game.DungeonCenter.SData.DungeonTowerDynData")
local AllAdjCustomData = require("Game.AdjCustom.AllAdjCustomData")
local FavorHeroData = require("Game.PlayerData.Hero.FavorHeroData")
local EpSavingDataCenter = require("Game.CommonUI.ModeSelect.Data.EpSavingDataCenter")
local ActHisSpecialData = require("Game.ActivityFrame.Data.ActHisSpecialData")

function PlayerDataCenter:InitData()
  self.isOnline = false
  self.isSyncUserDataEnd = false
  self.heroDic = {}
  self.heroCount = 0
  self.hideHeroCount = 0
  self.campHeroCount = {}
  self.itemDic = {}
  self.itemTypeList = {}
  for i = 1, ItemTypeMax do
    self.itemTypeList[i] = {}
  end
  self.playerLevel = PlayerLevelData.New()
  self.AllBuildingData = AllBuildingData.New()
  self.sectorStage = SectorStageData.New()
  self.formationDic = {}
  self.cstDataDic = {}
  self.stamina = StaminaData.New()
  self.allTaskData = AllTaskData.New()
  self.trainingSlotDatas = TrainingSlotData.InitAllTrainingSlotData()
  self.sectorAchievementDatas = nil
  self.achivLevelData = AchivLevelData.New()
  self.allAthData = AllAthData.New()
  self.allEnterData = {}
  self.allEffectorData = AllEffectorData.New()
  self.allFriendshipData = FriendshipData.New()
  self.attributeBonus = AttributeBonus.New()
  self.dungeonDailyBattleTimes = {}
  self.dungeonTotalBattleTimes = {}
  self.dungeonComplectedWhithoutSupport = {}
  self.dungeonDyncData = DungeonDyncData.New()
  self.allVisitedMonsters = {}
  self.showGirlId = nil
  self.lastSectorMentionedId = nil
  self.infinityData = InfinityData.New()
  self.lastAthDiff = nil
  self.cacheSaveData = CacheSaveData.New()
  self.dungeonCenterData = DungeonCenterData.New()
  self.periodicChallengeData = PeriodicChallengeData.New()
  self.allWeeklyChallengeData = AllWeeklyChallengeData.New()
  self.dailySignInData = DailySignInData.New()
  self.playerBonus = PlayerBonus.New()
  self.playerBonus:InitPlayerBonus()
  self.battlepassData = AllBattlePassData.New()
  self.skinData = AllSkinData.New()
  self.activityStarUpData = AllActivityStarUpData.New()
  self.allLtrData = AllLtrPoolData.New()
  self.eventNoviceSignData = AllEventNoviceSignData.New()
  if isGameDev then
    self.heroAttrChecker = HeroAttrChecker.New()
  end
  self.homeChatDataCenter = HomeChatDataCenter.New()
  self.friendDataCenter = FriendDataCenter.New()
  self.checkerConditionRegister = CheckerConditionRegister.New()
  self.__userInfoDataCacheDic = {}
  self.__waitAvatarFetchList = {}
  self.dormBriefData = nil
  self.channelId = nil
  self.supportHeroData = SupportHeroData.New()
  self.allTimingProduct = AllTimingProduct.New()
  self.allActivitySectorIData = AllActivitySectorIData.New()
  self.sectorEntranceHandler = SectorEntranceHandler.New()
  self.dungeonTowerSData = DungeonTowerDynData.New()
  self.allHeroTalentData = AllHeroTalentData.New()
  self.allAdjCustomData = AllAdjCustomData.New()
  self.favorHeroData = FavorHeroData.New()
  self.allSpecWeaponData = AllSpecWeaponData.New()
  self.gameSettingData = GameSettingData.New()
  self.epSavingDataCenter = EpSavingDataCenter.New()
  self.actHisSpecialData = ActHisSpecialData.New()
end

function PlayerDataCenter:UpdateDungeonBattleTimes(msg)
  self.dungeonDailyBattleTimes = msg.dailyBattleTimes
  self.dungeonTotalBattleTimes = {}
  self.dungeonComplectedWhithoutSupport = {}
  for id, value in pairs(msg.totalBattleTimes) do
    local count = value >> 1
    self.dungeonTotalBattleTimes[id] = count
    if value & 1 == 1 then
      self.dungeonComplectedWhithoutSupport[id] = true
    end
  end
  self:UpdateDungeonBattleQuick(msg.quickChallengeModule)
  for dungeonId, infoMsg in pairs(msg.info) do
    if infoMsg.challenge then
      for k, taskId in ipairs(infoMsg.challenge.FinishedQuestIds) do
        self.dungeonCenterData:SetDgChallengeTaskComplete(dungeonId, taskId)
      end
    end
  end
end

function PlayerDataCenter:UpdateDungeonBattleQuick(quickChallengeModule)
  self._dungeonQuickMoudleDic = {}
  for i, v in ipairs(quickChallengeModule) do
    self._dungeonQuickMoudleDic[v] = true
  end
end

function PlayerDataCenter:IsDungeonModuleOpenQuick(moduleId)
  return self._dungeonQuickMoudleDic[moduleId]
end

function PlayerDataCenter:LocallyAddDungeonLimit(moduelId, dungeonStageId, hasSupport, startDungeonBattleTS)
  if self.dungeonDailyBattleTimes == nil then
    self.dungeonDailyBattleTimes = {}
  end
  if self.dungeonDailyBattleTimes[moduelId] == nil then
    self.dungeonDailyBattleTimes[moduelId] = {}
    self.dungeonDailyBattleTimes[moduelId].data = {}
  end
  local timepassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, false)
  local isToday = timepassCtrl:GetIsLogicToday(startDungeonBattleTS)
  if isToday then
    local moduelData = self.dungeonDailyBattleTimes[moduelId].data
    if moduelData[dungeonStageId] == nil then
      moduelData[dungeonStageId] = 1
    else
      moduelData[dungeonStageId] = moduelData[dungeonStageId] + 1
    end
  end
  if self.dungeonTotalBattleTimes == nil then
    self.dungeonTotalBattleTimes = {}
  end
  local moduelData = self.dungeonTotalBattleTimes[dungeonStageId]
  if moduelData == nil then
    moduelData = 1
  else
    moduelData = moduelData + 1
  end
  self.dungeonTotalBattleTimes[dungeonStageId] = moduelData
  if not hasSupport then
    self.dungeonComplectedWhithoutSupport[dungeonStageId] = true
  end
  MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.CompleteDungeon)
end

function PlayerDataCenter:GetTotalBattleTimes(dungeonStageId)
  if self.dungeonTotalBattleTimes == nil then
    return 0
  end
  local moduelData = self.dungeonTotalBattleTimes[dungeonStageId]
  if moduelData == nil then
    return 0
  else
    return moduelData
  end
end

function PlayerDataCenter:IsDungeonCompletedWithoutSupport(dungeonStageId)
  if self.dungeonComplectedWhithoutSupport == nil then
    return false
  end
  return self.dungeonComplectedWhithoutSupport[dungeonStageId]
end

function PlayerDataCenter:GetLastRemoteSectorMentionId()
  return self.lastSectorMentionedId
end

function PlayerDataCenter:RecordLastRemoteSectorMentionId(completeId)
  self.lastSectorMentionedId = completeId
end

function PlayerDataCenter:SyncUserData(userData)
  self.isOnline = true
  self.createTm = userData.createTm.createTm
  self.serverTm = userData.createTm.serverTm
  self.createRelativeTm = userData.createTm.createRelativeTm
  self.channelId = userData.channelId
  PersistentManager.playerId = self.playerId
  PersistentManager:LoadAndDecodeData(PersistentConfig.ePackage.UserData)
  PersistentManager:LoadAndDecodeData(PersistentConfig.ePackage.UserChatData)
  local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  userChatCtrl:SetIsChatSystemBan(userData.chatBan)
  HotResDecryptManager.TryDecryptHotRes(userData.decryptedResource)
  FunctionUnlockMgr:ResetUnlockData()
  if userData["function"] ~= nil then
    self:InitFunctionUnlockData(userData["function"])
  end
  if userData.heroGroup ~= nil then
    self:InitHeroData(userData.heroGroup)
  end
  if userData.timingBrief ~= nil then
    self.allTimingProduct:InitAllTimingProduct(userData.timingBrief)
  end
  if userData.rechargeStat ~= nil then
    ControllerManager:GetController(ControllerTypeId.Pay, true):UpdTotalCharge(userData.rechargeStat.amount, true)
  end
  self.gameSettingData:InitGameSettingData(userData.record)
  if userData.resource ~= nil then
    local resource = userData.resource
    if resource.backpack ~= nil then
      if resource.backpack.itemTimeLimit ~= nil then
        for itemId, v in pairs(resource.backpack.itemTimeLimit) do
          local itemData = DynLimitTimeItemData.New(itemId, v.timeLimit)
          self.itemTypeList[itemData.type][itemId] = itemData
          self.itemDic[itemId] = itemData
        end
      end
      if resource.backpack.data ~= nil then
        for itemId, v in pairs(resource.backpack.data) do
          local itemData = ItemData.New(v.id, v.count)
          self.itemTypeList[itemData.type][itemId] = itemData
          self.itemDic[itemId] = itemData
        end
      end
    end
    self:CheckHaseLimitTimeItem()
  end
  ControllerManager:GetController(ControllerTypeId.HomeController, true)
  if userData.questGroup ~= nil then
    self.allTaskData:InitAllTaskData(userData.questGroup)
  end
  if userData.quest ~= nil then
    self.allTaskData:InitCompletedMainTask(userData.quest.mainLineQuest)
    self.allTaskData:InitCompletedMilestoneTask(userData.quest.mileStoneTask)
  end
  self.renameCount = 0
  if userData.userBrief ~= nil then
    self.playerLevel:UpdatePlayerLevelData(userData.userBrief.avatar.biref.lv, userData.userBrief.avatar.biref.exp, true)
    self.inforData = UserInfoData.CreateSelfData(userData.userBrief)
    if cs_MicaSDKManager.channelId == Consts.GameChannelType.Kol then
      UIManager:ShowWindowAsync(UIWindowTypeID.WaterMark, function(win)
        win:SetWaterMarkUID(self.inforData:GetUserUID())
      end)
    end
    if userData.heroGroup ~= nil then
      self.inforData.heroHeadDict = {}
      self:InitHeroHeadData(userData.heroGroup)
    end
    if userData.heroGroup ~= nil then
      self.inforData.isHeadLockedDict = {}
      self:InitHeroHeadLockedDict()
    end
    if userData.heroGroup ~= nil then
      self.globalTreeSavingData = userData.heroGroup.savingTree
    end
    if userData.userBrief.avatar.biref.showGirl ~= nil then
      self.showGirlId = userData.userBrief.avatar.biref.showGirl
    end
    if userData.userBrief.userBase ~= nil then
      self.lastSectorMentionedId = userData.userBrief.userBase.cliLastSecMent
      self.renameCount = userData.userBrief.userBase.renameCount
      PlayerDataCenter.sectorStage:InitSectorChapterUnlockShow(userData.userBrief.userBase.chapterIds)
      GuideManager:InitCompleteTriggerGuide(userData.userBrief.userBase.triggerGuidance)
    else
      self.lastSectorMentionedId = 0
      GuideManager:InitCompleteTriggerGuide({})
    end
  else
    GuideManager:InitCompleteTriggerGuide({})
  end
  if userData.monsterAtlas ~= nil then
    self.allVisitedMonsters = userData.monsterAtlas.data
  end
  if userData.logic ~= nil and userData.logic.logic ~= nil then
    for index, data in ipairs(userData.logic.logic) do
      local data = data.data
      self.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_Double_Regular, index, data[1], data[2], data[3], data[4])
    end
  end
  self:UpdateDormBriefData(userData.dormData)
  local giftTypeInfoList = userData.giftTypeInfos
  local giftTypeInfoDic = {}
  for i = 1, #giftTypeInfoList do
    giftTypeInfoDic[giftTypeInfoList[i].id] = giftTypeInfoList[i]
  end
  self.GiftTypeInfos = giftTypeInfoDic
  ControllerManager:GetController(ControllerTypeId.AvgPlay, true):InitAllAvgPlayed(userData.avg)
  userChatCtrl:InitChatSystemEmojiData()
  NetworkManager:GetNetwork(NetworkTypeID.Sector):CS_SECTOR_Detail()
  NetworkManager:GetNetwork(NetworkTypeID.Sector):CS_ENDLESS_Detail()
  NetworkManager:GetNetwork(NetworkTypeID.Exploration):CS_EXPLORATION_Detail_NoWait()
  WarChessManager:ctor()
  WarChessManager:SyncIsHaveUncompletedWarChess()
  WarChessSeasonManager:ctor()
  WarChessSeasonManager:SyncWCSSavingData()
  NetworkManager:GetNetwork(NetworkTypeID.Building):SendBuildingDetail()
  NetworkManager:GetNetwork(NetworkTypeID.Effector):CS_EFFECTOR_ResourceGenerator()
  ControllerManager:GetController(ControllerTypeId.TimePass, true):InitTimePassData(function()
    local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
    payGiftCtrl:InitPayGift()
    ControllerManager:GetController(ControllerTypeId.Shop, true):StartShopAllRedDot()
    NoticeManager:RefreshDungeonRewardRateNotice(false, true)
  end)
  NetworkManager:GetNetwork(NetworkTypeID.Sector):SendAchievement()
  NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_Detail(function()
    local activityFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
    if activityFrameCtr:IsExistOpenActByActType(ActivityFrameEnum.eActivityType.SectorI) then
      NetworkManager:GetNetwork(NetworkTypeID.ActivitySectorI):CS_ACTIVITYSECTORI_Detail_NOWait()
      NetworkManager:GetNetwork(NetworkTypeID.Object):AddNewWaitUserPreData(proto_csmsg_MSG_ID.MSG_SC_ACTIVITYSECTORI_Detail)
    end
    if activityFrameCtr:IsExistOpenActByActType(ActivityFrameEnum.eActivityType.BattlePass) then
      NetworkManager:GetNetwork(NetworkTypeID.BattlePass):CS_BATTLEPASS_Detail()
    end
    if activityFrameCtr:IsExistOpenActByActType(ActivityFrameEnum.eActivityType.SevenDayLogin) then
      NetworkManager:GetNetwork(NetworkTypeID.EventNoviceSign):CS_SIGNACTIVITY_Detail()
    end
    if activityFrameCtr:IsExistOpenActByActType(ActivityFrameEnum.eActivityType.HeroBackOff) then
      NetworkManager:GetNetwork(NetworkTypeID.Hero):CS_HEROREVERT_Detail()
    end
    if activityFrameCtr:IsExistOpenActByActType(ActivityFrameEnum.eActivityType.HeroGrow) then
      local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow, true)
      heroGrowCtrl:InitHeroGrow()
    end
    NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_ConcreteInfos()
    NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon):CS_DUNGEON_Dync_Detail()
    self.allTaskData:InitTimeLimitTaskRedDot()
    MsgCenter:Broadcast(eMsgEventId.ActivityShowChange)
  end)
  NetworkManager:GetNetwork(NetworkTypeID.AdjCustom):CS_MainInterface_Detail()
  NetworkManager:GetNetwork(NetworkTypeID.AchivLevel):Send_ACHIEVEMENT_Detail()
  ControllerManager:GetController(ControllerTypeId.Mail, true):GetInitData()
  NetworkManager:GetNetwork(NetworkTypeID.Task):SendQuestPeriodDetail()
  NetworkManager:GetNetwork(NetworkTypeID.Arithmetic):CS_ATH_Detail()
  NetworkManager:GetNetwork(NetworkTypeID.Friendship):CS_INTIMACY_Detail(true)
  NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon):CS_DUNGEON_STATIC_Detail()
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DungeonTower) then
    NetworkManager:GetNetwork(NetworkTypeID.DungeonTower):CS_DUNGEONTOWER_Detail()
  end
  NetworkManager:GetNetwork(NetworkTypeID.DailySignIn):CS_MONTH_CARD_Detail()
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge) then
    NetworkManager:GetNetwork(NetworkTypeID.Sector):CS_DAILYCHALLENGE_Detail()
  end
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge) then
    NetworkManager:GetNetwork(NetworkTypeID.Sector):CS_WEEKLYCHALLENGE_Detail()
  end
  ControllerManager:GetController(ControllerTypeId.Fairy, true):QuestAllFairyData()
  if table.count(self.formationDic) == 0 then
    local formation = FormationData.CreateDefault(1)
    self.formationDic[1] = formation
    NetworkManager:GetNetwork(NetworkTypeID.Hero):SendFormationFresh(1, formation.data, formation:GetFmtFairyUID())
    if formation.cstId ~= nil then
      NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill):CS_COMMANDSKILL_SaveFromFormation(formation)
    end
  end
  if userData.rechargeRewardBrief ~= nil then
    ControllerManager:GetController(ControllerTypeId.Pay, true):SetWaitShowPayResult(userData.rechargeRewardBrief)
  end
  ControllerManager:GetController(ControllerTypeId.Factory, true)
  ControllerManager:GetController(ControllerTypeId.GameNotice, true)
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Talent) and not ConfigData.buildinConfig.HeroTalentForbid then
    self.allHeroTalentData:InitHeroTalent()
    NetworkManager:GetNetwork(NetworkTypeID.Hero):CS_HERO_TALENT_Detail()
  end
  NetworkManager:GetNetwork(NetworkTypeID.Lottery):CS_LOTTERY_Detail(function()
    CS.NetworkManager.Instance:SetReconnectActive(true)
    self.isSyncUserDataEnd = true
  end)
end

function PlayerDataCenter:OnPreDataRecvComplete()
  print("接受前置数据完毕")
  self:CheckUserData()
  MsgCenter:Broadcast(eMsgEventId.SyncUserData)
end

function PlayerDataCenter:CheckUserData()
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill) then
    for formId, formation in pairs(self.formationDic) do
      if formation:IsIllegalCST(true) then
        NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill):CS_COMMANDSKILL_SaveFromFormation(formation)
      end
    end
  end
end

function PlayerDataCenter:InitHeroData(heroGroup)
  if heroGroup ~= nil then
    self.heroCount = 0
    self.hideHeroCount = 0
    for k, v in pairs(heroGroup.hero) do
      local heroData = HeroData.New(v)
      self.heroDic[heroData.dataId] = heroData
      local heroCfg = ConfigData.hero_data[heroData.dataId]
      self.campHeroCount[heroData.camp] = (self.campHeroCount[heroData.camp] or 0) + 1
      self.heroCount = self.heroCount + 1
      if heroCfg.collection_exclude then
        self.hideHeroCount = self.hideHeroCount + 1
      end
    end
    local isCST_Unlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
    local formationData = heroGroup.formation
    for k, v in pairs(formationData) do
      local formationData = FormationData.FromUserData(v)
      self.formationDic[k] = formationData
      if isCST_Unlock and FormationUtil.IsNeedResendCSTInfoFmtId(k) and formationData:GetFmtCSTDatDic() == nil then
        if formationData:IsIllegalCST(true) then
          warn("auto change fmt CST data and save")
        end
        NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill):CS_COMMANDSKILL_SaveFromFormation(formationData)
      end
    end
    local skinData = heroGroup.heroSkin
    if skinData ~= nil then
      self.skinData:UpdateData(skinData)
      local heroNetwork = NetworkManager:GetNetwork(NetworkTypeID.Hero)
      for heroId, heroData in pairs(self.heroDic) do
        self.skinData:UpdateHeroDefaultSkin(heroId)
        if not self.skinData:IsSkinUnlocked(heroData.skinId) then
          heroNetwork:CS_HERO_SkinChange(heroData.dataId, 0)
        end
      end
    end
    local favorId = heroGroup.favorId
    if favorId ~= nil then
      self.favorHeroData:InitFavorHeroDataByMsg(favorId)
    end
  end
end

function PlayerDataCenter:InitHeroHeadData(heroGroup)
  if heroGroup ~= nil then
    for k, v in pairs(heroGroup.hero) do
      self:UpdateHeroHeadData(k, true)
    end
    local skinData = heroGroup.heroSkin
    if skinData ~= nil then
      for k, v in pairs(skinData) do
        for k1, v1 in pairs(v.unlockSkin) do
          self:UpdateHeroHeadData(k1, v1)
        end
      end
    end
  end
end

function PlayerDataCenter:UpdateHeroHeadData(Id, flag)
  self.inforData.heroHeadDict[Id] = flag
end

function PlayerDataCenter:InitHeroHeadLockedDict()
  for k, v in pairs(ConfigData.hero_data) do
    self.inforData.isHeadLockedDict[k] = v.is_locked
    for k1, v1 in pairs(v.skin) do
      self.inforData.isHeadLockedDict[v1] = v.is_locked
    end
  end
end

function PlayerDataCenter:InitFunctionUnlockData(functionUnlockData)
  if functionUnlockData == nil then
    return
  end
  if functionUnlockData ~= nil then
    for k, v in pairs(functionUnlockData.data) do
      local openCfg = ConfigData.system_open[k]
      if openCfg ~= nil and openCfg.screening then
      else
        FunctionUnlockMgr:AddUnlockFunction(k, true)
      end
    end
  end
end

function PlayerDataCenter:SyncItemUpdateDiff(resourceData)
  local itemUpdate = {}
  local itemUpdateCount = {}
  local isLimitTimeItem = false
  if resourceData.backpack ~= nil then
    for itemId, v in pairs(resourceData.backpack.deletes) do
      local deleteItem = self.itemDic[itemId]
      if deleteItem ~= nil then
        self.itemTypeList[deleteItem.type][itemId] = nil
      end
      self.itemDic[itemId] = nil
      itemUpdate[itemId] = true
      if deleteItem ~= nil and isLimitTimeItem == false and deleteItem:IsLimitTime() then
        isLimitTimeItem = true
      end
    end
    for itemId, v in pairs(resourceData.backpack.updateTL) do
      local itemData = self.itemDic[itemId]
      if itemData ~= nil then
        itemData:UpdateStackInfos(v.timeLimit)
      else
        itemData = DynLimitTimeItemData.New(itemId, v.timeLimit)
        self.itemTypeList[itemData.type][itemId] = itemData
        self.itemDic[itemId] = itemData
      end
      if isLimitTimeItem == false and itemData:IsLimitTime() then
        isLimitTimeItem = true
      end
      itemUpdate[itemId] = true
    end
    for itemId, v in pairs(resourceData.backpack.updates) do
      local itemData = self.itemDic[itemId]
      if itemData ~= nil then
        itemUpdateCount[itemId] = v.count - itemData:GetCount()
        itemData:UpdateData(v)
      else
        itemUpdateCount[itemId] = v.count
        itemData = ItemData.New(v.id, v.count)
        self.itemTypeList[itemData.type][itemId] = itemData
        self.itemDic[itemId] = itemData
        self.gameSettingData:TryAddTitleItem(itemData)
      end
      itemUpdate[itemId] = false
      if isLimitTimeItem == false and itemData:IsLimitTime() then
        isLimitTimeItem = true
      end
    end
  end
  if isLimitTimeItem then
    self:CheckHaseLimitTimeItem()
    self:CheckEarliestOverdueStaminaLimitTime()
  end
  if self.dormBriefData then
    self.dormBriefData:CheckDmItemChange(itemUpdate)
  end
  MsgCenter:Broadcast(eMsgEventId.UpdateItem, itemUpdate, resourceData, itemUpdateCount)
end

function PlayerDataCenter:SyncHeroUpdateDiff(heroUpdateData)
  local hasNew = false
  local hasUpdateHero = false
  local heroUpdate
  if heroUpdateData.update ~= nil then
    heroUpdate = {}
    for heroId, hero in pairs(heroUpdateData.update) do
      local heroData = self.heroDic[heroId]
      if heroData ~= nil then
        heroData:UpdateHeroData(hero)
        heroUpdate[heroId] = false
      else
        heroData = HeroData.New(hero)
        self.heroDic[heroData.dataId] = heroData
        self.campHeroCount[heroData.camp] = (self.campHeroCount[heroData.camp] or 0) + 1
        heroUpdate[heroId] = true
        hasNew = true
        self.heroCount = self.heroCount + 1
        local heroCfg = ConfigData.hero_data[heroData.dataId]
        if heroCfg.collection_exclude then
          self.hideHeroCount = self.hideHeroCount + 1
        end
        self:UpdateHeroHeadData(heroId, true)
      end
      if heroData:GetHeroDataTalent() == nil then
        self.allHeroTalentData:TryCreateAndBindHeroTalentByHeroId(heroId)
      end
    end
    hasUpdateHero = true
  end
  local hasSkinUpdate = false
  local skinData = heroUpdateData.updateSkin
  if skinData ~= nil then
    self.skinData:UpdateData(skinData)
    for k, heroSikn in pairs(skinData) do
      for skinId, bool in pairs(heroSikn.unlockSkin) do
        self:UpdateHeroHeadData(skinId, bool)
      end
    end
    hasSkinUpdate = true
  end
  if hasUpdateHero then
    MsgCenter:Broadcast(eMsgEventId.UpdateHero, heroUpdate, hasNew)
    if hasNew then
      MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.MinHeroStar)
      for heroId, bool in pairs(heroUpdate) do
        PlayerDataCenter.skinData:UpdateHeroDefaultSkin(heroId)
      end
    end
  end
  if hasSkinUpdate then
    MsgCenter:Broadcast(eMsgEventId.UpdateHeroSkin, heroUpdateData.updateSkin)
  end
  if hasNew then
    self.allFriendshipData:AddFriendshipgBonus()
  end
end

function PlayerDataCenter:UpdateHeroBackOffData(datas)
  self.herobackoffData = HeroBackOffData.New(datas)
end

function PlayerDataCenter:IsHeroBackOffEnable(heroId)
  if self.herobackoffData == nil then
    return false, 0
  end
  return self.herobackoffData:IsHeroBackOffEnable(heroId)
end

function PlayerDataCenter:__GetItemCount(itemId, raw)
  if not raw and self.allEffectorData:IsAutoGenerateResource(itemId) then
    return self.allEffectorData:GetCurrentARGNum(itemId)
  end
  local itemData = self.itemDic[itemId]
  if itemData == nil then
    return 0
  end
  local count = itemData:GetCount()
  if GuideManager.collectResGuideUnComplete and itemId == 1004 then
    count = count - 1
  end
  return count
end

function PlayerDataCenter:GetItemOverflowNum(itemId, buyNum)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg.action_type == eItemActionType.HeroCardFrag then
    local heroData = self.heroDic[itemCfg.arg[1]]
    if heroData == nil then
      return 0
    end
    local needMaxNum = heroData:GetMaxNeedFragNum(true)
    needMaxNum = needMaxNum < 0 and 0 or needMaxNum
    if needMaxNum == 0 then
      return buyNum
    elseif 0 < needMaxNum and buyNum > needMaxNum then
      return buyNum - needMaxNum
    elseif 0 < needMaxNum and buyNum <= needMaxNum then
      return 0
    end
  else
    local nowNum = self:GetItemCount(itemCfg.id)
    if itemCfg.type == eItemType.DormFurniture then
      nowNum = nowNum + PlayerDataCenter.dormBriefData:GetFurnitureItemCountInDorm(itemCfg.id)
    elseif itemCfg.type == eItemType.Skin then
      nowNum = nowNum + (self.skinData:IsHaveSkinPermanent(itemCfg.id) and 1 or 0)
    end
    return nowNum + buyNum <= itemCfg.holdlimit and 0 or buyNum - (itemCfg.holdlimit - nowNum)
  end
  return 0
end

function PlayerDataCenter:GetItemOverflowTransItemIdAndNum(itemId, itemNum)
  local itemCfg = ConfigData.item[itemId]
  local trans_item_list = {}
  local transPara = {}
  if itemCfg.overflow_type == eItemTransType.actItemOverFlow then
    for index, value in ipairs(itemCfg.overflow_para) do
      if index % 3 ~= 1 then
        table.insert(transPara, value)
      end
    end
  else
    transPara = itemCfg.overflow_para
  end
  if not (#transPara % 2) == 0 then
    error("this overflow type has error para")
    return nil
  end
  for i = 1, #transPara, 2 do
    local trans_item = {}
    trans_item.itemId = transPara[i]
    trans_item.num = transPara[i + 1] * itemNum
    table.insert(trans_item_list, trans_item)
  end
  return trans_item_list
end

function PlayerDataCenter:GetItemCoutNoMerge(itemId, raw)
  return self:__GetItemCount(itemId, raw)
end

function PlayerDataCenter:GetItemCount(itemId, raw)
  local count = 0
  local mergeList = eItemMergeDic[itemId]
  if mergeList == nil then
    count = self:__GetItemCount(itemId, raw)
  else
    for k, id in ipairs(mergeList) do
      count = count + self:__GetItemCount(id, raw)
    end
  end
  return count
end

function PlayerDataCenter:GetDynLimtTimeItemStackInfo(itemId, index)
  local itemData = self.itemDic[itemId]
  if itemData == nil or itemData:IsDynLimitTime() ~= true then
    return nil
  end
  return itemData:GetStackInfoByIndex(index)
end

function PlayerDataCenter:GetGlobalExpCount()
  return self:GetItemCount(ConfigData.game_config.globalExpItemId)
end

function PlayerDataCenter:GetItemDicByType(itemType)
  if 0 < itemType and itemType <= ItemTypeMax then
    return self.itemTypeList[itemType]
  end
  return nil
end

function PlayerDataCenter:TryGetFormation(formationId)
  local formation = self.formationDic[formationId]
  if formation == nil then
    return false, nil, nil
  else
    return true, formation.data, formation.userSkill, formation:GetFmtCSTData()
  end
end

function PlayerDataCenter:CreateFormation(formationId)
  local formation = FormationData.Create(formationId)
  self.formationDic[formationId] = formation
  return formation
end

function PlayerDataCenter:GetResId(id)
  return self.heroDic[id].heroCfg.src_id
end

function PlayerDataCenter:UserLoginComplete(role, firstLogin)
  cs_playerData.playerName = role.name
  cs_playerData.playerId = role.id
  print("playerId", cs_playerData.strPlayerId)
  self.timezone_offset = role.timezone_offset
  self.timezone_offset_timestamp = self.timezone_offset * 3600
  cs_playerData.serverTime:UpdateServerTime(role.timestamp)
  CS.MicaSDKManager.Instance:OnPlayerLoginCompelete()
  CS.MTPManager.Instance:UserLoginComplete(0, 0, cs_playerData.strPlayerId, "")
  local cs_MicaSDKManager = CS.MicaSDKManager.Instance
  if not cs_MicaSDKManager:IsUseSdk() then
    return
  end
  if Consts.GameChannelType.IsInland() then
    local rapidjson = require("rapidjson")
    local roleTrackTab = {
      role_id = cs_playerData.strPlayerId,
      role_name = role.name
    }
    local roleTrackJson = rapidjson.encode(roleTrackTab)
    if firstLogin then
      cs_MicaSDKManager:TrackEvent("role_create", roleTrackJson)
    end
    cs_MicaSDKManager:TrackEvent("role_enter_game", roleTrackJson)
  elseif Consts.GameChannelType.IsPnSdk(cs_MicaSDKManager.channelId) then
    cs_MicaSDKManager:SetPayBasicInfo()
  elseif Consts.GameChannelType.IsOversea() then
    cs_MicaSDKManager:StatsEventPreSetUid("login")
    if firstLogin then
      cs_MicaSDKManager:StatsEventPreSetUid("create_character")
    end
  end
end

function PlayerDataCenter:UpdateUserNameData(name)
  cs_playerData.playerName = name
  MsgCenter:Broadcast(eMsgEventId.UserNameChanged)
end

function PlayerDataCenter:GetHeroData(heroId)
  local heroData = self.heroDic[heroId]
  if heroData == nil then
    error("Can't get heroData, id = " .. tostring(heroId))
  end
  return heroData
end

function PlayerDataCenter:ContainsHeroData(heroId)
  return self.heroDic[heroId] ~= nil
end

function PlayerDataCenter:TakeHeroIdSnapShoot()
  self._heroIdSnapShoot = {}
  for k, heroData in pairs(self.heroDic) do
    self._heroIdSnapShoot[heroData.dataId] = true
  end
  return self._heroIdSnapShoot
end

function PlayerDataCenter:GetHeroIdSnapShoot()
  return self._heroIdSnapShoot
end

function PlayerDataCenter:UnlockCommanderSkill()
  for key, value in pairs(self.formationDic) do
    FormationData.CreateDefultCST(key)
  end
end

function PlayerDataCenter:IsNewEnemy(ememyId)
  if self.allVisitedMonsters[ememyId] then
    if self.tempOldEnemy ~= nil and self.tempOldEnemy[ememyId] then
      return true
    end
    return false
  else
    return true
  end
end

function PlayerDataCenter:AddOldEnemy(ememyId)
  self.allVisitedMonsters[ememyId] = true
  if self.tempOldEnemy == nil then
    self.tempOldEnemy = {}
  end
  self.tempOldEnemy[ememyId] = true
end

function PlayerDataCenter:CleanTempOldEnemy()
  self.tempOldEnemy = nil
end

function PlayerDataCenter:UpdateDormBriefData(dormBrief)
  if dormBrief == nil then
    return
  end
  if self.dormBriefData ~= nil then
    self.dormBriefData:UpdateDormBriefByServer(dormBrief)
  else
    self.dormBriefData = DormBriefData.CreateDormBriefByServer(dormBrief)
    self.dormBriefData:CheckDmHouseUnlock()
  end
end

function PlayerDataCenter:GetCmderSex()
  if self.inforData == nil then
    return true
  end
  return self.inforData:GetSex()
end

function PlayerDataCenter:GetSelfName()
  return self.playerName
end

function PlayerDataCenter:GetSelfId()
  return self.playerId
end

function PlayerDataCenter:GetBattleSkillFightPower(skillId, level, power, isChip)
  local skillCfg = ConfigData.battle_skill[skillId]
  if skillCfg == nil or skillCfg.skill_comat == nil or skillCfg.skill_comat == "" then
    error("Cant get battle_skill.skill_comat, skillId = " .. tostring(skillId))
    return 0
  end
  local formulaFunc = skillCfg.skill_comat
  if type(formulaFunc) ~= "function" then
    formulaFunc = load("return function(power,lv,para1) return " .. skillCfg.skill_comat .. " end")()
    skillCfg.skill_comat = formulaFunc
  end
  local para1 = 1
  if isChip then
    if self._skillFormulaPara1 == nil then
      self._skillFormulaPara1 = {}
    end
    self._skillFormulaPara1.lv = level
    para1 = ConfigData.GetFormulaValue(eFormulaType.ChipPara, self._skillFormulaPara1)
  end
  local power = formulaFunc(power, level, para1)
  power = math.floor(power)
  return power
end

function PlayerDataCenter:GetUserInfoByUID(uid, callback)
  if uid == self.inforData:GetUserUID() then
    callback(self.inforData)
    return
  end
  local userInfo
  userInfo = self.friendDataCenter:TryGetFriendData(uid)
  if userInfo ~= nil and not userInfo:GetIsNeedFreshData() then
    callback(userInfo)
    return
  end
  if userInfo == nil then
    userInfo = self.friendDataCenter:TryGetFriendApplyData(uid)
    if userInfo ~= nil and not userInfo:GetIsNeedFreshData() then
      callback(userInfo)
      return
    end
  end
  if userInfo == nil then
    userInfo = self.__userInfoDataCacheDic[uid]
    if userInfo ~= nil and not userInfo:GetIsNeedFreshData() then
      callback(userInfo)
      return
    end
  end
  
  local function next()
    table.remove(self.__waitAvatarFetchList, 1)
    if #self.__waitAvatarFetchList > 0 then
      self.__waitAvatarFetchList[1]()
    end
  end
  
  local function netFunc()
    NetworkManager:GetNetwork(NetworkTypeID.Object):CS_AVATAR_Fetch(uid, function(args)
      local avatarMsg
      if args ~= nil and args.Count > 0 then
        avatarMsg = args[0]
        if avatarMsg == false then
          callback(nil)
          next()
          return
        end
      else
        callback(nil)
        next()
        return
      end
      if userInfo ~= nil then
        userInfo:UpdateByAvatarMsg(avatarMsg)
        callback(userInfo)
        next()
        return
      end
      if self.__userInfoDataCacheDic[uid] ~= nil then
        self.__userInfoDataCacheDic[uid]:UpdateByAvatarMsg(avatarMsg)
      else
        local data = UserInfoData.CreateStrangerDataWithAvatarMsg(avatarMsg)
        self.__userInfoDataCacheDic[uid] = data
      end
      callback(self.__userInfoDataCacheDic[uid])
      next()
      if self.__infoDataCacheTimerId == nil then
        self.__infoDataCacheTimerId = TimerManager:StartTimer(10, self.UserInfoCacheOutOfData, self, false, false, true)
      end
    end)
  end
  
  if self.__waitAvatarFetchList == nil then
    self.__waitAvatarFetchList = {}
  end
  table.insert(self.__waitAvatarFetchList, netFunc)
  if #self.__waitAvatarFetchList == 1 then
    netFunc()
  end
end

function PlayerDataCenter:GetUserInfoByUIDList(uidList, callback)
  if uidList == nil or #uidList == 0 then
    callback(nil)
    return
  end
  local result = {}
  local needNetFetchUidList = {}
  for index, uid in ipairs(uidList) do
    local userInfo = self:GetUserInfoByUIDFromCache(uid)
    if userInfo ~= nil then
      table.insert(result, userInfo)
    else
      needNetFetchUidList[uid] = true
    end
  end
  if #uidList == #result then
    callback(result)
    return
  end
  
  local function next()
    table.remove(self.__waitAvatarFetchList, 1)
    if #self.__waitAvatarFetchList > 0 then
      self.__waitAvatarFetchList[1]()
    end
  end
  
  local function netFunc()
    NetworkManager:GetNetwork(NetworkTypeID.Object):CS_AVATAR_Fetch_Multi(needNetFetchUidList, function(avatarMap)
      if avatarMap == nil or table.length(avatarMap) == 0 then
        callback(result)
        next()
        return
      end
      for uid, avatarMsg in pairs(avatarMap) do
        local ignoreExpirationTime = true
        local userInfo = self:GetUserInfoByUIDFromCache(uid, ignoreExpirationTime)
        if userInfo ~= nil then
          userInfo:UpdateByAvatarMsg(avatarMsg)
          table.insert(result, userInfo)
        else
          local data = UserInfoData.CreateStrangerDataWithAvatarMsg(avatarMsg)
          self.__userInfoDataCacheDic[uid] = data
          table.insert(result, data)
        end
      end
      for index, userId in ipairs(uidList) do
        for key, userInfoData in pairs(result) do
          if userId == userInfoData:GetUserUID() then
            local temp = result[key]
            result[key] = result[index]
            result[index] = temp
          end
        end
      end
      callback(result)
      next()
      if self.__infoDataCacheTimerId == nil then
        self.__infoDataCacheTimerId = TimerManager:StartTimer(10, self.UserInfoCacheOutOfData, self, false, false, true)
      end
    end)
  end
  
  if self.__waitAvatarFetchList == nil then
    self.__waitAvatarFetchList = {}
  end
  table.insert(self.__waitAvatarFetchList, netFunc)
  if #self.__waitAvatarFetchList == 1 then
    netFunc()
  end
end

function PlayerDataCenter:GetUserInfoByUIDFromCache(uid, ignoreExpirationTime)
  if ignoreExpirationTime == nil then
    ignoreExpirationTime = false
  end
  if uid == self.inforData:GetUserUID() then
    return self.inforData
  end
  local userInfo
  userInfo = self.friendDataCenter:TryGetFriendData(uid)
  if userInfo ~= nil and (ignoreExpirationTime or not userInfo:GetIsNeedFreshData()) then
    return userInfo
  end
  if userInfo == nil then
    userInfo = self.friendDataCenter:TryGetFriendApplyData(uid)
    if userInfo ~= nil and (ignoreExpirationTime or not userInfo:GetIsNeedFreshData()) then
      return userInfo
    end
  end
  if userInfo == nil then
    userInfo = self.__userInfoDataCacheDic[uid]
    if userInfo ~= nil and (ignoreExpirationTime or not userInfo:GetIsNeedFreshData()) then
      return userInfo
    end
  end
end

function PlayerDataCenter:UserInfoCacheOutOfData()
  for uid, userCacheInfo in pairs(self.__userInfoDataCacheDic) do
    if userCacheInfo:GetIsNeedFreshData() then
      self.__userInfoDataCacheDic[uid] = nil
    end
  end
  if table.count(self.__userInfoDataCacheDic) <= 0 then
    TimerManager:StopTimer(10, self.__infoDataCacheTimerId)
    self.__infoDataCacheTimerId = nil
  end
end

function PlayerDataCenter:OnLogOut()
  self.supportHeroData:Delete()
  self:InitData()
  if self.__infoDataCacheTimerId ~= nil then
    TimerManager:StopTimer(10, self.__infoDataCacheTimerId)
    self.__infoDataCacheTimerId = nil
  end
end

function PlayerDataCenter:CheckHaseLimitTimeItem()
  local isHasMin15 = false
  local isHas = false
  
  local function checkDay(time)
    local diffTime = time - PlayerDataCenter.timestamp
    if 0 < diffTime then
      local d = TimeUtil:TimestampToTimeInter(diffTime, false, true)
      if d < 15 then
        return true, true
      end
      return false, true
    end
    return false, false
  end
  
  for k, v in pairs(self.itemDic) do
    if not ((v:GetWareHousePage() or 0) <= 0) then
      if v:IsDynLimitTime() and v:GetWareHousePage() > 0 then
        for i = 1, v:GetStackCount() do
          isHasMin15, isHas = checkDay(v:GetLimitTime(i))
          if isHasMin15 then
            break
          end
        end
        if isHasMin15 then
          break
        end
      elseif v:IsLimitTime() then
        isHasMin15, isHas = checkDay(v:GetLimitTime())
        if isHasMin15 then
          break
        end
      end
    end
  end
  if isHasMin15 ~= self.isHasMin15LimitTime then
    self.isHasMin15LimitTime = isHasMin15
    MsgCenter:Broadcast(eMsgEventId.UpdateWareHouseLimitTime, self.isHasMin15LimitTime)
  end
  self.isHasLimitTime = isHas
end

function PlayerDataCenter:GetIsHasLimitTime()
  if self.isHasLimitTime == nil then
    self:CheckHaseLimitTimeItem()
  end
  return self.isHasLimitTime
end

function PlayerDataCenter:GetIsHasMin15LimitTime()
  if self.isHasMin15LimitTime == nil then
    self:CheckHaseLimitTimeItem()
  end
  return self.isHasMin15LimitTime
end

function PlayerDataCenter:GetDynLimtTimeItemStackCount(itemId)
  local itemData = self.itemDic[itemId]
  if itemData == nil or itemData:IsDynLimitTime() ~= true then
    return 1
  end
  local stackNum = itemData:GetStackCount()
  return stackNum
end

function PlayerDataCenter:IsItemOutTime(itemId, stacIndex)
  local itemData = self.itemDic[itemId]
  if itemData == nil then
    return true
  end
  if itemData:IsLimitTime() ~= true then
    return false
  end
  local time = 0
  if itemData:IsDynLimitTime() then
    time = itemData:GetLimitTime(stacIndex == nil and 0 or stacIndex)
  else
    time = itemData:GetLimitTime()
  end
  if time <= PlayerDataCenter.timestamp then
    return true
  end
end

function PlayerDataCenter:IsItemLimitHold(itemId)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil or itemCfg.holdlimit == 0 then
    return false
  end
  if itemCfg.type == eItemType.DormFurniture then
    local count = self.dormBriefData:GetFurnitureItemCountInDorm(itemId)
    return self:GetItemCount(itemId) + count >= itemCfg.holdlimit
  end
  if itemCfg.type == eItemType.Skin then
    return self.skinData:IsHaveSkinPermanent(itemId)
  end
  return self:GetItemCount(itemId) >= itemCfg.holdlimit
end

function PlayerDataCenter:CalCrItemTransDic(itemIds, itemNums)
  local dic = {}
  for i, itemId in pairs(itemIds) do
    local itemCfg = ConfigData.item[itemId]
    local itemCount = itemNums[i]
    if itemCfg.overflow_type == eItemTransType.actMoneyX then
      local num = PlayerDataCenter:GetItemOverflowNum(itemId, itemCount)
      if num ~= 0 then
        dic[itemId] = num
      end
    end
  end
  return dic
end

function PlayerDataCenter:CheckEarliestOverdueStaminaLimitTime()
  local limitDay, limitHour, limitMinute, isHasMin1Day = self:GetEarliestOverdueStaminaLimitTime()
  MsgCenter:Broadcast(eMsgEventId.UpdateStaminaLimitTime, limitDay, limitHour, limitMinute, isHasMin1Day)
end

function PlayerDataCenter:GetEarliestOverdueStaminaLimitTime()
  local isHasMin1Day = false
  local limitDay = -1
  local limitHour = -1
  local limitMinute = -1
  
  local function checkDay(time)
    local diffTime = time - PlayerDataCenter.timestamp
    if 0 < diffTime then
      local d, h, m = TimeUtil:TimestampToTimeInter(diffTime, false, true)
      if d < 3 then
        return d, h, m
      end
    end
    return -1, -1, -1
  end
  
  local function swapNum(tempDay, tempHour, tempMinute)
    limitDay = tempDay
    limitHour = tempHour
    limitMinute = tempMinute
  end
  
  local function compareNum(tempDay, tempHour, tempMinute)
    if limitDay < 0 and limitHour < 0 and limitMinute < 0 then
      swapNum(tempDay, tempHour, tempMinute)
      return
    end
    local limitTime = limitMinute + limitHour * 60 + limitDay * 24 * 60
    local tempTime = tempMinute + tempHour * 60 + tempDay * 24 * 60
    if limitTime > tempTime then
      swapNum(tempDay, tempHour, tempMinute)
    end
  end
  
  for k, v in pairs(StaminaLimitTimeItemDic) do
    local itemData = self.itemDic[k]
    if itemData ~= nil then
      local tempDay = -1
      local tempHour = -1
      local tempMinute = -1
      for i = 1, itemData:GetStackCount() do
        tempDay, tempHour, tempMinute = checkDay(itemData:GetLimitTime(i))
        if 0 <= tempMinute then
          compareNum(tempDay, tempHour, tempMinute)
          isHasMin1Day = limitDay < 1
        end
      end
    end
  end
  return limitDay, limitHour, limitMinute, isHasMin1Day
end

function PlayerDataCenter:GetLvLimitHeroList(levelLimit)
  local lvLimitHeroList = {}
  for k, heroData in pairs(self.heroDic) do
    if levelLimit > heroData.level then
      table.insert(lvLimitHeroList, heroData)
    end
  end
  table.sort(lvLimitHeroList, function(a, b)
    if a.level ~= b.level then
      return a.level < b.level
    end
    return a.dataId > b.dataId
  end)
  return lvLimitHeroList
end

return PlayerDataCenter
