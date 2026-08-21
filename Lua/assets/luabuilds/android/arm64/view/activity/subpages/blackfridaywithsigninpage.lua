local var_0_0 = class("BlackFridayWithSignInPage", import(".BlackFridayPage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.signInUIlist = UIItemList.New(arg_1_0._tf:Find("AD/signIn"), arg_1_0._tf:Find("AD/signIn/award"))
	arg_1_0.toggles = {
		arg_1_0._tf:Find("AD/toggles/skin"),
		arg_1_0._tf:Find("AD/toggles/sign")
	}
	arg_1_0.lockSignBtn = arg_1_0._tf:Find("AD/toggles/sign/lock")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.lockSignBtn, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end, SFX_PANEL)

	arg_2_0.signInActId = arg_2_0.activity:getConfig("config_client")[2]

	arg_2_0:FlushSignInInfo()

	if arg_2_0.contextData.showByNextAct then
		arg_2_0.contextData.showByNextAct = nil

		triggerToggle(arg_2_0.toggles[2], true)
	end

	return
end

function var_0_0.GetSignInAct(arg_4_0)
	return (getProxy(ActivityProxy):getActivityById(arg_4_0.signInActId))
end

function var_0_0.ClientSignInActIsEnd(arg_5_0)
	local var_5_9000
	local var_5_0 = pg.TimeMgr.GetInstance().parseTimeFromConfig(var_5_9000, pg.activity_template[arg_5_0.signInActId].time[3])
	local var_5_1 = pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_template[arg_5_0.signInActId].time[2])
	local var_5_2 = pg.TimeMgr.GetInstance():GetServerTime()

	return var_5_0 < var_5_2 or var_5_2 < var_5_1
end

function var_0_0.FlushSignInInfo(arg_6_0)
	local var_6_0 = arg_6_0:GetSignInAct()
	local var_6_1 = pg.activity_template[arg_6_0.signInActId]
	local var_6_2 = arg_6_0:ClientSignInActIsEnd()
	local var_6_3 = not (var_6_0 and not var_6_0:isEnd()) and var_6_2

	if var_6_3 then
		triggerToggle(arg_6_0.toggles[1], true)
		setToggleEnabled(arg_6_0.toggles[2], false)
	end

	setActive(arg_6_0.lockSignBtn, var_6_3)

	local var_6_4 = pg.activity_7_day_sign[var_6_1.config_id].front_drops

	arg_6_0.signInUIlist:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			updateDrop(arg_7_2, {
				type = var_6_4[arg_7_1 + 1][1],
				id = var_6_4[arg_7_1 + 1][2],
				count = var_6_4[arg_7_1 + 1][3]
			})
			onButton(arg_6_0, arg_7_2, function()
				arg_6_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_6_0.signInUIlist:align(#pg.activity_7_day_sign[var_6_1.config_id].front_drops)

	return
end

function var_0_0.FlushSignAwardsState(arg_9_0)
	local var_9_0 = arg_9_0:GetSignInAct()
	local var_9_1 = var_9_0 and not var_9_0:isEnd() and var_9_0.data1 or 0
	local var_9_2 = arg_9_0:ClientSignInActIsEnd()

	arg_9_0.signInUIlist:each(function(arg_10_0, arg_10_1)
		if not var_9_2 and not var_0 then
			setActive(arg_10_1:Find("got"), true)
		else
			setActive(arg_10_1:Find("got"), arg_10_0 + 1 <= var_9_1)
		end

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_11_0)
	var_0_0.super.OnUpdateFlush(arg_11_0)
	arg_11_0:FlushSignAwardsState()

	return
end

return var_0_0
