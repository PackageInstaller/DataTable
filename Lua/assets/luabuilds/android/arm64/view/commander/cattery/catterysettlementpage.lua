local var_0_0 = class("CatterySettlementPage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "CatterySettlementPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.painting = arg_2_0._tf:Find("painting")
	arg_2_0.uilist = UIItemList.New(arg_2_0._tf:Find("frame/commanders"), arg_2_0._tf:Find("frame/commanders/tpl"))

	setText(arg_2_0._tf:Find("dialogue/label/Text1"), i18n("cattery_settlement_dialogue_1"))
	setText(arg_2_0._tf:Find("dialogue/label/Text3"), i18n("cattery_settlement_dialogue_2"))
	setText(arg_2_0._tf:Find("dialogue/label1/Text1"), i18n("cattery_settlement_dialogue_3"))
	setText(arg_2_0._tf:Find("dialogue/label1/Text3"), i18n("cattery_settlement_dialogue_4"))

	arg_2_0.timeTxt = arg_2_0._tf:Find("dialogue/label/Text2"):GetComponent(typeof(Text))
	arg_2_0.expTxt = arg_2_0._tf:Find("dialogue/label1/Text2"):GetComponent(typeof(Text))
	arg_2_0.confirmBtn = arg_2_0._tf:Find("comfirm")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		arg_3_0:Destroy()

		return
	end, SFX_PANEL)

	arg_3_0.cards = {}

	arg_3_0.uilist:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateCommander(arg_5_2, arg_3_0.displays[arg_5_1 + 1])
		end

		return
	end)

	return
end

function var_0_0.Show(arg_6_0, arg_6_1)
	var_0_0.super.Show(arg_6_0)

	arg_6_0.home = arg_6_1

	arg_6_0:SetPainting()
	arg_6_0:UpdateCommanders()
	arg_6_0:UpdateDialogue()
	pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)

	return
end

function var_0_0.Hide(arg_7_0)
	var_0_0.super.Hide(arg_7_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0._tf, pg.UIMgr.GetInstance()._normalUIMain)

	return
end

function var_0_0.GetFlagShip(arg_8_0)
	return Ship.New({
		id = 999,
		configId = 312011
	})
end

function var_0_0.SetPainting(arg_9_0)
	arg_9_0:ReturnPainting()

	local var_9_0 = arg_9_0:GetFlagShip():getPainting()

	arg_9_0.paintingName = var_9_0

	setPaintingPrefabAsync(arg_9_0.painting, var_9_0, "jiesuan")

	return
end

function var_0_0.UpdateCommanders(arg_10_0)
	arg_10_0.displays = {}

	for iter_10_0, iter_10_1 in pairs((arg_10_0.home:GetCatteries())) do
		table.insert(arg_10_0.displays, iter_10_1)
	end

	table.sort(arg_10_0.displays, function(arg_11_0, arg_11_1)
		return arg_11_0:GetCommanderId() > arg_11_1:GetCommanderId()
	end)
	arg_10_0.uilist:align(#arg_10_0.displays)

	return
end

function var_0_0.UpdateCommander(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.cards[arg_12_1]

	if not arg_12_0.cards[arg_12_1] then
		var_12_0 = CatterySettlementCard.New(arg_12_1)
		arg_12_0.cards[arg_12_1] = var_12_0
	end

	var_12_0:Update(arg_12_2, arg_12_2:GetCacheExp())
	var_12_0:Action(function()
		return
	end)

	return
end

function var_0_0.UpdateDialogue(arg_14_0)
	local var_14_0 = 0
	local var_14_1 = 0

	for iter_14_0, iter_14_1 in pairs((arg_14_0.home:GetCatteries())) do
		var_14_0 = var_14_0 + iter_14_1:GetCacheExp()

		local var_14_2 = iter_14_1:GetCacheExpTime()

		if var_14_1 < var_14_2 then
			var_14_1 = var_14_2
		end
	end

	arg_14_0.timeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_14_1)
	arg_14_0.expTxt.text = var_14_0

	return
end

function var_0_0.ReturnPainting(arg_15_0)
	if arg_15_0.paintingName then
		retPaintingPrefab(arg_15_0.painting, arg_15_0.paintingName)

		arg_15_0.paintingName = nil
	end

	return
end

function var_0_0.OnDestroy(arg_16_0)
	arg_16_0:ReturnPainting()

	for iter_16_0, iter_16_1 in pairs(arg_16_0.cards) do
		iter_16_1:Dispose()
	end

	arg_16_0:Hide()

	arg_16_0.cards = nil

	return
end

return var_0_0
