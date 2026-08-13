class = var_0_10000

local var_0_0 = "BossRushVerSardiniaSPScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.DISPLAY = {
	STORY = "Story",
	BATTLE = "Battle"
}

function var_0_1.getUIName(arg_1_0)
	return "BossRushVerSardiniaSPUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "Top")
	arg_2_0.seriesNodes = {}
	eachChild = var_1

	local var_2_1 = arg_2_0._tf

	var_1(var_3.Find(var_2_1, "Battle/Nodes"), function(arg_3_0, arg_3_1)
		arg_2_0.seriesNodes[arg_3_0.name] = arg_3_0

		return
	end)

	local var_2_2 = arg_2_0.rtStoryAward

	arg_2_0.progressText = var_1.Find(var_2_2, "Text")

	for iter_2_0 = 1, arg_2_0.rtStoryItems.childCount do
		local var_2_3 = arg_2_0.rtStoryItems
		local var_2_4 = var_5.GetChild(var_2_3, iter_2_0 - 1)
		local var_2_5 = var_5.GetComponent

		typeof = var_1_10009
		LayoutElement = var_1_10011

		local var_2_6 = var_2_5(var_2_4, var_1_10009(var_1_10011))
		local var_2_7

		if iter_2_0 ~= arg_2_0.index or not arg_2_0.EXPAND_WIDTH then
			var_2_7 = arg_2_0.CLOSE_WIDTH
		end

		var_2_6.preferredWidth = var_2_7
		setCanvasGroupAlpha = var_2_6

		local var_2_8 = var_5:Find("close")

		var_1_10009 = iter_2_0 == arg_2_0.index and 0 or 1

		var_2_6(var_2_8, var_1_10009)

		setText = var_2_6

		local var_2_9 = var_5:Find("get/Text")

		i18n = var_1_10009

		var_2_6(var_2_9, var_1_10009("SardiniaSPCoreActivityUI_unlock"))

		onButton = var_2_6

		local var_2_10 = arg_2_0

		var_1_10009 = var_5

		local function var_2_11()
			if arg_2_0.blockAnim then
				return
			end

			local var_4_0 = arg_2_0

			var_0.SelectItem(var_4_0, iter_2_0)

			return
		end

		SFX_PANEL = var_1_10011

		var_2_6(var_2_10, var_1_10009, var_2_11, var_1_10011)
	end

	arg_2_0.ActionSequence = {}

	return
end

function var_0_1.SetActivity(arg_5_0, arg_5_1)
	arg_5_0.activity = arg_5_1

	return
end

function var_0_1.SetPtActivity(arg_6_0, arg_6_1)
	arg_6_0.ptActivity = arg_6_1
	setText = var_1_10002

	var_1_10002(arg_6_0.countPT, arg_6_0.ptActivity.data1)

	setActive = var_1_10002

	local var_6_0 = arg_6_0.tipPT

	Activity = var_5

	var_1_10002(var_6_0, var_5.IsActivityReady(arg_6_0.ptActivity))

	return
end

function var_0_1.SetStoryActivity(arg_7_0, arg_7_1)
	arg_7_0.storyActivity = arg_7_1
	arg_7_0.storyList = arg_7_1:GetConfigClientSetting("story")

	return
end

function var_0_1.SetTasksActivity(arg_8_0, arg_8_1)
	arg_8_0.tasksActivity = arg_8_1

	return
end

