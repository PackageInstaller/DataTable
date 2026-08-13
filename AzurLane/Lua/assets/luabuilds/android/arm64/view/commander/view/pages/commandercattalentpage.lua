class = var_0_10000

local var_0_0 = "CommanderCatTalentPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderCatTalentui"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.resetFrame = var_1.Find(var_2_0, "frame/point/reset_frame")

	local var_2_1 = arg_2_0._tf

	arg_2_0.resetTimeTF = var_1.Find(var_2_1, "frame/point/reset_frame/reset_time")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "frame/point/reset_frame/reset_time/Text")
	local var_2_4 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.resetTimeTxt = var_2_4(var_2_3, var_4(var_1_10006))

	local var_2_5 = arg_2_0._tf

	arg_2_0.resetTimeBtn = var_1.Find(var_2_5, "frame/point/reset_frame/reset_btn")

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "frame/point/usage_frame/point/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.pointTxt = var_2_8(var_2_7, var_4(var_1_10006))

	local var_2_9 = arg_2_0._tf

	arg_2_0.useBtn = var_1.Find(var_2_9, "frame/point/usage_frame/use_btn")
	UIItemList = var_1

	local var_2_10 = var_1.New
	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_3.Find(var_2_11, "frame/talents/content")
	local var_2_13 = arg_2_0._tf

	arg_2_0.uilist = var_2_10(var_2_12, var_4.Find(var_2_13, "frame/talents/content/talent_tpl"))
	CommanderResetTalentPage = var_1
	arg_2_0.resetPanel = var_1.New(arg_2_0._parentTf, arg_2_0.event, arg_2_0.contextData)
	CommanderUsageTalentPage = var_1
	arg_2_0.usagePanel = var_1.New(arg_2_0._parentTf, arg_2_0.event, arg_2_0.contextData)
	setText = var_1

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_3.Find(var_2_14, "frame/point/Text")

	i18n = var_4

	var_1(var_2_15, var_4("commander_level_up_tip"))

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0:RegisterEvent()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.resetTimeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0.commanderVO

		if var_0.IsSameTalent(var_4_0) then
			pg = var_0

			local var_4_1 = var_0.TipsMgr.GetInstance()
			local var_4_2 = var_0.ShowTips

			i18n = var_2_10003

			var_4_2(var_4_1, var_2_10003("commander_reset_talent_is_not_need"))

			return
		end

		if arg_3_0.inChapter then
			pg = var_0

			local var_4_3 = var_0.TipsMgr.GetInstance()
			local var_4_4 = var_0.ShowTips

			i18n = var_2_10003

			var_4_4(var_4_3, var_2_10003("commander_is_in_battle"))

			return
		end

		local var_4_5 = arg_3_0.commanderVO

		if var_0.CanReset(var_4_5) then
			local var_4_6 = arg_3_0.resetPanel

			var_0.ExecuteAction(var_4_6, "Show", arg_3_0.commanderVO)
		else
			pg = var_0

			local var_4_7 = var_0.TipsMgr.GetInstance()
			local var_4_8 = var_0.ShowTips

			i18n = var_2_10003

			var_4_8(var_4_7, var_2_10003("commander_reset_talent_time_no_rearch"))
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.useBtn

	local function var_3_5()
		if arg_3_0.inChapter then
			pg = var_0

			local var_5_0 = var_0.TipsMgr.GetInstance()
			local var_5_1 = var_0.ShowTips

			i18n = var_2_10003

			var_5_1(var_5_0, var_2_10003("commander_is_in_battle"))

			return
		end

		local var_5_2 = arg_3_0.commanderVO

		if var_0.getTalentPoint(var_5_2) > 0 then
			local var_5_3 = arg_3_0.usagePanel

			var_0.ExecuteAction(var_5_3, "Show", arg_3_0.commanderVO)
		else
			pg = var_0

			local var_5_4 = var_0.TipsMgr.GetInstance()
			local var_5_5 = var_0.ShowTips

			i18n = var_2_10003

			var_5_5(var_5_4, var_2_10003("commander_skill_point_noengough"))
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_3, var_3_4, var_3_5, var_1_10006)

	return
end

