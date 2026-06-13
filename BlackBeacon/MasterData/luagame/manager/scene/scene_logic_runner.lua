local CommDefine = require("cs_share.common_define")
local ActionFunc = require("manager.scene.scene_logic_func")
local LOGIC_ACTION = CommDefine.LOGIC_ACTION
local LOGIC_OTHER_PARAMETER = CommDefine.LOGIC_OTHER_PARAMETER
local MONSTER_REFRESH_TYPE = CommDefine.MONSTER_REFRESH_TYPE
local LOGIC_FINISH_CONDITION = CommDefine.LOGIC_FINISH_CONDITION
local LOGIC_EVENT = CommDefine.LOGIC_EVENT
local LOGIC_HIT_NPC_CNT_TYPE = CommDefine.LOGIC_HIT_NPC_CNT_TYPE
local ADD_MONSTER_TIMER_OUT_SIGN = 1
local ADD_MONSTER_EVENT = {
  [LOGIC_ACTION.ADD_MONSTER] = true,
  [LOGIC_ACTION.RANDOM_ADD_MONSTER_EVENT] = true
}
local NPC_STATE = {LIVE = 1, DEAD = 2}
local SAVE_NPC_TYPE = CommDefine.SAVE_NPC_TYPE
local _tunpack = table.unpack
local _tremove = table.remove
local _tinesrt = table.insert
local DELAY_ADD_MONSTER_POOL_KEY = "delay_add_monster_pool"
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local Base = require("manager.scene.base_scene_logic_runner")
local M = Util.create_child_mt(Base)
local AddMonsterParam = Util.create_class()

function AddMonsterParam:_init(uuid, self_camp, res_id, pos_key, offset_x, offset_z, rotation, tag_x, tag_y, camp, level, cur_hp, npc_group, lBornPos, sName, sParams, nMagicId, bLookAtRole, nAiGroup, nAiGroupId, is_end_action, is_max_wave, event_key, lock_enemy_list, difficulty_tag, auto_level)
  self.uuid, self.self_camp, self.res_id, self.pos_key, self.offset_x, self.offset_z, self.rotation, self.tag_x, self.tag_y, self.camp, self.level, self.cur_hp, self.npc_group, self.lBornPos, self.sName, self.sParams, self.nMagicId, self.bLookAtRole, self.nAiGroup, self.nAiGroupId, self.is_end_action, self.is_max_wave, self.event_key, self.lock_enemy_list, self.difficulty_tag, self.auto_level = uuid, self_camp, res_id, pos_key, offset_x, offset_z, rotation, tag_x, tag_y, camp, level, cur_hp, npc_group, lBornPos, sName, sParams, nMagicId, bLookAtRole, nAiGroup, nAiGroupId, is_end_action, is_max_wave, event_key, lock_enemy_list, difficulty_tag, auto_level
end

function AddMonsterParam:get_params()
  return self.uuid, self.self_camp, self.res_id, self.pos_key, self.offset_x, self.offset_z, self.rotation, self.tag_x, self.tag_y, self.camp, self.level, self.cur_hp, self.npc_group, self.lBornPos, self.sName, self.sParams, self.nMagicId, self.bLookAtRole, self.nAiGroup, self.nAiGroupId, self.is_end_action, self.is_max_wave, self.event_key, self.lock_enemy_list, self.difficulty_tag, self.auto_level
end

function AddMonsterParam:on_destroy()
  self.uuid, self.self_camp, self.res_id, self.pos_key, self.offset_x, self.offset_z, self.rotation, self.tag_x, self.tag_y, self.camp, self.level, self.cur_hp, self.npc_group, self.lBornPos, self.sName, self.sParams, self.nMagicId, self.bLookAtRole, self.nAiGroup, self.nAiGroupId, self.is_end_action, self.is_max_wave, self.event_key, self.lock_enemy_list, self.difficulty_tag, self.auto_level = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
end

