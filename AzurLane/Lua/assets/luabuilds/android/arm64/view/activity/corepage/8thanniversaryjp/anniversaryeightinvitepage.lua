local var_0_0 = class("AnniversaryEightInvitePage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.rtMarks = arg_1_0._tf:Find("AD/image_02/progress")
	arg_1_0.rtFinish = arg_1_0._tf:Find("AD/image_02/award")
	arg_1_0.rtBtns = arg_1_0._tf:Find("AD/btn_list")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	if arg_2_0.ptData then
		arg_2_0.ptData:Update(arg_2_0.activity)
	else
		arg_2_0.ptData = ActivityPtData.New(arg_2_0.activity)
	end

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.rtBtns:Find("go"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CITY_REBUILD_MAP)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.rtBtns:Find("get"), function()
		arg_3_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 4,
			activity_id = arg_3_0.ptData:GetId(),
			arg1 = arg_3_0.ptData:GetCurrTarget()
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	local var_6_0, var_6_1, var_6_2 = arg_6_0.ptData:GetResProgress()
	local var_6_3 = arg_6_0.ptData:GetDroptItemState(arg_6_0.ptData:GetCurrLevel())

	for iter_6_0 = 1, arg_6_0.rtMarks.childCount do
		local var_6_4 = arg_6_0.rtMarks:GetChild(iter_6_0 - 1)

		setActive(var_6_4:Find("mark"), iter_6_0 <= var_6_0)
	end

	setActive(arg_6_0.rtBtns:Find("get"), var_6_3 == ActivityPtData.STATE_CAN_GET and var_6_1 <= var_6_0)
	setActive(arg_6_0.rtBtns:Find("got"), var_6_3 == ActivityPtData.STATE_GOT and var_6_1 <= var_6_0)
	setActive(arg_6_0.rtBtns:Find("red"), var_6_3 == ActivityPtData.STATE_CAN_GET and var_6_1 <= var_6_0)
	setActive(arg_6_0.rtBtns:Find("go"), var_6_0 < var_6_1)
	setActive(arg_6_0.rtFinish, var_6_3 == ActivityPtData.STATE_GOT)

	return
end

return var_0_0
