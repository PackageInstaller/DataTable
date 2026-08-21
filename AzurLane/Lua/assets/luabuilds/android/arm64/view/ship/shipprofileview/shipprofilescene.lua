local var_0_0 = class("ShipProfileScene", import("...base.BaseUI"))

var_0_0.SHOW_SKILL_INFO = "event show skill info"
var_0_0.SHOW_EVALUATION = "event show evalution"
var_0_0.WEDDING_REVIEW = "event wedding review"
var_0_0.INDEX_DETAIL = 1
var_0_0.INDEX_PROFILE = 2
var_0_0.CHAT_ANIMATION_TIME = 0.3
var_0_0.CHAT_SHOW_TIME = 3

local var_0_1 = 0.35

function var_0_0.getUIName(arg_1_0)
	return "ShipProfileUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	LoadSpriteAtlasAsync("bg/star_level_bg_" .. getProxy(CollectionProxy):getShipGroup(arg_2_0.contextData.groupId):rarity2bgPrintForGet(arg_2_0.showTrans), "", arg_2_1)

	return
end

function var_0_0.setShipGroup(arg_3_0, arg_3_1)
	arg_3_0.shipGroup = arg_3_1
	arg_3_0.groupSkinList = ShipGroup.GetDisplayableSkinList(arg_3_1.id)
	arg_3_0.isBluePrintGroup = arg_3_0.shipGroup:isBluePrintGroup()
	arg_3_0.isMetaGroup = arg_3_0.shipGroup:isMetaGroup()

	return
end

function var_0_0.setShowTrans(arg_4_0, arg_4_1)
	arg_4_0.showTrans = arg_4_1

	return
end

function var_0_0.setOwnedSkinList(arg_5_0, arg_5_1)
	arg_5_0.ownedSkinList = arg_5_1

	return
end

function var_0_0.init(arg_6_0)
	arg_6_0.bg = arg_6_0._tf:Find("bg")
	arg_6_0.staticBg = arg_6_0.bg:Find("static_bg")
	arg_6_0.painting = arg_6_0._tf:Find("paint")
	arg_6_0.paintingFitter = findTF(arg_6_0.painting, "fitter")
	arg_6_0.paintingInitPos = arg_6_0.painting.transform.localPosition
	arg_6_0.chatTF = arg_6_0._tf:Find("paint/chat")

	setActive(arg_6_0.chatTF, false)

	arg_6_0.commonPainting = arg_6_0.painting:Find("fitter")
	arg_6_0.l2dRoot = arg_6_0.painting:Find("live2d")
	arg_6_0.spinePaintingRoot = arg_6_0.painting:Find("spinePainting")
	arg_6_0.spinePaintingBgRoot = arg_6_0._tf:Find("paintBg/spinePainting")
	arg_6_0.chatBg = arg_6_0.chatTF:Find("chatbgtop")
	arg_6_0.initChatBgH = arg_6_0.chatBg.sizeDelta.y
	arg_6_0.chatText = arg_6_0.chatBg:Find("Text")
	arg_6_0.name = arg_6_0._tf:Find("name")
	arg_6_0.nameInitPos = arg_6_0.name.transform.localPosition
	arg_6_0.shipType = arg_6_0.name:Find("type")
	arg_6_0.labelName = arg_6_0.name:Find("name_mask/Text"):GetComponent(typeof(Text))
	arg_6_0.labelEnName = arg_6_0.name:Find("english_name"):GetComponent(typeof(Text))
	arg_6_0.stars = arg_6_0.name:Find("stars")
	arg_6_0.star = arg_6_0:getTpl("star_tpl", arg_6_0.stars)
	arg_6_0.blurPanel = arg_6_0._tf:Find("blur_panel")
	arg_6_0.top = arg_6_0._tf:Find("blur_panel/adapt/top")
	arg_6_0.btnBack = arg_6_0.top:Find("back")
	arg_6_0.bottomTF = arg_6_0._tf:Find("adapt/bottom")
	arg_6_0.labelHeart = arg_6_0.blurPanel:Find("adapt/detail_left_panel/heart/label")
	arg_6_0.btnLike = arg_6_0.blurPanel:Find("adapt/detail_left_panel/heart/btnLike")
	arg_6_0.btnChangeSkin = arg_6_0.blurPanel:Find("adapt/detail_left_panel/change_skin")
	arg_6_0.changeSkinToggle = ChangeSkinToggle.New(findTF(arg_6_0.btnChangeSkin, "toggle_ui"))
	arg_6_0.btnLikeAct = arg_6_0.btnLike:Find("like")
	arg_6_0.btnLikeDisact = arg_6_0.btnLike:Find("unlike")
	arg_6_0.obtainBtn = arg_6_0._tf:Find("adapt/bottom/others/obtain_btn")
	arg_6_0.evaBtn = arg_6_0._tf:Find("adapt/bottom/others/eva_btn")
	arg_6_0.viewBtn = arg_6_0._tf:Find("adapt/bottom/others/view_btn")
	arg_6_0.shareBtn = arg_6_0._tf:Find("adapt/bottom/others/share_btn")
	arg_6_0.rotateBtn = arg_6_0._tf:Find("adapt/bottom/others/rotate_btn")
	arg_6_0.cryptolaliaBtn = arg_6_0._tf:Find("adapt/bottom/others/cryptolalia_btn")
	arg_6_0.equipCodeBtn = arg_6_0._tf:Find("adapt/bottom/others/equip_code_btn")
	arg_6_0.leftProfile = arg_6_0.blurPanel:Find("adapt/profile_left_panel")
	arg_6_0.modelContainer = arg_6_0.leftProfile:Find("model")
	arg_6_0.live2DBtn = ShipProfileLive2dBtn.New(arg_6_0.blurPanel:Find("L2D_btn"))
	arg_6_0.l2dBtnOn = false

	GetComponent(arg_6_0.blurPanel:Find("L2D_btn"), typeof(Image)):SetNativeSize()
	GetComponent(arg_6_0.blurPanel:Find("L2D_btn/img"), typeof(Image)):SetNativeSize()

	arg_6_0.spinePaintingBtn = arg_6_0.blurPanel:Find("SP_btn")

	GetComponent(arg_6_0.spinePaintingBtn, typeof(Image)):SetNativeSize()
	GetComponent(arg_6_0.blurPanel:Find("SP_btn/img"), typeof(Image)):SetNativeSize()
	GetComponent(arg_6_0.blurPanel:Find("adapt/top/title"), typeof(Image)):SetNativeSize()

	arg_6_0.spinePaintingToggle = arg_6_0.spinePaintingBtn:Find("toggle")
	arg_6_0.cvLoader = ShipProfileCVLoader.New()
	arg_6_0.pageTFs = arg_6_0._tf:Find("adapt/pages")
	arg_6_0.paintingView = ShipProfilePaintingView.New(arg_6_0._tf, arg_6_0.painting)
	arg_6_0.toggles = {
		arg_6_0._tf:Find("adapt/bottom/detail"),
		arg_6_0._tf:Find("adapt/bottom/profile")
	}

	local var_6_0 = ShipProfileInformationPage.New(arg_6_0.pageTFs, arg_6_0.event)

	var_6_0:SetCvLoader(arg_6_0.cvLoader)
	var_6_0:SetCallback(function(arg_7_0)
		arg_6_0:OnCVBtnClick(arg_7_0)

		return
	end)

	arg_6_0.pages = {
		ShipProfileDetailPage.New(arg_6_0.pageTFs, arg_6_0.event),
		var_6_0
	}
	arg_6_0.UISkinList = UIItemList.New(arg_6_0.leftProfile:Find("scroll/Viewport/skin_container"), arg_6_0.leftProfile:Find("scroll/Viewport/skin_container/skin_tpl"))

	return
