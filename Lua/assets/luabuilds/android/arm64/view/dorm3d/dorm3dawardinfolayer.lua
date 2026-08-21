local var_0_0 = class("Dorm3dAwardInfoLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dAwardInfoUI"
end

function var_0_0.init(arg_2_0)
	onButton(arg_2_0, arg_2_0._tf:Find("bg"), function()
		if arg_2_0.inAnimPlaying or arg_2_0.isCloseAnim then
			return
		end

		arg_2_0.isCloseAnim = true

		arg_2_0._tf:GetComponent(typeof(Animation)):Play("anim_educate_awardinfo_award_out")

		return
	end, SFX_CANCEL)
	arg_2_0._tf:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		arg_2_0:closeView()

		return
	end)

	arg_2_0.tipTF = arg_2_0._tf:Find("panel/tip")

	setText(arg_2_0.tipTF, i18n("child_close_tip"))

	arg_2_0.itemContainer = arg_2_0._tf:Find("panel/content")

	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	return
end

function var_0_0.didEnter(arg_5_0)
	UIItemList.StaticAlign(arg_5_0.itemContainer, arg_5_0.itemContainer:Find("tpl"), #arg_5_0.contextData.items, function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_1 = arg_6_1 + 1

		if arg_6_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_6_2, arg_5_0.contextData.items[arg_6_1])
			onButton(arg_5_0, arg_6_2, function()
				arg_5_0:emit(BaseUI.ON_NEW_DROP, {
					style = "dorm",
					drop = var_0
				})

				return
			end, SFX_PANEL)
		end

		return
	end)

	arg_5_0.inAnimPlaying = true

	local var_5_0 = {}

	table.insert({}, function(arg_8_0)
		arg_5_0:managedTween(LeanTween.delayedCall, arg_8_0, 0.33, nil)

		return
	end)
	eachChild(arg_5_0.itemContainer, function(arg_9_0)
		if isActive(arg_9_0) then
			setActive(arg_9_0, false)
			table.insert(var_5_0, function(arg_10_0)
				setActive(arg_9_0, true)
				arg_5_0:managedTween(LeanTween.delayedCall, arg_10_0, 0.066, nil)

				return
			end)
		end

		return
	end)
	seriesAsync({}, function()
		arg_5_0:managedTween(LeanTween.delayedCall, function()
			arg_5_0.inAnimPlaying = false

			return
		end, 0.066, nil)

		return
	end)
	pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_reward")

	return
end

function var_0_0.onBackPressed(arg_13_0)
	triggerButton(arg_13_0._tf:Find("bg"))

	return
end

function var_0_0.willExit(arg_14_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_14_0._tf)

	return
end

return var_0_0
