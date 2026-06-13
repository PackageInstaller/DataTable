local M = Util.create_class()

function M:_init()
  self.numb = 0
end

function M:on_start()
end

function M:before_heal(npc, target, magic_id)
  if target == get_come_on_hero() then
    self.numb = self.numb + 1
    if self.numb >= 10 then
      local castNpc = get_come_on_hero()
      local targetlist = search_npc(self.npc, 4, 10, nil, true, true)
      for k, v in pairs(targetlist) do
        cast_magic(castNpc, v, 7000020202, 1)
      end
      self.numb = 0
    end
  end
end

function M:on_element_aborn_end(npc, element, attacker)
end

return M
