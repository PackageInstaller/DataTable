local ENUM_IDX = 0
local function _enumID()
    ENUM_IDX = ENUM_IDX+1
    return ENUM_IDX
end

local FightSkillItemState = {
    NO_POWER = _enumID(),
    SHOW_ROUND = _enumID(),
    PALSY = _enumID(),
    LOCK = _enumID(),
    FORBID = _enumID(),
    EMPTY = _enumID(),
    NORMAL = _enumID(),
}


return FightSkillItemState
 
--[[ 替换语言包自动生成，请勿修改！
]]
