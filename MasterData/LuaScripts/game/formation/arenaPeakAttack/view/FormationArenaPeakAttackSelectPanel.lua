--[[ 
-----------------------------------------------------
@filename       : FormationArenaPeakAttackSelectPanel
@Description    : 竞技场进攻选择战员
@date           : 2023-09-25 16:12:47
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('fomation.FormationArenaPeakAttackSelectPanel', Class.impl(formation.FormationHeroSelectPanel))


function __getHeadSelectItem(self)
    return formation.FormationArenaPeakAttackSelectItem
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
