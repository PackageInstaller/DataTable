local var_0_0 = class("SkinAtlasPreviewPage", import("....base.BaseSubView"))

var_0_0.ON_BG_SWITCH_DONE = "SkinAtlasScene:ON_BG_SWITCH_DONE"
var_0_0.ON_L2D_SWITCH_DONE = "SkinAtlasScene:ON_L2D_SWITCH_DONE"

function var_0_0.getUIName(arg_1_0)
	return "SkinAtlasPreviewPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.paintingTr = arg_2_0._tf:Find("paint")
	arg_2_0.live2dContainer = arg_2_0._tf:Find("paint/live2d")
	arg_2_0.mainImg = arg_2_0._tf:Find("main"):GetComponent(typeof(UnityEngine.UI.Graphic))
	arg_2_0.backBtn = arg_2_0._tf:Find("main/left/back")
	arg_2_0.nameTxt = arg_2_0._tf:Find("main/left/name_bg/skin_name"):GetComponent(typeof(Text))
	arg_2_0.shipnameTxt = arg_2_0._tf:Find("main/left/name_bg/name"):GetComponent(typeof(Text))
	arg_2_0.charParent = arg_2_0._tf:Find("main/right/char")
	arg_2_0.viewBtn = arg_2_0._tf:Find("main/right/view_btn")
	arg_2_0.changeBtn = arg_2_0._tf:Find("main/right/change_btn")
	arg_2_0.changeBtnDis = arg_2_0.changeBtn:Find("dis")
	arg_2_0.changeBtnEn = arg_2_0.changeBtn:Find("en")
	arg_2_0.obtainBtn = arg_2_0._tf:Find("main/right/obtain_btn")
	arg_2_0.bgFlag = true
	arg_2_0.l2dFlag = false

	local var_2_0 = arg_2_0._tf:Find("main/left/tpl")

	arg_2_0.btns = {
		ShipAtlasBgBtn.New(var_2_0, PlayerVitaeBaseBtn.HRZ_TYPE, arg_2_0.event, arg_2_0.bgFlag),
		ShipAtlasLive2dBtn.New(var_2_0, PlayerVitaeBaseBtn.HRZ_TYPE, arg_2_0.event, arg_2_0.l2dFlag)
	}
	arg_2_0.changeSkinUI = arg_2_0._tf:Find("main/bottom/changeSkin")
	arg_2_0.changeSkinToggle = ChangeSkinToggle.New(findTF(arg_2_0.changeSkinUI, "ChangeSkinToggleUI"))
	arg_2_0.bgView = SkinAtlasBgView.New(arg_2_0._tf:Find("bg/bg"))
	arg_2_0.paintingView = SkinAtlasPaintingView.New(arg_2_0._tf:Find("paint"))
	arg_2_0.selectShipPage = ChangeShipSkinPage.New(arg_2_0._parentTf, arg_2_0.event)

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.viewBtn, function()
		arg_3_0.mainImg.enabled = false

		arg_3_0.paintingView:Enter()

		if arg_3_0.live2d then
			arg_3_0.live2d:OpenClick()
		end

		return
	end, SFX_PANEL)

	local var_3_0 = arg_3_0._tf:GetComponent(typeof(PinchZoom))

	onButton(arg_3_0, arg_3_0._tf, function()
		if var_3_0.processing then
			return
		end

		arg_3_0.mainImg.enabled = true

		arg_3_0.paintingView:Exit()

		if arg_3_0.live2d then
			arg_3_0.live2d:CloseClick()
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.changeBtn, function()
		if arg_3_0.skin:CantUse() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("without_ship_to_wear"))

			return
		end

		arg_3_0.selectShipPage:ExecuteAction("Show", arg_3_0.skin)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.obtainBtn, function()
		local var_8_0 = ShipGroup.New({
			id = arg_3_0.skin:getConfig("ship_group")
		})

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_OBTAIN,
			shipId = var_8_0:getShipConfigId(),
			list = var_8_0.groupConfig.description,
			mediatorName = SkinAtlasMediator.__cname
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.changeSkinUI, function()
		if ShipSkin.GetChangeSkinData(arg_3_0.skin.id) then
			arg_3_0:Flush(ShipSkin.New({
				id = ShipSkin.GetChangeSkinNextId(arg_3_0.skin.id)
			}), arg_3_0.index)
		end

		return
	end, SFX_PANEL)
	arg_3_0:bind(var_0_0.ON_BG_SWITCH_DONE, function(arg_10_0, arg_10_1)
		arg_3_0.bgFlag = arg_10_1

		arg_3_0.bgView:Init(arg_3_0.ship, arg_3_0.bgFlag)

		return
	end)
	arg_3_0:bind(var_0_0.ON_L2D_SWITCH_DONE, function(arg_11_0, arg_11_1)
		arg_3_0.l2dFlag = arg_11_1

		arg_3_0:UpdatePainting(arg_3_0.ship)

		return
	end)
	addSlip(SLIP_TYPE_HRZ, arg_3_0._tf:Find("main"), function()
		arg_3_0:OnPrev()

		return
	end, function()
		arg_3_0:OnNext()

		return
	end)

	return
