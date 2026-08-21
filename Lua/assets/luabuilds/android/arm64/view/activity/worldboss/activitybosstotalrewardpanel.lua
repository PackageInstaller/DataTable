local var_0_0 = class("ActivityBossTotalRewardPanel", import("view.level.BaseTotalRewardPanel"))

function var_0_0.getUIName(arg_1_0)
	return "ActivityBossTotalRewardPanel"
end

local var_0_1 = 0.15

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)

	arg_2_0.itemList = arg_2_0.boxView:Find("Content/ItemGrid2")

	setText(arg_2_0.window:Find("Fixed/top/bg/obtain/title"), i18n("autofight_rewards"))
	setText(arg_2_0.window:Find("Fixed/ButtonGO/pic"), i18n("text_confirm"))

	return
end

function var_0_0.didEnter(arg_3_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf, {
		lockGlobalBlur = true
	})
	arg_3_0:UpdateView()

	local var_3_0 = PlayerPrefs.GetInt(AUTO_BATTLE_LABEL, 0) > 0

	if arg_3_0.contextData.isAutoFight and var_3_0 then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_AUTO_BATTLE)
		LuaHelper.Vibrate()
	end

	return
end

function var_0_0.willExit(arg_4_0)
	arg_4_0:SkipAnim()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf)

	return
end

function var_0_0.UpdateView(arg_5_0)
	local var_5_0 = arg_5_0.contextData

	onButton(arg_5_0, arg_5_0._tf:Find("BG"), function()
		if arg_5_0.isRewardAnimating then
			arg_5_0:SkipAnim()

			return
		end

		existCall(var_5_0.onClose)
		arg_5_0:closeView()

		return
	end)
	onButton(arg_5_0, arg_5_0.window:Find("Fixed/ButtonGO"), function()
		existCall(var_5_0.onClose)
		arg_5_0:closeView()

		return
	end, SFX_CONFIRM)

	local var_5_1 = arg_5_0.contextData.rewards
	local var_5_2 = {}
	local var_5_3 = arg_5_0.contextData.rewards and #var_5_1 > 0
	local var_5_4 = CustomIndexLayer.Clone2Full(arg_5_0.itemList, #arg_5_0.contextData.rewards)

	for iter_5_0, iter_5_1 in ipairs(var_5_4) do
		updateDrop(var_5_4[iter_5_0]:Find("Icon"), var_5_1[iter_5_0])
		onButton(arg_5_0, var_5_4[iter_5_0]:Find("Icon"), function()
			arg_5_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
	end

	if var_5_3 then
		arg_5_0.isRewardAnimating = true

		for iter_5_2 = 1, #var_5_1 do
			setActive(var_5_4[iter_5_2], false)
			table.insert(var_5_2, function(arg_9_0)
				if arg_5_0.exited then
					return
				end

				setActive(var_0, true)
				scrollTo(arg_5_0.boxView:Find("Content"), {
					y = 0
				})

				arg_5_0.LTid = LeanTween.delayedCall(var_0_1, System.Action(arg_9_0)).uniqueId

				return
			end)
		end
	end

	local var_5_5 = {}

	if not arg_5_0.contextData.stopReason then
		if arg_5_0.contextData.isAutoFight then
			table.insert(var_5_5, i18n("multiple_sorties_finish"))
		else
			table.insert(var_5_5, i18n("multiple_sorties_stop"))
		end
	else
		table.insert(var_5_5, arg_5_0.contextData.stopReason .. i18n("multiple_sorties_stop_tip_end"))
	end

	table.insert(var_5_5, i18n("multiple_sorties_end_status", arg_5_0.contextData.totalBattleTimes, arg_5_0.contextData.totalBattleTimes - arg_5_0.contextData.continuousBattleTimes))

	if #var_5_5 > 0 then
		setText(arg_5_0.boxView:Find("Content/TextArea2/Text"), table.concat(var_5_5, "\n"))
	end

	arg_5_0:ShowShips(var_5_1)
	seriesAsync(var_5_2, function()
		arg_5_0:SkipAnim()

		return
	end)

	return
end

function var_0_0.ShowShips(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = getProxy(BayProxy):getNewShip(true)
	local var_11_1 = {}

	for iter_11_0 = math.max(1, #var_11_0 - #_.filter(arg_11_1, function(arg_12_0)
		return arg_12_0.type == DROP_TYPE_SHIP
	end) + 1), #var_11_0 do
		local var_11_2 = var_11_0[iter_11_0]

		if PlayerPrefs.GetInt(DISPLAY_SHIP_GET_EFFECT) ~= 1 then
			local var_11_3 = var_11_0[iter_11_0].virgin

			if not var_11_0[iter_11_0].virgin then
				if var_11_0[iter_11_0]:getRarity() < ShipRarity.Purple then
					var_11_3 = false

					goto label_11_0
				end

				var_11_3 = true
			end

			::label_11_0::

			print(var_11_3)

			if var_11_3 then
				table.insert(var_11_1, function(arg_13_0)
					print("eeeeeeeeeeeee")
					arg_11_0:emit(ActivityBossTotalRewardPanelMediator.GET_NEW_SHIP, var_11_2, arg_13_0)

					return
				end)
			end
		end
	end

	seriesAsync(var_11_1, arg_11_2)

	return
end

function var_0_0.SkipAnim(arg_14_0)
	if not arg_14_0.isRewardAnimating then
		return
	end

	arg_14_0.isRewardAnimating = nil

	if arg_14_0.LTid then
		LeanTween.cancel(arg_14_0.LTid)

		arg_14_0.LTid = nil
	end

	eachChild(arg_14_0.itemList, function(arg_15_0)
		setActive(arg_15_0, true)

		return
	end)

	return
end

function var_0_0.onBackPressed(arg_16_0)
	existCall(arg_16_0.contextData.onClose)
	arg_16_0:closeView()

	return
end

return var_0_0
