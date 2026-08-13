class = var_0_10000

local var_0_0 = "SelectFleetCommanderCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().fleetId
	local var_1_1 = var_2.pos
	local var_1_2 = var_2.commanderId
	local var_1_3 = var_2.callback

	getProxy = var_1_10007
	FleetProxy = var_1_10009

	local var_1_4 = var_1_10007(var_1_10009)
	local var_1_5 = var_7.getFleetById(var_1_4, var_1_0)
	local var_1_6 = var_7.getCommanderByPos(var_1_5, var_1_1)
	local var_1_7 = var_7
	local var_1_8 = var_7.getCommanders(var_1_7)

	if not var_1_6 or var_1_6.id ~= var_1_2 then
		getProxy = var_1_5
		CommanderProxy = var_1_10012

		local var_1_9 = var_1_5(var_1_10012)
		local var_1_10 = var_10.getCommanderById(var_1_9, var_1_2)

		pairs = var_1_7

		for iter_1_0, iter_1_1 in var_1_7(var_1_8) do
			if iter_1_1.groupId == var_1_10.groupId and iter_1_0 ~= var_1_1 and var_1_2 ~= iter_1_1.id then
				pg = var_16

				local var_1_11 = var_16.TipsMgr.GetInstance()
				local var_1_12 = var_16.ShowTips

				i18n = var_1_10019

				var_1_12(var_1_11, var_1_10019("commander_can_not_select_same_group"))

				return
			end
		end
	end

	local function var_1_13(arg_2_0)
		getProxy = var_2_10001
		FleetProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)
		local var_2_1 = var_1.getCommanders(var_2_0)

		ipairs = var_2_10002

		for iter_2_0, iter_2_1 in var_2_10002(var_2_1) do
			if iter_2_1.fleetId ~= var_1_0 and iter_2_1.commanderId == arg_2_0 then
				return true, iter_2_1
			end
		end

		return false
	end

	local function var_1_14(arg_3_0)
		local var_3_0 = var_1_1 == 2 and 1 or 2

		if var_1_8[var_3_0] and var_2.id == arg_3_0 then
			return true, var_3_0
		end

		return false
	end

	local var_1_15 = {}
	local var_1_16 = true
	local var_1_17, var_1_18 = var_1_13(var_1_2)

	if var_1_17 then
		table = var_16

		var_16.insert(var_1_15, function(arg_4_0)
			if var_1_18.pos == 1 then
				i18n = var_4_0

				local var_4_0

				if not var_4_0("commander_main_pos") then
					i18n = var_4_0
					var_4_0 = var_4_0("commander_assistant_pos")
				end

				Fleet = var_2_10002

				local var_4_1 = var_2_10002.DEFAULT_NAME[var_1_18.fleetId]

				pg = var_3

				local var_4_2 = var_3.MsgboxMgr.GetInstance()
				local var_4_3 = var_3.ShowMsgBox
				local var_4_4 = {}

				i18n = var_2_10007
				var_4_4.content = var_2_10007("comander_repalce_tip", var_4_1, var_4_0)

				function var_4_4.onYes()
					pg = var_3_10000

					local var_5_0 = var_3_10000.m02
					local var_5_1 = var_0.sendNotification

					GAME = var_3_10003

					var_5_1(var_5_0, var_3_10003.COOMMANDER_EQUIP_TO_FLEET, {
						commanderId = 0,
						fleetId = var_1_18.fleetId,
						pos = var_1_18.pos,
						callback = arg_4_0
					})

					return
				end

				function var_4_4.onNo()
					var_1_16 = false

					arg_4_0()

					return
				end

				var_4_3(var_4_2, var_4_4)

				return
			end
		end)
	end

	local var_1_19, var_1_20 = var_1_14(var_1_2)

	if var_1_19 then
		table = var_18

		var_18.insert(var_1_15, function(arg_7_0)
			pg = var_2_10001

			local var_7_0 = var_2_10001.m02
			local var_7_1 = var_1.sendNotification

			GAME = var_2_10004

			var_7_1(var_7_0, var_2_10004.COOMMANDER_EQUIP_TO_FLEET, {
				commanderId = 0,
				fleetId = var_1_0,
				pos = var_1_20,
				callback = arg_7_0
			})

			return
		end)
	end

	table = var_18

	var_18.insert(var_1_15, function(arg_8_0)
		if var_1_16 then
			pg = var_1

			local var_8_0 = var_1.m02
			local var_8_1 = var_1.sendNotification

			GAME = var_2_10004

			var_8_1(var_8_0, var_2_10004.COOMMANDER_EQUIP_TO_FLEET, {
				fleetId = var_1_0,
				pos = var_1_1,
				commanderId = var_1_2,
				callback = function(arg_9_0)
					arg_8_0()

					return
				end
			})
		else
			arg_8_0()
		end

		return
	end)

	seriesAsync = var_18

	var_18(var_1_15, var_1_3)

	return
end

return var_0_1
