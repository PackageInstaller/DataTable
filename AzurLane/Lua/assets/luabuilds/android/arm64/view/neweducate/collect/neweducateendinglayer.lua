local var_0_0 = class("NewEducateEndingLayer", import(".NewEducateCollectLayerTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "NewEducateEndingUI"
end

function var_0_0.initConfig(arg_2_0)
	arg_2_0.config = pg.child2_ending
	arg_2_0.allIds = arg_2_0.contextData.permanentData:GetAllEndingIds()
	arg_2_0.unlockIds = arg_2_0.contextData.permanentData:GetActivatedEndings()
	arg_2_0.finishedIds = arg_2_0.contextData.permanentData:GetFinishedEndings()
	arg_2_0.char = getProxy(NewEducateProxy):GetChar(arg_2_0.contextData.permanentData.id)

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("anim_root/close"), function()
		arg_3_0:PlayAnimClose()

		return
	end, SFX_PANEL)
	arg_3_0:InitPageInfo()
	setText(arg_3_0.performTF:Find("review_btn/Text"), i18n("child_btn_review"))
	setText(arg_3_0.curCntTF, #arg_3_0.unlockIds)
	setText(arg_3_0.allCntTF, "/" .. #arg_3_0.allIds)

	arg_3_0.toggleTF = arg_3_0.windowTF:Find("toggle")

	setText(arg_3_0.toggleTF:Find("on/Text"), i18n("child2_endings_toggle_on"))
	setText(arg_3_0.toggleTF:Find("off/Text"), i18n("child2_endings_toggle_off"))

	arg_3_0.tpl = arg_3_0.windowTF:Find("condition_tpl")

	onToggle(arg_3_0, arg_3_0.toggleTF, function(arg_5_0)
		arg_3_0:UpdatePage()

		return
	end, SFX_PANEL)
	arg_3_0:UpdatePage()

	return
end

function var_0_0.UpdateItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.config[arg_6_1]
	local var_6_1 = table.contains(arg_6_0.unlockIds, arg_6_0.config[arg_6_1].id)

	setActive(arg_6_2:Find("unlock"), var_6_1)
	setActive(arg_6_2:Find("lock"), not var_6_1)
	setActive(arg_6_2:Find("finished"), table.contains(arg_6_0.finishedIds, var_6_0.id))

	local var_6_3 = arg_6_2:Find("name")

	if var_6_1 then
		local var_6_4 = var_6_0.name or "???"

		var_6_2(var_6_3, var_6_4)

		local var_6_5

		if var_6_1 then
			LoadImageSpriteAsync("bg/" .. var_6_0.pic, arg_6_2:Find("unlock/mask/Image"))
			onButton(arg_6_0, arg_6_2, function()
				arg_6_0:ShowPerformWindow(var_6_0)

				return
			end, SFX_PANEL)
		else
			removeOnButton(arg_6_2)

			var_6_5 = {}
		end

		if arg_6_0.toggleTF:GetComponent(typeof(Toggle)).isOn then
			setActive(arg_6_2:Find("lock"), true)
			setActive(arg_6_2:Find("lock/icon"), not var_6_1)
			setActive(arg_6_2:Find("mask"), var_6_1)

			var_6_5 = var_6_0.condition_desc
		else
			setActive(arg_6_2:Find("mask"), false)
		end

		arg_6_0:UpdateConditions(var_6_5, arg_6_2:Find("lock/conditions"))

		return
	end
end

function var_0_0.UpdateConditions(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = 0

	for iter_8_0 = 1, #arg_8_1 do
		local var_8_1 = arg_8_1[iter_8_0]

		var_8_0 = var_8_0 + 1

		local var_8_2 = iter_8_0 <= arg_8_2.childCount and arg_8_2:GetChild(iter_8_0 - 1) or cloneTplTo(arg_8_0.tpl, arg_8_2)
		local var_8_3 = arg_8_0.char:LogicalOperator({
			operator = "||",
			conditions = arg_8_1[iter_8_0][1]
		})

		setActive(var_8_2:Find("icon/unlock"), var_8_3)
		setTextColor(var_8_2:Find("Text"), Color.NewHex(var_8_3 and "F59F48" or "888888"))
		setText(var_8_2:Find("Text"), var_8_1[2])
	end

	for iter_8_1 = 1, arg_8_2.childCount do
		setActive(arg_8_2:GetChild(iter_8_1 - 1), iter_8_1 <= var_8_0)
	end

	return
end

function var_0_0.ShowPerformWindow(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.performTF:Find("Image")

	LoadImageSpriteAsync("bg/" .. arg_9_1.pic, var_9_0)
	setActive(arg_9_0.performTF, true)
	onButton(arg_9_0, var_9_0, function()
		setActive(arg_9_0.performTF, false)

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.performTF:Find("review_btn"), function()
		pg.NewStoryMgr.GetInstance():Play(arg_9_1.performance, nil, true)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.PlayAnimChange(arg_12_0)
	arg_12_0.anim:Stop()
	arg_12_0.anim:Play("anim_educate_ending_change")

	return
end

function var_0_0.PlayAnimClose(arg_13_0)
	arg_13_0.anim:Play("anim_educate_ending_out")

	return
end

return var_0_0
