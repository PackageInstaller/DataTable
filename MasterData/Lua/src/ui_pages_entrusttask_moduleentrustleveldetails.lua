local cls = class("moduleEntrustLevelDetails", G_UIModuleBase)
local _dungeonEntrustTpl = L_GameTpl:getDungeonEntrustTpl()
local _dungeonTpl = L_GameTpl:getDungeonTpl()
local _trainTaskTpl = L_GameTpl:getTrainTaskTpl()
local _kibiDuelTpl = L_GameTpl:getKiboDuelTpl()
local _enemyTpl = L_GameTpl:getEnemyTpl()
local L_EntrustStore = _ENV.L_EntrustStore
local L_ConditionManager = _ENV.L_ConditionManager
local math_floor = math.floor
local ipairs = _ENV.ipairs
local StarIconEnum = {
  [3] = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_wz03.png",
  [2] = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_wz02.png",
  [1] = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_wz01.png"
}

function cls.bind()
  return {
    active_imgIndicator = false,
    go_finished = false,
    img_finishedStar = "",
    img_enemy = "",
    txt_entrustName = "",
    txt_recommendLevel = "",
    active_btnEnemyInfo = false,
    active_listCondition = false,
    active_listCondition_area = false,
    list_entrustTaskCondition_area = {
      moduleName = "pages/entrustTask/cellEntrustTaskCondition_area"
    },
    list_entrustTaskCondition = {
      moduleName = "pages/entrustTask/cellEntrustTaskCondition"
    },
    active_goLine = false,
    active_starReward = false,
    list_entrustTaskStarReward = {
      moduleName = "pages/entrustTask/cellEntrustTaskStarReward"
    },
    active_scrollDesc = false,
    txt_scrollDesc = "",
    color_txtScrollDesc = C_Color.white,
    active_Desc = false,
    txt_Desc = "",
    pos_Desc = C_Vector3.zero,
    pos_npcNameNode = C_Vector3.zero,
    active_npcNameNode = false,
    txt_npcName = "",
    active_consumeTipsNode = false,
    txt_energyConsume = "",
    sizeDelta_titleBg = C_Vector2.zero,
    table_taskReward = {
      moduleName = "pages/entrustTask/cellEntrustTaskReward"
    },
    moduleRewardUp = {
      moduleName = "pages/gameAct/doubleDrop/moduleRewardUp"
    },
    txt_btnName = "",
    go_bgArea = false,
    go_bgOther = false,
    go_enemyImg = false
  }
end

