local BackYardSystemTheme = class("BackYardSystemTheme", import(".BackYardSelfThemeTemplate"))

function BackYardSystemTheme:Ctor(arg_1_1)
	BackYardSystemTheme.super.Ctor(self, arg_1_1)

	self.level = 1
	self.order = self:getConfig("order")

	return
end

function BackYardSystemTheme:GetRawPutList()
	self:CheckLevel()

	if not self.putInfo then
		local var_2_0

		pcall(function()
			var_2_0 = require("GameCfg.backyardTheme.theme_" .. self.id)

			return
		end)

		var_2_0 = var_2_0 or require("GameCfg.backyardTheme.theme_empty")
		self.putInfo = _.select(var_2_0["furnitures_" .. getProxy(DormProxy):getRawData().level] or {}, function(arg_4_0)
			return pg.furniture_data_template[arg_4_0.id]
		end)
	end

	return self.putInfo
end

function BackYardSystemTheme:CheckLevel()
	local var_5_0 = getProxy(DormProxy):getRawData().level

	if self.level ~= var_5_0 then
		self.furnitruesByIds = nil
		self.putInfo = nil
		self.level = var_5_0
	end

	return
end

function BackYardSystemTheme:GetAllFurniture()
	self:CheckLevel()
	BackYardSystemTheme.super.GetAllFurniture(self)

	if not self.furnitruesByIds then
		self:CheckData()
	end

	return self.furnitruesByIds
end

function BackYardSystemTheme:GetWarpFurnitures()
	self:CheckLevel()

	return BackYardSystemTheme.super.GetWarpFurnitures(self)
end

function BackYardSystemTheme:CheckData()
	local var_8_0 = getProxy(DormProxy):getRawData()
	local var_8_1 = {}
	local var_8_2 = {}

	for iter_8_0, iter_8_1 in pairs(self.furnitruesByIds) do
		if not var_8_0:IsPurchasedFurniture(iter_8_1.configId) then
			if iter_8_1.parent ~= 0 then
				table.insert(var_8_2, {
					pid = iter_8_1.parent,
					id = iter_8_0
				})
			elseif table.getCount(iter_8_1.child) > 0 then
				for iter_8_2, iter_8_3 in pairs(iter_8_1.child) do
					table.insert(var_8_1, iter_8_2)
				end
			end

			table.insert(var_8_1, iter_8_0)
		end
	end

	local var_8_3 = #var_8_1 > 0 or #var_8_2 > 0

	for iter_8_4, iter_8_5 in ipairs(var_8_1) do
		self.furnitruesByIds[iter_8_5] = nil
	end

	for iter_8_6, iter_8_7 in pairs(var_8_2) do
		if self.furnitruesByIds[iter_8_7.pid] then
			for iter_8_8, iter_8_9 in pairs(self.furnitruesByIds[iter_8_7.pid].child) do
				if iter_8_8 == iter_8_7.id then
					self.furnitruesByIds[iter_8_7.pid].child[iter_8_7.id] = nil

					break
				end
			end
		end
	end

	return var_8_3
end

function BackYardSystemTheme:bindConfigTable()
	return pg.backyard_theme_template
end

function BackYardSystemTheme:IsOverTime()
	local var_10_0 = pg.furniture_shop_template

	return _.all(self:getConfig("ids"), function(arg_11_0)
		local var_11_0 = var_10_0[arg_11_0] and not pg.TimeMgr.GetInstance():inTime(var_10_0[arg_11_0].time) or true

		return var_11_0
	end)
end

function BackYardSystemTheme:GetFurnitures()
	return self:getConfig("ids")
end

function BackYardSystemTheme:HasDiscount()
	return _.any(self:GetFurnitures(), function(arg_14_0)
		local var_14_0 = Furniture.New({
			id = arg_14_0
		})

		return var_14_0:getConfig("dorm_icon_price") > var_14_0:getPrice(PlayerConst.ResDormMoney)
	end)
end

function BackYardSystemTheme:GetDiscount()
	local var_15_0 = _.map(self:GetFurnitures(), function(arg_16_0)
		return Furniture.New({
			id = arg_16_0
		})
	end)
	local var_15_1 = _.reduce(var_15_0, 0, function(arg_18_0, arg_18_1)
		return arg_18_0 + arg_18_1:getConfig("dorm_icon_price")
	end)

	return (var_15_1 - _.reduce(var_15_0, 0, function(arg_17_0, arg_17_1)
		return arg_17_0 + arg_17_1:getPrice(PlayerConst.ResDormMoney)
	end)) / var_15_1 * 100
end

function BackYardSystemTheme:IsPurchased(arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(self:getConfig("ids")) do
		if not arg_19_1[iter_19_1] then
			return false
		end
	end

	return true
end

function BackYardSystemTheme:GetName()
	return self:getConfig("name")
end

function BackYardSystemTheme:GetDesc()
	return self:getConfig("desc")
end

function BackYardSystemTheme:IsSystem()
	return true
end

function BackYardSystemTheme:getName()
	return self:GetName()
end

function BackYardSystemTheme:getIcon()
	return self:getConfig("icon")
end

function BackYardSystemTheme:isUnLock(arg_25_1)
	return self:getConfig("deblocking") <= arg_25_1.level
end

return BackYardSystemTheme
