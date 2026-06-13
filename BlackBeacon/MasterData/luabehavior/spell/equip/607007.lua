local M = Util.create_class()

function M:_init(npc)
  self.is_boom = true
  self.magic_numbs = 3
  self.curse_missile = {}
end

function M:on_start()
  self.come_on_hero = get_come_on_hero()
end

function M:on_hero_showup_or_back(npc, is_showup)
  if true == is_showup then
    self.come_on_hero = get_come_on_hero()
  end
end

function M:on_before_npc_hp_zero(npc)
  if self.magic_numbs > 0 and npc ~= self.come_on_hero and self.npc == self.come_on_hero and npc.id ~= 1002002 then
    if 2 ~= get_role_kind(npc) then
      return
    end
    local random = math.random(1, 10)
    if random >= 8 then
      cast_missile(npc, npc, nil, nil, 10018010105, 1, nil, nil)
      cast_missile(npc, npc, nil, nil, 10018010106, 1, nil, nil)
    end
  end
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 10018010105 or missile_cfg.Id == 10018010106 then
    table.insert(self.curse_missile, missile)
  end
end

function M:on_frame()
  if is_pass_room() then
    for k, v in pairs(self.curse_missile) do
      remove_missile(v)
      self.curse_missile[k] = nil
    end
  end
end

function M:disenagement_from_battle()
  if not is_in_challenge() then
    self.blood = 0
  end
  if is_pass_room() then
    self.blood = 0
  end
end

return M
