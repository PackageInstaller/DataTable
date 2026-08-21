local var_0_0 = class("BlackFridayWithManualSignPage", import(".BlackFridayPage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.signList = UIItemList.New(arg_1_0._tf:Find("AD/singlist"), arg_1_0._tf:Find("AD/singlist/Award"))
	arg_1_0.signBtn = arg_1_0._tf:Find("AD/signBtn")

	setText(arg_1_0.signBtn:Find("Text"), i18n("SkinMagazinePage2_tip"))

	return
end

function var_0_0.GetPageLink(arg_2_0)
	return {
		arg_2_0.activity:getConfig("config_client")[2]
	}
end

function var_0_0.OnFirstFlush(arg_3_0)
	var_0_0.super.OnFirstFlush(arg_3_0)

	arg_3_0.signInActId = arg_3_0.activity:getConfig("config_client")[2]

	return
end

function var_0_0.FlushSignBtn(arg_4_0)
	local var_4_0 = getProxy(ActivityProxy):getActivityById(arg_4_0.signInActId)
	local var_4_1 = not var_4_0 or var_4_0:isEnd()

	onButton(arg_4_0, arg_4_0.signBtn, function()
		arg_4_0:Sign(var_4_0)

		return
	end, SFX_PANEL)
	setActive(arg_4_0.signBtn, not var_4_1 and var_4_0:AnyAwardCanGet())

	return
end

function var_0_0.FlushSignActivity(arg_6_0)
	local var_6_0 = getProxy(ActivityProxy):getActivityById(arg_6_0.signInActId)

	if not var_6_0 or var_6_0:isEnd() then
		arg_6_0:FlushEmptyList()
	else
		arg_6_0:FlushSignList(var_6_0)
	end

	return
end

function var_0_0.FlushEmptyList(arg_7_0)
	arg_7_0.signList:align(0)

	return
end

function var_0_0.FlushSignList(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:GetDropList()
	local var_8_1 = arg_8_1:GetCanGetAwardIndexList()
	local var_8_2 = {}
	local var_8_3 = arg_8_1:getConfig("config_client")
	local var_8_4 = type(var_8_3) == "table" and var_8_3 or {}

	arg_8_0.signList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = arg_8_1:GetAwardState(arg_9_1 + 1)

			arg_8_0:UpdateSignAward(arg_8_1, var_9_0, var_8_0[arg_9_1 + 1], arg_9_2)

			if var_9_0 == ManualSignActivity.STATE_GOT then
				table.insert(var_8_2, var_8_4[arg_9_1 + 1])
			end
		end

		return
	end)
	arg_8_0.signList:align(#var_8_0)
	arg_8_0:TryPlayStory(var_8_2)

	return
end

function var_0_0.TryPlayStory(arg_10_0, arg_10_1)
	if #arg_10_1 <= 0 then
		return
	end

	local var_10_0 = _.select(arg_10_1, function(arg_11_0)
		return not pg.NewStoryMgr.GetInstance():IsPlayed(arg_11_0)
	end)

	if #var_10_0 > 0 then
		pg.NewStoryMgr.GetInstance():SeriesPlay(var_10_0)
	end

	return
end

function var_0_0.UpdateSignAward(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	updateDrop(arg_12_4, arg_12_3)
	setActive(arg_12_4:Find("got"), arg_12_2 == ManualSignActivity.STATE_GOT)
	setActive(arg_12_4:Find("get"), arg_12_2 == ManualSignActivity.STATE_CAN_GET)
	onButton(arg_12_0, arg_12_4, function()
		if arg_12_2 == ManualSignActivity.STATE_CAN_GET then
			arg_12_0:Sign(arg_12_1)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Sign(arg_14_0, arg_14_1)
	pg.m02:sendNotification(GAME.ACT_MANUAL_SIGN, {
		activity_id = arg_14_1.id,
		cmd = ManualSignActivity.OP_GET_AWARD
	})

	return
end

function var_0_0.OnUpdateFlush(arg_15_0)
	var_0_0.super.OnUpdateFlush(arg_15_0)
	arg_15_0:FlushSignActivity()
	arg_15_0:FlushSignBtn()

	return
end

return var_0_0
