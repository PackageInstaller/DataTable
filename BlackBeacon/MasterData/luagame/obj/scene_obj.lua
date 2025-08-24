local Base = require("obj.char")
local Layer = require("utils.layer")
local SHADOW_PATH = "Fx_Common_Shadow"
local CircleCollider = require("manager.fight.collider.circle")
local Effect_Name = {
  idle = "Fx_T3002001_idel_1",
  arder_idle = "Fx_T3002001_arder_idel_1",
  skill1_1 = "Fx_T3002001_skill1_1_1"
}
local M = Util.create_child_mt(Base)

function M:_init(...)
  Base._init(self, ...)
end

function M:presetup(...)
  Base.presetup(self, ...)
  self:add_component("state_manager", require("obj.state.manager.npc_state_manager"):new(self))
end

function M:on_init_gameobj(...)
  Base.on_init_gameobj(self, ...)
  self.v_simple_shadow = ResMgr:load_gameobj(Path.get_res_path(SHADOW_PATH))
  self.v_simple_shadow.transform:SetParent(self.transform)
  self:set_layer(Layer.Layer.NPC)
  local clips = self.animator.runtimeAnimatorController.animationClips
  self.v_clip_list = {}
  if clips.Length > 0 then
    for i = 0, clips.Length - 1 do
      self.v_clip_list[clips[i].name] = clips[i].length
    end
  end
  self.v_effect_list = {}
  for state_name, effect_name in pairs(Effect_Name) do
    self.v_effect_list[state_name] = Util.get_child_gameobj(effect_name, self.gameobj)
  end
  self.v_end_cb = {}
end

function M:update()
  Base.update(self)
end

function M:is_godmode()
  return true
end

function M:on_destroy()
  Base.on_destroy(self)
  for _, v in pairs(self.v_end_cb) do
    Timer:remove_timer(v)
  end
  self.v_end_cb = nil
  ResMgr:destroy_gameobj(self.v_simple_shadow)
end

function M:has_part()
  return false
end

function M:is_can_searched()
  return false
end

function M:is_scene_obj()
  return true
end

function M:player_anim(anim_type, is_get, cb)
  self:_play_treasure_ani(anim_type, is_get, cb)
end

function M:_play_treasure_ani(anim_type, is_get, cb)
  if "idle" == anim_type then
    if is_get then
      self:_play("arder_idle")
    else
      self:_play("idle")
    end
  elseif "interact" == anim_type then
    self:_play("skill1_1", function()
      self:player_anim("idle", true)
      cb()
    end)
  end
end

function M:_play(ani_type, end_cb)
  for state_name, effect_obj in pairs(self.v_effect_list) do
    effect_obj:SetActive(state_name == ani_type)
  end
  self.animator:Play(ani_type, -1, 0.0)
  if end_cb then
    local len = self.v_clip_list[ani_type]
    if not len or 0 == len then
      return
    end
    if self.v_end_cb[ani_type] then
      Timer:remove_timer(self.v_end_cb[ani_type])
      self.v_end_cb[ani_type] = nil
    end
    self.v_end_cb[ani_type] = Timer:add_timer(ani_type, len, function()
      end_cb()
    end)
  end
end

function M:get_in_global_scale()
  return false
end

return M
