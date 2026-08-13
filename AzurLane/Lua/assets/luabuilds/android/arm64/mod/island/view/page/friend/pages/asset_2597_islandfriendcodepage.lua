class = var_0_10000

local var_0_0 = "IslandFriendCodePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))
local var_0_2 = 4

function var_0_1.getUIName(arg_1_0)
	return "IslandFirendCodeUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.enterBtn = var_1.Find(var_2_0, "frame/visit")

	local var_2_1 = arg_2_0._tf

	arg_2_0.saveBtn = var_1.Find(var_2_1, "frame/like")

	local var_2_2 = arg_2_0._tf

	arg_2_0.inputTr = var_1.Find(var_2_2, "frame/input")
	UIItemList = var_1

	local var_2_3 = var_1.New
	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_3.Find(var_2_4, "frame/list")
	local var_2_6 = arg_2_0._tf

	arg_2_0.uiItemlist = var_2_3(var_2_5, var_4.Find(var_2_6, "frame/list/tpl"))

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "frame/sub_title/Text")
	local var_2_9 = var_1.GetComponent

	typeof = var_4
	Text = var_2_6
	arg_2_0.tipTxt = var_2_9(var_2_8, var_4(var_2_6))
	arg_2_0.frequentlyUsedList = arg_2_0:GetSaveCodeList()
	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_3.Find(var_2_10, "frame/title/Text")

	i18n = var_4

	var_1(var_2_11, var_4("island_input_code_tip"))

	setText = var_1

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_3.Find(var_2_12, "frame/input/Text")

	i18n = var_4

	var_1(var_2_13, var_4("island_input_code_tip_1"))

	setText = var_1

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_3.Find(var_2_14, "frame/like/Text")

	i18n = var_4

	var_1(var_2_15, var_4("island_set_like"))

	setText = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_3.Find(var_2_16, "frame/visit/Text")

	i18n = var_4

	var_1(var_2_17, var_4("island_btn_label_visit"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.enterBtn

	local function var_3_2()
		getInputText = var_2_10000

		if not var_2_10000(arg_3_0.inputTr) or var_0 == "" then
			pg = var_2_10001

			local var_4_0 = var_2_10001.TipsMgr.GetInstance()

			var_2_10001 = var_2_10001.ShowTips
			i18n = var_2_10004

			var_2_10001(var_4_0, var_2_10004("island_input_code_erro"))

			return
		end

		pg = var_2_10001

		local var_4_1 = var_2_10001.GameTrackerMgr.GetInstance()
		local var_4_2 = var_1.Record

		GameTrackerBuilder = var_2_10004

		var_4_2(var_4_1, var_2_10004.BuildIslandVisitByCode())

		local var_4_3 = arg_3_0
		local var_4_4 = var_1.emit

		IslandMediator = var_4

		var_4_4(var_4_3, var_4.ENTER_ISLAND_BY_CODE, var_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.saveBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.AddCode(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)
	arg_3_0:InitFrequentlyUsedList()

	return
end

function var_0_1.GetSaveCodeList(arg_6_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.getRawData(var_6_0).id

	PlayerPrefs = var_1_10002

	if var_1_10002.GetString("_ISLAND_CODE_" .. var_6_1, "") == "" then
		return {}
	end

	string = var_6_0

	return (var_6_0.split(var_2, "#"))
end

function var_0_1.AddCode(arg_7_0)
	local var_7_0 = #arg_7_0.frequentlyUsedList

	if var_0_2 <= var_7_0 then
		pg = var_7_0

		local var_7_1 = var_7_0.TipsMgr.GetInstance()

		var_7_0 = var_7_0.ShowTips
		i18n = var_1_10004

		var_7_0(var_7_1, var_1_10004("island_visit_tip7"))

		return
	end

	getInputText = var_7_0

	local var_7_3

	if not var_7_0(arg_7_0.inputTr) or var_1 == "" then
		pg = var_7_3

		local var_7_2 = var_7_3.TipsMgr.GetInstance()

		var_7_3 = var_7_3.ShowTips
		i18n = var_1_10005

		var_7_3(var_7_2, var_1_10005("island_input_code_erro"))

		return
	end

	table = var_7_3

	local var_7_5

	if var_7_3.contains(arg_7_0.frequentlyUsedList, var_1) then
		pg = var_7_5

		local var_7_4 = var_7_5.TipsMgr.GetInstance()

		var_7_5 = var_7_5.ShowTips
		i18n = var_5

		var_7_5(var_7_4, var_5("island_code_exist"))

		return
	end

	table = var_7_5

	var_7_5.insert(arg_7_0.frequentlyUsedList, var_1)
	arg_7_0:InitFrequentlyUsedList()

	return
end

function var_0_1.RemoveCode(arg_8_0, arg_8_1)
	table = var_1_10002

	var_1_10002.removebyvalue(arg_8_0.frequentlyUsedList, arg_8_1)
	arg_8_0:InitFrequentlyUsedList()

	return
end

function var_0_1.SaveCodeList(arg_9_0)
	table = var_1_10001

	local var_9_0 = var_1_10001.concat(arg_9_0.frequentlyUsedList, "#")

	getProxy = var_1_10002
	PlayerProxy = var_4

	local var_9_1 = var_1_10002(var_4)
	local var_9_2 = var_2.getRawData(var_9_1).id

	PlayerPrefs = var_3

	local var_9_3 = var_3.SetString("_ISLAND_CODE_" .. var_9_2, var_9_0)

	PlayerPrefs = var_9_1

	var_9_1.Save()

	return
end

function var_0_1.InitFrequentlyUsedList(arg_10_0)
	local var_10_0 = arg_10_0.uiItemlist

	var_1.make(var_10_0, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_10_0.frequentlyUsedList[arg_11_1 + 1]

			setActive = var_4

			var_4(arg_11_2:Find("btns"), var_11_0)

			setActive = var_4

			var_4(arg_11_2:Find("empty"), not var_11_0)

			if var_11_0 then
				local var_11_1 = arg_10_0

				var_4.UpdateCodeTpl(var_11_1, arg_11_2:Find("btns"), var_11_0)
			end
		end

		return
	end)

	local var_10_1 = arg_10_0.uiItemlist

	var_1.align(var_10_1, var_0_2)

	local var_10_2 = arg_10_0.tipTxt

	i18n = var_1_10002
	var_10_2.text = var_1_10002("island_like_title") .. #arg_10_0.frequentlyUsedList .. "/" .. var_0_2

	return
end

function var_0_1.UpdateCodeTpl(arg_12_0, arg_12_1, arg_12_2)
	setText = var_1_10003

	var_1_10003(arg_12_1:Find("id/Text"), arg_12_2)

	onButton = var_1_10003

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_1
	local var_12_2 = arg_12_1.Find(var_12_1, "copy")

	local function var_12_3()
		UniPasteBoard = var_2_10000

		var_2_10000.SetClipBoardString(arg_12_2)

		pg = var_0

		local var_13_0 = var_0.TipsMgr.GetInstance()
		local var_13_1 = var_0.ShowTips

		i18n = var_2_10003

		var_13_1(var_13_0, var_2_10003("friend_id_copy_ok"))

		return
	end

	SFX_PANEL = var_12_1

	var_1_10003(var_12_0, var_12_2, var_12_3, var_12_1)

	onButton = var_1_10003

	local var_12_4 = arg_12_0
	local var_12_5 = arg_12_1
	local var_12_6 = arg_12_1.Find(var_12_5, "remove")

	local function var_12_7()
		local var_14_0 = arg_12_0

		var_0.RemoveCode(var_14_0, arg_12_2)

		return
	end

	SFX_PANEL = var_12_5

	var_1_10003(var_12_4, var_12_6, var_12_7, var_12_5)

	setText = var_1_10003

	local var_12_8 = arg_12_1:Find("remove/Text")

	i18n = var_12_6

	var_1_10003(var_12_8, var_12_6("island_btn_label_remove"))

	setText = var_1_10003

	local var_12_9 = arg_12_1:Find("copy/Text")

	i18n = var_6

	var_1_10003(var_12_9, var_6("island_btn_label_copy"))

	return
end

function var_0_1.Hide(arg_15_0)
	var_0_1.super.Hide(arg_15_0)
	arg_15_0:SaveCodeList()

	return
end

function var_0_1.OnDestroy(arg_16_0)
	if arg_16_0:isShowing() then
		arg_16_0:Hide()
	end

	return
end

return var_0_1
