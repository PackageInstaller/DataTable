local this = class("moduleEntrustBattleTask", G_UIModuleBase)
local LevelData = {
  id = 0,
  chapter_id = 0,
  level_name = string.empty,
  next_level_id = 0,
  level_num = string.empty,
  desc = string.empty,
  npc_name = string.empty,
  is_unlock = false,
  lock_desc = string.empty,
  is_complete = false,
  complete_star = 0,
  challenge_list = {},
  first_loot_list = {},
  challenge_reward_show_list = {},
  enemy_list = {},
  lock_desc = string.empty,
  pre_level_id = 0,
  is_unlock_pre_level = false,
  stamina = 0
}

function LevelData:new(id, chapter_id, level_name, next_level_id, level_num, desc, npc_name, is_unlock, is_complete, complete_star, challenge_list, first_loot_list, challenge_reward_show_list, enemy_list, lock_desc, pre_level_id, is_unlock_pre_level, stamina)
  local self = setmetatable({}, LevelData)
  self.id = id or 0
  self.chapter_id = chapter_id or 0
  self.level_name = level_name or ""
  self.next_level_id = next_level_id or 0
  self.desc = desc or ""
  self.npc_name = npc_name or ""
  self.level_num = level_num or ""
  self.is_unlock = is_unlock or false
  self.is_complete = is_complete or false
  self.complete_star = complete_star or 0
  self.challenge_list = challenge_list or {}
  self.first_loot_list = first_loot_list or {}
  self.challenge_reward_show_list = challenge_reward_show_list or {}
  self.enemy_list = enemy_list or {}
  self.lock_desc = lock_desc or ""
  self.pre_level_id = pre_level_id or 0
  self.is_unlock_pre_level = is_unlock_pre_level or false
  self.stamina = stamina or 0
  self.need_show_lock_bg = false
  self.lock_bg_length = 0
  self.unlock_tran = nil
  return self
end

local LevelMap = {}
local _kiboDuleGroupTpl = L_GameTpl:getKiBoDuelGroupTpl()
local _kiboDuleKoTpl = L_GameTpl:getKiboDuelTpl()
local commonConditionTpl = L_GameTpl:getCommonConditionTpl()

function this.bind()
  return {
    module_entrustBattleTaskList = {
      moduleName = "pages/entrustTask/moduleEntrustBattleTaskList"
    },
    moduleEntrustLevelDetails = {
      moduleName = "pages/entrustTask/moduleEntrustLevelDetails"
    }
  }
end

function this.methods()
  return {}
end

function this:open()
  self._taskListModule = self.modules.module_entrustBattleTaskList
  self.moduleEntrustLevelDetails = self.modules.moduleEntrustLevelDetails
  self:initData()
  self:initCommonTop()
  self._taskListModule:setListData(LevelMap)
  self._taskListModule:refreshList()
  local firstValue = self:getFirstData(self.sort_list)
  self.moduleEntrustLevelDetails:initEntrustBattleTaskDetails(firstValue)
  self._taskListModule:refreshAllBtnFalse()
  self._taskListModule:selectItem(firstValue.id)
end

function this:setSelect(id)
  if self._taskListModule and LevelMap[id] then
    self._taskListModule:selectItem(id, true)
    self.moduleEntrustLevelDetails:initEntrustBattleTaskDetails(LevelMap[id], true)
  end
end

function this:activate()
  self:open()
  C_AudioManager.Play("Play_SFX_System_UI_EnTrust_Tab_Pencil")
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

