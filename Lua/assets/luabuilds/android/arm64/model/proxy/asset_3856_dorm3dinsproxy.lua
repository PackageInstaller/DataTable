local Dorm3dInsProxy = class("Dorm3dInsProxy", import(".NetProxy"))

Dorm3dInsProxy.UNLOCK_TYPE_CHAT = 1
Dorm3dInsProxy.UNLOCK_TYPE_PHONE = 2
Dorm3dInsProxy.UNLOCK_TYPE_INS = 3

function Dorm3dInsProxy:register()
	self.instagrams = {}
	self.insRoomList = self:BuildRoomList()
	self.insPhoneData = self:BuildPhoneData()

	self:on(28000, function(arg_2_0)
		if DORM_LOCK_INS then
			return
		end

		self:HandleInsData(arg_2_0.ins)

		return
	end)
	self:on(28025, function(arg_3_0)
		if DORM_LOCK_INS then
			return
		end

		for iter_3_0, iter_3_1 in ipairs(arg_3_0.list) do
			switch(iter_3_1.type, {
				[Dorm3dInsProxy.UNLOCK_TYPE_CHAT] = function()
					getProxy(Dorm3dChatProxy):HandleAct(iter_3_1)

					return
				end,
				[Dorm3dInsProxy.UNLOCK_TYPE_PHONE] = function()
					self:UnlockPhone(iter_3_1.ship_id, iter_3_1.act_id, iter_3_1.time)

					return
				end,
				[Dorm3dInsProxy.UNLOCK_TYPE_INS] = function()
					self:UnlockInstagram(iter_3_1.ship_id, iter_3_1.act_id, iter_3_1.time)

					return
				end
			})
		end

		return
	end)

	return
end

function Dorm3dInsProxy:HandleInsData(arg_7_1)
	if not arg_7_1 then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		self.instagrams[iter_7_1.ship_group] = self:BuildInstagrams(iter_7_1.ship_group, iter_7_1.friend_list)

		self:ExtendPhoneData(iter_7_1.ship_group, iter_7_1.phone_list)
		getProxy(Dorm3dChatProxy):CreateChat(iter_7_1)
	end

	return
end

function Dorm3dInsProxy:BuildInstagrams(arg_8_1, arg_8_2)
	local var_8_0 = {}
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_2 or {}) do
		var_8_1[iter_8_1.id] = iter_8_1
	end

	for iter_8_2, iter_8_3 in ipairs(pg.dorm3d_ins_template.get_id_list_by_ship_group[arg_8_1] or {}) do
		if var_8_1[iter_8_3] then
			table.insert(var_8_0, Instagram3Dorm.New(var_8_1[iter_8_3], false))
		else
			table.insert(var_8_0, Instagram3Dorm.New({
				id = iter_8_3
			}))
		end
	end

	return var_8_0
end

function Dorm3dInsProxy:GetInstagramList(arg_9_1)
	return self.instagrams[arg_9_1]
end

function Dorm3dInsProxy:UnlockInstagram(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = _.detect(self:GetInstagramList(arg_10_1), function(arg_11_0)
		return arg_11_0.id == arg_10_2
	end)

	if var_10_0 then
		var_10_0:Unlock(arg_10_3)
	end

	return
end

function Dorm3dInsProxy:AnyInstagramShouldTip(arg_12_1)
	return _.any(self:GetInstagramList(arg_12_1) or {}, function(arg_13_0)
		return arg_13_0:ShouldTip()
	end)
end

function Dorm3dInsProxy:AllInstagramShouldTip()
	return _.any(_.keys(self.instagrams), function(arg_15_0)
		local var_15_0 = self:AnyInstagramShouldTip(arg_15_0)

		var_15_0 = var_15_0 and self:GetRoomByGroupId(arg_15_0):IsDownloaded()

		return var_15_0
	end)
end

function Dorm3dInsProxy:BuildPhoneData()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(pg.dorm3d_ins_telephone_group.get_id_list_by_ship_group) do
		local var_16_1 = {}

		_.each(iter_16_1, function(arg_17_0)
			table.insert(var_16_1, Dorm3dInsPhone.New(arg_17_0))

			return
		end)

		var_16_0[iter_16_0] = var_16_1
	end

	return var_16_0
end

function Dorm3dInsProxy:GetPhoneListByGroup(arg_18_1)
	return self.insPhoneData[arg_18_1]
end

function Dorm3dInsProxy:UnlockPhone(arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = _.detect(self:GetPhoneListByGroup(arg_19_1), function(arg_20_0)
		return arg_20_0.id == arg_19_2
	end)

	if var_19_0 then
		var_19_0:Unlock(arg_19_3)
	end

	return
end

function Dorm3dInsProxy:ExtendPhoneData(arg_21_1, arg_21_2)
	local var_21_0 = self:GetPhoneListByGroup(arg_21_1)

	for iter_21_0, iter_21_1 in ipairs(arg_21_2) do
		local var_21_1 = _.detect(var_21_0, function(arg_22_0)
			return arg_22_0.id == iter_21_1.id
		end)

		if var_21_1 then
			var_21_1:ExtendsData(iter_21_1)
		end
	end

	return
end

function Dorm3dInsProxy:ShoudTipPhoneById(arg_23_1)
	local var_23_0 = self:GetPhoneListByGroup(arg_23_1)

	if not var_23_0 then
		return false
	end

	return _.any(var_23_0, function(arg_24_0)
		return arg_24_0:ShouldTip()
	end)
end

function Dorm3dInsProxy:AnyPhoneShouldTip()
	return _.any(_.keys(self.insPhoneData), function(arg_26_0)
		return self:ShoudTipPhoneById(arg_26_0)
	end)
end

function Dorm3dInsProxy:BuildRoomList()
	local var_27_0 = {}

	_.each(pg.dorm3d_rooms.all, function(arg_28_0)
		if pg.dorm3d_rooms[arg_28_0].type == 1 and #pg.dorm3d_rooms[arg_28_0].character_pay > 0 then
			table.insert(var_27_0, Dorm3dInsPublicRoom.New(arg_28_0))
		elseif pg.dorm3d_rooms[arg_28_0].type == 2 then
			table.insert(var_27_0, Dorm3dInsCharRoom.New(arg_28_0))
		end

		return
	end)

	return var_27_0
end

function Dorm3dInsProxy:GetRoomList()
	return self.insRoomList
end

function Dorm3dInsProxy:GetRoomById(arg_30_1)
	return _.detect(self.insRoomList, function(arg_31_0)
		return arg_31_0.id == arg_30_1
	end)
end

function Dorm3dInsProxy:GetRoomByGroupId(arg_32_1)
	return _.detect(self.insRoomList, function(arg_33_0)
		return arg_33_0:GetType() == 2 and arg_33_0.groupId == arg_32_1
	end)
end

return Dorm3dInsProxy
