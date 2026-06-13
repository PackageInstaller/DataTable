local M = Util.create_class()

function M:_init()
  self.is_enhance_condition = 0
  self.now_time = 0
  self.bonus_time = 0
  self.target = nil
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 12, nil, 1)
end

function M:on_frame()
  self:search_target()
  if self.npc == nil then
    return
  end
  if not self.npc then
    return
  end
  if self.target and 0 == self.is_enhance_condition then
    self.bonus_time = get_npc_time(self.npc) + 20
    self.is_enhance_condition = 1
  end
  self.now_time = get_npc_time(self.npc)
  if self.now_time > self.bonus_time and 1 == self.is_enhance_condition and not check_magic(self.npc, 6021068) then
    if check_magic(self.npc, 6021049) then
      abort_magic_by_id(self.npc, 6021049, 1)
    end
    cast_magic(self.npc, self.npc, 6021044, 1)
  end
end

function M:on_room_change(npc)
  if npc == self.npc then
    self.is_enhance_condition = 0
    cast_magic(self.npc, self.npc, 6021049, 1)
  end
end

function M:on_hero_showup_or_back(npc, is_showup)
  if npc ~= self.npc then
    return
  end
  if true == is_showup then
    self.bonus_time = get_npc_time(self.npc)
  else
    self.is_enhance_condition = 0
    cast_magic(self.npc, self.npc, 6021049, 1)
  end
end

return M
