module("recharge.RechargeVo", Class.impl())

function parseData(self, cusData)
	--充值商品id
	self.itemId = cusData.item_id
	--充值类型
	self.type = cusData.item_type
	--充值子类型（目前暂时无用了）
	self.subType = nil
	--详细id
	self.detailId = cusData.detail_id
	--花费人民币：元
	self.RMB = cusData.amount / 100
	--获得元宝数
	self.goldNum = cusData.gold
	--额外获得元宝数
	self.extraGoldNum = cusData.plus_gold
end

function toString(self)
	return "充值商品id：", self.itemId, "，充值类型：", self.type, "，充值子类型：", self.subType, "，充值的详细id：", self.detailId, "花费人民币：", self.RMB, "，获得元宝数：", self.goldNum, "，额外获得元宝数：", self.extraGoldNum
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
