class = var_0_10000

local var_0_0 = "CatterySettlementPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CatterySettlementPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.painting = var_1.Find(var_2_0, "painting")
	UIItemList = var_1

	local var_2_1 = var_1.New
	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_3.Find(var_2_2, "frame/commanders")
	local var_2_4 = arg_2_0._tf

	arg_2_0.uilist = var_2_1(var_2_3, var_4.Find(var_2_4, "frame/commanders/tpl"))
	setText = var_1

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_3.Find(var_2_5, "dialogue/label/Text1")

	i18n = var_4

	var_1(var_2_6, var_4("cattery_settlement_dialogue_1"))

	setText = var_1

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_3.Find(var_2_7, "dialogue/label/Text3")

	i18n = var_4

	var_1(var_2_8, var_4("cattery_settlement_dialogue_2"))

	setText = var_1

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_3.Find(var_2_9, "dialogue/label1/Text1")

	i18n = var_4

	var_1(var_2_10, var_4("cattery_settlement_dialogue_3"))

	setText = var_1

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_3.Find(var_2_11, "dialogue/label1/Text3")

	i18n = var_4

	var_1(var_2_12, var_4("cattery_settlement_dialogue_4"))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "dialogue/label/Text2")
	local var_2_15 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.timeTxt = var_2_15(var_2_14, var_4(var_6))

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_1.Find(var_2_16, "dialogue/label1/Text2")
	local var_2_18 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.expTxt = var_2_18(var_2_17, var_4(var_6))

	local var_2_19 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_19, "comfirm")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Destroy(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	arg_3_0.cards = {}

	local var_3_3 = arg_3_0.uilist

	var_1.make(var_3_3, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_3_0.displays[arg_5_1 + 1]
			local var_5_1 = arg_3_0

			var_4.UpdateCommander(var_5_1, arg_5_2, var_5_0)
		end

		return
	end)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1)
	var_0_1.super.Show(arg_6_0)

	arg_6_0.home = arg_6_1

	arg_6_0:SetPainting()
	arg_6_0:UpdateCommanders()
	arg_6_0:UpdateDialogue()

	pg = var_2

	local var_6_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_6_0, arg_6_0._tf)

	return
end

function var_0_1.Hide(arg_7_0)
	var_0_1.super.Hide(arg_7_0)

	pg = var_1

	local var_7_0 = var_1.UIMgr.GetInstance()
	local var_7_1 = var_1.UnOverlayPanel
	local var_7_2 = arg_7_0._tf

	pg = var_1_10005

	var_7_1(var_7_0, var_7_2, var_1_10005.UIMgr.GetInstance()._normalUIMain)

	return
end

function var_0_1.GetFlagShip(arg_8_0)
	Ship = var_1_10001

	return var_1_10001.New({
		id = 999,
		configId = 312011
	})
end

function var_0_1.SetPainting(arg_9_0)
	arg_9_0:ReturnPainting()

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.GetFlagShip(var_9_0)

	arg_9_0.paintingName = var_1.getPainting(var_9_1)
	setPaintingPrefabAsync = var_9_0

	var_9_0(arg_9_0.painting, var_2, "jiesuan")

	return
end

function var_0_1.UpdateCommanders(arg_10_0)
	local var_10_0 = arg_10_0.home
	local var_10_1 = var_1.GetCatteries(var_10_0)

	arg_10_0.displays = {}
	pairs = var_3

	for iter_10_0, iter_10_1 in var_3(var_10_1) do
		table = var_1_10008

		var_1_10008.insert(arg_10_0.displays, iter_10_1)
	end

	table = var_3

	var_3.sort(arg_10_0.displays, function(arg_11_0, arg_11_1)
		return arg_11_0:GetCommanderId() > arg_11_1:GetCommanderId()
	end)

	local var_10_2 = arg_10_0.uilist

	var_3.align(var_10_2, #arg_10_0.displays)

	return
end

function var_0_1.UpdateCommander(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	if not arg_12_0.cards[arg_12_1] then
		CatterySettlementCard = var_1_10004
		var_12_0 = var_1_10004.New(arg_12_1)
		arg_12_0.cards[arg_12_1] = var_12_0
	end

	var_12_0:Update(arg_12_2, arg_12_2:GetCacheExp())
	var_12_0:Action(function()
		return
	end)

	return
end

function var_0_1.UpdateDialogue(arg_14_0)
	local var_14_0 = arg_14_0.home
	local var_14_1 = var_1.GetCatteries(var_14_0)
	local var_14_2 = 0
	local var_14_3 = 0

	pairs = var_1_10005

	for iter_14_0, iter_14_1 in var_1_10005(var_14_1) do
		var_14_2 = var_14_2 + iter_14_1:GetCacheExp()

		if var_14_3 < iter_14_1:GetCacheExpTime() then
			var_14_3 = var_10
		end
	end

	local var_14_4 = arg_14_0.timeTxt

	pg = var_6

	local var_14_5 = var_6.TimeMgr.GetInstance()

	var_14_4.text = var_6.DescCDTime(var_14_5, var_14_3)
	arg_14_0.expTxt.text = var_14_2

	return
end

function var_0_1.ReturnPainting(arg_15_0)
	if arg_15_0.paintingName then
		retPaintingPrefab = var_1

		var_1(arg_15_0.painting, arg_15_0.paintingName)

		arg_15_0.paintingName = nil
	end

	return
end

function var_0_1.OnDestroy(arg_16_0)
	arg_16_0:ReturnPainting()

	pairs = var_1

	for iter_16_0, iter_16_1 in var_1(arg_16_0.cards) do
		iter_16_1:Dispose()
	end

	arg_16_0:Hide()

	arg_16_0.cards = nil

	return
end

return var_0_1
