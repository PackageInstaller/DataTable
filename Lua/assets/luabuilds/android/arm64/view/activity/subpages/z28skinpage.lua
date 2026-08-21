local var_0_0 = class("Z28SkinPage", import(".NewYearSnackPage"))

function var_0_0.OnDataSetting(arg_1_0)
	local var_1_0 = getProxy(MiniGameProxy):GetHubByHubId((arg_1_0.activity:getConfig("config_id")))

	arg_1_0.needCount = var_1_0:getConfig("reward_need")
	arg_1_0.leftCount = var_1_0.count
	arg_1_0.playedCount = var_1_0.usedtime
	arg_1_0.isGotAward = var_1_0.ultimate > 0
	arg_1_0.curDay = arg_1_0.leftCount + arg_1_0.playedCount

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0.progressUIItemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			arg_3_1 = arg_3_1 + 1

			local var_3_0 = arg_3_2:Find("Unlocked")
			local var_3_1 = arg_3_2:Find("Finished")
			local var_3_2 = arg_3_2:Find("FinalFinished")

			setActive(arg_3_2:Find("Locked"), arg_3_1 > arg_2_0.curDay)

			if arg_3_1 <= arg_2_0.curDay then
				setActive(var_3_0, arg_3_1 > arg_2_0.playedCount)
				setActive(var_3_1, arg_3_1 <= arg_2_0.playedCount and arg_3_1 ~= arg_2_0.needCount)
				setActive(var_3_2, arg_3_1 <= arg_2_0.playedCount and arg_3_1 == arg_2_0.needCount)
			else
				setActive(var_3_0, false)
				setActive(var_3_1, false)
				setActive(var_3_2, false)
			end
		end

		return
	end)

	local var_2_0 = 36

	onButton(arg_2_0, arg_2_0.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_2_0, {
			callback = function()
				local var_5_0 = Context.New()

				SCENE.SetSceneInfo(var_5_0, SCENE.NEWYEAR_BACKHILL_2022)
				getProxy(ContextProxy):PushContext2Prev(var_5_0)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("help_xinnian2022_z28")
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_7_0)
	arg_7_0.progressUIItemList:align(arg_7_0.needCount)
	arg_7_0:tryGetFinalAward()

	return
end

function var_0_0.OnDestroy(arg_8_0)
	return
end

function var_0_0.tryGetFinalAward(arg_9_0)
	local var_9_0 = getProxy(MiniGameProxy):GetHubByHubId((arg_9_0.activity:getConfig("config_id")))
	local var_9_1 = var_9_0.ultimate > 0

	if var_9_0:getConfig("reward_need") <= var_9_0.usedtime and not var_9_1 then
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_9_0.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

return var_0_0
