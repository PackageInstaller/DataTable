local cls = class("moduleEntrustMultiCoopDetails", G_UIModuleBase)
local _dungeonTpl = L_GameTpl:getDungeonTpl()
local _multiDungeonTpl = L_GameTpl:getMultiDungeonTpl()
local _dungeonCrisisCrusadeTpl = L_GameTpl:getDungeonCrisisCrusadeTpl()
local _dungeonCrisisCrusadeDiffTagTpl = L_GameTpl:getDungeonCrisisCrusadeDiffTagTpl()
local _currencyTpl = L_GameTpl:getCurrencyTpl()
local _gameConstTpl = L_GameTpl:getGameConstTpl()
local _enemyTpl = L_GameTpl:getEnemyTpl()
local _errorCodeTpl = L_GameTpl:getErrorCodeTpl()
local scoreRankIconEnum = {
  [6] = "UI/Atlas/MultiCoopTask/tex_crisiscrusade_icon_zsss.png",
  [5] = "UI/Atlas/MultiCoopTask/tex_crisiscrusade_icon_zss.png",
  [4] = "UI/Atlas/MultiCoopTask/tex_crisiscrusade_icon_zs.png",
  [3] = "UI/Atlas/MultiCoopTask/tex_crisiscrusade_icon_za.png",
  [2] = "UI/Atlas/MultiCoopTask/tex_crisiscrusade_icon_zb.png",
  [1] = "UI/Atlas/MultiCoopTask/tex_crisiscrusade_icon_zc.png"
}
local MaxTeamMemberCount = 3

function cls.bind()
  return {
    active_imgIndicator = false,
    go_finished = false,
    img_finishedStar = "",
    txt_finishedScore_SSS = "",
    txt_finishedScore_SS = "",
    txt_finishedScore_S = "",
    txt_finishedScore_A_B = "",
    txt_finishedScore_C = "",
    txt_entrustName = "",
    txt_recommendLevel = "",
    active_btnEnemyInfo = false,
    active_listCondition = false,
    list_entrustTaskCondition = {
      moduleName = "pages/entrustTask/cellEntrustTaskCondition"
    },
    active_scrollDesc = false,
    txt_scrollDesc = "",
    active_Desc = false,
    txt_Desc = "",
    pos_Desc = C_Vector3.zero,
    active_npcNameNode = false,
    txt_npcName = "",
    active_consumeTipsNode = false,
    img_currencyIcon = "",
    img_enemy = "",
    txt_currencyConsume = "",
    table_taskReward = {
      moduleName = "pages/entrustTask/cellEntrustTaskReward"
    },
    moduleRewardUp = {
      moduleName = "pages/gameAct/doubleDrop/moduleRewardUp"
    },
    active_btn_enterEntrustSingleMode = false,
    active_btn_createTaskRoom = false,
    active_btn_randomMatch = false,
    active_btn_startMatchMember = false,
    active_btn_cancelMatchMember = false,
    active_btn_postPreparation = false,
    active_btn_postPreparationWait = false,
    active_btn_prepare = false,
    active_btn_cancelPrepare = false,
    active_btn_enterEntrustMultiMode = false,
    active_btn_cancelMatchMemberSingle = false,
    active_btn_switchMultiCoopEntrust = false,
    txt_switchMode = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_10"),
    active_switchModeLock = false,
    active_taskIsNotCurTask = false,
    active_matchTipsIcon = true,
    txt_matchTips = "",
    active_matchTips = false,
    txt_postPreparationWait = "",
    localPosition_postPreparation = nil,
    localPosition_postPreparationWait = nil,
    localPosition_enterEntrustMultiMode = nil,
    active_imgMatchTipsTimer = false,
    active_imgMatchTipsSword = false,
    active_surpriseTime = false,
    txt_surpriseTime = ""
  }
end

