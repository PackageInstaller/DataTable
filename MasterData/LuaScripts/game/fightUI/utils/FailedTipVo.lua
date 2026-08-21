module('fightUI.FailedTipVo', Class.impl())

function parseData(self, key, cusData)
	self.lv = key
    self.markLevel = cusData.mark_level
    self.equipLevel = cusData.equip_level
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
