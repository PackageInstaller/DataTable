local NewSkinShowLayer = class("NewSkinShowLayer", import("...base.BaseUI"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function NewSkinShowLayer:getUIName()
	return "NewSkinShowUI"
end

function NewSkinShowLayer:init()
	self.backBtn = self._tf:Find("adapt/top/closeBtn")
	self.homeBtn = self._tf:Find("adapt/top/homeBtn")
	self.bgs = self._tf:Find("bgs")
	self.resources = self._tf:Find("adapt/top/resources")
	self.limitTime = self._tf:Find("adapt/top/skinTitle/limit_time")
	self.skinName = self._tf:Find("adapt/top/skinTitle/skin_name_mask/skin_name")
	self.shipName = self._tf:Find("adapt/top/skinTitle/name_mask/name")
	self.changeSkin = self._tf:Find("adapt/top/change_skin")
	self.sdTg = self._tf:Find("adapt/right/sdTg")
	self.hideUITg = self._tf:Find("adapt/right/hideUITg")
	self.charContainer = self._tf:Find("adapt/right/char_container")
	self.backChara = self.charContainer:Find("bg/back/chara")
	self.charTf = self.charContainer:Find("char")
	self.furnitureContainer = self.charContainer:Find("fur")
	self.dynamicToggle = self._tf:Find("adapt/right/functionsAndTags/dynamic")
	self.showBgToggle = self._tf:Find("adapt/right/functionsAndTags/showBg")
	self.dynamicResToggle = self._tf:Find("adapt/right/functionsAndTags/dynamic/l2d_res_state")
	self.tagList = UIItemList.New(self._tf:Find("adapt/right/functionsAndTags/tags"), self._tf:Find("adapt/right/functionsAndTags/tags/tag"))
	self.switchPreviewBtn = self.charContainer:Find("switch")
	self.painting = self._tf:Find("painting")
	self.paintingTF = self._tf:Find("painting/paint")
	self.defaultPaintingPosition = self.paintingTF.anchoredPosition
	self.defaultPaintingScale = self.paintingTF.localScale
	self.live2dContainer = self._tf:Find("painting/paint/live2d")
	self.spTF = self._tf:Find("painting/paint/spinePainting")
	self.spBg = self._tf:Find("painting/paintBg/spinePainting")
	self.equipBtn = self._tf:Find("adapt/equipBtn")

	setText(self._tf:Find("bgs/empty/Text"), i18n("shop_new_unfound"))
	setText(self._tf:Find("adapt/top/title/Text"), i18n("shop_new_shop"))
	setText(self.equipBtn:Find("Text"), i18n("shop_new_wear"))
	setActive(self.switchPreviewBtn, false)
	setActive(self.limitTime, false)

	self.changeSkinToggle = ChangeSkinToggle.New(self.changeSkin:Find("toggle_ui"))
	self.downloads = {}
	self.isToggleDynamic = false
	self.isToggleShowBg = true
	self.selectShipPage = ChangeShipSkinPage.New(self._parentTf, self.event)

	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	return
end

function NewSkinShowLayer:didEnter()
	self.shipSkin = self.contextData.skin
	self.skinId = self.shipSkin.id

	self:SetResource()
	self:UpdateMainView()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.homeBtn, function()
		self:emit(NewSkinShowLayer.ON_HOME)

		return
	end, SFX_CANCEL)

	local var_3_0 = getProxy(PlayerProxy):getRawData().id

	onToggle(self, self.sdTg, function(arg_6_0)
		setActive(self.charContainer, arg_6_0)
		PlayerPrefs.SetInt("LatestSkinShopLayerSdTg" .. var_3_0, arg_6_0 and 1 or 0)
		PlayerPrefs.Save()

		return
	end, SFX_PANEL)
	triggerToggle(self.sdTg, PlayerPrefs.GetInt("LatestSkinShopLayerSdTg" .. var_3_0, 0) == 1)
	onToggle(self, self.sdTg, function(arg_7_0)
		setActive(self.charContainer, arg_7_0)

		return
	end, SFX_PANEL)
	onToggle(self, self.hideUITg, function(arg_8_0)
		setActive(self._tf:Find("adapt/top"), not arg_8_0)

		return
	end, SFX_PANEL)
	onButton(self, self.equipBtn, function()
		if self.shipSkin:CantUse() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("without_ship_to_wear"))

			return
		end

		self.selectShipPage:ExecuteAction("Show", self.shipSkin)

		return
	end, SFX_PANEL)
	onButton(self, self.changeSkin, function()
		if ShipSkin.IsChangeSkin(self.skinId) then
			self.changeSkinId = ShipSkin.GetChangeSkinNextId(self.skinId)

			self:UpdateMainView()
		end

		return
	end, SFX_PANEL)

	return
