class = var_0_10000

local var_0_0 = "ApartmentRoomInviteUnlockCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().roomId
	local var_1_1 = var_2.groupId

	getProxy = var_1_10005
	ApartmentProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.getRoom(var_1_2, var_1_0)

	assert = var_1_2
	underscore = var_8

	var_1_2(var_8.any(var_1_3:getConfig("character_pay"), function(arg_2_0)
		return arg_2_0 == var_1_1
	end))

	Apartment = var_1_2

	local var_1_4 = var_1_2.getGroupConfig
	local var_1_5 = var_1_1
	local var_1_6 = var_1_3
	local var_1_7 = var_1_4(var_1_5, var_1_3.getConfig(var_1_6, "invite_cost"))

	CommonCommodity = var_1_5

	local var_1_8 = var_1_5.New
	local var_1_9 = {
		id = var_1_7
	}

	Goods = var_1_6

	local var_1_10 = var_1_8(var_1_9, var_1_6.TYPE_SHOPSTREET)
	local var_1_11, var_1_12, var_1_13 = var_8.GetPrice(var_1_10)

	Drop = var_1_10012

	local var_1_14 = var_1_10012.New
	local var_1_15 = {}

	DROP_TYPE_RESOURCE = var_1_10014
	var_1_15.type = var_1_10014
	var_1_15.id = var_8:GetResType()
	var_1_15.count = var_1_11

	local var_1_16 = var_1_14(var_1_15)
	local var_1_18

	if #{
		var_1_16
	} > 0 then
		underscore = var_1_18

		if var_1_18.any(var_13, function(arg_3_0)
			return arg_3_0:getOwnedCount() < arg_3_0.count
		end) then
			pg = var_1_18

			local var_1_17 = var_1_18.TipsMgr.GetInstance()

			var_1_18 = var_1_18.ShowTips
			i18n = var_16

			var_1_18(var_1_17, var_16("temple_consume_not_enough"))

			return
		end
	end

	if not var_1_3 or var_1_3.unlockCharacter[var_1_1] then
		pg = var_1_18

		local var_1_19 = var_1_18.TipsMgr.GetInstance()

		var_1_18 = var_1_18.ShowTips

		local var_1_20 = "unlock error:%d, %d"
		local var_1_21 = var_1_3 and var_1_0 or 0
		local var_1_22

		if not var_1_3 or not var_1_3.unlockCharacter[var_1_1] then
			var_1_22 = 0
		end

		var_1_18(var_1_19, var_1_20, var_1_21, var_1_22)

		return
	end

	pg = var_1_18

	local var_1_23 = var_1_18.ConnectionMgr.GetInstance()

	var_14.Send(var_1_23, 28019, {
		room_id = var_1_0,
		ship_group = var_1_1
	}, 28020, function(arg_4_0)
		local var_4_2

		if arg_4_0.result == 0 then
			ipairs = var_4_2

			for iter_4_0, iter_4_1 in var_4_2(var_0) do
				reducePlayerOwn = var_2_10006

				var_2_10006(iter_4_1)
			end

			local var_4_0 = var_0

			var_4_2.ModifyRoom(var_4_0, var_1_0, function(arg_5_0)
				arg_5_0.unlockCharacter[var_1_1] = true

				return
			end)

			local var_4_1 = arg_1_0

			var_4_2 = var_4_2.sendNotification
			GAME = var_2_10003

			var_4_2(var_4_1, var_2_10003.APARTMENT_ROOM_INVITE_UNLOCK_DONE, {
				roomId = var_1_0,
				groupId = var_1_1
			})
		else
			pg = var_4_2

			local var_4_3 = var_4_2.TipsMgr.GetInstance()
			local var_4_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_4_4(var_4_3, var_2_10003[arg_4_0.result] .. arg_4_0.result)
		end

		return
	end)

	return
end

return var_0_1
