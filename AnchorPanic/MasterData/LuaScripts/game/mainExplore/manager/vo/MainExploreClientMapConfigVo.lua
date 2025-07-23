--[[ 
-----------------------------------------------------
@filename       : MainExploreClientMapConfigVo
@Description    : 主线探索地图配置
@date           : 2022-3-29 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreClientMapConfigVo", Class.impl())

function parseConfig(self, mapId, cusData)
	-- 地图id
	self.mapId = mapId
	-- 地图行数row
	self.gridRow = cusData.grid_y
	-- 地图列数col
	self.gridCol = cusData.grid_x
	-- 地图左下角坐标点
	self.leftBottomPos = math.Vector3(cusData.map_left_bottom_pos_x, cusData.map_left_bottom_pos_z, cusData.map_left_bottom_pos_y)
	-- 格子大小
	self.gridSize = cusData.grid_size
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
