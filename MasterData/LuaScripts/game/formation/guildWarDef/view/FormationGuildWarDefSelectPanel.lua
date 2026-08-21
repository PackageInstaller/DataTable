--[[ 
-----------------------------------------------------
@filename       : FormationGuildWarDefSelectPanel
@Description    : 联盟团战防守选择战员
-----------------------------------------------------
]]
module('fomation.FormationGuildWarDefSelectPanel', Class.impl(formation.FormationHeroSelectPanel))


function __getHeadSelectItem(self)
    return formation.FormationGuildWarDefSelectItem
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