function cls:open()
  self.isMultiPlayerMode = true
  self.isReqEnterDungeon = false
  self._onEvent_PlayerInOutEventHandle = self._onEvent_PlayerInOutEventHandle or handler(self, self.onPlayerInOut)
  C_MultiEvent.instance:Listen(C_EMultiEvent.MultiTeamInOutTeam, self._onEvent_PlayerInOutEventHandle)
  self._onEvent_PlayerisReadyEventHandle = self._onEvent_PlayerisReadyEventHandle or handler(self, self.onPlayerisReady)
  C_MultiEvent.instance:Listen(C_EMultiEvent.MultiTeamIsReady, self._onEvent_PlayerisReadyEventHandle)
  self._onEvent_ChangeTargetEventHandle = self._onEvent_ChangeTargetEventHandle or handler(self, self.onChangeTarget)
  C_MultiEvent.instance:Listen(C_EMultiEvent.MultiTeamChangeTarget, self._onEvent_ChangeTargetEventHandle)
  self._onEvent_MemberUpdataEventHandle = self._onEvent_MemberUpdataEventHandle or handler(self, self.onMemberUpdate)
  C_MultiEvent.instance:Listen(C_EMultiEvent.MultiTeamMemberUpdate, self._onEvent_MemberUpdataEventHandle)
  self._onEvent_ChangeLeaderChangeHandle = self._onEvent_ChangeLeaderChangeHandle or handler(self, self.onLeaderChange)
  C_MultiEvent.instance:Listen(C_EMultiEvent.MultiTeamLeaderChange, self._onEvent_ChangeLeaderChangeHandle)
  self._onEvent_IsMachingHandle = self._onEvent_IsMachingHandle or handler(self, self.onIsMatching)
  C_MultiEvent.instance:Listen(C_EMultiEvent.MultiTeamIsMatching, self._onEvent_IsMachingHandle)
  self._onEvent_PostPrepareWaitHandle = self._onEvent_PostPrepareWaitHandle or handler(self, self.onPostPrepareWaitTimer)
  C_MultiTeam.AddEventTimer("StartReady", self._onEvent_PostPrepareWaitHandle)
  self._onMultiTeamMatchStateUpdate = self._onMultiTeamMatchStateUpdate or handler(self, self.onMultiTeamMatchStateUpdate)
  C_MultiEvent.instance:Listen(C_EMultiEvent.MultiTeamMatchStateUpdate, self._onMultiTeamMatchStateUpdate)
  L_UI:addListener(L_UI.pageEvent.hided, self.onPageHide, self)
  L_TimerManager:newOrResetTimer(self, "matchLoopTimer", function()
    if C_MultiTeam.GetIsMatching() then
      self:onMatchTimer()
    end
  end, 0.1, -1)
end

function cls.methods()
  return {
    onClick_openEnemyInfo = function(self)
      local dungeonEntrustCfg = _dungeonCrisisCrusadeTpl:getTplById(self.levelId)
      L_UI:open("pageEntrustEnemyDetail", {
        dungeonId = _dungeonCrisisCrusadeTpl:getDungeonId(dungeonEntrustCfg),
        entrustType = L_Const.EntrustTypeEnum.MultiCoopEntrust
      })
    end,
    onClick_enterEntrustSingleMode = function(self)
      if self.isInOtherTeam then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_84"))
        return
      end
      self:StartEnterDungeonAndStopOher()
    end,
    onClick_createTaskRoom = function(self)
      self:CreateRoom()
    end,
    onClick_randomMatch = function(self)
      if self.isInOtherTeam then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_84"))
        return
      end
      self.matchTime = 0
      self:StartMatchMemberAndStopOher()
    end,
    onClick_startMatchMember = function(self)
      self.matchTime = 0
      L_AudioUtil.playSound("Play_SFX_System_UI_PamiAdventure_Match")
      self:StartMatchMemberAndStopOher()
    end,
    onClick_cancelMatchMember = function(self)
      L_AudioUtil.playSound("Stop_SFX_System_UI_PamiAdventure_Match")
      self:StartMatchMember(false)
    end,
    onClick_cancelMatchMemberSingle = function(self)
      self:StartMatchMember(false)
    end,
    onClick_postPreparation = function(self)
      self.postPreparationWaitTime = 30
      self:openTickTimer()
      C_MultiTeam.PostReadyRequest()
      self:refreshState()
    end,
    onClick_postPreparationWait = function(self)
    end,
    onClick_prepare = function(self)
      self:onbtnReady(true)
    end,
    onClick_cancelPrepare = function(self)
      self:onbtnReady(false)
    end,
    onClick_enterEntrustMultiMode = function(self)
      self:enterDungeon()
    end,
    onClick_switchMode = function(self)
      self:SwitchMode()
    end,
    onClick_switchMultiCoopEntrust = function(self)
      self:SwitchEntrust()
    end
  }
end

function cls:setShow(bShow)
  L_CommonUtil.setObjActive(self.gameObject, bShow)
end

function cls:StartEnterDungeonAndStopOher()
  local isMatching = C_MultiTeam.GetIsMatching()
  if isMatching then
    self.m_requestMatchCancelingState = 2
    self:StartMatchMember(false)
  else
    self:enterDungeon()
  end
end

