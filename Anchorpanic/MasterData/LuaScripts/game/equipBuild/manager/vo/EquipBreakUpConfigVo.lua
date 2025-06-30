module("equipBuild.EquipBreakUpConfigVo", Class.impl())

function ctor(self)
end

function parseConfigData(self, cusRank, cusData)
	self.rank = cusRank
	self.equipNeedLvl = cusData.level
	self.equipTargetLvl = cusData.level_limit
	self.costPropsList = {}
	for i = 1, #cusData.cost do
		table.insert(self.costPropsList, {tid = cusData.cost[i][1], count = cusData.cost[i][2]}) 
	end
	self.costMoneyTid = cusData.pay_id
	self.costMoneyCount = cusData.pay_num
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
