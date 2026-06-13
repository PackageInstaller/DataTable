local M = Util.create_class()

function M:_init()
end

function M:on_start()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc then
    local levelmax = get_skill_cfg(skill_id).BattleResCost / 100
    if levelmax > 1 then
      for index = 1, levelmax do
        cast_magic(self.npc, self.npc, 4033420101, 2)
      end
    elseif levelmax > 0 then
      cast_magic(self.npc, self.npc, 4033420101, 2)
    end
  end
end

function M:on_frame()
end

return M