end

function NewSkinShowLayer:SetResource()
	setText(self.resources:Find("gem/Text"), getProxy(PlayerProxy):getRawData():getTotalGem())
	onButton(self, self.resources:Find("gem"), function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)

	return
end

function NewSkinShowLayer:UpdateMainView()
	local var_13_0 = ShipSkin.IsChangeSkin(self.skinId)

	setActive(self.changeSkin, var_13_0)

	if var_13_0 then
		self:FlushChangeSkin()
	end

	self:FlushName()
	self:FlushSkin()
	self:FlushPaintingToggle()
	self:FlushTag()
	self:FlushBG()
	self:FlushPainting()

	return
end

function NewSkinShowLayer:FlushChangeSkin()
	if not self.changeSkinId then
		self.changeSkinId = self.skinId
	elseif ShipSkin.GetChangeSkinGroupId(self.changeSkinId) == ShipSkin.GetChangeSkinGroupId(self.skinId) then
		self.skinId = self.changeSkinId
		self.shipSkin = ShipSkin.New({
			id = self.skinId
		})
	else
		self.changeSkinId = self.skinId
	end

	self._toggleIndex = ShipSkin.GetChangeSkinIndex(self.skinId)

	self.changeSkinToggle:setSkinData(self.skinId)
	setActive(self.changeSkin, not self.changeSkinToggle:IsAsmrSkin())

	return
end

function NewSkinShowLayer:FlushName()
	setScrollText(self.skinName, SwitchSpecialChar(pg.ship_skin_template[self.skinId].name, true))

	if pg.ship_skin_template[self.skinId].skin_type == ShipSkin.SKIN_TYPE_TB then
		setScrollText(self.shipName, NewEducateHelper.GetShipNameBySecId(NewEducateHelper.GetSecIdBySkinId(self.skinId)))
	else
		setScrollText(self.shipName, ShipGroup.getDefaultShipConfig(pg.ship_skin_template[self.skinId].ship_group).name)
	end

	return
end

function NewSkinShowLayer:FlushSkin()
	if pg.ship_skin_template[self.skinId].skin_type == ShipSkin.SKIN_TYPE_TB then
		setActive(self.charContainer, false)

		return
	end

	setActive(self.charContainer, true)
	self:FlushChar(pg.ship_skin_template[self.skinId].prefab, pg.ship_skin_template[self.skinId].id)
	GetImageSpriteFromAtlasAsync("qicon/" .. pg.ship_skin_template[self.skinId].painting, "", self.backChara)

	return
end

function NewSkinShowLayer:FlushChar(arg_17_1, arg_17_2)
	if self.prefabName and self.prefabName == arg_17_1 then
		return
	end

	self:ReturnChar()

	self.prefabName = arg_17_1

	PoolMgr.GetInstance():GetSpineChar(arg_17_1, true, function(arg_18_0)
		if self.prefabName ~= arg_17_1 then
			PoolMgr.GetInstance():ReturnSpineChar(arg_17_1, arg_18_0)

			return
		end

		self.spineChar = tf(arg_18_0)
		self.spineChar.localScale = pg.skinshop_spine_scale[arg_17_2] and Vector3(pg.skinshop_spine_scale[arg_17_2].skinshop_scale, pg.skinshop_spine_scale[arg_17_2].skinshop_scale, 1) or Vector3(0.9, 0.9, 1)
		self.spineChar.localPosition = Vector3(0, 0, 0)

		pg.ViewUtils.SetLayer(self.spineChar, Layer.UI)
		setParent(self.spineChar, self.charTf)
		arg_18_0:GetComponent("SpineAnimUI"):SetAction("normal", 0)

		return
	end)

	return
