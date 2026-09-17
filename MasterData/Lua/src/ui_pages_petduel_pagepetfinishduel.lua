local this = class("pagePetFinishDuel", G_UIPageBase)
local kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
local kibiDuelGroupTpl = L_GameTpl:getKiBoDuelGroupTpl()
local worldSpawnerTpl = L_GameTpl:getWorldSpawnerTpl()
local commonConditionTpl = L_GameTpl:getCommonConditionTpl()
local currencyTpl = L_GameTpl:getCurrencyTpl()
local trainTaskTpl = L_GameTpl:getTrainTaskTpl()
local petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    conditionIsOn = true,
    txt_leftTime = "",
    playerSlider = 0,
    enemySlider = 0,
    playerName = "",
    playerHealthy = "",
    enemyName = "",
    enemyHealthy = "",
    rewardActive = false,
    rewardList = L_Const.ModuleInfo.CellIconBag,
    conditionList = {
      moduleName = "pages/petDuel/cellFinishCondition"
    },
    failedTips = "",
    petList = {
      moduleName = "pages/petDuel/cellPetExpItem"
    },
    petsExpActive = false,
    buttonsActive = true,
    conditionContentActive = false,
    moduleAreaLevel = {
      moduleName = "pages/petDuel/moduleAreaLevel"
    },
    contentBoard = true,
    timeActive = true,
    spaceAspectActive = false,
    active_btnBack2Match = false,
    active_btnTryAgain = true,
    active_reportPlayer = false
  }
end

function this.methods()
  return {
    onClick_quit = function(self)
      if CS.Lens.Gameplay.Modules.BigWorld.Macro.IsKiboDuelSimulator then
        C_KiboDuelSimulatorManager.instance:ExitBattle()
        C_KiboDuelSystemMgr:QuitKiBoDuel()
        return
      end
      L_MultiDungeonStore:req_CSProtoMultiCampaignQuit()
    end,
    onClick_tryAgain = function(self)
      if CS.Lens.Gameplay.Modules.BigWorld.Macro.IsKiboDuelSimulator then
        C_KiboDuelSimulatorManager.instance:ExitBattle()
        C_KiboDuelSystemMgr:QuitKiBoDuel()
        return
      end
      self:doTryAgain()
    end,
    onClick_statisticsBtn = function(self)
      L_UI:open("pagePetDuelStatistics")
    end,
    onClick_nestCoopStatisticsBtn = function(self)
      if self.options.MultiStatistics then
        self.options.MultiStatistics()
      end
    end,
    onClick_nestCoopExit = function(self)
      if self.options.MultiExit then
        self.options.MultiExit()
      end
    end,
    onClick_back2Match = function(self)
      if C_PetDuelArenaManager.GetCurIsRankMode() then
        if not C_PetDuelArenaManager.CheckIsInSeason() or C_PetDuelArenaManager.CheckIsNewSeacon() then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_74"))
          return
        end
        if C_PetDuelArenaManager.CheckAndTipIsInMatchTime() then
          L_UI:open("pagePetDuelMain", {
            mode = L_PetConst.PetDuelFormationType.pvpMatch,
            isRank = true,
            dontBack2RootWhenClose = true,
            dontShowHome = true
          })
        end
      else
        L_UI:open("pagePetDuelMain", {
          mode = L_PetConst.PetDuelFormationType.pvpMatch,
          isRank = false,
          dontBack2RootWhenClose = true,
          dontShowHome = true
        })
      end
    end,
    onClick_reportPlayer = function(self)
      CS.Lens.Gameplay.UI.ReportStore.GetStore():TryOpenKiboDuelReportBox()
    end
  }
end