function cls:initMultiCoopEntrustDetails(levelId, bChangeTab, bChangeLevel, callback)
  self.callback = callback
  
  local function func()
    self.entrustType = L_Const.EntrustTypeEnum.MultiCoopEntrust
    self.levelId = levelId
    local dungeonEntrustCfg = _dungeonCrisisCrusadeTpl:getTplById(self.levelId)
    self.bind.txt_recommendLevel = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_04") .. tostring(_dungeonCrisisCrusadeTpl:getRecommendLevel(dungeonEntrustCfg))
    self.bind.txt_entrustName = _dungeonCrisisCrusadeTpl:getName(dungeonEntrustCfg)
    self.bind.active_btnEnemyInfo = true
    self.bind.active_scrollDesc = true
    self.bind.txt_scrollDesc = _dungeonCrisisCrusadeTpl:getIntroduce(dungeonEntrustCfg)
    self.bind.active_Desc = false
    self.bind.active_npcNameNode = true
    self.bind.txt_npcName = _dungeonCrisisCrusadeTpl:getEntrustNpcName(dungeonEntrustCfg)
    local levelScore = L_MultiDungeonStore:getMultiDungeonPassScore(self.levelId)
    levelScore = levelScore or 0
    local levelRank = self:calRank(levelScore)
    self.bind.go_finished = 0 < levelScore
    self.bind.active_imgIndicator = 0 < levelScore
    if 0 <= levelRank then
      self.bind.img_finishedStar = scoreRankIconEnum[levelRank]
      self:setScoreTxt(levelRank, levelScore)
    end
    self.bind.active_consumeTipsNode = true
    self.consumeCurrencyNum = _dungeonCrisisCrusadeTpl:getConsumeNum(dungeonEntrustCfg)
    local currencyTpl = _currencyTpl:getTplById(_dungeonCrisisCrusadeTpl:getConsumeType(dungeonEntrustCfg))
    local currencyIconPath = _currencyTpl:getIconSmall(currencyTpl)
    self.bind.img_currencyIcon = currencyIconPath
    self.bind.txt_currencyConsume = tostring(self.consumeCurrencyNum) .. "】"
    self.bind.active_listCondition = true
    local dungeonId = _dungeonCrisisCrusadeTpl:getDungeonId(dungeonEntrustCfg)
    local enemyData = self:getDungeonEnemyBoss(dungeonId)
    if enemyData then
      local enemyCfg = _enemyTpl:getTplById(enemyData)
      if enemyCfg then
        self.bind.img_enemy = _enemyTpl:getAvatarTexture(enemyCfg)
      end
    end
    local isSpecial = _dungeonCrisisCrusadeTpl:getEntrustType(dungeonEntrustCfg)
    if isSpecial == 2 then
      self.bind.active_surpriseTime = true
      self:initSurpriseTimer()
    else
      self.bind.active_surpriseTime = false
      self:closeSurpriseTimer()
    end
    self:refreshMultiCoopEntrustTaskCondition(dungeonEntrustCfg)
    self:refreshMultiCoopEntrustTaskReward(dungeonEntrustCfg)
    self:getTeamState()
  end
  
  if bChangeTab then
    self.bindComponents.rootAnim:Stop()
    self.bindComponents.boardAnim:Rewind()
    self.bindComponents.boardAnim:Play("anim_dungeon_formula_change")
    Timer.once(0.13, function()
      func()
    end, self, self.gameObject)
  elseif bChangeLevel then
    self.bindComponents.rootAnim:Stop()
    self.bindComponents.boardAnim:Rewind()
    self.bindComponents.boardAnim:Play("anim_dungeon_formula_change1")
    Timer.once(0.066, function()
      func()
    end, self, self.gameObject)
    C_AudioManager.Play("Play_SFX_System_UI_EnTrust_Tab_Switch")
  else
    func()
  end
end

function cls:getDungeonEnemyBoss(dungeonId)
  local cfg = _dungeonTpl:getTplById(dungeonId)
  local enemyList = _dungeonTpl:getEnemy(cfg)
  local infos = {}
  for i, v in ipairs(enemyList) do
    local id, level = table.unpack(v)
    table.insert(infos, id)
  end
  table.sort(infos, function(a, b)
    local tplA = _enemyTpl:getTplById(a)
    local tplB = _enemyTpl:getTplById(b)
    if tplA and tplB then
      return tplA.enemyType < tplB.enemyType
    else
      return false
    end
  end)
  return infos[1]
end

function cls:calRank(score)
  local dungeonEntrustCfg = _dungeonCrisisCrusadeTpl:getTplById(self.levelId)
  local totalScore = _dungeonCrisisCrusadeTpl:getContributionValue(dungeonEntrustCfg)
  local perScore = score / totalScore
  local scoreMap = _gameConstTpl:getMultiDungeonGrade()
  local rank = 6
  for index = 1, #scoreMap do
    if perScore * 100 >= scoreMap[index][2] then
      return rank
    end
    rank = rank - 1
  end
  return rank
end

function cls:setScoreTxt(rank, score)
  self.bind.txt_finishedScore_SSS = ""
  self.bind.txt_finishedScore_SS = ""
  self.bind.txt_finishedScore_S = ""
  self.bind.txt_finishedScore_A_B = ""
  self.bind.txt_finishedScore_C = ""
  local str = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_05")
  if rank == 6 then
    self.bind.txt_finishedScore_SSS = str .. tostring(score)
  elseif rank == 5 then
    self.bind.txt_finishedScore_SS = str .. tostring(score)
  elseif rank == 4 then
    self.bind.txt_finishedScore_S = str .. tostring(score)
  elseif rank == 1 then
    self.bind.txt_finishedScore_C = str .. tostring(score)
  else
    self.bind.txt_finishedScore_A_B = str .. tostring(score)
  end
