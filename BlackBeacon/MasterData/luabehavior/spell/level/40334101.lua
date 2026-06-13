local M = Util.create_class()

function M:_init()
  self.addMagic = false
  self.numb = 0
  self.nowTime = 0
  self.durationTime = 0
end

function M:on_start()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and self.addMagic and (3 == skill_type or 4 == skill_type or 5 == skill_type) then
    self.numb = self.numb + 1
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc and self.addMagic and self.numb >= 6 then
    self.durationTime = 0
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc and is_showup then
    self.addMagic = true
    self.durationTime = get_npc_time(self.npc) + 6
  elseif npc == self.npc and not is_showup then
    self.addMagic = false
    self.numb = 0
  end
end

function M:on_frame()
  if self.addMagic then
    self.nowTime = get_npc_time(self.npc)
    if self.nowTime >= self.durationTime then
      if self.numb >= 1 then
        cast_missile(self.npc, self.npc, nil, nil, 30020200111, self.numb)
        cast_missile(self.npc, self.npc, nil, nil, 30020200112, 1)
      end
      self.addMagic = false
    end
  end
end

return M
