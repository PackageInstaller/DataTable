--[[ 
-----------------------------------------------------
@filename       : FormationGuildWarAtkSelectPanel
@Description    : 联盟团战选择战员
-----------------------------------------------------
]]
module('fomation.FormationGuildWarAtkSelectPanel', Class.impl(formation.FormationHeroSelectPanel))


function __getHeadSelectItem(self)
    return formation.FormationGuildWarAtkSelectItem
end

return _M