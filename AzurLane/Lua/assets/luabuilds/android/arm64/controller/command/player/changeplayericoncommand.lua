class = var_0_10000

local var_0_0 = "ChangePlayerIconCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().skinPage
	local var_1_1 = var_2.after
	local var_1_2 = var_2.callback

	getProxy = var_1_10006
	PlayerProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)
	local var_1_4 = var_6.getData(var_1_3)
	local var_1_5 = var_7.GetShipPhantomMarks(var_1_4)

	if #var_1_1 <= 0 then
		pg = var_9
		var_1_10011 = var_9.TipsMgr.GetInstance()

		local var_1_6 = var_9.ShowTips

		i18n = var_1_10012

		var_1_6(var_1_10011, var_1_10012("common_error"))

		return
	end

	if #var_1_5 == #var_1_1 then
		underscore = var_9

		local var_1_7 = var_9.all

		underscore = var_1_10011

		if var_1_7(var_1_10011.keys(var_1_1), function(arg_2_0)
			return var_1_5[arg_2_0] == var_1_1[arg_2_0]
		end) then
			local var_1_9

			if var_1_0 then
				pg = var_1_9

				local var_1_8 = var_1_9.TipsMgr.GetInstance()

				var_1_9 = var_1_9.ShowTips
				i18n = var_12

				var_1_9(var_1_8, var_12("change_skin_secretary_ship"))
			end

			existCall = var_1_9

			var_1_9(var_1_2)

			return
		end
	end

	for iter_1_0 = #var_1_1, 1, -1 do
		for iter_1_1 = iter_1_0 - 1, 1, -1 do
			print = var_1_10017

			var_1_10017(var_1_1[iter_1_0], var_1_1[iter_1_1])

			if var_1_1[iter_1_0] == var_1_1[iter_1_1] then
				table = var_1_10017

				var_1_10017.remove(var_1_1, iter_1_0)

				break
			end
		end
	end

	underscore = var_9

	local var_1_10 = var_9.map(var_1_1, function(arg_3_0)
		ShipPhantom = var_2_10001

		local var_3_0, var_3_1 = var_2_10001.UnpackMark(arg_3_0)

		return {
			key = var_3_0,
			value = var_3_1
		}
	end)

	pg = var_10

	local var_1_11 = var_10.ConnectionMgr.GetInstance()

	var_10.Send(var_1_11, 11011, {
		character = var_1_10
	}, 11012, function(arg_4_0)
		local var_4_3

		if arg_4_0.result == 0 then
			var_0_1.UpdayePlayerCharas(var_0, var_1_10)

			local var_4_0 = var_0

			var_4_3.updatePlayer(var_4_0, var_0)

			pg = var_4_3

			local var_4_1 = var_4_3.ShipFlagMgr.GetInstance()

			var_4_3.UpdateFlagShips(var_4_1, "inAdmiral")

			if var_1_0 then
				pg = var_4_3

				local var_4_2 = var_4_3.TipsMgr.GetInstance()

				var_4_3 = var_4_3.ShowTips
				i18n = var_2_10004

				var_4_3(var_4_2, var_2_10004("change_skin_secretary_ship"))
			else
				pg = var_4_3

				local var_4_4 = var_4_3.TipsMgr.GetInstance()

				var_4_3 = var_4_3.ShowTips
				i18n = var_2_10004

				var_4_3(var_4_4, var_2_10004("player_changePlayerIcon_ok"))
			end

			local var_4_5 = arg_1_0

			var_4_3 = var_4_3.sendNotification
			GAME = var_2_10004

			var_4_3(var_4_5, var_2_10004.CHANGE_PLAYER_ICON_DONE)
		else
			pg = var_4_3

			local var_4_6 = var_4_3.TipsMgr.GetInstance()

			var_4_3 = var_4_3.ShowTips
			errorTip = var_2_10004

			var_4_3(var_4_6, var_2_10004("player_changePlayerIcon", arg_4_0.result))
		end

		existCall = var_4_3

		var_4_3(var_1_2)

		return
	end)

	return
end

function var_0_1.UpdayePlayerCharas(arg_5_0, arg_5_1)
	underscore = var_1_10002
	arg_5_0.characters = var_1_10002.map(arg_5_1, function(arg_6_0)
		return arg_6_0.key
	end)
	underscore = var_2
	arg_5_0.phantoms = var_2.map(arg_5_1, function(arg_7_0)
		return arg_7_0.value
	end)
	arg_5_0.character = arg_5_0.characters[1]

	local var_5_0

	if not arg_5_0.phantoms[1] then
		var_5_0 = 0
	end

	arg_5_0.phantomId = var_5_0
	ShipPhantom = var_5_0

	local var_5_1 = var_5_0.Change

	getProxy = var_4
	BayProxy = var_1_10006

	local var_5_2 = var_4(var_1_10006)

	arg_5_0.icon = var_5_1(var_4.getShipById(var_5_2, arg_5_0.character), arg_5_0.phantoms[1]).configId
	arg_5_0.skinId = var_2:getSkinId()

	return
end

return var_0_1
