module("role.RoleLvlUpVo", Class.impl("lib.event.EventDispatcher"))

-- 解析消息
function parseConfigData(self, cusLvl, cusData)
	self.lvl = cusLvl
	-- 当前等级升到下一等级需要的经验
	self.needExp = cusData.need
	-- 当前等级自然增加的体力，不限制通过道具获得体力 或者 货币购买体力
	self.maxStamina = cusData.max_stamina
	-- 当前等级升到下一等级能增加的体力
	self.addStamina = cusData.level_stamina
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