end

function var_0_0.didEnter(arg_8_0)
	onButton(arg_8_0, arg_8_0.btnBack, function()
		arg_8_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.equipCodeBtn, function()
		arg_8_0:emit(ShipProfileMediator.OPEN_EQUIP_CODE_SHARE, arg_8_0.shipGroup.id)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.cryptolaliaBtn, function()
		arg_8_0:emit(ShipProfileMediator.OPEN_CRYPTOLALIA, arg_8_0.shipGroup.id)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.obtainBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_OBTAIN,
			shipId = arg_8_0.shipGroup:getShipConfigId(),
			list = arg_8_0.shipGroup.groupConfig.description,
			mediatorName = ShipProfileMediator.__cname
		})

		return
	end)
	onButton(arg_8_0, arg_8_0.evaBtn, function()
		arg_8_0:emit(var_0_0.SHOW_EVALUATION, arg_8_0.shipGroup.id)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.viewBtn, function()
		if LeanTween.isTweening(arg_8_0.chatTF.gameObject) then
			LeanTween.cancel(arg_8_0.chatTF.gameObject)

			arg_8_0.chatTF.localScale = Vector3(0, 0, 0)

			if arg_8_0.dailogueCallback then
				arg_8_0.dailogueCallback()

				arg_8_0.dailogueCallback = nil
			end
		end

		arg_8_0.paintingView:Start()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.shareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeShipProfile)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.rotateBtn, function()
		setActive(arg_8_0._tf, false)
		setActive(arg_8_0.blurPanel, false)
		arg_8_0:emit(ShipProfileMediator.CLICK_ROTATE_BTN, arg_8_0.shipGroup, arg_8_0.showTrans, arg_8_0.skin)

		return
	end, SFX_PANEL)
	arg_8_0.live2DBtn:AddListener(function(arg_17_0)
		if arg_17_0 then
			arg_8_0:CreateLive2D()
		else
			arg_8_0:clearLive2dPainting()
		end

		arg_8_0.l2dBtnOn = arg_17_0

		setActive(arg_8_0.viewBtn, not arg_17_0)
		setActive(arg_8_0.rotateBtn, not arg_17_0)
		setActive(arg_8_0.commonPainting, not arg_17_0)
		setActive(arg_8_0.l2dRoot, arg_17_0)
		arg_8_0:StopDailogue()

		arg_8_0.l2dActioning = nil

		if arg_8_0.skin then
			arg_8_0.pages[var_0_0.INDEX_PROFILE]:ExecuteAction("Flush", arg_8_0.skin, arg_17_0)
		end

		return
	end)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.toggles) do
		onToggle(arg_8_0, iter_8_1, function(arg_18_0)
			if iter_8_0 == var_0_0.INDEX_DETAIL then
				arg_8_0.live2DBtn:Update(arg_8_0.paintingName, false)

				arg_8_0.spinePaintingisOn = false

				arg_8_0:updateSpinePaintingState()
				arg_8_0:DisplaySpinePainting(false)
			end

			if arg_18_0 then
				arg_8_0:SwitchPage(iter_8_0)
			end

			return
		end, SFX_PANEL)
	end

	arg_8_0:InitCommon()
	arg_8_0.live2DBtn:Update(arg_8_0.paintingName, false)
	arg_8_0:updateSpinePaintingState()
	onButton(arg_8_0, arg_8_0.btnChangeSkin, function()
		if ShipSkin.IsChangeSkin(arg_8_0.skin.id) then
			arg_8_0:showSkinProfile(arg_8_0.contextData.skinIndex, pg.ship_skin_template[ShipSkin.GetChangeSkinNextId(arg_8_0.skin.id)], arg_8_0.prevSkinBtn)
		end

		return
	end, SFX_CONFIRM)
	setActive(arg_8_0.bottomTF, false)
	triggerToggle(arg_8_0.toggles[var_0_0.INDEX_DETAIL], true)

	return
end

