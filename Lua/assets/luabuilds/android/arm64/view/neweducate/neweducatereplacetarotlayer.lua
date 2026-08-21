local var_0_0 = class("NewEducateReplaceTarotLayer", import("view.newEducate.base.NewEducateBaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "NewEducateReplaceTarotUI"
end

function var_0_0.init(arg_2_0)
	setText(arg_2_0._tf:Find("title"), i18n("child2_replace_title"))
	setText(arg_2_0._tf:Find("tip"), i18n("child2_replace_tip"))

	arg_2_0.toggleTF = arg_2_0._tf:Find("toggle")

	setText(arg_2_0.toggleTF:Find("Text"), i18n("child2_show_detail_desc"))

	arg_2_0.oldTF = arg_2_0._tf:Find("old")
	arg_2_0.oldCard = NewEducateTarotCard.New(arg_2_0.oldTF)
	arg_2_0.newTF = arg_2_0._tf:Find("new")
	arg_2_0.newCard = NewEducateTarotCard.New(arg_2_0.newTF)
	arg_2_0.cancelBtn = arg_2_0._tf:Find("cancel_btn")

	setText(arg_2_0.cancelBtn:Find("Text"), i18n("child2_replace_cancel"))

	arg_2_0.sureBtn = arg_2_0._tf:Find("sure_btn")

	setText(arg_2_0.sureBtn:Find("Text"), i18n("child2_replace_sure"))

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:BlurPanel(arg_3_0._tf, {
		groupDelta = 3
	})
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0.state:SetHoldId(arg_3_0.oldId)
		arg_3_0:CheckState()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.sureBtn, function()
		arg_3_0.state:SetHoldId(arg_3_0.newId)
		arg_3_0:CheckState()

		return
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0.toggleTF, function(arg_6_0)
		NewEducateHelper.SetTarotDeatilDescData(arg_6_0)
		arg_3_0.oldCard:UpdateDescMode(arg_6_0)
		arg_3_0.newCard:UpdateDescMode(arg_6_0)

		return
	end, SFX_PANEL)
	arg_3_0:UpdateView()
	triggerToggle(arg_3_0.toggleTF, NewEducateHelper.IsShowTarotDeatilDesc())

	return
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.state = getProxy(NewEducateProxy):GetCurChar():GetFSM():GetPriorityState()
	arg_7_0.oldId = arg_7_0.state:GetHoldId()

	if arg_7_0.oldId == 0 then
		arg_7_0.oldId = arg_7_0.contextData.char:GetTarotId()
	end

	arg_7_0.newId = arg_7_0.state:GetFirstId()

	arg_7_0.oldCard:Update(arg_7_0.oldId, NewEducateTarotCard.TYPE.CURRENT)
	arg_7_0.newCard:Update(arg_7_0.newId, NewEducateTarotCard.TYPE.REPLACE)
	triggerToggle(arg_7_0.toggleTF, false)

	return
end

function var_0_0.CheckState(arg_8_0)
	arg_8_0.state:PopId()

	if arg_8_0.state:IsFinish() then
		local var_8_0 = arg_8_0.state:GetHoldId() == arg_8_0.contextData.char:GetTarotId() and 0 or arg_8_0.state:GetHoldId()

		arg_8_0:emit(NewEducateReplaceTarotMediator.ON_REPLACE_TAROT, var_8_0)
	else
		arg_8_0:closeView()
	end

	return
end

function var_0_0.OnReplaceDone(arg_9_0, arg_9_1)
	seriesAsync({
		function(arg_10_0)
			arg_9_0._tf:GetComponent(typeof(Animation)):Play("Anim_NewEducateReplaceTarotUI_cliek")
			onDelayTick(arg_10_0, 0.4)

			return
		end,
		function(arg_11_0)
			if #arg_9_1.drops > 0 then
				arg_9_0:emit(var_0_0.ON_DROP, {
					items = arg_9_1.drops,
					removeFunc = function()
						arg_11_0()

						return
					end
				})
			else
				arg_11_0()
			end

			return
		end
	}, function()
		arg_9_0:closeView()

		return
	end)

	return
end

function var_0_0.onBackPressed(arg_14_0)
	return
end

function var_0_0.willExit(arg_15_0)
	arg_15_0.oldCard:Dispose()
	arg_15_0.newCard:Dispose()
	arg_15_0:UnOverlayPanel(arg_15_0._tf)
	existCall(arg_15_0.contextData.onExit)

	return
end

return var_0_0