function var_0_1.SelectItem(arg_9_0, arg_9_1)
	if arg_9_0.index == arg_9_1 then
		return
	end

	arg_9_0.index = arg_9_1
	arg_9_0.blockAnim = true
	ipairs = var_2

	local var_9_0

	if not arg_9_0.LTList then
		var_9_0 = {}
	end

	for iter_9_0, iter_9_1 in var_2(var_9_0) do
		LeanTween = var_1_10007

		var_1_10007.cancel(iter_9_1)
	end

	arg_9_0.LTList = {}

	for iter_9_2 = 1, arg_9_0.rtStoryItems.childCount do
		local var_9_1 = arg_9_0.rtStoryItems
		local var_9_2 = var_6.GetChild(var_9_1, iter_9_2 - 1)
		local var_9_3 = var_6.GetComponent

		typeof = var_1_10010
		LayoutElement = var_1_10012

		local var_9_4 = var_9_3(var_9_2, var_1_10010(var_1_10012)).preferredWidth
		local var_9_5

		if iter_9_2 ~= arg_9_1 or not arg_9_0.EXPAND_WIDTH then
			var_9_5 = arg_9_0.CLOSE_WIDTH
		end

		if var_9_4 ~= var_9_5 then
			math = var_1_10010
			var_1_10010 = var_1_10010.abs(var_9_5 - var_9_4) / arg_9_0.DURATION_PARAMETER
			table = var_11

			local var_9_6 = var_11.insert
			local var_9_7 = arg_9_0.LTList

			LeanTween = var_1_10014
			var_1_10014 = var_1_10014.value
			go = var_1_10016
			var_1_10016 = var_1_10014(var_1_10016(var_6), var_9_4, var_9_5, var_1_10010)
			var_1_10014 = var_1_10014.setEase
			LeanTweenType = var_17
			var_1_10016 = var_1_10014(var_1_10016, var_17.easeOutSine)
			var_1_10014 = var_1_10014.setOnUpdate
			System = var_17

			var_9_6(var_9_7, var_1_10014(var_1_10016, var_17.Action_float(function(arg_10_0)
				var_0.preferredWidth = arg_10_0

				return
			end)).uniqueId)

			table = var_9_6

			local var_9_8 = var_9_6.insert
			local var_9_9 = arg_9_0.LTList

			LeanTween = var_1_10014
			var_1_10014 = var_1_10014.alphaCanvas

			local var_9_10 = var_6:Find("close")

			var_1_10016 = var_1_10016.GetComponent
			typeof = var_19
			CanvasGroup = var_1_10021
			var_1_10016 = var_1_10014(var_1_10016(var_9_10, var_19(var_1_10021)), iter_9_2 == arg_9_1 and 0 or 1, var_1_10010)
			var_1_10014 = var_1_10014.setEase
			LeanTweenType = var_17

			var_9_8(var_9_9, var_1_10014(var_1_10016, var_17.easeOutSine).uniqueId)
		end
	end

	pg = var_2

	local var_9_11 = var_2.NewStoryMgr.GetInstance()

	if arg_9_0.index ~= 1 and arg_9_0.storyActivity.data1 > 0 and not var_9_11:IsPlayed(arg_9_0.storyList[arg_9_0.index - 1][1]) then
		local var_9_12 = arg_9_0
		local var_9_13 = arg_9_0.emit

		BossRushVerSardiniaSPMediator = var_6

		var_9_13(var_9_12, var_6.ON_ACTIVITY_UNLOCKSTOIRY, arg_9_0.storyActivity.id, var_9_11:StoryName2StoryId(arg_9_0.storyList[arg_9_0.index - 1][1]))
	else
		arg_9_0:UpdataStoryState()
	end

	return
end

