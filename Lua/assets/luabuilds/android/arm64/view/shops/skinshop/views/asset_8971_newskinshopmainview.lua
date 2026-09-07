local NewSkinShopMainView = class("NewSkinShopMainView", import("view.base.BaseEventLogic"))

NewSkinShopMainView.EVT_SHOW_OR_HIDE_PURCHASE_VIEW = "NewSkinShopMainView:EVT_SHOW_OR_HIDE_PURCHASE_VIEW"
NewSkinShopMainView.EVT_ON_PURCHASE = "NewSkinShopMainView:EVT_ON_PURCHASE"

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = 3
local var_0_7 = 4
local var_0_8 = 5
local var_0_9 = 6
local var_0_10 = 7
local var_0_11 = 8

local function var_0_12(arg_1_0)
	NewSkinShopMainView.obtainBtnSpriteNames = NewSkinShopMainView.obtainBtnSpriteNames or {
		[var_0_4] = "yigoumai_butten",
		[var_0_5] = "goumai_butten",
		[var_0_6] = "qianwanghuoqu_butten",
		[var_0_7] = "item_buy",
		[var_0_8] = "furniture_shop",
		[var_0_9] = "tiyan_btn",
		[var_0_10] = "item_buy",
		[var_0_11] = "buy_with_gift"
	}

	return NewSkinShopMainView.obtainBtnSpriteNames[arg_1_0]
end

function NewSkinShopMainView:Ctor(arg_2_1, arg_2_2, arg_2_3)
	pg.DelegateInfo.New(self)
	NewSkinShopMainView.super.Ctor(self, arg_2_2)

	self.contextData = arg_2_3
	self._go = arg_2_1.gameObject
	self._tf = arg_2_1
	self.overlay = self._tf:Find("overlay")
	self.titleTr = self._tf:Find("overlay/title")
	self.skinNameTxt = self._tf:Find("overlay/title/skin_name"):GetComponent(typeof(Text))
	self.shipNameTxt = self._tf:Find("overlay/title/name"):GetComponent(typeof(Text))
	self.timeLimitTr = self._tf:Find("overlay/title/limit_time")
	self.timeLimitTxt = self.timeLimitTr:Find("Text"):GetComponent(typeof(Text))
	self.changeSkinUI = self._tf:Find("overlay/left/change_skin")
	self.changeSkinToggle = ChangeSkinToggle.New(findTF(self.changeSkinUI, "toggle_ui"))
	self.rightTr = self._tf:Find("overlay/right")
	self.uiTagList = UIItemList.New(self._tf:Find("overlay/right/container/tags_container/tags"), self._tf:Find("overlay/right/container/tags_container/tags/tpl"))
	self.charContainer = self._tf:Find("overlay/right/container/char_container")
	self.charTf = self._tf:Find("overlay/right/container/char_container/char")
	self.furnitureContainer = self._tf:Find("overlay/right/fur")
	self.charBg = self._tf:Find("overlay/right/container/char_container/bg/char")
	self.furnitureBg = self._tf:Find("overlay/right/container/char_container/bg/furn")
	self.switchPreviewBtn = self._tf:Find("overlay/right/switch")
	self.obtainBtn = self._tf:Find("overlay/right/price/btn")
	self.obtainBtnImg = self.obtainBtn:GetComponent(typeof(Image))
	self.giftTag = self.obtainBtn:Find("tag")
	self.giftItem = self.obtainBtn:Find("item")
	self.giftText = self._tf:Find("overlay/right/price/btn/Text"):GetComponent(typeof(Text))
	self.consumeTr = self._tf:Find("overlay/right/price/consume")
	self.consumeRealPriceTxt = self.consumeTr:Find("Text"):GetComponent(typeof(Text))
	self.consumePriceTxt = self.consumeTr:Find("originalprice/Text"):GetComponent(typeof(Text))
	self.experienceTr = self._tf:Find("overlay/right/price/timelimt")
	self.experienceTxt = self.experienceTr:Find("consume/Text"):GetComponent(typeof(Text))

	setText(self.consumeTr:Find("originalprice/label"), i18n("skin_original_price"))

	self.dynamicToggle = self._tf:Find("overlay/right/toggles/l2d_preview")
	self.showBgToggle = self._tf:Find("overlay/right/toggles/hideObjToggle")
	self.dynamicResToggle = self._tf:Find("overlay/right/toggles/l2d_res_state")
	self.dynamicResDownaload = self._tf:Find("overlay/right/toggles/l2d_res_state/downloaded")
	self.dynamicResUnDownaload = self._tf:Find("overlay/right/toggles/l2d_res_state/undownload")
	self.paintingTF = self._tf:Find("painting/paint")
	self.defaultPaintingPosition = self.paintingTF.anchoredPosition
	self.defaultPaintingScale = self.paintingTF.localScale
	self.live2dContainer = self._tf:Find("painting/paint/live2d")
	self.spTF = self._tf:Find("painting/paint/spinePainting")
	self.spBg = self._tf:Find("painting/paintBg/spinePainting")
	self.bgsGo = self._tf:Find("bgs").gameObject
	self.diffBg = self._tf:Find("bgs/diffBg/bg")
	self.defaultBg = self._tf:Find("bgs/default")
	self.downloads = {}
	self.obtainBtnSprites = {}
	self.isToggleDynamic = false
	self.isToggleShowBg = true
	self.isPreviewFurniture = false
	self.interactionPreview = BackYardInteractionPreview.New(self.furnitureContainer, Vector3(0, 0, 0))
	self.voucherMsgBox = SkinVoucherMsgBox.New(pg.UIMgr.GetInstance().OverlayMain)
	self.purchaseView = NewSkinShopPurchaseView.New(self._tf, arg_2_2)

	self:RegisterEvent()

	return
end

