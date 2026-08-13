class = var_0_10000

local var_0_0 = "SculptureScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.OPEN_GRATITUDE_PAGE = "SculptureScene:OPEN_GRATITUDE_PAGE"

local var_0_2 = 5
local var_0_3 = 6

function var_0_1.getUIName(arg_1_0)
	return "SculptureUI"
end

function var_0_1.SetActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1

	return
end

function var_0_1.GetBaseActivity(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)
	local var_3_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	return var_3_1(var_3_0, var_1_10004.ACTIVITY_TYPE_VIRTUAL_BAG)
end

function var_0_1.OnUpdateActivity(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0:SetActivity(arg_4_3)

	ipairs = var_4

	for iter_4_0, iter_4_1 in var_4(arg_4_0.cards) do
		if iter_4_1.id == arg_4_2 then
			iter_4_1:Flush(arg_4_3)

			break
		end
	end

	SculptureActivity = var_4

	if arg_4_1 == var_4.STATE_FINSIH then
		if arg_4_0.gratitudePage then
			local var_4_0 = arg_4_0.gratitudePage

			if var_4.GetLoaded(var_4_0) then
				local var_4_1 = arg_4_0.gratitudePage

				var_4.Flush(var_4_1, arg_4_3)
			end
		end

		arg_4_0:UpdateAward()
	else
		SculptureActivity = var_4

		if arg_4_1 == var_4.STATE_UNLOCK then
			arg_4_0:EnterDrawLinePage(arg_4_2)
			arg_4_0:UpdateRes()
		else
			SculptureActivity = var_4

			if arg_4_1 == var_4.STATE_DRAW then
				arg_4_0:EnterPuzzlePage(arg_4_2)
			else
				SculptureActivity = var_4

				if arg_4_1 == var_4.STATE_JOINT then
					arg_4_0:EnterPresentedPage(arg_4_2)
				end
			end
		end
	end

	return
end

function var_0_1.init(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.backBtn = var_1.Find(var_5_0, "back")

	local var_5_1 = arg_5_0._tf

	arg_5_0.helpBtn = var_1.Find(var_5_1, "help")

	local var_5_2 = arg_5_0._tf

	arg_5_0.awardBtn = var_1.Find(var_5_2, "award")

	local var_5_3 = arg_5_0._tf
	local var_5_4 = var_1.Find(var_5_3, "award/Text")
	local var_5_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_5_0.awardTxt = var_5_5(var_5_4, var_4(var_1_10006))

	local var_5_6 = arg_5_0._tf

	arg_5_0.ore = var_1.Find(var_5_6, "ore")

	local var_5_7 = arg_5_0._tf
	local var_5_8 = var_1.Find(var_5_7, "ore/icon")
	local var_5_9 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_5_0.oreIcon = var_5_9(var_5_8, var_4(var_1_10006))

	local var_5_10 = arg_5_0._tf
	local var_5_11 = var_1.Find(var_5_10, "ore/Text")
	local var_5_12 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_5_0.oreTxt = var_5_12(var_5_11, var_4(var_1_10006))

	local var_5_13 = arg_5_0._tf

	arg_5_0.feather = var_1.Find(var_5_13, "feather")

	local var_5_14 = arg_5_0._tf
	local var_5_15 = var_1.Find(var_5_14, "feather/icon")
	local var_5_16 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_5_0.featherIcon = var_5_16(var_5_15, var_4(var_1_10006))

	local var_5_17 = arg_5_0._tf
	local var_5_18 = var_1.Find(var_5_17, "feather/Text")
	local var_5_19 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_5_0.featherTxt = var_5_19(var_5_18, var_4(var_1_10006))

	local var_5_20 = arg_5_0._tf

	arg_5_0.tpl = var_1.Find(var_5_20, "frame/content/tpl")
	setActive = var_1

	var_1(arg_5_0.tpl, false)

	arg_5_0.tpls = {}
	SculptureDrawLinePage = var_1
	arg_5_0.drawLinePage = var_1.New(arg_5_0._tf, arg_5_0.event, arg_5_0.contextData)
	SculpturePuzzlePage = var_1
	arg_5_0.puzzlePage = var_1.New(arg_5_0._tf, arg_5_0.event, arg_5_0.contextData)
	SculpturePresentedPage = var_1
	arg_5_0.presentedPage = var_1.New(arg_5_0._tf, arg_5_0.event, arg_5_0.contextData)
	SculptureGratitudePage = var_1
	arg_5_0.gratitudePage = var_1.New(arg_5_0._tf, arg_5_0.event, arg_5_0.contextDat)
	SculptureAwardInfoPage = var_1
	arg_5_0.awardInfoPage = var_1.New(arg_5_0._tf, arg_5_0.event, arg_5_0.contextDat)
	SculptureResMsgBoxPage = var_1
	arg_5_0.resMsgBoxPage = var_1.New(arg_5_0._tf, arg_5_0.event)

	local var_5_21 = arg_5_0.contextData

	SculptureMsgBoxPage = var_1_10002
	var_5_21.msgBoxPage = var_1_10002.New(arg_5_0._tf, arg_5_0.event)

	local var_5_22 = arg_5_0.contextData

	SculptureTipPage = var_2
	var_5_22.tipPage = var_2.New(arg_5_0._tf, arg_5_0.event)

	local var_5_23 = arg_5_0.contextData

	SculptureMiniMsgBoxPage = var_2
	var_5_23.miniMsgBox = var_2.New(arg_5_0._tf, arg_5_0.event)
	Input = var_5_23
	var_5_23.multiTouchEnabled = false

	arg_5_0:bind(var_0_1.OPEN_GRATITUDE_PAGE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_5_0.gratitudePage

		var_2.ExecuteAction(var_6_0, "Show", arg_6_1, arg_5_0.activity, function()
			if arg_5_0.presentedPage then
				local var_7_0 = arg_5_0.presentedPage

				if var_0.GetLoaded(var_7_0) then
					local var_7_1 = arg_5_0.presentedPage

					var_0.Hide(var_7_1)
				end
			end

			return
		end)

		return
	end)

	return
end

function var_0_1.didEnter(arg_8_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_9_0)
			local var_9_0 = arg_8_0

			var_1.UpdateResIcon(var_9_0)

			local var_9_1 = arg_8_0

			var_1.UpdateRes(var_9_1)

			local var_9_2 = arg_8_0

			var_1.UpdateAward(var_9_2)

			local var_9_3 = arg_8_0

			var_1.InitMainView(var_9_3, arg_9_0)

			return
		end,
		function(arg_10_0)
			local var_10_0 = arg_8_0

			var_1.RegisterEvent(var_10_0, arg_10_0)

			return
		end
	})

	return
