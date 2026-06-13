local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  Base._init(self)
end

function M:on_start()
  if self.npc.id == 20105401 or self.npc.id == 20105402 or self.npc.id == 20105403 then
    enable_shadow(self.npc, false)
  end
  if self.npc.id == 20105404 then
    enable_shadow(self.npc, false)
    change_follow_target_new(1, self.npc, {
      10,
      0,
      {
        x = 0,
        y = 0,
        z = 0
      },
      1,
      0.8,
      0.02
    })
  end
end

function M:on_remove()
  change_follow_target_new(0)
end

function M:on_born_behavior()
  CommonMonster.born_animation(self, self.born_skill)
end

return M
