local Dorm3dFurniture = class("Dorm3dFurniture", import("model.vo.BaseVO"))

Dorm3dFurniture.TYPE = {
	SPECIAL = 99,
	FLOOR = 2,
	DECORATION = 3,
	BED = 4,
	TABLE = 6,
	COUCH = 5,
	WALLPAPER = 1
}
Dorm3dFurniture.TYPE2NAME = {
	[0] = "dorm3d_furnitrue_type_floor",
	"dorm3d_furnitrue_type_decoration",
	"dorm3d_furnitrue_type_bed",
	"dorm3d_furnitrue_type_couch",
	"dorm3d_furnitrue_type_table",
	99,
	"dorm3d_furnitrue_type_special",
	[nil] = "dorm3d_furnitrue_type_wallpaper"
}

function Dorm3dFurniture:bindConfigTable()
	return pg.dorm3d_furniture_template
end

function Dorm3dFurniture:Ctor(arg_2_1)
	Dorm3dFurniture.super.Ctor(self, arg_2_1)

	self.slotId = self.slotId or 0

	return
end

function Dorm3dFurniture:GetSlotID()
	return self.slotId
end

function Dorm3dFurniture:SetSlotID(arg_4_1)
	self.slotId = arg_4_1

	return
end

function Dorm3dFurniture:GetName()
	return self:getConfig("name")
end

function Dorm3dFurniture:GetType()
	return self:getConfig("type")
end

function Dorm3dFurniture:GetRarity()
	return self:getConfig("rarity")
end

function Dorm3dFurniture:GetTargetSlots()
	return self:getConfig("target_slots")
end

function Dorm3dFurniture:GetTargetSlotID()
	local var_9_0 = self:GetTargetSlots()[1]

	assert(var_9_0, "Missing Target Slot Dorm3dFurniture ID: " .. self:GetConfigID())

	return var_9_0
end

function Dorm3dFurniture:GetIcon()
	return self:getConfig("icon")
end

function Dorm3dFurniture:GetModel()
	return self:getConfig("model")
end

function Dorm3dFurniture:GetAcesses()
	local var_12_0 = self:getConfig("acesses")

	if var_12_0 == nil or var_12_0 == "" then
		return {}
	end

	return var_12_0
end

function Dorm3dFurniture:GetShopID()
	return self:getConfig("shop_id")[1] or 0
end

function Dorm3dFurniture:IsValuable()
	return self:getConfig("is_exclusive") == 1
end

function Dorm3dFurniture:IsSpecial()
	return self:getConfig("is_special") == 1
end

function Dorm3dFurniture:InShopTime()
	local var_16_0 = self:GetShopID()

	if var_16_0 == 0 then
		return true
	end

	return pg.TimeMgr.GetInstance():inTime(pg.shop_template[var_16_0].time)
end

function Dorm3dFurniture:GetEndTime()
	local var_17_0 = self:GetShopID()

	if var_17_0 == 0 then
		return 0
	end

	local var_17_1 = pg.shop_template[var_17_0]

	assert(pg.shop_template[var_17_0], "Missing shopCfg " .. (var_17_0 or "NIL"))

	if var_17_1.time == "always" or var_17_1.time == "stop" then
		return 0
	end

	return (pg.TimeMgr.GetInstance():parseTimeFromConfig(var_17_1.time[2]))
end

function Dorm3dFurniture:NeedViewTip()
	local var_18_0

	if self then
		var_18_0 = {}
		var_18_0[1] = getProxy(ApartmentProxy):getRoom(self)
		var_18_0 = var_18_0 or underscore.values(getProxy(ApartmentProxy).roomData)
	end

	return underscore.any(var_18_0, function(arg_19_0)
		return underscore.any(arg_19_0:GetFurnitures(), function(arg_20_0)
			return Dorm3dFurniture.GetViewedFlag(arg_20_0:GetConfigID()) == 0
		end)
	end)
end

function Dorm3dFurniture:NeedViewTipByFurnitureId()
	return Dorm3dFurniture.GetViewedFlag(self) == 0 and not (function(arg_22_0)
		local var_22_0 = getProxy(ApartmentProxy):getRoom(pg.dorm3d_furniture_template[arg_22_0].room_id)

		return var_22_0 and var_22_0:HasFurniture(arg_22_0)
	end)(self)
end

function Dorm3dFurniture:GetViewedFlag()
	return PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dFurnitureViewed_" .. self, 0)
end

function Dorm3dFurniture:SetViewedFlag()
	if Dorm3dFurniture.GetViewedFlag(self) > 0 then
		return
	end

	PlayerPrefs.SetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dFurnitureViewed_" .. self, 1)
	PlayerPrefs.Save()

	return true
end

function Dorm3dFurniture:IsTimelimitShopTip()
	local var_25_0

	if self then
		var_25_0 = {}
		var_25_0[1] = getProxy(ApartmentProxy):getRoom(self)
		var_25_0 = var_25_0 or underscore.values(getProxy(ApartmentProxy).roomData)
	end

	return underscore.any(var_25_0, function(arg_26_0)
		return _.any(pg.dorm3d_furniture_template.get_id_list_by_room_id[arg_26_0:GetConfigID()] or {}, function(arg_27_0)
			local var_27_0 = Dorm3dFurniture.New({
				configId = arg_27_0
			})

			return var_27_0:GetEndTime() > 0 and var_27_0:InShopTime() and Dorm3dFurniture.GetViewedFlag(arg_27_0) == 0
		end)
	end)
end

function Dorm3dFurniture.RecordLastTimelimitShopFurniture()
	local var_28_0 = getProxy(PlayerProxy):getRawData().id
	local var_28_1 = PlayerPrefs.GetInt(var_28_0 .. "_dorm3dTimelimitFurniture", 0)
	local var_28_2 = var_28_1

	underscore.each(underscore.values(getProxy(ApartmentProxy).roomData), function(arg_29_0)
		_.each(pg.dorm3d_furniture_template.get_id_list_by_room_id[arg_29_0:GetConfigID()] or {}, function(arg_30_0)
			local var_30_0 = Dorm3dFurniture.New({
				configId = arg_30_0
			})

			if var_30_0:GetEndTime() > 0 and var_30_0:InShopTime() then
				var_28_2 = math.max(var_28_2, arg_30_0)
			end

			return
		end)

		return
	end)

	if var_28_1 <= var_28_1 then
		return
	end

	PlayerPrefs.SetInt(var_28_0 .. "_dorm3dTimelimitFurniture", var_28_1)
	PlayerPrefs.Save()

	return
end

function Dorm3dFurniture.IsOnceTimelimitShopTip()
	local var_31_0 = PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dTimelimitFurniture", 0)

	return underscore.any(underscore.values(getProxy(ApartmentProxy).roomData), function(arg_32_0)
		local var_32_0 = arg_32_0:GetFurnitures()

		return _.any(pg.dorm3d_furniture_template.get_id_list_by_room_id[arg_32_0:GetConfigID()] or {}, function(arg_33_0)
			if arg_33_0 <= var_31_0 then
				return
			end

			local var_33_0 = Dorm3dFurniture.New({
				configId = arg_33_0
			})

			return var_33_0:GetEndTime() > 0 and var_33_0:InShopTime() and not _.detect(var_32_0, function(arg_34_0)
				return arg_34_0:GetConfigID() == arg_33_0
			end)
		end)
	end)
end

return Dorm3dFurniture
