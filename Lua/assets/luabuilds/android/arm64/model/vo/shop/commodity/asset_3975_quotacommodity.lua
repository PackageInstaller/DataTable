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
	return Drop.New({
		id = self:getConfig("commodity_id"),
		type = self:getConfig("commodity_type"),
		count = self:getConfig("num")
	}):getOwnedCount()
end

function QuotaCommodity:GetLimitGoodCount()
	local var_5_0 = self:getConfig("limit_args")

	if type(var_5_0) == "table" then
		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			if iter_5_1[1] == "quota" then
				return iter_5_1[2]
			end
		end
	end

	assert(false, "good not limit_args 'quota' with id: " .. self.id)

	return
end

return QuotaCommodity
