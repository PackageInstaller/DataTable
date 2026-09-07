local EducateGood = class("EducateGood", import("model.vo.BaseVO"))

function EducateGood:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.remainCnt = arg_1_1.num

	self:initTime()

	return
end

function EducateGood:bindConfigTable()
	return pg.child_shop_template
end

function EducateGood:IsAlwaysTime()
	return self:getConfig("time") == "always"
end

function EducateGood:initTime()
	if not self:IsAlwaysTime() then
		self.startTime, self.endTime = EducateHelper.CfgTime2Time((self:getConfig("time")))
	end

	return
end

function EducateGood:CanBuy()
	return self:GetRemainCnt() > 0
end

function EducateGood:GetRemainCnt()
	return self.remainCnt
end

function EducateGood:ReduceRemainCnt(arg_7_1)
	self.remainCnt = self.remainCnt - arg_7_1

	return
end

function EducateGood:GetCost(arg_8_1)
	return {
		id = self:getConfig("resource"),
		num = self:GetPrice(arg_8_1)
	}
end

function EducateGood:GetPrice(arg_9_1)
	local var_9_0 = self:getConfig("resource_num")

	if not arg_9_1 then
		return var_9_0
	end

	return math.floor(var_9_0 * (1 - arg_9_1 / 16))
end

function EducateGood:GetShowInfo()
	return {
		type = EducateConst.DROP_TYPE_ITEM,
		id = self:getConfig("item_id"),
		number = self:getConfig("buy_num")
	}
end

function EducateGood:InTime(arg_11_1)
	if not self:IsAlwaysTime() then
		return EducateHelper.InTime(arg_11_1, self.startTime, self.endTime)
	else
		return true
	end

	return
end

return EducateGood
