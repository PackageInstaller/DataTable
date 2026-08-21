_class("IDGenerator", Object)
IDGenerator = IDGenerator
local _IDGeneratorType = {DEFAULT_FIRST_ID = -1000000, GAME_EVENT_LISTENER_FIRST_ID = 1}
_enum("IDGeneratorType", _IDGeneratorType)
IDGeneratorType = IDGeneratorType

function IDGenerator:Constructor(first_id)
  self.next_id = first_id or IDGeneratorType.DEFAULT_FIRST_ID
end

function IDGenerator:GenID()
  local id = self.next_id
  self.next_id = self.next_id + 1
  return id
end