function cls.methods()
  return {
    onClick_openEnemyInfo = function(self)
      if self.entrustType == L_Const.EntrustTypeEnum.PetDuel then
        L_UI:open("pageEntrustEnemyDetail", {
          dungeonId = self.levelData.id,
          entrustType = L_Const.EntrustTypeEnum.PetDuel
        })
      elseif self.entrustType == L_Const.EntrustTypeEnum.AreaEntrust then
        local dungeonEntrustCfg = _dungeonEntrustTpl:getTplById(self.levelId)
        L_UI:open("pageEntrustEnemyDetail", {
          dungeonId = _dungeonEntrustTpl:getDungeonId(dungeonEntrustCfg),
          entrustType = L_Const.EntrustTypeEnum.AreaEntrust
        })
      end
    end,
    onClick_challenge = function(self)
      if self.entrustType == L_Const.EntrustTypeEnum.AreaEntrust then
        local condId = AzurWorld.ConditionMgr:CreateCond({70001}, nil)
        if not AzurWorld.ConditionMgr:CheckCond(condId) then
          local cond = AzurWorld.ConditionMgr:GetCond(condId)
          if cond then
            local str = cond:ShowMsg()
            L_FlyMsgManager:showNormalMsg(str)
          end
          return
        end
        local id = self.levelId
        print("场景ID" .. id)
        L_EntrustStore:setCurChallengeEntrustId(id)
        L_EntrustStore:req_enterEntrustLevel(id)
        if AzurWorld.proxyCenter.curProxy.proxyType ~= C_EWorldType.Home then
          c_UIRestore.TagUIRestoreData("pageDungeonEntrustEntrance", L_UI:getOptions({
            isInDetail = true,
            openDetail = true,
            detailPageTypeId = 1,
            selectId = id,
            checkGuid = true
          }))
        end
      elseif self.entrustType == L_Const.EntrustTypeEnum.TrainTask then
        self:checkAndGo()
        if AzurWorld.proxyCenter.curProxy.proxyType ~= C_EWorldType.Home then
          c_UIRestore.TagUIRestoreData("pageDungeonEntrustEntrance", L_UI:getOptions({
            isInDetail = true,
            openDetail = true,
            entrustType = 3,
            selectTab = 1,
            checkGuid = true
          }))
        end
      elseif self.entrustType == L_Const.EntrustTypeEnum.PetDuel then
        local entrustTypeTpl = L_GameTpl:getDungeonEntrustTypeTpl()
        local tpl = entrustTypeTpl:getTplById(L_Const.EntrustTypeEnum.PetDuel)
        local systemId = entrustTypeTpl:getSystemUnLockId(tpl)
        if not C_IntegrateMgr.SystemUnlockModule:CheckAndTip(systemId) then
          return
        end
        local curStamina = L_PlayerStore:getCurrencyNum(L_Const.currencyType.stamina)
        if curStamina >= self.levelData.stamina then
          local levelId = self.levelData.id
          L_EntrustStore:call(L_EntrustStore.event.entrustEnter, function()
            L_UI:open("pagePetDuelMain", {levelId = levelId, isRestore = true})
          end)
          if AzurWorld.proxyCenter.curProxy.proxyType ~= C_EWorldType.Home then
            c_UIRestore.TagUIRestoreData("pageDungeonEntrustEntrance", L_UI:getOptions({
              isInDetail = true,
              openDetail = true,
              entrustType = 5,
              selectId = levelId,
              checkGuid = true
            }))
          end
        else
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_dungeon_lackenergy"))
          L_UI:open("pageStamina")
        end
      end
    end
  }
end

function cls:setShow(bShow)
  L_CommonUtil.setObjActive(self.gameObject, bShow)
  self.bindComponents.rootAnim:Play("anim_dungeon_formula_in")
end

