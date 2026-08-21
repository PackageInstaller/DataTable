local var_0_0 = class("VoteAwardWindowPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "VoteAwardWindowUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.currToggle = arg_2_0._tf:Find("frame/toggle/curr")
	arg_2_0.accToggle = arg_2_0._tf:Find("frame/toggle/acc")
	arg_2_0.ptWindow = VoteAwardPtWindow.New(arg_2_0._tf, arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")

	setText(arg_2_0._tf:Find("frame/title/Text"), i18n("vote_lable_window_title"))
	setText(arg_2_0._tf:Find("frame/panel/list/tpl/award1/mask/Text"), i18n("vote_lable_rearch"))
	setText(arg_2_0._tf:Find("frame/panel/list/tpl/award/mask/Text"), i18n("vote_lable_rearch"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onToggle(arg_3_0, arg_3_0.currToggle, function(arg_4_0)
		if arg_4_0 and arg_3_0.currPtData then
			arg_3_0.ptWindow:Show({
				type = VoteAwardPtWindow.TYPE_CURR,
				dropList = arg_3_0.currPtData.dropList,
				targets = arg_3_0.currPtData.targets,
				level = arg_3_0.currPtData.level,
				count = arg_3_0.currPtData.count
			})
		end

		return
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0.accToggle, function(arg_5_0)
		if arg_5_0 and arg_3_0.accPtData then
			arg_3_0.ptWindow:Show({
				type = VoteAwardPtWindow.TYPE_ACC,
				dropList = arg_3_0.accPtData.dropList,
				targets = arg_3_0.accPtData.targets,
				level = arg_3_0.accPtData.level,
				count = arg_3_0.accPtData.count
			})
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_8_0)
	var_0_0.super.Show(arg_8_0)

	arg_8_0.currPtData = arg_8_0:GenCurrPtData()
	arg_8_0.accPtData = arg_8_0:GenAccPtData()

	local var_8_0 = arg_8_0.currPtData ~= nil and #arg_8_0.currPtData.targets > 0

	setActive(arg_8_0.currToggle, arg_8_0.currPtData ~= nil and #arg_8_0.currPtData.targets > 0)

	if var_8_0 then
		triggerToggle(arg_8_0.currToggle, true)
	else
		triggerToggle(arg_8_0.accToggle, true)
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_8_0._tf)

	return
end

function var_0_0.Hide(arg_9_0)
	var_0_0.super.Hide(arg_9_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0._tf, arg_9_0._parentTf)

	return
end

function var_0_0.GenCurrPtData(arg_10_0)
	local var_10_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VOTE)

	if var_10_0 and not var_10_0:isEnd() then
		local var_10_1 = pg.activity_vote[var_10_0:getConfig("config_id")]

		for iter_10_0, iter_10_1 in ipairs(var_10_1.period_reward) do
			table.insert({}, iter_10_1[1])
		end

		for iter_10_2, iter_10_3 in ipairs(var_10_1.period_reward_display) do
			table.insert({}, iter_10_3)
		end

		local var_10_2 = 0

		for iter_10_4, iter_10_5 in pairs({}) do
			if iter_10_5 <= var_10_0.data2 then
				var_10_2 = iter_10_4
			end
		end

		return {
			type = VoteAwardPtWindow.TYPE_CURR,
			dropList = {},
			targets = {},
			level = var_10_2,
			count = var_10_0.data2
		}
	end

	return
end

function var_0_0.GenAccPtData(arg_11_0)
	local var_11_0
	local var_11_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.VOTE_ENTRANCE_ACT_ID)

	if var_11_1 and not var_11_1:isEnd() then
		var_11_0 = ActivityPtData.New((getProxy(ActivityProxy):getActivityById(var_11_1:getConfig("config_client")[1])))
	end

	return var_11_0
end

function var_0_0.OnDestroy(arg_12_0)
	if arg_12_0:isShowing() then
		arg_12_0:Hide()
	end

	if arg_12_0.ptWindow then
		arg_12_0.ptWindow = nil
	end

	return
end

return var_0_0