end

function var_0_1.UpdateResIcon(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.activity_workbench_item[var_0_2]
	local var_11_1 = arg_11_0.oreIcon

	LoadSprite = var_1_10003
	var_11_1.sprite = var_1_10003("props/" .. var_11_0.icon)
	pg = var_11_1

	local var_11_2 = var_11_1.activity_workbench_item[var_0_3]
	local var_11_3 = arg_11_0.featherIcon

	LoadSprite = var_1_10004
	var_11_3.sprite = var_1_10004("props/" .. var_11_2.icon)
	rtf = var_11_3

	local var_11_4 = var_11_3(arg_11_0.oreIcon.gameObject)

	Vector2 = var_4
	var_11_4.sizeDelta = var_4(80, 80)
	rtf = var_11_4

	local var_11_5 = var_11_4(arg_11_0.featherIcon.gameObject)

	Vector2 = var_4
	var_11_5.sizeDelta = var_4(80, 80)

	return
end

function var_0_1.InitMainView(arg_12_0, arg_12_1)
	arg_12_0.cards = {}

	local var_12_0 = {}

	ipairs = var_1_10003

	local var_12_1 = arg_12_0.activity

	for iter_12_0, iter_12_1 in var_1_10003(var_5.getConfig(var_12_1, "config_data")) do
		table = var_8

		var_8.insert(var_12_0, function(arg_13_0)
			local var_13_0 = #arg_12_0.tpls

			if 0 < var_13_0 then
				table = var_13_1

				local var_13_1

				if not var_13_1.remove(arg_12_0.tpls, 1) then
					Object = var_13_1
					var_13_1 = var_13_1.Instantiate(arg_12_0.tpl, arg_12_0.tpl.parent).transform
				end

				setActive = var_2_10003

				var_2_10003(var_13_1, true)

				local var_13_2 = arg_12_0
				local var_13_3 = var_3.CreateNewCard(var_13_2, var_13_1, iter_12_1)

				table = var_2_10004

				var_2_10004.insert(arg_12_0.cards, var_13_3)

				if not var_1 then
					onNextTick = var_4

					var_4(arg_13_0)
				else
					arg_13_0()
				end

				return
			end
		end)
	end

	seriesAsync = var_3

	var_3(var_12_0, arg_12_1)

	return
end

function var_0_1.UpdateRes(arg_14_0)
	local var_14_0 = arg_14_0:GetBaseActivity()

	arg_14_0.oreTxt.text = var_14_0:getVitemNumber(var_0_2)
	arg_14_0.featherTxt.text = var_14_0:getVitemNumber(var_0_3)

	return
end

function var_0_1.UpdateAward(arg_15_0)
	local var_15_0 = arg_15_0.activity
	local var_15_1, var_15_2 = var_1.GetAwardProgress(var_15_0)

	arg_15_0.awardTxt.text = var_15_1 .. "/" .. var_15_2

	return
end

function var_0_1.CreateNewCard(arg_16_0, arg_16_1, arg_16_2)
	SculptureCard = var_1_10003

	local var_16_0 = var_1_10003.New(arg_16_1)

	var_3.Update(var_16_0, arg_16_2, arg_16_0.activity)

	onButton = var_4

	local var_16_1 = arg_16_0
	local var_16_2 = var_3.continueBtn

	local function var_16_3()
		local var_17_0 = arg_16_0.activity
		local var_17_1 = var_0.GetSculptureState(var_17_0, arg_16_2)

		SculptureActivity = var_2_10001

		if var_17_1 == var_2_10001.STATE_UNLOCK then
			local var_17_2 = arg_16_0

			var_1.EnterDrawLinePage(var_17_2, arg_16_2)
		else
			SculptureActivity = var_1

			if var_17_1 == var_1.STATE_DRAW then
				local var_17_3 = arg_16_0

				var_1.EnterPuzzlePage(var_17_3, arg_16_2)
			end
		end

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_16_1, var_16_2, var_16_3, var_1_10009)

	onButton = var_4

	local var_16_4 = arg_16_0
	local var_16_5 = var_3.lockBtn

	local function var_16_6()
		local var_18_0 = arg_16_0.activity
		local var_18_1, var_18_2 = var_0._GetComsume(var_18_0, arg_16_2)
		local var_18_3 = arg_16_0.activity
		local var_18_4 = var_2.GetResorceName(var_18_3, arg_16_2)
		local var_18_5 = arg_16_0.contextData.msgBoxPage
		local var_18_6 = var_3.ExecuteAction
		local var_18_7 = "Show"
		local var_18_8 = {
			nextBtn = true
		}
		local var_18_9 = arg_16_0.activity

		var_18_8.content = var_8.getDataConfig(var_18_9, arg_16_2, "describe")
		var_18_8.consume = var_18_2
		var_18_8.consumeId = var_18_1

		function var_18_8.onYes()
			local var_19_0 = arg_16_0
			local var_19_1 = var_0.emit

			SculptureMediator = var_3_10003

			var_19_1(var_19_0, var_3_10003.ON_UNLOCK_SCULPTURE, arg_16_2)

			return
		end

		local var_18_10 = arg_16_0.activity

		var_18_8.iconName = var_8.GetResorceName(var_18_10, arg_16_2)
		var_18_8.title = var_18_4 .. "_title"

		var_18_6(var_18_5, var_18_7, var_18_8)

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_16_4, var_16_5, var_16_6, var_1_10009)

	onButton = var_4

	local var_16_7 = arg_16_0
	local var_16_8 = var_3.finishBtn

	local function var_16_9()
		local var_20_0 = arg_16_0.activity
		local var_20_1 = var_0.GetResorceName(var_20_0, arg_16_2)
		local var_20_2 = arg_16_0.contextData.msgBoxPage
		local var_20_3 = var_1.ExecuteAction
		local var_20_4 = "Show"
		local var_20_5 = {}
		local var_20_6 = arg_16_0.activity

		var_20_5.content = var_6.getDataConfig(var_20_6, arg_16_2, "describe")
		var_20_5.title = var_20_1 .. "_title"

		var_20_3(var_20_2, var_20_4, var_20_5)

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_16_7, var_16_8, var_16_9, var_1_10009)

	onButton = var_4

	local var_16_10 = arg_16_0
	local var_16_11 = var_3.tr

	local function var_16_12()
		local var_21_0 = arg_16_0.activity
		local var_21_1 = var_0.GetSculptureState(var_21_0, arg_16_2)

		SculptureActivity = var_2_10001

		if var_21_1 == var_2_10001.STATE_FINSIH then
			triggerButton = var_1

			var_1(var_0.finishBtn)
		else
			triggerButton = var_1

			var_1(var_0.continueBtn)
		end

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_16_10, var_16_11, var_16_12, var_1_10009)

	onButton = var_4

	local var_16_13 = arg_16_0
	local var_16_14 = var_3.presentedBtn

	local function var_16_15()
		local var_22_0 = arg_16_0

		var_0.EnterPresentedPage(var_22_0, arg_16_2)

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_16_13, var_16_14, var_16_15, var_1_10009)

	return var_3