end

function var_0_0.OnNext(arg_14_0)
	if arg_14_0.loading then
		return
	end

	arg_14_0:emit(SkinAtlasScene.ON_NEXT_SKIN, arg_14_0.index)

	return
end

function var_0_0.OnPrev(arg_15_0)
	if arg_15_0.loading then
		return
	end

	arg_15_0:emit(SkinAtlasScene.ON_PREV_SKIN, arg_15_0.index)

	return
end

function var_0_0.Show(arg_16_0, arg_16_1, arg_16_2)
	var_0_0.super.Show(arg_16_0)

	arg_16_0.index = arg_16_2
	arg_16_0.skin = arg_16_1
	arg_16_0.bgFlag = true
	arg_16_0.l2dFlag = false

	local var_16_0 = arg_16_0.skin:ToShip()

	assert(var_16_0)

	arg_16_0.ship = var_16_0

	arg_16_0:UpdateMain(var_16_0)

	local var_16_1 = arg_16_0.skin:CantUse()

	setActive(arg_16_0.changeBtnDis, var_16_1)
	setActive(arg_16_0.changeBtnEn, not var_16_1)
	setActive(arg_16_0.changeSkinUI, ShipSkin.GetChangeSkinData(arg_16_0.skin.id) and true or false)
	arg_16_0.changeSkinToggle:setSkinData(arg_16_0.skin.id)
	setActive(arg_16_0.changeSkinUI, not arg_16_0.changeSkinToggle:IsAsmrSkin())
	setActive(arg_16_0.obtainBtn, not arg_16_0.skin:OwnShip())

	return
end

function var_0_0.Flush(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:Clear()
	arg_17_0:Show(arg_17_1, arg_17_2)

	return
end

function var_0_0.UpdateMain(arg_18_0, arg_18_1)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.btns) do
		local var_18_1 = iter_18_1:IsActive(arg_18_1)

		if var_18_1 then
			var_18_0 = var_18_0 + 1
		end

		iter_18_1:Update(var_18_1, var_18_0, arg_18_1)
	end

	arg_18_0.nameTxt.text = arg_18_0.skin:getConfig("name")
	arg_18_0.shipnameTxt.text = arg_18_1:getName()
	arg_18_0.loading = true

	parallelAsync({
		function(arg_19_0)
			arg_18_0.bgView:Init(arg_18_1, arg_18_0.bgFlag, arg_19_0)

			return
		end,
		function(arg_20_0)
			arg_18_0:UpdatePainting(arg_18_1, arg_20_0)

			return
		end,
		function(arg_21_0)
			arg_18_0:UpdateChar(arg_18_1, arg_21_0)

			return
		end
	}, function()
		arg_18_0.loading = false

		return
	end)

	return
end

