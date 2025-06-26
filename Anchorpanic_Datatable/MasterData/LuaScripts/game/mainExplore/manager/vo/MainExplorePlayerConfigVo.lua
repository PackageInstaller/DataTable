--[[ 
-----------------------------------------------------
@filename       : MainExplorePlayerConfigVo
@Description    : 主线探索玩家配置
@date           : 2022-3-29 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExplorePlayerConfigVo", Class.impl())

function parseConfig(self, heroTid, cusData)
	-- 战员tid
	self.heroTid = heroTid
	-- 索敌范围
	self.findRange = cusData.find_range
	-- 索敌角度
	self.findAngle = cusData.find_angle
	-- agent半径（百分比）
	self.agentRadius = cusData.agent_radius / 100
	-- agent高度（百分比）
	self.agentHeight = cusData.agent_height / 100
	-- 移动速度
	self.normalSpeed = cusData.normal_speed
	-- 自动寻路速度
	self.audioSpeed = cusData.auto_speed
	-- 模型正常播放速度
	self.normalAnimationSpeed = cusData.normal_animation_speed
	-- 小地图图标
	self.miniIcon = cusData.mini_icon
	-- 小地图图标是否显示在外边
	self.miniShowOutEnable = cusData.mini_showout_enable == 1
	-- 小地图是否显示范围
	self.miniRangeEnable = cusData.mini_range_enable == 1
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
