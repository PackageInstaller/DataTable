--[[ 
-----------------------------------------------------
@filename       : FormationArenaPeakDefenseSelectPanel
@Description    : 竞技场防守选择战员
@date           : 2021年12月2日 19:37:02
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('fomation.FormationArenaPeakDefenseSelectPanel', Class.impl(formation.FormationHeroSelectPanel))


function __getHeadSelectItem(self)
    return formation.FormationArenaPeakDefenseSelectItem
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