function cls:initAreaEntrustDetails(levelId, bChangeTab, bChangeLevel)
  local function func()
    self.entrustType = L_Const.EntrustTypeEnum.AreaEntrust
    
    self.levelId = levelId
    self.bind.txt_btnName = L_WordsTpl:getValue("dungeon_entrust_startbutton")
    local dungeonEntrustCfg = _dungeonEntrustTpl:getTplById(self.levelId)
    self.bind.txt_recommendLevel = string.format("当前关卡建议 LV.%s", _dungeonEntrustTpl:getRecommendLevel(dungeonEntrustCfg))
    self.bind.txt_entrustName = _dungeonEntrustTpl:getName(dungeonEntrustCfg)
    self.bind.active_btnEnemyInfo = true
    self.bind.active_scrollDesc = true
    self.bind.txt_scrollDesc = _dungeonEntrustTpl:getIntroduce(dungeonEntrustCfg)
    if L_DeviceTpl:getIsMobile() then
      self.bind.color_txtScrollDesc = C_Color(0.16470588235294117, 0.16470588235294117, 0.16470588235294117, 0.8)
    else
      self.bind.color_txtScrollDesc = C_Color(0.16470588235294117, 0.16470588235294117, 0.16470588235294117, 0.6)
    end
    self.bind.active_Desc = false
    self.bind.active_npcNameNode = true
    self.bind.txt_npcName = _dungeonEntrustTpl:getEntrustNpcName(dungeonEntrustCfg)
    local starNum = L_EntrustStore:getEntrustLevelStar(self.levelId)
    self.bind.go_finished = 0 < starNum
    self.bind.active_imgIndicator = 0 < starNum
    if 0 <= starNum then
      self.bind.img_finishedStar = StarIconEnum[starNum]
    end
    self.bind.active_consumeTipsNode = true
    self.staminaConsume = _dungeonEntrustTpl:getEnergyConsume(dungeonEntrustCfg)
    self.bind.txt_energyConsume = tostring(self.staminaConsume) .. "】"
    self.bind.sizeDelta_titleBg = C_Vector2(633, 43)
    self.bind.active_listCondition = false
    self.bind.active_listCondition_area = true
    self.bind.active_starReward = true
    self:refreshAreaEntrustTaskCondition(dungeonEntrustCfg)
    self:refreshAreaEntrustTaskReward(dungeonEntrustCfg)
    self.bind.go_bgArea = false
    self.bind.go_bgOther = true
    self.bind.go_enemyImg = true
    local dungeonId = _dungeonEntrustTpl:getDungeonId(dungeonEntrustCfg)
    local enemyData = self:getDungeonEnemyBoss(dungeonId)
    if enemyData then
      local enemyCfg = _enemyTpl:getTplById(enemyData)
      if enemyCfg then
        self.bind.img_enemy = _enemyTpl:getAvatarTexture(enemyCfg)
      end
    end
  end
  
  if self.initAnimOver then
    if bChangeTab then
      self.bindComponents.rootAnim:Stop()
      self.bindComponents.boardAnim:Rewind()
      self.bindComponents.boardAnim:Play("anim_dungeon_formula_change")
      L_TimerManager:newOrResetTimer(self, "dungeonChange1", function()
        func()
      end, 0.13)
    else
      self.bindComponents.rootAnim:Stop()
      self.bindComponents.boardAnim:Rewind()
      self.bindComponents.boardAnim:Play("anim_dungeon_formula_change1")
      L_TimerManager:newOrResetTimer(self, "dungeonChange1", function()
        func()
      end, 0.07)
      C_AudioManager.Play("Play_SFX_System_UI_EnTrust_Tab_Switch")
    end
  else
    self.bindComponents.rootAnim:Stop()
    self.bindComponents.boardAnim:Rewind()
    self.bindComponents.rootAnim:Play("anim_dungeon_formula_in")
    L_TimerManager:newOrResetTimer(self, "anim_dungeon_formula_in", function()
      func()
      self.initAnimOver = true
    end, 0.13)
  end
  self.bindComponents.scroll_desc.verticalNormalizedPosition = 1
  self.bindComponents.scroll_reward.horizontalNormalizedPosition = 0
end

function cls:getDungeonEnemyBoss(dungeonId)
  local cfg = _dungeonTpl:getTplById(dungeonId)
  local enemyList = _dungeonTpl:getEnemy(cfg)
  if not enemyList or #enemyList == 0 then
    return nil
  end
  local priority = {
    [L_Const.enemyType.boss] = 3,
    [L_Const.enemyType.elite] = 2,
    [L_Const.enemyType.normal] = 1
  }
  local bestId, bestPriority = nil, -1
  for i = 1, #enemyList do
    local v = enemyList[i]
    local id = v[1]
    local tpl = _enemyTpl:getTplById(id)
    if tpl then
      local p = priority[tpl.enemyType] or 0
      if bestPriority < p then
        bestPriority = p
        bestId = id
      end
    end
  end
  return bestId
end