end

function cls:getTeamState()
  self.isInRoom = C_MultiTeam.IsInMultiTeam()
  self.isMatching = C_MultiTeam.GetIsMatching()
  if self.isInRoom then
    if C_MultiTeam.isMultiBattleTeam() then
      local dungeonId = C_MultiTeam.GetDungeonId()
      local levelId = _dungeonCrisisCrusadeTpl:getLevelIdByDungeonId(dungeonId)
      if self.curRoomLevel ~= levelId then
        self.curRoomLevel = _dungeonCrisisCrusadeTpl:getLevelIdByDungeonId(dungeonId)
        self.callback(self.curRoomLevel)
      end
      local playerInfo = L_PlayerStore:getPlayerBaseInfo()
      local teamData = C_MultiTeam.GetAllPlayersData(playerInfo.id)
      if teamData ~= nil then
        self.isRoomOwner = teamData.IsLeader
        if self.isMatching then
          self.curMatchingLevel = self.curRoomLevel
        end
        self.isReady = teamData.IsReady
      end
      if not C_MultiTeam.IsExitTimer("StartReady") then
        self.postPreparationWaitTime = 0
      end
      self.teamMemberCount = C_MultiTeam.GetTeamMemberCount()
      self.teamMemberReadyCount = C_MultiTeam.GetTeamMemberReadyCount()
      if self.teamMemberCount == MaxTeamMemberCount then
        self.isMatching = false
      end
    else
      self.isInOtherTeam = true
      self.isInRoom = false
      self.isMatching = false
    end
  else
    self.isInOtherTeam = false
    if self.curRoomLevel ~= 0 then
      self.curRoomLevel = 0
      self.callback(self.curRoomLevel)
    end
    local dungeonId = C_MultiTeam.GetMatchingId()
    local levelId = _dungeonCrisisCrusadeTpl:getLevelIdByDungeonId(dungeonId)
    if self.isMatching then
      self.curMatchingLevel = levelId
    end
  end
  self:refreshState()
end

function cls:showMatchTips()
  if not self.isMatchShow then
    self.isMatchShow = true
    L_TimerManager:stopTimer(self, "tips_out")
    self.bindComponents.anim_matchTips:Stop()
    self.bindComponents.anim_matchTips:Rewind()
    self.bindComponents.anim_matchTips:Play("anim_entrust_multicoop_leveldetial_tips_in")
    self.bind.active_matchTips = true
  end
end

function cls:hiteMatchTips()
  if self.isMatchShow then
    self.isMatchShow = false
    self.bindComponents.anim_matchTips:Stop()
    self.bindComponents.anim_matchTips:Rewind()
    self.bindComponents.anim_matchTips:Play("anim_entrust_multicoop_leveldetial_tips_out")
    L_TimerManager:newOrResetTimer(self, "tips_out", function()
      self.bind.active_matchTips = false
    end, 0.35)
  end
end

