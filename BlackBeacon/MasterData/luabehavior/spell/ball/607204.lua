local M = Util.create_class()

function M:_init()
  self.room = 0
  self.count = 0
end

function M:creat_magic()
  if 0 == self.room then
    return
  end
  if is_pass_room() then
    self.count = self.count + 1
    local npc1 = get_come_on_hero()
    cast_magic(npc1, npc1, 60720401, 1)
    if get_scene_hero_by_poskey(21) then
      local npc2 = get_scene_hero_by_poskey(21)
      cast_magic(npc2, npc2, 60720401, 1)
    end
    if get_scene_hero_by_poskey(22) then
      local npc3 = get_scene_hero_by_poskey(22)
      cast_magic(npc3, npc3, 60720401, 1)
    end
    self.room = 0
  end
end

function M:on_room_change(npc)
  self.room = 0
  if not is_pass_room() then
    self.room = 1
  end
end

function M:on_frame()
  self:creat_magic()
end

function M:on_frame_background()
  self:creat_magic()
end

return M