end

function var_0_1.RegisterEvent(arg_23_0, arg_23_1)
	onButton = var_1_10002

	local var_23_0 = arg_23_0
	local var_23_1 = arg_23_0.backBtn

	local function var_23_2()
		local var_24_0 = arg_23_0

		var_0.emit(var_24_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_23_0, var_23_1, var_23_2, var_1_10007)

	onButton = var_1_10002

	local var_23_3 = arg_23_0
	local var_23_4 = arg_23_0.awardBtn

	local function var_23_5()
		local var_25_0 = arg_23_0.awardInfoPage

		var_0.ExecuteAction(var_25_0, "Show", arg_23_0.activity)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_23_3, var_23_4, var_23_5, var_1_10007)

	onButton = var_1_10002

	local var_23_6 = arg_23_0
	local var_23_7 = arg_23_0.helpBtn

	local function var_23_8()
		pg = var_2_10000

		local var_26_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_26_1 = var_0.ShowMsgBox
		local var_26_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_26_2.type = var_2_10004
		pg = var_2_10004
		var_26_2.helps = var_2_10004.gametip.gift_act_help.tip

		var_26_1(var_26_0, var_26_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_23_6, var_23_7, var_23_8, var_1_10007)

	onButton = var_1_10002

	local var_23_9 = arg_23_0
	local var_23_10 = arg_23_0.ore

	local function var_23_11()
		local var_27_0 = arg_23_0.resMsgBoxPage

		var_0.ExecuteAction(var_27_0, "Show", var_0_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_23_9, var_23_10, var_23_11, var_1_10007)

	onButton = var_1_10002

	local var_23_12 = arg_23_0
	local var_23_13 = arg_23_0.feather

	local function var_23_14()
		local var_28_0 = arg_23_0.resMsgBoxPage

		var_0.ExecuteAction(var_28_0, "Show", var_0_3)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_23_12, var_23_13, var_23_14, var_1_10007)

	return