function var_0_1.didEnter(arg_11_0)
	onButton = var_1_10001

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.btnBack

	local function var_11_2()
		local var_12_0 = arg_11_0

		var_0.closeView(var_12_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_11_0, var_11_1, var_11_2, var_1_10006)

	onButton = var_1_10001

	local var_11_3 = arg_11_0
	local var_11_4 = arg_11_0.btnHome

	local function var_11_5()
		local var_13_0 = arg_11_0

		var_0.quickExitFunc(var_13_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_11_3, var_11_4, var_11_5, var_1_10006)

	onButton = var_1_10001

	local var_11_6 = arg_11_0
	local var_11_7 = arg_11_0.btnHelp

	local function var_11_8()
		pg = var_2_10000

		local var_14_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_14_1 = var_0.ShowMsgBox
		local var_14_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_14_2.type = var_2_10004
		i18n = var_2_10004
		var_14_2.helps = var_2_10004("SardiniaSPCoreActivityUI_help")

		var_14_1(var_14_0, var_14_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_11_6, var_11_7, var_11_8, var_1_10006)

	onButton = var_1_10001

	local var_11_9 = arg_11_0
	local var_11_10 = arg_11_0.btnRank

	local function var_11_11()
		local var_15_0 = arg_11_0
		local var_15_1 = var_0.emit

		BossRushVerSardiniaSPMediator = var_2_10003

		var_15_1(var_15_0, var_2_10003.ON_EXTRA_RANK)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_11_9, var_11_10, var_11_11, var_1_10006)

	onButton = var_1_10001

	local var_11_12 = arg_11_0
	local var_11_13 = arg_11_0.btnPT

	local function var_11_14()
		local var_16_0 = arg_11_0
		local var_16_1 = var_0.emit

		BossRushVerSardiniaSPMediator = var_2_10003

		local var_16_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_16_1(var_16_0, var_16_2, var_2_10004.ACTIVITY, {
			id = arg_11_0.ptActivity.id
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_11_12, var_11_13, var_11_14, var_1_10006)

	onButton = var_1_10001

	local var_11_15 = arg_11_0
	local var_11_16 = arg_11_0.btnTask

	local function var_11_17()
		local var_17_0 = arg_11_0
		local var_17_1 = var_0.emit

		BossRushVerSardiniaSPMediator = var_2_10003

		local var_17_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_17_1(var_17_0, var_17_2, var_2_10004.TASK)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_11_15, var_11_16, var_11_17, var_1_10006)

	onButton = var_1_10001

	local var_11_18 = arg_11_0
	local var_11_19 = arg_11_0.switchToggle
	local var_11_20 = var_4.Find(var_11_19, "Story")

	local function var_11_21()
		if arg_11_0.blockAnim then
			return
		end

		local var_18_0 = arg_11_0

		var_0.SetDisplayMode(var_18_0, var_0_1.DISPLAY.BATTLE)

		return
	end

	SFX_PANEL = var_11_19

	var_1_10001(var_11_18, var_11_20, var_11_21, var_11_19)

	onButton = var_1_10001

	local var_11_22 = arg_11_0
	local var_11_23 = arg_11_0.switchToggle
	local var_11_24 = var_4.Find(var_11_23, "Battle")

	local function var_11_25()
		if arg_11_0.blockAnim then
			return
		end

		local var_19_0 = arg_11_0

		var_0.SetDisplayMode(var_19_0, var_0_1.DISPLAY.STORY)

		return
	end

	SFX_PANEL = var_11_23

	var_1_10001(var_11_22, var_11_24, var_11_25, var_11_23)

	local var_11_26 = arg_11_0
	local var_11_27 = arg_11_0.SetDisplayMode
	local var_11_28

	if not arg_11_0.contextData.displayMode then
		var_11_28 = var_0_1.DISPLAY.BATTLE
	end

	var_11_27(var_11_26, var_11_28)

	return
end

function var_0_1.SetDisplayMode(arg_20_0, arg_20_1)
	arg_20_0.contextData.displayMode = arg_20_1

	arg_20_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_21_0)
	local var_21_0 = arg_21_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE
	local var_21_1 = arg_21_0.switchToggle
	local var_21_2 = var_2.Find(var_21_1, arg_21_0.contextData.displayMode)

	var_2.SetAsLastSibling(var_21_2)

	setActive = var_2

	var_2(arg_21_0.rtPageBattle, var_21_0)

	setActive = var_2

	var_2(arg_21_0.rtPageStory, not var_21_0)

	if var_21_0 then
		arg_21_0:UpdateBattle()
	else
		arg_21_0:UpdateStory()
	end

	arg_21_0:UpdateTipDisplay()

	return
end