function NewSkinShopMainView:RegisterEvent()
	self:bind(NewSkinShopMainView.EVT_SHOW_OR_HIDE_PURCHASE_VIEW, function(arg_4_0, arg_4_1)
		self:AdjustPainting(arg_4_1)
		setActive(self.overlay, not arg_4_1)

		if self.live2dChar then
			self.live2dChar:setPurchaseOffset(arg_4_1)
		end

		if self.spineChar then
			if arg_4_1 then
				if pg.ship_skin_template[self.skinId].purchase_offset and #pg.ship_skin_template[self.skinId].purchase_offset >= 3 then
					self.spineChar:SetLocalPosition(Vector3(pg.ship_skin_template[self.skinId].purchase_offset[1], pg.ship_skin_template[self.skinId].purchase_offset[2], pg.ship_skin_template[self.skinId].purchase_offset[3]))
				end

				if pg.ship_skin_template[self.skinId].purchase_offset and #pg.ship_skin_template[self.skinId].purchase_offset >= 4 then
					self.spineChar:SetLocalScale(Vector3(pg.ship_skin_template[self.skinId].purchase_offset[4], pg.ship_skin_template[self.skinId].purchase_offset[4], pg.ship_skin_template[self.skinId].purchase_offset[4]))
				end
			else
				self.spineChar:SetLocalPosition(Vector3(0, 0, 0))
				self.spineChar:SetLocalScale(Vector3(0.9, 0.9, 1))
			end
		end

		return
	end)
	self:bind(NewSkinShopMainView.EVT_ON_PURCHASE, function(arg_5_0, arg_5_1)
		self:OnClickBtn(self:GetObtainBtnState(arg_5_1), arg_5_1)

		return
	end)
	onButton(self, self.changeSkinUI, function()
		if ShipSkin.IsChangeSkin(self.skinId) then
			self.changeSkinId = ShipSkin.GetChangeSkinNextId(self.skinId)

			self:Flush(self.commodity)
		end

		return
	end, SFX_PANEL)

	return
end

function NewSkinShopMainView:Flush(arg_7_1)
	if not arg_7_1 then
		self:FlushStyle(true)

		return
	end

	self:FlushStyle(false)

	local var_7_0 = self.commodity and self.commodity.id == arg_7_1.id

	self.skinId = arg_7_1:getSkinId()

	self:FlushChangeSkin(arg_7_1)

	if not var_7_0 then
		self:FlushName(arg_7_1)
		self:FlushPreviewBtn(arg_7_1)
		self:FlushTimeline(arg_7_1)
		self:FlushTag(arg_7_1)
		self:SwitchPreview(arg_7_1, self.isPreviewFurniture, false)
		self:FlushPaintingToggle(arg_7_1)
		self:FlushBG(arg_7_1)
		self:FlushPainting(arg_7_1)
	elseif ShipSkin.IsChangeSkin(self.skinId) then
		self:FlushBG(arg_7_1)
		self:FlushPainting(arg_7_1)
		self:FlushTag(arg_7_1)
		self:SwitchPreview(arg_7_1, self.isPreviewFurniture, false)
	else
		self:FlushBG(arg_7_1)
		self:FlushPainting(arg_7_1)
	end

	self:FlushPrice(arg_7_1)
	self:FlushObtainBtn(arg_7_1)

	self.commodity = arg_7_1

	return
end

function NewSkinShopMainView:FlushChangeSkin(arg_8_1)
	local var_8_0 = ShipSkin.IsChangeSkin(self.skinId)

	setActive(self.changeSkinUI, var_8_0 and true or false)

	if var_8_0 then
		if not self.changeSkinId then
			self.changeSkinId = self.skinId
		elseif ShipSkin.GetChangeSkinGroupId(self.changeSkinId) == ShipSkin.GetChangeSkinGroupId(self.skinId) then
			self.skinId = self.changeSkinId
		else
			self.changeSkinId = self.skinId
		end

		self.changeSkinToggle:setSkinData(self.skinId)
		setActive(self.changeSkinUI, not self.changeSkinToggle:IsAsmrSkin())
	end

	return
end

function NewSkinShopMainView:FlushStyle(arg_9_1)
	setActive(self.paintingTF.parent, not arg_9_1)
	setActive(self.defaultBg, arg_9_1)
	setActive(self.diffBg.parent, not arg_9_1)
	setActive(self.titleTr, not arg_9_1)
	setActive(self.rightTr, not arg_9_1)

	return
end

function NewSkinShopMainView:getUIName()
	return "NewSkinShopMainView"
end

function NewSkinShopMainView:FlushBgWithAnim(arg_11_1)
	local var_11_0 = self._tf:GetComponent(typeof(CanvasGroup))

	var_11_0.blocksRaycasts = false

	parallelAsync({
		function(arg_12_0)
			self:DoSwitchBgAnim(1, 0.3, 0.8, LeanTweenType.linear, arg_12_0)

			return
		end,
		function(arg_13_0)
			self:FlushBG(arg_11_1, arg_13_0)

			return
		end
	}, function()
		self:DoSwitchBgAnim(1, 1, 0.01, LeanTweenType.linear, function()
			var_11_0.blocksRaycasts = true

			return
		end)

		return
	end)

	return
end

