--[[ 
-----------------------------------------------------
@filename       : MainExploreMapConfigVo
@Description    : 主线探索地图配置
@date           : 2022-3-29 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreMapConfigVo", Class.impl())

function parseConfig(self, mapId, cusData)
	-- 地图id
	self.mapId = mapId
	-- 场景id
	self.sceneId = cusData.scene_id
	-- 副本类型
	self.dupType = cusData.dup_type
	-- 副本id
	self.dupId = cusData.dup_id
	-- 出生点
	self.bornPos = math.Vector3(cusData.born_pos[1], cusData.born_pos[2], cusData.born_pos[3])
	-- 对应小地图资源
	self.miniMap = cusData.mini_map
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
