local M = Util.create_class()

function M:_init()
  self.come_on_hero = nil
end

function M:on_start()
  self.come_on_hero = get_come_on_hero()
end

function M:on_hero_showup_or_back(npc, is_showup)
  if true == is_showup then
    self.come_on_hero = get_come_on_hero()
  end
end

function M:on_npc_born(npc)
  if self.npc ~= self.come_on_hero then
    return
  end
  local npc_kind = get_role_kind(npc)
  if npc_kind >= 2 and npc_kind <= 3 or 7 == npc_kind then
    local random = math.random(1, 100)
    if random <= 30 then
      cast_missile(npc, self.npc, nil, nil, 10018010401, 1, nil, nil)
    end
  end
end

return M
