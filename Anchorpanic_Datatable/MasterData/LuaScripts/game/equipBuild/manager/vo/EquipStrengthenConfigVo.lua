module("equipBuild.EquipStrengthenConfigVo", Class.impl())

function ctor(self)
end

function parseConfigData(self, cusLvl, cusData)
	self.lvl = cusLvl
	self.needExp = cusData.exp
	self.convertExp = cusData.return_exp
	self.costMoneyTid = cusData.pay_id
	self.costMoneyCount = cusData.pay_num
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