function var_0_0.InitSkinList(arg_20_0)
	arg_20_0.skinBtns = {}

	arg_20_0.UISkinList:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			local var_21_0 = arg_20_0.groupSkinList[arg_21_1 + 1]
			local var_21_1 = ShipProfileSkinBtn.New(arg_21_2)

			table.insert(arg_20_0.skinBtns, var_21_1)
			var_21_1:Update(var_21_0, arg_20_0.shipGroup, table.contains(arg_20_0.ownedSkinList, var_21_0.id))
			onButton(arg_20_0, var_21_1._tf, function()
				if not var_21_1.unlock then
					pg.TipsMgr.GetInstance():ShowTips(i18n("ship_profile_skin_locked"))

					return
				end

				arg_20_0:showSkinProfile(arg_21_1, var_21_0, var_21_1)

				return
			end, SFX_PANEL)
			setActive(arg_21_2, var_21_0.skin_type == ShipSkin.SKIN_TYPE_DEFAULT or not HXSet.isHxSkin())
		end

		return
	end)
	arg_20_0.UISkinList:align(#arg_20_0.groupSkinList)

	return
end

function var_0_0.showSkinProfile(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = ShipSkin.IsChangeSkin(arg_23_2.id)

	setActive(arg_23_0.btnChangeSkin, var_23_0)

	if var_23_0 then
		arg_23_0.changeSkinToggle:setSkinData(arg_23_2.id)
		setActive(arg_23_0.btnChangeSkin, not arg_23_0.changeSkinToggle:IsAsmrSkin())
	end

	arg_23_0.contextData.skinIndex = arg_23_1 + 1

	arg_23_0:ShiftSkin(arg_23_2)

	if arg_23_0.prevSkinBtn then
		arg_23_0.prevSkinBtn:UnShift()
	end

	arg_23_3:Shift()

	arg_23_0.prevSkinBtn = arg_23_3

	return
end

function var_0_0.InitCommon(arg_24_0)
	arg_24_0:LoadSkinBg(arg_24_0.shipGroup:rarity2bgPrintForGet(arg_24_0.showTrans))
	setImageSprite(arg_24_0.shipType, GetSpriteFromAtlas("shiptype", arg_24_0.shipGroup:getShipType(arg_24_0.showTrans)))

	arg_24_0.labelName.text = arg_24_0.shipGroup:getName(arg_24_0.showTrans)
	arg_24_0.labelEnName.text = arg_24_0.shipGroup.shipConfig.english_name

	for iter_24_0 = 1, pg.ship_data_template[arg_24_0.shipGroup.shipConfig.id].star_max do
		cloneTplTo(arg_24_0.star, arg_24_0.stars)
	end

	arg_24_0:FlushHearts()
	arg_24_0:SetPainting(arg_24_0.shipGroup:GetSkin(arg_24_0.showTrans).id, arg_24_0.showTrans)

	return
end

function var_0_0.SetPainting(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:RecyclePainting()

	if arg_25_2 and arg_25_0.shipGroup.trans then
		arg_25_1 = arg_25_0.shipGroup.groupConfig.trans_skin
	end

	local var_25_0 = pg.ship_skin_template[arg_25_1].painting

	setPaintingPrefabAsync(arg_25_0.painting, pg.ship_skin_template[arg_25_1].painting, "chuanwu", function()
		setActive(arg_25_0.commonPainting, true)

		return
	end)

	arg_25_0.paintingName = var_25_0

	arg_25_0:UpdateCryptolaliaBtn(arg_25_1)

	return
end

function var_0_0.RecyclePainting(arg_27_0)
	if arg_27_0.paintingName then
		retPaintingPrefab(arg_27_0.painting, arg_27_0.paintingName)
	end

	return
end

function var_0_0.FlushHearts(arg_28_0)
	local var_28_0 = arg_28_0.shipGroup.hearts

	setText(arg_28_0.labelHeart, arg_28_0.shipGroup.hearts > 999 and "999+" or var_28_0)

	local var_28_1 = arg_28_0.labelHeart:GetComponent("Text")

	var_28_1.color = arg_28_0.shipGroup.iheart and Color.New(1, 0.6, 0.6) or Color.New(1, 1, 1)

	setActive(arg_28_0.btnLikeDisact, not arg_28_0.shipGroup.iheart)
	setActive(arg_28_0.btnLikeAct, arg_28_0.shipGroup.iheart)

	return
end

function var_0_0.LoadSkinBg(arg_29_0, arg_29_1)
	arg_29_0.bluePintBg = arg_29_0.isBluePrintGroup and arg_29_0.shipGroup:rarity2bgPrintForGet(arg_29_0.showTrans)
	arg_29_0.metaMainBg = arg_29_0.isMetaGroup and arg_29_0.shipGroup:rarity2bgPrintForGet(arg_29_0.showTrans)

	if arg_29_0.shipSkinBg ~= arg_29_1 then
		arg_29_0.shipSkinBg = arg_29_1

		local function var_29_1()
			PoolMgr.GetInstance():GetUI("raritydesign" .. arg_29_0.shipGroup:getRarity(arg_29_0.showTrans), true, function(arg_32_0)
				arg_29_0.designBg = arg_32_0
				arg_29_0.designName = "raritydesign" .. arg_29_0.shipGroup:getRarity(arg_29_0.showTrans)

				arg_32_0.transform:SetParent(arg_29_0.staticBg, false)

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
			PoolMgr.GetInstance():GetUI("raritymeta" .. arg_29_0.shipGroup:getRarity(arg_29_0.showTrans), true, function(arg_34_0)
				arg_29_0.metaBg = arg_34_0
				arg_29_0.metaName = "raritymeta" .. arg_29_0.shipGroup:getRarity(arg_29_0.showTrans)

				arg_34_0.transform:SetParent(arg_29_0.staticBg, false)

				arg_34_0.transform.localPosition = Vector3(1, 1, 1)
				arg_34_0.transform.localScale = Vector3(1, 1, 1)

				arg_34_0.transform:SetSiblingIndex(1)
				setActive(arg_34_0, true)

				return
			end)

			return
		end

		pg.DynamicBgMgr.GetInstance():LoadBg(arg_29_0, arg_29_1, arg_29_0.bg, arg_29_0.staticBg, function(arg_30_0)
			rtf(arg_30_0).localPosition = Vector3(0, 0, 200)
			rtf(arg_30_0).anchorMin = Vector2.zero
			rtf(arg_30_0).anchorMax = Vector2.one
			rtf(arg_30_0).offsetMin = Vector2(0, 0)
			rtf(arg_30_0).offsetMax = Vector2(0, 0)

			return
		end, function(arg_35_0)
			if arg_29_0.bluePintBg and arg_29_1 == arg_29_0.bluePintBg then
				if arg_29_0.metaBg then
					setActive(arg_29_0.metaBg, false)
				end

				if arg_29_0.designBg and arg_29_0.designName ~= "raritydesign" .. arg_29_0.shipGroup:getRarity(arg_29_0.showTrans) then
					PoolMgr.GetInstance():ReturnUI(arg_29_0.designName, arg_29_0.designBg)

					arg_29_0.designBg = nil
				end

				if not arg_29_0.designBg then
					var_29_1()
				else
					setActive(arg_29_0.designBg, true)
				end
			elseif arg_29_0.metaMainBg and arg_29_1 == arg_29_0.metaMainBg then
				if arg_29_0.designBg then
					setActive(arg_29_0.designBg, false)
				end

				if arg_29_0.metaBg and arg_29_0.metaName ~= "raritymeta" .. arg_29_0.shipGroup:getRarity(arg_29_0.showTrans) then
					PoolMgr.GetInstance():ReturnUI(arg_29_0.metaName, arg_29_0.metaBg)

					arg_29_0.metaBg = nil
				end

				if not arg_29_0.metaBg then
					var_29_2()
				else
					setActive(arg_29_0.metaBg, true)
				end
			else
				if arg_29_0.designBg then
					setActive(arg_29_0.designBg, false)
				end

				if arg_29_0.metaBg then
					setActive(arg_29_0.metaBg, false)
				end
			end

			return
		end)
	end

	return
end

function var_0_0.SwitchPage(arg_36_0, arg_36_1)
	if arg_36_0.index ~= arg_36_1 then
		seriesAsync({
			function(arg_37_0)
				arg_36_0:OverlayPanel(arg_36_0.blurPanel)
				arg_37_0()

				return
			end,
			function(arg_38_0)
				local var_38_1 = arg_36_1 == var_0_0.INDEX_PROFILE and not var_38_0:GetLoaded()

				arg_36_0.pages[arg_36_1]:ExecuteAction("Update", arg_36_0.shipGroup, arg_36_0.showTrans, function()
					if var_38_1 then
						arg_36_0:InitSkinList()
					end

					arg_38_0()

					return
				end)

				return
			end,
			function(arg_40_0)
				if not arg_36_0.index then
					arg_40_0()

					return
				end

				arg_36_0.pages[arg_36_0.index]:ExecuteAction("ExistAnim", var_0_1)
				arg_40_0()

				return
			end,
			function(arg_41_0)
				SetParent(arg_36_0.bottomTF, arg_36_0.pages[arg_36_1]._tf)
				setActive(arg_36_0.bottomTF, true)
				setAnchoredPosition(arg_36_0.bottomTF, {
					z = 0,
					x = -7,
					y = 24
				})
				arg_36_0.pages[arg_36_1]:ExecuteAction("EnterAnim", var_0_1)
				arg_36_0:TweenPage(arg_36_1)
				arg_41_0()

				return
			end,
			function(arg_42_0)
				arg_36_0.index = arg_36_1

				local var_42_0 = arg_36_0.contextData.skinIndex or 1

				if arg_36_1 == var_0_0.INDEX_PROFILE and var_42_0 <= #arg_36_0.skinBtns then
					triggerButton(arg_36_0.skinBtns[var_42_0]._tf)
				end

				return
			end
		})
	end

	return
end

function var_0_0.TweenPage(arg_43_0, arg_43_1)
	if arg_43_1 == var_0_0.INDEX_DETAIL then
		LeanTween.moveX(rtf(arg_43_0.leftProfile), -700, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveY(rtf(arg_43_0.live2DBtn._tf), -70, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveY(rtf(arg_43_0.spinePaintingBtn), -70, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveX(rtf(arg_43_0.painting), arg_43_0.paintingInitPos.x, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveX(rtf(arg_43_0.name), arg_43_0.nameInitPos.x, var_0_1):setEase(LeanTweenType.easeInOutSine)
	elseif arg_43_1 == var_0_0.INDEX_PROFILE then
		LeanTween.moveX(rtf(arg_43_0.leftProfile), 0, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveY(rtf(arg_43_0.live2DBtn._tf), 60, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveY(rtf(arg_43_0.spinePaintingBtn), 60, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveX(rtf(arg_43_0.painting), arg_43_0.paintingInitPos.x + 50, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveX(rtf(arg_43_0.name), arg_43_0.nameInitPos.x + 50, var_0_1):setEase(LeanTweenType.easeInOutSine)
	end

	return
end

function var_0_0.ShiftSkin(arg_44_0, arg_44_1)
	if arg_44_0.index ~= var_0_0.INDEX_PROFILE or arg_44_0.skin and arg_44_1.id == arg_44_0.skin.id then
		return
	end

	arg_44_0.skin = arg_44_1

	arg_44_0:SetPainting(arg_44_1.id, false)
	arg_44_0:LoadModel(arg_44_1)
	arg_44_0.live2DBtn:Disable()
	arg_44_0.live2DBtn:Update(arg_44_0.paintingName, false)
	LoadSpriteAtlasAsync("ui/share/btn_l2d_atlas", arg_44_1 and arg_44_1.spine_use_live2d == 1 and "spine_painting_bg" or "live2d_bg", function(arg_45_0)
		GetComponent(arg_44_0.blurPanel:Find("L2D_btn"), typeof(Image)).sprite = arg_45_0
		GetComponent(arg_44_0.blurPanel:Find("L2D_btn/img"), typeof(Image)).sprite = arg_45_0

		GetComponent(arg_44_0.blurPanel:Find("L2D_btn"), typeof(Image)):SetNativeSize()
		GetComponent(arg_44_0.blurPanel:Find("L2D_btn/img"), typeof(Image)):SetNativeSize()

		return
	end)

	arg_44_0.spinePaintingisOn = false

	arg_44_0:updateSpinePaintingState()
	arg_44_0:DestroySpinePainting()
	arg_44_0.pages[var_0_0.INDEX_PROFILE]:ExecuteAction("Flush", arg_44_1, false)

	local var_44_1
	local var_44_2 = PlayerPrefs.GetInt("paint_hide_other_obj_" .. arg_44_0.skin.painting, 0) == 0

	var_44_1 = arg_44_0.skin.bg_sp and arg_44_0.skin.bg_sp ~= "" and var_44_2 and arg_44_0.skin.bg_sp or arg_44_0.skin.bg and arg_44_0.skin.bg ~= "" and arg_44_0.skin.bg or arg_44_0.shipGroup:rarity2bgPrintForGet(arg_44_0.showTrans, arg_44_0.skin.id)

	arg_44_0:LoadSkinBg(var_44_1)

	arg_44_0.haveOp = checkABExist("ui/skinunlockanim/star_level_unlock_anim_" .. arg_44_0.skin.id)

	return
end

function var_0_0.UpdateCryptolaliaBtn(arg_46_0, arg_46_1)
	setActive(arg_46_0.cryptolaliaBtn, getProxy(PlayerProxy):getRawData():ExistCryptolalia((ShipSkin.New({
		id = arg_46_1
	}):getConfig("ship_group"))))

	return
end

function var_0_0.LoadModel(arg_47_0, arg_47_1)
	if arg_47_0.inLoading then
		return
	end

	arg_47_0:ReturnModel()

	local var_47_0 = arg_47_1.prefab

	arg_47_0.inLoading = true

	local var_47_1 = SpineAnimChar.New()

	var_47_1:SetPaint(arg_47_1.prefab)
	var_47_1:Load(true, function(arg_48_0)
		arg_47_0.inLoading = false

		arg_48_0:SetName(var_47_0)
		arg_48_0:SetLocalPosition(Vector3.zero)
		arg_48_0:SetLocalScale(Vector3(0.8, 0.8, 1))
		arg_48_0:SetParent(arg_47_0.modelContainer)

		local var_48_0 = arg_47_1.show_skin or "stand"

		arg_48_0:SetAction(var_48_0, 0)

		arg_47_0.characterModel = arg_48_0
		arg_47_0.modelName = var_47_0

		return
	end)

	return
end

function var_0_0.ReturnModel(arg_49_0)
	if arg_49_0.characterModel then
		arg_49_0.characterModel:Dispose()

		arg_49_0.characterModel = nil
	end

	return
end

function var_0_0.CreateLive2D(arg_50_0)
	arg_50_0.live2DBtn:SetEnable(false)

	if arg_50_0.l2dChar then
		arg_50_0.l2dChar:Dispose()

		arg_50_0.l2dChar = nil
	end

	local var_50_0 = arg_50_0.shipGroup:getShipConfigId()
	local var_50_1 = pg.ship_skin_template[arg_50_0.skin.id].live2d_offset_profile

	if pg.ship_skin_template[arg_50_0.skin.id].live2d_offset_profile and #var_50_1 >= 3 then
		-- block empty
	else
		-- block empty
	end

	arg_50_0.l2dChar = Live2DPainting.New(Live2DPainting.GenerateData({
		ship = Ship.New({
			noChangeSkin = true,
			configId = var_50_0,
			skin_id = arg_50_0.skin.id,
			propose = arg_50_0.shipGroup.married
		}),
		position = Vector3(0, 0, 0),
		offset = var_50_1,
		parent = arg_50_0.l2dRoot
	}), function(arg_51_0)
		arg_51_0:setSortingModeFrontZ()
		arg_50_0.live2DBtn:SetEnable(true)

		return
	end)

	if isHalfBodyLive2D(arg_50_0.skin.prefab) then
		setAnchoredPosition(arg_50_0.l2dRoot, {
			y = -77 - (arg_50_0.painting.rect.height - arg_50_0.l2dRoot.rect.height * 1.5) / 2
		})
	else
		setAnchoredPosition(arg_50_0.l2dRoot, {
			y = -40
		})
	end

	if Live2dConst.UnLoadL2dPating then
		Live2dConst.UnLoadL2dPating()
	end

	return
end

function var_0_0.GetModelAction(arg_52_0, arg_52_1)
	if not arg_52_1.spine_action or arg_52_1.spine_action == "" then
		return "stand"
	else
		return arg_52_1.spine_action
	end

	return
end

function var_0_0.OnCVBtnClick(arg_53_0, arg_53_1)
	local var_53_0

	if arg_53_0.l2dActioning then
		do return end

		function var_53_0()
			local var_54_0 = arg_53_1:isEx() and (arg_53_0.l2dChar and arg_53_0.l2dChar:checkActionExist(var_0.l2d_action .. "_ex") and var_0.l2d_action .. "_ex" or var_0.l2d_action) or var_0.l2d_action

			if arg_53_0.l2dBtnOn and arg_53_0.l2dChar and not arg_53_0.l2dChar:enablePlayAction(var_54_0) then
				return
			end

			arg_53_0:UpdatePaintingFace(arg_53_1)

			if arg_53_0.characterModel then
				arg_53_0.characterModel:SetAction(arg_53_0:GetModelAction(var_0), 0)
			end

			local var_54_1 = {
				var_0_0.CHAT_SHOW_TIME
			}

			if arg_53_0.live2DBtn.isOn and arg_53_0.l2dChar then
				if arg_53_0.l2dChar:IsLoaded() then
					arg_53_0.l2dActioning = true

					if not arg_53_1:L2dHasEvent() then
						parallelAsync({
							function(arg_55_0)
								arg_53_0:RemoveLive2DTimer()

								arg_53_0.l2dActioning = arg_53_0.l2dChar:TriggerAction(var_54_0, arg_55_0)

								return
							end,
							function(arg_56_0)
								arg_53_0:PlayVoice(arg_53_1, var_54_1)
								arg_53_0:ShowDailogue(arg_53_1, var_54_1, arg_56_0)

								return
							end
						}, function()
							arg_53_0.l2dActioning = false

							return
						end)
					else
						seriesAsync({
							function(arg_58_0)
								arg_53_0:RemoveLive2DTimer()

								if arg_53_0.l2dChar:checkActionProfile(var_54_0) then
									arg_53_0.l2dActioning = arg_53_0.l2dChar:TriggerAction(var_54_0, arg_58_0, nil, function(arg_59_0)
										arg_53_0:PlayVoice(arg_53_1, var_54_1)
										arg_53_0:ShowDailogue(arg_53_1, var_54_1, arg_58_0)

										return
									end)
								else
									arg_53_0:PlayVoice(arg_53_1, var_54_1)
									arg_53_0:ShowDailogue(arg_53_1, var_54_1, arg_58_0)
								end

								return
							end
						}, function()
							arg_53_0.l2dActioning = false

							return
						end)
					end
				end
			else
				arg_53_0:PlayVoice(arg_53_1, var_54_1)
				arg_53_0:ShowDailogue(arg_53_1, var_54_1)
			end

			return
		end
	end

	if arg_53_1.voice.key == "unlock" and arg_53_0.haveOp then
		arg_53_0:playOpening(function()
			local var_54_0 = arg_53_1:isEx() and (arg_53_0.l2dChar and arg_53_0.l2dChar:checkActionExist(var_0.l2d_action .. "_ex") and var_0.l2d_action .. "_ex" or var_0.l2d_action) or var_0.l2d_action

			if arg_53_0.l2dBtnOn and arg_53_0.l2dChar and not arg_53_0.l2dChar:enablePlayAction(var_54_0) then
				return
			end

			arg_53_0:UpdatePaintingFace(arg_53_1)

			if arg_53_0.characterModel then
				arg_53_0.characterModel:SetAction(arg_53_0:GetModelAction(var_0), 0)
			end

			local var_54_1 = {
				var_0_0.CHAT_SHOW_TIME
			}

			if arg_53_0.live2DBtn.isOn and arg_53_0.l2dChar then
				if arg_53_0.l2dChar:IsLoaded() then
					arg_53_0.l2dActioning = true

					if not arg_53_1:L2dHasEvent() then
						parallelAsync({
							function(arg_55_0)
								arg_53_0:RemoveLive2DTimer()

								arg_53_0.l2dActioning = arg_53_0.l2dChar:TriggerAction(var_54_0, arg_55_0)

								return
							end,
							function(arg_56_0)
								arg_53_0:PlayVoice(arg_53_1, var_54_1)
								arg_53_0:ShowDailogue(arg_53_1, var_54_1, arg_56_0)

								return
							end
						}, function()
							arg_53_0.l2dActioning = false

							return
						end)
					else
						seriesAsync({
							function(arg_58_0)
								arg_53_0:RemoveLive2DTimer()

								if arg_53_0.l2dChar:checkActionProfile(var_54_0) then
									arg_53_0.l2dActioning = arg_53_0.l2dChar:TriggerAction(var_54_0, arg_58_0, nil, function(arg_59_0)
										arg_53_0:PlayVoice(arg_53_1, var_54_1)
										arg_53_0:ShowDailogue(arg_53_1, var_54_1, arg_58_0)

										return
									end)
								else
									arg_53_0:PlayVoice(arg_53_1, var_54_1)
									arg_53_0:ShowDailogue(arg_53_1, var_54_1, arg_58_0)
								end

								return
							end
						}, function()
							arg_53_0.l2dActioning = false

							return
						end)
					end
				end
			else
				arg_53_0:PlayVoice(arg_53_1, var_54_1)
				arg_53_0:ShowDailogue(arg_53_1, var_54_1)
			end

			return
		end)
	elseif arg_53_1.voice.resource_key == "get" then
		if PaintingShowScene.GetSkinShowAble(arg_53_1.skin.id) then
			arg_53_0:emit(ShipProfileMediator.OPEN_PAINTING_SHOW, arg_53_1.skin.id, function()
				onNextTick(function()
					var_53_0()

					return
				end)

				return
			end)
		else
			(function()
				local var_54_0 = arg_53_1:isEx() and (arg_53_0.l2dChar and arg_53_0.l2dChar:checkActionExist(var_0.l2d_action .. "_ex") and var_0.l2d_action .. "_ex" or var_0.l2d_action) or var_0.l2d_action

				if arg_53_0.l2dBtnOn and arg_53_0.l2dChar and not arg_53_0.l2dChar:enablePlayAction(var_54_0) then
					return
				end

				arg_53_0:UpdatePaintingFace(arg_53_1)

				if arg_53_0.characterModel then
					arg_53_0.characterModel:SetAction(arg_53_0:GetModelAction(var_0), 0)
				end

				local var_54_1 = {
					var_0_0.CHAT_SHOW_TIME
				}

				if arg_53_0.live2DBtn.isOn and arg_53_0.l2dChar then
					if arg_53_0.l2dChar:IsLoaded() then
						arg_53_0.l2dActioning = true

						if not arg_53_1:L2dHasEvent() then
							parallelAsync({
								function(arg_55_0)
									arg_53_0:RemoveLive2DTimer()

									arg_53_0.l2dActioning = arg_53_0.l2dChar:TriggerAction(var_54_0, arg_55_0)

									return
								end,
								function(arg_56_0)
									arg_53_0:PlayVoice(arg_53_1, var_54_1)
									arg_53_0:ShowDailogue(arg_53_1, var_54_1, arg_56_0)

									return
								end
							}, function()
								arg_53_0.l2dActioning = false

								return
							end)
						else
							seriesAsync({
								function(arg_58_0)
									arg_53_0:RemoveLive2DTimer()

									if arg_53_0.l2dChar:checkActionProfile(var_54_0) then
										arg_53_0.l2dActioning = arg_53_0.l2dChar:TriggerAction(var_54_0, arg_58_0, nil, function(arg_59_0)
											arg_53_0:PlayVoice(arg_53_1, var_54_1)
											arg_53_0:ShowDailogue(arg_53_1, var_54_1, arg_58_0)

											return
										end)
									else
										arg_53_0:PlayVoice(arg_53_1, var_54_1)
										arg_53_0:ShowDailogue(arg_53_1, var_54_1, arg_58_0)
									end

									return
								end
							}, function()
								arg_53_0.l2dActioning = false

								return
							end)
						end
					end
				else
					arg_53_0:PlayVoice(arg_53_1, var_54_1)
					arg_53_0:ShowDailogue(arg_53_1, var_54_1)
				end

				return
			end)()
		end
	else
		(function()
			local var_54_0 = arg_53_1:isEx() and (arg_53_0.l2dChar and arg_53_0.l2dChar:checkActionExist(var_0.l2d_action .. "_ex") and var_0.l2d_action .. "_ex" or var_0.l2d_action) or var_0.l2d_action

			if arg_53_0.l2dBtnOn and arg_53_0.l2dChar and not arg_53_0.l2dChar:enablePlayAction(var_54_0) then
				return
			end

			arg_53_0:UpdatePaintingFace(arg_53_1)

			if arg_53_0.characterModel then
				arg_53_0.characterModel:SetAction(arg_53_0:GetModelAction(var_0), 0)
			end

			local var_54_1 = {
				var_0_0.CHAT_SHOW_TIME
			}

			if arg_53_0.live2DBtn.isOn and arg_53_0.l2dChar then
				if arg_53_0.l2dChar:IsLoaded() then
					arg_53_0.l2dActioning = true

					if not arg_53_1:L2dHasEvent() then
						parallelAsync({
							function(arg_55_0)
								arg_53_0:RemoveLive2DTimer()

								arg_53_0.l2dActioning = arg_53_0.l2dChar:TriggerAction(var_54_0, arg_55_0)

								return
							end,
							function(arg_56_0)
								arg_53_0:PlayVoice(arg_53_1, var_54_1)
								arg_53_0:ShowDailogue(arg_53_1, var_54_1, arg_56_0)

								return
							end
						}, function()
							arg_53_0.l2dActioning = false

							return
						end)
					else
						seriesAsync({
							function(arg_58_0)
								arg_53_0:RemoveLive2DTimer()

								if arg_53_0.l2dChar:checkActionProfile(var_54_0) then
									arg_53_0.l2dActioning = arg_53_0.l2dChar:TriggerAction(var_54_0, arg_58_0, nil, function(arg_59_0)
										arg_53_0:PlayVoice(arg_53_1, var_54_1)
										arg_53_0:ShowDailogue(arg_53_1, var_54_1, arg_58_0)

										return
									end)
								else
									arg_53_0:PlayVoice(arg_53_1, var_54_1)
									arg_53_0:ShowDailogue(arg_53_1, var_54_1, arg_58_0)
								end

								return
							end
						}, function()
							arg_53_0.l2dActioning = false

							return
						end)
					end
				end
			else
				arg_53_0:PlayVoice(arg_53_1, var_54_1)
				arg_53_0:ShowDailogue(arg_53_1, var_54_1)
			end

			return
		end)()
	end

	return
end

function var_0_0.UpdatePaintingFace(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_1.voice.key

	if arg_63_1.wordData.mainIndex ~= nil then
		var_63_0 = "main_" .. arg_63_1.wordData.mainIndex
	end

	if arg_63_0.paintingFitter.childCount > 0 then
		ShipExpressionHelper.SetExpression(arg_63_0.paintingFitter:GetChild(0), arg_63_0.paintingName, var_63_0, arg_63_1.wordData.maxfavor, arg_63_1.skin.id)
	end

	if arg_63_0.spinePainting then
		local var_63_1

		if pg.AssistantInfo.GetAssistantEventsByDialog(var_63_0) then
			var_63_1 = pg.AssistantInfo.GetAssistantEventsByDialog(var_63_0).action
		end

		local var_63_2 = ShipExpressionHelper.GetExpression(arg_63_0.paintingName, var_63_0, arg_63_1.wordData.maxfavor, arg_63_1.skin.id)

		if var_63_2 ~= "" then
			arg_63_0.spinePainting:SetAction(var_63_2, 1)

			if var_63_1 and arg_63_0.spinePainting:getAnimationExist(var_63_1) then
				arg_63_0.spinePainting:SetEmptyAction(1)
				arg_63_0.spinePainting:SetOnceAction(var_63_1, nil, function()
					return
				end, true)
			elseif arg_63_0.spinePainting:isInAction() then
				arg_63_0.spinePainting:SetAction(arg_63_0.spinePainting:getIdleName(), 0, true)
				arg_63_0.spinePainting:ClearAction()
			end
		else
			arg_63_0.spinePainting:SetEmptyAction(1)

			if var_63_1 and arg_63_0.spinePainting:getAnimationExist(var_63_1) then
				arg_63_0.spinePainting:SetOnceAction(var_63_1, nil, function()
					return
				end, true)
			elseif arg_63_0.spinePainting:isInAction() then
				arg_63_0.spinePainting:SetAction(arg_63_0.spinePainting:getIdleName(), 0, true)
				arg_63_0.spinePainting:ClearAction()
			end
		end
	end

	return
end

function var_0_0.PlayVoice(arg_66_0, arg_66_1, arg_66_2)
	arg_66_0:RemoveCvTimer()

	if not arg_66_1.wordData.cvPath or arg_66_1.wordData.cvPath == "" then
		return
	end

	if arg_66_1.words.voice_key >= ShipWordHelper.CV_KEY_REPALCE or arg_66_1.words.voice_key_2 >= ShipWordHelper.CV_KEY_REPALCE or arg_66_1.words.voice_key == ShipWordHelper.CV_KEY_BAN_NEW then
		local var_66_1 = 0

		if arg_66_1.isLive2d and arg_66_0.l2dChar and arg_66_1.wordData.voiceCalibrate then
			var_66_1 = arg_66_1.wordData.voiceCalibrate
		end

		arg_66_0.cvLoader:DelayPlaySound(arg_66_1.wordData.cvPath, var_66_1, function(arg_67_0)
			if arg_67_0 then
				arg_66_2[1] = long2int(arg_67_0.length) * 0.001
			end

			return
		end)
	end

	local var_66_2 = arg_66_1.wordData.se

	if arg_66_1.isLive2d and arg_66_0.l2dChar and var_66_2 then
		arg_66_0.cvLoader:RawPlaySound("event:/ui/" .. var_66_2[1], var_66_2[2])
	end

	return
end

function var_0_0.RemoveCvSeTimer(arg_68_0)
	if arg_68_0.cvSeTimer then
		arg_68_0.cvSeTimer:Stop()

		arg_68_0.cvSeTimer = nil
	end

	return
end

function var_0_0.RemoveCvTimer(arg_69_0)
	if arg_69_0.cvTimer then
		arg_69_0.cvTimer:Stop()

		arg_69_0.cvTimer = nil
	end

	return
end

function var_0_0.RemoveLive2DTimer(arg_70_0)
	if arg_70_0.Live2DTimer then
		LeanTween.cancel(arg_70_0.Live2DTimer)

		arg_70_0.Live2DTimer = nil
	end

	return
end

function var_0_0.ShowDailogue(arg_71_0, arg_71_1, arg_71_2, arg_71_3)
	arg_71_0.dailogueCallback = arg_71_3 or function()
		return
	end

	if not arg_71_1.wordData.textContent or arg_71_1.wordData.textContent == "" or arg_71_1.wordData.textContent == "nil" then
		if arg_71_0.dailogueCallback then
			arg_71_0.dailogueCallback()

			arg_71_0.dailogueCallback = nil
		end

		return
	end

	local var_71_1 = arg_71_0.chatText:GetComponent(typeof(Text))

	setText(arg_71_0.chatText, SwitchSpecialChar(arg_71_1.wordData.textContent))

	if #var_71_1.text > CHAT_POP_STR_LEN then
		var_71_1.alignment = TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

		local var_71_2 = arg_71_0.chatBg

		var_71_2.sizeDelta = var_71_1.preferredHeight + 120 > arg_71_0.initChatBgH and Vector2.New(arg_71_0.chatBg.sizeDelta.x, var_71_1.preferredHeight + 120) or Vector2.New(arg_71_0.chatBg.sizeDelta.x, arg_71_0.initChatBgH)

		arg_71_0:StopDailogue()
		setActive(arg_71_0.chatTF, true)
		LeanTween.scale(rtf(arg_71_0.chatTF.gameObject), Vector3.New(1, 1, 1), var_0_0.CHAT_ANIMATION_TIME):setEase(LeanTweenType.easeOutBack):setDelay(var_71_0 and var_71_0 or 0):setOnComplete(System.Action(function()
			LeanTween.scale(rtf(arg_71_0.chatTF.gameObject), Vector3.New(0, 0, 1), var_0_0.CHAT_ANIMATION_TIME):setEase(LeanTweenType.easeInBack):setDelay(var_0_0.CHAT_ANIMATION_TIME + arg_71_2[1]):setOnComplete(System.Action(function()
				if arg_71_0.dailogueCallback then
					arg_71_0.dailogueCallback()

					arg_71_0.dailogueCallback = nil
				end

				if arg_71_0.spinePainting then
					arg_71_0.spinePainting:SetEmptyAction(1)
				end

				return
			end))

			return
		end))

		return
	end
end

function var_0_0.StopDailogue(arg_75_0)
	LeanTween.cancel(arg_75_0.chatTF.gameObject)

	arg_75_0.chatTF.localScale = Vector3(0, 0)

	return
end

function var_0_0.onBackPressed(arg_76_0)
	if arg_76_0.paintingView.isPreview then
		arg_76_0.paintingView:Finish(true)

		return
	end

	triggerButton(arg_76_0.btnBack)

	return
end

function var_0_0.playOpening(arg_77_0, arg_77_1)
	if checkABExist("ui/skinunlockanim/" .. "star_level_unlock_anim_" .. arg_77_0.skin.id) then
		pg.CpkPlayMgr.GetInstance():PlayCpkMovie(function()
			return
		end, function()
			if arg_77_1 then
				arg_77_1()
			end

			return
		end, "ui/skinunlockanim", "star_level_unlock_anim_" .. arg_77_0.skin.id, true, false)
	elseif arg_77_1 then
		arg_77_1()
	end

	return
end

function var_0_0.updateSpinePaintingState(arg_80_0)
	if checkABExist((HXSet.autoHxShiftPath("spinepainting/" .. arg_80_0.paintingName))) then
		setActive(arg_80_0.spinePaintingBtn, true)
		setActive(arg_80_0.spinePaintingToggle:Find("on"), arg_80_0.spinePaintingisOn)
		setActive(arg_80_0.spinePaintingToggle:Find("off"), not arg_80_0.spinePaintingisOn)
		removeOnButton(arg_80_0.spinePaintingBtn)
		onButton(arg_80_0, arg_80_0.spinePaintingBtn, function()
			arg_80_0.spinePaintingisOn = not arg_80_0.spinePaintingisOn

			setActive(arg_80_0.spinePaintingToggle:Find("on"), arg_80_0.spinePaintingisOn)
			setActive(arg_80_0.spinePaintingToggle:Find("off"), not arg_80_0.spinePaintingisOn)

			if arg_80_0.spinePaintingisOn then
				arg_80_0:CreateSpinePainting()
			end

			setActive(arg_80_0.viewBtn, not arg_80_0.spinePaintingisOn)
			setActive(arg_80_0.rotateBtn, not arg_80_0.spinePaintingisOn)
			setActive(arg_80_0.commonPainting, not arg_80_0.spinePaintingisOn)
			setActive(arg_80_0.spinePaintingRoot, arg_80_0.spinePaintingisOn)
			setActive(arg_80_0.spinePaintingBgRoot, arg_80_0.spinePaintingisOn)
			arg_80_0:StopDailogue()

			if arg_80_0.skin then
				arg_80_0.pages[var_0_0.INDEX_PROFILE]:ExecuteAction("Flush", arg_80_0.skin, false)
			end

			return
		end, SFX_PANEL)
	else
		setActive(arg_80_0.spinePaintingBtn, false)
	end

	return
end

function var_0_0.CreateSpinePainting(arg_82_0)
	if arg_82_0.skin.id ~= arg_82_0.preSkinId then
		arg_82_0:DestroySpinePainting()

		arg_82_0.spinePainting = SpinePainting.New(SpinePainting.GenerateData({
			ship = Ship.New({
				noChangeSkin = true,
				configId = arg_82_0.shipGroup:getShipConfigId(),
				skin_id = arg_82_0.skin.id
			}),
			position = Vector3(0, 0, 0),
			parent = arg_82_0.spinePaintingRoot,
			offset = pg.ship_skin_template[arg_82_0.skin.id].spine_offset_profile,
			effectParent = arg_82_0.spinePaintingBgRoot
		}), function()
			return
		end)
		arg_82_0.preSkinId = arg_82_0.skin.id
	end

	arg_82_0:DisplaySpinePainting(true)

	return
end

function var_0_0.clearLive2dPainting(arg_84_0)
	if arg_84_0.l2dChar then
		arg_84_0.l2dChar:Dispose()

		arg_84_0.l2dChar = nil
		arg_84_0.l2dActioning = false
		arg_84_0.cvLoader.prevCvPath = nil

		arg_84_0:StopDailogue()
		arg_84_0.cvLoader:StopSound()
	end

	return
end

function var_0_0.DestroySpinePainting(arg_85_0)
	if arg_85_0.spinePainting then
		arg_85_0.spinePainting:Dispose()

		arg_85_0.spinePainting = nil
	end

	arg_85_0.preSkinId = nil

	return
end

function var_0_0.onWeddingReview(arg_86_0, arg_86_1)
	if not arg_86_1 and arg_86_0.exitLoadL2d then
		arg_86_0.exitLoadL2d = false

		arg_86_0.live2DBtn:Update(arg_86_0.paintingName, true)
	else
		arg_86_0.live2DBtn:Update(arg_86_0.paintingName, false)
	end

	arg_86_0.live2DBtn:SetEnable(not arg_86_1)

	if arg_86_0.l2dChar and arg_86_1 then
		arg_86_0.l2dChar:Dispose()

		arg_86_0.l2dChar = nil
		arg_86_0.l2dActioning = false
		arg_86_0.cvLoader.prevCvPath = nil

		arg_86_0:StopDailogue()
		arg_86_0.cvLoader:StopSound()

		arg_86_0.exitLoadL2d = true
	end

	if arg_86_0.spinePaintingRoot.childCount > 0 then
		setActive(arg_86_0.commonPainting, not arg_86_0.spinePaintingisOn)
	end

	return
end

function var_0_0.DisplaySpinePainting(arg_87_0, arg_87_1)
	setActive(arg_87_0.spinePaintingRoot, arg_87_1)
	setActive(arg_87_0.spinePaintingBgRoot, arg_87_1)

	return
end

function var_0_0.willExit(arg_88_0)
	pg.CpkPlayMgr.GetInstance():DisposeCpkMovie()
	SetParent(arg_88_0.bottomTF, arg_88_0._tf)
	arg_88_0:UnOverlayPanel(arg_88_0.blurPanel, arg_88_0._tf)

	for iter_88_0, iter_88_1 in ipairs(arg_88_0.pages) do
		iter_88_1:Destroy()
	end

	if arg_88_0.l2dChar then
		arg_88_0.l2dChar:Dispose()

		arg_88_0.l2dChar = nil
	end

	arg_88_0:DestroySpinePainting()
	arg_88_0.paintingView:Dispose()
	arg_88_0.live2DBtn:Dispose()
	arg_88_0.cvLoader:Dispose()
	arg_88_0:ReturnModel()
	arg_88_0:RecyclePainting()

	local var_88_0 = arg_88_0.skinBtns or {}

	_.each(var_88_0, function(arg_89_0)
		arg_89_0:Dispose()

		return
	end)
	arg_88_0:RemoveCvTimer()
	arg_88_0:RemoveCvSeTimer()
	arg_88_0:RemoveLive2DTimer()

	return
end

return var_0_0
