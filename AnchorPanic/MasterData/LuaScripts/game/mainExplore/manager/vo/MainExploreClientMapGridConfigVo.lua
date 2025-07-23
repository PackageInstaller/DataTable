--[[ 
-----------------------------------------------------
@filename       : MainExploreClientMapGridConfigVo
@Description    : 主线探索地图格子配置
@date           : 2022-3-29 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreClientMapGridConfigVo", Class.impl())

function parseConfig(self, mapId, cusData)
	-- 地图id
	self.mapId = mapId
	-- 后端单位：格子位置行row
	self.gridRow = cusData.grid_y
	-- 后端单位：格子位置列col
	self.gridCol = cusData.grid_x
	-- 后端单位：格子高度树
	self.gridHeightNum = cusData.grid_z
	-- 格子类型
	self.gridType = cusData.grid_type
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
