class = var_0_10000

local var_0_0 = "HarvestResourceCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	id2res = var_1_10003

	local var_1_2 = var_1_10003(var_1_1)

	getProxy = var_1_0
	PlayerProxy = var_1_10006

	local var_1_3 = var_1_0(var_1_10006)
	local var_1_4 = var_4.getData(var_1_3)
	local var_1_5

	if var_1_1 == 1 then
		var_1_5 = var_1_4:getLevelMaxGold()
	elseif var_1_1 == 2 then
		var_1_5 = var_1_4:getLevelMaxOil()
	else
		assert = var_1_3

		var_1_3(false)
	end

	local var_1_7

	if var_1_5 <= var_1_4[var_1_2] then
		pg = var_1_7

		local var_1_6 = var_1_7.TipsMgr.GetInstance()

		var_1_7 = var_1_7.ShowTips
		i18n = var_1_10010

		var_1_7(var_1_6, var_1_10010("player_harvestResource_error_fullBag"))

		return
	end

	pg = var_1_7

	local var_1_8 = var_1_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_8, 11013, {
		number = 0,
		type = var_1_1
	}, 11014, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = var_1_5 - var_1_4[var_1_2]

			local var_2_1 = 0

			if var_2_0 < var_1_4[var_1_2 .. "Field"] then
				var_2_1 = var_2_0

				local var_2_2 = var_1_4

				var_3.addResources(var_2_2, {
					[var_1_2] = var_2_0
				})

				var_1_4[var_1_2 .. "Field"] = var_1_4[var_1_2 .. "Field"] - var_2_0
			else
				var_2_1 = var_1_4[var_1_2 .. "Field"]

				local var_2_3 = var_1_4

				var_3.addResources(var_2_3, {
					[var_1_2] = var_1_4[var_1_2 .. "Field"]
				})

				var_1_4[var_1_2 .. "Field"] = 0
			end

			local var_2_4 = var_0

			var_3.updatePlayer(var_2_4, var_1_4)

			local var_2_5 = arg_1_0
			local var_2_6 = var_3.sendNotification

			GAME = var_6

			var_2_6(var_2_5, var_6.HARVEST_RES_DONE, {
				type = var_1_1,
				outPut = var_2_1
			})

			pg = var_2_6

			local var_2_7 = var_2_6.CriMgr.GetInstance()
			local var_2_8 = var_3.PlaySoundEffect_V3

			SFX_UI_ACADEMY_GETMATERIAL = var_6

			var_2_8(var_2_7, var_6)
		else
			pg = var_2_0

			local var_2_9 = var_2_0.TipsMgr.GetInstance()
			local var_2_10 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_10(var_2_9, var_2_10004("player_harvestResource", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
