local PaintingShowScene = class("PaintingShowScene", import("..base.BaseUI"))
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

function PaintingShowScene:getUIName()
	return "PaintingShowUI"
end

function PaintingShowScene:didEnter()
	self._tf.sizeDelta = Vector2(Screen.width, Screen.height)
	self.ad = findTF(self._tf, "ad")
	self.paintTf = findTF(self.ad, "paint")
	self.spineContainer = findTF(self.ad, "paint/spinePainting")
	self.l2dContainner = findTF(self.ad, "paint/live2d")
	self.paintingFitter = findTF(self.ad, "paint/fitter")
	self.effectContainer = findTF(self.ad, "paint/effect")
	self.flushAnimator = GetComponent(findTF(self.ad, "flush"), typeof(Animator))
	self.flushEevent = GetComponent(findTF(self.ad, "flush"), typeof(DftAniEvent))
	self.btnClose = findTF(self.ad, "btnClose")
	self.btnDebug = findTF(self.ad, "btnDebug")
	self.effectTf = findTF(self.ad, "effect")

	warning("init tf parent pos = " .. self._tf.parent.position.x .. "," .. self._tf.parent.position.y)
	warning("init tf pos = " .. self._tf.anchoredPosition.x .. "," .. self._tf.anchoredPosition.y)
	warning("init ad pos = " .. self.ad.anchoredPosition.x .. "," .. self.ad.anchoredPosition.y)
	warning("init painting pos = " .. self.paintTf.anchoredPosition.x .. "," .. self.paintTf.anchoredPosition.y)
	warning("init l2dContainner pos = " .. self.l2dContainner.anchoredPosition.x .. "," .. self.l2dContainner.anchoredPosition.y)
	onButton(self, self.btnClose, function()
		if not self.loading then
			self:closeView()
		end

		return
	end)
	setActive(self.btnDebug, false)
	onButton(self, self.btnDebug, function()
		self:startShowing()

		return
	end)
	self.flushEevent:SetTriggerEvent(function(arg_5_0)
		if self.triggerData then
			if not isActive(self.paintTf) then
				SetActive(self.paintTf, true)
			end

			warning("set tf pos = " .. self._tf.anchoredPosition.x .. "," .. self._tf.anchoredPosition.y)
			warning("set ad pos = " .. self.ad.anchoredPosition.x .. "," .. self.ad.anchoredPosition.y)
			warning("set painting pos = " .. self.paintTf.anchoredPosition.x .. "," .. self.paintTf.anchoredPosition.y)
			warning("set l2dContainner pos = " .. self.l2dContainner.anchoredPosition.x .. "," .. self.l2dContainner.anchoredPosition.y)
			warning("set painting pos = " .. self.triggerData.pos.x .. "," .. self.triggerData.pos.y)
			warning("set painting scale = " .. self.triggerData.scale)

			self.paintTf.anchoredPosition = self.triggerData.pos
			self.paintTf.localScale = Vector3(self.triggerData.scale, self.triggerData.scale, self.triggerData.scale)
		elseif not self.debugFlag then
			self:closeView()
		end

		return
	end)
	self.flushEevent:SetEndEvent(function(arg_6_0)
		if self.triggerData then
			self:movePaint(function()
				self:flushPainting()

				return
			end)
		end

		return
	end)

	self.loading = false

	SetActive(self.paintTf, false)

	self.closeCallBack = self.contextData.callback
	self.skinId = self.contextData.skinId
	self.isShop = self.contextData.is_shop

	pg.UIMgr.GetInstance():BlurPanel(self.ad)

	if self.skinId then
		if pg.ship_skin_template[self.skinId].get_showing then
			self.debugFlag = pg.ship_skin_template[self.skinId].get_showing.debug == 1
		end

		setActive(self.btnDebug, self.debugFlag)
		self:loadShowPaint(pg.ship_skin_template[self.skinId].ship_group * 10 + 1, self.skinId, function()
			self:startShowing()

			return
		end)
	else
		onNextTick(function()
			self:closeView()

			return
		end)
	end

	return
end

function PaintingShowScene:startShowing()
	if not self.l2dFlag then
		local var_10_0

		if pg.ship_skin_template[self.skinId].get_showing.data then
			var_10_0 = pg.ship_skin_template[self.skinId].get_showing.data or var_0_1
		end

		local var_10_1
		local var_10_2

		if self.paintOffset then
			var_10_1 = Vector2(self.paintOffset[1], self.paintOffset[2])
			var_10_2 = self.paintOffset[3]
		else
			var_10_1 = Vector2(0, 0)
			var_10_2 = 1
		end

		self.showDatas = {}

		for iter_10_0 = 1, #var_10_0 do
			local var_10_3 = Vector2(var_10_0[iter_10_0][1] + var_10_1.x, var_10_0[iter_10_0][2] + var_10_1.y)
			local var_10_4
			local var_10_5

			if #var_10_0[iter_10_0] >= 4 then
				var_10_4 = Vector3(var_10_0[iter_10_0][1] + var_10_1.x + var_10_0[iter_10_0][4], var_10_0[iter_10_0][2] + var_10_1.y + var_10_0[iter_10_0][5], 0)
				var_10_5 = var_10_0[iter_10_0][6]
			end

			table.insert(self.showDatas, {
				pos = var_10_3,
				scale = var_10_0[iter_10_0][3] * var_10_2,
				move = var_10_4,
				move_time = var_10_5
			})
		end

		self:flushPainting()
	end

	return
end

function PaintingShowScene:flushPainting()
	if #self.showDatas > 0 then
		self.triggerData = table.remove(self.showDatas, 1)

		self.flushAnimator:SetTrigger("active")
	else
		self.triggerData = nil

		self.flushAnimator:SetTrigger("active")
	end

	return