function cls:refreshAreaEntrustTaskCondition(dungeonEntrustCfg)
  local starBit = L_EntrustStore:getEntrustLevelStarBit(self.levelId)
  local taskTable = self:calTaskComplete(starBit, 3)
  if not self._areaEntrustConditionCache then
    self._areaEntrustConditionCache = {}
  end
  local levelId = _dungeonEntrustTpl:getId(dungeonEntrustCfg)
  local cache = self._areaEntrustConditionCache[levelId]
  if not cache then
    cache = {}
    local dungeonId = _dungeonEntrustTpl:getDungeonId(dungeonEntrustCfg)
    local dungeonCfg = _dungeonTpl:getTplById(dungeonId)
    local dungeonTaskDecs = _dungeonTpl:getChallengeDes(dungeonCfg) or {}
    local starRewards = {}
    local oneStarReward = _dungeonEntrustTpl:getOneStarRewardShow(dungeonEntrustCfg) or {}
    if oneStarReward[1] then
      local item = L_ItemTplManager:getItemConfig(oneStarReward[1].itemType, oneStarReward[1].itemId)
      if item then
        starRewards[1] = {
          icon = item.icon,
          numTxt = "X" .. oneStarReward[1].itemNum
        }
      end
    end
    local twoStarReward = _dungeonEntrustTpl:getTwoStarRewardShow(dungeonEntrustCfg) or {}
    if twoStarReward[1] then
      local item = L_ItemTplManager:getItemConfig(twoStarReward[1].itemType, twoStarReward[1].itemId)
      if item then
        starRewards[2] = {
          icon = item.icon,
          numTxt = "X" .. twoStarReward[1].itemNum
        }
      end
    end
    local threeStarReward = _dungeonEntrustTpl:getThreeStarRewardShow(dungeonEntrustCfg) or {}
    if threeStarReward[1] then
      local item = L_ItemTplManager:getItemConfig(threeStarReward[1].itemType, threeStarReward[1].itemId)
      if item then
        starRewards[3] = {
          icon = item.icon,
          numTxt = "X" .. threeStarReward[1].itemNum
        }
      end
    end
    cache.starRewards = starRewards
    local info = {}
    for i, v in ipairs(dungeonTaskDecs) do
      local rewardSummary = starRewards[i]
      info[i] = {
        txt_condition = v,
        bFinish = false,
        starNum = 0,
        index = i,
        levelId = levelId,
        go_reward = rewardSummary and true or false,
        img_reward = rewardSummary and rewardSummary.icon or "",
        txt_itemNum = rewardSummary and rewardSummary.numTxt or ""
      }
    end
    cache.info = info
    self._areaEntrustConditionCache[levelId] = cache
  end
  local starRewards = cache.starRewards or {}
  local info = cache.info or {}
  local headerReward = starRewards[self.bind.index]
  if headerReward then
    self.bind.img_reward = headerReward.icon
    self.bind.txt_itemNum = headerReward.numTxt
  else
    self.bind.img_reward = ""
    self.bind.txt_itemNum = ""
  end
  if taskTable then
    for i = 1, #info do
      local cond = info[i]
      cond.starNum = L_EntrustStore:getEntrustLevelStar(self.levelId)
      cond.bFinish = taskTable[cond.index] == 1
    end
  else
    for i = 1, #info do
      info[i].bFinish = false
    end
  end
  local listData = {}
  for i = 1, #info do
    local src = info[i]
    listData[i] = {
      txt_condition = src.txt_condition,
      bFinish = src.bFinish,
      starNum = src.starNum,
      index = src.index,
      levelId = src.levelId,
      go_reward = src.go_reward,
      img_reward = src.img_reward,
      txt_itemNum = src.txt_itemNum
    }
  end
  self.bind.list_entrustTaskStarReward:clear()
  self.bind.list_entrustTaskStarReward:insert_array(listData)
  self.bind.active_goLine = true
  self.bind.list_entrustTaskCondition_area:clear()
  self.bind.list_entrustTaskCondition_area:insert_array(listData)
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
    _star = math_floor(_star / 2)
  end
  return tbl
end

function cls:refreshAreaEntrustTaskReward(dungeonEntrustCfg)
  local rewardItems = {}
  local reward = _dungeonEntrustTpl:getRewardShow(dungeonEntrustCfg)
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
  self.modules.moduleRewardUp:setEntrustType(_dungeonEntrustTpl:getTag(dungeonEntrustCfg))