function NewSkinShopMainView:DoSwitchBgAnim(arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	self:ClearSwitchBgAnim()

	local var_16_0 = GetOrAddComponent(self.bgsGo, typeof(CanvasGroup))

	var_16_0.alpha = arg_16_1

	LeanTween.value(self.bgsGo, arg_16_1, arg_16_2, arg_16_3):setOnUpdate(System.Action_float(function(arg_17_0)
		var_16_0.alpha = arg_17_0

		return
	end)):setEase(arg_16_4):setOnComplete(System.Action(arg_16_5))

	return
end

function NewSkinShopMainView:ClearSwitchBgAnim()
	if LeanTween.isTweening(self.bgsGo) then
		LeanTween.cancel(self.bgsGo)
	end

	GetOrAddComponent(self.bgsGo, typeof(CanvasGroup)).alpha = 1

	return
end

function NewSkinShopMainView:FlushBG(arg_19_1, arg_19_2)
	local var_19_0 = pg.ship_skin_template[self.skinId]
	local var_19_1

	if pg.ship_skin_template[self.skinId].skin_type == ShipSkin.SKIN_TYPE_TB then
		var_19_1 = VirtualEducateCharShip.New(NewEducateHelper.GetSecIdBySkinId(self.skinId))
	else
		local var_19_2 = {
			id = 999
		}

		var_19_2.configId = ShipGroup.getDefaultShipConfig(var_19_0.ship_group).id
		var_19_2.skin_id = self.skinId
		var_19_1 = Ship.New(var_19_2)
	end

	local var_19_3 = var_19_1:getShipBgPrint(true)

	if (self.isToggleShowBg or not checkABExist("painting/" .. pg.ship_skin_template[self.skinId].painting .. "_n")) and var_19_0.bg_sp ~= "" then
		var_19_3 = var_19_0.bg_sp
	end

	local var_19_4 = var_19_3 ~= var_19_1:rarity2bgPrintForGet()

	if var_19_4 then
		pg.DynamicBgMgr.GetInstance():LoadBg(self, var_19_3, self.diffBg.parent, self.diffBg, function(arg_20_0)
			if arg_19_2 then
				arg_19_2()
			end

			return
		end, function(arg_21_0)
			if arg_19_2 then
				arg_19_2()
			end

			return
		end)
	else
		pg.DynamicBgMgr.GetInstance():ClearBg(self:getUIName())

		if arg_19_2 then
			arg_19_2()
		end
	end

	setActive(self.diffBg, var_19_4)
	setActive(self.defaultBg, not var_19_4)

	return
end

function NewSkinShopMainView:FlushName(arg_22_1)
	self.skinNameTxt.text = SwitchSpecialChar(pg.ship_skin_template[self.skinId].name, true)
	self.shipNameTxt.text = pg.ship_skin_template[self.skinId].skin_type == ShipSkin.SKIN_TYPE_TB and NewEducateHelper.GetShipNameBySecId(NewEducateHelper.GetSecIdBySkinId(self.skinId)) or ShipGroup.getDefaultShipConfig(pg.ship_skin_template[self.skinId].ship_group).name

	return
end

function NewSkinShopMainView:FlushPaintingToggle(arg_23_1)
	removeOnToggle(self.dynamicToggle)
	removeOnToggle(self.showBgToggle)

	local var_23_0 = ShipSkin.New({
		id = self.skinId
	})
	local var_23_1 = checkABExist("painting/" .. var_23_0:getConfig("painting") .. "_n")

	if self.isToggleShowBg and not var_23_1 then
		triggerToggle(self.showBgToggle, false)

		self.isToggleShowBg = false
	elseif var_23_1 then
		triggerToggle(self.showBgToggle, true)

		self.isToggleShowBg = true
	end

	local var_23_2 = var_23_0:IsSpine() or var_23_0:IsLive2d()

	if var_23_2 then
		if PlayerPrefs.GetInt("skinShop#l2dPreViewToggle" .. getProxy(PlayerProxy):getRawData().id, 0) == 1 then
			self.isToggleDynamic = true
		end
	end

	if self.isToggleDynamic and not var_23_2 then
		triggerToggle(self.dynamicToggle, false)

		self.isToggleDynamic = false
	elseif self.isToggleDynamic and not self.dynamicToggle:GetComponent(typeof(Toggle)).isOn then
		if var_23_0:IsLive2d() and Live2dConst.GetLive2DArm32MatchAble() then
			self.isToggleDynamic = false

			PlayerPrefs.SetInt("skinShop#l2dPreViewToggle" .. getProxy(PlayerProxy):getRawData().id, 0)
			PlayerPrefs.Save()
			triggerToggle(self.dynamicToggle, false)
		else
			triggerToggle(self.dynamicToggle, true)

			self.isToggleDynamic = true
		end
	end

	if var_23_1 then
		onToggle(self, self.showBgToggle, function(arg_24_0)
			self.isToggleShowBg = arg_24_0

			self:FlushPainting(arg_23_1)
			self:FlushBG(arg_23_1)

			return
		end, SFX_PANEL)
	end

	if var_23_0:IsSpine() or var_23_0:IsLive2d() then
		onToggle(self, self.dynamicToggle, function(arg_25_0)
			if arg_25_0 and Live2dConst.GetLive2DArm32MatchAble() and var_23_0:IsLive2d() then
				Live2dConst.ShowLive2DArm32Tips()
				triggerToggle(self.dynamicToggle, false)

				return
			end

			self.isToggleDynamic = arg_25_0

			setActive(self.dynamicResToggle, arg_25_0)
			setActive(self.showBgToggle, not arg_25_0 and var_23_1)
			self:FlushPainting(arg_23_1)
			self:FlushDynamicPaintingResState(arg_23_1)
			self:RecordFlag(arg_25_0)

			return
		end, SFX_PANEL)
	end

	if self.isToggleDynamic then
		self:FlushDynamicPaintingResState(arg_23_1)
	end

	setActive(self.dynamicToggle, var_23_2)
	setActive(self.dynamicResToggle, self.isToggleDynamic)
	setActive(self.showBgToggle, not self.isToggleDynamic and var_23_1)

	return
end

function NewSkinShopMainView:RecordFlag(arg_26_1)
	PlayerPrefs.SetInt("skinShop#l2dPreViewToggle" .. getProxy(PlayerProxy):getRawData().id, arg_26_1 and 1 or 0)
	PlayerPrefs.Save()
	self:emit(NewSkinShopMediator.ON_RECORD_ANIM_PREVIEW_BTN, arg_26_1)

	return
end

function NewSkinShopMainView:ExistL2dRes(arg_27_1)
	local var_27_0 = HXSet.autoHxShiftPath("live2d/" .. string.lower(arg_27_1), nil, true)

	return checkABExist(var_27_0), var_27_0
end

function NewSkinShopMainView:ExistSpineRes(arg_28_1)
	local var_28_0 = HXSet.autoHxShiftPath("SpinePainting/" .. string.lower(arg_28_1), nil, true)

	return checkABExist(var_28_0), var_28_0
end

function NewSkinShopMainView:FlushDynamicPaintingResState(arg_29_1)
	if not self.isToggleDynamic then
		return
	end

	local var_29_0 = self:GetPaintingState(arg_29_1)
	local var_29_1 = false
	local var_29_2 = ""

	if var_0_2 == var_29_0 then
		var_29_1, var_29_2 = self:ExistL2dRes(pg.ship_skin_template[self.skinId].painting)
	elseif var_0_3 == var_29_0 then
		var_29_1, var_29_2 = self:ExistSpineRes(pg.ship_skin_template[self.skinId].painting)
	end

	setActive(self.dynamicResDownaload, var_29_1)
	setActive(self.dynamicResUnDownaload, not var_29_1)
	removeOnButton(self.dynamicResUnDownaload)

	if not var_29_1 and var_29_2 ~= "" then
		onButton(self, self.dynamicResUnDownaload, function()
			self:DownloadDynamicPainting(var_29_2, arg_29_1)

			return
		end, SFX_PANEL)
	end

	return
end

function NewSkinShopMainView:DownloadDynamicPainting(arg_31_1, arg_31_2)
	local var_31_0 = self.skinId

	if self.downloads[self.skinId] then
		return
	end

	local var_31_1 = SkinShopDownloadRequest.New()

	self.downloads[self.skinId] = var_31_1

	var_31_1:Start(arg_31_1, function(arg_32_0)
		if arg_32_0 and self.paintingState and self.paintingState.id == arg_31_2.id then
			self:FlushPainting(arg_31_2)
			self:FlushDynamicPaintingResState(arg_31_2)
		end

		var_31_1:Dispose()

		self.downloads[var_31_0] = nil

		return
	end)

	return
end

function NewSkinShopMainView:GetPaintingState(arg_33_1)
	local var_33_0 = ShipSkin.New({
		id = self.skinId
	})

	if self.isToggleDynamic and var_33_0:IsLive2d() then
		return var_0_2
	elseif self.isToggleDynamic and var_33_0:IsSpine() then
		if var_33_0:getConfig("spine_use_live2d") == 1 then
			return var_0_2
		end

		return var_0_3
	else
		return var_0_1
	end

	return
end

function NewSkinShopMainView:FlushPainting(arg_34_1)
	local var_34_0 = self:GetPaintingState(arg_34_1)
	local var_34_1 = pg.ship_skin_template[self.skinId].painting
	local var_34_2 = not not ShipSkin.GetChangeSkinData(self.skinId)

	if var_34_0 == var_0_2 and not self:ExistL2dRes(var_34_1) or var_34_0 == var_0_3 and not self:ExistSpineRes(var_34_1) then
		var_34_0 = var_0_1
	end

	if self.paintingState and self.paintingState.state == var_34_0 and self.paintingState.id == arg_34_1.id and self.paintingState.showBg == self.isToggleShowBg and self.paintingState.purchaseFlag == arg_34_1.buyCount and not var_34_2 then
		return
	end

	self:ClearPainting()

	if var_34_0 == var_0_1 then
		self:LoadMeshPainting(arg_34_1, self.isToggleShowBg)
	elseif var_34_0 == var_0_2 then
		self:LoadL2dPainting(arg_34_1)
	elseif var_34_0 == var_0_3 then
		self:LoadSpinePainting(arg_34_1)
	end

	self.paintingState = {
		state = var_34_0,
		id = arg_34_1.id,
		showBg = self.isToggleShowBg,
		purchaseFlag = arg_34_1.buyCount
	}

	self:AdjustPainting(false)

	return
end

function NewSkinShopMainView:ClearPainting()
	if not self.paintingState then
		return
	end

	if self.paintingState.state == var_0_1 then
		self:ClearMeshPainting()
	elseif self.paintingState.state == var_0_2 then
		self:ClearL2dPainting()
	elseif self.paintingState.state == var_0_3 then
		self:ClearSpinePainting()
	end

	self.paintingState = nil

	return
end

function NewSkinShopMainView:LoadMeshPainting(arg_36_1, arg_36_2)
	local var_36_0 = findTF(self.paintingTF, "fitter")
	local var_36_1 = GetOrAddComponent(var_36_0, "PaintingScaler")

	var_36_1.FrameName = "chuanwu"
	var_36_1.Tween = 1

	local var_36_2 = pg.ship_skin_template[self.skinId].painting
	local var_36_3 = pg.ship_skin_template[self.skinId].painting

	if not arg_36_2 and checkABExist("painting/" .. var_36_2 .. "_n") then
		var_36_2 = var_36_2 .. "_n"
	end

	if not checkABExist("painting/" .. var_36_2) then
		return
	end

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetPainting(var_36_2, true, function(arg_37_0)
		pg.UIMgr.GetInstance():LoadingOff()
		setParent(arg_37_0, var_36_0, false)
		ShipExpressionHelper.SetExpression(var_36_0:GetChild(0), var_36_3)

		self.paintingName = var_36_2

		if self.paintingState and self.paintingState.id ~= arg_36_1.id then
			self:ClearMeshPainting()
		end

		self:CheckShowShopHx(arg_37_0.transform:Find("shop_hx"), arg_36_1)

		return
	end)

	return
end

function NewSkinShopMainView:ClearMeshPainting()
	local var_38_0 = self.paintingTF:Find("fitter")

	if self.paintingName and var_38_0.childCount > 0 then
		local var_38_1 = var_38_0:GetChild(0).gameObject

		self:RevertShopHx((var_38_1.transform:Find("shop_hx")))
		PoolMgr.GetInstance():ReturnPainting(self.paintingName, var_38_1)
	end

	self.paintingName = nil

	return
end

function NewSkinShopMainView:LoadL2dPainting(arg_39_1)
	local var_39_0

	if pg.ship_skin_template[self.skinId].skin_type == ShipSkin.SKIN_TYPE_TB then
		var_39_0 = VirtualEducateCharShip.New(NewEducateHelper.GetSecIdBySkinId(self.skinId))
	else
		local var_39_1 = {
			noChangeSkin = true
		}

		var_39_1.configId = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[self.skinId].ship_group).id
		var_39_1.skin_id = self.skinId
		var_39_0 = Ship.New(var_39_1)
	end

	local var_39_2 = Live2DPainting.GenerateData({
		ship = var_39_0,
		position = Vector3(0, 0, -1),
		parent = self.live2dContainer,
		offset = var_39_0:GetSkinConfig().shop_offset
	})

	var_39_2.shopPreView = true

	pg.UIMgr.GetInstance():LoadingOn()

	self.live2dChar = Live2DPainting.New(var_39_2, function(arg_40_0)
		arg_40_0:IgonreReactPos(true)
		self:CheckShowShopHxForL2d(arg_40_0, arg_39_1)

		if self.paintingState and self.paintingState.id ~= arg_39_1.id then
			self:ClearL2dPainting()
		end

		arg_40_0:setSortingLayer(LayerWeightConst.L2D_DEFAULT_LAYER)
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	return
end

function NewSkinShopMainView:ClearL2dPainting()
	if self.live2dChar then
		self:RevertShopHxForL2d(self.live2dChar)
		self.live2dChar:Dispose()

		self.live2dChar = nil
	end

	return
end

function NewSkinShopMainView:LoadSpinePainting(arg_42_1)
	local var_42_0

	if pg.ship_skin_template[self.skinId].skin_type == ShipSkin.SKIN_TYPE_TB then
		var_42_0 = VirtualEducateCharShip.New(NewEducateHelper.GetSecIdBySkinId(self.skinId))
	else
		local var_42_1 = {
			noChangeSkin = true
		}

		var_42_1.configId = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[self.skinId].ship_group).id
		var_42_1.skin_id = self.skinId
		var_42_0 = Ship.New(var_42_1)
	end

	local var_42_2 = SpinePainting.GenerateData({
		ship = var_42_0,
		position = Vector3(0, 0, 0),
		parent = self.spTF,
		effectParent = self.spBg,
		offset = var_42_0:GetSkinConfig().shop_offset
	})

	pg.UIMgr.GetInstance():LoadingOn()

	self.spinePainting = SpinePainting.New(var_42_2, function(arg_43_0)
		if self.paintingState and self.paintingState.id ~= arg_42_1.id then
			self:ClearSpinePainting()
		end

		self:CheckShowShopHx(arg_43_0._tf:Find("shop_hx"), arg_42_1)
		pg.UIMgr.GetInstance():LoadingOff()
		arg_43_0:SetShopHx()

		return
	end)

	return