function this:doTryAgain()
  local isBan = C_IntegrateMgr.SystemUnlockModule:getSystemIsBan(L_SystemConst.enum.petDuelNpcType)
  if isBan then
    local banReason = C_IntegrateMgr.SystemUnlockModule:getSystemBanReason(L_SystemConst.enum.petDuelNpcType)
    if not banReason or banReason == "" then
      local systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()
      local systemUnlock = systemUnlockTpl:getTplById(L_SystemConst.enum.petDuelNpcType)
      if systemUnlock then
        banReason = systemUnlockTpl:getGmCloseTips(systemUnlock)
      end
    end
    local data = {
      confirmCallback = function()
      end,
      txtContent = banReason,
      hideCancel = true
    }
    L_GameUtil.showCommonTip(data)
    return
  end
  if self.options ~= nil and L_EntrustStore:isEntrustKiboBattleLevel(self.options.duelId) then
    local curStamina = L_PlayerStore:getCurrencyNum(L_Const.currencyType.stamina)
    local kibo_tpl = kibiDuelGroupTpl:getTplById(self.options.duelId)
    local stamina = kibiDuelGroupTpl:getStamina(kibo_tpl)
    if curStamina < stamina then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_dungeon_lackenergy"))
      L_UI:open("pageStamina")
      return
    end
  end
  c_UIRestore.AddTagCount()
  if C_KiboArenaSystemMgr.isInArena then
    if not C_KiboDuelSystemMgr:CheckValidArenaFormationAndTip() then
      return
    end
    if self._reStratTimeLimit then
      L_FlyMsgManager:showNormalMsg(string.format(L_WordsTpl:getValue("ui_kiboDuel_93"), math.ceil(self._lastTime)))
      return
    end
    self._lastTime = self._reStratTimeLimitTime
    self._reStratTimeLimit = true
    C_KiboDuelSystemMgr:SendArenaRestart()
  else
    C_KiboDuelSystemMgr:RestartKiBoDuel()
    L_UI:close(self.pageName)
  end
end

function this:preOpen(options)
  if not options then
    return
  end
  self.options = options
  self._reStratTimeLimit = false
  self._reStratTimeLimitTime = L_GameConstTpl:getData("KIBO_DUEL_PVP_INVITE_CD", L_Const.GameTplType.int) or 3
  self._lastTime = 0
  Timer.repeated(0, function()
    if self._reStratTimeLimit then
      self._lastTime = self._lastTime - C_Time.deltaTime
      if self._lastTime <= 0 then
        self._reStratTimeLimit = false
      end
    end
  end, self, self.gameObject)
  self:initPage()
end

function this:open()
  if self.options.winStatus then
    self.bindComponents.finishAnimation:Play("anim_petbattle_finish_win")
    L_AudioUtil.playSound("Set_State_State_Battle_BattleLevel_Win")
  else
    self.bindComponents.finishAnimation:Play("anim_petbattle_finish_fail")
    L_AudioUtil.playSound("Play_SFX_System_Dungeon_Info_Loose")
    if C_KiboDuelSystemMgr:IsInNestCoop() then
      L_AudioUtil.playSound("Set_State_GamePlay_Nest_Battle_Lose")
    else
      L_AudioUtil.playSound("Set_State_State_Battle_BattleLevel_Lose")
    end
  end
  C_ExternalManager.DispatchEvent(C_EExternalEventType.PetFightEnd)
end

