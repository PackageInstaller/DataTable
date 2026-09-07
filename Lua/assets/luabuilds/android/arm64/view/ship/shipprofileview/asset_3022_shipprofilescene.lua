local ShipProfileScene = class("ShipProfileScene", import("...base.BaseUI"))

ShipProfileScene.SHOW_SKILL_INFO = "event show skill info"
ShipProfileScene.SHOW_EVALUATION = "event show evalution"
ShipProfileScene.WEDDING_REVIEW = "event wedding review"
ShipProfileScene.INDEX_DETAIL = 1
ShipProfileScene.INDEX_PROFILE = 2
ShipProfileScene.CHAT_ANIMATION_TIME = 0.3
ShipProfileScene.CHAT_SHOW_TIME = 3

local var_0_1 = 0.35

function ShipProfileScene:getUIName()
	return "ShipProfileUI"
end

function ShipProfileScene:preload(arg_2_1)
	LoadSpriteAtlasAsync("bg/star_level_bg_" .. getProxy(CollectionProxy):getShipGroup(self.contextData.groupId):rarity2bgPrintForGet(self.showTrans), "", arg_2_1)

	return
end

function ShipProfileScene:setShipGroup(arg_3_1)
	self.shipGroup = arg_3_1
	self.groupSkinList = ShipGroup.GetDisplayableSkinList(arg_3_1.id)
	self.isBluePrintGroup = self.shipGroup:isBluePrintGroup()
	self.isMetaGroup = self.shipGroup:isMetaGroup()

	return
end

function ShipProfileScene:setShowTrans(arg_4_1)
	self.showTrans = arg_4_1

	return
end

function ShipProfileScene:setOwnedSkinList(arg_5_1)
	self.ownedSkinList = arg_5_1

	return
end

function ShipProfileScene:init()
	self.bg = self._tf:Find("bg")
	self.staticBg = self.bg:Find("static_bg")
	self.painting = self._tf:Find("paint")
	self.paintingFitter = findTF(self.painting, "fitter")
	self.paintingInitPos = self.painting.transform.localPosition
	self.chatTF = self._tf:Find("paint/chat")

	setActive(self.chatTF, false)

	self.commonPainting = self.painting:Find("fitter")
	self.l2dRoot = self.painting:Find("live2d")
	self.spinePaintingRoot = self.painting:Find("spinePainting")
	self.spinePaintingBgRoot = self._tf:Find("paintBg/spinePainting")
	self.chatBg = self.chatTF:Find("chatbgtop")
	self.initChatBgH = self.chatBg.sizeDelta.y
	self.chatText = self.chatBg:Find("Text")
	self.name = self._tf:Find("name")
	self.nameInitPos = self.name.transform.localPosition
	self.shipType = self.name:Find("type")
	self.labelName = self.name:Find("name_mask/Text"):GetComponent(typeof(Text))
	self.labelEnName = self.name:Find("english_name"):GetComponent(typeof(Text))
	self.stars = self.name:Find("stars")
	self.star = self:getTpl("star_tpl", self.stars)
	self.blurPanel = self._tf:Find("blur_panel")
	self.top = self._tf:Find("blur_panel/adapt/top")
	self.btnBack = self.top:Find("back")
	self.bottomTF = self._tf:Find("adapt/bottom")
	self.labelHeart = self.blurPanel:Find("adapt/detail_left_panel/heart/label")
	self.btnLike = self.blurPanel:Find("adapt/detail_left_panel/heart/btnLike")
	self.btnChangeSkin = self.blurPanel:Find("adapt/detail_left_panel/change_skin")
	self.changeSkinToggle = ChangeSkinToggle.New(findTF(self.btnChangeSkin, "toggle_ui"))
	self.btnLikeAct = self.btnLike:Find("like")
	self.btnLikeDisact = self.btnLike:Find("unlike")
	self.obtainBtn = self._tf:Find("adapt/bottom/others/obtain_btn")
	self.evaBtn = self._tf:Find("adapt/bottom/others/eva_btn")
	self.viewBtn = self._tf:Find("adapt/bottom/others/view_btn")
	self.shareBtn = self._tf:Find("adapt/bottom/others/share_btn")
	self.rotateBtn = self._tf:Find("adapt/bottom/others/rotate_btn")
	self.cryptolaliaBtn = self._tf:Find("adapt/bottom/others/cryptolalia_btn")
	self.equipCodeBtn = self._tf:Find("adapt/bottom/others/equip_code_btn")
	self.leftProfile = self.blurPanel:Find("adapt/profile_left_panel")
	self.modelContainer = self.leftProfile:Find("model")
	self.live2DBtn = ShipProfileLive2dBtn.New(self.blurPanel:Find("L2D_btn"))
	self.l2dBtnOn = false

	GetComponent(self.blurPanel:Find("L2D_btn"), typeof(Image)):SetNativeSize()
	GetComponent(self.blurPanel:Find("L2D_btn/img"), typeof(Image)):SetNativeSize()

	self.spinePaintingBtn = self.blurPanel:Find("SP_btn")

	GetComponent(self.spinePaintingBtn, typeof(Image)):SetNativeSize()
	GetComponent(self.blurPanel:Find("SP_btn/img"), typeof(Image)):SetNativeSize()
	GetComponent(self.blurPanel:Find("adapt/top/title"), typeof(Image)):SetNativeSize()

	self.spinePaintingToggle = self.spinePaintingBtn:Find("toggle")
	self.cvLoader = ShipProfileCVLoader.New()
	self.pageTFs = self._tf:Find("adapt/pages")
	self.paintingView = ShipProfilePaintingView.New(self._tf, self.painting)
	self.toggles = {
		self._tf:Find("adapt/bottom/detail"),
		self._tf:Find("adapt/bottom/profile")
	}

	local var_6_0 = ShipProfileInformationPage.New(self.pageTFs, self.event)

	var_6_0:SetCvLoader(self.cvLoader)
	var_6_0:SetCallback(function(arg_7_0)
		self:OnCVBtnClick(arg_7_0)

		return
	end)

	self.pages = {
		ShipProfileDetailPage.New(self.pageTFs, self.event),
		var_6_0
	}
	self.UISkinList = UIItemList.New(self.leftProfile:Find("scroll/Viewport/skin_container"), self.leftProfile:Find("scroll/Viewport/skin_container/skin_tpl"))

	return
