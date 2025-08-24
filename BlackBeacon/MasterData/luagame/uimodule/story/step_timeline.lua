local Base = require("uimodule.story.step_base")
local M = Util.create_child_mt(Base)
local GEN_CRI_SOURCE_TYPE = {COMMON_AUDIO = 1, TIMELINE_AUDIO = 2}
local NodeGroupName = {Character = "Character", Step = "Step"}

function M:_init(...)
  Base._init(self, ...)
end

function M:on_destroy()
  Base.on_destroy(self)
end

function M:update()
  Base.update(self)
end

function M:start()
  Global.sound_mgr:pause_gen_source(false, GEN_CRI_SOURCE_TYPE.TIMELINE_AUDIO, nil, true)
  local step_cfg = self.v_step_cfg
  if not UtilTable.is_empty(step_cfg.AnimationTrans) then
    for k, animation_transition_data in pairs(step_cfg.AnimationTrans) do
      local simple_node_ref_com = self.v_lua_obj:get_timeline_node_ref_com()
      local node_transform = simple_node_ref_com:GetNodeByName(NodeGroupName.Character, animation_transition_data.CharacterName)
      if not node_transform then
        Log.Error("没有找到<" .. animation_transition_data.CharacterName .. ">的引用")
        self:complete()
        return
      end
      local animator = Util.get_animator(nil, node_transform)
      animator:CrossFadeInFixedTime(animation_transition_data.AnimationStateName, animation_transition_data.transitionTime)
    end
  end
  if step_cfg.TimelineStepName then
    local simple_node_ref_com = self.v_lua_obj:get_timeline_node_ref_com()
    if nil ~= simple_node_ref_com then
      local timeline_step_obj = simple_node_ref_com:GetNodeByName(NodeGroupName.Step, step_cfg.TimelineStepName)
      self.v_lua_obj:next_timeline_step(timeline_step_obj)
    end
  end
  self:complete()
end

return M
