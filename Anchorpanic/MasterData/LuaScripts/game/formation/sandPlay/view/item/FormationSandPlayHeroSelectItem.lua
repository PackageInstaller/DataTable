--[[
-----------------------------------------------------
@filename       : FormationSandPlayHeroSelectItem
@Description    : 地图探索副本
@date           : 2023-10-23 16:06:24
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('formation.FormationSandPlayHeroSelectItem', Class.impl(formation.FormationHeroSelectItem))

function setData(self, param)
    super.setData(self, param)
    self:__update()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