end

function ShipProfileScene:didEnter()
	onButton(self, self.btnBack, function()
		self:emit(ShipProfileScene.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self.equipCodeBtn, function()
		self:emit(ShipProfileMediator.OPEN_EQUIP_CODE_SHARE, self.shipGroup.id)

		return
	end, SFX_PANEL)
	onButton(self, self.cryptolaliaBtn, function()
		self:emit(ShipProfileMediator.OPEN_CRYPTOLALIA, self.shipGroup.id)

		return
	end, SFX_PANEL)
	onButton(self, self.obtainBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_OBTAIN,
			shipId = self.shipGroup:getShipConfigId(),
			list = self.shipGroup.groupConfig.description,
			mediatorName = ShipProfileMediator.__cname
		})

		return
	end)
	onButton(self, self.evaBtn, function()
		self:emit(ShipProfileScene.SHOW_EVALUATION, self.shipGroup.id)

		return
	end, SFX_PANEL)
	onButton(self, self.viewBtn, function()
		if LeanTween.isTweening(self.chatTF.gameObject) then
			LeanTween.cancel(self.chatTF.gameObject)

			self.chatTF.localScale = Vector3(0, 0, 0)

			if self.dailogueCallback then
				self.dailogueCallback()

				self.dailogueCallback = nil
			end
		end

		self.paintingView:Start()

		return
	end, SFX_PANEL)
	onButton(self, self.shareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeShipProfile)

		return
	end, SFX_PANEL)
	onButton(self, self.rotateBtn, function()
		setActive(self._tf, false)
		setActive(self.blurPanel, false)
		self:emit(ShipProfileMediator.CLICK_ROTATE_BTN, self.shipGroup, self.showTrans, self.skin)

		return
	end, SFX_PANEL)
	self.live2DBtn:AddListener(function(arg_17_0)
		if arg_17_0 then
			self:CreateLive2D()
		else
			self:clearLive2dPainting()
		end

		self.l2dBtnOn = arg_17_0

		setActive(self.viewBtn, not arg_17_0)
		setActive(self.rotateBtn, not arg_17_0)
		setActive(self.commonPainting, not arg_17_0)
		setActive(self.l2dRoot, arg_17_0)
		self:StopDailogue()

		self.l2dActioning = nil

		if self.skin then
			self.pages[ShipProfileScene.INDEX_PROFILE]:ExecuteAction("Flush", self.skin, arg_17_0)
		end

		return
	end)

	for iter_8_0, iter_8_1 in ipairs(self.toggles) do
		onToggle(self, iter_8_1, function(arg_18_0)
			if iter_8_0 == ShipProfileScene.INDEX_DETAIL then
				self.live2DBtn:Update(self.paintingName, false)

				self.spinePaintingisOn = false

				self:updateSpinePaintingState()
				self:DisplaySpinePainting(false)
			end

			if arg_18_0 then
				self:SwitchPage(iter_8_0)
			end

			return
		end, SFX_PANEL)
	end

	self:InitCommon()
	self.live2DBtn:Update(self.paintingName, false)
	self:updateSpinePaintingState()
	onButton(self, self.btnChangeSkin, function()
		if ShipSkin.IsChangeSkin(self.skin.id) then
			self:showSkinProfile(self.contextData.skinIndex, pg.ship_skin_template[ShipSkin.GetChangeSkinNextId(self.skin.id)], self.prevSkinBtn)
		end

		return
	end, SFX_CONFIRM)
	setActive(self.bottomTF, false)
	triggerToggle(self.toggles[ShipProfileScene.INDEX_DETAIL], true)

	return