function cls:refreshState()
  self:onSwitch()
  self.bind.active_switchModeLock = self.isInRoom
  self.bindComponents.anim_btn_switchMode.enabled = not self.isInRoom
  if self.isInRoom then
    if self.isRoomOwner then
      if self.curRoomLevel == self.levelId then
        if self.isMatching then
          self.bind.active_btn_cancelMatchMember = true
        elseif self.teamMemberCount < MaxTeamMemberCount then
          self.bind.active_btn_startMatchMember = true
        end
        self:showMatchTips()
        if self.isMatching then
          self.bind.active_imgMatchTipsTimer = true
          local tips = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_06") .. "(0s)"
          if self.matchTime then
            tips = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_06") .. "(" .. tostring(self.matchTime) .. "s)"
            self.bind.txt_matchTips = tips
            CS.Lens.Gameplay.UI.PageMultiTeamState.UpdateMatchTips(tips)
          else
            self.bind.txt_matchTips = tips
            CS.Lens.Gameplay.UI.PageMultiTeamState.UpdateMatchTips(tips)
          end
        elseif self.teamMemberCount and self.teamMemberCount > 1 then
          self.bind.active_imgMatchTipsSword = true
          if self.teamMemberReadyCount == self.teamMemberCount then
            self.bind.txt_matchTips = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_17")
          else
            self.bind.txt_matchTips = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_18")
          end
        else
          self.bind.active_imgMatchTipsTimer = true
          self.bind.txt_matchTips = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_07")
        end
        if self.teamMemberCount and self.teamMemberCount > 1 then
          if self.teamMemberReadyCount == self.teamMemberCount then
            if self.teamMemberCount < MaxTeamMemberCount then
              self.bind.active_btn_enterEntrustSingleMode = true
              self.bind.localPosition_enterEntrustMultiMode = L_Vector3.new(115, -365, 0)
            else
              self.bind.active_btn_enterEntrustMultiMode = true
            end
          else
            if self.postPreparationWaitTime and 0 < self.postPreparationWaitTime then
              self.bind.active_btn_postPreparationWait = true
            else
              self.bind.active_btn_postPreparation = true
            end
            if self.teamMemberCount < MaxTeamMemberCount then
              self.bind.localPosition_postPreparation = L_Vector3.new(115, -365, 0)
              self.bind.localPosition_postPreparationWait = L_Vector3.new(115, -365, 0)
            else
              self.bind.localPosition_postPreparation = L_Vector3.new(-43, -365, 0)
              self.bind.localPosition_postPreparationWait = L_Vector3.new(-43, -365, 0)
            end
          end
        else
          self.bind.active_btn_enterEntrustSingleMode = true
          self.bind.localPosition_enterEntrustMultiMode = L_Vector3.new(115, -365, 0)
        end
      else
        self.bind.active_matchTips = false
        self.isMatchShow = false
        self.bind.active_btn_switchMultiCoopEntrust = true
      end
    elseif self.curRoomLevel == self.levelId then
      self:showMatchTips()
      self.bind.active_imgMatchTipsSword = true
      self.bind.txt_matchTips = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_08")
      if self.isReady then
        self.bind.active_btn_cancelPrepare = true
      else
        self.bind.active_btn_prepare = true
      end
    else
      self.bind.active_matchTips = false
      self.isMatchShow = false
      self.bind.active_taskIsNotCurTask = true
    end
  elseif self.isMatching then
    if self.curMatchingLevel == self.levelId then
      self:showMatchTips()
      self.bind.active_imgMatchTipsTimer = true
      if self.matchTime then
        self.bind.txt_matchTips = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_06") .. "(" .. tostring(self.matchTime) .. "s)"
      else
        self.bind.txt_matchTips = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_06") .. "(0s)"
      end
      self.bind.active_btn_createTaskRoom = true
      self.bind.active_btn_cancelMatchMemberSingle = true
    else
      self.bind.active_matchTips = false
      self.isMatchShow = false
      self.bind.active_btn_createTaskRoom = true
      self.bind.active_btn_randomMatch = true
    end
  else
    self.bind.active_imgMatchTipsTimer = true
    self.bind.txt_matchTips = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_06") .. "(" .. tostring(self.lastMatchTime == nil and 0 or self.lastMatchTime) .. "s)"
    self:hiteMatchTips()
    if self.isMultiPlayerMode then
      self.bind.active_btn_createTaskRoom = true
      self.bind.active_btn_randomMatch = true
      self.bind.txt_switchMode = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_09")
    else
      self.bind.active_btn_enterEntrustSingleMode = true
      self.bind.localPosition_enterEntrustMultiMode = L_Vector3.new(-43, -365, 0)
      self.bind.txt_switchMode = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_10")
    end
  end
end

function cls:onSwitch()
  self.bind.active_btn_enterEntrustSingleMode = false
  self.bind.active_btn_createTaskRoom = false
  self.bind.active_btn_randomMatch = false
  self.bind.active_btn_startMatchMember = false
  self.bind.active_btn_cancelMatchMember = false
  self.bind.active_btn_postPreparation = false
  self.bind.active_btn_postPreparationWait = false
  self.bind.active_btn_prepare = false
  self.bind.active_btn_cancelPrepare = false
  self.bind.active_btn_enterEntrustMultiMode = false
  self.bind.active_btn_cancelMatchMemberSingle = false
  self.bind.active_btn_switchMultiCoopEntrust = false
  self.bind.active_taskIsNotCurTask = false
  self.bind.txt_matchTips = ""
  self.bind.active_imgMatchTipsTimer = false
  self.bind.active_imgMatchTipsSword = false
end

function cls:refreshMultiCoopEntrustTaskReward(dungeonEntrustCfg)
  local rewardItems = {}
  local star = L_MultiDungeonStore:getMultiDungeonPassRank(self.levelId)
  star = star or 0
  local reward = _dungeonCrisisCrusadeTpl:getRewardShow(dungeonEntrustCfg)
  for i = 1, #reward do
    local item = L_ItemTplManager:getItemConfig(reward[i].itemType, reward[i].itemId)
    if item then
      local rarity = L_ItemTplManager:getItemQuality(reward[i].itemType, reward[i].itemId)
      table.insert(rewardItems, {
        itemType = item.itemType,
        itemId = item.itemId,
        itemNumTxt = reward[i].itemNumTxt,
        starNum = 0,
        rarity = rarity
      })
    end
  end
  self.bind.table_taskReward:clear()
  self.bind.table_taskReward:insert_array(rewardItems)
  self.modules.moduleRewardUp:setEntrustType(0)
end

