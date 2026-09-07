local Furniture = class("Furniture", import("..BaseVO"))

Furniture.TYPE_WALLPAPER = 1
Furniture.TYPE_FURNITURE = 2
Furniture.TYPE_DECORATE = 3
Furniture.TYPE_FLOORPAPER = 4
Furniture.TYPE_MAT = 5
Furniture.TYPE_WALL = 6
Furniture.TYPE_COLLECTION = 7
Furniture.TYPE_STAGE = 8
Furniture.TYPE_ARCH = 9
Furniture.TYPE_WALL_MAT = 10
Furniture.TYPE_MOVEABLE = 11
Furniture.TYPE_TRANSPORT = 12
Furniture.TYPE_RANDOM_CONTROLLER = 13
Furniture.TYPE_FOLLOWER = 14
Furniture.TYPE_LUTE = 15
Furniture.TYPE_RANDOM_SLOT = 16
Furniture.INDEX_TO_COMFORTABLE_TYPE = {
	Furniture.TYPE_WALLPAPER,
	Furniture.TYPE_FURNITURE,
	Furniture.TYPE_DECORATE,
	Furniture.TYPE_FLOORPAPER,
	Furniture.TYPE_MAT,
	Furniture.TYPE_WALL,
	Furniture.TYPE_COLLECTION,
	Furniture.TYPE_FURNITURE,
	Furniture.TYPE_FURNITURE,
	Furniture.TYPE_WALL,
	Furniture.TYPE_FURNITURE,
	Furniture.TYPE_FURNITURE,
	Furniture.TYPE_FURNITURE,
	Furniture.TYPE_FURNITURE,
	Furniture.TYPE_FURNITURE,
	Furniture.TYPE_FURNITURE
}
Furniture.INDEX_TO_SHOP_TYPE = {
	{
		Furniture.TYPE_WALLPAPER
	},
	{
		Furniture.TYPE_FLOORPAPER
	},
	{
		Furniture.TYPE_FURNITURE,
		Furniture.TYPE_MAT,
		Furniture.TYPE_COLLECTION,
		Furniture.TYPE_STAGE,
		Furniture.TYPE_ARCH,
		Furniture.TYPE_MOVEABLE,
		Furniture.TYPE_TRANSPORT,
		Furniture.TYPE_RANDOM_CONTROLLER,
		Furniture.TYPE_FOLLOWER,
		Furniture.TYPE_LUTE,
		Furniture.TYPE_RANDOM_SLOT
	},
	{},
	{
		Furniture.TYPE_DECORATE
	},
	{
		Furniture.TYPE_WALL,
		Furniture.TYPE_WALL_MAT
	}
}

function Furniture:Ctor(arg_1_1)
	self.id = tonumber(arg_1_1.id)
	self.configId = arg_1_1.configId or tonumber(arg_1_1.id)
	self.count = arg_1_1.count or 0
	self.date = arg_1_1.get_time or arg_1_1.date or 0
	self.newFlag = false

	return
end

function Furniture:MarkNew()
	self.newFlag = true

	return
end

function Furniture:ClearNewFlag()
	self.newFlag = false

	return
end

function Furniture:getDate()
	if self.date > 0 then
		return pg.TimeMgr.GetInstance():STimeDescS(self.date, "%Y/%m/%d")
	end

	return
end

function Furniture:GetOwnCnt()
	return self.count
end

function Furniture:setCount(arg_6_1)
	self.count = arg_6_1

	return
end

function Furniture:isNotForSale()
	return self:getConfig("not_for_sale") == 1
end

function Furniture:isForActivity()
	return self:getConfig("not_for_sale") == 2
end

function Furniture:addFurnitrueCount(arg_9_1)
	self.count = self.count + arg_9_1

	return
end

function Furniture:canPurchase()
	return self.count < self:getConfig("count")
end

function Furniture:bindConfigTable()
	return pg.furniture_data_template
end

function Furniture:bindShopConfigTable()
	return pg.furniture_shop_template
end

function Furniture:isFurniture()
	return self:getConfig("type") ~= 0
end

function Furniture:IsNew()
	return self:getConfig("new") ~= 0
end

function Furniture:getConfig(arg_15_1)
	local var_15_0 = self:bindConfigTable()[self.configId]

	assert(var_15_0, self.configId)

	if var_15_0[arg_15_1] then
		return var_15_0[arg_15_1]
	else
		local var_15_1 = self:bindShopConfigTable()[self.configId]

		if var_15_1 then
			return var_15_1[arg_15_1]
		end
	end

	return