end

function ShipProfileScene:InitSkinList()
	self.skinBtns = {}

	self.UISkinList:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			local var_21_0 = self.groupSkinList[arg_21_1 + 1]
			local var_21_1 = ShipProfileSkinBtn.New(arg_21_2)

			table.insert(self.skinBtns, var_21_1)
			var_21_1:Update(var_21_0, self.shipGroup, table.contains(self.ownedSkinList, var_21_0.id))
			onButton(self, var_21_1._tf, function()
				if not var_21_1.unlock then
					pg.TipsMgr.GetInstance():ShowTips(i18n("ship_profile_skin_locked"))

					return
				end

				self:showSkinProfile(arg_21_1, var_21_0, var_21_1)

				return
			end, SFX_PANEL)
			setActive(arg_21_2, var_21_0.skin_type == ShipSkin.SKIN_TYPE_DEFAULT or not HXSet.isHxSkin())
		end

		return
	end)
	self.UISkinList:align(#self.groupSkinList)

	return
end

function ShipProfileScene:showSkinProfile(arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = ShipSkin.IsChangeSkin(arg_23_2.id)

	setActive(self.btnChangeSkin, var_23_0)

	if var_23_0 then
		self.changeSkinToggle:setSkinData(arg_23_2.id)
		setActive(self.btnChangeSkin, not self.changeSkinToggle:IsAsmrSkin())
	end

	self.contextData.skinIndex = arg_23_1 + 1

	self:ShiftSkin(arg_23_2)

	if self.prevSkinBtn then
		self.prevSkinBtn:UnShift()
	end

	arg_23_3:Shift()

	self.prevSkinBtn = arg_23_3

	return
end

function ShipProfileScene:InitCommon()
	self:LoadSkinBg(self.shipGroup:rarity2bgPrintForGet(self.showTrans))
	setImageSprite(self.shipType, GetSpriteFromAtlas("shiptype", self.shipGroup:getShipType(self.showTrans)))

	self.labelName.text = self.shipGroup:getName(self.showTrans)
	self.labelEnName.text = self.shipGroup.shipConfig.english_name

	for iter_24_0 = 1, pg.ship_data_template[self.shipGroup.shipConfig.id].star_max do
		cloneTplTo(self.star, self.stars)
	end

	self:FlushHearts()
	self:SetPainting(self.shipGroup:GetSkin(self.showTrans).id, self.showTrans)

	return
end

function ShipProfileScene:SetPainting(arg_25_1, arg_25_2)
	self:RecyclePainting()

	if arg_25_2 and self.shipGroup.trans then
		arg_25_1 = self.shipGroup.groupConfig.trans_skin
	end

	local var_25_0 = pg.ship_skin_template[arg_25_1].painting

	setPaintingPrefabAsync(self.painting, pg.ship_skin_template[arg_25_1].painting, "chuanwu", function()
		setActive(self.commonPainting, true)

		return
	end)

	self.paintingName = var_25_0

	self:UpdateCryptolaliaBtn(arg_25_1)

	return
end

function ShipProfileScene:RecyclePainting()
	if self.paintingName then
		retPaintingPrefab(self.painting, self.paintingName)
	end

	return
end

function ShipProfileScene:FlushHearts()
	setText(self.labelHeart, self.shipGroup.hearts > 999 and "999+" or self.shipGroup.hearts)

	self.labelHeart:GetComponent("Text").color = self.shipGroup.iheart and Color.New(1, 0.6, 0.6) or Color.New(1, 1, 1)

	setActive(self.btnLikeDisact, not self.shipGroup.iheart)
	setActive(self.btnLikeAct, self.shipGroup.iheart)

	return
end

function ShipProfileScene:LoadSkinBg(arg_29_1)
	self.bluePintBg = self.isBluePrintGroup and self.shipGroup:rarity2bgPrintForGet(self.showTrans)
	self.metaMainBg = self.isMetaGroup and self.shipGroup:rarity2bgPrintForGet(self.showTrans)

	if self.shipSkinBg ~= arg_29_1 then
		self.shipSkinBg = arg_29_1

		local function var_29_1()
			PoolMgr.GetInstance():GetUI("raritydesign" .. self.shipGroup:getRarity(self.showTrans), true, function(arg_32_0)
				self.designBg = arg_32_0
				self.designName = "raritydesign" .. self.shipGroup:getRarity(self.showTrans)

				arg_32_0.transform:SetParent(self.staticBg, false)

				arg_32_0.transform.localPosition = Vector3(1, 1, 1)
				arg_32_0.transform.localScale = Vector3(1, 1, 1)

				arg_32_0.transform:SetSiblingIndex(1)
				SetTFLayerOrder(arg_32_0.transform, LayerWeightConst.PAINTING_RARITY_DESIGN_LAYER)
				setActive(arg_32_0, true)

				return
			end)

			return
		end

		local function var_29_2()
			PoolMgr.GetInstance():GetUI("raritymeta" .. self.shipGroup:getRarity(self.showTrans), true, function(arg_34_0)
				self.metaBg = arg_34_0
				self.metaName = "raritymeta" .. self.shipGroup:getRarity(self.showTrans)

				arg_34_0.transform:SetParent(self.staticBg, false)

				arg_34_0.transform.localPosition = Vector3(1, 1, 1)
				arg_34_0.transform.localScale = Vector3(1, 1, 1)

				arg_34_0.transform:SetSiblingIndex(1)
				setActive(arg_34_0, true)

				return
			end)

			return
		end

		pg.DynamicBgMgr.GetInstance():LoadBg(self, arg_29_1, self.bg, self.staticBg, function(arg_30_0)
			rtf(arg_30_0).localPosition = Vector3(0, 0, 200)
			rtf(arg_30_0).anchorMin = Vector2.zero
			rtf(arg_30_0).anchorMax = Vector2.one
			rtf(arg_30_0).offsetMin = Vector2(0, 0)
			rtf(arg_30_0).offsetMax = Vector2(0, 0)

			return
		end, function(arg_35_0)
			if self.bluePintBg and arg_29_1 == self.bluePintBg then
				if self.metaBg then
					setActive(self.metaBg, false)
				end

				if self.designBg and self.designName ~= "raritydesign" .. self.shipGroup:getRarity(self.showTrans) then
					PoolMgr.GetInstance():ReturnUI(self.designName, self.designBg)

					self.designBg = nil
				end

				if not self.designBg then
					var_29_1()
				else
					setActive(self.designBg, true)
				end
			elseif self.metaMainBg and arg_29_1 == self.metaMainBg then
				if self.designBg then
					setActive(self.designBg, false)
				end

				if self.metaBg and self.metaName ~= "raritymeta" .. self.shipGroup:getRarity(self.showTrans) then
					PoolMgr.GetInstance():ReturnUI(self.metaName, self.metaBg)

					self.metaBg = nil
				end

				if not self.metaBg then
					var_29_2()
				else
					setActive(self.metaBg, true)
				end
			else
				if self.designBg then
					setActive(self.designBg, false)
				end

				if self.metaBg then
					setActive(self.metaBg, false)
				end
			end

			return
		end)
	end

	return
end

function ShipProfileScene:SwitchPage(arg_36_1)
	if self.index ~= arg_36_1 then
		seriesAsync({
			function(arg_37_0)
				self:OverlayPanel(self.blurPanel)
				arg_37_0()

				return
			end,
			function(arg_38_0)
				local var_38_0 = arg_36_1 == ShipProfileScene.INDEX_PROFILE and not self.pages[arg_36_1]:GetLoaded()

				self.pages[arg_36_1]:ExecuteAction("Update", self.shipGroup, self.showTrans, function()
					if var_38_0 then
						self:InitSkinList()
					end

					arg_38_0()

					return
				end)

				return
			end,
			function(arg_40_0)
				if not self.index then
					arg_40_0()

					return
				end

				self.pages[self.index]:ExecuteAction("ExistAnim", var_0_1)
				arg_40_0()

				return
			end,
			function(arg_41_0)
				SetParent(self.bottomTF, self.pages[arg_36_1]._tf)
				setActive(self.bottomTF, true)
				setAnchoredPosition(self.bottomTF, {
					z = 0,
					x = -7,
					y = 24
				})
				self.pages[arg_36_1]:ExecuteAction("EnterAnim", var_0_1)
				self:TweenPage(arg_36_1)
				arg_41_0()

				return
			end,
			function(arg_42_0)
				self.index = arg_36_1

				local var_42_0 = self.contextData.skinIndex or 1

				if arg_36_1 == ShipProfileScene.INDEX_PROFILE and var_42_0 <= #self.skinBtns then
					triggerButton(self.skinBtns[var_42_0]._tf)
				end

				return
			end
		})
	end

	return
end

function ShipProfileScene:TweenPage(arg_43_1)
	if arg_43_1 == ShipProfileScene.INDEX_DETAIL then
		LeanTween.moveX(rtf(self.leftProfile), -700, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveY(rtf(self.live2DBtn._tf), -70, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveY(rtf(self.spinePaintingBtn), -70, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveX(rtf(self.painting), self.paintingInitPos.x, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveX(rtf(self.name), self.nameInitPos.x, var_0_1):setEase(LeanTweenType.easeInOutSine)
	elseif arg_43_1 == ShipProfileScene.INDEX_PROFILE then
		LeanTween.moveX(rtf(self.leftProfile), 0, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveY(rtf(self.live2DBtn._tf), 60, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveY(rtf(self.spinePaintingBtn), 60, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveX(rtf(self.painting), self.paintingInitPos.x + 50, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveX(rtf(self.name), self.nameInitPos.x + 50, var_0_1):setEase(LeanTweenType.easeInOutSine)
	end

	return
end

function ShipProfileScene:ShiftSkin(arg_44_1)
	if self.index ~= ShipProfileScene.INDEX_PROFILE or self.skin and arg_44_1.id == self.skin.id then
		return
	end

	self.skin = arg_44_1

	self:SetPainting(arg_44_1.id, false)
	self:LoadModel(arg_44_1)
	self.live2DBtn:Disable()
	self.live2DBtn:Update(self.paintingName, false)
	LoadSpriteAtlasAsync("ui/share/btn_l2d_atlas", arg_44_1 and arg_44_1.spine_use_live2d == 1 and "spine_painting_bg" or "live2d_bg", function(arg_45_0)
		GetComponent(self.blurPanel:Find("L2D_btn"), typeof(Image)).sprite = arg_45_0
		GetComponent(self.blurPanel:Find("L2D_btn/img"), typeof(Image)).sprite = arg_45_0

		GetComponent(self.blurPanel:Find("L2D_btn"), typeof(Image)):SetNativeSize()
		GetComponent(self.blurPanel:Find("L2D_btn/img"), typeof(Image)):SetNativeSize()

		return
	end)

	self.spinePaintingisOn = false

	self:updateSpinePaintingState()
	self:DestroySpinePainting()
	self.pages[ShipProfileScene.INDEX_PROFILE]:ExecuteAction("Flush", arg_44_1, false)
	self:LoadSkinBg(self.skin.bg_sp and self.skin.bg_sp ~= "" and PlayerPrefs.GetInt("paint_hide_other_obj_" .. self.skin.painting, 0) == 0 and self.skin.bg_sp or self.skin.bg and self.skin.bg ~= "" and self.skin.bg or self.shipGroup:rarity2bgPrintForGet(self.showTrans, self.skin.id))

	self.haveOp = checkABExist("ui/skinunlockanim/star_level_unlock_anim_" .. self.skin.id)

	return
end

function ShipProfileScene:UpdateCryptolaliaBtn(arg_46_1)
	setActive(self.cryptolaliaBtn, getProxy(PlayerProxy):getRawData():ExistCryptolalia((ShipSkin.New({
		id = arg_46_1
	}):getConfig("ship_group"))))

	return
end

function ShipProfileScene:LoadModel(arg_47_1)
	if self.inLoading then
		return
	end

	self:ReturnModel()

	local var_47_0 = arg_47_1.prefab

	self.inLoading = true

	local var_47_1 = SpineAnimChar.New()

	var_47_1:SetPaint(arg_47_1.prefab)
	var_47_1:Load(true, function(arg_48_0)
		self.inLoading = false

		arg_48_0:SetName(var_47_0)
		arg_48_0:SetLocalPosition(Vector3.zero)
		arg_48_0:SetLocalScale(Vector3(0.8, 0.8, 1))
		arg_48_0:SetParent(self.modelContainer)
		arg_48_0:SetAction(arg_47_1.show_skin or "stand", 0)

		self.characterModel = arg_48_0
		self.modelName = var_47_0

		return
	end)

	return
end

function ShipProfileScene:ReturnModel()
	if self.characterModel then
		self.characterModel:Dispose()

		self.characterModel = nil
	end

	return
end

function ShipProfileScene:CreateLive2D()
	self.live2DBtn:SetEnable(false)

	if self.l2dChar then
		self.l2dChar:Dispose()

		self.l2dChar = nil
	end

	local var_50_0 = self.shipGroup:getShipConfigId()
	local var_50_1 = pg.ship_skin_template[self.skin.id].live2d_offset_profile

	self.l2dChar = Live2DPainting.New(Live2DPainting.GenerateData({
		ship = Ship.New({
			noChangeSkin = true,
			configId = var_50_0,
			skin_id = self.skin.id,
			propose = self.shipGroup.married
		}),
		position = Vector3(0, 0, 0),
		offset = var_50_1,
		parent = self.l2dRoot
	}), function(arg_51_0)
		arg_51_0:setSortingModeFrontZ()
		self.live2DBtn:SetEnable(true)

		return
	end)

	if isHalfBodyLive2D(self.skin.prefab) then
		setAnchoredPosition(self.l2dRoot, {
			y = -77 - (self.painting.rect.height - self.l2dRoot.rect.height * 1.5) / 2
		})
	else
		setAnchoredPosition(self.l2dRoot, {
			y = -40
		})
	end

	if Live2dConst.UnLoadL2dPating then
		Live2dConst.UnLoadL2dPating()
	end

	return
end

function ShipProfileScene:GetModelAction(arg_52_1)
	if not arg_52_1.spine_action or arg_52_1.spine_action == "" then
		return "stand"
	else
		return arg_52_1.spine_action
	end

	return
end

function ShipProfileScene:OnCVBtnClick(arg_53_1)
	if self.l2dActioning then
		return
	end

	local var_53_0 = arg_53_1.voice

	local function var_53_1()
		local var_54_0 = arg_53_1:isEx() and (self.l2dChar and self.l2dChar:checkActionExist(var_53_0.l2d_action .. "_ex") and var_53_0.l2d_action .. "_ex" or var_53_0.l2d_action) or var_53_0.l2d_action

		if self.l2dBtnOn and self.l2dChar and not self.l2dChar:enablePlayAction(var_54_0) then
			return
		end

		self:UpdatePaintingFace(arg_53_1)

		if self.characterModel then
			self.characterModel:SetAction(self:GetModelAction(var_53_0), 0)
		end

		local var_54_1 = {
			ShipProfileScene.CHAT_SHOW_TIME
		}

		if self.live2DBtn.isOn and self.l2dChar then
			if self.l2dChar:IsLoaded() then
				self.l2dActioning = true

				if not arg_53_1:L2dHasEvent() then
					parallelAsync({
						function(arg_55_0)
							self:RemoveLive2DTimer()

							self.l2dActioning = self.l2dChar:TriggerAction(var_54_0, arg_55_0)

							return
						end,
						function(arg_56_0)
							self:PlayVoice(arg_53_1, var_54_1)
							self:ShowDailogue(arg_53_1, var_54_1, arg_56_0)

							return
						end
					}, function()
						self.l2dActioning = false

						return
					end)
				else
					seriesAsync({
						function(arg_58_0)
							self:RemoveLive2DTimer()

							if self.l2dChar:checkActionProfile(var_54_0) then
								self.l2dActioning = self.l2dChar:TriggerAction(var_54_0, arg_58_0, nil, function(arg_59_0)
									self:PlayVoice(arg_53_1, var_54_1)
									self:ShowDailogue(arg_53_1, var_54_1, arg_58_0)

									return
								end)
							else
								self:PlayVoice(arg_53_1, var_54_1)
								self:ShowDailogue(arg_53_1, var_54_1, arg_58_0)
							end

							return
						end
					}, function()
						self.l2dActioning = false

						return
					end)
				end
			end
		else
			self:PlayVoice(arg_53_1, var_54_1)
			self:ShowDailogue(arg_53_1, var_54_1)
		end

		return
	end

	if arg_53_1.voice.key == "unlock" and self.haveOp then
		self:playOpening(var_53_1)
	elseif arg_53_1.voice.resource_key == "get" then
		if PaintingShowScene.GetSkinShowAble(arg_53_1.skin.id) then
			self:emit(ShipProfileMediator.OPEN_PAINTING_SHOW, arg_53_1.skin.id, function()
				onNextTick(function()
					var_53_1()

					return
				end)

				return
			end)
		else
			var_53_1()
		end
	else
		var_53_1()
	end

	return
end

function ShipProfileScene:UpdatePaintingFace(arg_63_1)
	local var_63_0 = arg_63_1.voice.key

	if arg_63_1.wordData.mainIndex ~= nil then
		var_63_0 = "main_" .. arg_63_1.wordData.mainIndex
	end

	if self.paintingFitter.childCount > 0 then
		ShipExpressionHelper.SetExpression(self.paintingFitter:GetChild(0), self.paintingName, var_63_0, arg_63_1.wordData.maxfavor, arg_63_1.skin.id)
	end

	if self.spinePainting then
		local var_63_1

		if pg.AssistantInfo.GetAssistantEventsByDialog(var_63_0) then
			var_63_1 = pg.AssistantInfo.GetAssistantEventsByDialog(var_63_0).action
		end

		local var_63_2 = ShipExpressionHelper.GetExpression(self.paintingName, var_63_0, arg_63_1.wordData.maxfavor, arg_63_1.skin.id)

		if var_63_2 ~= "" then
			self.spinePainting:SetAction(var_63_2, 1)

			if var_63_1 and self.spinePainting:getAnimationExist(var_63_1) then
				self.spinePainting:SetEmptyAction(1)
				self.spinePainting:SetOnceAction(var_63_1, nil, function()
					return
				end, true)
			elseif self.spinePainting:isInAction() then
				self.spinePainting:SetAction(self.spinePainting:getIdleName(), 0, true)
				self.spinePainting:ClearAction()
			end
		else
			self.spinePainting:SetEmptyAction(1)

			if var_63_1 and self.spinePainting:getAnimationExist(var_63_1) then
				self.spinePainting:SetOnceAction(var_63_1, nil, function()
					return
				end, true)
			elseif self.spinePainting:isInAction() then
				self.spinePainting:SetAction(self.spinePainting:getIdleName(), 0, true)
				self.spinePainting:ClearAction()
			end
		end
	end

	return
end

function ShipProfileScene:PlayVoice(arg_66_1, arg_66_2)
	self:RemoveCvTimer()

	if not arg_66_1.wordData.cvPath or arg_66_1.wordData.cvPath == "" then
		return
	end

	if arg_66_1.words.voice_key >= ShipWordHelper.CV_KEY_REPALCE or arg_66_1.words.voice_key_2 >= ShipWordHelper.CV_KEY_REPALCE or arg_66_1.words.voice_key == ShipWordHelper.CV_KEY_BAN_NEW then
		self.cvLoader:DelayPlaySound(arg_66_1.wordData.cvPath, (arg_66_1.isLive2d and self.l2dChar and arg_66_1.wordData.voiceCalibrate or nil) and arg_66_1.wordData.voiceCalibrate, function(arg_67_0)
			if arg_67_0 then
				arg_66_2[1] = long2int(arg_67_0.length) * 0.001
			end

			return
		end)
	end

	local var_66_2 = arg_66_1.wordData.se

	if arg_66_1.isLive2d and self.l2dChar and var_66_2 then
		self.cvLoader:RawPlaySound("event:/ui/" .. var_66_2[1], var_66_2[2])
	end

	return
end

function ShipProfileScene:RemoveCvSeTimer()
	if self.cvSeTimer then
		self.cvSeTimer:Stop()

		self.cvSeTimer = nil
	end

	return
end

function ShipProfileScene:RemoveCvTimer()
	if self.cvTimer then
		self.cvTimer:Stop()

		self.cvTimer = nil
	end

	return
end

function ShipProfileScene:RemoveLive2DTimer()
	if self.Live2DTimer then
		LeanTween.cancel(self.Live2DTimer)

		self.Live2DTimer = nil
	end

	return
end

function ShipProfileScene:ShowDailogue(arg_71_1, arg_71_2, arg_71_3)
	self.dailogueCallback = arg_71_3 or function()
		return
	end

	if not arg_71_1.wordData.textContent or arg_71_1.wordData.textContent == "" or arg_71_1.wordData.textContent == "nil" then
		if self.dailogueCallback then
			self.dailogueCallback()

			self.dailogueCallback = nil
		end

		return
	end

	local var_71_0 = arg_71_1.wordData.voiceCalibrate
	local var_71_1 = self.chatText:GetComponent(typeof(Text))

	setText(self.chatText, SwitchSpecialChar(arg_71_1.wordData.textContent))

	if #var_71_1.text > CHAT_POP_STR_LEN then
		var_71_1.alignment = TextAnchor.MiddleLeft or TextAnchor.MiddleCenter
	end

	self.chatBg.sizeDelta = var_71_1.preferredHeight + 120 > self.initChatBgH and Vector2.New(self.chatBg.sizeDelta.x, var_71_1.preferredHeight + 120) or Vector2.New(self.chatBg.sizeDelta.x, self.initChatBgH)

	self:StopDailogue()
	setActive(self.chatTF, true)
	LeanTween.scale(rtf(self.chatTF.gameObject), Vector3.New(1, 1, 1), ShipProfileScene.CHAT_ANIMATION_TIME):setEase(LeanTweenType.easeOutBack):setDelay(var_71_0 and var_71_0 or 0):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(self.chatTF.gameObject), Vector3.New(0, 0, 1), ShipProfileScene.CHAT_ANIMATION_TIME):setEase(LeanTweenType.easeInBack):setDelay(ShipProfileScene.CHAT_ANIMATION_TIME + arg_71_2[1]):setOnComplete(System.Action(function()
			if self.dailogueCallback then
				self.dailogueCallback()

				self.dailogueCallback = nil
			end

			if self.spinePainting then
				self.spinePainting:SetEmptyAction(1)
			end

			return
		end))

		return
	end))

	return
end

function ShipProfileScene:StopDailogue()
	LeanTween.cancel(self.chatTF.gameObject)

	self.chatTF.localScale = Vector3(0, 0)

	return
end

function ShipProfileScene:onBackPressed()
	if self.paintingView.isPreview then
		self.paintingView:Finish(true)

		return
	end

	triggerButton(self.btnBack)

	return
end

function ShipProfileScene:playOpening(arg_77_1)
	if checkABExist("ui/skinunlockanim/" .. "star_level_unlock_anim_" .. self.skin.id) then
		pg.CpkPlayMgr.GetInstance():PlayCpkMovie(function()
			return
		end, function()
			if arg_77_1 then
				arg_77_1()
			end

			return
		end, "ui/skinunlockanim", "star_level_unlock_anim_" .. self.skin.id, true, false)
	elseif arg_77_1 then
		arg_77_1()
	end

	return
end

function ShipProfileScene:updateSpinePaintingState()
	if checkABExist((HXSet.autoHxShiftPath("spinepainting/" .. self.paintingName))) then
		setActive(self.spinePaintingBtn, true)
		setActive(self.spinePaintingToggle:Find("on"), self.spinePaintingisOn)
		setActive(self.spinePaintingToggle:Find("off"), not self.spinePaintingisOn)
		removeOnButton(self.spinePaintingBtn)
		onButton(self, self.spinePaintingBtn, function()
			self.spinePaintingisOn = not self.spinePaintingisOn

			setActive(self.spinePaintingToggle:Find("on"), self.spinePaintingisOn)
			setActive(self.spinePaintingToggle:Find("off"), not self.spinePaintingisOn)

			if self.spinePaintingisOn then
				self:CreateSpinePainting()
			end

			setActive(self.viewBtn, not self.spinePaintingisOn)
			setActive(self.rotateBtn, not self.spinePaintingisOn)
			setActive(self.commonPainting, not self.spinePaintingisOn)
			setActive(self.spinePaintingRoot, self.spinePaintingisOn)
			setActive(self.spinePaintingBgRoot, self.spinePaintingisOn)
			self:StopDailogue()

			if self.skin then
				self.pages[ShipProfileScene.INDEX_PROFILE]:ExecuteAction("Flush", self.skin, false)
			end

			return
		end, SFX_PANEL)
	else
		setActive(self.spinePaintingBtn, false)
	end

	return
end

function ShipProfileScene:CreateSpinePainting()
	if self.skin.id ~= self.preSkinId then
		self:DestroySpinePainting()

		self.spinePainting = SpinePainting.New(SpinePainting.GenerateData({
			ship = Ship.New({
				noChangeSkin = true,
				configId = self.shipGroup:getShipConfigId(),
				skin_id = self.skin.id
			}),
			position = Vector3(0, 0, 0),
			parent = self.spinePaintingRoot,
			offset = pg.ship_skin_template[self.skin.id].spine_offset_profile,
			effectParent = self.spinePaintingBgRoot
		}), function()
			return
		end)
		self.preSkinId = self.skin.id
	end

	self:DisplaySpinePainting(true)

	return
end

function ShipProfileScene:clearLive2dPainting()
	if self.l2dChar then
		self.l2dChar:Dispose()

		self.l2dChar = nil
		self.l2dActioning = false
		self.cvLoader.prevCvPath = nil

		self:StopDailogue()
		self.cvLoader:StopSound()
	end

	return
end

function ShipProfileScene:DestroySpinePainting()
	if self.spinePainting then
		self.spinePainting:Dispose()

		self.spinePainting = nil
	end

	self.preSkinId = nil

	return
end

function ShipProfileScene:onWeddingReview(arg_86_1)
	if not arg_86_1 and self.exitLoadL2d then
		self.exitLoadL2d = false

		self.live2DBtn:Update(self.paintingName, true)
	else
		self.live2DBtn:Update(self.paintingName, false)
	end

	self.live2DBtn:SetEnable(not arg_86_1)

	if self.l2dChar and arg_86_1 then
		self.l2dChar:Dispose()

		self.l2dChar = nil
		self.l2dActioning = false
		self.cvLoader.prevCvPath = nil

		self:StopDailogue()
		self.cvLoader:StopSound()

		self.exitLoadL2d = true
	end

	if self.spinePaintingRoot.childCount > 0 then
		setActive(self.commonPainting, not self.spinePaintingisOn)
	end

	return
end

function ShipProfileScene:DisplaySpinePainting(arg_87_1)
	setActive(self.spinePaintingRoot, arg_87_1)
	setActive(self.spinePaintingBgRoot, arg_87_1)

	return
end

function ShipProfileScene:willExit()
	pg.CpkPlayMgr.GetInstance():DisposeCpkMovie()
	SetParent(self.bottomTF, self._tf)
	self:UnOverlayPanel(self.blurPanel, self._tf)

	for iter_88_0, iter_88_1 in ipairs(self.pages) do
		iter_88_1:Destroy()
	end

	if self.l2dChar then
		self.l2dChar:Dispose()

		self.l2dChar = nil
	end

	self:DestroySpinePainting()
	self.paintingView:Dispose()
	self.live2DBtn:Dispose()
	self.cvLoader:Dispose()
	self:ReturnModel()
	self:RecyclePainting()
	_.each(self.skinBtns or {}, function(arg_89_0)
		arg_89_0:Dispose()

		return
	end)
	self:RemoveCvTimer()
	self:RemoveCvSeTimer()
	self:RemoveLive2DTimer()

	return
end

return ShipProfileScene