end

function NewSkinShopMainView:ClearSpinePainting()
	if self.spinePainting and self.spinePainting._tf then
		local var_44_0 = self.spinePainting._tf:Find("shop_hx")

		self:RevertShopHx(self.shopHx)
		self.spinePainting:Dispose()

		self.spinePainting = nil
	end

	return
end

function NewSkinShopMainView:CheckShowShopHxForL2d(arg_45_1, arg_45_2)
	if PLATFORM_CODE ~= PLATFORM_CH then
		return
	end

	if not HXSet.isHx() then
		return
	end

	arg_45_1:changeParamaterValue("shophx", arg_45_2.buyCount <= 0 and 1 or 0)

	return
end

function NewSkinShopMainView:RevertShopHxForL2d(arg_46_1)
	arg_46_1:changeParamaterValue("shophx", 0)

	return
end

function NewSkinShopMainView:CheckShowShopHx(arg_47_1, arg_47_2)
	if PLATFORM_CODE ~= PLATFORM_CH then
		return
	end

	if not HXSet.isHx() then
		return
	end

	if not IsNil(arg_47_1) and arg_47_2.buyCount <= 0 then
		setActive(arg_47_1, true)
	end

	return
end

function NewSkinShopMainView:RevertShopHx(arg_48_1)
	if not IsNil(arg_48_1) then
		setActive(arg_48_1, false)
	end

	return