function var_0_1.UpdateBattle(arg_22_0)
	local var_22_0 = arg_22_0.activity

	if arg_22_0.contextData.showFlash then
		underscore = var_2

		local var_22_1

		if not var_2.to_array(var_22_0:GetPassCounts()) then
			var_22_1 = nil
		end

		arg_22_0.contextData.showFlash = nil

		local var_22_2 = {}

		ipairs = var_4

		for iter_22_0, iter_22_1 in var_4(var_22_0:getConfig("config_data")) do
			local var_22_3 = arg_22_0.seriesNodes

			tostring = var_1_10010

			local var_22_4 = var_22_3[var_1_10010(iter_22_1)]

			BossRushSeriesData = var_1_10010
			var_22_2[iter_22_0] = var_1_10010.New({
				id = iter_22_1,
				actId = var_22_0.id
			})

			local var_22_5 = var_1_10010
			local var_22_6 = var_1_10010.IsUnlock(var_22_5, var_22_0)

			setActive = var_12

			var_12(var_22_4:Find("lock"), not var_22_6)

			local var_22_7 = var_22_0
			local var_22_8 = var_22_0.HasPassSeries(var_22_7, var_1_10010.id)

			setActive = var_22_5

			var_22_5(var_22_4:Find("finish"), var_22_8)

			setActive = var_22_5

			local var_22_9 = var_22_4:Find("finish")
			local var_22_10 = var_15.GetChild(var_22_9, 0)

			if var_22_1 and arg_22_0.contextData.passCounts then
				table = var_22_11

				local var_22_11

				if not var_22_11.contains(arg_22_0.contextData.passCounts, var_1_10010.id) then
					table = var_22_11
					var_22_11 = var_22_11.contains(var_22_1, var_1_10010.id)
				else
					var_22_11 = false
				end
			end

			if false then
				var_22_11 = true
			end

			var_22_5(var_22_10, var_22_11)

			local var_22_12 = var_1_10010:GetType()

			BossRushSeriesData = var_22_7

			local var_22_13 = var_22_12 == var_22_7.TYPE.SP
			local var_22_14 = true

			if var_22_13 then
				setActive = var_22_11

				var_22_11(var_22_4:Find("times"), var_22_6)

				if not var_22_0:GetUsedBonus()[iter_22_0] then
					var_22_11 = 0
				end

				var_22_14 = var_1_10010:GetMaxBonusCount() - var_22_11 > 0
				setText = var_18

				local var_22_15 = var_22_4
				local var_22_16 = var_22_4.Find(var_22_15, "times/Text")

				i18n = var_1_10021
				var_1_10021 = var_1_10021("series_enemy_SP_count")
				setColorStr = var_22_15
				math = var_1_10024

				var_18(var_22_16, var_1_10021 .. var_22_15(var_1_10024.max(0, var_17 - var_22_11) .. "/" .. var_17, "#f77d24"))
			end

			onButton = var_22_11

			local var_22_17 = arg_22_0
			local var_22_18 = var_22_4

			local function var_22_19()
				if not var_22_6 then
					local var_23_0 = var_1_10010
					local var_23_1 = var_0.GetPreSeriesId(var_23_0)

					BossRushSeriesData = var_2_10001

					local var_23_2 = var_2_10001.New({
						id = var_23_1
					})

					pg = var_23_0

					local var_23_3 = var_23_0.TipsMgr.GetInstance()
					local var_23_4 = var_2.ShowTips

					i18n = var_2_10005

					var_23_4(var_23_3, var_2_10005("series_enemy_unlock", var_23_2:GetName()))

					return
				end

				if not var_22_14 then
					pg = var_0

					local var_23_5 = var_0.TipsMgr.GetInstance()
					local var_23_6 = var_0.ShowTips

					i18n = var_2_10003

					var_23_6(var_23_5, var_2_10003("series_enemy_SP_error"))

					return
				end

				local var_23_7 = {}
				local var_23_8

				if iter_22_0 > 1 then
					local var_23_9 = var_1_10010

					if var_2.IsFleetsEmpty(var_23_9) then
						table = var_2

						var_2.insert(var_23_7, function(arg_24_0)
							pg = var_3_10001

							local var_24_0 = var_3_10001.MsgboxMgr.GetInstance()
							local var_24_1 = var_1.ShowMsgBox
							local var_24_2 = {}

							i18n = var_3_10005
							var_24_2.content = var_3_10005("SardiniaSPCoreActivityUI_fleetconfirm")

							function var_24_2.onYes()
								local var_25_0 = var_1_10010

								var_0.CopyFleetsByOther(var_25_0, var_22_2[iter_22_0 - 1])
								arg_24_0()

								return
							end

							var_24_2.onNo = arg_24_0

							var_24_1(var_24_0, var_24_2)

							return
						end)
					end
				end

				seriesAsync = var_2

				var_2(var_23_7, function()
					local var_26_0 = arg_22_0
					local var_26_1 = var_0.emit

					BossRushVerSardiniaSPMediator = var_3_10003

					var_26_1(var_26_0, var_3_10003.ON_FLEET_SELECT, var_1_10010)

					return
				end)

				return
			end

			SFX_PANEL = var_1_10021

			var_22_11(var_22_17, var_22_18, var_22_19, var_1_10021)
		end

		return
	end
