local var_0_0 = class("AnniversarySixInvitationPage", import("...base.BaseActivityPage"))

function var_0_0.OnDataSetting(arg_1_0)
	if arg_1_0.ptData then
		arg_1_0.ptData:Update(arg_1_0.activity)
	else
		arg_1_0.ptData = ActivityPtData.New(arg_1_0.activity)
	end

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0.rtMarks = arg_2_0._tf:Find("AD/progress")
	arg_2_0.rtFinish = arg_2_0._tf:Find("AD/award")

	local var_2_0 = arg_2_0._tf:Find("AD/btn_list")

	onButton(arg_2_0, var_2_0:Find("go"), function()
		local var_3_0 = underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_4_0)
			return arg_4_0:getConfig("config_id") == 3
		end)

		if not var_3_0 or var_3_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

			return
		end

		local var_3_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND)

		if var_3_1 and not var_3_1:isEnd() then
			arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.ANNIVERSARY_ISLAND_SEA, {
				wraps = SixthAnniversaryIslandScene.SHOP
			})
		else
			arg_2_0:emit(ActivityMediator.OPEN_LAYER, Context.New({
				mediator = SixthAnniversaryIslandShopMediator,
				viewComponent = SixthAnniversaryIslandShopLayer
			}))
		end

		return
	end, SFX_PANEL)
	onButton(arg_2_0, var_2_0:Find("get"), function()
		local var_5_0, var_5_1 = arg_2_0.ptData:GetResProgress()

		arg_2_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = arg_2_0.ptData:GetId(),
			arg1 = var_5_1
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	local var_6_0, var_6_1 = arg_6_0.ptData:GetResProgress()
	local var_6_2 = arg_6_0.ptData:CanGetAward()
	local var_6_3 = arg_6_0.ptData:CanGetNextAward()
	local var_6_4 = arg_6_0._tf:Find("AD/btn_list")

	setActive(var_6_4:Find("get"), var_6_2)
	setActive(var_6_4:Find("got"), not var_6_3)
	setActive(var_6_4:Find("go"), not var_6_2 and var_6_3)

	var_6_0 = var_6_3 and math.min(var_6_0, var_6_1) or var_6_1 + 1

	for iter_6_0 = 1, arg_6_0.rtMarks.childCount do
		local var_6_5 = arg_6_0.rtMarks:GetChild(iter_6_0 - 1)

		setActive(var_6_5:Find("mark"), iter_6_0 < var_6_0)
		setActive(var_6_5:Find("icon"), iter_6_0 == var_6_0)
	end

	setGray(arg_6_0.rtFinish:Find("Image"), not var_6_3)
	setActive(arg_6_0.rtFinish:Find("got"), not var_6_3)

	return
end

return var_0_0
