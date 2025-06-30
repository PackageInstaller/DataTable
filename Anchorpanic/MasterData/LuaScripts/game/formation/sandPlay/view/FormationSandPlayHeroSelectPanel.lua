--[[
-----------------------------------------------------
@filename       : FormationSandPlayHeroSelectPanel
@Description    : 地图探索副本选择战员
@date           : 2023-10-23 16:05:39
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('formation.FormationSandPlayHeroSelectPanel', Class.impl(formation.FormationHeroSelectPanel))

function __getHeadSelectItem(self)
    return formation.FormationSandPlayHeroSelectItem
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
