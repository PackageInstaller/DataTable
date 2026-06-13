local clue_manager = {}
clue_manager.clue_list = {}
clue_manager.invisible_clue_list = {}

function clue_manager:add_clue(npc)
  if npc.id == 3001100 or npc.id == 3001105 then
    table.insert(self.clue_list, npc)
  else
    table.insert(self.invisible_clue_list, npc)
  end
end

function clue_manager:remove_clue(npc)
  for key, value in pairs(self.clue_list) do
    if value == npc then
      table.remove(self.clue_list, key)
    end
  end
  for key, value in pairs(self.invisible_clue_list) do
    if value == npc then
      table.remove(self.invisible_clue_list, key)
    end
  end
end

return clue_manager