end

var_0_1.EXPAND_WIDTH = 628
var_0_1.CLOSE_WIDTH = 136
var_0_1.DURATION_PARAMETER = 1500

function var_0_1.UpdateStory(arg_27_0)
	if not arg_27_0.index then
		arg_27_0:SelectItem(1)
	else
		arg_27_0:UpdataStoryState()
	end

	return
end

function var_0_1.UpdataStoryState(arg_28_0, arg_28_1)
	pg = var_1_10002

	local var_28_0 = var_1_10002.NewStoryMgr.GetInstance()
	local var_28_1

	if not arg_28_1 or not var_28_0:StoryId2StoryName(arg_28_1) then
		var_28_1 = nil
	end

	assert = var_1_10004

	var_1_10004(not arg_28_1 or arg_28_0.storyList[arg_28_0.index - 1][1] == var_28_1)

	eachChild = var_1_10004

	var_1_10004(arg_28_0.rtStoryItems, function(arg_29_0, arg_29_1)
		arg_29_1 = arg_29_1 + 1

		local var_29_0
		local var_29_1
		local var_29_2

		if arg_29_1 == 1 then
			var_29_0 = false
			var_29_2 = false
		else
			var_29_0 = arg_28_0.index == arg_29_1 and arg_28_1

			if not var_29_0 then
				local var_29_3 = var_28_0

				var_29_0 = var_2_10004.IsPlayed(var_29_3, arg_28_0.storyList[arg_29_1 - 1][1])
			end

			var_29_2 = arg_28_0.storyActivity.data1 > 0
		end

		setActive = var_2_10004

		var_2_10004(arg_29_0:Find("got"), var_29_0)

		setActive = var_2_10004

		var_2_10004(arg_29_0:Find("get"), not var_29_0 and var_29_2)

		return
	end)

	local var_28_2 = {}

	if arg_28_0.index == 1 then
		local var_28_3 = arg_28_0.activity
		local var_28_4 = var_5.GetConfigClientSetting(var_28_3, "openStory")

		if not var_28_0:IsPlayed(var_28_4) then
			table = var_6

			var_6.insert(var_28_2, function(arg_30_0)
				local var_30_0 = var_28_0

				var_1.Play(var_30_0, var_28_4, arg_30_0)

				return
			end)
		end
	end

	if var_28_1 and not var_28_0:IsPlayed(var_28_1) then
		table = var_5

		var_5.insert(var_28_2, function(arg_31_0)
			local var_31_0 = var_28_0

			var_1.Play(var_31_0, var_28_1, arg_31_0)

			return
		end)
	end

	local var_28_5 = arg_28_0.activity
	local var_28_6 = var_5.GetConfigClientSetting(var_28_5, "endStory")

	if not var_28_0:IsPlayed(var_28_6) then
		underscore = var_6

		if var_6.all(arg_28_0.storyList, function(arg_32_0)
			local var_32_0 = var_28_0
			local var_32_1

			if not var_1.IsPlayed(var_32_0, arg_32_0[1]) then
				var_32_1 = arg_32_0[1] == var_28_1
			end

			return var_32_1
		end) then
			table = var_6

			var_6.insert(var_28_2, function(arg_33_0)
				local var_33_0 = var_28_0

				var_1.Play(var_33_0, var_28_6, arg_33_0)

				return
			end)
		end
	end

	arg_28_0.blockAnim = false
	seriesAsync = var_6

	var_6(var_28_2, function()
		local var_34_0 = arg_28_0

		var_0.UpdateStoryTask(var_34_0)

		return
	end)

	return