end

function NewSkinShowLayer:FlushPaintingToggle()
	removeOnToggle(self.dynamicToggle)
	removeOnToggle(self.showBgToggle)

	local var_19_0 = checkABExist("painting/" .. self.shipSkin:getConfig("painting") .. "_n")

	if self.isToggleShowBg and not var_19_0 then
		triggerToggle(self.showBgToggle, false)

		self.isToggleShowBg = false
	elseif var_19_0 then
		triggerToggle(self.showBgToggle, true)

		self.isToggleShowBg = true
	end

	local var_19_1 = self.shipSkin:IsSpine() or self.shipSkin:IsLive2d() or self.shipSkin:IsSpinePlus() or self.shipSkin:IsLive2dPlus()

	if var_19_1 then
		if PlayerPrefs.GetInt("skinShop#l2dPreViewToggle" .. getProxy(PlayerProxy):getRawData().id, 0) == 1 then
			self.isToggleDynamic = true
		end
	end

	if var_19_1 then
		local var_19_2 = 0

		if self.shipSkin:IsSpine() then
			var_19_2 = 6
		elseif self.shipSkin:IsLive2d() then
			var_19_2 = 1
		elseif self.shipSkin:IsSpinePlus() then
			var_19_2 = 7
		elseif self.shipSkin:IsLive2dPlus() then
			var_19_2 = 9
		end

		LoadImageSpriteAtlasAsync("SkinIcon", "type_" .. ShipSkin.Tag2Name(var_19_2) .. "_off", self.dynamicToggle)
		LoadImageSpriteAtlasAsync("SkinIcon", "type_" .. ShipSkin.Tag2Name(var_19_2), self.dynamicToggle:Find("select"))
	end

	if self.isToggleDynamic and not var_19_1 then
		triggerToggle(self.dynamicToggle, false)

		self.isToggleDynamic = false
	elseif self.isToggleDynamic and not self.dynamicToggle:GetComponent(typeof(Toggle)).isOn then
		if (self.shipSkin:IsLive2d() or self.shipSkin:IsLive2dPlus()) and Live2dConst.GetLive2DArm32MatchAble() then
			self.isToggleDynamic = false

			PlayerPrefs.SetInt("skinShop#l2dPreViewToggle" .. getProxy(PlayerProxy):getRawData().id, 0)
			PlayerPrefs.Save()
			triggerToggle(self.dynamicToggle, false)
		else
			triggerToggle(self.dynamicToggle, true)

			self.isToggleDynamic = true
		end
	end

	if var_19_0 then
		onToggle(self, self.showBgToggle, function(arg_20_0)
			self.isToggleShowBg = arg_20_0

			self:FlushPainting()
			self:FlushBG()

			return
		end, SFX_PANEL)
	end

	if self.shipSkin:IsSpine() or self.shipSkin:IsLive2d() or self.shipSkin:IsSpinePlus() or self.shipSkin:IsLive2dPlus() then
		onToggle(self, self.dynamicToggle, function(arg_21_0)
			if arg_21_0 and Live2dConst.GetLive2DArm32MatchAble() and (self.shipSkin:IsLive2d() or self.shipSkin:IsLive2dPlus()) then
				Live2dConst.ShowLive2DArm32Tips()
				triggerToggle(self.dynamicToggle, false)

				return
			end

			self.isToggleDynamic = arg_21_0

			setActive(self.showBgToggle, not arg_21_0 and var_19_0)
			self:FlushPainting()
			self:FlushDynamicPaintingResState()
			self:RecordFlag(arg_21_0)

			return
		end, SFX_PANEL)
	end

	if self.isToggleDynamic then
		self:FlushDynamicPaintingResState()
	end

	setActive(self.dynamicToggle, var_19_1)
	setActive(self.showBgToggle, not self.isToggleDynamic and var_19_0)

	return
end