function var_0_1.RegisterEvent(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.bind

	CommanderCatScene = var_1_10004

	var_6_1(var_6_0, var_1_10004.EVENT_FOLD, function(arg_7_0, arg_7_1)
		if arg_7_1 then
			LeanTween = var_2_10002
			var_2_10002 = var_2_10002.moveX
			rtf = var_2_10004

			var_2_10002(var_2_10004(arg_6_0._tf), 1000, 0.5)
		else
			LeanTween = var_2_10002

			local var_7_0 = var_2_10002.moveX

			rtf = var_2_10004

			var_7_0(var_2_10004(arg_6_0._tf), -410, 0.5)
		end

		return
	end)

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.bind

	CommanderCatScene = var_4

	var_6_3(var_6_2, var_4.EVENT_SELECTED, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_6_0

		var_2.Flush(var_8_0, arg_8_1)

		return
	end)

	return
end

function var_0_1.Show(arg_9_0, arg_9_1)
	var_0_1.super.Show(arg_9_0)
	arg_9_0:Flush(arg_9_1)

	return
end

function var_0_1.Flush(arg_10_0, arg_10_1)
	arg_10_0.commanderVO = arg_10_1
	CommanderCatUtil = var_1_10002
	arg_10_0.inChapter = var_1_10002.CommanderInChapter(arg_10_0.commanderVO)

	arg_10_0:RemoveTimer()
	arg_10_0:UpdatePoint()
	arg_10_0:UpdateStyle()
	arg_10_0:UpdateTimer()
	arg_10_0:UpdateTalents()

	return
end

function var_0_1.UpdateTalents(arg_11_0)
	local var_11_0 = arg_11_0.commanderVO
	local var_11_1 = var_1.GetDisplayTalents(var_11_0)
	local var_11_2 = arg_11_0.uilist

	var_3.make(var_11_2, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = var_11_1[arg_12_1 + 1]
			local var_12_1 = arg_11_0

			var_4.UpdateTalentCard(var_12_1, arg_12_2, var_12_0)

			if var_12_0 then
				setActive = var_4

				local var_12_2 = arg_12_2:Find("unlock/lock")
				local var_12_3 = var_0

				var_4(var_12_2, not var_7.IsLearnedTalent(var_12_3, var_12_0.id))
			end
		end

		return
	end)

	local var_11_3 = arg_11_0.uilist
	local var_11_4 = var_3.align

	CommanderConst = var_6

	var_11_4(var_11_3, var_6.MAX_TELENT_COUNT)

	return
end

function var_0_1.UpdateTalentCard(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1
	local var_13_1 = arg_13_1.Find(var_13_0, "unlock")
	local var_13_2 = arg_13_1
	local var_13_3 = arg_13_1.Find(var_13_2, "lock")

	if arg_13_2 then
		GetImageSpriteFromAtlasAsync = var_13_0

		local var_13_4 = "CommanderTalentIcon/" .. arg_13_2:getConfig("icon")
		local var_13_5 = ""
		local var_13_6 = var_13_1

		var_13_0(var_13_4, var_13_5, var_13_1.Find(var_13_6, "icon"))

		if var_13_1:Find("tree_btn") then
			onButton = var_13_2

			local var_13_7 = arg_13_0
			local var_13_8 = var_13_0

			local function var_13_9()
				local var_14_0 = arg_13_0.contextData.treePanel

				var_0.ExecuteAction(var_14_0, "Show", arg_13_2)

				return
			end

			SFX_PANEL = var_13_6

			var_13_2(var_13_7, var_13_8, var_13_9, var_13_6)
		end

		setText = var_13_2

		var_13_2(var_13_1:Find("name_bg/Text"), arg_13_2:getConfig("name"))

		setScrollText = var_13_2

		var_13_2(var_13_1:Find("desc/Text"), arg_13_2:getConfig("desc"))
	end

	setActive = var_13_0

	var_13_0(var_13_1, arg_13_2)

	if var_13_3 then
		setActive = var_13_0

		var_13_0(var_13_3, not arg_13_2)
	end

	return
end

function var_0_1.UpdateTimer(arg_15_0)
	local var_15_0 = arg_15_0.commanderVO
	local var_15_1 = var_1.GetNextResetAbilityTime(var_15_0)

	pg = var_1_10003

	local var_15_2 = var_1_10003.TimeMgr.GetInstance()
	local var_15_3 = var_3.GetServerTime(var_15_2)
	local var_15_4 = var_1:getPt()
	local var_15_5 = 0 < var_15_4 or var_15_3 < var_15_1

	setActive = var_5

	var_5(arg_15_0.resetTimeBtn, var_15_5)

	setActive = var_5

	var_5(arg_15_0.resetTimeTF, var_15_5)
	arg_15_0:AddTimer()

	return
end

function var_0_1.AddTimer(arg_16_0)
	local var_16_0 = arg_16_0.commanderVO
	local var_16_1 = var_1.GetNextResetAbilityTime(var_16_0)

	pg = var_1_10003

	local var_16_2 = var_1_10003.TimeMgr.GetInstance()

	if var_16_1 <= var_3.GetServerTime(var_16_2) then
		var_16_0 = arg_16_0.resetTimeTxt
		i18n = var_16_2
		var_16_0.text = var_16_2("commander_reset_talent")
		setActive = var_16_0

		var_16_0(arg_16_0.resetTimeTF, false)

		return
	end

	Timer = var_16_0
	arg_16_0.timer = var_16_0.New(function()
		pg = var_2_10000

		local var_17_0 = var_2_10000.TimeMgr.GetInstance()

		var_0 = var_0.GetServerTime(var_17_0)

		if var_16_1 - var_0 > 0 then
			local var_17_1 = arg_16_0.resetTimeTxt

			pg = var_17_0

			local var_17_2 = var_17_0.TimeMgr.GetInstance()

			var_17_1.text = var_17_0.DescCDTime(var_17_2, var_0)
		else
			local var_17_3 = arg_16_0.resetTimeTxt

			i18n = var_17_0
			var_17_3.text = var_17_0("commander_reset_talent")
			setActive = var_17_3

			var_17_3(arg_16_0.resetTimeTF, false)
		end

		return
	end, 1, -1)

	local var_16_3 = arg_16_0.timer

	var_4.Start(var_16_3)
	arg_16_0.timer.func()

	return
end

function var_0_1.UpdatePoint(arg_18_0)
	local var_18_0 = arg_18_0.commanderVO

	arg_18_0.pointTxt.text = var_18_0:getTalentPoint()

	return
end

function var_0_1.UpdateStyle(arg_19_0)
	local var_19_0 = arg_19_0.commanderVO

	setActive = var_1_10002

	var_1_10002(arg_19_0.resetFrame, not var_19_0:IsRegularTalent())

	return
end

function var_0_1.RemoveTimer(arg_20_0)
	if arg_20_0.timer then
		local var_20_0 = arg_20_0.timer

		var_1.Stop(var_20_0)

		arg_20_0.timer = nil
	end

	return
end

function var_0_1.CanBack(arg_21_0)
	if arg_21_0.usagePanel then
		local var_21_0 = arg_21_0.usagePanel

		if var_1.GetLoaded(var_21_0) and arg_21_0.usagePanel.CanBack then
			local var_21_1 = arg_21_0.usagePanel

			if not var_1.CanBack(var_21_1) then
				return false
			end
		end
	end

	if arg_21_0.usagePanel then
		local var_21_2 = arg_21_0.usagePanel

		if var_1.GetLoaded(var_21_2) then
			local var_21_3 = arg_21_0.usagePanel

			if var_1.isShowing(var_21_3) then
				local var_21_4 = arg_21_0.usagePanel

				var_1.Hide(var_21_4)

				return false
			end
		end
	end

	if arg_21_0.resetPanel then
		local var_21_5 = arg_21_0.resetPanel

		if var_1.GetLoaded(var_21_5) then
			local var_21_6 = arg_21_0.resetPanel

			if var_1.isShowing(var_21_6) then
				local var_21_7 = arg_21_0.resetPanel

				var_1.Hide(var_21_7)

				return false
			end
		end
	end

	return true
end

function var_0_1.OnDestroy(arg_22_0)
	arg_22_0:RemoveTimer()

	if arg_22_0.usagePanel then
		local var_22_0 = arg_22_0.usagePanel

		var_1.Destroy(var_22_0)

		arg_22_0.usagePanel = nil
	end

	if arg_22_0.resetPanel then
		local var_22_1 = arg_22_0.resetPanel

		var_1.Destroy(var_22_1)

		arg_22_0.resetPanel = nil
	end

	return
end

return var_0_1
