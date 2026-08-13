class = var_0_10000

local var_0_0 = "GetCommanderCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.callback

	defaultValue = var_1_10005

	local var_1_2 = var_1_10005(var_2.notify, true)

	getProxy = var_1_10006
	CommanderProxy = var_8

	local var_1_3 = var_1_10006(var_8)
	local var_1_4 = var_6.getBoxById(var_1_3, var_1_0)

	getProxy = var_8
	PlayerProxy = var_10

	local var_1_5 = var_8(var_10)
	local var_1_6 = var_8.getRawData(var_1_5).commanderBagMax
	local var_1_7 = var_6

	if var_1_6 <= var_6.getCommanderCnt(var_1_7) then
		pg = var_1_6

		local var_1_8 = var_1_6.TipsMgr.GetInstance()
		local var_1_9 = var_9.ShowTips

		i18n = var_1_7

		var_1_9(var_1_8, var_1_7("commander_capcity_is_max"))

		if var_1_1 then
			var_1_1()
		end

		return
	end

	local var_1_10 = var_1_4:getState()

	CommanderBox = var_10

	if var_1_10 ~= var_10.STATE_FINISHED then
		return
	end

	pg = var_1_10

	local var_1_11 = var_1_10.ConnectionMgr.GetInstance()

	var_9.Send(var_1_11, 25004, {
		boxid = var_1_0
	}, 25005, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			Commander = var_2_0
			var_2_0 = var_2_0.New(arg_2_0.commander)
			var_2_10004 = var_0

			var_2.addCommander(var_2_10004, var_2_0)

			var_2_10004 = var_1_4

			var_2.finish(var_2_10004)

			if var_1_2 then
				var_2_10004 = arg_1_0

				local var_2_1 = var_2.sendNotification

				GAME = var_5

				var_2_1(var_2_10004, var_5.COMMANDER_ON_OPEN_BOX_DONE, {
					commander = var_2_0:clone(),
					boxId = var_1_0,
					callback = var_1_1
				})
			elseif var_1_1 then
				var_1_1(var_2_0)
			end
		else
			pg = var_2_0

			local var_2_2 = var_2_0.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			i18n = var_2_10004

			var_2_3(var_2_2, var_2_10004("commander_acquire_erro", arg_2_0.result))

			if var_1_1 then
				var_1_1()
			end
		end

		return
	end)

	return
end

return var_0_1
