class = var_0_10000

local var_0_0 = "PaintingShowScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))
local var_0_2 = {
	{
		-176,
		-466,
		2,
		100,
		100,
		2
	},
	{
		526,
		-107,
		2,
		100,
		100,
		2
	},
	{
		-934,
		-115,
		2,
		100,
		100,
		2
	},
	{
		-32,
		643,
		2,
		100,
		100,
		2
	}
}
local var_0_3 = {}

ShipSkin = var_3
var_0_3[1] = var_3.WITH_LIVE2D
ShipSkin = var_3
var_0_3[2] = var_3.WITH_SPINE

function var_0_1.getUIName(arg_1_0)
	return "PaintingShowUI"
end

function var_0_1.didEnter(arg_2_0)
	local var_2_0 = arg_2_0._tf

	Vector2 = var_1_10002
	Screen = var_1_10004

	local var_2_1 = var_1_10004.width

	Screen = var_1_10005
	var_2_0.sizeDelta = var_1_10002(var_2_1, var_1_10005.height)
	findTF = var_2_0
	arg_2_0.ad = var_2_0(arg_2_0._tf, "ad")
	findTF = var_1
	arg_2_0.paintTf = var_1(arg_2_0.ad, "paint")
	findTF = var_1
	arg_2_0.spineContainer = var_1(arg_2_0.ad, "paint/spinePainting")
	findTF = var_1
	arg_2_0.l2dContainner = var_1(arg_2_0.ad, "paint/live2d")
	findTF = var_1
	arg_2_0.paintingFitter = var_1(arg_2_0.ad, "paint/fitter")
	findTF = var_1
	arg_2_0.effectContainer = var_1(arg_2_0.ad, "paint/effect")
	GetComponent = var_1
	findTF = var_3

	local var_2_2 = var_3(arg_2_0.ad, "flush")

	typeof = var_4
	Animator = var_6
	arg_2_0.flushAnimator = var_1(var_2_2, var_4(var_6))
	GetComponent = var_1
	findTF = var_2_2

	local var_2_3 = var_2_2(arg_2_0.ad, "flush")

	typeof = var_4
	DftAniEvent = var_6
	arg_2_0.flushEevent = var_1(var_2_3, var_4(var_6))
	findTF = var_1
	arg_2_0.btnClose = var_1(arg_2_0.ad, "btnClose")
	findTF = var_1
	arg_2_0.btnDebug = var_1(arg_2_0.ad, "btnDebug")
	findTF = var_1
	arg_2_0.effectTf = var_1(arg_2_0.ad, "effect")
	warning = var_1

	var_1("init tf parent pos = " .. arg_2_0._tf.parent.position.x .. "," .. arg_2_0._tf.parent.position.y)

	warning = var_1

	var_1("init tf pos = " .. arg_2_0._tf.anchoredPosition.x .. "," .. arg_2_0._tf.anchoredPosition.y)

	warning = var_1

	var_1("init ad pos = " .. arg_2_0.ad.anchoredPosition.x .. "," .. arg_2_0.ad.anchoredPosition.y)

	warning = var_1

	var_1("init painting pos = " .. arg_2_0.paintTf.anchoredPosition.x .. "," .. arg_2_0.paintTf.anchoredPosition.y)

	warning = var_1

	var_1("init l2dContainner pos = " .. arg_2_0.l2dContainner.anchoredPosition.x .. "," .. arg_2_0.l2dContainner.anchoredPosition.y)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.btnClose, function()
		if not arg_2_0.loading then
			local var_3_0 = arg_2_0

			var_0.closeView(var_3_0)
		end

		return
	end)

	setActive = var_1

	var_1(arg_2_0.btnDebug, false)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.btnDebug, function()
		local var_4_0 = arg_2_0

		var_0.startShowing(var_4_0)

		return
	end)

	local var_2_4 = arg_2_0.flushEevent

	var_1.SetTriggerEvent(var_2_4, function(arg_5_0)
		if arg_2_0.triggerData then
			isActive = var_1

			if not var_1(arg_2_0.paintTf) then
				SetActive = var_1

				var_1(arg_2_0.paintTf, true)
			end

			warning = var_1

			var_1("set tf pos = " .. arg_2_0._tf.anchoredPosition.x .. "," .. arg_2_0._tf.anchoredPosition.y)

			warning = var_1

			var_1("set ad pos = " .. arg_2_0.ad.anchoredPosition.x .. "," .. arg_2_0.ad.anchoredPosition.y)

			warning = var_1

			var_1("set painting pos = " .. arg_2_0.paintTf.anchoredPosition.x .. "," .. arg_2_0.paintTf.anchoredPosition.y)

			warning = var_1

			var_1("set l2dContainner pos = " .. arg_2_0.l2dContainner.anchoredPosition.x .. "," .. arg_2_0.l2dContainner.anchoredPosition.y)

			warning = var_1

			var_1("set painting pos = " .. arg_2_0.triggerData.pos.x .. "," .. arg_2_0.triggerData.pos.y)

			warning = var_1

			var_1("set painting scale = " .. arg_2_0.triggerData.scale)

			arg_2_0.paintTf.anchoredPosition = arg_2_0.triggerData.pos

			local var_5_0 = arg_2_0.paintTf

			Vector3 = var_2
			var_5_0.localScale = var_2(arg_2_0.triggerData.scale, arg_2_0.triggerData.scale, arg_2_0.triggerData.scale)
		elseif not arg_2_0.debugFlag then
			local var_5_1 = arg_2_0

			var_1.closeView(var_5_1)
		end

		return
	end)

	local var_2_5 = arg_2_0.flushEevent

	var_1.SetEndEvent(var_2_5, function(arg_6_0)
		if arg_2_0.triggerData then
			local var_6_0 = arg_2_0

			var_1.movePaint(var_6_0, function()
				local var_7_0 = arg_2_0

				var_0.flushPainting(var_7_0)

				return
			end)
		end

		return
	end)

	arg_2_0.loading = false
	SetActive = var_1

	var_1(arg_2_0.paintTf, false)

	arg_2_0.closeCallBack = arg_2_0.contextData.callback
	arg_2_0.skinId = arg_2_0.contextData.skinId
	arg_2_0.isShop = arg_2_0.contextData.is_shop
	pg = var_1

	local var_2_6 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_6, arg_2_0.ad)

	if arg_2_0.skinId then
		pg = var_1

		local var_2_7 = var_1.ship_skin_template[arg_2_0.skinId].ship_group * 10 + 1
		local var_2_8

		if var_1.get_showing then
			var_2_8 = var_1.get_showing.debug == 1 and true or false
			arg_2_0.debugFlag = var_2_8
		end

		setActive = var_2_8

		var_2_8(arg_2_0.btnDebug, arg_2_0.debugFlag)
		arg_2_0:loadShowPaint(var_2_7, arg_2_0.skinId, function()
			local var_8_0 = arg_2_0

			var_0.startShowing(var_8_0)

			return
		end)
	else
		onNextTick = var_1

		var_1(function()
			local var_9_0 = arg_2_0

			var_0.closeView(var_9_0)

			return
		end)
	end

	return
