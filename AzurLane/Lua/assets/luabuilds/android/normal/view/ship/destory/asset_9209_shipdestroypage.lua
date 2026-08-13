class = var_0_10000

local var_0_0 = "ShipDestroyPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "DestoryInfoUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/sliders/content")

	arg_2_0.cardScrollRect = var_1.GetComponent(var_2_1, "LScrollRect")

	function arg_2_0.cardScrollRect.onInitItem(arg_3_0)
		return
	end

	function arg_2_0.cardScrollRect.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0.shipIds[arg_4_0 + 1]

		DockyardShipItem = var_3

		local var_4_1 = var_3.New
		local var_4_2 = arg_4_1

		ShipStatus = var_2_10005

		local var_4_3 = var_4_1(var_4_2, var_2_10005.TAG_HIDE_DESTROY)

		var_3.update(var_4_3, arg_2_0.shipVOs[var_4_0])

		onButton = var_4

		local var_4_4 = arg_2_0
		local var_4_5 = var_3.tr

		local function var_4_6()
			existCall = var_3_10000

			var_3_10000(arg_2_0.OnCardClick, var_0)

			local var_5_0 = arg_2_0

			var_0.DisplayShipList(var_5_0)

			return
		end

		SFX_PANEL = var_2_10008

		var_4(var_4_4, var_4_5, var_4_6, var_2_10008)

		return
	end

	function arg_2_0.cardScrollRect.onReturnItem(arg_6_0, arg_6_1)
		removeOnButton = var_2_10002

		var_2_10002(arg_6_1)

		return
	end

	local var_2_2 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_2, "frame/cancel_button")

	local var_2_3 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_3, "frame/top/btnBack")

	local var_2_4 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_4, "frame/confirm_button")
	setText = var_1

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_2.Find(var_2_5, "frame/bg_award/label")

	i18n = var_2_5

	var_1(var_2_6, var_2_5("disassemble_available") .. ":")

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "frame/bg_award/res_list")

	UIItemList = var_2_7
	arg_2_0.resList = var_2_7.New(var_2_8, var_2_8:Find("res"))

	local var_2_9 = arg_2_0.resList

	var_2.make(var_2_9, function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_2_0.showList[arg_7_1]

			GetImageSpriteFromAtlasAsync = var_2_10004

			var_2_10004(var_7_0:getIcon(), "", arg_7_2:Find("icon"))

			setText = var_2_10004

			var_2_10004(arg_7_2:Find("Text"), "X" .. var_7_0.count)
		end

		return
	end)

	return
end

function var_0_1.OnInit(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.cancelBtn

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.Hide(var_9_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.backBtn

	local function var_8_5()
		local var_10_0 = arg_8_0

		var_0.Hide(var_10_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10005)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.confirmBtn

	local function var_8_8()
		if arg_8_0.OnConfirm then
			arg_8_0.OnConfirm()
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_6, var_8_7, var_8_8, var_1_10005)

	return
end

function var_0_1.SetConfirmCallBack(arg_12_0, arg_12_1)
	arg_12_0.OnConfirm = arg_12_1

	return
end

function var_0_1.SetCardClickCallBack(arg_13_0, arg_13_1)
	arg_13_0.OnCardClick = arg_13_1

	return
end

function var_0_1.Refresh(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.shipIds = arg_14_1
	arg_14_0.shipVOs = arg_14_2

	arg_14_0:DisplayShipList()
	arg_14_0:RefreshRes()
	arg_14_0:Show()

	return
end

function var_0_1.DisplayShipList(arg_15_0)
	local var_15_0 = arg_15_0.cardScrollRect

	var_1.SetTotalCount(var_15_0, #arg_15_0.shipIds)

	if #arg_15_0.shipIds == 0 then
		arg_15_0:Hide()
	end

	return
end

function var_0_1.CalcShipsReturnRes(arg_16_0, arg_16_1)
	_ = var_1_10002

	local var_16_0 = var_1_10002.map(arg_16_0, function(arg_17_0)
		return arg_16_1[arg_17_0]
	end)

	ShipCalcHelper = var_3

	return var_3.CalcDestoryRes(var_16_0)
end

function var_0_1.RefreshRes(arg_18_0)
	local var_18_0, var_18_1, var_18_2 = var_0_1.CalcShipsReturnRes(arg_18_0.shipIds, arg_18_0.shipVOs)

	table = var_1_10004

	local var_18_3 = var_1_10004.insert
	local var_18_4 = var_18_2
	local var_18_5 = 1

	Drop = var_1_10007

	local var_18_6 = var_1_10007.New
	local var_18_7 = {}

	DROP_TYPE_RESOURCE = var_1_10009
	var_18_7.type = var_1_10009
	PlayerConst = var_1_10009
	var_18_7.id = var_1_10009.ResOil
	var_18_7.count = var_18_1

	var_18_3(var_18_4, var_18_5, var_18_6(var_18_7))

	table = var_18_3

	local var_18_8 = var_18_3.insert
	local var_18_9 = var_18_2
	local var_18_10 = 1

	Drop = var_7

	local var_18_11 = var_7.New
	local var_18_12 = {}

	DROP_TYPE_RESOURCE = var_9
	var_18_12.type = var_9
	PlayerConst = var_9
	var_18_12.id = var_9.ResGold
	var_18_12.count = var_18_0

	var_18_8(var_18_9, var_18_10, var_18_11(var_18_12))

	underscore = var_18_8
	arg_18_0.showList = var_18_8.filter(var_18_2, function(arg_19_0)
		return arg_19_0.count > 0
	end)

	local var_18_13 = arg_18_0.resList

	var_4.align(var_18_13, #arg_18_0.showList)

	return
end

function var_0_1.Show(arg_20_0)
	var_0_1.super.Show(arg_20_0)

	pg = var_1

	local var_20_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_20_0, arg_20_0._tf)

	return
end

function var_0_1.Hide(arg_21_0)
	var_0_1.super.Hide(arg_21_0)

	pg = var_1

	local var_21_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_21_0, arg_21_0._tf, arg_21_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_22_0)
	arg_22_0.OnCardClick = nil
	ClearLScrollrect = var_1

	var_1(arg_22_0.cardScrollRect)
	arg_22_0:Hide()

	return
end

return var_0_1
