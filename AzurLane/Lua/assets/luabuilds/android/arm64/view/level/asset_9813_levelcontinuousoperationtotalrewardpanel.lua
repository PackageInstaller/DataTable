class = var_0_10000

local var_0_0 = "LevelContinuousOperationTotalRewardPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.level.LevelStageTotalRewardPanel"))

function var_0_1.getUIName(arg_1_0)
	return "LevelContinuousOperationTotalRewardPanel"
end

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	return
end

function var_0_1.didEnter(arg_3_0)
	var_0_1.super.didEnter(arg_3_0)

	return
end

function var_0_1.UpdateView(arg_4_0)
	var_0_1.super.UpdateView(arg_4_0)

	setActive = var_1

	var_1(arg_4_0.boxView, true)

	setActive = var_1

	var_1(arg_4_0.emptyTip, false)

	local var_4_0 = arg_4_0.contextData.continuousData
	local var_4_1 = var_1.GetTotalBattleTime(var_4_0)
	local var_4_2 = arg_4_0.contextData.chapter
	local var_4_3 = var_3.GetMaxBattleCount(var_4_2)

	math = var_4_0

	local var_4_4 = var_4_0.min(var_4_1, var_4_3) > 0 and var_1:IsActive()

	onButton = var_6

	local var_4_5 = arg_4_0
	local var_4_6 = arg_4_0.window
	local var_4_7 = var_9.Find(var_4_6, "Fixed/ButtonGO")

	local function var_4_8()
		if arg_4_0.contextData.spItemID then
			PlayerPrefs = var_2_10001
			var_2_10001 = var_2_10001.GetInt("autoFight_firstUse_sp", 0) == 1

			if not var_2_10001 then
				PlayerPrefs = var_2_10002

				var_2_10002.SetInt("autoFight_firstUse_sp", 1)

				PlayerPrefs = var_2_10002

				var_2_10002.Save()

				function var_2_10002()
					arg_4_0.contextData.spItemID = nil

					local var_6_0 = arg_4_0

					var_0.UpdateSPItem(var_6_0)

					return
				end

				local var_5_0 = arg_4_0
				local var_5_1 = var_3.HandleShowMsgBox

				var_2_10006 = {
					hideNo = true
				}
				i18n = var_2_10007
				var_2_10006.content = var_2_10007("autofight_special_operation_tip")
				var_2_10006.onYes = var_2_10002
				var_2_10006.onNo = var_2_10002

				var_5_1(var_5_0, var_2_10006)

				return
			end
		end

		Chapter = var_2_10001

		local var_5_2 = var_2_10001.GetSPOperationItemCacheKey(arg_4_0.contextData.chapter.id)

		PlayerPrefs = var_2_10002

		local var_5_3 = var_2_10002.SetInt
		local var_5_4 = var_5_2
		local var_5_5

		if not arg_4_0.contextData.spItemID then
			var_5_5 = 0
		end

		var_5_3(var_5_4, var_5_5)

		if var_4_4 then
			getProxy = var_2
			ChapterProxy = var_5_4

			local var_5_6 = var_2(var_5_4)
			local var_5_7 = var_2.InitContinuousTime

			SYSTEM_SCENARIO = var_5_5

			var_5_7(var_5_6, var_5_5, var_0)
		end

		local var_5_8 = true
		local var_5_9 = arg_4_0
		local var_5_10 = var_3.emit

		LevelMediator2 = var_2_10006

		var_5_10(var_5_9, var_2_10006.ON_RETRACKING, arg_4_0.contextData.chapter, var_5_8)

		local var_5_11 = arg_4_0

		var_3.closeView(var_5_11)

		return
	end

	SFX_CONFIRM = var_4_6

	var_6(var_4_5, var_4_7, var_4_8, var_4_6)

	local var_4_9 = {}

	if var_1:IsActive() then
		table = var_4_5
		var_4_5 = var_4_5.insert

		local var_4_10 = var_4_9

		i18n = var_4_6

		var_4_5(var_4_10, var_4_6("multiple_sorties_finish"))
	else
		table = var_4_5
		var_4_5 = var_4_5.insert

		local var_4_11 = var_4_9

		i18n = var_4_6

		var_4_5(var_4_11, var_4_6("multiple_sorties_stop"))
	end

	setActive = var_4_5

	local var_4_12 = arg_4_0.boxView

	var_4_5(var_10.Find(var_4_12, "Content/TextArea2/Title/Sucess"), var_7)

	setActive = var_4_5

	local var_4_13 = arg_4_0.boxView

	var_4_5(var_10.Find(var_4_13, "Content/TextArea2/Title/Failure"), not var_7)

	table = var_4_5

	local var_4_14 = var_4_5.insert
	local var_4_15 = var_4_9

	i18n = var_11

	var_4_14(var_4_15, var_11("multiple_sorties_main_end", var_4_1, var_4_1 - var_1:GetRestBattleTime()))

	local var_4_16 = #var_4_9

	if 0 < var_4_16 then
		setText = var_4_16
		var_4_13 = arg_4_0.boxView

		var_4_16(var_10.Find(var_4_13, "Content/TextArea2/Title/Text"), var_4_9[1])

		setText = var_4_16
		var_4_13 = arg_4_0.boxView

		var_4_16(var_10.Find(var_4_13, "Content/TextArea2/Detail"), var_4_9[2])
	end

	if var_4_4 then
		local var_4_17 = arg_4_0.contextData.chapter

		var_4_16 = var_4_16.GetRestDailyBonus(var_4_17)
		setActive = var_9

		local var_4_18 = arg_4_0.spList

		go = var_4_13

		local var_4_19

		if var_4_13(arg_4_0.spList).activeSelf then
			var_4_19 = var_4_16 < var_4
		end

		var_9(var_4_18, var_4_19)
	end

	setActive = var_4_16

	local var_4_20 = arg_4_0.window

	var_4_16(var_10.Find(var_4_20, "RetryTimes"), var_4_4)

	setText = var_4_16

	local var_4_21 = arg_4_0.window
	local var_4_22 = var_10.Find(var_4_21, "RetryTimes/Text")

	i18n = var_11

	var_4_16(var_4_22, var_11("multiple_sorties_retry_desc", var_4))

	return
end

function var_0_1.willExit(arg_7_0)
	var_0_1.super.willExit(arg_7_0)

	return
end

return var_0_1