end

function var_0_1.startShowing(arg_10_0)
	if not arg_10_0.l2dFlag then
		pg = var_1

		local var_10_0

		if not var_1.ship_skin_template[arg_10_0.skinId].get_showing.data or not var_1.get_showing.data then
			var_10_0 = var_0_2
		end

		local var_10_1
		local var_10_2

		if arg_10_0.paintOffset then
			Vector2 = var_5
			var_10_1 = var_5(arg_10_0.paintOffset[1], arg_10_0.paintOffset[2])
			var_10_2 = arg_10_0.paintOffset[3]
		else
			Vector2 = var_5
			var_10_1 = var_5(0, 0)
			var_10_2 = 1
		end

		arg_10_0.showDatas = {}

		for iter_10_0 = 1, #var_10_0 do
			local var_10_3 = var_10_0[iter_10_0]

			Vector2 = var_1_10010
			var_1_10010 = var_1_10010(var_10_3[1] + var_10_1.x, var_10_3[2] + var_10_1.y)

			local var_10_4 = var_10_3[3] * var_10_2
			local var_10_5
			local var_10_6

			if #var_10_3 >= 4 then
				Vector3 = var_14
				var_10_5 = var_14(var_10_3[1] + var_10_1.x + var_10_3[4], var_10_3[2] + var_10_1.y + var_10_3[5], 0)
				var_10_6 = var_10_3[6]
			end

			table = var_14

			var_14.insert(arg_10_0.showDatas, {
				pos = var_1_10010,
				scale = var_10_4,
				move = var_10_5,
				move_time = var_10_6
			})
		end

		arg_10_0:flushPainting()
	end

	return