end

function var_0_1.EnterDrawLinePage(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.drawLinePage

	var_2.ExecuteAction(var_29_0, "Show", arg_29_1, arg_29_0.activity)

	return
end

function var_0_1.EnterPresentedPage(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.presentedPage

	var_2.ExecuteAction(var_30_0, "Show", arg_30_1, arg_30_0.activity, function()
		if arg_30_0.puzzlePage then
			local var_31_0 = arg_30_0.puzzlePage

			if var_0.GetLoaded(var_31_0) then
				local var_31_1 = arg_30_0.puzzlePage

				var_0.Hide(var_31_1)
			end
		end

		return
	end)

	return
end

function var_0_1.EnterPuzzlePage(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.puzzlePage

	var_2.ExecuteAction(var_32_0, "Show", arg_32_1, arg_32_0.activity, function()
		if arg_32_0.drawLinePage then
			local var_33_0 = arg_32_0.drawLinePage

			if var_0.GetLoaded(var_33_0) then
				local var_33_1 = arg_32_0.drawLinePage

				var_0.Hide(var_33_1)
			end
		end

		return
	end)

	return
end

function var_0_1.onBackPressed(arg_34_0)
	var_0_1.super.onBackPressed(arg_34_0)

	return
end

function var_0_1.willExit(arg_35_0)
	ipairs = var_1_10001

	for iter_35_0, iter_35_1 in var_1_10001(arg_35_0.cards) do
		iter_35_1:Dispose()
	end

	arg_35_0.cards = nil

	if arg_35_0.contextData.msgBoxPage then
		local var_35_0 = arg_35_0.contextData.msgBoxPage

		var_1.Destroy(var_35_0)

		arg_35_0.contextData.msgBoxPage = nil
	end

	if arg_35_0.drawLinePage then
		local var_35_1 = arg_35_0.drawLinePage

		var_1.Destroy(var_35_1)

		arg_35_0.drawLinePage = nil
	end

	if arg_35_0.contextData.tipPage then
		local var_35_2 = arg_35_0.contextData.tipPage

		var_1.Destroy(var_35_2)

		arg_35_0.contextData.tipPage = nil
	end

	if arg_35_0.puzzlePage then
		local var_35_3 = arg_35_0.puzzlePage

		var_1.Destroy(var_35_3)

		arg_35_0.puzzlePage = nil
	end

	if arg_35_0.contextData.miniMsgBox then
		local var_35_4 = arg_35_0.contextData.miniMsgBox

		var_1.Destroy(var_35_4)

		arg_35_0.contextData.miniMsgBox = nil
	end

	if arg_35_0.awardInfoPage then
		local var_35_5 = arg_35_0.awardInfoPage

		var_1.Destroy(var_35_5)

		arg_35_0.awardInfoPage = nil
	end

	if arg_35_0.resMsgBoxPage then
		local var_35_6 = arg_35_0.resMsgBoxPage

		var_1.Destroy(var_35_6)

		arg_35_0.resMsgBoxPage = nil
	end

	Input = var_1
	var_1.multiTouchEnabled = true

	return
end

return var_0_1
