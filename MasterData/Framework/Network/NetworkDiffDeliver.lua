local NetworkDiffDeliver = {}
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local diffOrderList = {
  proto_csmsg_SyncUpdateDiffEnum.DIFF_FUNCTION,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_USERBASE,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_BATTLEPASS,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_BUILDING,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_INTIMACY,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_FACTORY,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_SECTOR,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ALG,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_EXPLORATION,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_HERO,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_FAIRY,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ATH,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_DRAWLOTTERY,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_RESOURCE,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_EFFECTORRG,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_QUEST,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACHIEVEMENT,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_LOTTERY,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_COUNTER,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_MAIL,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_MONTHCARD,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ENDLESS,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_FRIEND,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_DUNGEON_DYNC,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_TIMING_PRODUCT,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_SECTOR_I,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_SECTOR_Hero,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_DUNGEON_TOWER,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_HERO_TALENT,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_SECTOR_II,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_VALENTINE,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_ROUND,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_REFRESHDUNGEON,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_QUEST,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_CARNIVAL,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_EFFECT,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_TINYGAME,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_RECHARGE,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_SUMMER2022,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_HALLOWEEN,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_WINTER2023,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_INVITATION,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_KEYEXERTION,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_SEASON,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_CARINIVAL2023,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_CARD,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_SPRING,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_MILESTONE,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_HERO_DIVERGENT,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_EXPLORE_FUND,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_SIGN_THEATER,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_BLACKHOLE,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_DAILYCHALLENGE,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_STEINSGATE,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_GENERAL,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_MONSTERCARD,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_HARD_DUNGEON,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_SECTOR_HERO_LITE,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_ORDER,
  proto_csmsg_SyncUpdateDiffEnum.DFII_ACTIVITY_BOND,
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_ANNIV24
}
local needHeroRecordFlags = {
  proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_HERO_DIVERGENT
}
local diffFuncTable = {
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACHIEVEMENT] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.achievement
    local AchivLevelNetwork = NetworkManager:GetNetwork(NetworkTypeID.AchivLevel)
    if diffMsg ~= nil then
      AchivLevelNetwork:AchieveLevelCommonDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ATH] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.ath
    local AthNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
    if diffMsg ~= nil then
      AthNetwork:SC_ATH_SyncUpdateDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_BUILDING] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.building
    local buildingNetwork = NetworkManager:GetNetwork(NetworkTypeID.Building)
    if diffMsg ~= nil then
      buildingNetwork:OnRecvBuildingSyncUpdateDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_EFFECTORRG] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.effectorRG
    local EffectorNetwork = NetworkManager:GetNetwork(NetworkTypeID.Effector)
    if diffMsg ~= nil then
      EffectorNetwork:SC_EFFECTOR_RGSyncUpdateDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ENDLESS] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.endless
    local SectorNetwork = NetworkManager:GetNetwork(NetworkTypeID.Sector)
    if diffMsg ~= nil then
      SectorNetwork:SC_ENDLESS_SyncUpdateDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_EXPLORATION] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.exploration
    local epNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
    if diffMsg ~= nil then
      epNetwork:SC_EXPLORATION_SyncUpdateDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_FACTORY] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.factory
    local FactoryNetwork = NetworkManager:GetNetwork(NetworkTypeID.Factory)
    if diffMsg ~= nil then
      FactoryNetwork:FactoryCommonDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_HERO] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.hero
    local ObjectNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
    if diffMsg ~= nil then
      ObjectNetwork:SC_HERO_SyncUpdateDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_FAIRY] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.fairy
    local fairyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy)
    if fairyCtrl ~= nil then
      fairyCtrl:UpdateDiffFairyData(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_MAIL] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.mail
    local MailNetwork = NetworkManager:GetNetwork(NetworkTypeID.Mail)
    if diffMsg ~= nil then
      MailNetwork:MailCommonDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_QUEST] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.quest
    local TaskNetwork = NetworkManager:GetNetwork(NetworkTypeID.Task)
    if diffMsg ~= nil then
      TaskNetwork:OnRecvSyncUpdateDiff(diffMsg, syncUpdateDiff)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_SECTOR] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.sector
    local SectorNetwork = NetworkManager:GetNetwork(NetworkTypeID.Sector)
    if diffMsg ~= nil then
      SectorNetwork:SC_SECTOR_SyncUpdateDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_COUNTER] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.counter
    local ObjectNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
    if diffMsg ~= nil then
      ObjectNetwork:SC_COUNTER_SyncUpdateDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_FUNCTION] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.functions
    local ObjectNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
    if diffMsg ~= nil then
      ObjectNetwork:SC_FUNCTION_SyncUpdateDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_RESOURCE] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.resource
    local ObjectNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
    if diffMsg ~= nil then
      ObjectNetwork:ItemDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_USERBASE] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.userBase
    local ObjectNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
    if diffMsg ~= nil then
      ObjectNetwork:userBaseDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ALG] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.alg
    local BattleDungeonNetwork = NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)
    if diffMsg ~= nil then
      BattleDungeonNetwork:SC_BATTLE_NtfAlgDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_INTIMACY] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.intimacy
    local friendshipNetwork = NetworkManager:GetNetwork(NetworkTypeID.Friendship)
    if diffMsg ~= nil then
      friendshipNetwork:SC_INTIMACY_SyncDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_BATTLEPASS] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.battlepass
    if diffMsg ~= nil then
      NetworkManager:GetNetwork(NetworkTypeID.BattlePass):SC_BATTLEPASS_SyncDiff(diffMsg)
    end
    return true
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_MONTHCARD] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.monthCard
    local dailySignInNetwork = NetworkManager:GetNetwork(NetworkTypeID.DailySignIn)
    if diffMsg ~= nil then
      dailySignInNetwork:ApplyMonthCardDiff(diffMsg.update)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.activity
    local netWorkController = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
    if diffMsg ~= nil then
      netWorkController:ApplyActivityDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_LOTTERY] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.lottery
    local netWorkController = NetworkManager:GetNetwork(NetworkTypeID.Lottery)
    if diffMsg ~= nil then
      netWorkController:SC_LOTTERY_SyncDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_FRIEND] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.friend
    local netWorkController = NetworkManager:GetNetwork(NetworkTypeID.Friend)
    if diffMsg ~= nil and netWorkController ~= nil then
      netWorkController:HandleFriendDiffer(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_DUNGEON_DYNC] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.dungeonDync
    local netWorkController = NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)
    if diffMsg ~= nil and netWorkController ~= nil then
      netWorkController:SC_DUNGEON_Dync_SyncDiff(diffMsg)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_TIMING_PRODUCT] = function(syncUpdateDiff)
    local timingProduct = syncUpdateDiff.timingProduct
    local netWorkController = NetworkManager:GetNetwork(NetworkTypeID.TimingProduct)
    if timingProduct ~= nil and netWorkController ~= nil then
      netWorkController:SC_TimingProduct_SyncUpdateDiff(timingProduct)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_SECTOR_I] = function(syncUpdateDiff)
    local acitvitySectorI = syncUpdateDiff.acitvitySectorI
    local netWorkController = NetworkManager:GetNetwork(NetworkTypeID.ActivitySectorI)
    if acitvitySectorI ~= nil and netWorkController ~= nil then
      netWorkController:SC_ACTIVITYSECTORI_SyncDiff(acitvitySectorI)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_SECTOR_Hero] = function(syncUpdateDiff)
    if syncUpdateDiff.acitvitySectorHero ~= nil then
      local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow, true)
      heroGrowCtrl:UpdateHeroGrow(syncUpdateDiff.acitvitySectorHero.data)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_DUNGEON_TOWER] = function(syncUpdateDiff)
    if syncUpdateDiff.dungeonTower ~= nil then
      PlayerDataCenter.dungeonTowerSData:UpdateTowerServerData(syncUpdateDiff.dungeonTower)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_HERO_TALENT] = function(syncUpdateDiff)
    if syncUpdateDiff.heroTalent ~= nil then
      local networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Hero)
      networkCtrl:SC_HERO_TALENT_SyncDiff(syncUpdateDiff.heroTalent)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_SECTOR_II] = function(syncUpdateDiff)
    if syncUpdateDiff.activitySectorII ~= nil then
      local networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.DungeonSectorII)
      networkCtrl:SC_ACTIVITYSCTORII_SyncDiff(syncUpdateDiff.activitySectorII)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_VALENTINE] = function(syncUpdateDiff)
    if syncUpdateDiff.activityValentine ~= nil then
      local whiteDayCtrl = ControllerManager:GetController(ControllerTypeId.WhiteDay)
      if whiteDayCtrl ~= nil then
        whiteDayCtrl:UpdataSingleWhiteDayActivity(syncUpdateDiff.activityValentine.data)
      end
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_ROUND] = function(syncUpdateDiff)
    if syncUpdateDiff.activityRound ~= nil then
      local activityRoundCtrl = ControllerManager:GetController(ControllerTypeId.ActivityRound)
      if activityRoundCtrl ~= nil then
        activityRoundCtrl:UpdateActivityRound(syncUpdateDiff.activityRound.data)
      end
    end
    return true
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_REFRESHDUNGEON] = function(syncUpdateDiff)
    if syncUpdateDiff.activityRefreshDungeon ~= nil then
      local refreshDunCtrl = ControllerManager:GetController(ControllerTypeId.ActRefreshDungeon)
      if refreshDunCtrl ~= nil then
        refreshDunCtrl:UpdateAllRefreshDunActivity(syncUpdateDiff.activityRefreshDungeon.data)
      end
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_QUEST] = function(syncUpdateDiff)
    if syncUpdateDiff.activityQuest ~= nil then
      local activityTaskCtrl = ControllerManager:GetController(ControllerTypeId.ActivityTask)
      if activityTaskCtrl ~= nil then
        for k, singleMsg in pairs(syncUpdateDiff.activityQuest.data) do
          activityTaskCtrl:UpadteTaskActivity(singleMsg)
        end
      end
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_CARNIVAL] = function(syncUpdateDiff)
    if syncUpdateDiff.activityCarnival ~= nil then
      local activityCarnivalCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival)
      if activityCarnivalCtrl ~= nil then
        for k, singleMsg in pairs(syncUpdateDiff.activityCarnival.data) do
          activityCarnivalCtrl:UpdateCarnivalAct(singleMsg)
        end
      end
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_EFFECT] = function(syncUpdateDiff)
    if syncUpdateDiff.effect ~= nil then
      MsgCenter:Broadcast(eMsgEventId.OnSpecEffectDiff, syncUpdateDiff.effect.diff)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_TINYGAME] = function(syncUpdateDiff)
    if syncUpdateDiff.tinyGame ~= nil then
      local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
      activityFrameCtrl:UpdateAllTinyGame(syncUpdateDiff.tinyGame.diff)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_RECHARGE] = function(syncUpdateDiff)
    if syncUpdateDiff.recharge ~= nil then
      local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
      payCtrl:RechargeSync(syncUpdateDiff.recharge.stat)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_SUMMER2022] = function(syncUpdateDiff)
    if syncUpdateDiff.activitySummer2022 ~= nil then
      local sectorIIICtrl = ControllerManager:GetController(ControllerTypeId.ActivitySectorIII, true)
      sectorIIICtrl:InitSectorIIIData(syncUpdateDiff.activitySummer2022.data)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_HALLOWEEN] = function(syncUpdateDiff)
    if syncUpdateDiff.activityHalloween ~= nil then
      local hallowmasCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas, true)
      local list = syncUpdateDiff.activityHalloween.data
      if list ~= nil then
        for i, msg in ipairs(list) do
          hallowmasCtrl:UpdateHallowmas(msg)
        end
      end
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_WINTER2023] = function(syncUpdateDiff)
    if syncUpdateDiff.activityWinter2023 ~= nil then
      local winter23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
      if winter23Ctrl then
        winter23Ctrl:UpdateWinter23(syncUpdateDiff.activityWinter2023.data)
      end
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_INVITATION] = function(syncUpdateDiff)
    if syncUpdateDiff.activityInvitation ~= nil then
      local invitationCtrl = ControllerManager:GetController(ControllerTypeId.ActivityInvitation)
      if invitationCtrl ~= nil then
        invitationCtrl:UpdateInvitation(syncUpdateDiff.activityInvitation)
        return true
      end
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_KEYEXERTION] = function(syncUpdateDiff)
    if syncUpdateDiff.activityKeyExertion ~= nil then
      local keyExertionCtrl = ControllerManager:GetController(ControllerTypeId.ActivityKeyExertion)
      if keyExertionCtrl ~= nil then
        keyExertionCtrl:UpdateAllKeyExertionData(syncUpdateDiff.activityKeyExertion.data)
        return true
      end
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_SEASON] = function(syncUpdateDiff)
    if syncUpdateDiff.activitySeason ~= nil then
      local activitySeasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
      if activitySeasonCtrl ~= nil then
        for _, data in pairs(syncUpdateDiff.activitySeason) do
          activitySeasonCtrl:UpdateSeasons(data)
        end
        return true
      end
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_CARINIVAL2023] = function(syncUpdateDiff)
    if syncUpdateDiff.activityCarnival2023 ~= nil then
      local activityCarnival23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23)
      if activityCarnival23Ctrl ~= nil then
        for _, data in pairs(syncUpdateDiff.activityCarnival2023) do
          activityCarnival23Ctrl:UpdateCarnival23(data)
        end
        return true
      end
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_CARD] = function(syncUpdateDiff)
    if syncUpdateDiff.activityCard ~= nil then
      local cardSetCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
      if cardSetCtrl ~= nil then
        cardSetCtrl:InitActCardSetData(syncUpdateDiff.activityCard.data)
        return true
      end
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_SPRING] = function(syncUpdateDiff)
    if syncUpdateDiff.activitySpring ~= nil then
      local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
      if springCtrl ~= nil then
        for _, data in pairs(syncUpdateDiff.activitySpring) do
          springCtrl:UpdateSpring(data)
        end
        return true
      end
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_MILESTONE] = function(syncUpdateDiff)
    local diffMsg = syncUpdateDiff.mileStone
    PlayerDataCenter.inforData:UpdateMilestone(diffMsg)
    MsgCenter:Broadcast(eMsgEventId.milestoneDataUpdate)
    return true
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_HERO_DIVERGENT] = function(syncUpdateDiff, self)
    if syncUpdateDiff.activityHeroDivergent ~= nil then
      local divergentCtrl = ControllerManager:GetController(ControllerTypeId.ActivityDivergent)
      if divergentCtrl == nil then
        return
      end
      local rewardDic = syncUpdateDiff.activityHeroDivergent.lvRewards
      if rewardDic ~= nil and table.count(rewardDic) > 0 then
        UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
          if window == nil then
            return
          end
          local CommonRewardData = require("Game.CommonUI.CommonRewardData")
          local CRData = CommonRewardData.CreateCRDataUseDic(rewardDic):SetCRNotHandledGreat(true):SetCRTitle(ConfigData:GetTipContent(9607)):SetCRHeroSnapshoot(self:__GetDiffHeroSnap(), false)
          window:AddAndTryShowReward(CRData)
        end)
      end
      for _, msg in pairs(syncUpdateDiff.activityHeroDivergent.data) do
        divergentCtrl:UpdateDivergent(msg)
      end
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_EXPLORE_FUND] = function(syncUpdateDiff)
    if syncUpdateDiff.activityExploreFund ~= nil then
      local explorationFundCtrl = ControllerManager:GetController(ControllerTypeId.ActivityExplorationFund)
      if explorationFundCtrl == nil then
        return
      end
      for _, msg in pairs(syncUpdateDiff.activityExploreFund.data) do
        explorationFundCtrl:UpdateExplorationFund(msg)
      end
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_SIGN_THEATER] = function(syncUpdateDiff)
    if syncUpdateDiff.activitySignTheater ~= nil then
      local ctrl = ControllerManager:GetController(ControllerTypeId.ShortTheatre)
      if ctrl == nil then
        return
      end
      ctrl:UpdateShortTheatre(syncUpdateDiff.activitySignTheater.data)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_BLACKHOLE] = function(syncUpdateDiff)
    if syncUpdateDiff.activityBlackHole ~= nil then
      local ctrl = ControllerManager:GetController(ControllerTypeId.ActBlackHole)
      if ctrl == nil then
        return
      end
      for _, data in pairs(syncUpdateDiff.activityBlackHole.data) do
        ctrl:UpdateBlackHole(data)
      end
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_DAILYCHALLENGE] = function(syncUpdateDiff)
    if syncUpdateDiff.dailyChallenge ~= nil then
      local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityDailyChallenge)
      if ctrl == nil then
        return
      end
      ctrl:UpdateADC(syncUpdateDiff.dailyChallenge.data)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_STEINSGATE] = function(syncUpdateDiff)
    if syncUpdateDiff.activitySteinsGate ~= nil then
      local ctrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
      if ctrl == nil then
        return
      end
      ctrl:UpdateSteinsGate(syncUpdateDiff.activitySteinsGate.data)
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_DRAWLOTTERY] = function(syncUpdateDiff)
    if syncUpdateDiff.activityDrawLottery ~= nil then
      local ctrl = ControllerManager:GetController(ControllerTypeId.EventDrawLottery)
      if ctrl == nil then
        return
      end
      for _, data in pairs(syncUpdateDiff.activityDrawLottery.data) do
        ctrl:UpdateEventDrawLottery(data)
      end
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_MONSTERCARD] = function(syncUpdateDiff)
    if syncUpdateDiff.activityMonsterCard ~= nil then
      local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
      for _, elem in pairs(syncUpdateDiff.activityMonsterCard.data) do
        local actFrameId = elem.actLongId
        local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
        if actFrameData ~= nil then
          local actBaseData = actFrameData:GetActivityData()
          actBaseData:RefreshActivityMonsterCardData(elem, true)
        end
      end
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_HARD_DUNGEON] = function(syncUpdateDiff)
    if syncUpdateDiff.activityHardDungeon ~= nil then
      local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
      for _, elem in pairs(syncUpdateDiff.activityHardDungeon.data) do
        local actFrameId = elem.actLongId
        local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
        if actFrameData ~= nil then
          local actBaseData = actFrameData:GetActivityData()
          actBaseData:RefreshCommonHardLevelPlayData(elem)
        end
      end
      return true
    end
    return true
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_GENERAL] = function(syncUpdateDiff)
    if syncUpdateDiff.activityGeneral ~= nil then
      if syncUpdateDiff.activityGeneral.taskRecord ~= nil then
        local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
        actFrameCtrl:UpdateActivityTaskCompleted(syncUpdateDiff.activityGeneral.taskRecord)
      end
      if syncUpdateDiff.activityGeneral.normal ~= nil then
        local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
        for actFrameId, elem in pairs(syncUpdateDiff.activityGeneral.normal) do
          local tempActFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
          if tempActFrameData then
            local actBaseData = tempActFrameData:GetActivityData()
            if actBaseData then
              actBaseData:RefreshActivityBpPoint(elem.questBP)
              actBaseData:RefreshActivityGiftItems(elem.giftItem)
            end
          end
        end
      end
      if syncUpdateDiff.activityGeneral.bp ~= nil then
        for actFrameId, elem in pairs(syncUpdateDiff.activityGeneral.bp) do
          local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
          local tempActFrameData = actFrameCtrl:GetActivityFrameData(elem.actLongId)
          if tempActFrameData then
            local actBaseData = tempActFrameData:GetActivityData()
            if actBaseData then
              actBaseData:RefreshActivityCommonRewardBp(elem)
            end
          end
        end
      end
      if syncUpdateDiff.activityGeneral.exGeneralHighScore ~= nil then
        MsgCenter:Broadcast(eMsgEventId.ActivityRankScoreChange, syncUpdateDiff.activityGeneral.exGeneralHighScore)
      end
    end
    return true
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_SECTOR_HERO_LITE] = function(syncUpdateDiff)
    if syncUpdateDiff.acitvitySectorHeroLite ~= nil then
      local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
      local activityHeroGrowV3Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrowV3)
      for _, elem in pairs(syncUpdateDiff.acitvitySectorHeroLite.data) do
        local actId = elem.actId
        local actFrameId = actFrameCtrl:GetIdByActTypeAndActId(ActivityFrameEnum.eActivityType.HeroGrowV3, actId)
        local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
        activityHeroGrowV3Ctrl:UpdateHGV3DataByMsg(elem)
      end
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_ORDER] = function(syncUpdateDiff)
    if syncUpdateDiff.activityOrder ~= nil then
      local ctrl = ControllerManager:GetController(ControllerTypeId.ActSigninLiveStreamCtrl, true)
      for _, elem in pairs(syncUpdateDiff.activityOrder.data) do
        ctrl:UpdateSILSDataByMsg(elem)
      end
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DFII_ACTIVITY_BOND] = function(syncUpdateDiff)
    if syncUpdateDiff.activityBond ~= nil then
      local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityBond, true)
      for _, elem in pairs(syncUpdateDiff.activityBond.data) do
        ctrl:UpdateActData(elem)
      end
      return true
    end
  end,
  [proto_csmsg_SyncUpdateDiffEnum.DIFF_ACTIVITY_ANNIV24] = function(syncUpdateDiff)
    if syncUpdateDiff.anniv24 ~= nil then
      local actAn24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
      if actAn24Ctrl == nil then
        return false
      end
      actAn24Ctrl:DiffActAnv24Ctrl(syncUpdateDiff.anniv24)
      return true
    end
  end
}

