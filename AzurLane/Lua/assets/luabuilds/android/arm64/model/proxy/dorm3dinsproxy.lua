class = var_0_10000

local var_0_0 = "Dorm3dInsProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.UNLOCK_TYPE_CHAT = 1
var_0_1.UNLOCK_TYPE_PHONE = 2
var_0_1.UNLOCK_TYPE_INS = 3

function var_0_1.register(arg_1_0)
	arg_1_0.instagrams = {}
	arg_1_0.insRoomList = arg_1_0:BuildRoomList()
	arg_1_0.insPhoneData = arg_1_0:BuildPhoneData()

	arg_1_0:on(28000, function(arg_2_0)
		DORM_LOCK_INS = var_2_10001

		if var_2_10001 then
			return
		end

		local var_2_0 = arg_1_0

		var_1.HandleInsData(var_2_0, arg_2_0.ins)

		return
	end)
	arg_1_0:on(28025, function(arg_3_0)
		DORM_LOCK_INS = var_2_10001

		if var_2_10001 then
			return
		end

		ipairs = var_2_10001

		for iter_3_0, iter_3_1 in var_2_10001(arg_3_0.list) do
			switch = var_2_10006

			var_2_10006(iter_3_1.type, {
				[var_0_1.UNLOCK_TYPE_CHAT] = function()
					getProxy = var_3_10000
					Dorm3dChatProxy = var_3_10002

					local var_4_0 = var_3_10000(var_3_10002)

					var_0.HandleAct(var_4_0, iter_3_1)

					return
				end,
				[var_0_1.UNLOCK_TYPE_PHONE] = function()
					local var_5_0 = arg_1_0

					var_0.UnlockPhone(var_5_0, iter_3_1.ship_id, iter_3_1.act_id, iter_3_1.time)

					return
				end,
				[var_0_1.UNLOCK_TYPE_INS] = function()
					local var_6_0 = arg_1_0

					var_0.UnlockInstagram(var_6_0, iter_3_1.ship_id, iter_3_1.act_id, iter_3_1.time)

					return
				end
			})
		end

		return
	end)

	return
end

function var_0_1.HandleInsData(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	ipairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_1) do
		local var_7_0 = arg_7_0:BuildInstagrams(iter_7_1.ship_group, iter_7_1.friend_list)

		arg_7_0.instagrams[iter_7_1.ship_group] = var_7_0

		local var_7_1 = arg_7_0

		arg_7_0.ExtendPhoneData(var_7_1, iter_7_1.ship_group, iter_7_1.phone_list)

		getProxy = var_8
		Dorm3dChatProxy = var_7_1

		local var_7_2 = var_8(var_7_1)

		var_8.CreateChat(var_7_2, iter_7_1)
	end

	return
end

function var_0_1.BuildInstagrams(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}
	local var_8_1 = {}

	ipairs = var_1_10005

	for iter_8_0, iter_8_1 in var_1_10005(arg_8_2 or {}) do
		var_8_1[iter_8_1.id] = iter_8_1
	end

	pg = var_5

	local var_8_2

	if not var_5.dorm3d_ins_template.get_id_list_by_ship_group[arg_8_1] then
		var_8_2 = {}
	end

	ipairs = var_6

	for iter_8_2, iter_8_3 in var_6(var_8_2) do
		local var_8_3

		if var_8_1[iter_8_3] then
			table = var_8_3
			var_8_3 = var_8_3.insert

			local var_8_4 = var_8_0

			Instagram3Dorm = var_1_10014

			var_8_3(var_8_4, var_1_10014.New(var_8_1[iter_8_3], false))
		else
			table = var_8_3

			local var_8_5 = var_8_3.insert
			local var_8_6 = var_8_0

			Instagram3Dorm = var_1_10014

			var_8_5(var_8_6, var_1_10014.New({
				id = iter_8_3
			}))
		end
	end

	return var_8_0
end

function var_0_1.GetInstagramList(arg_9_0, arg_9_1)
	return arg_9_0.instagrams[arg_9_1]
end