function var_0_0.UpdatePainting(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.l2dFlag then
		arg_23_0:InitL2D(arg_23_1, arg_23_2)
	else
		arg_23_0:InitPainting(arg_23_1, arg_23_2)
	end

	return
end

function var_0_0.InitPainting(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0:ClearPainting(arg_24_1)
	setActive(arg_24_0.live2dContainer, false)

	arg_24_0.painting = arg_24_1:getPainting()

	setPaintingPrefabAsync(arg_24_0.paintingTr, arg_24_0.painting, "chuanwu", arg_24_2)

	return
end

function var_0_0.InitL2D(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:ClearPainting(arg_25_1)

	arg_25_0.live2d = SkinAtlasLive2dView.New(arg_25_1, arg_25_0.live2dContainer, arg_25_2)

	arg_25_0.live2d.live2dChar:changeTriggerFlag(false)

	return
end

function var_0_0.UpdateChar(arg_26_0, arg_26_1, arg_26_2)
	PoolMgr.GetInstance():GetSpineChar(arg_26_1:getPrefab(), true, function(arg_27_0)
		arg_26_0.modelTf = tf(arg_27_0)
		arg_26_0.modelTf.localScale = Vector3(0.9, 0.9, 1)
		arg_26_0.modelTf.localPosition = Vector3(0, -135, 0)

		pg.ViewUtils.SetLayer(arg_26_0.modelTf, Layer.UI)
		setParent(arg_26_0.modelTf, arg_26_0.charParent)
		arg_27_0:GetComponent("SpineAnimUI"):SetAction("normal", 0)
		arg_26_2()

		return
	end)

	return
end

function var_0_0.ClearPainting(arg_28_0, arg_28_1)
	if arg_28_0.live2d then
		arg_28_0.live2d:Dispose()

		arg_28_0.live2d = nil
	elseif arg_28_0.painting then
		retPaintingPrefab(arg_28_0.paintingTr, arg_28_0.painting)

		arg_28_0.painting = nil
	end

	return
end

function var_0_0.ClearChar(arg_29_0, arg_29_1)
	if arg_29_0.modelTf then
		PoolMgr.GetInstance():ReturnSpineChar(arg_29_1:getPrefab(), arg_29_0.modelTf.gameObject)

		arg_29_0.modelTf = nil
	end

	return
end

function var_0_0.Clear(arg_30_0)
	if arg_30_0.ship then
		arg_30_0:ClearPainting(arg_30_0.ship)
		arg_30_0:ClearChar(arg_30_0.ship)

		arg_30_0.ship = nil
	end

	return
end

function var_0_0.Hide(arg_31_0)
	var_0_0.super.Hide(arg_31_0)
	arg_31_0:Clear()

	arg_31_0.skin = nil

	arg_31_0.bgView:Clear()

	if arg_31_0.paintingView:IsEnter() then
		arg_31_0.paintingView:Exit()
	end

	return
end

function var_0_0.IsShowSelectShipView(arg_32_0)
	local var_32_0 = arg_32_0.selectShipPage

	if arg_32_0.selectShipPage then
		var_32_0 = arg_32_0.selectShipPage:GetLoaded()
		var_32_0 = var_32_0 and arg_32_0.selectShipPage:isShowing()
	end

	return var_32_0
end

function var_0_0.CloseSelectShipView(arg_33_0)
	arg_33_0.selectShipPage:Hide()

	return
end

function var_0_0.OnDestroy(arg_34_0)
	if arg_34_0:isShowing() then
		arg_34_0:Hide()
	end

	for iter_34_0, iter_34_1 in ipairs(arg_34_0.btns) do
		iter_34_1:Dispose()
	end

	arg_34_0.btns = nil

	arg_34_0.bgView:Dispose()

	arg_34_0.bgView = nil

	arg_34_0.selectShipPage:Destroy()

	arg_34_0.selectShipPage = nil

	arg_34_0.paintingView:Dispose()

	arg_34_0.paintingView = nil

	return
end

return var_0_0
