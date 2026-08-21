local var_0_0 = class("PaintingShowScene", import("..base.BaseUI"))
local var_0_1 = {
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

function var_0_0.getUIName(arg_1_0)
	return "PaintingShowUI"
end

function var_0_0.didEnter(arg_2_0)
	arg_2_0._tf.sizeDelta = Vector2(Screen.width, Screen.height)
	arg_2_0.ad = findTF(arg_2_0._tf, "ad")
	arg_2_0.paintTf = findTF(arg_2_0.ad, "paint")
	arg_2_0.spineContainer = findTF(arg_2_0.ad, "paint/spinePainting")
	arg_2_0.l2dContainner = findTF(arg_2_0.ad, "paint/live2d")
	arg_2_0.paintingFitter = findTF(arg_2_0.ad, "paint/fitter")
	arg_2_0.effectContainer = findTF(arg_2_0.ad, "paint/effect")
	arg_2_0.flushAnimator = GetComponent(findTF(arg_2_0.ad, "flush"), typeof(Animator))
	arg_2_0.flushEevent = GetComponent(findTF(arg_2_0.ad, "flush"), typeof(DftAniEvent))
	arg_2_0.btnClose = findTF(arg_2_0.ad, "btnClose")
	arg_2_0.btnDebug = findTF(arg_2_0.ad, "btnDebug")
	arg_2_0.effectTf = findTF(arg_2_0.ad, "effect")

	warning("init tf parent pos = " .. arg_2_0._tf.parent.position.x .. "," .. arg_2_0._tf.parent.position.y)
	warning("init tf pos = " .. arg_2_0._tf.anchoredPosition.x .. "," .. arg_2_0._tf.anchoredPosition.y)
	warning("init ad pos = " .. arg_2_0.ad.anchoredPosition.x .. "," .. arg_2_0.ad.anchoredPosition.y)
	warning("init painting pos = " .. arg_2_0.paintTf.anchoredPosition.x .. "," .. arg_2_0.paintTf.anchoredPosition.y)
	warning("init l2dContainner pos = " .. arg_2_0.l2dContainner.anchoredPosition.x .. "," .. arg_2_0.l2dContainner.anchoredPosition.y)
	onButton(arg_2_0, arg_2_0.btnClose, function()
		if not arg_2_0.loading then
			arg_2_0:closeView()
		end

		return
	end)
	setActive(arg_2_0.btnDebug, false)
	onButton(arg_2_0, arg_2_0.btnDebug, function()
		arg_2_0:startShowing()

		return
	end)
	arg_2_0.flushEevent:SetTriggerEvent(function(arg_5_0)
		if arg_2_0.triggerData then
			if not isActive(arg_2_0.paintTf) then
				SetActive(arg_2_0.paintTf, true)
			end

			warning("set tf pos = " .. arg_2_0._tf.anchoredPosition.x .. "," .. arg_2_0._tf.anchoredPosition.y)
			warning("set ad pos = " .. arg_2_0.ad.anchoredPosition.x .. "," .. arg_2_0.ad.anchoredPosition.y)
			warning("set painting pos = " .. arg_2_0.paintTf.anchoredPosition.x .. "," .. arg_2_0.paintTf.anchoredPosition.y)
			warning("set l2dContainner pos = " .. arg_2_0.l2dContainner.anchoredPosition.x .. "," .. arg_2_0.l2dContainner.anchoredPosition.y)
			warning("set painting pos = " .. arg_2_0.triggerData.pos.x .. "," .. arg_2_0.triggerData.pos.y)
			warning("set painting scale = " .. arg_2_0.triggerData.scale)

			arg_2_0.paintTf.anchoredPosition = arg_2_0.triggerData.pos
			arg_2_0.paintTf.localScale = Vector3(arg_2_0.triggerData.scale, arg_2_0.triggerData.scale, arg_2_0.triggerData.scale)
		elseif not arg_2_0.debugFlag then
			arg_2_0:closeView()
		end

		return
	end)
	arg_2_0.flushEevent:SetEndEvent(function(arg_6_0)
		if arg_2_0.triggerData then
			arg_2_0:movePaint(function()
				arg_2_0:flushPainting()

				return
			end)
		end

		return
	end)

	arg_2_0.loading = false

	SetActive(arg_2_0.paintTf, false)

	arg_2_0.closeCallBack = arg_2_0.contextData.callback
	arg_2_0.skinId = arg_2_0.contextData.skinId
	arg_2_0.isShop = arg_2_0.contextData.is_shop

	pg.UIMgr.GetInstance():BlurPanel(arg_2_0.ad)

	if arg_2_0.skinId then
		local var_2_0 = pg.ship_skin_template[arg_2_0.skinId]

		if pg.ship_skin_template[arg_2_0.skinId].get_showing then
			arg_2_0.debugFlag = var_2_0.get_showing.debug == 1
		end

		setActive(arg_2_0.btnDebug, arg_2_0.debugFlag)
		arg_2_0:loadShowPaint(pg.ship_skin_template[arg_2_0.skinId].ship_group * 10 + 1, arg_2_0.skinId, function()
			arg_2_0:startShowing()

			return
		end)
	else
		onNextTick(function()
			arg_2_0:closeView()

			return
		end)
	end

	return
end

function var_0_0.startShowing(arg_10_0)
	if not arg_10_0.l2dFlag then
		if pg.ship_skin_template[arg_10_0.skinId].get_showing.data then
			local var_10_0 = pg.ship_skin_template[arg_10_0.skinId].get_showing.data or var_0_1
			local var_10_1
			local var_10_2

			if arg_10_0.paintOffset then
				var_10_1 = Vector2(arg_10_0.paintOffset[1], arg_10_0.paintOffset[2])
				var_10_2 = arg_10_0.paintOffset[3]
			else
				var_10_1 = Vector2(0, 0)
				var_10_2 = 1
			end

			arg_10_0.showDatas = {}

			for iter_10_0 = 1, #var_10_0 do
				local var_10_3 = Vector2(var_10_0[iter_10_0][1] + var_10_1.x, var_10_0[iter_10_0][2] + var_10_1.y)
				local var_10_4
				local var_10_5

				if #var_10_0[iter_10_0] >= 4 then
					var_10_4 = Vector3(var_10_0[iter_10_0][1] + var_10_1.x + var_10_0[iter_10_0][4], var_10_0[iter_10_0][2] + var_10_1.y + var_10_0[iter_10_0][5], 0)
					var_10_5 = var_10_0[iter_10_0][6]
				end

				table.insert(arg_10_0.showDatas, {
					pos = var_10_3,
					scale = var_10_0[iter_10_0][3] * var_10_2,
					move = var_10_4,
					move_time = var_10_5
				})
			end

			arg_10_0:flushPainting()

			return
		end
	end
end

function var_0_0.flushPainting(arg_11_0)
	if #arg_11_0.showDatas > 0 then
		arg_11_0.triggerData = table.remove(arg_11_0.showDatas, 1)

		arg_11_0.flushAnimator:SetTrigger("active")
	else
		arg_11_0.triggerData = nil

		arg_11_0.flushAnimator:SetTrigger("active")
	end

	return
end

function var_0_0.movePaint(arg_12_0, arg_12_1)
	if arg_12_0.triggerData.move and arg_12_0.triggerData.move_time then
		LeanTween.moveLocal(go(arg_12_0.paintTf), arg_12_0.triggerData.move, arg_12_0.triggerData.move_time):setOnComplete(System.Action(function()
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

function var_0_0.loadShowPaint(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0.loading = true
	arg_14_0.flagShip = Ship.New({
		configId = arg_14_1,
		skin_id = arg_14_2
	})

	local var_14_0 = arg_14_0.flagShip
	local var_14_1 = MainPaintingView.GetAssistantStatus(arg_14_0.flagShip)
	local var_14_2 = arg_14_0.flagShip:GetSkinConfig().tag

	if var_14_1 == MainPaintingView.STATE_SPINE_PAINTING then
		arg_14_0.spinePainting = SpinePainting.New(SpinePainting.GenerateData({
			ship = var_14_0,
			position = Vector3(0, 0, 0),
			parent = arg_14_0.spineContainer,
			effectParent = arg_14_0.effectContainer
		}), function(arg_15_0)
			for iter_15_0, iter_15_1 in ipairs((arg_15_0:GetSpineTransform():GetComponent(typeof(ItemList)).prefabItem:ToTable())) do
				local var_15_0 = GetComponent(iter_15_1, typeof(Canvas))

				if var_15_0 then
					RemoveComponent(var_15_0, typeof(Canvas))
				end
			end

			if arg_15_0:getAnimationExist("get") then
				arg_15_0:SetOnceAction("get", nil, function()
					arg_15_0:SetAction(arg_15_0:getIdleName(), 0)

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

	::label_14_0::

	if var_14_1 == MainPaintingView.STATE_PAINTING then
		if pg.ship_skin_template[arg_14_0.skinId].get_showing.paint_offset then
			arg_14_0.paintOffset = pg.ship_skin_template[arg_14_0.skinId].get_showing.paint_offset or nil

			if (table.contains(var_14_2, ShipSkin.WITH_LIVE2D) or table.contains(var_14_2, ShipSkin.WITH_SPINE)) and not arg_14_0.paintOffset then
				arg_14_0.paintingFitter.localScale = Vector3(1.1, 1.1, 1.1)
			end

			local var_14_3 = var_14_0:getPainting()

			LoadPaintingPrefabAsync(arg_14_0.paintTf, var_14_3, var_14_3, "mainNormal", function(arg_17_0)
				arg_14_0.loading = false

				local var_17_0 = findTF(arg_17_0, "shop_hx")

				if not IsNil(var_17_0) and arg_14_0.isShop then
					setActive(var_17_0, HXSet.isHx())
				end

				arg_14_3()

				return
			end)

			goto label_14_0

			if var_14_1 == MainPaintingView.STATE_L2D then
				if not isActive(arg_14_0.paintTf) then
					SetActive(arg_14_0.paintTf, true)
				end

				warning("set l2d painting pos = " .. arg_14_0.paintTf.anchoredPosition.x .. "," .. arg_14_0.paintTf.anchoredPosition.y)
				warning("set l2d l2dContainner pos = " .. arg_14_0.l2dContainner.anchoredPosition.x .. "," .. arg_14_0.l2dContainner.anchoredPosition.y)

				arg_14_0.live2dChar = Live2DPainting.New(Live2DPainting.GenerateData({
					ship = var_14_0,
					position = Vector3(0, 0, -1),
					parent = arg_14_0.l2dContainner,
					shopPreView = arg_14_0.isShop
				}), function(arg_18_0)
					arg_14_0:updateL2dSortMode(arg_18_0)
					arg_18_0:IgonreReactPos(true)

					arg_14_0.loading = false

					arg_14_3()

					return
				end)

				goto label_14_0
			end

			if pg.ship_skin_template[arg_14_0.skinId].get_showing.paint_offset then
				arg_14_0.paintOffset = pg.ship_skin_template[arg_14_0.skinId].get_showing.paint_offset or nil

				if (table.contains(var_14_2, ShipSkin.WITH_LIVE2D) or table.contains(var_14_2, ShipSkin.WITH_SPINE)) and not arg_14_0.paintOffset then
					arg_14_0.paintingFitter.localScale = Vector3(1.1, 1.1, 1.1)
				end

				do
					local var_14_4 = var_14_0:getPainting()

					LoadPaintingPrefabAsync(arg_14_0.paintTf, var_14_4, var_14_4, "mainNormal", function()
						arg_14_0.loading = false

						return
					end)
				end

				return
			end
		end
	end
end

function var_0_0.updateL2dSortMode(arg_20_0, arg_20_1)
	arg_20_1._go:GetComponent(typeof(CubismRenderController)).SortingMode = CubismSortingMode.BackToFrontOrder

	return
end

function var_0_0.StaticGetPaintingName(arg_21_0)
	if HXSet.isHx() then
		return arg_21_0
	end

	local var_21_0 = getProxy(SettingsProxy)
	local var_21_1 = var_21_0:GetMainPaintingVariantFlag(arg_21_0) == var_0_0.PAINTING_VARIANT_EX

	if var_21_1 and not checkABExist("painting/" .. arg_21_0 .. "_ex") then
		return arg_21_0
	end

	if var_21_1 then
		return arg_21_0 .. "_ex" or arg_21_0
	end
end

function var_0_0.closeView(arg_22_0)
	if arg_22_0.loading then
		return
	end

	var_0_0.super.closeView(arg_22_0)

	return
end

function var_0_0.onBackPressed(arg_23_0)
	if arg_23_0.loading then
		return
	end

	var_0_0.super.onBackPressed(arg_23_0)

	return
end

function var_0_0.GetSkinShowAble(arg_24_0)
	local var_24_0 = false

	if pg.ship_skin_template[arg_24_0].get_showing.show and pg.ship_skin_template[arg_24_0].get_showing.show == 1 then
		var_24_0 = true
	end

	return var_24_0
end

function var_0_0.willExit(arg_25_0)
	arg_25_0.flushEevent:SetTriggerEvent(nil)
	arg_25_0.flushEevent:SetEndEvent(nil)

	if LeanTween.isTweening(go(arg_25_0.paintTf)) then
		LeanTween.cancel(go(arg_25_0.paintTf))
	end

	arg_25_0:ClearPainting()

	if arg_25_0.closeCallBack then
		arg_25_0.closeCallBack()

		arg_25_0.closeCallBack = nil
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_25_0.ad, arg_25_0._tf)

	return
end

function var_0_0.ClearPainting(arg_26_0)
	if arg_26_0.live2dChar then
		arg_26_0.live2dChar:Dispose()

		arg_26_0.live2dChar = nil
	end

	if arg_26_0.spinePainting then
		arg_26_0.spinePainting:Dispose()

		arg_26_0.spinePainting = nil
	end

	return
end

return var_0_0