function this:initPage()
  if self.options.winStatus then
    L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_Win")
  end
  self._hasConditonContent = false
  self._hasRewardContent = false
  self._hasArealLevel = false
  self.bind.conditionIsOn = self.options.winStatus
  self.bind.timeActive = self.options.winStatus
  self.bind.playerName = L_PlayerStore:getPlayerName()
  local tpl_kiBoDuel = kiBoDuelTpl:getTplById(self.options.duelId)
  if tpl_kiBoDuel ~= nil then
    local npcSpawnerID = kiBoDuelTpl:getNpcSpawnerID(tpl_kiBoDuel)
    local tpl_worldSpawner = worldSpawnerTpl:getTplById(npcSpawnerID)
    self.bind.enemyName = worldSpawnerTpl:getName(tpl_worldSpawner)
  end
  self.bind.playerSlider = self.options.blueHpPercent
  self.bind.playerHealthy = string.format("%.0f", self.options.blueHpPercent * 100) .. "%"
  self.bind.enemySlider = self.options.redHpPercent
  self.bind.enemyHealthy = string.format("%.0f", self.options.redHpPercent * 100) .. "%"
  self.bind.txt_leftTime = tostring(self.options.duelTime)
  self:initFailedTips()
  self.bind.active_reportPlayer = CS.Lens.Gameplay.UI.ReportStore.GetStore():IsKiboDuelReportEnabled()
  if self.options.isMulti == nil or self.options.isMulti == false then
    self.bind.buttonsActive = true
    if self.bindComponents.nest_coop_buttons ~= nil then
      self.bindComponents.nest_coop_buttons.gameObject:SetActive(false)
    end
  else
    local showTime = L_GameConstTpl:getData("NESTCOOP_ENDING_TIME_LIMIT", L_Const.GameTplType.int) * 60
    if showTime == nil or showTime <= 0 then
      showTime = 900
    end
    Timer.once(showTime, function()
      self:outTimer()
    end, self, self.gameObject)
    self.bind.buttonsActive = false
    if self.bindComponents.nest_coop_buttons ~= nil then
      self.bindComponents.nest_coop_buttons.gameObject:SetActive(true)
    end
    if self.options.nestLoseType == 1 then
      self.bind.failedTips = L_WordsTpl:getValue("notice_kibo_duel_in_battle_07")
    else
      self.bind.failedTips = L_WordsTpl:getValue("notice_kibo_duel_in_battle_08")
    end
    return
  end
  self:initRewards()
  self.bind.contentBoard = self._hasConditonContent or self._hasRewardContent
  self:initAreaLevel(tpl_kiBoDuel)
  local curMode = C_PetDuelArenaManager.GetCurKiboArenaMode()
  if curMode == C_EKiboArenaMode.pvpMatch then
    self.bind.active_btnBack2Match = true
    self.bind.active_btnTryAgain = false
    self.modules.moduleAreaLevel:SetActive(false)
  elseif curMode == C_EKiboArenaMode.pvpInvite then
    self.bind.active_btnBack2Match = false
    self.bind.active_btnTryAgain = true
    self.modules.moduleAreaLevel:SetActive(false)
  elseif curMode == C_EKiboArenaMode.pve then
    local _kiboDuelTpl = L_GameTpl:getKiboDuelTpl()
    local tpl = _kiboDuelTpl:getTplById(self.options.duelId)
    local isTryAgain = _kiboDuelTpl:getIsRechallenge(tpl)
    self.bind.active_btnBack2Match = false
    self.bind.active_btnTryAgain = isTryAgain
  elseif not C_KiboDuelSystemMgr:IsTrialDuel(self.options.duelId) then
    self:initCondition(tpl_kiBoDuel)
  end
  if C_PetDuelArenaManager.GetCurIsRankMode() then
    self.bind.buttonsActive = false
    Timer.once(3, function()
      L_UI:addListener(L_UI.pageEvent.closed, self.onPageClosed, self)
      L_UI:open("pageKiboDuelPVPRankChange")
    end, self, self.gameObject)
  end
end

function this:initFailedTips()
  if self.options.winStatus then
    return
  end
  if self.options.blueHp <= 0 then
    self.bind.failedTips = L_WordsTpl:getValue("notice_kibo_duel_in_battle_07")
    return
  end
  if 0 >= self.options.duelTime then
    self.bind.failedTips = L_WordsTpl:getValue("notice_kibo_duel_in_battle_08")
    return
  end
  self.bind.failedTips = L_WordsTpl:getValue("notice_kibo_duel_in_battle_09")
end