end

function var_0_1.PlayStory(arg_35_0, arg_35_1, arg_35_2)
	if not arg_35_1 then
		existCall = var_1_10003

		return var_1_10003(arg_35_2)
	end

	pg = var_1_10003

	local var_35_0 = var_1_10003.NewStoryMgr.GetInstance()
	local var_35_1 = var_3.IsPlayed(var_35_0, arg_35_1)

	seriesAsync = var_1_10005

	var_1_10005({
		function(arg_36_0)
			if var_35_1 then
				return arg_36_0()
			end

			tonumber = var_1

			if var_1(arg_35_1) and var_1 > 0 then
				local var_36_0 = arg_35_0
				local var_36_1 = var_2.emit

				BossRushVerSardiniaSPMediator = var_2_10005

				var_36_1(var_36_0, var_2_10005.ON_PERFORM_COMBAT, var_1)
			else
				local var_36_2 = var_0

				var_2.Play(var_36_2, arg_35_1, arg_36_0)
			end

			return
		end
	}, arg_35_2)

	return
end

function var_0_1.UpdateStoryTask(arg_37_0)
	local var_37_0 = arg_37_0.activity
	local var_37_1 = var_1.GetConfigClientSetting(var_37_0, "tasks")[1]

	getProxy = var_1_10002
	TaskProxy = var_4

	local var_37_2 = var_1_10002(var_4)
	local var_37_3

	if not var_2.getTaskVO(var_37_2, var_37_1) then
		Task = var_37_3
		var_37_3 = var_37_3.New({
			submit_time = 1,
			id = var_37_1
		})
	end

	arg_37_0.storyTask = var_37_3

	local var_37_4 = arg_37_0.storyTask
	local var_37_5 = var_2.getProgress(var_37_4)
	local var_37_6 = arg_37_0.storyTask
	local var_37_7 = var_3.getTargetNumber(var_37_6)

	setText = var_37_4

	local var_37_8 = arg_37_0.progressText

	i18n = var_1_10007

	var_37_4(var_37_8, var_1_10007("SardiniaSPCoreActivityUI_story_reward_count", arg_37_0.storyActivity.data1, var_37_5))

	local var_37_9 = arg_37_0.storyTask
	local var_37_10 = var_4.getConfig(var_37_9, "award_display")

	Drop = var_37_6

	local var_37_11 = var_37_6.Create(var_37_10[1])
	local var_37_12 = arg_37_0.rtStoryAward
	local var_37_13 = var_6.Find(var_37_12, "IconTpl")

	updateDrop = var_7

	var_7(var_37_13, var_37_11)

	onButton = var_7

	local var_37_14 = arg_37_0
	local var_37_15 = var_37_13

	local function var_37_16()
		local var_38_0 = arg_37_0
		local var_38_1 = var_0.emit

		BaseUI = var_2_10003

		var_38_1(var_38_0, var_2_10003.ON_DROP, var_37_11)

		return
	end

	SFX_PANEL = var_1_10012

	var_7(var_37_14, var_37_15, var_37_16, var_1_10012)

	local var_37_17 = arg_37_0.storyTask
	local var_37_18 = var_7.getTaskStatus(var_37_17)

	setActive = var_37_12

	var_37_12(var_37_13:Find("get"), var_37_18 == 1)

	setActive = var_37_12

	var_37_12(var_37_13:Find("got"), var_37_18 == 2)

	if var_37_18 == 1 then
		local var_37_19 = arg_37_0
		local var_37_20 = arg_37_0.emit

		BossRushVerSardiniaSPMediator = var_11

		var_37_20(var_37_19, var_11.ON_TASK_SUBMIT, arg_37_0.storyTask)
	end

	return