function NetworkDiffDeliver:HandleDiff(syncUpdateDiff)
  if syncUpdateDiff == nil then
    return
  end
  local flagMap = syncUpdateDiff.flag
  if self:__GetIsNeedRecordHero(flagMap) then
    self:__RecordDiffHeroSnap()
  else
    self:__ClearDiffHeroSnap()
  end
  for k, syncUpdateDiffEnum in ipairs(diffOrderList) do
    if flagMap[syncUpdateDiffEnum] then
      self:__HandleDiffEnum(syncUpdateDiff, syncUpdateDiffEnum)
    end
  end
  MsgCenter:Broadcast(eMsgEventId.NetDiffSyncFinish)
end

function NetworkDiffDeliver:__GetIsNeedRecordHero(flagMap)
  for _, flagId in ipairs(needHeroRecordFlags) do
    if flagMap[flagId] ~= nil then
      return true
    end
  end
  return false
end

function NetworkDiffDeliver:__RecordDiffHeroSnap()
  self._diffHeroSnap = PlayerDataCenter:TakeHeroIdSnapShoot()
end

function NetworkDiffDeliver:__GetDiffHeroSnap()
  return self._diffHeroSnap or table.emptytable
end

function NetworkDiffDeliver:__ClearDiffHeroSnap()
  self._diffHeroSnap = nil
end

function NetworkDiffDeliver:__HandleDiffEnum(syncUpdateDiff, syncUpdateDiffEnum)
  local func = diffFuncTable[syncUpdateDiffEnum]
  if func ~= nil then
    local isSuccessUpdate = func(syncUpdateDiff, self)
    if not isSuccessUpdate then
      error("can't apply diff diffId=" .. tostring(syncUpdateDiffEnum))
    end
  else
    error("don't have diffFunc diffId=" .. tostring(syncUpdateDiffEnum))
  end
end

return NetworkDiffDeliver
