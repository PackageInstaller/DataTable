class = var_0_10000

local var_0_0 = "CommanderUsageTalentPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderCatUsageTalentUI"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "bg/frame/bg/talents/content")
	local var_2_3 = arg_2_0._tf

	arg_2_0.usageList = var_2_0(var_2_2, var_4.Find(var_2_3, "bg/frame/bg/talents/content/talent"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.usageCancelBtn = var_1.Find(var_2_4, "bg/frame/cancel_btn")

	local var_2_5 = arg_2_0._tf

	arg_2_0.usageConfirmBtn = var_1.Find(var_2_5, "bg/frame/confirm_btn")

	local var_2_6 = arg_2_0._tf

	arg_2_0.usageConfirmUpgrade = var_1.Find(var_2_6, "bg/frame/confirm_btn/upgrade")

	local var_2_7 = arg_2_0._tf

	arg_2_0.usageConfirmILearned = var_1.Find(var_2_7, "bg/frame/confirm_btn/learned")

	local var_2_8 = arg_2_0._tf

	arg_2_0.usageTalent = var_1.Find(var_2_8, "bg/frame/bg/talent")

	local var_2_9 = arg_2_0._tf

	arg_2_0.usageCostIconTF = var_1.Find(var_2_9, "bg/frame/consume/Image")

	local var_2_10 = arg_2_0._tf

	arg_2_0.usageCostTxtTF = var_1.Find(var_2_10, "bg/frame/consume/Text")

	local var_2_11 = arg_2_0.usageCostTxtTF
	local var_2_12 = var_1.GetComponent

	typeof = var_4
	Text = var_2_3
	arg_2_0.usageCostTxt = var_2_12(var_2_11, var_4(var_2_3))

	local var_2_13 = arg_2_0._tf

	arg_2_0.usageCloseBtn = var_1.Find(var_2_13, "bg/frame/close_btn")
	CommanderReplaceTalentPage = var_1
	arg_2_0.replacePage = var_1.New(arg_2_0._parentTf.parent, arg_2_0.event)
	setText = var_1

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_3.Find(var_2_14, "bg/frame/bg/title/Text")

	i18n = var_4

	var_1(var_2_15, var_4("commander_choice_talent_1"))

	setText = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_3.Find(var_2_16, "bg/frame/bg/talents/title/Text")

	i18n = var_4

	var_1(var_2_17, var_4("commander_choice_talent_2"))

	setText = var_1

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_3.Find(var_2_18, "bg/frame/consume/label")

	i18n = var_4

	var_1(var_2_19, var_4("word_consume"))

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0:RegisterEvent()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.usageCancelBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.usageCloseBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.usageConfirmBtn

	local function var_3_11()
		local var_7_0 = arg_3_0.commanderVO

		if arg_3_0.talent and var_7_0:fullTalentCnt() and not var_7_0:hasTalent(arg_3_0.talent) then
			local var_7_1 = arg_3_0.replacePage

			var_1.ExecuteAction(var_7_1, "Show", var_7_0, arg_3_0.talent)
		elseif arg_3_0.talent then
			local var_7_2 = arg_3_0
			local var_7_3 = var_1.emit

			CommanderCatMediator = var_2_10004

			var_7_3(var_7_2, var_2_10004.LEARN_TALENT, var_7_0.id, arg_3_0.talent.id, 0)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_9, var_3_10, var_3_11, var_1_10006)

	return
end

function var_0_1.RegisterEvent(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.bind

	CommanderCatScene = var_1_10004

	var_8_1(var_8_0, var_1_10004.MSG_FETCH_TALENT_LIST, function(arg_9_0)
		if arg_8_0.commanderVO then
			getProxy = var_1
			CommanderProxy = var_2_10003

			local var_9_0 = var_1(var_2_10003)
			local var_9_1 = var_1.getCommanderById(var_9_0, arg_8_0.commanderVO.id)
			local var_9_2 = arg_8_0

			var_2.Flush(var_9_2, var_9_1)
		end

		return
	end)

	local var_8_2 = arg_8_0
	local var_8_3 = arg_8_0.bind

	CommanderCatScene = var_4

	var_8_3(var_8_2, var_4.MSG_LEARN_TALENT, function(arg_10_0)
		if arg_8_0.commanderVO then
			getProxy = var_1
			CommanderProxy = var_2_10003

			local var_10_0 = var_1(var_2_10003)
			local var_10_1 = var_1.getCommanderById(var_10_0, arg_8_0.commanderVO.id)

			if var_1.getTalentPoint(var_10_1) <= 0 then
				local var_10_2 = arg_8_0

				var_2.Hide(var_10_2)

				return
			end

			local var_10_3 = arg_8_0

			var_2.Flush(var_10_3, var_1)
		end

		return
	end)

	return
end

function var_0_1.Show(arg_11_0, arg_11_1)
	var_0_1.super.Show(arg_11_0)

	local var_11_0 = arg_11_0._tf

	var_2.SetAsLastSibling(var_11_0)
	arg_11_0:Flush(arg_11_1)
	arg_11_0:UpdateStyle()

	return
end

function var_0_1.Flush(arg_12_0, arg_12_1)
	arg_12_0.commanderVO = arg_12_1

	if not arg_12_1:getNotLearnedList() or #var_2 == 0 then
		arg_12_0:FetchList()
	else
		arg_12_0:UpdateList()
	end

	return
end

function var_0_1.UpdateStyle(arg_13_0)
	setActive = var_1_10001

	var_1_10001(arg_13_0.usageCostIconTF, false)

	setActive = var_1_10001

	var_1_10001(arg_13_0.usageCostTxtTF, false)

	return
end

function var_0_1.FetchList(arg_14_0)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.emit

	CommanderCatMediator = var_1_10004

	var_14_1(var_14_0, var_1_10004.FETCH_NOT_LEARNED_TALENT, arg_14_0.commanderVO.id)

	return
end

function var_0_1.UpdateList(arg_15_0)
	local var_15_0 = arg_15_0.commanderVO
	local var_15_1 = var_1.getNotLearnedList(var_15_0)
	local var_15_2 = arg_15_0.usageList

	var_3.make(var_15_2, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = var_15_1[arg_16_1 + 1]
			local var_16_1 = arg_15_0

			var_4.UpdateCard(var_16_1, var_16_0, arg_16_2)

			if arg_16_1 == 0 then
				triggerToggle = var_4

				var_4(arg_16_2, true)
			end
		end

		return
	end)

	local var_15_3 = arg_15_0.usageList

	var_3.align(var_15_3, #var_15_1)

	return
end

function var_0_1.UpdateCard(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.commanderVO
	local var_17_1 = var_3.hasTalent(var_17_0, arg_17_1)

	setActive = var_1_10005

	var_1_10005(arg_17_2:Find("up"), var_17_1)

	GetImageSpriteFromAtlasAsync = var_1_10005

	local var_17_2 = "CommanderTalentIcon/"
	local var_17_3 = arg_17_1

	var_1_10005(var_17_2 .. arg_17_1.getConfig(var_17_3, "icon"), "", arg_17_2)

	onToggle = var_1_10005

	local var_17_4 = arg_17_0
	local var_17_5 = arg_17_2

	local function var_17_6(arg_18_0)
		if arg_18_0 and (not arg_17_0.talent or arg_17_0.talent.id ~= arg_17_1.id) then
			arg_17_0.talent = arg_17_1

			local var_18_0 = arg_17_0

			var_1.UpdateTalentCard(var_18_0, arg_17_0.usageTalent, arg_17_1)

			local var_18_1 = arg_17_1
			local var_18_2 = var_1.getConfig(var_18_1, "cost")

			setActive = var_2

			var_2(arg_17_0.usageCostIconTF, var_18_2 > 0)

			setActive = var_2

			var_2(arg_17_0.usageCostTxtTF, var_18_2 > 0)

			local var_18_3 = arg_17_0.usageCostTxt

			var_18_3.text = var_18_2
			setActive = var_18_3

			local var_18_4 = arg_17_0.usageConfirmUpgrade
			local var_18_5 = var_0

			var_18_3(var_18_4, var_5.hasTalent(var_18_5, arg_17_1))

			setActive = var_18_3

			local var_18_6 = arg_17_0.usageConfirmILearned
			local var_18_7 = var_0

			var_18_3(var_18_6, not var_5.hasTalent(var_18_7, arg_17_1))
		end

		return
	end

	SFX_PANEL = var_17_3

	var_1_10005(var_17_4, var_17_5, var_17_6, var_17_3)

	return
end

function var_0_1.UpdateTalentCard(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1
	local var_19_1 = arg_19_1.Find(var_19_0, "unlock")
	local var_19_2 = arg_19_1
	local var_19_3 = arg_19_1.Find(var_19_2, "lock")

	if arg_19_2 then
		GetImageSpriteFromAtlasAsync = var_19_0

		local var_19_4 = "CommanderTalentIcon/" .. arg_19_2:getConfig("icon")
		local var_19_5 = ""
		local var_19_6 = var_19_1

		var_19_0(var_19_4, var_19_5, var_19_1.Find(var_19_6, "icon"))

		if var_19_1:Find("tree_btn") then
			onButton = var_19_2

			local var_19_7 = arg_19_0
			local var_19_8 = var_19_0

			local function var_19_9()
				local var_20_0 = arg_19_0.contextData.treePanel

				var_0.ExecuteAction(var_20_0, "Show", arg_19_2)

				return
			end

			SFX_PANEL = var_19_6

			var_19_2(var_19_7, var_19_8, var_19_9, var_19_6)
		end

		setText = var_19_2

		var_19_2(var_19_1:Find("name_bg/Text"), arg_19_2:getConfig("name"))

		setScrollText = var_19_2

		var_19_2(var_19_1:Find("desc/Text"), arg_19_2:getConfig("desc"))
	end

	setActive = var_19_0

	var_19_0(var_19_1, arg_19_2)

	if var_19_3 then
		setActive = var_19_0

		var_19_0(var_19_3, not arg_19_2)
	end

	return
end

function var_0_1.CanBack(arg_21_0)
	if arg_21_0.replacePage then
		local var_21_0 = arg_21_0.replacePage

		if var_1.GetLoaded(var_21_0) then
			local var_21_1 = arg_21_0.replacePage

			if var_1.isShowing(var_21_1) then
				local var_21_2 = arg_21_0.replacePage

				var_1.Hide(var_21_2)

				return false
			end
		end
	end

	return true
end

function var_0_1.OnDestroy(arg_22_0)
	if arg_22_0.replacePage then
		local var_22_0 = arg_22_0.replacePage

		var_1.Destroy(var_22_0)

		arg_22_0.replacePage = nil
	end

	return
end

return var_0_1
