class = var_0_10000

local var_0_0 = "IslandMsgBoxAutoCollectionWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandAutomaticCollectionMsgBox"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_0, "container/btns/confirm")

	local var_2_1 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_1, "container/btns/cancel")

	local var_2_2 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_2, "container/close")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "container/btns/cancel/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.cancelTxt = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "container/btns/confirm/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.confirmTxt = var_2_8(var_2_7, var_4(var_1_10006))

	local var_2_9 = arg_2_0.cancelTxt

	i18n = var_1_10002
	var_2_9.text = var_1_10002("word_cancel")

	local var_2_10 = arg_2_0.confirmTxt

	i18n = var_2
	var_2_10.text = var_2("word_ok")
	setText = var_2_10

	local var_2_11 = arg_2_0.uigatherText

	i18n = var_4

	var_2_10(var_2_11, var_4("island_chara_gather_tag_1"))

	setText = var_2_10

	local var_2_12 = arg_2_0.uimineText

	i18n = var_4

	var_2_10(var_2_12, var_4("island_chara_gather_tag_2"))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "container/title")
	local var_2_15 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.titleTxt = var_2_15(var_2_14, var_4(var_6))

	local var_2_16 = arg_2_0.titleTxt

	i18n = var_2
	var_2_16.text = var_2("island_msg_info")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.cancelBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.uigather

	local function var_3_8()
		local var_6_0 = arg_3_0.selectTypeDic

		IslandAutoCollectHelper = var_2_10001

		local var_6_1

		if not var_6_0[var_2_10001.SelectType.Gather] then
			var_6_1 = false
		end

		local var_6_2 = not var_6_1
		local var_6_3 = arg_3_0.selectTypeDic

		IslandAutoCollectHelper = var_2_10002
		var_6_3[var_2_10002.SelectType.Gather] = var_6_2
		setActive = var_6_3

		var_6_3(arg_3_0.uigatherselected, var_6_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.uimine

	local function var_3_11()
		local var_7_0 = arg_3_0.selectTypeDic

		IslandAutoCollectHelper = var_2_10001

		local var_7_1

		if not var_7_0[var_2_10001.SelectType.HandCollection] then
			var_7_1 = false
		end

		local var_7_2 = not var_7_1
		local var_7_3 = arg_3_0.selectTypeDic

		IslandAutoCollectHelper = var_2_10002
		var_7_3[var_2_10002.SelectType.HandCollection] = var_7_2
		setActive = var_7_3

		var_7_3(arg_3_0.uimineselected, var_7_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.closeBtn

	local function var_3_14()
		local var_8_0 = arg_3_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10006)

	onButton = var_1_10001

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.confirmBtn

	local function var_3_17()
		local var_9_0 = arg_3_0.selectTypeDic

		IslandAutoCollectHelper = var_2_10001

		local var_9_1 = var_9_0[var_2_10001.SelectType.Gather]
		local var_9_2 = arg_3_0.selectTypeDic

		IslandAutoCollectHelper = var_2_10002

		local var_9_3 = var_9_2[var_2_10002.SelectType.HandCollection]

		IslandAutoCollectHelper = var_2

		local var_9_4 = var_2.SelectType.None

		if var_9_1 and var_9_3 then
			IslandAutoCollectHelper = var_2_10003
			var_9_4 = var_2_10003.SelectType.Both
		elseif var_9_1 then
			IslandAutoCollectHelper = var_2_10003
			var_9_4 = var_2_10003.SelectType.Gather
		elseif var_9_3 then
			IslandAutoCollectHelper = var_2_10003
			var_9_4 = var_2_10003.SelectType.HandCollection
		end

		arg_3_0.onYes(var_9_4, function()
			local var_10_0 = arg_3_0

			var_0.Hide(var_10_0)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_15, var_3_16, var_3_17, var_1_10006)

	return
end

function var_0_1.OnShow(arg_11_0)
	arg_11_0.onYes = arg_11_0.settings.onYes
	arg_11_0.onNo = var_1.onNo
	arg_11_0.onHide = var_1.onHide
	arg_11_0.selectTypeDic = {}
	setActive = var_2

	var_2(arg_11_0.uigatherselected, false)

	setActive = var_2

	var_2(arg_11_0.uimineselected, false)

	return
end

function var_0_1.OnHide(arg_12_0)
	arg_12_0.onYes = nil
	arg_12_0.onNo = nil

	if arg_12_0.onHide then
		arg_12_0.onHide()

		arg_12_0.onHide = nil
	end

	return
end

return var_0_1
