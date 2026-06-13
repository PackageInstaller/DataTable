local M = Util.create_class()
local CommonRole = import("common.role")
local Base = import("character.base.base_role")

function M:_init()
  Base._init(self)
  CommonRole.role_common_init(self)
  self.skill_id = 607000001
  self.hero_list = {
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22),
    get_come_on_hero()
  }
  self.skill_area = {
    type = 1,
    res = "Fx_skillarea_circle_1",
    sizex = 5
  }
  self.skill_indi_cfg = {
    type = 3,
    res = "FX_text_kong",
    sizex = 5,
    sizey = 5
  }
  set_ui_object_visible("fight", "Btn_skill8", true)
end

function M:on_frame()
  CommonRole.indicator_input(self, 60, self.skill_id, nil, self.skill_area, self.skill_indi_cfg, nil, nil, 3)
end

function M:on_input(input_id)
  CommonRole.role_common_on_input(self, input_id, 0)
end

function M:on_touch_up(input_id, iscancle)
  if 60 == input_id and false == iscancle then
    local hero_attr = 0
    for key, value in pairs(self.hero_list) do
      if value then
        hero_attr = hero_attr + get_npc_attr(value, 71)
      end
    end
    hero_attr = math.min(math.max(1, math.floor(hero_attr / 10)), 10)
    cast_missile(self.npc, self.npc, nil, nil, 60700000101, hero_attr)
    cast_missile(self.npc, self.npc, nil, nil, 60700000102, 0)
  end
end

return M
