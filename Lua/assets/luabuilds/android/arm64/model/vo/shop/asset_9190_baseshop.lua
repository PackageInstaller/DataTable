local BaseShop = class("BaseShop", import("..BaseVO"))

function BaseShop:IsSameKind(arg_1_1)
	assert(false)

	return
end

function BaseShop:GetCommodityById(arg_2_1)
	assert(false)

	return
end

function BaseShop:GetCommodities()
	assert(false)

	return
end

function BaseShop:IsPurchaseAll()
	for iter_4_0, iter_4_1 in pairs((self:GetCommodities())) do
		if iter_4_1:canPurchase() then
			return false
		end
	end

	return true
end

return BaseShop
