local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  Base._init(self)
  self.time = 0
  self.control = 0
  self.nums = 0
end

function M:on_superarmor_break(npc, camp)
end

function M:sleep_time()
  if get_npc_time(self.npc) >= self.time and self.nums <= 5 then
    if not check_magic(self.npc, 100104) then
      play_effect(self.npc, "Fx_Equip_Element_3_1", "eff_mid", false)
    end
    self.time = get_npc_time(self.npc) + 1
    self.control = 0
    self.nums = self.nums + 1
  else
    self.control = 1
  end
end

function M:creat_magic()
  if not self.target then
    return
  end
  if 0 == self.control and 1 == get_magic_num(self.npc, 1998020) then
    cast_magic(self.target, self.npc, 1998022, 1)
  elseif 0 == self.control and 2 == get_magic_num(self.npc, 1998020) then
    cast_magic(self.target, self.npc, 1998022, 2)
  elseif 0 == self.control and 3 == get_magic_num(self.npc, 1998020) then
    cast_magic(self.target, self.npc, 1998022, 3)
  elseif 0 == self.control and 4 == get_magic_num(self.npc, 1998020) then
    cast_magic(self.target, self.npc, 1998022, 4)
  elseif 0 == self.control and 5 == get_magic_num(self.npc, 1998020) then
    cast_magic(self.target, self.npc, 1998022, 5)
  end
end

function M:on_frame()
  CommonMonster.search_target(self, 30, 8)
  if check_npc_die(self.npc) then
    return
  end
  if self.nums < 5 then
    self:sleep_time()
    self:creat_magic()
  end
end

return M
