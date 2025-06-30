--[[ 
-----------------------------------------------------
@filename       : MainExploreItemConfigVo
@Description    : 主线探索物件配置
@date           : 2022-3-29 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreItemConfigVo", Class.impl())

function parseConfig(self, mapId, eventId, configList)
	self.eventId = eventId
	self.list = {}
	for i = 1, #configList do
		local configData = configList[i]
		self.list[i] = {}
		self.list[i]["position"] = mainExplore.getGridLocalPos(mapId, configData.grid_y, configData.grid_x, configData.grid_z)
		self.list[i]["rotation"] = math.Vector3(configData.rotation_x, configData.rotation_y, configData.rotation_z)
		self.list[i]["scale"] = math.Vector3(configData.scale_x, configData.scale_y, configData.scale_z)
	end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
