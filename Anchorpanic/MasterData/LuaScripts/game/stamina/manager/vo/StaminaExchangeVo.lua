module("stamina.StaminaExchangeVo", Class.impl("lib.event.EventDispatcher"))

function ctor(self)
end

-- 解析消息
function parseConfigData(self, cusButTimes, cusData)
	self.buyTimes = cusButTimes
	-- 消耗钛金石数量
	self.costIianium = cusData.pay_jewel
	-- 获得抗疫血清数量
	self.stamina = cusData.stamina
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
