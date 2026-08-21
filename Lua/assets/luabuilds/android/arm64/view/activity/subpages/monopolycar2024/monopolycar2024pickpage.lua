local var_0_0 = class("MonopolyCar2024PickPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "MonopolyCar2024PickUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.confirmBtn = arg_2_0._tf:Find("confirm")
	arg_2_0.anim = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.animEvent = arg_2_0.anim:GetComponent(typeof(DftAniEvent))

	arg_2_0.animEvent:SetEndEvent(function()
		var_0_0.super.Hide(arg_2_0)

		return
	end)

	arg_2_0.items = {
		arg_2_0._tf:Find("list/1"),
		arg_2_0._tf:Find("list/2"),
		arg_2_0._tf:Find("list/3")
	}

	setText(arg_2_0._tf:Find("title/Text"), i18n("MonopolyCar2024Game_pick_tip"))
	setText(arg_2_0.confirmBtn:Find("Text"), i18n("MonopolyCar2024Game_sel_label"))

	return
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.selectedId = 0

	onButton(arg_4_0, arg_4_0.confirmBtn, function()
		if arg_4_0.selectedId <= 0 then
			return
		end

		if arg_4_0.callback then
			arg_4_0.callback(arg_4_0.selectedId)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateList(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.items) do
		local var_6_0 = table.contains(arg_6_0.banList, iter_6_0)

		onToggle(arg_6_0, iter_6_1, function(arg_7_0)
			if arg_7_0 then
				arg_6_0.selectedId = iter_6_0
			end

			return
		end, SFX_PANEL)
		setToggleEnabled(iter_6_1, not var_6_0)
		warning(iter_6_0, var_6_0)
		setActive(iter_6_1:Find(iter_6_0 .. "/active"), not var_6_0)
		setActive(iter_6_1:Find(iter_6_0 .. "/coin"), arg_6_0.banCount < 3 and not var_6_0)

		if not var_6_0 then
			triggerToggle(iter_6_1, true)
		end
	end

	return
end

function var_0_0.Show(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	var_0_0.super.Show(arg_8_0)

	arg_8_0.activityId = arg_8_1
	arg_8_0.turnCnt = arg_8_4
	arg_8_0.banCount = #arg_8_2
	arg_8_0.banList = arg_8_0.banCount >= 3 and {} or arg_8_2
	arg_8_0.callback = arg_8_5

	arg_8_0:UpdateList()
	pg.UIMgr.GetInstance():BlurPanel(arg_8_0._tf)
	arg_8_0.anim:Play("anim_monopolycar_pick_in")
	arg_8_0:CheckAuto(arg_8_3)

	return
end

function var_0_0.CheckAuto(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.items) do
		if not table.contains(arg_9_0.banList, iter_9_0) then
			table.insert(var_9_0, iter_9_0)
		end
	end

	arg_9_0.selectedId = var_9_0[math.random(1, #var_9_0)]

	if arg_9_0.callback then
		arg_9_0.callback(arg_9_0.selectedId)
	end

	return
end

function var_0_0.Hide(arg_10_0)
	arg_10_0.anim:Play("anim_monopolycar_pick_out")

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.items) do
		triggerToggle(iter_10_1, false)
	end

	arg_10_0.selectedId = 0

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf, arg_10_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_11_0)
	return
end

return var_0_0