function cls:refreshMultiCoopEntrustTaskCondition(dungeonEntrustCfg)
  local starNum = L_MultiDungeonStore:getMultiDungeonPassRank(self.levelId)
  starNum = starNum or 0
  local taskTable = self:calTaskComplete(starNum, 3)
  local dungeonId = _dungeonCrisisCrusadeTpl:getDungeonId(dungeonEntrustCfg)
  local dungeonCfg = _dungeonTpl:getTplById(dungeonId)
  local dungeonTaskDecs = _dungeonTpl:getChallengeDes(dungeonCfg)
  local info = {}
  for i, v in ipairs(dungeonTaskDecs) do
    local reward, rewardItem
    if i == 1 then
      reward = _dungeonCrisisCrusadeTpl:getOneStarRewardShow(dungeonEntrustCfg)
    elseif i == 2 then
      reward = _dungeonCrisisCrusadeTpl:getTwoStarRewardShow(dungeonEntrustCfg)
    elseif i == 3 then
      reward = _dungeonCrisisCrusadeTpl:getThreeStarRewardShow(dungeonEntrustCfg)
    end
    if reward and reward[1] then
      rewardItem = L_ItemTplManager:getItemConfig(reward[1].itemType, reward[1].itemId)
    end
    table.insert(info, {
      txt_condition = v,
      bFinish = taskTable[i] == 1,
      go_reward = rewardItem and true or false,
      img_reward = rewardItem and rewardItem.icon or "",
      txt_itemNum = reward[1] and "X" .. reward[1].itemNum or ""
    })
  end
  self.bind.list_entrustTaskCondition:clear()
  self.bind.list_entrustTaskCondition:insert_array(info)
end

function cls:calTaskComplete(star, bits)
  local _bits = bits or 3
  local _star = star
  if _star < 0 or _star > 2 ^ _bits - 1 then
    return
  end
  local tbl = {}
  for i = 1, _bits do
    tbl[i] = _star % 2
    _star = math.floor(_star / 2)
  end
  return tbl
end

function cls:calTaskStar(star)
  local _table = self:calTaskComplete(star, 3)
  local result = 0
  for i, v in ipairs(_table) do
    if v == 1 then
      result = result + 1
    end
  end
  return result
end

function cls:CreateRoom()
  if self.isInOtherTeam then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_kiboDuel_84"))
    return
  end
  local tpl = _dungeonCrisisCrusadeTpl:getTplById(self.levelId)
  C_MultiTeam.ReqCreateTeam(tpl.dungeonId)
end

function cls:StartMatchMemberAndStopOher()
  local condId = AzurWorld.ConditionMgr:SafeQuickCheck({70002})
  if not condId then
    local errorCode = 21310
    local tpl = _errorCodeTpl:getTplById(errorCode)
    L_FlyMsgManager:showNormalMsg(_errorCodeTpl:getName(tpl, nil, errorCode))
    return
  end
  local isMatching = C_MultiTeam.GetIsMatching()
  if isMatching then
    self.m_requestMatchCancelingState = 1
    self:StartMatchMember(false)
  else
    self:StartMatchMember(true)
  end
end

function cls:StartMatchMember(isStart)
  self.isMatching = isStart
  self.curMatchingLevel = isStart and self.levelId or nil
  self:refreshState()
  local tpl = _dungeonCrisisCrusadeTpl:getTplById(self.levelId)
  C_MultiTeam.MatchTeam(isStart, tpl.dungeonId)
end

function cls:onbtnReady(isReady)
  if isReady then
    local condId = AzurWorld.ConditionMgr:SafeQuickCheck({70002})
    if not condId then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageMultiDungeonMatching_11"))
      return
    end
    local condId = AzurWorld.ConditionMgr:CreateCond({70003}, nil)
    if not AzurWorld.ConditionMgr:CheckCond(condId) then
      local cond = AzurWorld.ConditionMgr:GetCond(condId)
      if cond then
        local str = cond:ShowMsg()
        L_FlyMsgManager:showNormalMsg(str)
      end
      return
    end
  end
  self.isReady = isReady
  self:refreshState()
  local playerInfo = L_PlayerStore:getPlayerBaseInfo()
  C_MultiTeam.ChangeReady(playerInfo.id, isReady)
end

function cls:enterDungeon()
  if self.isReqEnterDungeon then
    C_MJLog.LogInfo("------enterDungeon isReqEnterDungeoning")
    return
  end
  self.isReqEnterDungeon = true
  local tpl = _dungeonCrisisCrusadeTpl:getTplById(self.levelId)
  C_MultiTeam.EnterDungeon(tpl.dungeonId)
end

function cls:SwitchMode()
  if self.isInRoom then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageMultiDungeonMatching_12"))
  else
    self.bindComponents.rootAnim:Stop()
    self.bindComponents.boardAnim:Rewind()
    self.bindComponents.boardAnim:Play("anim_dungeon_formula_change_switchmode")
    self.isMatching = false
    self.isMultiPlayerMode = not self.isMultiPlayerMode
    self:refreshState()
  end