function NewSkinShowLayer:FlushPainting()
	local var_22_0 = self:GetPaintingState()
	local var_22_1 = pg.ship_skin_template[self.skinId].painting
	local var_22_2 = not not ShipSkin.GetChangeSkinData(self.skinId)

	if var_22_0 == var_0_2 and not self:ExistL2dRes(var_22_1) or var_22_0 == var_0_3 and not self:ExistSpineRes(var_22_1) then
		var_22_0 = var_0_1
	end

	if self.paintingState and self.paintingState.state == var_22_0 and self.paintingState.id == self.skinId and self.paintingState.showBg == self.isToggleShowBg and not var_22_2 then
		return
	end

	self:ClearPainting()

	if var_22_0 == var_0_1 then
		self:LoadMeshPainting(self.isToggleShowBg)
	elseif var_22_0 == var_0_2 then
		self:LoadL2dPainting()
	elseif var_22_0 == var_0_3 then
		self:LoadSpinePainting()
	end

	self.paintingState = {
		state = var_22_0,
		id = self.skinId,
		showBg = self.isToggleShowBg
	}

	self:AdjustPainting(false)

	return
end

function NewSkinShowLayer:GetPaintingState()
	if self.isToggleDynamic and (self.shipSkin:IsLive2d() or self.shipSkin:IsLive2dPlus()) then
		return var_0_2
	elseif self.isToggleDynamic and (self.shipSkin:IsSpine() or self.shipSkin:IsSpinePlus()) then
		if self.shipSkin:getConfig("spine_use_live2d") == 1 then
			return var_0_2
		end

		return var_0_3
	else
		return var_0_1
	end

	return
end

function NewSkinShowLayer:ExistL2dRes(arg_24_1)
	local var_24_0 = HXSet.autoHxShiftPath("live2d/" .. string.lower(arg_24_1), nil, true)

	return checkABExist(var_24_0), var_24_0
end

function NewSkinShowLayer:ExistSpineRes(arg_25_1)
	local var_25_0 = HXSet.autoHxShiftPath("SpinePainting/" .. string.lower(arg_25_1), nil, true)

	return checkABExist(var_25_0), var_25_0
end

function NewSkinShowLayer:FlushBG(arg_26_1)
	local var_26_0 = pg.ship_skin_template[self.skinId]
	local var_26_1

	if pg.ship_skin_template[self.skinId].skin_type == ShipSkin.SKIN_TYPE_TB then
		var_26_1 = VirtualEducateCharShip.New(NewEducateHelper.GetSecIdBySkinId(self.skinId))
	else
		local var_26_2 = {
			id = 999
		}

		var_26_2.configId = ShipGroup.getDefaultShipConfig(var_26_0.ship_group).id
		var_26_2.skin_id = self.skinId
		var_26_1 = Ship.New(var_26_2)
	end

	local var_26_3 = var_26_1:getShipBgPrint(true)

	if (self.isToggleShowBg or not checkABExist("painting/" .. pg.ship_skin_template[self.skinId].painting .. "_n")) and var_26_0.bg_sp ~= "" then
		var_26_3 = var_26_0.bg_sp
	end

	local var_26_4 = var_26_3 ~= var_26_1:rarity2bgPrintForGet()

	if var_26_4 then
		pg.DynamicBgMgr.GetInstance():LoadBg(self, var_26_3, self.bgs:Find("diffBg"), self.bgs:Find("diffBg/bg"), function(arg_27_0)
			if arg_26_1 then
				arg_26_1()
			end

			return
		end, function(arg_28_0)
			if arg_26_1 then
				arg_26_1()
			end

			return
		end)
	else
		pg.DynamicBgMgr.GetInstance():ClearBg(self:getUIName())

		if arg_26_1 then
			arg_26_1()
		end
	end

	setActive(self.bgs:Find("diffBg"), var_26_4)
	setActive(self.bgs:Find("default"), not var_26_4)

	return
end

