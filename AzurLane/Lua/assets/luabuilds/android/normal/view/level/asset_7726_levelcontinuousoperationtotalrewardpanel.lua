class = var_0_10000

local var_0_0 = "LevelContinuousOperationTotalRewardPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.level.LevelStageTotalRewardPanel"))

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

	math = var_4_2

	local var_4_4, var_4_5

	if var_4_2.min(var_4_1, var_4_3) > 0 then
		var_4_4 = var_1
		var_4_5 = var_1.IsActive(var_4_4)
	else
		var_4_5 = false
	end

	if false then
		var_4_5 = true
	end

	onButton = var_4_4

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.window
	local var_4_8 = var_8.Find(var_4_7, "Fixed/ButtonGO")

	local function var_4_9()
		if arg_4_0.contextData.spItemID then
			PlayerPrefs = var_2_10001
			var_2_10001 = var_2_10001.GetInt("autoFight_firstUse_sp", 0) == 1

			if not var_2_10001 then
				PlayerPrefs = var_2

				var_2.SetInt("autoFight_firstUse_sp", 1)

				PlayerPrefs = var_2

				var_2.Save()

				local function var_5_0()
					arg_4_0.contextData.spItemID = nil

					local var_6_0 = arg_4_0

					var_0.UpdateSPItem(var_6_0)

					return
				end

				local var_5_1 = arg_4_0
				local var_5_2 = var_3.HandleShowMsgBox

				var_2_10005 = {
					hideNo = true
				}
				i18n = var_2_10006
				var_2_10005.content = var_2_10006("autofight_special_operation_tip")
				var_2_10005.onYes = var_5_0
				var_2_10005.onNo = var_5_0

				var_5_2(var_5_1, var_2_10005)

				return
			end
		end

		Chapter = var_2_10001

		local var_5_3 = var_2_10001.GetSPOperationItemCacheKey(arg_4_0.contextData.chapter.id)

		PlayerPrefs = var_2

		local var_5_4 = var_2.SetInt
		local var_5_5 = var_5_3
		local var_5_6

		if not arg_4_0.contextData.spItemID then
			var_5_6 = 0
		end

		var_5_4(var_5_5, var_5_6)

		if var_4_5 then
			getProxy = var_2
			ChapterProxy = var_5_5

			local var_5_7 = var_2(var_5_5)
			local var_5_8 = var_2.InitContinuousTime

			SYSTEM_SCENARIO = var_5_6

			var_5_8(var_5_7, var_5_6, var_0)
		end

		local var_5_9 = true
		local var_5_10 = arg_4_0
		local var_5_11 = var_3.emit

		LevelMediator2 = var_2_10005

		var_5_11(var_5_10, var_2_10005.ON_RETRACKING, arg_4_0.contextData.chapter, var_5_9)

		local var_5_12 = arg_4_0

		var_3.closeView(var_5_12)

		return
	end

	SFX_CONFIRM = var_10

	var_4_4(var_4_6, var_4_8, var_4_9, var_10)

	local var_4_10 = {}
	local var_4_11 = var_1

	if var_1.IsActive(var_4_11) then
		table = var_4_11
		var_4_11 = var_4_11.insert

		local var_4_12 = var_4_10

		i18n = var_10

		var_4_11(var_4_12, var_10("multiple_sorties_finish"))
	else
		table = var_4_11
		var_4_11 = var_4_11.insert

		local var_4_13 = var_4_10

		i18n = var_10

		var_4_11(var_4_13, var_10("multiple_sorties_stop"))
	end

	setActive = var_4_11

	local var_4_14 = arg_4_0.boxView

	var_4_11(var_9.Find(var_4_14, "Content/TextArea2/Title/Sucess"), var_7)

	setActive = var_4_11

	local var_4_15 = arg_4_0.boxView

	var_4_11(var_9.Find(var_4_15, "Content/TextArea2/Title/Failure"), not var_7)

	table = var_4_11

	local var_4_16 = var_4_11.insert
	local var_4_17 = var_4_10

	i18n = var_10

	var_4_16(var_4_17, var_10("multiple_sorties_main_end", var_4_1, var_4_1 - var_1:GetRestBattleTime()))

	if #var_4_10 > 0 then
		setText = var_4_21

		local var_4_18 = arg_4_0.boxView

		var_4_21(var_9.Find(var_4_18, "Content/TextArea2/Title/Text"), var_4_10[1])

		setText = var_4_21

		local var_4_19 = arg_4_0.boxView

		var_4_21(var_9.Find(var_4_19, "Content/TextArea2/Detail"), var_4_10[2])
	end

	local var_4_21

	if var_4_5 then
		local var_4_20 = arg_4_0.contextData.chapter

		var_4_21 = var_4_21.GetRestDailyBonus(var_4_20)
		setActive = var_4_20

		local var_4_22 = arg_4_0.spList

		go = var_11

		local var_4_23

		if var_11(arg_4_0.spList).activeSelf then
			var_4_23 = var_4_21 < var_4
		end

		var_4_20(var_4_22, var_4_23)
	end

	setActive = var_4_21

	local var_4_24 = arg_4_0.window

	var_4_21(var_9.Find(var_4_24, "RetryTimes"), var_4_5)

	setText = var_4_21

	local var_4_25 = arg_4_0.window
	local var_4_26 = var_9.Find(var_4_25, "RetryTimes/Text")

	i18n = var_4_25

	var_4_21(var_4_26, var_4_25("multiple_sorties_retry_desc", var_4))

	return
end

function var_0_1.willExit(arg_7_0)
	var_0_1.super.willExit(arg_7_0)

	return
end

return var_0_1