end

function cls:SwitchEntrust()
  if self.teamMemberCount and self.teamMemberCount > 1 then
    self:switchEntrustTimer()
  else
    self.curRoomLevel = self.levelId
    self.callback(self.levelId)
    self:refreshState()
    local tpl = _dungeonCrisisCrusadeTpl:getTplById(self.levelId)
    C_MultiTeam.ReqChangeCurDungeon(tpl.dungeonId, false)
  end
end

function cls:switchEntrustTimer()
  if self.canRequestChangeEntrust == nil then
    self.canRequestChangeEntrust = true
  end
  if self.canRequestChangeEntrust then
    self:checkTeanMemberLevel()
  else
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageMultiDungeonMatching_13"))
  end
end

function cls:checkTeanMemberLevel()
  local playerInfo = L_PlayerStore:getPlayerBaseInfo()
  local memberList = C_MultiTeam.GetAllTeamMemberPlayerId()
  local players = {}
  for i = 0, memberList.Count - 1 do
    table.insert(players, memberList[i])
  end
  local types = {
    L_Const.PlayerBasicQueryType.PBQT_LEVEL
  }
  L_FriendManager:requestBaseInfo(types, players, function()
    for i = 0, memberList.Count - 1 do
      local id = memberList[i]
      if id ~= playerInfo.id then
        local baseInfo = L_FriendStore:getPlayerBaseInfo(id)
        local recLevel = _dungeonCrisisCrusadeTpl:getRecommendLevel(_dungeonCrisisCrusadeTpl:getTplById(self.levelId))
        recLevel = self:getUnlockLv()
        if recLevel > baseInfo.lv then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageMultiDungeonMatching_14"))
          return
        end
      end
    end
    self.canRequestChangeEntrust = false
    local tpl = _dungeonCrisisCrusadeTpl:getTplById(self.levelId)
    C_MultiTeam.ReqChangeCurDungeon(tpl.dungeonId, true)
    Timer.once(15.0, function()
      self.canRequestChangeEntrust = true
    end, self, self.gameObject)
  end)
end

function cls:getUnlockLv()
  local cfg = _dungeonCrisisCrusadeTpl:getTplById(self.levelId)
  local unlockCondition = _dungeonCrisisCrusadeTpl:getTaskUnlock(cfg)
  return unlockCondition[1][2] and unlockCondition[1][2] or 0
end

function cls:openTickTimer()
  if not self.postPreparationWaitTime then
    self.postPreparationWaitTime = 30
  end
  
  local function func()
    if self.postPreparationWaitTime > 0 then
      self.bind.txt_postPreparationWait = tostring(self.postPreparationWaitTime) .. L_WordsTpl:getValue("notice_pageMultiDungeonMatching_15")
      self.postPreparationWaitTime = self.postPreparationWaitTime - 1
    else
      L_TimerManager:clearTimer(self)
      self:refreshState()
    end
  end
  
  L_TimerManager:newOrResetTimer(self, "postPrepationWait", func, 1, -1)
  func()
end

function cls:openMatchTickTimer()
  if not self.matchTime then
    self.matchTime = 0
  end
  
  local function func()
    if self.isMatching then
      self.matchTime = self.matchTime + 1
      self.bind.txt_matchTips = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_06") .. "(" .. tostring(self.matchTime) .. "s)"
      self.lastMatchTime = self.matchTime
      if self.matchTime > 300 then
        self:StartMatchMember(false)
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageMultiDungeonMatching_16"))
      end
    else
      L_TimerManager:clearTimer(self)
    end
  end
  
  L_TimerManager:newOrResetTimer(self, "matchTimer", func, 1, -1)
  func()
end

function cls:onPlayerInOut(isPlayerIn)
  self.postPreparationWaitTime = 0
  self:hiteMatchTips()
  self:getTeamState()
end

function cls:onPlayerisReady(isPlayerisReady)
  self:getTeamState()
  self.bind.txt_postPreparationWait = tostring(self.postPreparationWaitTime) .. L_WordsTpl:getValue("notice_pageMultiDungeonMatching_15")
end

function cls:onChangeTarget(id, data)
  if data:GetBool(1) then
    return
  else
    self:onChangeEntrust(data:GetInt(0))
  end
end

function cls:onMemberUpdate()
  self:getTeamState()
end

function cls:onLeaderChange()
  self:getTeamState()
end

function cls:onIsMatching()
  self:getTeamState()
end

function cls:onMatchTimer(time)
  if self.isRoomOwner or not self.isInRoom then
    self.matchTime = C_MultiTeam.GetPlayTimeLenSec()
    if self.matchTime >= 180 then
      self.isMatching = false
      self:refreshState()
    else
      local tips = L_WordsTpl:getValue("notice_pageMultiDungeonMatching_06") .. "(" .. tostring(self.matchTime) .. "s)"
      self.bind.txt_matchTips = tips
      CS.Lens.Gameplay.UI.PageMultiTeamState.UpdateMatchTips(tips)
    end
  end