function NewSkinShowLayer:FlushDynamicPaintingResState()
	if not self.isToggleDynamic then
		return
	end

	local var_29_0 = self:GetPaintingState()
	local var_29_1 = false
	local var_29_2 = ""

	if var_0_2 == var_29_0 then
		var_29_1, var_29_2 = self:ExistL2dRes(pg.ship_skin_template[self.skinId].painting)
	elseif var_0_3 == var_29_0 then
		var_29_1, var_29_2 = self:ExistSpineRes(pg.ship_skin_template[self.skinId].painting)
	end

	setActive(self.dynamicResToggle, not var_29_1)
	removeOnButton(self.dynamicResToggle)

	if not var_29_1 and var_29_2 ~= "" then
		onButton(self, self.dynamicResToggle, function()
			self:DownloadDynamicPainting(var_29_2)

			return
		end, SFX_PANEL)
	end

	return
end

function NewSkinShowLayer:DownloadDynamicPainting(arg_31_1)
	local var_31_0 = self.skinId

	if self.downloads[self.skinId] then
		return
	end

	local var_31_1 = SkinShopDownloadRequest.New()

	self.downloads[self.skinId] = var_31_1

	var_31_1:Start(arg_31_1, function(arg_32_0)
		if arg_32_0 and self.paintingState and self.paintingState.id == self.skinId then
			self:FlushPainting()
			self:FlushDynamicPaintingResState()
		end

		var_31_1:Dispose()

		self.downloads[var_31_0] = nil

		return
	end)

	return
end

function NewSkinShowLayer:RecordFlag(arg_33_1)
	PlayerPrefs.SetInt("skinShop#l2dPreViewToggle" .. getProxy(PlayerProxy):getRawData().id, arg_33_1 and 1 or 0)
	PlayerPrefs.Save()
	self:emit(LatestSkinShopMediator.ON_RECORD_ANIM_PREVIEW_BTN, arg_33_1)

	return
end

function NewSkinShowLayer:LoadMeshPainting(arg_34_1)
	local var_34_0 = findTF(self.paintingTF, "fitter")
	local var_34_1 = GetOrAddComponent(var_34_0, "PaintingScaler")

	var_34_1.FrameName = "chuanwu"
	var_34_1.Tween = 1

	local var_34_2 = pg.ship_skin_template[self.skinId].painting
	local var_34_3 = pg.ship_skin_template[self.skinId].painting

	if not arg_34_1 and checkABExist("painting/" .. var_34_2 .. "_n") then
		var_34_2 = var_34_2 .. "_n"
	end

	if not checkABExist("painting/" .. var_34_2) then
		return
	end

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetPainting(var_34_2, true, function(arg_35_0)
		pg.UIMgr.GetInstance():LoadingOff()
		setParent(arg_35_0, var_34_0, false)
		ShipExpressionHelper.SetExpression(var_34_0:GetChild(0), var_34_3)

		self.paintingName = var_34_2

		if self.paintingState and self.paintingState.id ~= self.skinId then
			self:ClearMeshPainting()
		end

		return
	end)

	return
end

function NewSkinShowLayer:ClearMeshPainting()
	local var_36_0 = self.paintingTF:Find("fitter")

	if self.paintingName and var_36_0.childCount > 0 then
		PoolMgr.GetInstance():ReturnPainting(self.paintingName, var_36_0:GetChild(0).gameObject)
	end

	self.paintingName = nil

	return
end

