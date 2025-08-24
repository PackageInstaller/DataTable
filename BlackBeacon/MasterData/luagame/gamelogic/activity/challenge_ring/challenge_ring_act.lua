local Base = require("gamelogic.activity.activity")
local CommonDefine = require("cs_share.common_define")
local M = Util.create_child_mt(Base)
local STAGE_STATE = {
  LOCK = 1,
  CHALLENGE = 2,
  PASS = 3
}

function M:_init(activity_id, config_id)
  self.v_stage_info = {}
  self.v_skills = {}
  self.v_hero_skills = {}
  self.v_stage_cfg = ShareRes.create("activity.challenge_ring_main", config_id)
  if not self.v_stage_cfg then
    Log.Error("read best_config_fight_main failure! config_id=", config_id)
    return
  end
  Base._init(self, activity_id, self.v_stage_cfg.ActyTimeId)
  self.v_is_end = false
  self:sys_mq_bind(Const.MSG_FIGHT_CNT_TIPS_FINISH, self._response_time_finish, self)
end

function M:_response_time_finish(msg)
  local fight_info = TowerMgr:get_fight_info()
  if not fight_info or fight_info.type ~= CommonDefine.CHALLENGE_TYPE.CHALLENGE_RING then
    return
  end
  local tip_cfg = ShareRes.create("scene.scene_tips", msg.mm_x)
  local fight_tips_type = CommonDefine.FIGHT_TIPS_TYPE
  if tip_cfg.Type == fight_tips_type.TIMER then
    self.v_is_end = true
  end
end

function M:sync_best_conf_tower_list(data)
  for _, v in pairs(data.chal_ring_epis) do
    self.v_stage_info[v.id] = v
  end
end

function M:sync_best_conf_tower_data(data)
  self.v_stage_info[data.chal_ring_epi.id] = data.chal_ring_epi
  ChallengeRingMgr:change_now_ring()
  MsgGame:mq_publish2(Const.MSG_ON_UPDATE_CR_TOWER_INFO)
end

function M:get_game_id()
  return self.v_stage_cfg.Id
end

function M:get_activity_progress()
  local cur = 0
  local total = 0
  for _, v in pairs(self.v_stage_cfg.EpisodeIds) do
    total = total + 1
    if self:get_stage_state(v) == STAGE_STATE.PASS then
      cur = cur + 1
    end
  end
  return string.format("<color=#fff0d5>%s</color>/%s", cur, total)
end

function M:get_pass_level_amount()
  if next(self.v_stage_info) == nil then
    return
  end
  return UtilTable.hash_lenth(self.v_stage_info)
end

function M:get_stage_info(stage_id)
  return self.v_stage_info[stage_id]
end

function M:get_stage_score(stage_id)
  if self.v_stage_info[stage_id] then
    return self.v_stage_info[stage_id].history_max_score
  end
  return 0
end

function M:get_stage_state(stage_id)
  if self.v_stage_info[stage_id] then
    if self.v_stage_info[stage_id].complete then
      return STAGE_STATE.PASS
    end
    return STAGE_STATE.CHALLENGE
  end
  return STAGE_STATE.LOCK
end

function M:get_total_stage_info()
  return self.v_stage_info
end

function M:_get_consu_amount(stage_id, buddy_id)
  if not buddy_id then
    return 0
  end
  if not self.v_skills[stage_id] then
    return 0
  end
  if not self.v_skills[stage_id][buddy_id] then
    return 0
  end
  local num = 0
  for _, v in pairs(self.v_skills[stage_id][buddy_id]) do
    local cfg = ShareRes.create("activity.best_config_fight_skill", v)
    num = num + cfg.PointPrice
  end
  return num
end

function M:get_hero_skill_list(stage_id, buddy_id)
  if not buddy_id then
    return {}
  end
  if not self.v_skills[stage_id] then
    return {}
  end
  if not self.v_skills[stage_id][buddy_id] then
    return {}
  end
  return self.v_skills[stage_id][buddy_id]
end

function M:is_end()
  return self.v_is_end
end

function M:reset_state()
  self.v_is_end = false
end

return M
