local var_0_0 = class("Dorm3dInsProxy", import(".NetProxy"))

var_0_0.UNLOCK_TYPE_CHAT = 1
var_0_0.UNLOCK_TYPE_PHONE = 2
var_0_0.UNLOCK_TYPE_INS = 3

function var_0_0.register(arg_1_0)
	arg_1_0.instagrams = {}
	arg_1_0.insRoomList = arg_1_0:BuildRoomList()
	arg_1_0.insPhoneData = arg_1_0:BuildPhoneData()

	arg_1_0:on(28000, function(arg_2_0)
		if DORM_LOCK_INS then
			return
		end

		arg_1_0:HandleInsData(arg_2_0.ins)

		return
	end)
	arg_1_0:on(28025, function(arg_3_0)
		if DORM_LOCK_INS then
			return
		end

		for iter_3_0, iter_3_1 in ipairs(arg_3_0.list) do
			switch(iter_3_1.type, {
				[var_0_0.UNLOCK_TYPE_CHAT] = function()
					getProxy(Dorm3dChatProxy):HandleAct(iter_3_1)

					return
				end,
				[var_0_0.UNLOCK_TYPE_PHONE] = function()
					arg_1_0:UnlockPhone(iter_3_1.ship_id, iter_3_1.act_id, iter_3_1.time)

					return
				end,
				[var_0_0.UNLOCK_TYPE_INS] = function()
					arg_1_0:UnlockInstagram(iter_3_1.ship_id, iter_3_1.act_id, iter_3_1.time)

					return
				end
			})
		end

		return
	end)

	return
end

function var_0_0.HandleInsData(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		arg_7_0.instagrams[iter_7_1.ship_group] = arg_7_0:BuildInstagrams(iter_7_1.ship_group, iter_7_1.friend_list)

		arg_7_0:ExtendPhoneData(iter_7_1.ship_group, iter_7_1.phone_list)
		getProxy(Dorm3dChatProxy):CreateChat(iter_7_1)
	end

	return
end

function var_0_0.BuildInstagrams(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0, iter_8_1 in ipairs(arg_8_2 or {}) do
		({})[iter_8_1.id] = iter_8_1
	end

	local var_8_0 = pg.dorm3d_ins_template.get_id_list_by_ship_group[arg_8_1] or {}

	for iter_8_2, iter_8_3 in ipairs(var_8_0) do
		if ({})[iter_8_3] then
			table.insert({}, Instagram3Dorm.New(({})[iter_8_3], false))
		else
			table.insert({}, Instagram3Dorm.New({
				id = iter_8_3
			}))
		end
	end

	return {}
end

function var_0_0.GetInstagramList(arg_9_0, arg_9_1)
	return arg_9_0.instagrams[arg_9_1]
end

function var_0_0.UnlockInstagram(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = _.detect(arg_10_0:GetInstagramList(arg_10_1), function(arg_11_0)
		return arg_11_0.id == arg_10_2
	end)

	if var_10_0 then
		var_10_0:Unlock(arg_10_3)
	end

	return
end

function var_0_0.AnyInstagramShouldTip(arg_12_0, arg_12_1)
	return _.any(arg_12_0:GetInstagramList(arg_12_1) or {}, function(arg_13_0)
		return arg_13_0:ShouldTip()
	end)
end

function var_0_0.AllInstagramShouldTip(arg_14_0)
	return _.any(_.keys(arg_14_0.instagrams), function(arg_15_0)
		local var_15_0 = arg_14_0:AnyInstagramShouldTip(arg_15_0)

		var_15_0 = var_15_0 and arg_14_0:GetRoomByGroupId(arg_15_0):IsDownloaded()

		return var_15_0
	end)
end

function var_0_0.BuildPhoneData(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(pg.dorm3d_ins_telephone_group.get_id_list_by_ship_group) do
		local var_16_0 = {}

		_.each(iter_16_1, function(arg_17_0)
			table.insert(var_16_0, Dorm3dInsPhone.New(arg_17_0))

			return
		end)

		;({})[iter_16_0] = {}
	end

	return {}
end

function var_0_0.GetPhoneListByGroup(arg_18_0, arg_18_1)
	return arg_18_0.insPhoneData[arg_18_1]
end

function var_0_0.UnlockPhone(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = _.detect(arg_19_0:GetPhoneListByGroup(arg_19_1), function(arg_20_0)
		return arg_20_0.id == arg_19_2
	end)

	if var_19_0 then
		var_19_0:Unlock(arg_19_3)
	end

	return
end

function var_0_0.ExtendPhoneData(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0:GetPhoneListByGroup(arg_21_1)

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

function var_0_0.ShoudTipPhoneById(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetPhoneListByGroup(arg_23_1)

	if not var_23_0 then
		return false
	end

	return _.any(var_23_0, function(arg_24_0)
		return arg_24_0:ShouldTip()
	end)
end

function var_0_0.AnyPhoneShouldTip(arg_25_0)
	return _.any(_.keys(arg_25_0.insPhoneData), function(arg_26_0)
		return arg_25_0:ShoudTipPhoneById(arg_26_0)
	end)
end

function var_0_0.BuildRoomList(arg_27_0)
	local var_27_0 = {}

	_.each(pg.dorm3d_rooms.all, function(arg_28_0)
		if pg.dorm3d_rooms[arg_28_0].type == 1 and #pg.dorm3d_rooms[arg_28_0].character_pay > 0 then
			table.insert(var_27_0, Dorm3dInsPublicRoom.New(arg_28_0))
		elseif pg.dorm3d_rooms[arg_28_0].type == 2 then
			table.insert(var_27_0, Dorm3dInsCharRoom.New(arg_28_0))
		end

		return
	end)

	return {}
end

function var_0_0.GetRoomList(arg_29_0)
	return arg_29_0.insRoomList
end

function var_0_0.GetRoomById(arg_30_0, arg_30_1)
	return _.detect(arg_30_0.insRoomList, function(arg_31_0)
		return arg_31_0.id == arg_30_1
	end)
end

function var_0_0.GetRoomByGroupId(arg_32_0, arg_32_1)
	return _.detect(arg_32_0.insRoomList, function(arg_33_0)
		return arg_33_0:GetType() == 2 and arg_33_0.groupId == arg_32_1
	end)
end

return var_0_0