end

function cls:onMultiTeamMatchStateUpdate(_, varList)
  local isMatching = varList:GetBool(0)
  if not isMatching and self.m_requestMatchCancelingState then
    if self.m_requestMatchCancelingState == 1 then
      self:StartMatchMember(true)
    elseif self.m_requestMatchCancelingState == 2 then
      self:enterDungeon()
    end
  end
  self.m_requestMatchCancelingState = nil
end

function cls:onPostPrepareWaitTimer(time)
  if self.isRoomOwner then
    self.postPreparationWaitTime = math.floor(time)
    if self.postPreparationWaitTime <= 0 then
      self:refreshState()
    end
    self.bind.txt_postPreparationWait = tostring(self.postPreparationWaitTime) .. L_WordsTpl:getValue("notice_pageMultiDungeonMatching_15")
  end
end

function cls:onChangeEntrust(dungeonId)
  local levelId = _dungeonCrisisCrusadeTpl:getLevelIdByDungeonId(dungeonId)
  self.curRoomLevel = levelId
  self.callback(levelId, true)
  self:refreshState()
end

function cls:initSurpriseTimer()
  self:closeSurpriseTimer()
  local dungeonEntrustCfg = _dungeonCrisisCrusadeTpl:getTplById(self.levelId)
  local dungeonId = 0
  if dungeonEntrustCfg then
    dungeonId = dungeonEntrustCfg.dungeonId
  end
  self.surpriseTime = C_MultiTeam.GetEntrustData(dungeonId)
  self.bind.txt_surpriseTime = L_TimeUtil.getLeftTime(self.surpriseTime)
  self.surpriseTimer = Timer.repeated(1, function()
    self.bind.txt_surpriseTime = L_TimeUtil.getLeftTime(self.surpriseTime)
  end, self, self.gameObject)
end

function cls:closeSurpriseTimer()
  if self.surpriseTimer ~= nil then
    Timer.remove(self.surpriseTimer)
    self.surpriseTimer = nil
  end
end

function cls:hide()
  if self._onEvent_PostPrepareWaitHandle ~= nil then
    C_MultiTeam.RemoveEventTimer("StartReady", self._onEvent_PostPrepareWaitHandle)
  end
end

function cls:onPageHide(pageName)
  print("onPageHide" .. tostring(pageName))
  if pageName == "pageMultiTeam" then
    self:getTeamState()
  end
end

function cls:close(options)
  self:closeSurpriseTimer()
  self.isReqEnterDungeon = false
  L_TimerManager:clearTimer(self)
  if self._onEvent_PlayerInOutEventHandle ~= nil then
    C_MultiEvent.instance:Cancel(C_EMultiEvent.MultiTeamInOutTeam, self._onEvent_PlayerInOutEventHandle)
  end
  if self._onEvent_PlayerisReadyEventHandle ~= nil then
    C_MultiEvent.instance:Cancel(C_EMultiEvent.MultiTeamIsReady, self._onEvent_PlayerisReadyEventHandle)
  end
  if self._onEvent_ChangeTargetEventHandle ~= nil then
    C_MultiEvent.instance:Cancel(C_EMultiEvent.MultiTeamChangeTarget, self._onEvent_ChangeTargetEventHandle)
  end
  if self._onEvent_MemberUpdataEventHandle ~= nil then
    C_MultiEvent.instance:Cancel(C_EMultiEvent.MultiTeamMemberUpdate, self._onEvent_MemberUpdataEventHandle)
  end
  if self._onEvent_ChangeLeaderChangeHandle ~= nil then
    C_MultiEvent.instance:Cancel(C_EMultiEvent.MultiTeamLeaderChange, self._onEvent_ChangeLeaderChangeHandle)
  end
  if self._onEvent_IsMachingHandle ~= nil then
    C_MultiEvent.instance:Cancel(C_EMultiEvent.MultiTeamIsMatching, self._onEvent_IsMachingHandle)
  end
  if self._onEvent_MatchTimerHandle ~= nil then
    C_MultiTeam.RemoveEventTimer("Match", self._onEvent_MatchTimerHandle)
  end
  if self._onEvent_PostPrepareWaitHandle ~= nil then
    C_MultiTeam.RemoveEventTimer("StartReady", self._onEvent_PostPrepareWaitHandle)
  end
  if self._onMultiTeamMatchStateUpdate then
    C_MultiEvent.instance:Cancel(C_EMultiEvent.MultiTeamMatchStateUpdate, self._onMultiTeamMatchStateUpdate)
  end
  L_UI:removeListener(L_UI.pageEvent.hided, self.onPageHide, self)
  self.m_requestMatchCancelingState = nil
  cls.super.close(self, options)
end

return cls
