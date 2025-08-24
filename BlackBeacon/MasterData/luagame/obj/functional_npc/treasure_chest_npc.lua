local Base = require("obj.functional_npc.functional_npc")
local TREASURE_EFFECT = {
  idle = 1,
  arder_idle = 2,
  skill1_1 = 3
}
local M = Util.create_child_mt(Base)

function M:_init(...)
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
  Base.on_destroy_luaobj(self)
end

function M:on_destroy()
  Base.on_destroy(self)
end

function M:player_anim(anim_type, end_cb)
  local is_get = self.data.is_get
  local npc_data = self.data
  local npc_id = npc_data.npc_id
  if "idle" == anim_type then
    if is_get then
      self:_play("arder_idle")
      self:play_effect(TREASURE_EFFECT.arder_idle)
    else
      self:_play("idle")
      self:play_effect(TREASURE_EFFECT.idle)
    end
  elseif "interact" == anim_type then
    self:_play("skill1_1", function()
      self:create_drop_item(function()
        Util.show_message_tip(2102)
        SceneMgr:c2gs_call_scene("on_func_npc_interact_end", npc_id)
        BehaviorMgr:call_scene_logic_event_fun("on_func_npc_interact_end", npc_id)
      end)
      self:player_anim("idle")
      self:play_effect(TREASURE_EFFECT.idle)
    end)
    self:play_effect(TREASURE_EFFECT.skill1_1)
  end
end

return M