end

function var_0_1.flushPainting(arg_11_0)
	if #arg_11_0.showDatas > 0 then
		table = var_1
		arg_11_0.triggerData = var_1.remove(arg_11_0.showDatas, 1)

		local var_11_0 = arg_11_0.flushAnimator

		var_1.SetTrigger(var_11_0, "active")
	else
		arg_11_0.triggerData = nil

		local var_11_1 = arg_11_0.flushAnimator

		var_1.SetTrigger(var_11_1, "active")
	end

	return
end

function var_0_1.movePaint(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.triggerData.move
	local var_12_1 = arg_12_0.triggerData.move_time

	if var_12_0 and var_12_1 then
		LeanTween = var_1_10004

		local var_12_2 = var_1_10004.moveLocal

		go = var_1_10006

		local var_12_3 = var_12_2(var_1_10006(arg_12_0.paintTf), var_12_0, var_12_1)
		local var_12_4 = var_4.setOnComplete

		System = var_7

		var_12_4(var_12_3, var_7.Action(function()
			if arg_12_1 then
				arg_12_1()
			end

			return
		end))
	elseif arg_12_1 then
		arg_12_1()
	end

	return
end

function var_0_1.loadShowPaint(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0.loading = true
	Ship = var_4
	arg_14_0.flagShip = var_4.New({
		configId = arg_14_1,
		skin_id = arg_14_2
	})

	local var_14_0 = arg_14_0.flagShip

	MainPaintingView = var_1_10005

	local var_14_1 = var_1_10005.GetAssistantStatus(var_14_0)
	local var_14_2 = var_14_0:GetSkinConfig().tag

	pg = var_7

	local var_14_3 = var_7.ship_skin_template[arg_14_0.skinId]

	MainPaintingView = var_8

	local var_14_4

	if var_14_1 == var_8.STATE_SPINE_PAINTING then
		SpinePainting = var_14_4
		var_14_4 = var_14_4.GenerateData

		local var_14_5 = {
			ship = var_14_0
		}

		Vector3 = var_1_10011
		var_14_5.position = var_1_10011(0, 0, 0)
		var_14_5.parent = arg_14_0.spineContainer
		var_14_5.effectParent = arg_14_0.effectContainer
		var_14_4 = var_14_4(var_14_5)
		SpinePainting = var_1_10009
		arg_14_0.spinePainting = var_1_10009.New(var_14_4, function(arg_15_0)
			local var_15_0 = arg_15_0:GetSpineTransform()
			local var_15_1 = var_1.GetComponent

			typeof = var_2_10004
			ItemList = var_2_10006

			local var_15_2 = var_15_1(var_15_0, var_2_10004(var_2_10006)).prefabItem
			local var_15_3 = var_1.ToTable(var_15_2)

			ipairs = var_2_10002

			for iter_15_0, iter_15_1 in var_2_10002(var_15_3) do
				GetComponent = var_2_10007

				local var_15_4 = iter_15_1

				typeof = var_2_10010
				Canvas = var_2_10012

				if var_2_10007(var_15_4, var_2_10010(var_2_10012)) then
					RemoveComponent = var_2_10008
					var_2_10010 = var_2_10007
					typeof = var_2_10011
					Canvas = var_2_10013

					var_2_10008(var_2_10010, var_2_10011(var_2_10013))
				end
			end

			if arg_15_0:getAnimationExist("get") then
				arg_15_0:SetOnceAction("get", nil, function()
					local var_16_0 = arg_15_0
					local var_16_1 = var_0.SetAction
					local var_16_2 = arg_15_0

					var_16_1(var_16_0, var_3.getIdleName(var_16_2), 0)

					return
				end, true)
			end

			arg_15_0:SetShopHx(arg_14_0.isShop)

			arg_14_0.loading = false

			arg_14_3()

			return
		end)

		goto label_14_0
	end

	MainPaintingView = var_14_4

	if var_14_1 == var_14_4.STATE_PAINTING then
		local var_14_6

		if not var_14_3.get_showing.paint_offset or not var_14_3.get_showing.paint_offset then
			var_14_6 = nil
		end

		arg_14_0.paintOffset = var_14_6
		table = var_14_6
		var_14_6 = var_14_6.contains

		local var_14_7 = var_14_2

		ShipSkin = var_1_10011

		if not var_14_6(var_14_7, var_1_10011.WITH_LIVE2D) then
			table = var_14_6
			var_14_6 = var_14_6.contains

			local var_14_8 = var_14_2

			ShipSkin = var_1_10011

			if var_14_6(var_14_8, var_1_10011.WITH_SPINE) then
				if not arg_14_0.paintOffset then
					var_14_6 = arg_14_0.paintingFitter
					Vector3 = var_1_10009
					var_14_6.localScale = var_1_10009(1.1, 1.1, 1.1)
				end
			end

			var_14_6 = var_14_0:getPainting()
			LoadPaintingPrefabAsync = var_1_10009

			var_1_10009(arg_14_0.paintTf, var_14_6, var_14_6, "mainNormal", function(arg_17_0)
				local var_17_0 = arg_14_0

				var_17_0.loading = false
				findTF = var_17_0

				local var_17_1 = var_17_0(arg_17_0, "shop_hx")

				IsNil = var_2

				if not var_2(var_17_1) and arg_14_0.isShop then
					setActive = var_2

					local var_17_2 = var_17_1

					HXSet = var_2_10005

					var_2(var_17_2, var_2_10005.isHx())
				end

				arg_14_3()

				return
			end)

			goto label_14_0

			MainPaintingView = var_14_6

			if var_14_1 == var_14_6.STATE_L2D then
				isActive = var_8

				if not var_8(arg_14_0.paintTf) then
					SetActive = var_8

					var_8(arg_14_0.paintTf, true)
				end

				warning = var_8

				var_8("set l2d painting pos = " .. arg_14_0.paintTf.anchoredPosition.x .. "," .. arg_14_0.paintTf.anchoredPosition.y)

				warning = var_8

				var_8("set l2d l2dContainner pos = " .. arg_14_0.l2dContainner.anchoredPosition.x .. "," .. arg_14_0.l2dContainner.anchoredPosition.y)

				Live2DPainting = var_8

				local var_14_9 = var_8.GenerateData
				local var_14_10 = {
					ship = var_14_0
				}

				Vector3 = var_1_10011
				var_14_10.position = var_1_10011(0, 0, -1)
				var_14_10.parent = arg_14_0.l2dContainner
				var_14_10.shopPreView = arg_14_0.isShop

				local var_14_11 = var_14_9(var_14_10)

				Live2DPainting = var_1_10009
				arg_14_0.live2dChar = var_1_10009.New(var_14_11, function(arg_18_0)
					local var_18_0 = arg_14_0

					var_1.updateL2dSortMode(var_18_0, arg_18_0)
					arg_18_0:IgonreReactPos(true)

					arg_14_0.loading = false

					arg_14_3()

					return
				end)

				goto label_14_0
			end

			local var_14_12

			if not var_14_3.get_showing.paint_offset or not var_14_3.get_showing.paint_offset then
				var_14_12 = nil
			end

			arg_14_0.paintOffset = var_14_12
			table = var_14_12

			local var_14_13 = var_14_12.contains
			local var_14_14 = var_14_2

			ShipSkin = var_1_10011

			if not var_14_13(var_14_14, var_1_10011.WITH_LIVE2D) then
				table = var_8

				do
					local var_14_15 = var_8.contains
					local var_14_16 = var_14_2

					ShipSkin = var_11

					if var_14_15(var_14_16, var_11.WITH_SPINE) then
						if not arg_14_0.paintOffset then
							local var_14_17 = arg_14_0.paintingFitter

							Vector3 = var_1_10009
							var_14_17.localScale = var_1_10009(1.1, 1.1, 1.1)
						end
					end

					local var_14_18 = var_14_0:getPainting()

					LoadPaintingPrefabAsync = var_1_10009

					var_1_10009(arg_14_0.paintTf, var_14_18, var_14_18, "mainNormal", function()
						arg_14_0.loading = false

						return
					end)
				end

				::label_14_0::

				return
			end
		end
	end
end

function var_0_1.updateL2dSortMode(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1._go
	local var_20_1 = var_2.GetComponent

	typeof = var_1_10005
	CubismRenderController = var_1_10007

	local var_20_2 = var_20_1(var_20_0, var_1_10005(var_1_10007))

	CubismSortingMode = var_1_10003
	var_20_2.SortingMode = var_1_10003.BackToFrontOrder

	return
end

function var_0_1.StaticGetPaintingName(arg_21_0)
	local var_21_0 = arg_21_0

	HXSet = var_1_10002

	if var_1_10002.isHx() then
		return var_21_0
	end

	getProxy = var_2
	SettingsProxy = var_1_10004

	local var_21_1 = var_2(var_1_10004)

	if var_2.GetMainPaintingVariantFlag(var_21_1, arg_21_0) == var_0_1.PAINTING_VARIANT_EX then
		checkABExist = var_21_1

		if not var_21_1("painting/" .. var_21_0 .. "_ex") then
			return var_21_0
		end
	end

	local var_21_2

	if not var_3 or not (var_21_0 .. "_ex") then
		var_21_2 = var_21_0
	end

	return var_21_2
end

function var_0_1.closeView(arg_22_0)
	if arg_22_0.loading then
		return
	end

	var_0_1.super.closeView(arg_22_0)

	return
end

function var_0_1.onBackPressed(arg_23_0)
	if arg_23_0.loading then
		return
	end

	var_0_1.super.onBackPressed(arg_23_0)

	return
end

function var_0_1.GetSkinShowAble(arg_24_0)
	pg = var_1_10001

	local var_24_0 = var_1_10001.ship_skin_template[arg_24_0]
	local var_24_1 = false

	if var_24_0.get_showing.show and var_24_0.get_showing.show == 1 then
		var_24_1 = true
	end

	return var_24_1
end

function var_0_1.willExit(arg_25_0)
	local var_25_0 = arg_25_0.flushEevent

	var_1.SetTriggerEvent(var_25_0, nil)

	local var_25_1 = arg_25_0.flushEevent

	var_1.SetEndEvent(var_25_1, nil)

	LeanTween = var_1

	local var_25_2 = var_1.isTweening

	go = var_25_1

	if var_25_2(var_25_1(arg_25_0.paintTf)) then
		LeanTween = var_1

		local var_25_3 = var_1.cancel

		go = var_3

		var_25_3(var_3(arg_25_0.paintTf))
	end

	if arg_25_0.live2dChar then
		local var_25_4 = arg_25_0.live2dChar

		var_1.Dispose(var_25_4)

		arg_25_0.live2dChar = nil
	end

	if arg_25_0.spinePainting then
		local var_25_5 = arg_25_0.spinePainting

		var_1.Dispose(var_25_5)

		arg_25_0.spinePainting = nil
	end

	if arg_25_0.closeCallBack then
		arg_25_0.closeCallBack()

		arg_25_0.closeCallBack = nil
	end

	pg = var_1

	local var_25_6 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_25_6, arg_25_0.ad, arg_25_0._tf)

	return
end

return var_0_1