end

function var_0_1.addbubbleMsgBoxList(arg_39_0, arg_39_1)
	local var_39_0 = #arg_39_0.ActionSequence == 0

	table = var_1_10003

	var_1_10003.insertto(arg_39_0.ActionSequence, arg_39_1)

	if not var_39_0 then
		return
	end

	arg_39_0:resumeBubble()

	return
end

function var_0_1.addbubbleMsgBox(arg_40_0, arg_40_1)
	local var_40_0 = #arg_40_0.ActionSequence == 0

	table = var_1_10003

	var_1_10003.insert(arg_40_0.ActionSequence, arg_40_1)

	if not var_40_0 then
		return
	end

	arg_40_0:resumeBubble()

	return
end

function var_0_1.resumeBubble(arg_41_0)
	if #arg_41_0.ActionSequence == 0 then
		return
	end

	local var_41_0

	;(function()
		if arg_41_0.ActionSequence[1] then
			var_0(function()
				table = var_3_10000

				var_3_10000.remove(arg_41_0.ActionSequence, 1)
				var_0()

				return
			end)
		end

		return
	end)()

	return
end

function var_0_1.CleanBubbleMsgbox(arg_44_0)
	table = var_1_10001

	var_1_10001.clean(arg_44_0.ActionSequence)

	return
end

function var_0_1.UpdateTipDisplay(arg_45_0)
	setActive = var_1_10001

	var_1_10001(arg_45_0.rtToggleTip, arg_45_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE and arg_45_0:IsStoryTip())

	setActive = var_1_10001

	local var_45_0 = arg_45_0.btnTask
	local var_45_1 = var_3.Find(var_45_0, "tip")

	Activity = var_4

	var_1_10001(var_45_1, var_4.IsActivityReady(arg_45_0.tasksActivity))

	return
end

function var_0_1.IsStoryTip(arg_46_0)
	pg = var_1_10001

	local var_46_0 = var_1_10001.NewStoryMgr.GetInstance()
	local var_46_1 = var_1.IsPlayed
	local var_46_2 = arg_46_0.activity

	if not var_46_1(var_46_0, var_5.GetConfigClientSetting(var_46_2, "openStory")) then
		return true
	end

	Activity = var_2

	if var_2.IsActivityReady(arg_46_0.storyActivity) then
		return true
	end

	local var_46_3 = var_1
	local var_46_4 = var_1.IsPlayed
	local var_46_5 = arg_46_0.activity

	if not var_46_4(var_46_3, var_5.GetConfigClientSetting(var_46_5, "endStory")) then
		underscore = var_2

		if var_2.all(arg_46_0.storyList, function(arg_47_0)
			local var_47_0 = var_0

			return var_1.IsPlayed(var_47_0, arg_47_0[1])
		end) then
			return true
		end
	end

	local var_46_6 = arg_46_0.activity

	if var_2.GetConfigClientSetting(var_46_6, "tasks")[1] then
		::label_46_0::

		getProxy = var_1_10003
		TaskProxy = var_5

		local var_46_7 = var_1_10003(var_5)

		var_1_10003 = var_1_10003.getTaskVO(var_46_7, var_2)
	end

	if var_1_10003 and var_1_10003:getTaskStatus() == 1 then
		return true
	end

	return false
end

function var_0_1.willExit(arg_48_0)
	local var_48_0 = arg_48_0.contextData

	underscore = var_1_10002

	local var_48_1 = var_1_10002.to_array
	local var_48_2 = arg_48_0.activity

	var_48_0.passCounts = var_48_1(var_4.GetPassCounts(var_48_2))

	return
end

return var_0_1
