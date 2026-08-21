local var_0_0 = class("LevelContinuousOperationTotalRewardPanel", import("view.level.LevelStageTotalRewardPanel"))

function var_0_0.getUIName(arg_1_0)
	return "LevelContinuousOperationTotalRewardPanel"
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)

	return
end

function var_0_0.didEnter(arg_3_0)
	var_0_0.super.didEnter(arg_3_0)

	return
end

function var_0_0.UpdateView(arg_4_0)
	var_0_0.super.UpdateView(arg_4_0)
	setActive(arg_4_0.boxView, true)
	setActive(arg_4_0.emptyTip, false)

	local var_4_1 = arg_4_0.contextData.continuousData:GetTotalBattleTime()
	local var_4_2 = math.min(var_4_1, (arg_4_0.contextData.chapter:GetMaxBattleCount()))
	local var_4_3 = var_4_2 > 0 and var_4_0:IsActive()

	onButton(arg_4_0, arg_4_0.window:Find("Fixed/ButtonGO"), function()
		if arg_4_0.contextData.spItemID and PlayerPrefs.GetInt("autoFight_firstUse_sp", 0) ~= 1 then
			PlayerPrefs.SetInt("autoFight_firstUse_sp", 1)
			PlayerPrefs.Save()
			arg_4_0:HandleShowMsgBox({
				hideNo = true,
				content = i18n("autofight_special_operation_tip"),
				onYes = function()
					arg_4_0.contextData.spItemID = nil

					arg_4_0:UpdateSPItem()

					return
				end,
				onNo = function()
					arg_4_0.contextData.spItemID = nil

					arg_4_0:UpdateSPItem()

					return
				end
			})

			return
		end

		local var_5_0 = Chapter.GetSPOperationItemCacheKey(arg_4_0.contextData.chapter.id)
		local var_5_1 = arg_4_0.contextData.spItemID or 0

		PlayerPrefs.SetInt(var_5_0, var_5_1)

		if var_4_3 then
			getProxy(ChapterProxy):InitContinuousTime(SYSTEM_SCENARIO, var_4_2)
		end

		arg_4_0:emit(LevelMediator2.ON_RETRACKING, arg_4_0.contextData.chapter, true)
		arg_4_0:closeView()

		return
	end, SFX_CONFIRM)

	local var_4_4 = {}
	local var_4_5 = var_4_0:IsActive()

	if var_4_5 then
		table.insert(var_4_4, i18n("multiple_sorties_finish"))
	else
		table.insert(var_4_4, i18n("multiple_sorties_stop"))
	end

	setActive(arg_4_0.boxView:Find("Content/TextArea2/Title/Sucess"), var_4_5)
	setActive(arg_4_0.boxView:Find("Content/TextArea2/Title/Failure"), not var_4_5)
	table.insert(var_4_4, i18n("multiple_sorties_main_end", var_4_1, var_4_1 - var_4_0:GetRestBattleTime()))

	if #var_4_4 > 0 then
		setText(arg_4_0.boxView:Find("Content/TextArea2/Title/Text"), var_4_4[1])
		setText(arg_4_0.boxView:Find("Content/TextArea2/Detail"), var_4_4[2])
	end

	if var_4_3 then
		local var_4_6 = go(arg_4_0.spList).activeSelf and arg_4_0.contextData.chapter:GetRestDailyBonus() < var_4_2

		setActive(arg_4_0.spList, var_4_6)
	end

	setActive(arg_4_0.window:Find("RetryTimes"), var_4_3)
	setText(arg_4_0.window:Find("RetryTimes/Text"), i18n("multiple_sorties_retry_desc", var_4_2))

	return
end

function var_0_0.willExit(arg_7_0)
	var_0_0.super.willExit(arg_7_0)

	return
end

return var_0_0
