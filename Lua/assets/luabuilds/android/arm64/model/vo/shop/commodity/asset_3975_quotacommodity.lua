local QuotaCommodity = class("QuotaCommodity", import(".BaseCommodity"))

function QuotaCommodity:bindConfigTable()
	return pg.activity_shop_template
end

function QuotaCommodity:canPurchase()
	return self:GetPurchasableCnt() > 0
end

function QuotaCommodity:GetPurchasableCnt()
	return math.max(self:GetLimitGoodCount() - self:GetOwnedGoodCount(), 0)
end

function QuotaCommodity:GetOwnedGoodCount()
	return self:getDropInfo():getOwnedCount()
end

function QuotaCommodity:getDropInfo()
	return Drop.New({
		type = self:getConfig("commodity_type"),
		id = self:getConfig("commodity_id"),
		count = self:getConfig("num")
	})
end

function QuotaCommodity:GetLimitGoodCount()
	local var_6_0 = self:getConfig("limit_args")

	if type(var_6_0) == "table" then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			if iter_6_1[1] == "quota" then
				return iter_6_1[2]
			end
		end
	end

	assert(false, "good not limit_args 'quota' with id: " .. self.id)

	return
end

return QuotaCommodity
