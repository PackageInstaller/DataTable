local ApartmentRoom = class("ApartmentRoom", import(".BaseVO"))

function ApartmentRoom:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.unlockCharacter = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.ships or {}) do
		self.unlockCharacter[iter_1_1] = true
	end

	self.furnitures = {}

	table.Ipairs(arg_1_1.furnitures or {}, function(arg_2_0, arg_2_1)
		self.furnitures[arg_2_0] = Dorm3dFurniture.New({
			configId = arg_2_1.furniture_id,
			slotId = arg_2_1.slot_id
		})

		return
	end)

	self.slotDic = {}

	table.Ipairs(self:GetSlotIDList(), function(arg_3_0, arg_3_1)
		self.slotDic[arg_3_1] = Dorm3dFurnitureSlot.New({
			configId = arg_3_1
		})

		return
	end)

	self.zoneDic = {}

	table.Ipairs(self:GetZoneIDList(), function(arg_4_0, arg_4_1)
		local var_4_0 = Dorm3dZone.New({
			configId = arg_4_1
		})

		self.zoneDic[var_4_0:GetWatchCameraName()] = var_4_0

		var_4_0:SetSlots(_.map(var_4_0:GetSlotIDList(), function(arg_5_0)
			return self.slotDic[arg_5_0]
		end))

		return
	end)
	self:UpdateFurnitureReplaceConfig()

	self.cameraZones = _.map(self:GetCameraZoneIDList(), function(arg_6_0)
		return Dorm3dCameraZone.New({
			configId = arg_6_0
		})
	end)
	self.collectItemDic = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.collections or {}) do
		self.collectItemDic[iter_1_3] = true
	end

	self.shipArAnimationDic = {}

	local var_1_0 = self:getConfig("ar_anim")

	if var_1_0 then
		for iter_1_4, iter_1_5 in ipairs(var_1_0) do
			self.shipArAnimationDic[iter_1_5[1]] = _.map(iter_1_5[2], function(arg_7_0)
				return Dorm3dCameraAnim.New({
					configId = arg_7_0
				})
			end)
		end
	end

	return
end

function ApartmentRoom:bindConfigTable()
	return pg.dorm3d_rooms
end

function ApartmentRoom:getDownloadNameList()
	local var_9_0 = DormGroupConst.GetDownloadResourceDic()
	local var_9_1 = string.lower(self:getConfig("resource_name"))
	local var_9_2 = {}

	switch(self:getConfig("type"), {
		function()
			var_9_2 = {
				"room_" .. var_9_1,
				"common"
			}

			return
		end,
		function()
			var_9_2 = {
				"room_" .. var_9_1,
				"apartment_" .. var_9_1,
				"common"
			}

			return
		end
	}, function()
		assert(false, "without room type:" .. self:getConfig("type"))

		return
	end)

	local var_9_3 = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		table.insertto(var_9_3, var_9_0[iter_9_1] or {})
	end

	return var_9_3
end

function ApartmentRoom:needDownload()
	return #self:getDownloadNameList() > 0
end

function ApartmentRoom:getDownloadNeedSize()
	local var_14_0, var_14_1 = DormGroupConst.CalcDormListSize(self:getDownloadNameList())

	return var_14_0, var_14_1
end

function ApartmentRoom:getState()
	if DormGroupConst.DormDownloadLock and DormGroupConst.DormDownloadLock.roomId == self.configId then
		return "loading"
	elseif self:needDownload() then
		return "download"
	else
		return "complete"
	end

	return
end

function ApartmentRoom:isPersonalRoom()
	return self:getConfig("type") == 2
end

function ApartmentRoom:getPersonalGroupId()
	assert(self:isPersonalRoom())

	return self:getConfig("character")[1]
end

function ApartmentRoom:getInviteList()
	return table.mergeArray(self:getConfig("character"), self:getConfig("character_pay"))
end

function ApartmentRoom:getInteractRange()
	local var_19_0, var_19_1 = unpack(self:getConfig("character_range"))

	var_19_1 = var_19_1 or var_19_0

	return var_19_0, var_19_1
end

function ApartmentRoom:getRoomName()
	return self:getConfig("room")
end

function ApartmentRoom:GetZoneIDList()
	return pg.dorm3d_zone_template.get_id_list_by_room_id[self.configId] or {}
end

function ApartmentRoom:GetSlotIDList()
	return pg.dorm3d_furniture_slot_template.get_id_list_by_room_id[self.configId] or {}
end

function ApartmentRoom:GetFurnitureZoneIDList()
	return self:getConfig("furniture_zones")
end

function ApartmentRoom:GetCameraZoneIDList()
	return pg.dorm3d_camera_zone_template.get_id_list_by_room_id[self.configId] or {}
end

function ApartmentRoom:GetZones()
	return underscore(self.zoneDic):chain():values():sort(CompareFuncs({
		function(arg_26_0)
			return arg_26_0.configId
		end
	})):value()
end

function ApartmentRoom:GetFurnitureZones()
	return underscore.map(self:GetFurnitureZoneIDList(), function(arg_28_0)
		return (table.Find(self.zoneDic, function(arg_29_0, arg_29_1)
			return arg_29_1:GetConfigID() == arg_28_0
		end))
	end)
end

function ApartmentRoom:GetCameraZones()
	return self.cameraZones
end

function ApartmentRoom:GetSlots()
	return underscore(self.slotDic):chain():values():sort(CompareFuncs({
		function(arg_32_0)
			return arg_32_0.configId
		end
	})):value()
end