function var_0_1.UnlockInstagram(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0:GetInstagramList(arg_10_1)

	_ = var_1_10005

	if var_1_10005.detect(var_10_0, function(arg_11_0)
		return arg_11_0.id == arg_10_2
	end) then
		var_5:Unlock(arg_10_3)
	end

	return
end

function var_0_1.AnyInstagramShouldTip(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:GetInstagramList(arg_12_1)

	_ = var_1_10003

	return var_1_10003.any(var_12_0 or {}, function(arg_13_0)
		return arg_13_0:ShouldTip()
	end)
end

function var_0_1.AllInstagramShouldTip(arg_14_0)
	_ = var_1_10001

	local var_14_0 = var_1_10001.any

	_ = var_1_10003

	return var_14_0(var_1_10003.keys(arg_14_0.instagrams), function(arg_15_0)
		local var_15_0 = arg_14_0
		local var_15_3

		if var_1.AnyInstagramShouldTip(var_15_0, arg_15_0) then
			local var_15_1 = arg_14_0
			local var_15_2 = var_1.GetRoomByGroupId(var_15_1, arg_15_0)

			var_15_3 = var_1.IsDownloaded(var_15_2)
		end

		return var_15_3
	end)
end

function var_0_1.BuildPhoneData(arg_16_0)
	local var_16_0 = {}

	pairs = var_1_10002
	pg = var_1_10004

	for iter_16_0, iter_16_1 in var_1_10002(var_1_10004.dorm3d_ins_telephone_group.get_id_list_by_ship_group) do
		local var_16_1 = {}

		_ = var_1_10008

		var_1_10008.each(iter_16_1, function(arg_17_0)
			table = var_2_10001

			local var_17_0 = var_2_10001.insert
			local var_17_1 = var_16_1

			Dorm3dInsPhone = var_2_10004

			var_17_0(var_17_1, var_2_10004.New(arg_17_0))

			return
		end)

		var_16_0[iter_16_0] = var_16_1
	end

	return var_16_0
end

function var_0_1.GetPhoneListByGroup(arg_18_0, arg_18_1)
	return arg_18_0.insPhoneData[arg_18_1]
end

function var_0_1.UnlockPhone(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_0:GetPhoneListByGroup(arg_19_1)

	_ = var_1_10005

	if var_1_10005.detect(var_19_0, function(arg_20_0)
		return arg_20_0.id == arg_19_2
	end) then
		var_5:Unlock(arg_19_3)
	end

	return
end

function var_0_1.ExtendPhoneData(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0:GetPhoneListByGroup(arg_21_1)

	ipairs = var_1_10004

	for iter_21_0, iter_21_1 in var_1_10004(arg_21_2) do
		_ = var_1_10009

		if var_1_10009.detect(var_21_0, function(arg_22_0)
			return arg_22_0.id == iter_21_1.id
		end) then
			var_1_10009:ExtendsData(iter_21_1)
		end
	end

	return
end

function var_0_1.ShoudTipPhoneById(arg_23_0, arg_23_1)
	if not arg_23_0:GetPhoneListByGroup(arg_23_1) then
		return false
	end

	_ = var_1_10003

	return var_1_10003.any(var_2, function(arg_24_0)
		return arg_24_0:ShouldTip()
	end)
end

function var_0_1.AnyPhoneShouldTip(arg_25_0)
	_ = var_1_10001

	local var_25_0 = var_1_10001.any

	_ = var_1_10003

	return var_25_0(var_1_10003.keys(arg_25_0.insPhoneData), function(arg_26_0)
		local var_26_0 = arg_25_0

		return var_1.ShoudTipPhoneById(var_26_0, arg_26_0)
	end)
end

function var_0_1.BuildRoomList(arg_27_0)
	local var_27_0 = {}

	_ = var_1_10002

	local var_27_1 = var_1_10002.each

	pg = var_1_10004

	var_27_1(var_1_10004.dorm3d_rooms.all, function(arg_28_0)
		pg = var_2_10001

		local var_28_0

		if var_2_10001.dorm3d_rooms[arg_28_0].type == 1 then
			pg = var_28_0

			if #var_28_0.dorm3d_rooms[arg_28_0].character_pay > 0 then
				table = var_28_0
				var_28_0 = var_28_0.insert

				local var_28_1 = var_27_0

				Dorm3dInsPublicRoom = var_2_10004

				var_28_0(var_28_1, var_2_10004.New(arg_28_0))

				goto label_28_0
			end
		end

		pg = var_28_0

		if var_28_0.dorm3d_rooms[arg_28_0].type == 2 then
			table = var_1

			local var_28_2 = var_1.insert
			local var_28_3 = var_27_0

			Dorm3dInsCharRoom = var_2_10004

			var_28_2(var_28_3, var_2_10004.New(arg_28_0))
		end

		::label_28_0::

		return
	end)

	return var_27_0
end

function var_0_1.GetRoomList(arg_29_0)
	return arg_29_0.insRoomList
end

function var_0_1.GetRoomById(arg_30_0, arg_30_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_30_0.insRoomList, function(arg_31_0)
		return arg_31_0.id == arg_30_1
	end)
end

function var_0_1.GetRoomByGroupId(arg_32_0, arg_32_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_32_0.insRoomList, function(arg_33_0)
		return arg_33_0:GetType() == 2 and arg_33_0.groupId == arg_32_1
	end)
end

return var_0_1
