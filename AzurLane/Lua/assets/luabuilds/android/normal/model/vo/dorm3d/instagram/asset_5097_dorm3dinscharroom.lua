class = var_0_10000

local var_0_0 = "Dorm3dInsCharRoom"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".Dorm3dInsRoom"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0

	arg_1_0.groupId = arg_1_0.GetConfig(var_1_0, "character")[1]
	getProxy = var_2
	Dorm3dChatProxy = var_1_0

	local var_1_1 = var_2(var_1_0)

	arg_1_0.isCare = var_2.GetChatCare(var_1_1, arg_1_0.groupId) == 1

	return
end

function var_0_1.GetName(arg_2_0)
	ShipGroup = var_1_10001

	return var_1_10001.getDefaultShipNameByGroupID(arg_2_0.groupId)
end

function var_0_1.GetFurnitureNum(arg_3_0)
	getProxy = var_1_10001
	ApartmentProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)

	if not var_1.getRoom(var_3_0, arg_3_0.id) then
		return 0
	end

	_ = var_3_0

	return #var_3_0.keys(var_1:GetFurnitures())
end

function var_0_1.GetGiftNum(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.dorm3d_gift.get_id_list_by_ship_group_id[arg_4_0.groupId]

	getProxy = var_2
	ApartmentProxy = var_1_10003

	local var_4_1 = var_2(var_1_10003)

	_ = var_1_10003

	return var_1_10003.reduce(var_4_0, 0, function(arg_5_0, arg_5_1)
		local var_5_0 = var_4_1

		return arg_5_0 + var_2.GetGiftShopCount(var_5_0, arg_5_1)
	end)
end

function var_0_1.GetLastVisit(arg_6_0)
	getProxy = var_1_10001
	ApartmentProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)
	local var_6_1

	if not var_1.getApartment(var_6_0, arg_6_0.groupId) or not var_1.visitTime then
		var_6_1 = 0
	end

	if var_6_1 == 0 then
		i18n = var_3

		return var_3("dorm3d_privatechat_no_visit_time")
	end

	math = var_3

	local var_6_2 = var_3.floor

	pg = var_1_10004

	local var_6_3 = var_1_10004.TimeMgr.GetInstance()

	if var_6_2((var_4.GetServerTime(var_6_3) - var_6_1) / 0) == 0 then
		i18n = var_6_4

		local var_6_4

		if not var_6_4("dorm3d_privatechat_visit_time_now") then
			i18n = var_6_4
			var_6_4 = var_6_4("dorm3d_privatechat_visit_time", var_3)
		end

		return var_6_4
	end
end

function var_0_1.GetFavorLevel(arg_7_0)
	getProxy = var_1_10001
	ApartmentProxy = var_1_10002

	local var_7_0 = var_1_10001(var_1_10002)
	local var_7_1

	if not var_1.getApartment(var_7_0, arg_7_0.groupId) or not var_1.level then
		var_7_1 = 0
	end

	return var_7_1
end

function var_0_1.GetCard(arg_8_0)
	Apartment = var_1_10001

	local var_8_0 = var_1_10001.New({
		ship_group = arg_8_0.groupId
	})
	local var_8_1 = var_1.GetSkinModelID(var_8_0, arg_8_0:GetConfig("tag"))

	string = var_8_0

	return var_8_0.format("dorm3dselect/apartment_skin_%d", var_8_1)
end

function var_0_1.IsCare(arg_9_0)
	return arg_9_0.isCare
end

function var_0_1.SetCare(arg_10_0, arg_10_1)
	arg_10_0.isCare = arg_10_1 == 1
	getProxy = var_2
	Dorm3dChatProxy = var_1_10003

	local var_10_0 = var_2(var_1_10003)

	var_2.SetChatCare(var_10_0, arg_10_0.groupId, arg_10_1)

	return
end

function var_0_1.ShouldTip(arg_11_0)
	local var_11_0 = arg_11_0:GetInsContent()
	local var_11_1 = arg_11_0:GetChatContent()
	local var_11_2 = arg_11_0:GetChatContent()

	return var_11_0 or var_11_1 or var_11_2
end

function var_0_1.GetInsContent(arg_12_0)
	local var_12_0 = arg_12_0

	if arg_12_0.IsDownloaded(var_12_0) then
		getProxy = var_1
		Dorm3dInsProxy = var_12_0
		var_12_0 = var_1(var_12_0)

		if var_1.AnyInstagramShouldTip(var_12_0, arg_12_0.groupId) then
			local var_12_1 = true

			i18n = var_12_0
			var_12_0 = var_12_0("dorm3d_privatechat_new_topics", arg_12_0:GetConfig("room"))

			do return end

			goto label_12_0
		end
	end

	do
		local var_12_2 = false

		i18n = var_12_0

		local var_12_3 = var_12_0("dorm3d_privatechat_nonew_topics")

		return
	end

	::label_12_0::

	return
end

function var_0_1.GetPhoneContent(arg_13_0)
	local var_13_0 = arg_13_0

	if arg_13_0.IsDownloaded(var_13_0) then
		getProxy = var_1
		Dorm3dInsProxy = var_13_0
		var_13_0 = var_1(var_13_0)

		if var_1.ShoudTipPhoneById(var_13_0, arg_13_0.groupId) then
			local var_13_1 = true

			i18n = var_13_0
			var_13_0 = var_13_0("dorm3d_privatechat_new_calls")

			do return end

			goto label_13_0
		end
	end

	do
		local var_13_2 = false

		i18n = var_13_0

		local var_13_3 = var_13_0("dorm3d_privatechat_nonew_calls")

		return
	end

	::label_13_0::

	return
end

function var_0_1.GetChatContent(arg_14_0)
	local var_14_0 = arg_14_0

	if arg_14_0.IsDownloaded(var_14_0) then
		getProxy = var_1
		Dorm3dChatProxy = var_14_0
		var_14_0 = var_1(var_14_0)

		if var_1.ShouldShowShipTip(var_14_0, arg_14_0.groupId) then
			local var_14_1 = true

			i18n = var_14_0
			var_14_0 = var_14_0("dorm3d_privatechat_nonew_messages")

			do return end

			goto label_14_0
		end
	end

	do
		local var_14_2 = false

		i18n = var_14_0

		local var_14_3 = var_14_0("dorm3d_privatechat_new_messages")

		return
	end

	::label_14_0::

	return
end

return var_0_1
