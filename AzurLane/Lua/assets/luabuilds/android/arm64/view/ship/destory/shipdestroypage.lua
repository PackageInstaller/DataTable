local var_0_0 = class("ShipDestroyPage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "DestoryInfoUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.cardScrollRect = arg_2_0._tf:Find("frame/sliders/content"):GetComponent("LScrollRect")

	function arg_2_0.cardScrollRect.onInitItem(arg_3_0)
		return
	end

	function arg_2_0.cardScrollRect.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = DockyardShipItem.New(arg_4_1, ShipStatus.TAG_HIDE_DESTROY)

		var_4_0:update(arg_2_0.shipVOs[arg_2_0.shipIds[arg_4_0 + 1]])
		onButton(arg_2_0, var_4_0.tr, function()
			existCall(arg_2_0.OnCardClick, var_4_0)
			arg_2_0:DisplayShipList()

			return
		end, SFX_PANEL)

		return
	end

	function arg_2_0.cardScrollRect.onReturnItem(arg_6_0, arg_6_1)
		removeOnButton(arg_6_1)

		return
	end

	arg_2_0.cancelBtn = arg_2_0._tf:Find("frame/cancel_button")
	arg_2_0.backBtn = arg_2_0._tf:Find("frame/top/btnBack")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/confirm_button")

	setText(arg_2_0._tf:Find("frame/bg_award/label"), i18n("disassemble_available") .. ":")

	local var_2_0 = arg_2_0._tf:Find("frame/bg_award/res_list")

	arg_2_0.resList = UIItemList.New(var_2_0, var_2_0:Find("res"))

	arg_2_0.resList:make(function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1

		if arg_7_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync(arg_2_0.showList[arg_7_1]:getIcon(), "", arg_7_2:Find("icon"))
			setText(arg_7_2:Find("Text"), "X" .. arg_2_0.showList[arg_7_1].count)
		end

		return
	end)

	return
end

function var_0_0.OnInit(arg_8_0)
	onButton(arg_8_0, arg_8_0.cancelBtn, function()
		arg_8_0:Hide()

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.backBtn, function()
		arg_8_0:Hide()

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.confirmBtn, function()
		if arg_8_0.OnConfirm then
			arg_8_0.OnConfirm()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetConfirmCallBack(arg_12_0, arg_12_1)
	arg_12_0.OnConfirm = arg_12_1

	return
end

function var_0_0.SetCardClickCallBack(arg_13_0, arg_13_1)
	arg_13_0.OnCardClick = arg_13_1

	return
end

function var_0_0.Refresh(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.shipIds = arg_14_1
	arg_14_0.shipVOs = arg_14_2

	arg_14_0:DisplayShipList()
	arg_14_0:RefreshRes()
	arg_14_0:Show()

	return
end

function var_0_0.DisplayShipList(arg_15_0)
	arg_15_0.cardScrollRect:SetTotalCount(#arg_15_0.shipIds)

	if #arg_15_0.shipIds == 0 then
		arg_15_0:Hide()
	end

	return
end

function var_0_0.CalcShipsReturnRes(arg_16_0, arg_16_1)
	return ShipCalcHelper.CalcDestoryRes((_.map(arg_16_0, function(arg_17_0)
		return arg_16_1[arg_17_0]
	end)))
end

function var_0_0.RefreshRes(arg_18_0)
	local var_18_0, var_18_1, var_18_2 = var_0_0.CalcShipsReturnRes(arg_18_0.shipIds, arg_18_0.shipVOs)

	table.insert(var_18_2, 1, Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = PlayerConst.ResOil,
		count = var_18_1
	}))
	table.insert(var_18_2, 1, Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = PlayerConst.ResGold,
		count = var_18_0
	}))

	arg_18_0.showList = underscore.filter(var_18_2, function(arg_19_0)
		return arg_19_0.count > 0
	end)

	arg_18_0.resList:align(#arg_18_0.showList)

	return
end

function var_0_0.Show(arg_20_0)
	var_0_0.super.Show(arg_20_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_20_0._tf)

	return
end

function var_0_0.Hide(arg_21_0)
	var_0_0.super.Hide(arg_21_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_21_0._tf, arg_21_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_22_0)
	arg_22_0.OnCardClick = nil

	ClearLScrollrect(arg_22_0.cardScrollRect)
	arg_22_0:Hide()

	return
end

return var_0_0