end

function cls:initTrainTaskDetails(selectType, taskId, isbChangeTab)
  local function func()
    self._selectType = selectType
    
    self._selectTaskId = taskId
    self.entrustType = L_Const.EntrustTypeEnum.TrainTask
    self.bind.txt_btnName = "前往教学"
    self.bind.txt_recommendLevel = "任务信息"
    local tpl_task = _trainTaskTpl:getTplById(taskId)
    self.bind.txt_entrustName = _trainTaskTpl:getTaskName(tpl_task)
    self.bind.active_btnEnemyInfo = false
    self.bind.active_scrollDesc = false
    self.bind.active_Desc = true
    self.bind.txt_Desc = _trainTaskTpl:getDesc(tpl_task)
    self.bind.pos_Desc = C_Vector3(-35.607, 265, 0)
    self.bind.active_npcNameNode = false
    self.bind.go_finished = false
    self.bind.active_consumeTipsNode = false
    self.bind.sizeDelta_titleBg = C_Vector2(633, 43)
    self.bind.active_listCondition = false
    self.bind.active_listCondition_area = false
    self.bind.active_starReward = false
    self.bind.go_bgArea = false
    self.bind.go_bgOther = true
    self.bind.go_enemyImg = false
    self:refreshTrainTaskReward(taskId)
  end
  
  if not isbChangeTab then
    self.bindComponents.rootAnim:Stop()
    self.bindComponents.boardAnim:Rewind()
    self.bindComponents.boardAnim:Play("anim_dungeon_formula_change")
    L_TimerManager:newOrResetTimer(self, "dungeonChange1", function()
      func()
    end, 0.13)
  else
    self.bindComponents.rootAnim:Stop()
    self.bindComponents.boardAnim:Rewind()
    self.bindComponents.boardAnim:Play("anim_dungeon_formula_change1")
    L_TimerManager:newOrResetTimer(self, "dungeonChange1", function()
      func()
    end, 0.07)
    C_AudioManager.Play("Play_SFX_System_UI_EnTrust_Tab_Switch")
  end
  self.modules.moduleRewardUp:setEntrustType(0)
end

function cls:refreshTrainTaskReward(taskId)
  local completed = L_EntrustStore:getIsTrainTaskCompleted(taskId)
  local tpl_task = _trainTaskTpl:getTplById(taskId)
  local rewardList = {}
  if self._selectType == L_Const.trainTaskType.dungeon or self._selectType == L_Const.trainTaskType.hero then
    rewardList = _trainTaskTpl:getPassReward(tpl_task)
  elseif self._selectType == L_Const.trainTaskType.kiBoDuel then
    local kibo_duel_id = _trainTaskTpl:getDungeonId(tpl_task)
    local tpl_kibo_duel = _kibiDuelTpl:getTplById(kibo_duel_id)
    rewardList = _kibiDuelTpl:getFirstLoot(tpl_kibo_duel)
  end
  local rewardItems = {}
  for i = 1, #rewardList do
    local item = L_ItemTplManager:getItemConfig(rewardList[i].itemType, rewardList[i].itemId)
    table.insert(rewardItems, {
      itemType = item.itemType,
      itemId = item.itemId,
      num = rewardList[i].itemNum,
      active_img_receive = completed
    })
  end
  self.bind.table_taskReward:clear()
  self.bind.table_taskReward:insert_array(rewardItems)
end

function cls:checkAndGo()
  if self._selectType == L_Const.trainTaskType.dungeon or self._selectType == L_Const.trainTaskType.hero then
    local taskId = self._selectTaskId
    L_EntrustStore:req_CSProtoTeachStart(taskId)
  elseif self._selectType == L_Const.trainTaskType.kiBoDuel then
    local tpl_task = _trainTaskTpl:getTplById(self._selectTaskId)
    local levelId = _trainTaskTpl:getDungeonId(tpl_task)
    L_PetDuelStore:setCurChallengeLevelId(levelId)
    C_KiBoDuelLuaWrapper.SetCurrentLevel(levelId)
    L_PetDuelStore:req_CSProtoKiboDuelStart(levelId)
  end
