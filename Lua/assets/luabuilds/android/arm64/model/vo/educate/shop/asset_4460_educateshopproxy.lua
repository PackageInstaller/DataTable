local EducateShopProxy = class("EducateShopProxy")

function EducateShopProxy:Ctor(arg_1_1)
	self.binder = arg_1_1
	self.data = {}

	return
end

function EducateShopProxy:SetUp(arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.shops or {}) do
		var_2_0[iter_2_1.shop_id] = iter_2_1.goods
	end

	self.data = {}

	for iter_2_2, iter_2_3 in ipairs(pg.child_shop.all) do
		self.data[iter_2_3] = EducateShop.New(iter_2_3, var_2_0[iter_2_3] or {})
	end

	self.discountData = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.discountEventIds or {}) do
		self:AddDiscountEventById(iter_2_5)
	end

	return
end

function EducateShopProxy:GetShopWithId(arg_3_1)
	return self.data[arg_3_1]
end

function EducateShopProxy:UpdateShop(arg_4_1)
	self.data[arg_4_1.id] = arg_4_1

	return
end

function EducateShopProxy:GetDiscountData()
	return self.discountData
end

function EducateShopProxy:IsDiscountById(arg_6_1)
	return self.discountData[arg_6_1]
end

function EducateShopProxy:GetDiscountById(arg_7_1)
	return self.discountData[arg_7_1] and self.discountData[arg_7_1]:GetDiscountRatio() or 0
end

function EducateShopProxy:AddDiscountEventById(arg_8_1)
	local var_8_0 = EducateSpecialEvent.New(arg_8_1)

	self.discountData[var_8_0:GetDiscountShopId()] = var_8_0

	return
end

function EducateShopProxy:OnNewWeek(arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self.data) do
		if iter_9_1:IsRefreshShop(arg_9_1) then
			table.insert(var_9_0, function(arg_10_0)
				self.binder:sendNotification(GAME.EDUCATE_REQUEST_SHOP_DATA, {
					shopId = iter_9_1.id,
					callback = arg_10_0
				})

				return
			end)
		end
	end

	seriesAsync(var_9_0, function()
		return
	end)

	for iter_9_2, iter_9_3 in pairs(self.discountData) do
		if not iter_9_3:InDiscountTime(arg_9_1) then
			self.discountData[iter_9_2] = nil
		end
	end

	return
end

return EducateShopProxy
