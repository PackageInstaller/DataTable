local M = Util.create_class()

function M:_init()
  set_ui_object_visible("fight", "Btn_skillTower", false)
  self.stage_skill_id = 300103701
end

function M:on_input(input_id)
  if 60 == input_id then
    if get_npc_cd_charge(self.npc, self.stage_skill_id) >= get_skill_cfg(self.stage_skill_id).CdChargePerCost then
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, self.stage_skill_id)
    else
      cast_magic(self.npc, self.npc, 100181, 0)
    end
  end
end

return M
