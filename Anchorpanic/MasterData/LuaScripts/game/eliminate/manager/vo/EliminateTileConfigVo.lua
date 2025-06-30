--[[ 
-----------------------------------------------------
@filename       : EliminateTileConfigVo
@Description    : 消消乐网格配置数据
@date           : 2022-3-2 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("eliminate.EliminateTileConfigVo", Class.impl())

function setData(self, mapId, cusData)
    self.mapId = mapId
    self.rowIndex = cusData.row
    self.colIndex = cusData.col
    self.tileType = cusData.tile_type
    self.thingType = cusData.thing_type
    self.iceType = cusData.ice_type
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