function this:initData()
  local data = _kiboDuleGroupTpl:getValue()
  LevelMap = {}
  self.sort_list = {}
  for levelId, v in pairs(data) do
    local is_unlock = true
    local lock_desc = string.empty
    for i, iter in pairs(v.unlockCondition) do
      local tmp_lock, results, lockIndex = L_ConditionManager:singleIsComplete(iter)
      if not tmp_lock then
        is_unlock = false
        local tpl_commonCondition = commonConditionTpl:getTplById(iter[1])
        lock_desc = string.gsub(commonConditionTpl:getDescShowKey(tpl_commonCondition), "{playerlevel}", tostring(iter[2]))
        break
      end
    end
    local complete_star = L_EntrustStore:getEntrustKiboLevelStar(levelId)
    local is_complete = L_EntrustStore:getEntrustKiboSucTime(levelId) > 0
    local challenge_list = {}
    local first_loot_list = {}
    local challenge_reward_show_list = {}
    local enemy_list = {}
    local kibo_tpl = _kiboDuleKoTpl:getTplById(levelId)
    if kibo_tpl then
      challenge_list = _kiboDuleKoTpl:getChallenge(kibo_tpl)
      first_loot_list = _kiboDuleKoTpl:getChallengeRewardShow(kibo_tpl)
      challenge_reward_show_list = _kiboDuleKoTpl:getCommonReward(kibo_tpl)
      enemy_list = _kiboDuleKoTpl:getEnemy(kibo_tpl)
    end
    local pre_level_id = _kiboDuleGroupTpl:getPreCondition(levelId)
    local is_unlock_pre_level = L_EntrustStore:checkEntrustKiboBattleSuc(pre_level_id)
    local tmp_data = LevelData:new(v.id, v.chapterID, _kiboDuleGroupTpl:getLevelName(v), v.nextLevel, _kiboDuleGroupTpl:getLevelNum(v), _kiboDuleGroupTpl:getDec(v), _kiboDuleGroupTpl:getLevelNpc(v), is_unlock, is_complete, complete_star, challenge_list, first_loot_list, challenge_reward_show_list, enemy_list, lock_desc, pre_level_id, is_unlock_pre_level, v.stamina)
    
    function tmp_data.onClickEvent(id)
      self:onClickEvent(id)
    end
    
    LevelMap[levelId] = tmp_data
    table.insert(self.sort_list, tmp_data)
  end
  table.sort(self.sort_list, function(a, b)
    return tonumber(a.level_num) < tonumber(b.level_num)
  end)
  printf("Entrust Battle 初始化数据完成", LevelMap)
  self:createLockBgData()
end

function this:initCommonTop()
  local data = {
    name = L_WordsTpl:getValue("residual_code_moduleentrustbattletask_01"),
    nameEn = "NAME",
    mainBtnBool = true,
    mainBtn = function()
      L_UI:close(self.pageName)
    end,
    closeCurPage = function()
      L_UI:close(self.pageName)
    end
  }
end

function this:refreshDetailView(id)
end

function this:onClickEvent(id)
  local data = {}
  for k, v in pairs(LevelMap) do
    if v.id == id then
      data = v
      break
    end
  end
  if data == nil then
    errorf("点击事件错误，找不到关卡数据")
    return
  end
  if not LevelMap[id].is_unlock or not LevelMap[id].is_unlock_pre_level then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_cellPetDuelLevel"))
  elseif self.lastSelect ~= LevelMap[id] then
    self.lastSelect = LevelMap[id]
    self.moduleEntrustLevelDetails:initEntrustBattleTaskDetails(LevelMap[id], true)
    self._taskListModule:refreshAllBtnFalse()
    self._taskListModule:selectItem(id)
  end
end

function this:getFirstData(list)
  if table.isEmpty(list) then
    return nil
  end
  for k, v in pairs(list) do
    return v
  end
end

function this:createLockBgData()
  local isFirst = false
  local isFirstIndex = 1
  local count = 0
  local len = #self.sort_list
  for k, v in ipairs(self.sort_list) do
    if not v.is_unlock or not v.is_unlock_pre_level then
      if isFirst == false then
        isFirst = true
        isFirstIndex = k
      end
      count = count + 1
      if k == len then
        self.sort_list[isFirstIndex].need_show_lock_bg = true
        self.sort_list[isFirstIndex].lock_bg_length = count
        isFirst = false
      end
    elseif 1 <= isFirstIndex and len >= isFirstIndex and isFirst == true then
      self.sort_list[isFirstIndex].need_show_lock_bg = true
      self.sort_list[isFirstIndex].lock_bg_length = count
      isFirst = false
    end
  end
end

return this