end

function NewSkinShopMainView:FlushPreviewBtn(arg_49_1)
	local var_49_0 = Goods.ExistFurniture(arg_49_1.id)

	removeOnButton(self.switchPreviewBtn)

	if not var_49_0 and self.isPreviewFurniture then
		self.isPreviewFurniture = false
	end

	setActive(self.switchPreviewBtn, var_49_0)

	if var_49_0 then
		onButton(self, self.switchPreviewBtn, function()
			if self:IsSwitchTweening() then
				return
			end

			self.isPreviewFurniture = not self.isPreviewFurniture

			self:SwitchPreview(arg_49_1, self.isPreviewFurniture, true)
			self:FlushPrice(arg_49_1)
			self:FlushObtainBtn(arg_49_1)

			return
		end, SFX_PANEL)
	end

	return
end

function NewSkinShopMainView:IsSwitchTweening()
	return LeanTween.isTweening(go(self.furnitureBg)) or LeanTween.isTweening(go(self.charBg))
end

function NewSkinShopMainView:ClearSwitchTween()
	if self:IsSwitchTweening() then
		LeanTween.cancel(go(self.furnitureBg))
		LeanTween.cancel(go(self.charBg))
	end

	return
end

function NewSkinShopMainView:StartSwitchAnim(arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	self:ClearSwitchTween()

	local var_53_0 = arg_53_1:GetComponent(typeof(CanvasGroup))
	local var_53_1 = arg_53_2:GetComponent(typeof(CanvasGroup))
	local var_53_2 = var_53_0.alpha
	local var_53_3 = var_53_1.alpha

	LeanTween.moveLocal(go(arg_53_1), arg_53_2.anchoredPosition3D, arg_53_3):setOnComplete(System.Action(function()
		var_53_0.alpha = var_53_3

		return
	end))
	LeanTween.moveLocal(go(arg_53_2), arg_53_1.anchoredPosition3D, arg_53_3):setOnComplete(System.Action(function()
		var_53_1.alpha = var_53_2

		arg_53_4()

		return
	end))

	return
end

function NewSkinShopMainView:SwitchPreview(arg_56_1, arg_56_2, arg_56_3)
	if pg.ship_skin_template[self.skinId].skin_type == ShipSkin.SKIN_TYPE_TB then
		setActive(self.charContainer, false)

		return
	end

	setActive(self.charContainer, true)

	local var_56_0 = self.furnitureBg
	local var_56_1 = self.charBg

	self:StartSwitchAnim(self.furnitureBg, self.charBg, arg_56_3 and 0.3 or 0, function()
		setActive(self.charTf, not arg_56_2)
		setActive(self.furnitureContainer, arg_56_2)

		return
	end)

	if not arg_56_2 then
		var_56_0:SetAsFirstSibling()
		var_56_1:SetSiblingIndex(2)
		self:FlushChar(pg.ship_skin_template[self.skinId].prefab, pg.ship_skin_template[self.skinId].id)
	else
		var_56_1:SetAsFirstSibling()
		var_56_0:SetSiblingIndex(2)

		local var_56_2 = Goods.GetFurnitureConfig(arg_56_1.id)

		self.interactionPreview:Flush(self.skinId, Goods.Id2FurnitureId(arg_56_1.id), var_56_2.scale[2] or 1, var_56_2.position[2])
	end

	return
end

function NewSkinShopMainView:GetObtainBtnState(arg_58_1)
	if arg_58_1:getConfig("genre") == ShopArgs.SkinShopTimeLimit then
		return var_0_9
	elseif self.isPreviewFurniture then
		if getProxy(DormProxy):getRawData():HasFurniture(Goods.Id2FurnitureId(arg_58_1.id)) then
			return var_0_4
		else
			return var_0_8
		end
	elseif arg_58_1.type == Goods.TYPE_ACTIVITY or arg_58_1.type == Goods.TYPE_ACTIVITY_EXTRA then
		return var_0_6
	elseif arg_58_1.buyCount > 0 then
		return var_0_4
	elseif arg_58_1:isDisCount() and arg_58_1:IsItemDiscountType() then
		return var_0_7
	elseif arg_58_1:CanUseVoucherType() or arg_58_1:ExistExclusiveDiscountItem() then
		return var_0_10
	elseif #arg_58_1:GetGiftList() > 0 then
		return var_0_11
	else
		return var_0_5
	end

	return
end

function NewSkinShopMainView:GetMode()
	return self.contextData.mode or NewSkinShopScene.MODE_OVERVIEW
end

function NewSkinShopMainView:FlushPrice(arg_60_1)
	local var_60_0 = arg_60_1:getConfig("genre") == ShopArgs.SkinShopTimeLimit
	local var_60_1 = arg_60_1.type == Goods.TYPE_ACTIVITY or arg_60_1.type == Goods.TYPE_ACTIVITY_EXTRA

	if var_60_0 then
		if self:GetMode() == NewSkinShopScene.MODE_EXPERIENCE_FOR_ITEM then
			self:UpdateExperiencePrice4Item(arg_60_1)
		else
			self:UpdateExperiencePrice(arg_60_1)
		end
	elseif self.isPreviewFurniture then
		self:UpdateFurniturePrice(arg_60_1)
	elseif var_60_1 then
		-- block empty
	else
		self:UpdateCommodityPrice(arg_60_1)
	end

	local var_60_2 = arg_60_1.type == Goods.TYPE_SKIN

	setActive(self.experienceTr, var_60_0 and not var_60_1)
	setActive(self.consumeTr, var_60_2 and not var_60_0 and not var_60_1)

	return
end

function NewSkinShopMainView:UpdateExperiencePrice4Item(arg_61_1)
	local var_61_0 = arg_61_1:getConfig("resource_num")
	local var_61_1 = _.detect(getProxy(BagProxy):GetSkinExperienceItems(), function(arg_62_0)
		return arg_62_0:CanUseForShop(arg_61_1.id)
	end)
	local var_61_2

	if var_61_1 then
		var_61_2 = var_61_1.count or 0

		local var_61_3

		if var_61_2 < var_61_0 then
			var_61_3 = "<color=" .. COLOR_RED .. ">" or ""
		end
	end

	self.experienceTxt.text = (var_61_3 .. var_61_2 .. (var_61_2 < var_61_0 and "</color>" or "")) .. "/" .. var_61_0

	return
end

function NewSkinShopMainView:UpdateExperiencePrice(arg_63_1)
	local var_63_0 = arg_63_1:getConfig("resource_num")
	local var_63_1 = getProxy(PlayerProxy):getRawData():getSkinTicket()

	self.experienceTxt.text = (((var_63_1 < var_63_0 or nil) and ("<color=" .. COLOR_RED .. ">" or "")) .. var_63_1 .. (var_63_1 < var_63_0 and "</color>" or "")) .. "/" .. var_63_0

	return
end

function NewSkinShopMainView:UpdateCommodityPrice(arg_64_1)
	local var_64_0 = arg_64_1:GetPrice()
	local var_64_1 = arg_64_1:getConfig("resource_num")

	self.consumeRealPriceTxt.text = var_64_0
	self.consumePriceTxt.text = var_64_1

	setActive(tf(go(self.consumePriceTxt)).parent, var_64_0 ~= var_64_1)

	return
end

function NewSkinShopMainView:UpdateFurniturePrice(arg_65_1)
	local var_65_0 = Furniture.New({
		id = Goods.Id2FurnitureId(arg_65_1.id)
	})
	local var_65_1 = var_65_0:getConfig("gem_price")

	self.consumePriceTxt.text = var_65_1

	local var_65_2 = var_65_0:getPrice(PlayerConst.ResDiamond)

	self.consumeRealPriceTxt.text = var_65_2

	setActive(tf(go(self.consumePriceTxt)).parent, var_65_1 ~= var_65_2)

	return
end

function NewSkinShopMainView:FlushObtainBtn(arg_66_1)
	local var_66_0 = self:GetObtainBtnState(arg_66_1)
	local var_66_1 = self.obtainBtnSprites[var_66_0]

	if not self.obtainBtnSprites[var_66_0] then
		var_66_1 = GetSpriteFromAtlas("ui/skinshopui_atlas", var_0_12(var_66_0))
		self.obtainBtnSprites[var_66_0] = var_66_1
	end

	self.obtainBtnImg.sprite = var_66_1

	self.obtainBtnImg:SetNativeSize()
	setActive(self.giftTag, var_66_0 == var_0_11)
	setActive(self.giftItem, var_66_0 == var_0_11)

	if var_66_0 == var_0_11 then
		self:FlushGift(arg_66_1)
	else
		self.giftText.text = ""
	end

	onButton(self, self.obtainBtn, function()
		local var_67_0 = {}
		local var_67_1 = SkinCouponActivity.StaticEncoreActTip(arg_66_1.id)

		if tobool(var_67_1) then
			table.insert(var_67_0, function(arg_68_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("SkinDiscount_Hint"),
					onYes = function()
						if var_67_1 and not var_67_1:isEnd() then
							self:emit(NewSkinShopMediator.OPEN_ACTIVITY, var_67_1.id)
						end

						return
					end,
					onNo = function()
						arg_68_0()

						return
					end
				})

				return
			end)
		end

		seriesAsync(var_67_0, function()
			if var_66_0 == var_0_5 or var_66_0 == var_0_7 or var_66_0 == var_0_11 then
				self.purchaseView:ExecuteAction("Show", arg_66_1)
			else
				self:OnClickBtn(var_66_0, arg_66_1)
			end

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function NewSkinShopMainView:OnClickBtn(arg_72_1, arg_72_2)
	if arg_72_1 == var_0_5 or arg_72_1 == var_0_7 or arg_72_1 == var_0_11 then
		self:OnPurchase(arg_72_2)
	elseif arg_72_1 == var_0_10 then
		self:OnItemPurchase(arg_72_2)
	elseif arg_72_1 == var_0_6 then
		self:OnActivity(arg_72_2)
	elseif arg_72_1 == var_0_8 then
		self:OnBackyard(arg_72_2)
	elseif arg_72_1 == var_0_9 then
		if self:GetMode() == NewSkinShopScene.MODE_EXPERIENCE_FOR_ITEM then
			self:OnExperience4Item(arg_72_2)
		else
			self:OnExperience(arg_72_2)
		end
	end

	return
end

function NewSkinShopMainView:FlushGift(arg_73_1)
	local var_73_0 = arg_73_1:GetGiftList()

	updateDrop(self.giftItem, {
		type = var_73_0[1].type,
		id = var_73_0[1].id,
		count = var_73_0[1].count
	})

	if #var_73_0 > 1 then
		self.giftText.text = "+" .. #var_73_0 - 1 .. "..." or ""
	end

	return
end

function NewSkinShopMainView:OnItemPurchase(arg_74_1)
	if arg_74_1.type ~= Goods.TYPE_SKIN then
		return
	end

	local var_74_0 = arg_74_1:GetVoucherIdList()
	local var_74_1 = getProxy(BagProxy):GetExclusiveDiscountItem4Shop(arg_74_1.id)

	if #var_74_0 <= 0 and #var_74_1 <= 0 then
		return
	end

	local var_74_2 = {}

	for iter_74_0, iter_74_1 in ipairs(var_74_0) do
		table.insert(var_74_2, iter_74_1)
	end

	for iter_74_2, iter_74_3 in ipairs(var_74_1) do
		table.insert(var_74_2, iter_74_3.id)
	end

	self.voucherMsgBox:ExecuteAction("Show", {
		itemList = var_74_2,
		skinId = self.skinId,
		skinName = SwitchSpecialChar(pg.ship_skin_template[self.skinId].name, true),
		price = arg_74_1:GetPrice(),
		onYes = function(arg_75_0)
			if arg_75_0 then
				self:emit(NewSkinShopMediator.ON_ITEM_PURCHASE, arg_75_0, arg_74_1.id)
			else
				self:emit(NewSkinShopMediator.ON_SHOPPING, arg_74_1.id, 1)
			end

			return
		end
	})

	return
end

function NewSkinShopMainView:OnPurchase(arg_76_1)
	if arg_76_1.type ~= Goods.TYPE_SKIN then
		return
	end

	if arg_76_1:isDisCount() and arg_76_1:IsItemDiscountType() then
		self:emit(NewSkinShopMediator.ON_SHOPPING_BY_ACT, arg_76_1.id, 1)
	else
		self:emit(NewSkinShopMediator.ON_SHOPPING, arg_76_1.id, 1)
	end

	return
end

function NewSkinShopMainView:OnActivity(arg_77_1)
	local var_77_0 = arg_77_1:getConfig("activity")
	local var_77_1 = getProxy(ActivityProxy):getActivityById(var_77_0)

	if var_77_0 == 0 then
		if not pg.TimeMgr.GetInstance():inTime((arg_77_1:getConfig("time"))) then
			if var_77_1 and not var_77_1:isEnd() then
				if arg_77_1.type == Goods.TYPE_ACTIVITY then
					self:emit(NewSkinShopMediator.GO_SHOPS_LAYER, arg_77_1:getConfig("activity"))
				elseif arg_77_1.type == Goods.TYPE_ACTIVITY_EXTRA then
					local var_77_2 = arg_77_1:getConfig("scene")

					if var_77_2 and #var_77_2 > 0 then
						self:emit(NewSkinShopMediator.OPEN_SCENE, var_77_2)
					else
						self:emit(NewSkinShopMediator.OPEN_ACTIVITY, var_77_0)
					end
				end

				goto label_77_0
			end
		end
	end

	pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_not_start"))

	::label_77_0::

	return
end

function NewSkinShopMainView:OnBackyard(arg_78_1)
	if not pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "BackYardMediator") then
		pg.TipsMgr.GetInstance():ShowTips(i18n("no_open_system_tip", pg.open_systems_limited[1].name, pg.open_systems_limited[1].level))

		return
	end

	self:emit(NewSkinShopMediator.ON_BACKYARD_SHOP)

	return
end

function NewSkinShopMainView:OnExperience(arg_79_1)
	local var_79_0 = getProxy(ShipSkinProxy):getSkinById(self.skinId)

	if var_79_0 and not var_79_0:isExpireType() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("already_have_the_skin"))

		return
	end

	local var_79_1 = arg_79_1:getConfig("resource_num")
	local var_79_2, var_79_3, var_79_4, var_79_5 = pg.TimeMgr.GetInstance():parseTimeFrom(arg_79_1:getConfig("time_second") * var_79_1)

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("exchange_limit_skin_tip", var_79_1, pg.ship_skin_template[self.skinId].name, var_79_2, var_79_3),
		onYes = function()
			if getProxy(PlayerProxy):getRawData():getSkinTicket() < var_79_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

				return
			end

			self:emit(NewSkinShopMediator.ON_SHOPPING, arg_79_1.id, 1)

			return
		end
	})

	return
