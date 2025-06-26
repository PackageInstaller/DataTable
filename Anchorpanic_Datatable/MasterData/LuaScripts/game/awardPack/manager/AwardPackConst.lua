--[[ 
-----------------------------------------------------
@filename       : AwardPackConst
@Description    : 掉落包Const
@date           : 2023-07-3 14:36:13
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("AwardPackConst", Class.impl())

AwardPackType = {
    --小概率
    Small = 1,
    --概率
    Probability = 2,
    --大概率
    Large = 3,
    --固定
    Certain = 4
}

function getAwardShowName(self, type)
    local name = _TT(53629)--"小概率"
    local color = ""
    if type == AwardPackType.Probability then
        name = _TT(53630)--"概率"
        color = ""
    elseif type == AwardPackType.Large then
        name = _TT(53631)--"大概率"
        color = ""
    elseif type == AwardPackType.Certain then
        name = _TT(53632)--"固定"
        color = ""
    end
    return name
end

return _M