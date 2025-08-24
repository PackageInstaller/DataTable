local Base = require("obj.functional_npc.functional_npc")
local EFFECT = {idle = 1, skill1_1 = 2}
local M = Util.create_child_mt(Base)

function M:player_anim(anim_type, end_cb)
  if "idle" == anim_type then
    self:play_effect(EFFECT.idle)
  elseif "interact" == anim_type then
    if not self.v_effect_cb then
      function self.v_effect_cb()
        self.v_effect_cb = nil
        
        local npc_data = self.data
        local npc_id = npc_data.npc_id
        self:create_drop_item(function()
          SceneMgr:c2gs_call_scene("on_func_npc_interact_end", npc_id)
          BehaviorMgr:call_scene_logic_event_fun("on_func_npc_interact_end", npc_id)
        end)
        local msg = MsgGame:mq_publish2(Const.MSG_ON_NORMAL_DROP_NPC_CREATE_ITEM_END)
        msg.mm_x = npc_id
      end
    end
    self:remove_effect(EFFECT.idle)
    self:play_effect(EFFECT.skill1_1, self.v_effect_cb)
  end
end

function M:is_normal_drop_npc()
  return true
end

function M:on_destroy_luaobj()
  Base.on_destroy_luaobj(self)
  if self.v_effect_cb then
    self.v_effect_cb()
  end
end

return M
