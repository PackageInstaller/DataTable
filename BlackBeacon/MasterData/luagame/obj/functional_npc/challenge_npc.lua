local Base = require("obj.functional_npc.functional_npc")
local CHALLENGE_EFFECT = {
  FIRST_EFFECT = 1,
  SECOND_EFFECT = 2,
  THIRD_EFFECT = 3,
  FOURTH_EFFECT = 4
}
local M = Util.create_child_mt(Base)

function M:_init(...)
  self.v_effect_timer = {}
  self.v_scene_effect_list = {}
  Base._init(self, ...)
end

function M:presetup(...)
  Base.presetup(self)
end

function M:setup(...)
  Base.setup(self, ...)
end

function M:on_init_gameobj(...)
  Base.on_init_gameobj(self, ...)
end

function M:update()
  Base.update(self)
end

function M:on_destroy_luaobj()
  if self.v_effect_timer ~= nil then
    for _, v in pairs(self.v_effect_timer) do
      Timer:remove_timer(v)
    end
  end
  self.v_effect_timer = nil
  self:remove_challenge_effect()
  self.v_scene_effect_list = nil
  Base.on_destroy_luaobj(self)
end

function M:on_destroy()
  Base.on_destroy(self)
end

function M:player_anim(anim_type, end_cb, ignore_effect)
  if "idle" == anim_type then
    self:_play(anim_type, end_cb)
    if self:is_role_npc() then
      return
    end
    self:play_effect(CHALLENGE_EFFECT.FIRST_EFFECT)
    self:play_effect(CHALLENGE_EFFECT.FOURTH_EFFECT)
  else
    self:_play(anim_type, end_cb)
    if ignore_effect then
      return
    end
    if self:is_role_npc() then
      return
    end
    local len = self.v_clip_list[anim_type]
    self:play_effect(CHALLENGE_EFFECT.FIRST_EFFECT)
    if len then
      local function first_cb()
        self:play_effect(CHALLENGE_EFFECT.SECOND_EFFECT)
        
        self:play_scene_effect(CHALLENGE_EFFECT.THIRD_EFFECT)
        self:remove_effect(CHALLENGE_EFFECT.FIRST_EFFECT)
        Timer:remove_timer(self.v_effect_timer[CHALLENGE_EFFECT.FIRST_EFFECT])
      end
      
      self.v_effect_timer[CHALLENGE_EFFECT.FIRST_EFFECT] = Timer:add_timer("play_challenge_effect", len * 0.895, first_cb)
    end
  end
end

function M:on_treasure_chest_open(end_cb)
  local id = self.data.id
  local treasure_chest_cfg = ShareRes.create("episode_box.episode_box", id)
  if treasure_chest_cfg and #treasure_chest_cfg.Effect >= 2 then
    self:play_effect(CHALLENGE_EFFECT.SECOND_EFFECT)
  else
    Log.Info("宝箱没有配置打开特效")
    if end_cb then
      end_cb()
    end
  end
end

function M:on_treasure_chest_close(end_cb)
  local id = self.data.id
  local treasure_chest_cfg = ShareRes.create("episode_box.episode_box", id)
  if treasure_chest_cfg and #treasure_chest_cfg.Effect >= 2 then
    self:play_effect(CHALLENGE_EFFECT.THIRD_EFFECT, end_cb)
  else
    Log.Info("宝箱没有配置关闭特效")
    if end_cb then
      end_cb()
    end
  end
end

function M:play_scene_effect(effect_id, duration)
  if not self.character_cfg.Effect or not self.character_cfg.Effect[effect_id] then
    return
  end
  self.v_scene_effect_list[effect_id] = effect_id
  SceneMgr:create_scene_effect(self.character_cfg.Effect[effect_id], self:get_pos_vec3(), duration, self.character_cfg.Effect[effect_id])
end

function M:remove_scene_effect(effect_id)
  if not (self.character_cfg.Effect and self.character_cfg.Effect[effect_id] and self.v_scene_effect_list) or not self.v_scene_effect_list[effect_id] then
    return
  end
  SceneMgr:remove_scene_effect(self.character_cfg.Effect[effect_id])
end

function M:remove_challenge_effect()
  self:remove_scene_effect(CHALLENGE_EFFECT.THIRD_EFFECT)
end

return M
