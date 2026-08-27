local DormFightConst = require("Game.Fight.DormFightConst")
local CharacterFactory = {}

function CharacterFactory.CreateCharacter(characterType)
  local res
  if characterType == DormFightConst.CharacterType.Player then
    res = require("Game.Fight.Character.Entity.DormFightPlayerCharacter").New()
  elseif characterType == DormFightConst.CharacterType.Npc then
    res = require("Game.Fight.Character.Entity.DormFightNpcCharacter").New()
  end
  return res
end

return CharacterFactory
