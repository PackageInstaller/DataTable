local var_0_0 = class("DecodeMiniGameView", import("..BaseMiniGameView"))

function var_0_0.getUIName(arg_1_0)
	return "DecodeGameUI"
end

function var_0_0.didEnter(arg_2_0)
	arg_2_0.controller = DecodeGameController.New()

	arg_2_0.controller.view:SetUI(arg_2_0._tf)
	arg_2_0.controller:SetCallback(function()
		arg_2_0:emit(var_0_0.ON_BACK)

		return
	end, function(arg_4_0)
		if arg_2_0:GetMGHubData().count > 0 then
			arg_2_0:StoreDataToServer((arg_2_0.controller:GetSaveData()))

			arg_2_0.onGetAward = arg_4_0

			arg_2_0:SendSuccess(0)
		end

		return
	end, function()
		local var_5_0 = arg_2_0:GetMGHubData()

		if var_5_0.ultimate == 0 then
			pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
				hubid = var_5_0.id,
				cmd = MiniGameOPCommand.CMD_ULTIMATE,
				args1 = {}
			})
		end

		return
	end)
	arg_2_0.controller:SetUp((arg_2_0:PackData()))

	return
end

function var_0_0.GetData(arg_6_0, arg_6_1)
	local var_6_0 = PlayerPrefs.GetInt("DecodeGameMapId", 1)
	local var_6_1 = arg_6_1:GetRuntimeData("elements")

	if #var_6_1 ~= arg_6_0.usedtime then
		for iter_6_0 = 1, arg_6_0.usedtime - #var_6_1 do
			(function()
				for iter_7_0 = 1, 60 do
					if not table.contains(var_6_1, iter_7_0) then
						table.insert(var_6_1, iter_7_0)

						break
					end
				end

				return
			end)()
		end

		for iter_6_1 = 1, #var_6_1 - arg_6_0.usedtime do
			(function()
				table.remove(var_6_1, 1)

				return
			end)()
		end
	end

	return {
		mapId = var_6_0,
		unlocks = var_6_1,
		canUseCnt = arg_6_0.count,
		passwords = DecodeGameConst.MAPS_PASSWORD,
		isFinished = arg_6_0.ultimate > 0
	}
end

function var_0_0.PackData(arg_9_0)
	return var_0_0.GetData(arg_9_0:GetMGHubData(), (arg_9_0:GetMGData()))
end

function var_0_0.OnGetAwardDone(arg_10_0, arg_10_1)
	if arg_10_1.cmd == MiniGameOPCommand.CMD_COMPLETE and arg_10_0.onGetAward then
		arg_10_0.onGetAward()

		arg_10_0.onGetAward = nil
	end

	return
end

function var_0_0.willExit(arg_11_0)
	local var_11_0 = arg_11_0.controller.mapId or 1

	PlayerPrefs.SetInt("DecodeGameMapId", var_11_0)
	PlayerPrefs.Save()
	arg_11_0.controller:Dispose()

	return
end

return var_0_0