end

function cls:initEntrustBattleTaskDetails(levelData, isChangeTab)
  local function func()
    self.entrustType = L_Const.EntrustTypeEnum.PetDuel
    
    self.levelData = levelData
    self.bind.txt_btnName = "前往对决"
    self.bind.txt_recommendLevel = "任务信息"
    self.bind.txt_entrustName = self.levelData.level_name
    local starNum = self.levelData.complete_star
    self.bind.go_finished = 0 < starNum
    self.bind.active_imgIndicator = 0 < starNum
    if 0 <= starNum then
      self.bind.img_finishedStar = StarIconEnum[starNum]
    end
    self.bind.active_btnEnemyInfo = true
    self.bind.active_scrollDesc = false
    self.bind.active_Desc = true
    self.bind.txt_Desc = self.levelData.desc
    self.bind.pos_Desc = C_Vector3(-35.607, 47.965, 0)
    self.bind.pos_npcNameNode = C_Vector3(205.5, 28.5, 0)
    self.bind.active_npcNameNode = true
    self.bind.txt_npcName = self.levelData.npc_name
    self.bind.active_consumeTipsNode = true
    self.bind.txt_energyConsume = tostring(self.levelData.stamina) .. "】"
    self.bind.sizeDelta_titleBg = C_Vector2(633, 43)
    self.bind.go_bgArea = false
    self.bind.go_bgOther = true
    self.bind.go_enemyImg = false
    self.bind.active_listCondition = true
    self.bind.active_listCondition_area = false
    self.bind.active_starReward = false
    self:refreshEntrustBattleTaskCondition()
    self:refreshEntrustBattleTaskReward()
  end
  
  if isChangeTab then
    self.bindComponents.rootAnim:Stop()
    self.bindComponents.boardAnim:Rewind()
    self.bindComponents.boardAnim:Play("anim_dungeon_formula_change1")
    L_TimerManager:newOrResetTimer(self, "dungeonChange1", function()
      func()
    end, 0.07)
    C_AudioManager.Play("Play_SFX_System_UI_EnTrust_Tab_Switch")
  else
    func()
  end
  self.modules.moduleRewardUp:setEntrustType(0)
end

function cls:refreshEntrustBattleTaskCondition()
  local conditionList = {}
  local starBit = L_EntrustStore:getEntrustKiboLevelStarBit(self.levelData.id)
  local taskTable = self:calTaskComplete(starBit, 3)
  local descS = L_ConditionManager:getDescs(self.levelData.challenge_list)
  for i, v in ipairs(descS) do
    table.insert(conditionList, {
      txt_condition = v,
      bFinish = taskTable[i] == 1,
      go_reward = false
    })
  end
  self.bind.active_goLine = false
  self.bind.list_entrustTaskCondition:clear()
  self.bind.list_entrustTaskCondition:insert_array(conditionList)
end

function cls:refreshEntrustBattleTaskReward()
  local rewardList = {}
  for i, reward in ipairs(self.levelData.first_loot_list) do
    if i > self.levelData.complete_star then
      table.insert(rewardList, {
        itemType = reward.itemType,
        itemId = reward.itemId,
        num = reward.itemNum,
        starNum = i
      })
    end
  end
  for i, reward in ipairs(self.levelData.challenge_reward_show_list) do
    table.insert(rewardList, {
      itemType = reward.itemType,
      itemId = reward.itemId,
      num = reward.itemNum,
      starNum = 0
    })
  end
  self.bind.table_taskReward:clear()
  self.bind.table_taskReward:insert_array(rewardList)
end

function cls:close(options)
  cls.super.close(self, options)
  L_TimerManager:clearTimer(self)
end

return cls