function ApartmentRoom:GetFurnitureIDList()
	return pg.dorm3d_furniture_template.get_id_list_by_room_id[self.configId]
end

function ApartmentRoom:GetFurnitures()
	return self.furnitures
end

function ApartmentRoom:HasFurniture(arg_35_1)
	return _.any(self.furnitures, function(arg_36_0)
		return arg_36_0:GetConfigID() == arg_35_1
	end)
end

function ApartmentRoom:AddFurnitureByID(arg_37_1)
	table.insert(self.furnitures, Dorm3dFurniture.New({
		configId = arg_37_1
	}))

	return
end

function ApartmentRoom:ReplaceFurnitures(arg_38_1)
	_.each(arg_38_1, function(arg_39_0)
		self:ReplaceFurniture(arg_39_0.slotId, arg_39_0.furnitureId)

		return
	end)
	self:UpdateFurnitureReplaceConfig()

	return
end

function ApartmentRoom:ReplaceFurniture(arg_40_1, arg_40_2)
	if arg_40_1 > 0 then
		local var_40_0 = _.detect(self.furnitures, function(arg_41_0)
			return arg_41_0:GetSlotID() == arg_40_1
		end)

		if var_40_0 then
			var_40_0:SetSlotID(0)
		end
	end

	if arg_40_2 > 0 then
		local var_40_1 = _.detect(self.furnitures, function(arg_42_0)
			return arg_42_0:GetConfigID() == arg_40_2 and arg_42_0:GetSlotID() == 0
		end)

		if var_40_1 then
			var_40_1:SetSlotID(arg_40_1)
		end
	end

	return
end

function ApartmentRoom:IsFurnitureSetIn(arg_43_1)
	for iter_43_0, iter_43_1 in ipairs(self.furnitures) do
		if iter_43_1:GetConfigID() == arg_43_1 and iter_43_1.slotId > 0 then
			return true
		end
	end

	return false
end

function ApartmentRoom:UpdateFurnitureReplaceConfig()
	local var_44_0 = {}

	for iter_44_0, iter_44_1 in ipairs(self.furnitures) do
		if iter_44_1.slotId ~= 0 then
			var_44_0[iter_44_1.slotId] = iter_44_1
		end
	end

	return
end

ApartmentRoom.ITEM_LOCK = 0
ApartmentRoom.ITEM_UNLOCK = 1
ApartmentRoom.ITEM_ACTIVE = 2
ApartmentRoom.ITEM_FIRST = 3

function ApartmentRoom:getTriggerableCollectItemDic(arg_45_1)
	local var_45_0 = {}

	for iter_45_0, iter_45_1 in ipairs(pg.dorm3d_collection_template.get_id_list_by_room_id[self.configId] or {}) do
		var_45_0[iter_45_1] = (pg.dorm3d_collection_template[iter_45_1].time ~= 0 and pg.dorm3d_collection_template[iter_45_1].time ~= arg_45_1 or not ApartmentProxy.CheckUnlockConfig(pg.dorm3d_collection_template[iter_45_1].unlock)) and ApartmentRoom.ITEM_LOCK or self.collectItemDic[iter_45_1] and ApartmentRoom.ITEM_ACTIVE or ApartmentRoom.ITEM_FIRST
	end

	return var_45_0
end

function ApartmentRoom:getNormalZoneNames()
	return underscore(self.zoneDic):chain():values():select(function(arg_47_0)
		return not arg_47_0:IsGlobal()
	end):map(function(arg_48_0)
		return arg_48_0:GetWatchCameraName()
	end):value()
end

function ApartmentRoom:getZoneConfig(arg_49_1, arg_49_2)
	return self.zoneDic[arg_49_1]:getConfig(arg_49_2)
end

function ApartmentRoom:getApartmentZoneConfig(arg_50_1, arg_50_2, arg_50_3)
	return Apartment.getGroupConfig(arg_50_3, self:getZoneConfig(arg_50_1, arg_50_2))
end

function ApartmentRoom:getAllARAnimationListByShip(arg_51_1)
	return self.shipArAnimationDic[arg_51_1]
end

function ApartmentRoom:getMiniGames()
	return underscore.rest(pg.dorm3d_minigame.get_id_list_by_room_id[self.configId] or {}, 1)
end

function ApartmentRoom:unlockAllInvite()
	for iter_53_0, iter_53_1 in ipairs(self:getConfig("character_pay")) do
		if not self.unlockCharacter[iter_53_1] then
			return false
		end
	end

	return true
end

function ApartmentRoom:GetAllTouchIDByZone(arg_54_1, arg_54_2)
	local var_54_0 = {}
	local var_54_1 = self:getApartmentZoneConfig(arg_54_1, "touch_id", arg_54_2)

	if var_54_1 then
		table.insert(var_54_0, {
			touchId = var_54_1
		})
	end

	for iter_54_0, iter_54_1 in pairs(self.furnitures) do
		if iter_54_1:GetSlotID() > 0 then
			local var_54_2 = self.slotDic[iter_54_1:GetSlotID()]

			if var_54_2 and pg.dorm3d_zone_template[var_54_2:GetZoneID()].watch_camera == arg_54_1 then
				local var_54_3 = iter_54_1:GetName()
				local var_54_4 = Apartment.getGroupConfig(arg_54_2, iter_54_1:getConfig("touch_id"))

				if var_54_3 and var_54_4 then
					table.insert(var_54_0, {
						touchId = var_54_4,
						furnitureName = var_54_3
					})
				end
			end
		end
	end

	return var_54_0
end

return ApartmentRoom
