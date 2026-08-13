class = var_0_10000

local var_0_0 = "ChangeSkinABCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().skin_id

	ShipSkin = var_1_10004

	local var_1_1 = var_1_10004.GetChangeSkinNextId(var_1_0)

	getProxy = var_5
	PlayerProxy = var_1_10006

	local var_1_2 = var_5(var_1_10006)
	local var_1_3 = var_5.getRawData(var_1_2)
	local var_1_4 = var_5.GetFlagShip(var_1_3)

	if var_1_0 ~= var_5.getSkinId(var_1_4) then
		return
	end

	pg = var_6

	local var_1_5 = var_6.ChangeSkinMgr.GetInstance()

	if not var_6.isAble(var_1_5) then
		return
	end

	pg = var_6

	local var_1_6 = var_6.ChangeSkinMgr.GetInstance()

	var_6.preloadChangeAction(var_1_6, var_1_1, function()
		local var_2_0 = arg_1_0

		var_0.startChangeAction(var_2_0, var_1_0, var_1_1, var_0)

		return
	end)

	return
end

function var_0_1.startChangeAction(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	getProxy = var_1_10004
	SettingsProxy = var_1_10005

	local var_3_0 = var_1_10004(var_1_10005)
	local var_3_1 = var_4.getCharacterSetting
	local var_3_2 = arg_3_3.id

	SHIP_FLAG_L2D = var_1_10007

	if var_3_1(var_3_0, var_3_2, var_1_10007) then
		Live2dConst = var_3_0

		if var_3_0.GetLive2DArm32MatchAble() then
			getProxy = var_3_0
			SettingsProxy = var_3_2
			var_3_2 = var_3_0(var_3_2)
			var_3_0 = var_3_0.setCharacterSetting
			var_1_10007 = arg_3_3.id
			SHIP_FLAG_L2D = var_1_10008

			var_3_0(var_3_2, var_1_10007, var_1_10008, false)

			goto label_3_0
		end
	end

	if not var_4 then
		Live2dConst = var_3_0

		if not var_3_0.GetLive2DArm32MatchAble() then
			getProxy = var_5
			SettingsProxy = var_3_2

			local var_3_3 = var_5(var_3_2)
			local var_3_4 = var_5.setCharacterSetting

			var_1_10007 = arg_3_3.id
			SHIP_FLAG_L2D = var_1_10008

			var_3_4(var_3_3, var_1_10007, var_1_10008, true)
		end
	end

	::label_3_0::

	local var_3_5 = arg_3_0
	local var_3_6 = arg_3_0.sendNotification

	GAME = var_1_10007

	var_3_6(var_3_5, var_1_10007.PLAY_CHANGE_SKIN_OUT, {
		callback = function(arg_4_0)
			local var_4_0 = arg_4_0.flag
			local var_4_1 = arg_4_0.tip

			if var_4_0 then
				ShipSkin = var_2_10003
				var_2_10003 = var_2_10003.SetStoreChangeSkinId

				local var_4_2 = arg_3_2
				local var_4_3 = arg_3_3

				var_2_10003(var_4_2, var_5.GetShipPhantomMark(var_4_3))

				ShipSkin = var_2_10003
				var_2_10003 = var_2_10003.GetChangeSkinCustomDataId(arg_3_2, "asmr") == 1 and true or false
				pg = var_4

				local var_4_4 = var_4.ChangeSkinMgr.GetInstance()

				var_4.play(var_4_4, arg_3_2, function()
					local var_5_0 = arg_3_0
					local var_5_1 = var_0.sendNotification

					GAME = var_3_10002

					var_5_1(var_5_0, var_3_10002.CHANGE_SKIN_EXCHANGE, {
						callback = function()
							return
						end,
						asmr = var_2_10003
					})

					return
				end, function()
					local var_7_0 = arg_3_0
					local var_7_1 = var_0.sendNotification

					GAME = var_3_10002

					var_7_1(var_7_0, var_3_10002.PLAY_CHANGE_SKIN_IN)

					return
				end, function()
					local var_8_0 = arg_3_0
					local var_8_1 = var_0.sendNotification

					GAME = var_3_10002

					var_8_1(var_8_0, var_3_10002.PLAY_CHANGE_SKIN_FINISH)

					return
				end)
			end

			if var_4_1 then
				pg = var_2_10003

				local var_4_5 = var_2_10003.TipsMgr.GetInstance()

				var_3.ShowTips(var_4_5, arg_3_1)
			end

			return
		end
	})

	return
end

return var_0_1