end

function PaintingShowScene:movePaint(arg_12_1)
	if self.triggerData.move and self.triggerData.move_time then
		LeanTween.moveLocal(go(self.paintTf), self.triggerData.move, self.triggerData.move_time):setOnComplete(System.Action(function()
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

function PaintingShowScene:loadShowPaint(arg_14_1, arg_14_2, arg_14_3)
	self.loading = true
	self.flagShip = Ship.New({
		configId = arg_14_1,
		skin_id = arg_14_2
	})

	local var_14_0 = self.flagShip
	local var_14_1 = MainPaintingView.GetAssistantStatus(self.flagShip)
	local var_14_2 = self.flagShip:GetSkinConfig().tag

	if var_14_1 == MainPaintingView.STATE_SPINE_PAINTING then
		self.spinePainting = SpinePainting.New(SpinePainting.GenerateData({
			ship = var_14_0,
			position = Vector3(0, 0, 0),
			parent = self.spineContainer,
			effectParent = self.effectContainer
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

			arg_15_0:SetShopHx(self.isShop)

			self.loading = false

			arg_14_3()

			return
		end)
	elseif var_14_1 == MainPaintingView.STATE_PAINTING then
		if pg.ship_skin_template[self.skinId].get_showing.paint_offset then
			self.paintOffset = pg.ship_skin_template[self.skinId].get_showing.paint_offset or nil
		end

		if (table.contains(var_14_2, ShipSkin.WITH_LIVE2D) or table.contains(var_14_2, ShipSkin.WITH_SPINE)) and not self.paintOffset then
			self.paintingFitter.localScale = Vector3(1.1, 1.1, 1.1)
		end

		local var_14_3 = var_14_0:getPainting()

		LoadPaintingPrefabAsync(self.paintTf, var_14_3, var_14_3, "mainNormal", function(arg_17_0)
			self.loading = false

			local var_17_0 = findTF(arg_17_0, "shop_hx")

			if not IsNil(var_17_0) and self.isShop then
				setActive(var_17_0, HXSet.isHx())
			end

			arg_14_3()

			return
		end)
	elseif var_14_1 == MainPaintingView.STATE_L2D then
		if not isActive(self.paintTf) then
			SetActive(self.paintTf, true)
		end

		warning("set l2d painting pos = " .. self.paintTf.anchoredPosition.x .. "," .. self.paintTf.anchoredPosition.y)
		warning("set l2d l2dContainner pos = " .. self.l2dContainner.anchoredPosition.x .. "," .. self.l2dContainner.anchoredPosition.y)

		self.live2dChar = Live2DPainting.New(Live2DPainting.GenerateData({
			ship = var_14_0,
			position = Vector3(0, 0, -1),
			parent = self.l2dContainner,
			shopPreView = self.isShop
		}), function(arg_18_0)
			self:updateL2dSortMode(arg_18_0)
			arg_18_0:IgonreReactPos(true)

			self.loading = false

			arg_14_3()

			return
		end)
	else
		if pg.ship_skin_template[self.skinId].get_showing.paint_offset then
			self.paintOffset = pg.ship_skin_template[self.skinId].get_showing.paint_offset or nil
		end

		if (table.contains(var_14_2, ShipSkin.WITH_LIVE2D) or table.contains(var_14_2, ShipSkin.WITH_SPINE)) and not self.paintOffset then
			self.paintingFitter.localScale = Vector3(1.1, 1.1, 1.1)
		end

		local var_14_4 = var_14_0:getPainting()

		LoadPaintingPrefabAsync(self.paintTf, var_14_4, var_14_4, "mainNormal", function()
			self.loading = false

			return
		end)
	end

	return
end

function PaintingShowScene:updateL2dSortMode(arg_20_1)
	arg_20_1._go:GetComponent(typeof(CubismRenderController)).SortingMode = CubismSortingMode.BackToFrontOrder

	return
end

function PaintingShowScene:StaticGetPaintingName()
	if HXSet.isHx() then
		return self
	end

	local var_21_0 = getProxy(SettingsProxy):GetMainPaintingVariantFlag(self) == PaintingShowScene.PAINTING_VARIANT_EX

	if var_21_0 and not checkABExist("painting/" .. self .. "_ex") then
		return self
	end

	return (var_21_0 or nil) and (self .. "_ex" or self)
end

function PaintingShowScene:closeView()
	if self.loading then
		return
	end

	PaintingShowScene.super.closeView(self)

	return
end

function PaintingShowScene:onBackPressed()
	if self.loading then
		return
	end

	PaintingShowScene.super.onBackPressed(self)

	return
end

function PaintingShowScene:GetSkinShowAble()
	return not not (pg.ship_skin_template[self].get_showing.show and pg.ship_skin_template[self].get_showing.show == 1)
end

function PaintingShowScene:willExit()
	self.flushEevent:SetTriggerEvent(nil)
	self.flushEevent:SetEndEvent(nil)

	if LeanTween.isTweening(go(self.paintTf)) then
		LeanTween.cancel(go(self.paintTf))
	end

	self:ClearPainting()

	if self.closeCallBack then
		self.closeCallBack()

		self.closeCallBack = nil
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self.ad, self._tf)

	return
end

function PaintingShowScene:ClearPainting()
	if self.live2dChar then
		self.live2dChar:Dispose()

		self.live2dChar = nil
	end

	if self.spinePainting then
		self.spinePainting:Dispose()

		self.spinePainting = nil
	end

	return
end

return PaintingShowScene