function this:initCondition(tpl_kiBoDuel)
  local challengeList = kiBoDuelTpl:getChallenge(tpl_kiBoDuel)
  local challengeRewardShowList = kiBoDuelTpl:getChallengeRewardShow(tpl_kiBoDuel)
  if challengeList == nil or challengeRewardShowList == nil then
    self.bind.conditionContentActive = false
    errorf("奇波结算" .. "challengeList为空 id " .. kiBoDuelTpl:getId(tpl_kiBoDuel))
    return
  end
  if #challengeList == 0 then
    self.bind.conditionContentActive = false
    return
  end
  self._hasConditonContent = true
end

function this:playConditionAnimation(data)
  for i = 1, #data do
    local index = i
    Timer.once((index - 1) * 0.2, function()
      if not self.isBind then
        return
      end
      local item = self.bind.conditionList:getItemCls(index)
      if data[index].isSatisfied then
        item:playCellAnimation("anim_petbattle_finish_cellfinish")
        if not self.bind.conditionIsOn then
          L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_Result_LightUp")
        end
      else
        item:playCellAnimation("anim_petbattle_finish_cellunfinish")
      end
    end)
  end
end

function this:initRewards()
  if not self.options then
    return
  end
  if not self.isBind then
    return
  end
  local state = L_EntrustStore:isActivityEntrustLevel(self.options.duelId)
  if state then
    self.bind.rewardActive = false
    return
  end
  self.bind.rewardActive = true
  self.bind.petsExpActive = true
  local rewards = {}
  local delay = 1
  if self.options.isFirstWin or L_EntrustStore:isEntrustKiboBattleLevel(self.options.duelId) then
    local tpl = kiBoDuelTpl:getTplById(self.options.duelId)
    rewards = kiBoDuelTpl:getFirstLoot(tpl)
    for k, v in ipairs(rewards) do
      if v.itemType == L_Const.resType.currency and v.itemId == L_Const.currencyType.petExp then
        table.remove(rewards, k)
        break
      end
    end
    local pets = self:getShowPetExpInfo()
    self.bind.buttonsActive = #pets == 0
    if 0 < #rewards then
      delay = 1
    end
  end
  Timer.once(delay, function()
    self:initPetExp()
  end, self, self.gameObject)
  if 0 < #rewards then
    self._hasRewardContent = true
    self.bind.rewardActive = true
  else
    local pets = self:getShowPetExpInfo()
    self._hasRewardContent = 0 < #pets
    self.bind.rewardActive = false
  end
  self.bind.rewardList:clear()
  self.bind.rewardList:insert_array(rewards)
end

function this:getShowPetExpInfo()
  local pets = L_PetDuelStore:getPetExpInfo()
  if #pets == 0 then
    pets = L_PetDuelStore:getDefaultPetExpInfos()
  end
  return pets
end

function this:outTimer()
  L_GameUtil.showCommonTip({
    txtContent = L_WordsTpl:getValue("nestcoop_ending_time_limit_text"),
    pageClosedCallback = function()
      if self.options.MultiExit then
        self.options.MultiExit()
      end
    end
  })
end

function this:onPageClosed(pageName)
  if pageName == "pageKiboDuelPVPRankChange" then
    self.bind.buttonsActive = true
  end
end

function this:initPetExp()
  if not self.options then
    return
  end
  local state = L_EntrustStore:isActivityEntrustLevel(self.options.duelId)
  if state then
    self.bind.petsExpActive = false
    return
  end
  local pets = self:getShowPetExpInfo()
  self.bind.petsExpActive = 0 < #pets
  self.bind.petList:clear()
  self.bind.petList:insert_array(pets)
  if not C_PetDuelArenaManager.GetCurIsRankMode() then
    self.bind.buttonsActive = true
  end
  local mvpPetGuid, petConfigId = self:calcMVPPet()
  for i = 1, #self.bind.petList do
    self.bind.petList:change(i, {mvpGuid = mvpPetGuid, mvpPetConfigId = petConfigId})
  end
end