function NewSkinShowLayer:LoadL2dPainting()
	local var_37_0

	if pg.ship_skin_template[self.skinId].skin_type == ShipSkin.SKIN_TYPE_TB then
		var_37_0 = VirtualEducateCharShip.New(NewEducateHelper.GetSecIdBySkinId(self.skinId))
	else
		local var_37_1 = {
			noChangeSkin = true
		}

		var_37_1.configId = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[self.skinId].ship_group).id
		var_37_1.skin_id = self.skinId
		var_37_0 = Ship.New(var_37_1)
	end

	local var_37_2 = Live2DPainting.GenerateData({
		ship = var_37_0,
		position = Vector3(0, 0, -1),
		parent = self.live2dContainer,
		offset = var_37_0:GetSkinConfig().shop_offset
	})

	pg.UIMgr.GetInstance():LoadingOn()

	self.live2dChar = Live2DPainting.New(var_37_2, function(arg_38_0)
		arg_38_0:IgonreReactPos(true)

		if self.paintingState and self.paintingState.id ~= self.skinId then
			self:ClearL2dPainting()
		end

		arg_38_0:setSortingLayer(LayerWeightConst.L2D_DEFAULT_LAYER)
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	return
end

function NewSkinShowLayer:ClearL2dPainting()
	if self.live2dChar then
		self.live2dChar:Dispose()

		self.live2dChar = nil
	end

	return
end

function NewSkinShowLayer:LoadSpinePainting()
	local var_40_0

	if pg.ship_skin_template[self.skinId].skin_type == ShipSkin.SKIN_TYPE_TB then
		var_40_0 = VirtualEducateCharShip.New(NewEducateHelper.GetSecIdBySkinId(self.skinId))
	else
		local var_40_1 = {
			noChangeSkin = true
		}

		var_40_1.configId = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[self.skinId].ship_group).id
		var_40_1.skin_id = self.skinId
		var_40_0 = Ship.New(var_40_1)
	end

	local var_40_2 = SpinePainting.GenerateData({
		ship = var_40_0,
		position = Vector3(0, 0, 0),
		parent = self.spTF,
		effectParent = self.spBg,
		offset = var_40_0:GetSkinConfig().shop_offset
	})

	pg.UIMgr.GetInstance():LoadingOn()

	self.spinePainting = SpinePainting.New(var_40_2, function(arg_41_0)
		if self.paintingState and self.paintingState.id ~= self.skinId then
			self:ClearSpinePainting()
		end

		self:InitSpecialTouch(var_40_0, self.spTF)
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	return
end

function NewSkinShowLayer:ClearSpinePainting()
	if self.spinePainting and self.spinePainting._tf then
		local var_42_0 = self.spinePainting._tf:Find("shop_hx")

		self.spinePainting:Dispose()

		self.spinePainting = nil

		if self.dragEvent then
			ClearEventTrigger(self.dragEvent)
		end
	end

	return
end

function NewSkinShowLayer:InitSpecialTouch(arg_43_1, arg_43_2)
	local var_43_0 = arg_43_1:getPainting()
	local var_43_1 = findTF(arg_43_2:GetChild(0), "hitArea")

	if not var_43_1 then
		return
	end

	eachChild(var_43_1, function(arg_44_0)
		if self:getDragTouchAble(arg_44_0.name, var_43_0, false) then
			self.dragEvent = GetOrAddComponent(arg_44_0, typeof(EventTriggerListener))

			self.dragEvent:AddPointDownFunc(function(arg_45_0, arg_45_1)
				self.dragActive = true
				self.dragStart = arg_45_1.position

				return
			end)
			self.dragEvent:AddPointUpFunc(function(arg_46_0, arg_46_1)
				if self.dragActive then
					self.dragActive = false
					self.dragOffset = Vector2(self.dragStart.x - arg_46_1.position.x, self.dragStart.y - arg_46_1.position.y)

					if math.abs(self.dragOffset.x) < 200 or math.abs(self.dragOffset.y) < 200 then
						self.dragUp = arg_46_1.position

						if self.spinePainting:isInAction() then
							return
						end

						if self:getDragTouchAble(arg_44_0.name, var_43_0, true) then
							local var_46_1 = self.spinePainting:readyDragAction(arg_44_0.name)
						end
					end
				end

				return
			end)
			self.dragEvent:AddDragFunc(function(arg_47_0, arg_47_1)
				if self.dragActive then
					self.dragOffset = Vector2(self.dragStart.x - arg_47_1.position.x, self.dragStart.y - arg_47_1.position.y)

					if math.abs(self.dragOffset.x) > 200 or math.abs(self.dragOffset.y) > 200 then
						self.dragActive = false

						self.spinePainting:readyDragAction(arg_44_0.name)
					end
				end

				return
			end)
		else
			onButton(self, arg_44_0, function()
				if self.spinePainting:isInAction() then
					return
				end

				local var_48_0 = pg.AssistantInfo.getPaintingTouchEvents(arg_44_0.name)

				if self:getDragTouchAble(arg_44_0.name, var_43_0, true) then
					self.spinePainting:readyDragAction(arg_44_0.name)
				end

				return
			end)
		end

		return
	end)

	return
end

function NewSkinShowLayer:getDragTouchAble(arg_49_1, arg_49_2, arg_49_3)
	if not SpinePaintingConst.ship_drag_datas[arg_49_2] then
		return false
	end

	if SpinePaintingConst.ship_drag_datas[arg_49_2].drag_data and SpinePaintingConst.ship_drag_datas[arg_49_2].click_trigger ~= arg_49_3 then
		return false
	end

	if SpinePaintingConst.ship_drag_datas[arg_49_2].hit_area then
		return table.contains(SpinePaintingConst.ship_drag_datas[arg_49_2].hit_area, arg_49_1)
	end

	return false
end

function NewSkinShowLayer:AdjustPainting(arg_50_1)
	if pg.ship_skin_newmainui_shift[self.skinId] then
		local var_50_0 = pg.ship_skin_newmainui_shift[self.skinId].skin_shop_shift

		self.paintingTF.anchoredPosition = arg_50_1 and Vector2(var_50_0[1] - 440, var_50_0[2] + self.defaultPaintingPosition.y) or Vector2(var_50_0[1] + self.defaultPaintingPosition.x, var_50_0[2] + self.defaultPaintingPosition.y)
		self.paintingTF.localScale = Vector3(var_50_0[4], var_50_0[4], 1)
	else
		self.paintingTF.anchoredPosition = Vector2(self.defaultPaintingPosition.x, self.defaultPaintingPosition.y)
		self.paintingTF.localScale = self.defaultPaintingScale
	end

	return
end

function NewSkinShowLayer:ReturnChar()
	if not IsNil(self.spineChar) then
		self.spineChar.gameObject:GetComponent("SpineAnimUI"):SetActionCallBack(nil)
		PoolMgr.GetInstance():ReturnSpineChar(self.prefabName, self.spineChar.gameObject)

		self.spineChar = nil
		self.prefabName = nil
	end

	return
end

function NewSkinShowLayer:FlushTag()
	local var_52_0 = Clone(pg.ship_skin_template[self.skinId].tag)

	for iter_52_0 = #var_52_0, 1, -1 do
		if var_52_0[iter_52_0] == 1 or var_52_0[iter_52_0] == 6 or var_52_0[iter_52_0] == 7 or var_52_0[iter_52_0] == 9 then
			table.remove(var_52_0, iter_52_0)
		end
	end

	local var_52_3 = checkABExist("painting/" .. self.shipSkin:getConfig("painting") .. "_n")

	self.tagList:make(function(arg_53_0, arg_53_1, arg_53_2)
		if arg_53_0 == UIItemList.EventUpdate then
			LoadSpriteAtlasAsync("SkinIcon", "type_" .. ShipSkin.Tag2Name(var_52_0[arg_53_1 + 1]), function(arg_54_0)
				if self.exited then
					return
				end

				arg_53_2:GetComponent(typeof(Image)).sprite = arg_54_0

				return
			end)
		end

		return
	end)
	self.tagList:align(#var_52_0)

	return
end

function NewSkinShowLayer:ClearPainting()
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

function NewSkinShowLayer:IsShowSelectShipView()
	local var_56_0 = self.selectShipPage

	if self.selectShipPage then
		var_56_0 = self.selectShipPage:GetLoaded()
		var_56_0 = var_56_0 and self.selectShipPage:isShowing()
	end

	return var_56_0
end

function NewSkinShowLayer:CloseSelectShipView()
	self.selectShipPage:Hide()

	return
end

function NewSkinShowLayer:willExit()
	pg.DynamicBgMgr.GetInstance():ClearBg(self:getUIName())

	if self.live2dChar then
		self.live2dChar:Dispose()

		self.live2dChar = nil
	end

	for iter_58_0, iter_58_1 in pairs(self.downloads) do
		iter_58_1:Dispose()
	end

	self.downloads = {}

	self:ClearPainting()
	self:ReturnChar()
	self.selectShipPage:Destroy()

	self.selectShipPage = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function NewSkinShowLayer:onBackPressed()
	if self:IsShowSelectShipView() then
		self:CloseSelectShipView()

		return
	end

	NewSkinShowLayer.super.onBackPressed(self)

	return
end

return NewSkinShowLayer
