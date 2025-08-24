local Base = require("obj.state.state_base")
local M = Util.create_child_mt(Base)

function M:state_on_enter(...)
  Base.state_on_enter(self, ...)
end

function M:state_on_leave()
  Base.state_on_leave(self)
  if self.v_spell_area then
    SpellArea:release(self.v_spell_area)
    self.v_spell_area = nil
    self.v_spell_area_transform = nil
    self.v_pos_target_uuid = nil
    self.v_need_update_angle = nil
  end
end

function M:state_create_skill_area()
  if self.v_need_show_range and not self.v_spell_area then
    local area, need_update_angle, pos_target_uuid = SpellArea:get_spell_area(self.v_owner, self.v_spell_cfg)
    if not area then
      self.v_need_show_range = false
      return
    end
    self.v_spell_area = area
    self.v_spell_area_transform = area.area_obj.transform
    self.v_need_update_angle = need_update_angle
    self.v_pos_target_uuid = pos_target_uuid
    local x, y, z = self.v_owner:get_euler_angles()
    self.v_spell_area_transform:SetEuler(x, y, z)
  end
end

function M:state_update_skill_area()
  if self.v_need_show_range then
    if self.v_spell_area_transform then
      if self.v_need_update_angle then
        local x, y, z = self.v_owner:get_euler_angles()
        self.v_spell_area_transform:SetEuler(x, y, z)
      end
      if self.v_pos_target_uuid then
        local target = Global.scene_mgr:pick_by_uuid(self.v_pos_target_uuid)
        if target then
          local x, y, z = target.transform:getpositionA()
          self.v_spell_area_transform:setpositionA(x, y + 0.3, z)
        end
      end
    else
      self:state_create_skill_area()
    end
  end
end

return M
