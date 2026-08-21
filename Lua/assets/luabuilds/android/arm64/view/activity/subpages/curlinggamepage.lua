local var_0_0 = class("CurlingGamePage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.progressTpl = arg_1_0._tf:Find("ProgressTpl")
	arg_1_0.progressTplContainer = arg_1_0._tf:Find("ProgressList")
	arg_1_0.progressUIItemList = UIItemList.New(arg_1_0.progressTplContainer, arg_1_0.progressTpl)
	arg_1_0.goBtn = arg_1_0._tf:Find("GoBtn")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	local var_2_0 = getProxy(MiniGameProxy):GetHubByHubId((arg_2_0.activity:getConfig("config_id")))

	arg_2_0.needCount = var_2_0:getConfig("reward_need")
	arg_2_0.leftCount = var_2_0.count
	arg_2_0.playedCount = var_2_0.usedtime
	arg_2_0.isGotAward = var_2_0.ultimate > 0
	arg_2_0.curDay = arg_2_0.leftCount + arg_2_0.playedCount

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	arg_3_0.progressUIItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			arg_4_1 = arg_4_1 + 1

			local var_4_0 = arg_4_2:Find("Unlocked")
			local var_4_1 = arg_4_2:Find("Finished")

			setActive(arg_4_2:Find("Current"), arg_4_1 == arg_3_0.playedCount)

			if arg_4_1 <= arg_3_0.curDay then
				setActive(var_4_0, arg_4_1 > arg_3_0.playedCount)
				setActive(var_4_1, arg_4_1 <= arg_3_0.playedCount and arg_4_1 ~= arg_3_0.needCount)
			else
				setActive(var_4_0, false)
				setActive(var_4_1, false)
			end
		end

		return
	end)
	arg_3_0.progressUIItemList:align(arg_3_0.needCount)
	onButton(arg_3_0, arg_3_0.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 33)

		return
	end, SFX_PANEL)
	arg_3_0:tryGetFinalAward()

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	return
end

function var_0_0.OnDestroy(arg_7_0)
	return
end

function var_0_0.tryGetFinalAward(arg_8_0)
	local var_8_0 = getProxy(MiniGameProxy):GetHubByHubId((arg_8_0.activity:getConfig("config_id")))
	local var_8_1 = var_8_0.ultimate > 0

	if var_8_0:getConfig("reward_need") <= var_8_0.usedtime and not var_8_1 then
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_8_0.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

return var_0_0
