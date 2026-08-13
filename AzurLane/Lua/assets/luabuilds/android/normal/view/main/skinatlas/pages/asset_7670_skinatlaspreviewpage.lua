class = var_0_10000

local var_0_0 = "SkinAtlasPreviewPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

var_0_1.ON_BG_SWITCH_DONE = "SkinAtlasScene:ON_BG_SWITCH_DONE"
var_0_1.ON_L2D_SWITCH_DONE = "SkinAtlasScene:ON_L2D_SWITCH_DONE"

function var_0_1.getUIName(arg_1_0)
	return "SkinAtlasPreviewPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.paintingTr = var_1.Find(var_2_0, "paint")

	local var_2_1 = arg_2_0._tf

	arg_2_0.live2dContainer = var_1.Find(var_2_1, "paint/live2d")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "main")
	local var_2_4 = var_1.GetComponent

	typeof = var_3
	UnityEngine = var_1_10004
	arg_2_0.mainImg = var_2_4(var_2_3, var_3(var_1_10004.UI.Graphic))

	local var_2_5 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_5, "main/left/back")

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "main/left/name_bg/skin_name")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.nameTxt = var_2_8(var_2_7, var_3(var_4))

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "main/left/name_bg/name")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.shipnameTxt = var_2_11(var_2_10, var_3(var_4))

	local var_2_12 = arg_2_0._tf

	arg_2_0.charParent = var_1.Find(var_2_12, "main/right/char")

	local var_2_13 = arg_2_0._tf

	arg_2_0.viewBtn = var_1.Find(var_2_13, "main/right/view_btn")

	local var_2_14 = arg_2_0._tf

	arg_2_0.changeBtn = var_1.Find(var_2_14, "main/right/change_btn")

	local var_2_15 = arg_2_0.changeBtn

	arg_2_0.changeBtnDis = var_1.Find(var_2_15, "dis")

	local var_2_16 = arg_2_0.changeBtn

	arg_2_0.changeBtnEn = var_1.Find(var_2_16, "en")

	local var_2_17 = arg_2_0._tf

	arg_2_0.obtainBtn = var_1.Find(var_2_17, "main/right/obtain_btn")
	arg_2_0.bgFlag = true
	arg_2_0.l2dFlag = false

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_1.Find(var_2_18, "main/left/tpl")
	local var_2_20 = {}

	ShipAtlasBgBtn = var_3

	local var_2_21 = var_3.New
	local var_2_22 = var_2_19

	PlayerVitaeBaseBtn = var_1_10005
	var_2_20[1] = var_2_21(var_2_22, var_1_10005.HRZ_TYPE, arg_2_0.event, arg_2_0.bgFlag)
	ShipAtlasLive2dBtn = var_3

	local var_2_23 = var_3.New
	local var_2_24 = var_2_19

	PlayerVitaeBaseBtn = var_5
	var_2_20[2] = var_2_23(var_2_24, var_5.HRZ_TYPE, arg_2_0.event, arg_2_0.l2dFlag)
	arg_2_0.btns = var_2_20

	local var_2_25 = arg_2_0._tf

	arg_2_0.changeSkinUI = var_2.Find(var_2_25, "main/bottom/changeSkin")
	ChangeSkinToggle = var_2

	local var_2_26 = var_2.New

	findTF = var_2_25
	arg_2_0.changeSkinToggle = var_2_26(var_2_25(arg_2_0.changeSkinUI, "ChangeSkinToggleUI"))
	SkinAtlasBgView = var_2

	local var_2_27 = var_2.New
	local var_2_28 = arg_2_0._tf

	arg_2_0.bgView = var_2_27(var_3.Find(var_2_28, "bg/bg"))
	SkinAtlasPaintingView = var_2

	local var_2_29 = var_2.New
	local var_2_30 = arg_2_0._tf

	arg_2_0.paintingView = var_2_29(var_3.Find(var_2_30, "paint"))
	ChangeShipSkinPage = var_2
	arg_2_0.selectShipPage = var_2.New(arg_2_0._parentTf, arg_2_0.event)

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.viewBtn

	local function var_3_5()
		arg_3_0.mainImg.enabled = false

		local var_5_0 = arg_3_0.paintingView

		var_0.Enter(var_5_0)

		if arg_3_0.live2d then
			local var_5_1 = arg_3_0.live2d

			var_0.OpenClick(var_5_1)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	local var_3_6 = arg_3_0._tf
	local var_3_7 = var_1.GetComponent

	typeof = var_3_4
	PinchZoom = var_3_5

	local var_3_8 = var_3_7(var_3_6, var_3_4(var_3_5))

	onButton = var_3_6

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0._tf

	local function var_3_11()
		if var_3_8.processing then
			return
		end

		arg_3_0.mainImg.enabled = true

		local var_6_0 = arg_3_0.paintingView

		var_0.Exit(var_6_0)

		if arg_3_0.live2d then
			local var_6_1 = arg_3_0.live2d

			var_0.CloseClick(var_6_1)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_3_6(var_3_9, var_3_10, var_3_11, var_1_10006)

	onButton = var_3_6

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.changeBtn

	local function var_3_14()
		local var_7_0 = arg_3_0.skin

		if var_0.CantUse(var_7_0) then
			pg = var_0

			local var_7_1 = var_0.TipsMgr.GetInstance()
			local var_7_2 = var_0.ShowTips

			i18n = var_2_10002

			var_7_2(var_7_1, var_2_10002("without_ship_to_wear"))

			return
		end

		local var_7_3 = arg_3_0.selectShipPage

		var_0.ExecuteAction(var_7_3, "Show", arg_3_0.skin)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_6(var_3_12, var_3_13, var_3_14, var_1_10006)

	onButton = var_3_6

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.obtainBtn

	local function var_3_17()
		local var_8_0 = arg_3_0.skin
		local var_8_1 = var_0.getConfig(var_8_0, "ship_group")

		ShipGroup = var_8_0

		local var_8_2 = var_8_0.New({
			id = var_8_1
		})
		local var_8_3 = {}

		MSGBOX_TYPE_OBTAIN = var_2_10003
		var_8_3.type = var_2_10003
		var_8_3.shipId = var_8_2:getShipConfigId()
		var_8_3.list = var_8_2.groupConfig.description
		SkinAtlasMediator = var_3
		var_8_3.mediatorName = var_3.__cname
		pg = var_3

		local var_8_4 = var_3.MsgboxMgr.GetInstance()

		var_3.ShowMsgBox(var_8_4, var_8_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_6(var_3_15, var_3_16, var_3_17, var_1_10006)

	onButton = var_3_6

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.changeSkinUI

	local function var_3_20()
		ShipSkin = var_2_10000

		if var_2_10000.GetChangeSkinData(arg_3_0.skin.id) then
			ShipSkin = var_0

			local var_9_0 = var_0.New
			local var_9_1 = {}

			ShipSkin = var_2_10002
			var_9_1.id = var_2_10002.GetChangeSkinNextId(arg_3_0.skin.id)

			local var_9_2 = var_9_0(var_9_1)
			local var_9_3 = arg_3_0

			var_1.Flush(var_9_3, var_9_2, arg_3_0.index)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_3_6(var_3_18, var_3_19, var_3_20, var_1_10006)
	arg_3_0:bind(var_0_1.ON_BG_SWITCH_DONE, function(arg_10_0, arg_10_1)
		arg_3_0.bgFlag = arg_10_1

		local var_10_0 = arg_3_0.bgView

		var_2.Init(var_10_0, arg_3_0.ship, arg_3_0.bgFlag)

		return
	end)

	local var_3_21 = arg_3_0

	arg_3_0.bind(var_3_21, var_0_1.ON_L2D_SWITCH_DONE, function(arg_11_0, arg_11_1)
		arg_3_0.l2dFlag = arg_11_1

		local var_11_0 = arg_3_0

		var_2.UpdatePainting(var_11_0, arg_3_0.ship)

		return
	end)

	addSlip = var_2
	SLIP_TYPE_HRZ = var_3_21

	local var_3_22 = arg_3_0._tf

	var_2(var_3_21, var_4.Find(var_3_22, "main"), function()
		local var_12_0 = arg_3_0

		var_0.OnPrev(var_12_0)

		return
	end, function()
		local var_13_0 = arg_3_0

		var_0.OnNext(var_13_0)

		return
	end)

	return
end

function var_0_1.OnNext(arg_14_0)
	if arg_14_0.loading then
		return
	end

	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.emit

	SkinAtlasScene = var_1_10003

	var_14_1(var_14_0, var_1_10003.ON_NEXT_SKIN, arg_14_0.index)

	return
end

function var_0_1.OnPrev(arg_15_0)
	if arg_15_0.loading then
		return
	end

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.emit

	SkinAtlasScene = var_1_10003

	var_15_1(var_15_0, var_1_10003.ON_PREV_SKIN, arg_15_0.index)

	return
end

function var_0_1.Show(arg_16_0, arg_16_1, arg_16_2)
	var_0_1.super.Show(arg_16_0)

	arg_16_0.index = arg_16_2
	arg_16_0.skin = arg_16_1
	arg_16_0.bgFlag = true
	arg_16_0.l2dFlag = false

	local var_16_0 = arg_16_0.skin
	local var_16_1 = var_3.ToShip(var_16_0)

	assert = var_16_0

	var_16_0(var_16_1)

	arg_16_0.ship = var_16_1

	arg_16_0:UpdateMain(var_16_1)

	local var_16_2 = arg_16_0.skin
	local var_16_3 = var_4.CantUse(var_16_2)

	setActive = var_16_2

	var_16_2(arg_16_0.changeBtnDis, var_16_3)

	setActive = var_16_2

	var_16_2(arg_16_0.changeBtnEn, not var_16_3)

	ShipSkin = var_16_2

	local var_16_4 = var_16_2.GetChangeSkinData(arg_16_0.skin.id)

	setActive = var_6

	var_6(arg_16_0.changeSkinUI, var_16_4 and true or false)

	local var_16_5 = arg_16_0.changeSkinToggle

	var_6.setSkinData(var_16_5, arg_16_0.skin.id)

	setActive = var_6

	local var_16_6 = arg_16_0.changeSkinUI
	local var_16_7 = arg_16_0.changeSkinToggle

	var_6(var_16_6, not var_8.IsAsmrSkin(var_16_7))

	setActive = var_6

	local var_16_8 = arg_16_0.obtainBtn
	local var_16_9 = arg_16_0.skin

	var_6(var_16_8, not var_8.OwnShip(var_16_9))

	return
end

function var_0_1.Flush(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:Clear()
	arg_17_0:Show(arg_17_1, arg_17_2)

	return
end

function var_0_1.UpdateMain(arg_18_0, arg_18_1)
	local var_18_0 = 0

	ipairs = var_1_10003

	for iter_18_0, iter_18_1 in var_1_10003(arg_18_0.btns) do
		if iter_18_1:IsActive(arg_18_1) then
			var_18_0 = var_18_0 + 1
		end

		iter_18_1:Update(var_8, var_18_0, arg_18_1)
	end

	local var_18_1 = arg_18_0.nameTxt
	local var_18_2 = arg_18_0.skin

	var_18_1.text = var_4.getConfig(var_18_2, "name")
	arg_18_0.shipnameTxt.text = arg_18_1:getName()
	arg_18_0.loading = true
	parallelAsync = var_3

	var_3({
		function(arg_19_0)
			local var_19_0 = arg_18_0.bgView

			var_1.Init(var_19_0, arg_18_1, arg_18_0.bgFlag, arg_19_0)

			return
		end,
		function(arg_20_0)
			local var_20_0 = arg_18_0

			var_1.UpdatePainting(var_20_0, arg_18_1, arg_20_0)

			return
		end,
		function(arg_21_0)
			local var_21_0 = arg_18_0

			var_1.UpdateChar(var_21_0, arg_18_1, arg_21_0)

			return
		end
	}, function()
		arg_18_0.loading = false

		return
	end)

	return
end

function var_0_1.UpdatePainting(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.l2dFlag then
		arg_23_0:InitL2D(arg_23_1, arg_23_2)
	else
		arg_23_0:InitPainting(arg_23_1, arg_23_2)
	end

	return
end

function var_0_1.InitPainting(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0:ClearPainting(arg_24_1)

	setActive = var_3

	var_3(arg_24_0.live2dContainer, false)

	arg_24_0.painting = arg_24_1:getPainting()
	setPaintingPrefabAsync = var_3

	var_3(arg_24_0.paintingTr, arg_24_0.painting, "chuanwu", arg_24_2)

	return
end

function var_0_1.InitL2D(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:ClearPainting(arg_25_1)

	SkinAtlasLive2dView = var_3
	arg_25_0.live2d = var_3.New(arg_25_1, arg_25_0.live2dContainer, arg_25_2)

	local var_25_0 = arg_25_0.live2d.live2dChar

	var_3.changeTriggerFlag(var_25_0, false)

	return
end

function var_0_1.UpdateChar(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_1
	local var_26_1 = arg_26_1.getPrefab(var_26_0)

	PoolMgr = var_26_0

	local var_26_2 = var_26_0.GetInstance()

	var_4.GetSpineChar(var_26_2, var_26_1, true, function(arg_27_0)
		local var_27_0 = arg_26_0

		tf = var_2_10002
		var_27_0.modelTf = var_2_10002(arg_27_0)

		local var_27_1 = arg_26_0.modelTf

		Vector3 = var_2
		var_27_1.localScale = var_2(0.9, 0.9, 1)

		local var_27_2 = arg_26_0.modelTf

		Vector3 = var_2
		var_27_2.localPosition = var_2(0, -135, 0)
		pg = var_27_2

		local var_27_3 = var_27_2.ViewUtils.SetLayer
		local var_27_4 = arg_26_0.modelTf

		Layer = var_3

		var_27_3(var_27_4, var_3.UI)

		setParent = var_27_3

		var_27_3(arg_26_0.modelTf, arg_26_0.charParent)

		local var_27_5 = arg_27_0:GetComponent("SpineAnimUI")

		var_1.SetAction(var_27_5, "normal", 0)
		arg_26_2()

		return
	end)

	return
end

function var_0_1.ClearPainting(arg_28_0, arg_28_1)
	if arg_28_0.live2d then
		local var_28_0 = arg_28_0.live2d

		var_2.Dispose(var_28_0)

		arg_28_0.live2d = nil
	elseif arg_28_0.painting then
		retPaintingPrefab = var_2

		var_2(arg_28_0.paintingTr, arg_28_0.painting)

		arg_28_0.painting = nil
	end

	return
end

function var_0_1.ClearChar(arg_29_0, arg_29_1)
	if arg_29_0.modelTf then
		PoolMgr = var_2

		local var_29_0 = var_2.GetInstance()

		var_2.ReturnSpineChar(var_29_0, arg_29_1:getPrefab(), arg_29_0.modelTf.gameObject)

		arg_29_0.modelTf = nil
	end

	return
end

function var_0_1.Clear(arg_30_0)
	if arg_30_0.ship then
		arg_30_0:ClearPainting(var_1)
		arg_30_0:ClearChar(var_1)

		arg_30_0.ship = nil
	end

	return
end

function var_0_1.Hide(arg_31_0)
	var_0_1.super.Hide(arg_31_0)
	arg_31_0:Clear()

	arg_31_0.skin = nil

	local var_31_0 = arg_31_0.bgView

	var_1.Clear(var_31_0)

	local var_31_1 = arg_31_0.paintingView

	if var_1.IsEnter(var_31_1) then
		local var_31_2 = arg_31_0.paintingView

		var_1.Exit(var_31_2)
	end

	return
end

function var_0_1.IsShowSelectShipView(arg_32_0)
	local var_32_2

	if arg_32_0.selectShipPage then
		local var_32_0 = arg_32_0.selectShipPage

		if var_1.GetLoaded(var_32_0) then
			local var_32_1 = arg_32_0.selectShipPage

			var_32_2 = var_1.isShowing(var_32_1)
		end
	end

	return var_32_2
end

function var_0_1.CloseSelectShipView(arg_33_0)
	local var_33_0 = arg_33_0.selectShipPage

	var_1.Hide(var_33_0)

	return
end

function var_0_1.OnDestroy(arg_34_0)
	if arg_34_0:isShowing() then
		arg_34_0:Hide()
	end

	ipairs = var_1

	for iter_34_0, iter_34_1 in var_1(arg_34_0.btns) do
		iter_34_1:Dispose()
	end

	arg_34_0.btns = nil

	local var_34_0 = arg_34_0.bgView

	var_1.Dispose(var_34_0)

	arg_34_0.bgView = nil

	local var_34_1 = arg_34_0.selectShipPage

	var_1.Destroy(var_34_1)

	arg_34_0.selectShipPage = nil

	local var_34_2 = arg_34_0.paintingView

	var_1.Dispose(var_34_2)

	arg_34_0.paintingView = nil

	return
end

return var_0_1
