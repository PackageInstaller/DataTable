local Base = require("gamelogic.activity.activity")
local M = Util.create_child_mt(Base)
local CommonDefine = require("cs_share.common_define")

function M:_init(activity_id, config_id)
  self.v_curse_ring_cfg = ShareRes.create("activity.curse_ring_main", config_id)
  assert(self.v_curse_ring_cfg, "read curse_ring_main failure! config_id= " .. config_id)
  Base._init(self, activity_id, self.v_curse_ring_cfg.ActyTimeId)
  self.v_is_end = false
  self:sys_mq_bind(Const.MSG_FIGHT_CNT_TIPS_FINISH, self._response_time_finish, self)
end

function M:_response_time_finish(msg)
  local fight_info = TowerMgr:get_fight_info()
  if not fight_info or fight_info.type ~= CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
    return
  end
  local tip_cfg = ShareRes.create("scene.scene_tips", msg.mm_x)
  local fight_tips_type = CommonDefine.FIGHT_TIPS_TYPE
  if tip_cfg.Type == fight_tips_type.TIMER then
    self.v_is_end = true
  end
end

function M:get_game_id()
  return self.v_curse_ring_cfg.Id
end

function M:get_activity_progress()
  local cur = ChallengeRingPlusMgr:get_acty_level() or 0
  local total = UtilTable.hash_lenth(self.v_curse_ring_cfg.EpisodeIds)
  return string.format("%s/%s", cur, total)
end

function M:is_end()
  return self.v_is_end
end

function M:reset_state()
  self.v_is_end = false
end

return M