function this:calcMVPPet()
  local statisticsData = C_KiboDuelSystemMgr:GetPetStatistics(C_ERecordValueType.None, 9999999)
  local playerMaxDamge, playerMaxDamgeTaken, playerMaxHealing = self:getMaxValues(statisticsData.playerData)
  local playerPetScores = {}
  for i = 0, statisticsData.playerData.Count - 1 do
    local data = statisticsData.playerData[i]
    local damageRate = playerMaxDamge ~= 0 and data.damgeValue / playerMaxDamge or 0
    local damageTakenRate = playerMaxDamgeTaken ~= 0 and data.damgeTakenValue / playerMaxDamgeTaken or 0
    local healingRate = playerMaxHealing ~= 0 and data.healingValue / playerMaxHealing or 0
    local indexSet = L_GameTpl:getGameConstTpl():getData("KIBO_DUEL_MVP", L_Const.GameTplType.list_float)
    local score = damageRate * indexSet[1] + damageTakenRate * indexSet[2] + healingRate * indexSet[3] + data.killedPetCount * indexSet[4] + data.desDefTowerCount * indexSet[5] + data.desBaseTowerCount * indexSet[6]
    table.insert(playerPetScores, {
      petScore = score,
      petGuid = data.guid,
      petConfig = data.petConfigId
    })
  end
  table.sort(playerPetScores, function(a, b)
    return a.petScore > b.petScore
  end)
  if #playerPetScores == 0 then
    return
  end
  local mvpPetTpl = petTpl:getTplById(playerPetScores[1].petConfig)
  local mvpPetName = petTpl:getName(mvpPetTpl, false)
  for index, data in ipairs(playerPetScores) do
    local tmp_petTpl = petTpl:getTplById(data.petConfig)
    local petName = petTpl:getName(tmp_petTpl, false)
    printf("MvpLog: petGuid: " .. tostring(data.petGuid) .. "petConfigId: " .. tostring(data.petConfig) .. " petName: " .. petName .. " petScore: " .. tostring(data.petScore))
  end
  printf("MVPPet Guid: " .. playerPetScores[1].petGuid)
  printf("mvp Pet Name: " .. tostring(mvpPetName))
  printf("mvp Score: " .. tostring(playerPetScores[1].petScore))
  return playerPetScores[1].petGuid, playerPetScores[1].petConfig
end

function this:getMaxValues(data)
  local maxDamge = 0
  local maxDamgeTaken = 0
  local maxHealing = 0
  for i = 0, data.Count - 1 do
    local v = data[i]
    if v.entityType == C_EEntityType.KiBo then
      maxDamge = maxDamge + v.damgeValue
      maxDamgeTaken = maxDamgeTaken + v.damgeTakenValue
      maxHealing = maxHealing + v.healingValue
    end
  end
  return maxDamge, maxDamgeTaken, maxHealing
end

function this:escHandle()
end

function this:close()
  if C_PetDuelArenaManager.GetCurIsRankMode() then
    L_UI:removeListener(L_UI.pageEvent.closed, self.onPageClosed, self)
  end
  L_PetDuelStore:resetPetExpInfo()
  L_PetDuelStore:resetAreaLevelRecordData()
  if C_KiboDuelSystemMgr:IsInNestCoop() then
    L_AudioUtil.stopBgm()
  end
end

function this:initAreaLevel(kiBoDuel)
  if self.options.winStatus then
    local areaType = kiBoDuelTpl:getAreaType(kiBoDuel)
    local areaTypeTpl = L_GameTpl:getKiboDuelAreaTypeTpl()
    if not areaTypeTpl:getTplById(areaType) then
      self.modules.moduleAreaLevel:SetActive(false)
      return
    end
    self._hasArealLevel = true
    self.modules.moduleAreaLevel:initModule({areaType = areaType})
    L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_Result_Badge")
  else
    self.modules.moduleAreaLevel:SetActive(false)
  end
  self.bind.spaceAspectActive = not self._hasArealLevel
end

return this