end

function NewSkinShopMainView:OnExperience4Item(arg_81_1)
	local var_81_0 = getProxy(ShipSkinProxy):getSkinById(self.skinId)

	if var_81_0 and not var_81_0:isExpireType() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("already_have_the_skin"))

		return
	end

	local var_81_1 = arg_81_1:getConfig("resource_num")
	local var_81_2, var_81_3, var_81_4, var_81_5 = pg.TimeMgr.GetInstance():parseTimeFrom(arg_81_1:getConfig("time_second") * var_81_1)
	local var_81_6 = _.detect(getProxy(BagProxy):GetSkinExperienceItems(), function(arg_82_0)
		return arg_82_0:CanUseForShop(arg_81_1.id)
	end)

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("exchange_limit_skin_tip", var_81_1, pg.ship_skin_template[self.skinId].name, var_81_2, var_81_3),
		onYes = function()
			if not var_81_6 or var_81_6.count < var_81_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

				return
			end

			self:emit(NewSkinShopMediator.ON_ITEM_EXPERIENCE, var_81_6.id, arg_81_1.id, 1)

			return
		end
	})

	return
end

function NewSkinShopMainView:FlushTag(arg_84_1)
	local var_84_0 = pg.ship_skin_template[self.skinId].tag

	self.uiTagList:make(function(arg_85_0, arg_85_1, arg_85_2)
		if arg_85_0 == UIItemList.EventUpdate then
			LoadSpriteAtlasAsync("SkinIcon", "type_" .. ShipSkin.Tag2Name(var_84_0[arg_85_1 + 1]), function(arg_86_0)
				if self.exited then
					return
				end

				local var_86_0 = arg_85_2:Find("icon"):GetComponent(typeof(Image))

				var_86_0.sprite = arg_86_0

				var_86_0:SetNativeSize()

				return
			end)
		end

		return
	end)
	self.uiTagList:align(#pg.ship_skin_template[self.skinId].tag)

	return
end

function NewSkinShopMainView:FlushChar(arg_87_1, arg_87_2)
	if self.prefabName and self.prefabName == arg_87_1 then
		return
	end

	self:ReturnChar()

	self.spineChar = SpineAnimChar.New()

	self.spineChar:SetPaint(arg_87_1)
	self.spineChar:Load(true, function(arg_88_0)
		self.prefabName = arg_87_1

		if pg.skinshop_spine_scale[arg_87_2] then
			self.spineChar:SetLocalScale(Vector3(pg.skinshop_spine_scale[arg_87_2].skinshop_scale, pg.skinshop_spine_scale[arg_87_2].skinshop_scale, 1))
		else
			self.spineChar:SetLocalScale(Vector3(0.9, 0.9, 1))
		end

		self.spineChar:SetLocalPosition(Vector3(0, 0, 0))
		self.spineChar:SetLayer(Layer.UI)
		self.spineChar:SetParent(self.charTf)
		self.spineChar:SetAction("normal", 0)

		return
	end)

	return
end

function NewSkinShopMainView:FlushTimeline(arg_89_1)
	local var_89_0 = false
	local var_89_1

	if arg_89_1:IsActivityExtra() and arg_89_1:ShowMaintenanceTime() then
		local var_89_2, var_89_3 = arg_89_1:GetMaintenanceMonthAndDay()

		function var_89_1()
			return i18n("limit_skin_time_before_maintenance", var_89_2, var_89_3)
		end

		var_89_0 = true
	elseif arg_89_1:getConfig("genre") == ShopArgs.SkinShopTimeLimit then
		local var_89_4 = getProxy(ShipSkinProxy):getSkinById(self.skinId)

		var_89_0 = var_89_4 and var_89_4:isExpireType() and not var_89_4:isExpired()

		if var_89_0 then
			function var_89_1()
				return skinTimeStamp(var_89_4:getRemainTime())
			end
		end
	else
		local var_89_5, var_89_6 = pg.TimeMgr.GetInstance():inTime(arg_89_1:getConfig("time"))

		var_89_0 = var_89_6

		if var_89_6 then
			local var_89_7 = pg.TimeMgr.GetInstance():Table2ServerTime(var_89_6)

			function var_89_1()
				return skinCommdityTimeStamp(var_89_7)
			end
		end
	end

	setActive(self.timeLimitTr, var_89_0)
	self:ClearTimer()

	if var_89_0 then
		self:AddTimer(var_89_1)
	end

	return
end

function NewSkinShopMainView:AddTimer(arg_93_1)
	self.timer = Timer.New(function()
		self.timeLimitTxt.text = arg_93_1()

		return
	end, 1, -1)

	self.timer.func()
	self.timer:Start()

	return
end

function NewSkinShopMainView:ClearTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function NewSkinShopMainView:ReturnChar()
	if self.spineChar then
		self.spineChar:Dispose()

		self.spineChar = nil
		self.prefabName = nil
	end

	return
end

function NewSkinShopMainView:ClosePurchaseView()
	if self.purchaseView and self.purchaseView:GetLoaded() then
		self.purchaseView:Hide()
	end

	return
end

function NewSkinShopMainView:AdjustPainting(arg_98_1)
	if pg.ship_skin_newmainui_shift[self.skinId] then
		local var_98_0 = pg.ship_skin_newmainui_shift[self.skinId].skin_shop_shift

		self.paintingTF.anchoredPosition = arg_98_1 and Vector2(var_98_0[1] - 440, var_98_0[2] + self.defaultPaintingPosition.y) or Vector2(var_98_0[1] + self.defaultPaintingPosition.x, var_98_0[2] + self.defaultPaintingPosition.y)
		self.paintingTF.localScale = Vector3(var_98_0[4], var_98_0[4], 1)
	else
		self.paintingTF.anchoredPosition = Vector2(self.defaultPaintingPosition.x, self.defaultPaintingPosition.y)
		self.paintingTF.localScale = self.defaultPaintingScale
	end

	return
end

function NewSkinShopMainView:Dispose()
	self.exited = true

	pg.DelegateInfo.Dispose(self)
	self:ClearSwitchBgAnim()
	pg.DynamicBgMgr.GetInstance():ClearBg(self:getUIName())

	if self.live2dChar then
		self.live2dChar:Dispose()

		self.live2dChar = nil
	end

	if self.voucherMsgBox then
		self.voucherMsgBox:Destroy()

		self.voucherMsgBox = nil
	end

	if self.purchaseView then
		self.purchaseView:Destroy()

		self.purchaseView = nil
	end

	for iter_99_0, iter_99_1 in pairs(self.downloads) do
		iter_99_1:Dispose()
	end

	self.downloads = {}

	self:ClearPainting()

	for iter_99_2, iter_99_3 in pairs(self.obtainBtnSprites) do
		self.obtainBtnSprites[iter_99_3] = nil
	end

	self.obtainBtnSprites = nil

	if self.interactionPreview then
		self.interactionPreview:Dispose()

		self.interactionPreview = nil
	end

	self:ClearSwitchTween()
	self:disposeEvent()
	self:ClearTimer()
	self:ReturnChar()

	return
end

return NewSkinShopMainView