end

function Furniture:getTypeForComfortable()
	local var_16_0 = Furniture.INDEX_TO_COMFORTABLE_TYPE[self:getConfig("type")]

	return var_16_0 and var_16_0 or Furniture.TYPE_FURNITURE
end

function Furniture:getDeblocking()
	local var_17_0 = self:getConfig("themeId")

	assert(pg.backyard_theme_template[var_17_0], "pg.backyard_theme_template>>> id" .. var_17_0)

	return pg.backyard_theme_template[var_17_0].deblocking
end

function Furniture:inTheme()
	local var_18_0 = self:getConfig("themeId")

	if var_18_0 == 0 then
		return false
	end

	local var_18_1 = pg.backyard_theme_template[var_18_0]

	assert(pg.backyard_theme_template[var_18_0], "pg.backyard_theme_template>>id" .. var_18_0)

	return table.contains(var_18_1.ids, self.id)
end

function Furniture:isLock(arg_19_1)
	return self:inTheme() and arg_19_1 < self:getDeblocking()
end

function Furniture:isPaper()
	local var_20_0 = self:getConfig("type")

	return var_20_0 == 4 or var_20_0 == 1
end

function Furniture:GetThemeName()
	local var_21_0 = pg.backyard_theme_template[self:getConfig("themeId")]

	if var_21_0 then
		return var_21_0.name
	end

	return ""
end

function Furniture:inTime()
	local var_22_0 = self:getConfig("time")
	local var_22_1 = self:getConfig("collaboration_furniture_time")

	if var_22_1 ~= "" and var_22_1 ~= var_22_0 then
		return false
	end

	return pg.TimeMgr.GetInstance():inTime(var_22_0)
end

function Furniture:isTimeLimit()
	local var_23_0 = self:getConfig("time")

	return var_23_0 and type(var_23_0) == "table"
end

function Furniture:isRecordTime()
	return self:getConfig("is_get_time_note") == 1
end

function Furniture:isDisCount()
	return (self:getConfig("discount") or 0) > 0 and pg.TimeMgr.GetInstance():inTime(self:getConfig("discount_time"))
end

function Furniture:sortSizeFunc()
	local var_26_0 = self:getConfig("size")

	return (var_26_0[1] or 0) * (var_26_0[2] or 0)
end

function Furniture:getPrice(arg_27_1)
	local var_27_0 = (100 - (self:isDisCount() and self:getConfig("discount") or 0)) / 100
	local var_27_1 = arg_27_1 == 4 and self:getConfig("gem_price") or arg_27_1 == 6 and self:getConfig("dorm_icon_price")

	if var_27_1 then
		local var_27_2 = math.floor(var_27_1 * var_27_0)

		return var_27_1 > 0 and var_27_2 == 0 and 1 or var_27_2
	end

	return
end

function Furniture:canPurchaseByGem()
	local var_28_0 = self:getPrice(4)

	return var_28_0 and var_28_0 ~= 0
end

function Furniture:canPurchaseByDormMoeny()
	local var_29_0 = self:getPrice(6)

	return var_29_0 and var_29_0 ~= 0
end

function Furniture:getSortCurrency()
	local var_30_0 = 0

	if self:canPurchaseByGem() then
		var_30_0 = var_30_0 + 2
	elseif self:canPurchaseByDormMoeny() then
		var_30_0 = var_30_0 + 1
	end

	return var_30_0
end

function Furniture:sortPriceFunc()
	local var_31_0 = self:getConfig("gem_price") or 0
	local var_31_1 = self:getConfig("dorm_icon_price") or 0

	if var_31_0 > 0 then
		return var_31_0 + 1000000
	else
		return var_31_1
	end

	return
end

function Furniture:isMatchSearchKey(arg_32_1)
	if arg_32_1 == "" or not arg_32_1 then
		do return true end

		arg_32_1 = string.lower(arg_32_1)
	end

	local var_32_0 = string.lower((self:getConfig("name")))
	local var_32_1 = string.lower((self:getConfig("describe")))

	if string.find(var_32_0, arg_32_1) or string.find(var_32_0, arg_32_1) then
		return true
	end

	return false
end

function Furniture:IsShopType()
	return self:bindShopConfigTable()[self.configId] ~= nil
end

return Furniture
