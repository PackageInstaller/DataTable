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
  self.v_stage_cfg = ShareRes.create("activity.best_config_fight_main", config_id)
  self.v_stage_list_cfg = ShareRes.create("activity.best_config_fight_episode")
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
  if not fight_info or fight_info.type ~= CommonDefine.CHALLENGE_TYPE.BEST_CONF then
    return
  end
  local tip_cfg = ShareRes.create("scene.scene_tips", msg.mm_x)
  local fight_tips_type = CommonDefine.FIGHT_TIPS_TYPE
  if tip_cfg.Type == fight_tips_type.TIMER then
    self.v_is_end = true
  end
end

function M:sync_best_conf_tower_list(data)
  for _, v in pairs(data.best_conf_epis) do
    self.v_stage_info[v.id] = v
  end
end

function M:sync_best_conf_tower_data(data)
  self.v_stage_info[data.best_conf_epi.id] = data.best_conf_epi
end

function M:request_set_best_conf_skill(epi_id, buddy_id, skill_ids)
  local send_data = {
    epi_id = epi_id,
    buddy_id = buddy_id,
    skill_ids = skill_ids
  }
  Network:call("c2gs_set_best_conf_skill", send_data, function(ok, resp)
    if true == ok and 0 == resp.errcode then
      if not self.v_skills[epi_id] then
        self.v_skills[epi_id] = {}
      end
      self.v_skills[epi_id][buddy_id] = {}
      for _, v in pairs(skill_ids) do
        self.v_skills[epi_id][buddy_id][v] = v
      end
      Util.show_message_tip(2046)
      MsgGame:mq_publish2(Const.MSG_HERO_SKILL_UPDATE)
    end
  end)
end

function M:request_get_best_conf_skill(epi_id)
  Network:call("c2gs_get_best_conf_skill", {epi_id = epi_id}, function(ok, resp)
    if true == ok and 0 == resp.errcode then
      self.v_skills[epi_id] = {}
      for _, v in pairs(resp.skill_ids) do
        local cfg = ShareRes.create("activity.best_config_fight_skill", v)
        if not self.v_skills[epi_id][cfg.BuddyId] then
          self.v_skills[epi_id][cfg.BuddyId] = {}
        end
        self.v_skills[epi_id][cfg.BuddyId][v] = v
      end
      MsgGame:mq_publish2(Const.MSG_HERO_SKILL_UPDATE)
    end
  end)
end

function M:request_get_survival_score(stage_id)
  Network:call("c2gs_fs_get_best_conf_special_score", {}, function(ok, resp)
    if true == ok and 0 == resp.errcode then
      self.v_stage_info[stage_id].survival_score = resp.sur_score
      self.v_stage_info[stage_id].kill_score = resp.kill_score
      MsgGame:mq_publish2(Const.MSG_TOP_VER_SCORE_UPDATE)
    end
  end)
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
  return string.format("<color=#fff0d5>%s</color>/%s", cur, total), cur, total
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

function M:get_remain_skill_point(stage_id, pos_idx, buddy_id)
  local cfg = self.v_stage_list_cfg[stage_id]
  if not cfg then
    Log.Error("read best_config_fight_episode failure! stage_id=", stage_id)
    return
  end
  return cfg.Point[pos_idx] - self:_get_consu_amount(stage_id, buddy_id)
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
