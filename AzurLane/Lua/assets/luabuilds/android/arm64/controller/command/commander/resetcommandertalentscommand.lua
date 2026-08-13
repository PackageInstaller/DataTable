class = var_0_10000

local var_0_0 = "ResetCommanderTalentsCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	getProxy = var_1_0
	CommanderProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	if not var_4.getCommanderById(var_1_2, var_1_1) then
		return
	end

	pg = var_1_10006

	local var_1_3 = var_1_10006.TimeMgr.GetInstance()
	local var_1_4 = var_6.GetServerTime(var_1_3)
	local var_1_5 = var_5

	if var_1_4 < var_5.GetNextResetAbilityTime(var_1_5) then
		pg = var_1_4

		local var_1_6 = var_1_4.TipsMgr.GetInstance()
		local var_1_7 = var_6.ShowTips

		i18n = var_1_5

		var_1_7(var_1_6, var_1_5("commander_reset_talent_time_no_rearch"))

		return
	end

	local var_1_8 = var_5:getTalentOrigins()
	local var_1_9 = var_5:getTalents()
	local var_1_10

	if #var_1_8 == #var_1_9 then
		_ = var_1_10

		if var_1_10.all(var_1_8, function(arg_2_0)
			_ = var_2_10001

			return var_2_10001.any(var_1_9, function(arg_3_0)
				return arg_3_0.id == arg_2_0.id
			end)
		end) then
			pg = var_1_10
			var_1_10010 = var_1_10.TipsMgr.GetInstance()
			var_1_10 = var_1_10.ShowTips
			i18n = var_11

			var_1_10(var_1_10010, var_11("commander_reset_talent_is_not_need"))

			return
		end
	end

	getProxy = var_1_10
	PlayerProxy = var_1_10010

	local var_1_11 = var_1_10(var_1_10010)
	local var_1_12 = var_8.getData(var_1_11)
	local var_1_13 = var_5:getResetTalentConsume()
	local var_1_15

	if var_1_12.gold < var_1_13 then
		pg = var_1_15

		local var_1_14 = var_1_15.TipsMgr.GetInstance()

		var_1_15 = var_1_15.ShowTips
		i18n = var_1_10014

		var_1_15(var_1_14, var_1_10014("common_no_resource"))

		return
	end

	pg = var_1_15

	local var_1_16 = var_1_15.ConnectionMgr.GetInstance()

	var_11.Send(var_1_16, 25014, {
		commanderid = var_1_1
	}, 25015, function(arg_4_0)
		local var_4_7

		if arg_4_0.result == 0 then
			local var_4_0 = var_1_12

			var_4_7.consume(var_4_0, {
				gold = var_1_13
			})

			local var_4_1 = var_0

			var_4_7.updatePlayer(var_4_1, var_1_12)

			local var_4_2 = var_0

			var_4_7.resetTalents(var_4_2)

			local var_4_3 = var_0

			var_4_7.updatePt(var_4_3, 0)

			local var_4_4 = var_0

			var_4_7.updateNotLearnedList(var_4_4, {})

			local var_4_5 = var_0

			var_4_7.updateCommander(var_4_5, var_0)

			local var_4_6 = var_0

			var_4_7 = var_4_7.updateAbilityTime
			pg = var_2_10004

			local var_4_8 = var_2_10004.TimeMgr.GetInstance()

			var_4_7(var_4_6, var_2_10004.GetServerTime(var_4_8))

			local var_4_9 = arg_1_0

			var_4_7 = var_4_7.sendNotification
			GAME = var_2_10004

			var_4_7(var_4_9, var_2_10004.COMMANDER_RESET_TALENTS_DONE)

			pg = var_4_7

			local var_4_10 = var_4_7.TipsMgr.GetInstance()

			var_4_7 = var_4_7.ShowTips
			i18n = var_2_10004

			var_4_7(var_4_10, var_2_10004("commander_reset_talent_success"))
		else
			pg = var_4_7

			local var_4_11 = var_4_7.TipsMgr.GetInstance()
			local var_4_12 = var_1.ShowTips

			i18n = var_2_10004

			var_4_12(var_4_11, var_2_10004("commander_reset_talent_erro", arg_4_0.result))
		end

		return
	end)

	return
end

return var_0_1