function M:_init(logic_id)
  Base._init(self, logic_id)
  if GeCaoBattleMgr then
    GeCaoBattleMgr:reset_kill_monster()
  end
  local cfg = ShareRes.get_scene_logic_config(self.m_LogicID)
  self.m_mMonsterEvent = {}
  self.v_monster_actions_count = 0
  self.m_lMonster = {}
  LuaCfgFieldMgr:configure_defaults(cfg)
  if cfg.MonsterRefreshCfg.MonsterWave > 0 then
    self.m_mEnterMonster = cfg.MonsterRefreshCfg
    self.v_monster_actions_count = self.v_monster_actions_count + 1
  end
  self.m_level_counter_list = {}
  self.m_scene_timeline_animator_list = {}
  self.m_mSaveVariable = {}
  self.m_mSaveForeverVariable = {}
  self.m_mEvent = {}
  self.m_mBanAreaKey = {}
  self.m_mMonsterLevel = {}
  self.m_lFuncModule = {}
  self.m_mMonsterActionTag = {}
  self.m_mListenVariable = {}
  self.m_interaction_end_func_npc = {}
  FightDataMgr:set_use_default_start_timer(cfg.mDefaultStartTime)
  FightDataMgr:set_use_default_end_timer(cfg.mDefaultEndTime)
  if cfg.mDefaultStartTime then
    self.mSendStartFightTimerRpc = false
  end
  if cfg.mDefaultEndTime then
    self.mSendStopFightTimerRpc = false
  end
  local mMonsterEvent = cfg.MonsterCountInfo
  self.m_nMonsterCount = 0
  self.m_statistics_monster_info = nil
  self.m_need_statistics_npc_id_map = nil
  if mMonsterEvent then
    self.v_monster_actions_count = self.v_monster_actions_count + mMonsterEvent.EventCount
    self.m_nMonsterCount = mMonsterEvent.MonsterCount
    self.m_statistics_monster_info = mMonsterEvent.MonsterInfo
    for _, data in pairs(cfg.Events) do
      local nType = data.Type
      if not self.m_mEvent[nType] then
        self.m_mEvent[nType] = {}
      end
      local mCopyData = UtilTable.copy_table(data)
      LuaCfgFieldMgr:configure_defaults(mCopyData)
      if mCopyData.Actions then
        local mChangeMonsterEvent = {}
        for index, info in pairs(mCopyData.Actions) do
          local nType = info.Type
          if nType == LOGIC_ACTION.RANDOM_ADD_MONSTER_EVENT then
            local monster_data
            local nEventIndex, mRefresh = self:RandomMonsterEvent(info.RandomMonsterCfgList)
            if mRefresh.MonsterCount then
              self.m_nMonsterCount = self.m_nMonsterCount + mRefresh.MonsterCount
            else
              monster_data = mRefresh
            end
            mChangeMonsterEvent[index] = nEventIndex
            if monster_data then
              self:GetMonsterEventCount(monster_data.Conditions)
            end
          end
        end
        for index, nRandomIndex in pairs(mChangeMonsterEvent) do
          mCopyData.Actions[index].RandomIndex = nRandomIndex
        end
      end
      if mCopyData.ConditionActions then
        local mChangeMonsterEventData = {}
        for index, info in pairs(mCopyData.ConditionActions) do
          if info.Actions then
            for action_index, action in pairs(info.Actions) do
              local nType = info.Type
              if nType == LOGIC_ACTION.RANDOM_ADD_MONSTER_EVENT then
                local monster_data
                local nEventIndex, mRefresh = self:RandomMonsterEvent(info.RandomMonsterCfgList)
                if mRefresh.MonsterCount then
                  self.m_nMonsterCount = self.m_nMonsterCount + mRefresh.MonsterCount
                else
                  monster_data = mRefresh
                end
                if not mChangeMonsterEventData[index] then
                  mChangeMonsterEventData[index] = {}
                end
                mChangeMonsterEventData[index][action_index] = nEventIndex
                if monster_data then
                  self:GetMonsterEventCount(monster_data.Conditions)
                end
              end
            end
          end
        end
        for index, action_index_info in pairs(mChangeMonsterEventData) do
          for action_index, nEvent in pairs(action_index_info) do
            mCopyData.ConditionActions[index][action_index].RandomIndex = nEvent
          end
        end
      end
      if LOGIC_EVENT.FUNC_MODULE == nType then
        self.m_lFuncModule[mCopyData.EventName] = mCopyData
      else
        self.m_mEvent[nType][#self.m_mEvent[nType] + 1] = mCopyData
      end
    end
  else
    for _, data in pairs(cfg.Events) do
      local nType = data.Type
      if not self.m_mEvent[nType] then
        self.m_mEvent[nType] = {}
      end
      local mCopyData = UtilTable.copy_table(data)
      LuaCfgFieldMgr:configure_defaults(mCopyData)
      if mCopyData.Actions then
        local mChangeMonsterEvent = {}
        for index, info in pairs(mCopyData.Actions) do
          local nType = info.Type
          if ADD_MONSTER_EVENT[nType] then
            self.v_monster_actions_count = self.v_monster_actions_count + 1
          end
          local monster_data
          if nType == LOGIC_ACTION.RANDOM_ADD_MONSTER_EVENT then
            local nEventIndex, mRefresh = self:RandomMonsterEvent(info.RandomMonsterCfgList)
            if mRefresh.MonsterCount then
              self.m_nMonsterCount = self.m_nMonsterCount + mRefresh.MonsterCount
            else
              monster_data = mRefresh
            end
            mChangeMonsterEvent[index] = nEventIndex
          else
            monster_data = info.RefreshCfg
          end
          if monster_data then
            self:GetMonsterEventCount(monster_data.Conditions)
          end
        end
        for index, nRandomIndex in pairs(mChangeMonsterEvent) do
          mCopyData.Actions[index].RandomIndex = nRandomIndex
        end
      end
      if mCopyData.ConditionActions then
        local mChangeMonsterEventData = {}
        for index, info in pairs(mCopyData.ConditionActions) do
          if info.Actions then
            for action_index, action in pairs(info.Actions) do
              local nType = info.Type
              if ADD_MONSTER_EVENT[nType] then
                self.v_monster_actions_count = self.v_monster_actions_count + 1
              end
              local monster_data
              if nType == LOGIC_ACTION.RANDOM_ADD_MONSTER_EVENT then
                local nEventIndex, mRefresh = self:RandomMonsterEvent(info.RandomMonsterCfgList)
                if mRefresh.MonsterCount then
                  self.m_nMonsterCount = self.m_nMonsterCount + mRefresh.MonsterCount
                else
                  monster_data = mRefresh
                end
                if not mChangeMonsterEventData[index] then
                  mChangeMonsterEventData[index] = {}
                end
                mChangeMonsterEventData[index][action_index] = nEventIndex
              else
                monster_data = info.RefreshCfg
              end
              if monster_data then
                self:GetMonsterEventCount(monster_data.Conditions)
              end
            end
          end
        end
        for index, action_index_info in pairs(mChangeMonsterEventData) do
          for action_index, nEvent in pairs(action_index_info) do
            mCopyData.ConditionActions[index][action_index].RandomIndex = nEvent
          end
        end
      end
      if LOGIC_EVENT.FUNC_MODULE == nType then
        self.m_lFuncModule[mCopyData.EventName] = mCopyData
      else
        self.m_mEvent[nType][#self.m_mEvent[nType] + 1] = mCopyData
      end
    end
  end
  self.m_mFinishCondition = {}
  if not self:is_pass_room() then
    for nType, info in pairs(cfg.FinishiConditionDict) do
      self.m_mFinishCondition[nType] = {parameter = info, state = false}
    end
  end
  self.v_last_add_frame_id = 0
  self.v_wait_check_add_monster_params = {}
  self.v_add_monster_param_pool = LuaObjPoolMgr.get_pool(DELAY_ADD_MONSTER_POOL_KEY) or LuaObjPoolMgr.register(DELAY_ADD_MONSTER_POOL_KEY, 10, AddMonsterParam)
  if SceneMgr then
    SceneMgr:refresh_scene_timeline_animator_list(self.m_mEvent[LOGIC_EVENT.SCENE_TIMELINE_OBJECT_LIST_EVENT])
  end
  self.v_spawner_behaviors = {}
end

function M:sync_custom_variable(data)
  self.m_mSaveVariable = data
end

function M:sync_forever_variable(data)
  self.m_mSaveForeverVariable = {}
  for _, variable in pairs(data) do
    self.m_mSaveForeverVariable[variable] = 1
  end
  self:refresh_treasure_chest_guide()
end

function M:CheckIsKillAllMonster()
  if not next(self.m_lMonster) then
    return false
  end
  local monster_cnt = #self.m_lMonster
  if monster_cnt < self.v_monster_actions_count then
    return false
  end
  for key, info in pairs(self.m_lMonster) do
    if next(info.monster_list) ~= nil or info.add_monster_status then
      return false
    end
  end
  return true
end

function M:GetEventCfg(nType)
  return self.m_mEvent[nType]
end

function M:RunFuncModule(sEvent)
  if not sEvent or "" == sEvent then
    return
  end
  local sModule = self.m_lFuncModule[sEvent]
  if not sModule then
    Log.Error("not find module func data  logic:" .. self.m_LogicID .. ", sEvent:" .. sEvent)
    return
  end
  if self:CheckCondition(sModule, nil, true) then
    self:RunAction(sModule.Actions)
    self:CheckSetCustomVariable(sModule)
  end
end

function M:FinishEvent(nEvent, nVal)
  local mCondition = self.m_mFinishCondition[nEvent]
  if not mCondition or mCondition.state then
    return
  end
  local func = ActionFunc.GetFinishEvent(nEvent)
  if not func then
    Log.Error("not find behavior func type:" .. nEvent)
  end
  func(mCondition, nVal, self)
  if mCondition.state == true and self:CheckFinishCondition() then
    self:fight_end(true)
  end
end

function M:CheckFinishCondition()
  if not next(self.m_mFinishCondition) then
    return false
  end
  for _, info in pairs(self.m_mFinishCondition) do
    if not info.state then
      return false
    end
  end
  return true
end

function M:AddMonsterEvent(mData)
  local nEvent = #self.m_mMonsterEvent + 1
  local nMaxWave = tonumber(mData.MonsterWave)
  if nMaxWave <= 0 then
    return
  end
  local mMonsterWaveCfg = {}
  local mCondition = mData.Conditions
  for i = 1, nMaxWave do
    local mRefresh = mCondition[i]
    if not next(mRefresh) then
      Log.Error(string.format("缺少怪物波数配置, logic:%s , 波数:%s", self.m_LogicID, i))
    end
    local nGroupId = mRefresh.Id
    local mMonsterData = ShareRes.get_monster_group_config(nGroupId)
    if not mMonsterData then
      Log.Error(string.format("缺少怪物分组配置, logic:%s , 分组ID:%s", self.m_LogicID, nGroupId))
    end
    local tower = TowerMgr and TowerMgr:get_tower()
    local nAiGroupId, difficulty_tag
    if mRefresh.AIGroupId and mRefresh.AIGroupId > 0 then
      nAiGroupId = mRefresh.AIGroupId
    end
    if mRefresh.AIDifficultyTag and mRefresh.AIDifficultyTag >= 0 then
      difficulty_tag = mRefresh.AIDifficultyTag
    end
    if tower and (not nAiGroupId or not difficulty_tag) then
      local temp1, temp2 = tower:get_behavior_ai_param()
      nAiGroupId = nAiGroupId or temp1
      difficulty_tag = difficulty_tag or temp2
    end
    mMonsterWaveCfg[i] = {
      param = mRefresh.param,
      CustomEventName = mRefresh.CustomEventName,
      RefreshCondition = mRefresh.RefreshCondition,
      Timeout = mRefresh.Timeout,
      Id = nGroupId,
      monster = mMonsterData,
      AiGroupId = mRefresh.AIGroup or 0,
      BehaviorGroupId = nAiGroupId,
      difficulty_tag = difficulty_tag
    }
  end
  local sAirWall = mData.WallObjPath
  self.m_mMonsterEvent[nEvent] = {
    max_wave = nMaxWave,
    wave = 0,
    wave_cfg = mMonsterWaveCfg,
    is_notify = mData.SendWave,
    air_wall = sAirWall,
    notify_style = mData.WaveStyle,
    action_tag = mData.ActionTag,
    end_perform = mData.EndPerform,
    lock_enemy_list = mData.MonsterLockEnemyInfoList
  }
  self.m_lMonster[nEvent] = {
    add_status = true,
    monster_list = {},
    add_monster_status = true
  }
  if mData.SendWave then
    self:monster_event_max_wave(nMaxWave)
  end
  if sAirWall then
    self:set_empty_wall_visible(sAirWall, true)
  end
  self:EventAddMonster(nEvent)
  self:check_track()
end

local is_prologue_combat1_start_track = false
local is_prologue_combat2_start_track = false

function M:check_track()
  if not is_prologue_combat1_start_track and TowerMgr and TowerMgr:get_tower() and TowerMgr:get_fight_type() == CommDefine.CHALLENGE_TYPE.NEWBIE_TOWER and 1 == TowerMgr:get_tower():get_floor_num() then
    SDKManager:track_adjust_event("13_prologue_combat1_start")
    is_prologue_combat1_start_track = true
  end
  if not is_prologue_combat2_start_track and TowerMgr and TowerMgr:get_tower() and TowerMgr:get_fight_type() == CommDefine.CHALLENGE_TYPE.NEWBIE_TOWER and 2 == TowerMgr:get_tower():get_floor_num() then
    SDKManager:track_adjust_event("16_prologue_combat2_start")
    is_prologue_combat2_start_track = true
  end
end

function M:GetTowerMonsterLevel(key)
  if not self.m_mMonsterLevel[key] then
    self.m_mMonsterLevel[key] = self:get_tower_monster_level(key)
  end
  return self.m_mMonsterLevel[key]
end

function M:EventAddMonster(nEventKey)
  local mEvent = self.m_mMonsterEvent[nEventKey]
  if not mEvent then
    return
  end
  if mEvent.wave >= mEvent.max_wave then
    return
  end
  local nWave = mEvent.wave + 1
  local mWaveMonsterCfg = mEvent.wave_cfg[nWave]
  if not mWaveMonsterCfg then
    return
  end
  if FightDataMgr:is_use_default_start_timer() and not self.mSendStartFightTimerRpc and 1 == nWave then
    self.mSendStartFightTimerRpc = true
    local func = ActionFunc.GetActionFunc(LOGIC_ACTION.START_FIGHT_TIMING)
    if func then
      func(self)
    end
  end
  if mEvent.is_notify then
    self:update_monster_event_wave(nWave, mEvent.notify_style)
  end
  local is_end_action = mEvent.end_perform
  local is_max_wave = nWave >= mEvent.max_wave
  local lock_enemy_list = mEvent.lock_enemy_list
  local nAiGroupId, nBehaviorId, difficulty_tag = mWaveMonsterCfg.AiGroupId, mWaveMonsterCfg.BehaviorGroupId, mWaveMonsterCfg.difficulty_tag
  for _, data in pairs(mWaveMonsterCfg.monster.unitList) do
    self:AddMonster(data, nEventKey, nil, mWaveMonsterCfg.monster.Id, nAiGroupId, nBehaviorId, is_end_action, is_max_wave, lock_enemy_list, difficulty_tag)
  end
  self.m_lMonster[nEventKey].add_monster_status = false
  mEvent.wave = nWave
  self:CheckAddMonsterCondition(nEventKey, mEvent)
end

function M:AddMonster(mMonster, nEventKey, bTimeOut, nNpcGroup, nAiGroupId, nBehaviorId, is_end_action, is_max_wave, lock_enemy_list, difficulty_tag)
  local lMonster = self.m_lMonster[nEventKey].monster_list
  local bCheckCondition = false
  if bTimeOut then
    local sMonsterKey = mMonster.UnitKey
    local nLevel = mMonster.Level
    local nAutoLevel = mMonster.AutoLevel
    if nAutoLevel and 0 ~= nAutoLevel then
      nLevel = self:GetTowerMonsterLevel("MonLevel" .. nAutoLevel)
    end
    local uuid = SceneMgr:get_uuid()
    self:_push_to_need_add(uuid, LOGIC_OTHER_PARAMETER.NPC_CAMP, mMonster.UnitID, mMonster.InitPos, mMonster.OffSetX or 0, mMonster.OffSetZ or 0, mMonster.Rotate, 0, 0, 0 == mMonster.Camp and 4 or mMonster.Camp, nLevel, nil, nNpcGroup, mMonster.BornPos, sMonsterKey, nil, mMonster.MagicId, mMonster.IsLookAtRole, nAiGroupId, nBehaviorId, is_end_action, is_max_wave, nEventKey, lock_enemy_list, difficulty_tag, nAutoLevel)
    for idx, obj in pairs(lMonster) do
      if obj == ADD_MONSTER_TIMER_OUT_SIGN then
        lMonster[idx] = uuid
        break
      end
    end
  elseif not mMonster.IsNoUse then
    local sMonsterKey = mMonster.UnitKey
    local nTimeOut = tonumber(mMonster.Delay or 0)
    if nTimeOut <= 0 then
      local nLevel = mMonster.Level
      local nAutoLevel = mMonster.AutoLevel
      if nAutoLevel and 0 ~= nAutoLevel then
        nLevel = self:GetTowerMonsterLevel("MonLevel" .. nAutoLevel)
      end
      local uuid = SceneMgr:get_uuid()
      self:_push_to_need_add(uuid, LOGIC_OTHER_PARAMETER.NPC_CAMP, mMonster.UnitID, mMonster.InitPos, mMonster.OffSetX or 0, mMonster.OffSetZ or 0, mMonster.Rotate, 0, 0, 0 == mMonster.Camp and 4 or mMonster.Camp, nLevel, nil, nNpcGroup, mMonster.BornPos, sMonsterKey, nil, mMonster.MagicId, mMonster.IsLookAtRole, nAiGroupId, nBehaviorId, is_end_action, is_max_wave, nEventKey, lock_enemy_list, difficulty_tag, nAutoLevel)
      lMonster[#lMonster + 1] = uuid
    else
      lMonster[#lMonster + 1] = ADD_MONSTER_TIMER_OUT_SIGN
      self:timer_call_out("add_monster_" .. sMonsterKey, function()
        self:AddMonster(mMonster, nEventKey, true, nNpcGroup, nAiGroupId, nBehaviorId, is_end_action, is_max_wave, lock_enemy_list, difficulty_tag)
      end, nTimeOut)
    end
  else
    bCheckCondition = true
  end
  return bCheckCondition
end

function M:_push_to_need_add(...)
  local params = self.v_add_monster_param_pool:new_obj(...)
  _tinesrt(self.v_wait_check_add_monster_params, params)
end

function M:_internal_add_monster(param)
  self:add_npc_by_pos_key(param:get_params())
end

function M:_check_add_monster_list()
  if not self.v_wait_check_add_monster_params or not next(self.v_wait_check_add_monster_params) then
    return
  end
  local params = self.v_wait_check_add_monster_params[1]
  _tremove(self.v_wait_check_add_monster_params, 1)
  self:_internal_add_monster(params)
  self.v_add_monster_param_pool:destroy_obj(params)
end

function M:CheckAddMonsterCondition(nEvent, mMonsterEvent, nNpcID)
  local mMonster = self.m_lMonster[nEvent]
  local nNum = #mMonster.monster_list
  mMonsterEvent = mMonsterEvent or self.m_mMonsterEvent[nEvent]
  local nNowWave = mMonsterEvent.wave
  local mWaveCfg = mMonsterEvent.wave_cfg[nNowWave]
  if not mWaveCfg then
    Log.Error("not find monster wave cfg wavenum:" .. nNowWave .. ", scenelogc:%s" .. self.m_LogicID)
    return
  end
  local nRefreshType = mWaveCfg.RefreshCondition
  if nRefreshType == MONSTER_REFRESH_TYPE.KILL_NPC then
    if not nNpcID or nNpcID ~= mWaveCfg.param then
      return
    end
    self:MonsterEventNextWave(nEvent, mMonsterEvent)
  else
    if mMonster.add_monster_status then
      return
    end
    if nRefreshType == MONSTER_REFRESH_TYPE.KILLALL and 0 == nNum or nRefreshType == MONSTER_REFRESH_TYPE.KILL_REST and nNum <= mWaveCfg.param then
      self:MonsterEventNextWave(nEvent, mMonsterEvent)
    end
  end
end

function M:MonsterEventNextWave(nEvent, mMonsterEvent)
  if mMonsterEvent.end_action then
    return
  end
  local nNowWave = mMonsterEvent.wave
  local mWaveCfg = mMonsterEvent.wave_cfg[nNowWave]
  local nTimeout = tonumber(mWaveCfg.Timeout)
  local lFunc
  SceneMgr:c2gs_call_scene("wave_monster_all_killed")
  if nNowWave >= mMonsterEvent.max_wave then
    local sAirWall = mMonsterEvent.air_wall
    if sAirWall then
      self:set_empty_wall_visible(sAirWall, false)
    end
    mMonsterEvent.end_action = true
    lFunc = {
      {
        "RunFuncModule",
        mWaveCfg.CustomEventName
      },
      {
        "FinishEvent",
        LOGIC_FINISH_CONDITION.KILLALL_MONSTER
      }
    }
  else
    self.m_lMonster[nEvent].add_monster_status = true
    lFunc = {
      {
        "RunFuncModule",
        mWaveCfg.CustomEventName
      },
      {
        "EventAddMonster",
        nEvent
      }
    }
  end
  if nTimeout <= 0 then
    self:RunFuncList(lFunc)
  else
    self:timer_call_out(mWaveCfg.TimeoutKey, function()
      self:RunFuncList(lFunc)
    end, nTimeout)
  end
  local mActionTag = mMonsterEvent.action_tag
  if nNowWave >= mMonsterEvent.max_wave and mActionTag then
    self.m_mMonsterActionTag[mActionTag] = true
    self:on_kill_all_include_monster()
  end
end

function M:on_npc_dead(npc)
  local name = npc:get_local_name()
  if name then
    self:on_npc_dead_event(name)
  end
  for cnt, info in ipairs(self.m_lMonster) do
    local lMonster = info.monster_list
    local nLength = #lMonster
    for i = nLength, 1, -1 do
      if lMonster[i] == npc:get_uuid() then
        _tremove(self.m_lMonster[cnt].monster_list, i)
        local res_id = npc:get_npc_id()
        self:CheckAddMonsterCondition(cnt, nil, res_id)
        break
      end
    end
  end
end

function M:RunFuncList(lFunc)
  for _, info in ipairs(lFunc) do
    self[info[1]](self, _tunpack(info, 2))
  end
end

function M:AddPosKeyNpc(nCamp, nResId, sPosKey, nOffsetX, nOffsetZ, nRotation, sCamp, nLevel, sName, sParams, nGroupId, lBornPos, nMagicId, nAutoLevel)
  local uuid = SceneMgr:get_uuid()
  self:_push_to_need_add(uuid, nCamp, nResId, sPosKey, nOffsetX, nOffsetZ, nRotation, 0, 0, sCamp, nLevel, nil, nGroupId, lBornPos, sName, sParams, nMagicId, nil, nil, nil, nil, nil, nil, nil, nAutoLevel)
  self:_check_add_monster_list()
end

function M:add_server_save_npc(nCamp, nResId, sPosKey, nOffsetX, nOffsetZ, nRotation, sCamp, nLevel, sName, sParams, nGroupId)
  assert(sName, self.m_LogicID)
  local mData = {
    camp = nCamp,
    res_id = nResId,
    pok_key = sPosKey,
    offset_x = nOffsetX,
    offset_z = nOffsetZ,
    rotation = nRotation,
    s_camp = sCamp,
    level = nLevel,
    params = sParams,
    group = nGroupId,
    state = NPC_STATE.LIVE,
    type = SAVE_NPC_TYPE.ORDINARY
  }
  SceneMgr:c2gs_call_scene("add_server_save_npc", sName, mData)
  self:AddPosKeyNpc(nCamp, nResId, sPosKey, nOffsetX, nOffsetZ, nRotation, sCamp, nLevel, sName, sParams, nGroupId)
end

function M:add_server_save_cd_npc(nCamp, config)
  local nResId, sPosKey, nOffsetX, nOffsetZ, nRotation, sCamp, nLevel, sName, nCd, nIgnoreLock = config.ResId, config.PosKey, config.OffsetX, config.OffsetZ, config.Rotation, config.Camp, config.Level, config.NPCName, config.Cd, not config.IgnoreLock
  assert(sName, self.m_LogicID)
  local mData = {
    camp = nCamp,
    res_id = nResId,
    pok_key = sPosKey,
    offset_x = nOffsetX,
    offset_z = nOffsetZ,
    rotation = nRotation,
    s_camp = sCamp,
    level = nLevel,
    cd = nCd,
    state = NPC_STATE.LIVE,
    type = SAVE_NPC_TYPE.CD,
    ignore_lock = nIgnoreLock
  }
  SceneMgr:c2gs_call_scene("add_server_save_npc", sName, mData)
  self:add_cd_pos_key_npc(nCamp, nResId, sPosKey, nOffsetX, nOffsetZ, nRotation, sCamp, nLevel, sName, nCd, nIgnoreLock)
end

function M:RunAction(action_list)
  if not action_list then
    return
  end
  for _, action_config in ipairs(action_list) do
    local actino_type = action_config.Type
    local time, timer_key = tonumber(action_config.Timeout), action_config.TimeoutKey
    local func = ActionFunc.GetActionFunc(actino_type)
    if func then
      if 0 ~= time then
        self:timer_call_out(timer_key, function()
          func(self, action_config)
        end, time)
      else
        func(self, action_config)
      end
    else
      Log.Error("not find behavior func type:" .. actino_type)
    end
  end
end

function M:RunConditionAction(mEvent)
  local sVariable = mEvent.FinishMarkVariable
  if sVariable and "" ~= sVariable then
    self:SetCustomVariable(sVariable, false, mEvent.ValidInTower)
  end
  self:RunAction(mEvent.Actions)
end

function M:GetVariable(sVariable, is_forever)
  if is_forever then
    return self.m_mSaveForeverVariable[sVariable] ~= nil
  end
  local sync_val = self:get_sync_var(sVariable)
  if nil ~= sync_val then
    return sync_val
  else
    return self.m_mSaveVariable and self.m_mSaveVariable[sVariable] and true or false
  end
end

function M:CheckCondition(mEvent, bSetVariable, ignore_set_custom_variable)
  local sVariable = mEvent.ConditionVariable
  if sVariable and "" ~= sVariable then
    local bNotCondition = mEvent.IsNotCondition
    local bIsForeverVariable = mEvent.IsForeverVariable
    local bVal = self:GetVariable(sVariable, bIsForeverVariable)
    if bNotCondition and bVal or not bNotCondition and not bVal then
      return false
    end
  end
  if not ignore_set_custom_variable then
    self:CheckSetCustomVariable(mEvent)
  end
  return true
end

function M:CheckSetCustomVariable(mEvent)
  local sFinishVariable = mEvent.FinishMarkVariable
  if sFinishVariable and "" ~= sFinishVariable then
    self:SetCustomVariable(sFinishVariable, false, mEvent.ValidInTower)
  end
end

function M:CheckCdNpcHitCnt(nType, nCnt)
  if not nType or nType == LOGIC_HIT_NPC_CNT_TYPE.NOT_RESTRICTIONS then
    return true
  end
  if nType == LOGIC_HIT_NPC_CNT_TYPE.ODD_NUMBER then
    return 0 ~= nCnt % 2
  elseif nType == LOGIC_HIT_NPC_CNT_TYPE.EVEN_NUMBER then
    return 0 == nCnt % 2
  end
end

function M:CheckMuiltFuncNpcInteractEnd(sNpcName)
  local lEvent = self:GetEventCfg(LOGIC_EVENT.MULTI_FUNC_NPC_INTERACT_END)
  if not lEvent then
    return
  end
  local oInteractFuncNpc = SceneMgr:GetBattlePlayer():GetComponent("InteractFuncNpc")
  for _, mEvent in ipairs(lEvent) do
    if self:CheckCondition(mEvent) then
      for _, Info in ipairs(mEvent.ConditionActions) do
        if oInteractFuncNpc:CheckInteractByList(Info.FuncNpcList, sNpcName) then
          self:RunConditionAction(Info)
        end
      end
    end
  end
end

function M:random_add_monster_event(mRandomData)
  local nKey = mRandomData.RandomIndex
  self:AddMonsterEvent(mRandomData.RandomMonsterCfgList[nKey])
end

function M:BanAddAreaKey(sKey)
  self.m_mBanAreaKey[sKey] = true
end

function M:CancelBanAreaKey(sKey)
  self.m_mBanAreaKey[sKey] = nil
end

function M:AddMachineGroup(nGroupID)
  local mMachineData = ShareRes.get_machine_group_config(nGroupID)
  if not mMachineData then
    Log.Error(string.format("缺少机关分组配置, logic:%s , 分组ID:%s", self.m_LogicID, nGroupID))
    return
  end
  for _, map in pairs(mMachineData.unitList) do
    local nLevel = map.Level
    local nAutoLevel = map.AutoLevel
    if nAutoLevel and 0 ~= nAutoLevel then
      nLevel = self:GetTowerMonsterLevel("MonLevel" .. nAutoLevel)
    end
    self:AddPosKeyNpc(LOGIC_OTHER_PARAMETER.NPC_CAMP, map.UnitID, map.InitPos, map.OffSetX, map.OffSetZ, map.Rotate, map.Camp, nLevel, map.UnitKey, nil, nGroupID, map.BornPos, map.MagicId, nAutoLevel)
  end
end

function M:SetCustomVariable(sVariable, bTemp, bTower)
  if self.m_mListenVariable[sVariable] then
    local errmsg = string.format("----%s--===出现设置变量套娃===--%s----", self.m_LogicID, sVariable, debug.traceback())
    Log.Error(errmsg)
    return
  end
  self.m_mSaveVariable[sVariable] = {temp = bTemp, tower = bTower}
  SceneMgr:c2gs_call_scene("set_custom_variable", sVariable, bTemp, bTower)
  self.m_mListenVariable[sVariable] = true
  self:on_set_variable_event()
end

function M:SetForeverVariable(sVariable)
  self.m_mSaveForeverVariable[sVariable] = true
  SceneMgr:c2gs_call_scene("set_forever_variable", sVariable)
  self:on_set_variable_event()
end

function M:GetMonsterEventCount(mCondition)
  for _, wave_data in pairs(mCondition) do
    local mMonsterData = ResHelper.SceneLogic.GetMonsterData(wave_data.Id)
    for _, monster_data in pairs(mMonsterData.unitList) do
      if not monster_data.IsNoUse then
        self.m_nMonsterCount = self.m_nMonsterCount + 1
      end
    end
  end
end

function M:RandomMonsterEvent(RandomMonsterCfgList)
  local mRandom = {}
  local iSumPba = 0
  for event_index, info in pairs(RandomMonsterCfgList) do
    mRandom[event_index] = info.Weight
    iSumPba = iSumPba + info.Weight
  end
  local iRnd = math.random(iSumPba)
  local iSum = 0
  local nEventIndex
  for k, v in pairs(mRandom) do
    iSum = iSum + v
    if iRnd <= iSum then
      nEventIndex = k
      break
    end
  end
  local mRefresh = RandomMonsterCfgList[nEventIndex]
  return nEventIndex, mRefresh
end

function M:_run_action_event(event_type)
  local lEvent = self:GetEventCfg(event_type)
  if not lEvent then
    return false
  end
  for _, event in ipairs(lEvent) do
    if self:CheckCondition(event) then
      self:RunAction(event.Actions)
    end
  end
  return true
end

function M:_run_condition_event(event_type, condition_func, ...)
  local lEvent = self:GetEventCfg(event_type)
  local has_match_event = false
  if not lEvent then
    return false, has_match_event
  end
  for _, event in ipairs(lEvent) do
    if self:CheckCondition(event) then
      for _, condition_action_config in pairs(event.ConditionActions) do
        if condition_func(condition_action_config, ...) then
          has_match_event = true
          self:RunConditionAction(condition_action_config)
        end
      end
    end
  end
  return true, has_match_event
end

function M:_run_state_event(event_type, filed_name, visible)
  local lEvent = self:GetEventCfg(event_type)
  if not lEvent then
    return false
  end
  for _, event in ipairs(lEvent) do
    if self:CheckCondition(event) and nil ~= event[filed_name] and event[filed_name] == visible then
      self:RunAction(event.Actions)
    end
  end
  return true
end

function M:run_event(event_name, ...)
  if not self[event_name] then
    Log.Error("scene logic runner没有实现事件", event_name)
    return
  end
  return self[event_name](self, ...)
end

function M:get_save_variable()
  local mData = {
    save_variable = self.m_mSaveVariable
  }
  return mData
end

function M:load_variable(data)
  if not data then
    return
  end
  if data.save_variable then
    self.m_mSaveVariable = data.save_variable
  end
end

function M:release()
  Base.release(self)
  if TowerMgr and TowerMgr:get_tower() then
    self:on_leave()
  end
  if CaptureMgr:is_initialized() then
    CaptureMgr:release_manager()
  end
  self.v_wait_check_add_monster_params = nil
  self:remove_all_spawner_behavior()
end

function M:kill_all_monster()
  for cnt in ipairs(self.m_lMonster) do
    self.m_lMonster[cnt].monster_list = {}
  end
  Base.kill_all_monster(self)
end

function M:open_progress_display(mData)
  if self.m_progress_display then
    Log.Error("出现多个进度显示器", self.m_LogicID)
    return
  end
  local speed = assert(mData.UpSpeed)
  self.m_progress_display = {
    run_module_event = mData.RichEventName
  }
  Base.open_progress_display(self, mData.InitValue, mData.CurrRoomFinalValue, mData.CurrRoomFinalValue, mData.UpSpeed, mData.IsNeedAnimation, mData.UpInterval, mData.StyleIndex)
end

function M:close_progress_display(is_need_anim)
  Base.close_progress_display(self, is_need_anim)
  self.m_progress_display = nil
end

function M:add_progress(value, is_timer)
  if not self.m_progress_display then
    return
  end
  Base.update_progress_display(self, value)
end

function M:add_npc_by_pos_key(uuid, self_camp, res_id, pos_key, offset_x, offset_z, rotation, tag_x, tag_y, camp, level, cur_hp, npc_group, lBornPos, sName, sParams, nMagicId, bLookAtRole, nAiGroup, nAiGroupId, is_end_action, is_max_wave, event_key, lock_enemy_list, difficulty_tag, auto_level)
  local args_map = {
    uuid = uuid,
    offset_x = offset_x,
    offset_z = offset_z,
    rotation = rotation,
    camp = camp,
    level = level,
    cur_hp = cur_hp,
    npc_group = npc_group,
    born_pos = lBornPos,
    npc_name = sName,
    params = sParams,
    magic_id = nMagicId,
    is_look_at_role = bLookAtRole,
    ai_group = nAiGroup,
    ai_group_id = nAiGroupId,
    is_end_action = is_end_action,
    is_max_wave = is_max_wave,
    event_key = event_key,
    lock_enemy_list = lock_enemy_list,
    difficulty_tag = difficulty_tag,
    auto_level = auto_level
  }
  return Base.add_npc_by_pos_key(self, self_camp, res_id, pos_key, args_map)
end

function M:on_first_enter()
  if self:GetVariable("first_enter") then
    return
  end
  self:SetCustomVariable("first_enter")
  self:_run_action_event(LOGIC_EVENT.ON_FIRST_ENTER)
end

function M:on_enter()
  self:FinishEvent(LOGIC_FINISH_CONDITION.ENTER_ROOM)
  self:on_first_enter()
  local lEvent = self:GetEventCfg(LOGIC_EVENT.ON_ENTER)
  local bPass = self:is_pass_room()
  if bPass then
    self:open_all_transmit(nil)
  end
  if lEvent then
    for _, event in ipairs(lEvent) do
      local iCamera = bPass and event.PassCamera or event.NoPassCamera
      if iCamera then
        local boNewCfg, bForceSwitch
        if bPass then
          boNewCfg = event.PassCameraIsNewConfig
          bForceSwitch = event.PassForceDepressCameraMode
        else
          boNewCfg = event.NoPassCameraIsNewConfig
          bForceSwitch = event.NoPassForceDepressCameraMode
        end
        self:set_scene_camera(iCamera, nil, boNewCfg, bForceSwitch, event.ForbidCameraBlend)
      end
      if self:CheckCondition(event) then
        if event.Obstacle then
          self:actvie_obstacle(event.Obstacle.Key, event.Obstacle.Tag, true)
        end
        self:RunAction(event.Actions)
      end
    end
  end
  if not bPass and self.m_mEnterMonster then
    self:AddMonsterEvent(self.m_mEnterMonster)
  end
end

local ADD_MONSTER_FRAME_INTERVAL = 2

function M:on_frame()
  self:_run_action_event(LOGIC_EVENT.ON_FRAME)
  if Global.frame_id - self.v_last_add_frame_id > ADD_MONSTER_FRAME_INTERVAL then
    self:_check_add_monster_list()
    self.v_last_add_frame_id = Global.frame_id
  end
end

local function _check_story_end(condition_action_config, story_id)
  return story_id and condition_action_config.StoryId == story_id
end

function M:on_story_end(story_id)
  self:FinishEvent(LOGIC_FINISH_CONDITION.STORY_END, story_id)
  self:_run_condition_event(LOGIC_EVENT.STORY_END, _check_story_end, story_id)
end

local function _check_timeline_end(condition_action_config, name)
  return condition_action_config.TimelineName == name
end

function M:on_timeline_end(timeline_name)
  self:FinishEvent(LOGIC_FINISH_CONDITION.PLAY_TIMELINE_END, timeline_name)
  self:_run_condition_event(LOGIC_EVENT.PLAY_TIMELINE_END, _check_timeline_end, timeline_name)
end

local function _check_timeline_start(condition_action_config, name)
  return condition_action_config.TimelineName == name
end

function M:on_timeline_start(timeline_name)
  self:_run_condition_event(LOGIC_EVENT.ON_TIMELINE_START, _check_timeline_start, timeline_name)
end

local function _check_texture_guide_finish(condition_action_config, group_id)
  return condition_action_config.GroupId == group_id
end

function M:on_texture_guide_finish(group_id)
  self:_run_condition_event(LOGIC_EVENT.TEXTURE_GUIDE_FINISH, _check_texture_guide_finish, group_id)
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  local sAreaKey = area.Key
  self:FinishEvent(LOGIC_FINISH_CONDITION.ENTER_ROOM, sAreaKey)
  self:judge_all_tp(area)
  local lEvent = self:GetEventCfg(LOGIC_EVENT.ENTER_AREA)
  if not lEvent then
    return
  end
  if self.m_mBanAreaKey[sAreaKey] then
    return
  end
  for _, event in ipairs(lEvent) do
    if self:CheckCondition(event) then
      for _, Info in pairs(event.ConditionActions) do
        local sConditionKey = Info.Key
        if not sConditionKey or "" == sConditionKey or sAreaKey == sConditionKey then
          self:RunConditionAction(Info)
          local bRemoveArea = Info.IsRemoveAfterEnter
          if sConditionKey and true == bRemoveArea then
            self:remove_area(sConditionKey, nil, Info.IsRemoveForever)
          end
        end
      end
    end
  end
end

local function _check_leave_area(condition_action_config, area_key)
  local key = condition_action_config.Key
  return not key or "" == key or key == area_key
end

function M:on_leave_area(npc, area)
  if not npc:is_hero() then
    return
  end
  self:_run_condition_event(LOGIC_EVENT.LEAVE_AREA, _check_leave_area, area.Key)
end

local function _check_func_npc_interact_end(condition_action_config, npc_id)
  local result = condition_action_config.NPCId == npc_id or 0 == condition_action_config.NPCId
  return result
end

local function _check_muilt_func_npc_interact_end(condition_action_config, npc_name, interaction_end_func_npc)
  local list = condition_action_config.FuncNpcList
  local is_finish = true
  local is_have = false
  for i, name in pairs(list) do
    if name == npc_name then
      is_have = true
    end
    if not interaction_end_func_npc[name] then
      is_finish = false
      break
    end
  end
  return is_finish and is_have
end

function M:on_func_npc_interact_end(npc_id)
  local npc_name = Global.scene_mgr:get_func_npc_name(npc_id)
  self:FinishEvent(LOGIC_FINISH_CONDITION.INTERACT_NPC, npc_id)
  self:_run_condition_event(LOGIC_EVENT.FINISH_INTERACT_NPC, _check_func_npc_interact_end, npc_id)
  if npc_name then
    self.m_interaction_end_func_npc[npc_name] = true
    self:_run_condition_event(LOGIC_EVENT.MULTI_FUNC_NPC_INTERACT_END, _check_muilt_func_npc_interact_end, npc_name, self.m_interaction_end_func_npc)
  end
end

local function _check_desc_story_end(condition_action_config, desc_story_id)
  return condition_action_config.descStoryId == desc_story_id or 0 == condition_action_config.descStoryId
end

function M:on_desc_story_end(desc_story_id)
  self:_run_condition_event(LOGIC_EVENT.DESC_STORY_CLOSE, _check_desc_story_end, desc_story_id)
end

function M:fight_end(is_win, isPopConfirmTips, tipsValue)
  if self:is_pass_room() then
    return
  end
  if TowerMgr and TowerMgr:check_hero_is_all_die() then
    return
  end
  if nil == is_win then
    is_win = true
  end
  
  local function confirm_cb()
    if FightDataMgr:is_use_default_end_timer() and not self.mSendStopFightTimerRpc then
      self.mSendStopFightTimerRpc = true
      local func = ActionFunc.GetActionFunc(LOGIC_ACTION.STOP_FIGHT_TIMING)
      if func then
        func(self)
      end
    end
    Base.fight_end(self, is_win)
  end
  
  if isPopConfirmTips then
    Util.show_conform_tip(tipsValue, nil, nil, nil, confirm_cb)
  else
    confirm_cb()
  end
end

function M:on_fight_end(is_win)
  self:_run_action_event(self:get_fight_end_event_name())
end

function M:get_fight_end_event_name()
  local lEvent = self:GetEventCfg(LOGIC_EVENT.FIGHT_END)
  if not lEvent then
    return LOGIC_EVENT.FIGHT_END_NEW
  end
  return LOGIC_EVENT.FIGHT_END
end

local function _check_story_begin(condition_action_config, story_id, step_id)
  local _story_id = condition_action_config.StoryId
  local _step_id = condition_action_config.StepId
  return (0 == _story_id or _story_id == story_id) and (0 == _step_id or _step_id == step_id)
end

function M:on_story_begin(story_id, step_id)
  self:FinishEvent(LOGIC_FINISH_CONDITION.STORY_BEGIN, story_id)
  self:_run_condition_event(LOGIC_EVENT.STORY_BEGIN, _check_story_begin, story_id, step_id)
end

function M:on_leave()
  self:_run_action_event(LOGIC_EVENT.ON_LEAVE)
end

local function _check_task_finish(condition_action_config, task_id)
  return 0 == task_id or condition_action_config.TaskId == task_id
end

function M:on_task_finish(taskid)
  self:_run_condition_event(LOGIC_EVENT.FINISH_TASH, _check_task_finish, taskid)
end

local function _check_guide_finish(condition_action_config, guide_id)
  return 0 == guide_id or condition_action_config.GuideID == guide_id
end

function M:on_guide_finished(guide_id)
  self:_run_condition_event(LOGIC_EVENT.ON_GUIDE_FINISHED, _check_guide_finish, guide_id)
end

function M:on_open_rune_ui()
  self:_run_action_event(LOGIC_EVENT.ON_OPEN_RUNE_UI)
end

function M:on_all_item_picked()
  self:_run_action_event(LOGIC_EVENT.ON_ALL_ITEM_PICKED)
end

function M:on_hero_born_anim_finish()
  self:_run_action_event(LOGIC_EVENT.ON_HERO_BORN_ANIM_FINISH)
end

local function _check_cd_npc_hit(condition_action_config, npc_name, hit_count)
  local _npc_name = condition_action_config.NPCName
  local is_name_equal = "" == _npc_name or _npc_name == npc_name
  local hit_type = condition_action_config.HitType
  local is_hit_need_send = false
  if not hit_type or hit_type == LOGIC_HIT_NPC_CNT_TYPE.NOT_RESTRICTIONS then
    is_hit_need_send = true
  end
  if hit_type == LOGIC_HIT_NPC_CNT_TYPE.ODD_NUMBER then
    is_hit_need_send = 0 ~= hit_count % 2
  elseif hit_type == LOGIC_HIT_NPC_CNT_TYPE.EVEN_NUMBER then
    is_hit_need_send = 0 == hit_count % 2
  end
  return is_name_equal and is_hit_need_send
end

function M:on_cd_npc_hit(npc_name, hit_count)
  local npc = SceneMgr:get_npc_by_name(npc_name)
  local target = Global.hero:get_target()
  if not npc:get_ignore_lock() and (not (npc and Global.hero and target) or npc:get_uuid() ~= target:get_uuid()) then
    return
  end
  self:_run_condition_event(LOGIC_EVENT.ON_HIT_NPC, _check_cd_npc_hit, npc_name, hit_count)
end

local function _check_pick_func_npc_all_reward(condition_action_config, npc_id)
  local _npc_id = condition_action_config.NPCId
  return 0 == _npc_id or _npc_id == npc_id
end

function M:on_pick_func_npc_all_reward(npc_id)
  self:_run_condition_event(LOGIC_EVENT.ON_FUNC_NPC_PICK_ALL_REWARD, _check_pick_func_npc_all_reward, npc_id)
end

function M:on_npc_removed(obj)
end

function M:on_chapter_node_continue(node_id)
  SceneMgr:c2gs_call_scene("chapter_node_continue", node_id)
  self:_run_action_event(LOGIC_EVENT.ON_CHAPTER_NODE_CONTINUE)
  if Util.is_more_than_zero(node_id) and Global.camera then
    Global.camera:change_switch_scene_processing_bg(node_id)
  end
  BattleTaskMgr:clear_node_task_map()
end

function M:on_npc_choose(chooseId, sEventPath)
  assert(sEventPath)
  local cfg = ShareRes.create("scene_event_logic." .. sEventPath)
  for _, data in pairs(cfg.Events) do
    local nType = data.Type
    if nType == LOGIC_EVENT.ON_NPC_CHOOSE and self:CheckCondition(data) then
      local mChooseEvent = assert(data.ConditionActions[chooseId], chooseId)
      if mChooseEvent.IsValid then
        self:RunAction(mChooseEvent.Actions)
      end
    end
  end
end

local function _check_reversible_timeline_end(condition_action_config, timeline_name)
  return condition_action_config.TimelineName == timeline_name
end

function M:on_reversible_timeline_end(timeline_name)
  self:_run_condition_event(LOGIC_EVENT.ON_REVERSIBLE_TIMELINE_END, _check_reversible_timeline_end, timeline_name)
end

local function _check_play_video_end(condition_action_config, video_name)
  return condition_action_config.VideoName == video_name
end

function M:in_play_video_end(video_name)
  self:_run_condition_event(LOGIC_EVENT.IN_PLAY_VIDEO_END, _check_play_video_end, video_name)
end

local function _check_scene_timeline_end(condition_action_config, timeline_name)
  return condition_action_config.TimelineName == timeline_name
end

function M:on_scene_timeline_end(timeline_name)
  self:_run_condition_event(LOGIC_EVENT.PLAY_SCENE_TIMELINE_END, _check_scene_timeline_end, timeline_name)
end

local function _check_tp_revive_room(condition_action_config, archive_num)
  return not archive_num or condition_action_config.ArchiveNumber == archive_num
end

function M:on_tp_revive_room()
  local archive_num = SceneMgr:get_archive_num()
  if not archive_num then
    return
  end
  SceneMgr:set_archive_num()
  local success = self:_run_condition_event(LOGIC_EVENT.ON_RESET_REVIVE, _check_tp_revive_room, archive_num)
  if success then
    self:SetCustomVariable("first_enter")
  end
end

function M:on_kill_all_include_monster()
  local lEvent = self:GetEventCfg(LOGIC_EVENT.ON_KILL_ALL_INCLUDE_MONSTER)
  if not lEvent then
    return
  end
  local mFinishMonsterTag = self.m_mMonsterActionTag
  for _, event in ipairs(lEvent) do
    if self:CheckCondition(event) then
      for _, Info in pairs(event.ConditionActions) do
        local mActionTag = Info.ActionTagMap
        local boExec = true
        for _, sMonsterTag in pairs(mActionTag) do
          if not mFinishMonsterTag[sMonsterTag] then
            boExec = false
            break
          end
        end
        if boExec then
          self:RunConditionAction(Info)
        end
      end
    end
  end
end

function M:on_display_progress_end()
  if not self.m_progress_display then
    return
  end
  local sModule = self.m_progress_display.run_module_event
  if sModule then
    self:RunFuncModule(sModule)
  end
  self.m_progress_display = nil
end

local function _check_collection_close(condition_action_config, collection_id)
  return condition_action_config.CollectionId == collection_id
end

function M:on_collection_close(collection_id)
  self:_run_condition_event(LOGIC_EVENT.ON_COLLECTION_CLOSE, _check_collection_close, collection_id)
end

local function _check_npc_dead_event(condition_action_config, npc_name)
  return condition_action_config.NPCName == npc_name
end

function M:on_npc_dead_event(sName)
  self:_run_condition_event(LOGIC_EVENT.ON_NPC_DEAD, _check_npc_dead_event, sName)
end

local function _check_set_variable_condition(condition_action_config)
end

function M:on_set_variable_event()
  self:_run_condition_event(LOGIC_EVENT.ON_VARIABLE_EVENT, function(condition_action_config)
    local condition_variable_list = condition_action_config.ConditionVariableList
    if not condition_variable_list or #condition_variable_list <= 0 then
      return false
    end
    for _, variable in pairs(condition_variable_list) do
      if not self:GetVariable(variable) then
        return false
      end
    end
    return true
  end)
end

function M:on_level_counter_add(key, add_type)
  local event_list = self.m_mEvent[LOGIC_EVENT.LEVLE_COUNTER_EVENT]
  if not event_list then
    return
  end
  local condition_action
  for i, event_data in pairs(event_list) do
    local condition_actions = event_data.ConditionActions
    local is_hava = false
    if condition_actions and #condition_actions > 0 then
      for i, condition in pairs(condition_actions) do
        if condition.Key == key then
          is_hava = true
          condition_action = condition
          break
        end
      end
    end
    if is_hava then
      break
    end
  end
  if not condition_action then
    return
  end
  local need_type_list = condition_action.ConditionVariableList
  if not need_type_list or 0 == #need_type_list then
    return
  end
  local curr_type_list = self.m_level_counter_list[key]
  if not curr_type_list then
    self.m_level_counter_list[key] = {}
    curr_type_list = self.m_level_counter_list[key]
  end
  table.insert(self.m_level_counter_list[key], add_type)
  local is_finish = true
  if #need_type_list ~= #self.m_level_counter_list[key] then
    if not condition_action.IsEveryStepCheck then
      return
    end
    is_finish = false
  end
  local is_success = true
  for i, v in ipairs(curr_type_list) do
    if need_type_list[i] ~= v then
      is_success = false
      break
    end
  end
  if is_success then
    if is_finish then
      self:RunFuncModule(condition_action.SuccessEvent)
    end
  else
    self:RunFuncModule(condition_action.FailEvent)
  end
end

function M:on_level_counter_clear(key)
  self.m_level_counter_list[key] = nil
end

function M:on_kill_monster_reach(event_name)
  self:RunFuncModule(event_name)
end

function M:on_finger_drag_end(event_name)
  self:RunFuncModule(event_name)
end

function M:on_ct_timer_end(event_name)
  self:RunFuncModule(event_name)
end

local function _check_task_condition_reach_event(condition_action_config, condition_id)
  return condition_action_config.ConditionId == condition_id
end

function M:on_task_condition_reach(condition_id)
  self:_run_condition_event(LOGIC_EVENT.ON_TASK_CONDITION_REACH_EVENT, _check_task_condition_reach_event, condition_id)
end

function M:play_pre_fight_story()
  local lEvent = self:GetEventCfg(LOGIC_EVENT.PRE_FIGHT_STORY)
  if not lEvent then
    return
  end
  local story_id, play_story_suc
  for _, event in ipairs(lEvent) do
    if self:CheckCondition(event) and (event.RepeatExecute or not self:GetVariable("first_enter")) then
      story_id = event.StoryID
      if story_id ~= ShareRes.get_comm_value("CreateAccountStory") or NewbieTowerMgr:need_read_story() then
        if Util.is_more_than_zero(story_id) then
          play_story_suc = true
        end
        self:RunAction(event.Actions)
      end
    end
  end
  return play_story_suc
end

local function _custom_death_event(action_config, death_type, has_match_type)
  local CUSTOM_DEATH_EVENT_TYPE = CommDefine.CUSTOM_DEATH_EVENT_TYPE
  if not has_match_type and action_config.DeathType == CUSTOM_DEATH_EVENT_TYPE.DEFAULT then
    death_type = CUSTOM_DEATH_EVENT_TYPE.DEFAULT
  end
  local result = action_config.DeathType == death_type
  if result then
    BehaviorShareMgr:set_sync_var("death_event_type", death_type)
    SceneMgr:c2gs_call_scene("set_dead_event_type", death_type)
  end
  return result
end

function M:custom_death_event(death_type)
  local lEvent = self:GetEventCfg(LOGIC_EVENT.CUSTOM_DEATH_EVENT)
  local has_match_type = false
  if death_type and lEvent then
    for _, event in ipairs(lEvent) do
      if self:CheckCondition(event) then
        for _, condition_action_config in pairs(event.ConditionActions) do
          if condition_action_config.DeathType == death_type then
            has_match_type = true
            break
          end
        end
      end
    end
  end
  return self:_run_condition_event(LOGIC_EVENT.CUSTOM_DEATH_EVENT, _custom_death_event, death_type, has_match_type)
end

function M:get_need_statistics_npc_id_map()
  return self.m_need_statistics_npc_id_map
end

function M:refresh_need_statistics_npc_id_map(list)
  self.m_need_statistics_npc_id_map = list
end

function M:on_treasure_chest_open(event_name)
  self:RunFuncModule(event_name)
end

function M:refresh_treasure_chest_guide()
  local tower_progress = TowerMgr:get_tower_progress()
  if not tower_progress or not ChapterMgr:check_episode_complete(tower_progress.episode_id) then
    return
  end
  local is_open_box_guide = BattleSettingMgr:load_treasure_chest_guide_state()
  self:on_treasure_chest_guide_state_update(is_open_box_guide)
end

function M:on_treasure_chest_guide_state_update(state)
  BattleSettingMgr:save_treasure_chest_guide_state(state)
  local event_type = state and LOGIC_EVENT.TREASURE_CHEST_GUIDE_OPEN_EVENT or LOGIC_EVENT.TREASURE_CHEST_GUIDE_CLOSE_EVENT
  self:_run_action_event(event_type)
end

local function check_mini_game_finish(action_config, game_type, game_id)
  return action_config.GameType == game_type and action_config.GameID == game_id
end

function M:on_mini_game_finish(game_type, game_id)
  local event_type = LOGIC_EVENT.ON_MINI_GAME_FINISH
  self:_run_condition_event(event_type, check_mini_game_finish, game_type, game_id)
end

function M:on_spawner_unit_clear(event_name)
  self:RunFuncModule(event_name)
end

local SpawnType = {
  Cyclic = 1,
  AssignKind = 2,
  TimeInterval = 3
}
local SpawnerBehaviorPath = {
  [SpawnType.Cyclic] = "manager.scene.spawner.unit_spawner_cyclic",
  [SpawnType.AssignKind] = "manager.scene.spawner.unit_spawner_assign_kind",
  [SpawnType.TimeInterval] = "manager.scene.spawner.unit_spawner_time_interval"
}

function M:add_spawner_behavior(config)
  local path = SpawnerBehaviorPath[config.SpawnType]
  if path then
    local behavior = require(path)
    local instance = behavior:new(self, config)
    self.v_spawner_behaviors[#self.v_spawner_behaviors + 1] = instance
  end
end

function M:remove_spawner_behavior(instance)
  if instance then
    for i = 1, #self.v_spawner_behaviors do
      if self.v_spawner_behaviors[i] == instance then
        self.v_spawner_behaviors[i]:on_destroy()
        table.remove(self.v_spawner_behaviors, i)
        break
      end
    end
  end
end

function M:remove_all_spawner_behavior()
  for i = #self.v_spawner_behaviors, 1, -1 do
    self.v_spawner_behaviors[i]:on_destroy()
    self.v_spawner_behaviors[i] = nil
  end
end

return M
