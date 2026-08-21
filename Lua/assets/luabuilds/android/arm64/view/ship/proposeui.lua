local var_0_0 = class("ProposeUI", import("..base.BaseUI"))

var_0_0.nationSpriteIndex = {
	us = 1,
	de = 4,
	cm = 0,
	cn = 5,
	np = 9,
	um = 11,
	en = 2,
	jp = 3,
	mnf = 8,
	bili = 10,
	ff = 7,
	sn = 6
}

function var_0_0.getUIName(arg_1_0)
	return "ProposeUI"
end

function var_0_0.setShip(arg_2_0, arg_2_1)
	arg_2_0.shipVO = arg_2_1
	arg_2_0.proposeType = arg_2_0.shipVO:getProposeType()

	arg_2_0:setShipGroupID(arg_2_0.shipVO:getGroupId())

	return
end

function var_0_0.setShipGroupID(arg_3_0, arg_3_1)
	arg_3_0.shipGroupID = arg_3_1

	return
end

function var_0_0.setWeddingReviewSkinID(arg_4_0, arg_4_1)
	arg_4_0.reviewSkinID = arg_4_1

	return
end

function var_0_0.setBagProxy(arg_5_0, arg_5_1)
	arg_5_0.bagProxy = arg_5_1

	return
end

function var_0_0.setPlayer(arg_6_0, arg_6_1)
	arg_6_0.player = arg_6_1

	return
end

function var_0_0.init(arg_7_0)
	arg_7_0.storybg = arg_7_0._tf:Find("close/bg")
	arg_7_0.bgAdd = arg_7_0._tf:Find("add")

	setActive(arg_7_0.storybg, false)
	setActive(arg_7_0.bgAdd, false)

	arg_7_0.targetActorTF = arg_7_0._tf:Find("actor_middle")
	arg_7_0.maskTF = arg_7_0._tf:Find("mask")
	arg_7_0.skipBtn = arg_7_0._tf:Find("skip_button")
	arg_7_0.actorPainting = nil
	arg_7_0.materialFace = arg_7_0._tf:Find("Resource/face"):GetComponent(typeof(Image)).material
	arg_7_0.materialPaint = arg_7_0._tf:Find("Resource/paint"):GetComponent(typeof(Image)).material
	arg_7_0.finishCallback = arg_7_0.contextData.finishCallback
	arg_7_0.commonTF = GameObject.Find("OverlayCamera/Overlay/UIMain/common")
	arg_7_0.exchangePanel = arg_7_0._tf:Find("exchange_panel")

	local var_7_0 = arg_7_0.exchangePanel:Find("window/msg_panel/content")

	setText(var_7_0:Find("text"), i18n("word_propose_cost_tip2"))

	for iter_7_0, iter_7_1 in ipairs(pg.gameset.vow_prop_conversion.description) do
		updateDrop(var_7_0:Find("icon_" .. iter_7_0), (Drop.New({
			count = 1,
			type = DROP_TYPE_ITEM,
			id = iter_7_1
		})))
		onButton(arg_7_0, var_7_0:Find("icon_" .. iter_7_0), function()
			arg_7_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
	end

	onButton(arg_7_0, arg_7_0.exchangePanel:Find("bg"), function()
		arg_7_0:hideExchangePanel()

		return
	end, SFX_CANCEL)
	onButton(arg_7_0, arg_7_0.exchangePanel:Find("window/top/btnBack"), function()
		arg_7_0:hideExchangePanel()

		return
	end, SFX_CANCEL)
	onButton(arg_7_0, arg_7_0.exchangePanel:Find("window/button_container/cancel"), function()
		arg_7_0:hideExchangePanel()

		return
	end, SFX_CANCEL)
	onButton(arg_7_0, arg_7_0.exchangePanel:Find("window/button_container/confirm"), function()
		if getProxy(BagProxy):getItemCountById(ITEM_ID_FOR_PROPOSE) > 0 then
			arg_7_0:emit(ProposeMediator.EXCHANGE_TIARA)
		else
			ItemTipPanel.ShowRingBuyTip()
		end

		arg_7_0:hideExchangePanel()

		return
	end, SFX_CONFIRM)

	arg_7_0.tweenList = {}

	return
end

function var_0_0.didEnter(arg_13_0)
	arg_13_0:emit(ProposeMediator.HIDE_SHIP_MAIN_WORD)

	if arg_13_0.commonTF then
		setActive(arg_13_0.commonTF, false)
	end

	if arg_13_0.contextData.review then
		arg_13_0.weddingReview = true
		arg_13_0.proposeType = arg_13_0.contextData.group:getProposeType()
		arg_13_0.bgName = Nation.Nation2BG((arg_13_0.contextData.group:getNation())) or Nation.Nation2BG(0)

		onButton(arg_13_0, arg_13_0.skipBtn, function()
			arg_13_0:closeView()

			return
		end, SFX_CANCEL)
		pg.UIMgr.GetInstance():BlurPanel(arg_13_0._tf)
		arg_13_0:doPlay()
	else
		arg_13_0:doMain()
	end

	return
end

function var_0_0.doPlay(arg_15_0)
	setActive(arg_15_0.skipBtn, arg_15_0.weddingReview)
	arg_15_0:setMask(true)
	pg.BgmMgr.GetInstance():TempPlay("wedding")
	arg_15_0:showProposePanel()

	return
end

function var_0_0.doMain(arg_16_0)
	onButton(arg_16_0, arg_16_0.skipBtn, function()
		arg_16_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_16_0, arg_16_0._tf:Find("close0"), function()
		if arg_16_0.proposeEndFlag then
			arg_16_0:DisplayRenamePanel()
		else
			arg_16_0:closeView()
		end

		return
	end, SFX_CANCEL)
	onButton(arg_16_0, arg_16_0._tf:Find("close_end"), function()
		if arg_16_0.proposeEndFlag then
			arg_16_0:DisplayRenamePanel()
		else
			arg_16_0:closeView()
		end

		return
	end, SFX_CANCEL)

	local var_16_0 = arg_16_0.shipVO:getConfigTable().nationality
	local var_16_1 = "Propose" .. Nation.Nation2Side(var_16_0) .. "UI"

	arg_16_0.bgName = Nation.Nation2BG(var_16_0) or Nation.Nation2BG(0)

	PoolMgr.GetInstance():GetUI("Propose" .. Nation.Nation2Side(var_16_0) .. "UI", true, function(arg_20_0)
		if arg_16_0.exited then
			PoolMgr.GetInstance():ReturnUI(var_16_1, arg_20_0)

			return
		end

		arg_16_0.window = tf(arg_20_0)

		setParent(tf(arg_20_0), arg_16_0._tf:Find("window"))

		arg_16_0.intimacyTF = arg_16_0.window:Find("intimacy/icon")
		arg_16_0.intimacyValueTF = arg_16_0.window:Find("intimacy/value")
		arg_16_0.button = arg_16_0.window:Find("button")
		arg_16_0.giftButton = arg_16_0.window:Find("giftBtn")
		arg_16_0.intimacyDesc = arg_16_0.window:Find("desc")
		arg_16_0.intimacydescTime = arg_16_0.window:Find("descPic/desc_time")
		arg_16_0.intimacyDescPic = arg_16_0.window:Find("descPic")
		arg_16_0.intimacyBuffDesc = arg_16_0.window:Find("desc_buff")
		arg_16_0._paintingTF = arg_16_0.window:Find("paintMask/paint")
		arg_16_0.intimacyAchieved = arg_16_0.window:Find("intimacy/achieved")
		arg_16_0.intimacyNoAchieved = arg_16_0.window:Find("intimacy/no_achieved")
		arg_16_0.ringAchieved = arg_16_0.window:Find("ringCount/achieved")
		arg_16_0.ringNoAchieved = arg_16_0.window:Find("ringCount/no_achieved")
		arg_16_0.ringValue = arg_16_0.window:Find("ringCount/value")
		arg_16_0.nameTF = arg_16_0.window:Find("title1/Text")
		arg_16_0.shipNameTF = arg_16_0.window:Find("title2/Text")
		arg_16_0.campTF = arg_16_0.window:Find("Camp")
		arg_16_0.doneTF = arg_16_0.window:Find("done")
		arg_16_0.CampSprite = arg_16_0.window:Find("CampSprite")

		setActive(arg_16_0.window, true)
		setText(arg_16_0.nameTF, arg_16_0.player.name)
		setText(arg_16_0.shipNameTF, arg_16_0.shipVO:getName())

		if arg_16_0.CampSprite then
			local var_20_0 = getImageSprite(arg_16_0.CampSprite:Find(Nation.Nation2Print(var_16_0)))

			if not var_20_0 then
				warning("找不到印花, shipConfigId: " .. arg_16_0.shipVO.configId)
				setActive(arg_16_0.campTF, false)
			else
				setImageSprite(arg_16_0.campTF, var_20_0, false)
				setActive(arg_16_0.campTF, true)
			end
		end

		setIntimacyIcon(arg_16_0.intimacyTF, arg_16_0.shipVO:getIntimacyIcon())

		local var_20_1, var_20_2 = arg_16_0.shipVO:getIntimacyDetail()

		setText(arg_16_0.intimacyValueTF, i18n("propose_intimacy_tip", var_20_2))

		if var_20_2 >= 100 then
			setTextColor(arg_16_0.intimacyValueTF, Color.white)
		else
			setTextColor(arg_16_0.intimacyValueTF, Color.New(0.5843137254901961, 0.5215686274509804, 0.40784313725490196))
		end

		local var_20_4 = arg_16_0.shipVO.propose or var_20_2 >= 100

		var_20_3(arg_16_0.intimacyAchieved, var_20_4)
		setActive(arg_16_0.intimacyNoAchieved, var_20_2 < 100 and not arg_16_0.shipVO.propose)
		arg_16_0:onUpdateItemCount()
		setActive(arg_16_0.doneTF, arg_16_0.shipVO.propose)

		local var_20_5, var_20_6 = arg_16_0.shipVO:getIntimacyInfo()

		if arg_16_0.shipVO.propose then
			if arg_16_0.intimacyDescPic then
				setActive(arg_16_0.intimacyDescPic, true)
				arg_16_0:onUpdateIntimacydescTime(arg_16_0.shipVO.proposeTime)
			end

			if arg_16_0.intimacyDesc then
				setActive(arg_16_0.intimacyDesc, not arg_16_0.intimacyDescPic)
				setText(arg_16_0.intimacyDesc, (arg_16_0:getProposeText()))
			end
		else
			if arg_16_0.intimacyDesc and GetComponent(arg_16_0.intimacyDesc, "VerticalText") then
				GetComponent(arg_16_0.intimacyDesc, "VerticalText").enabled = false
			end

			if arg_16_0.intimacyDescPic then
				setActive(arg_16_0.intimacyDescPic, false)
			end

			if arg_16_0.intimacyDesc then
				setActive(arg_16_0.intimacyDesc, true)
				setText(arg_16_0.intimacyDesc, i18n(var_20_6, arg_16_0.shipVO.name))
			end
		end

		setText(arg_16_0.intimacyBuffDesc, "*" .. i18n(var_20_6 .. "_buff"))
		arg_16_0:loadChar()
		pg.UIMgr.GetInstance():BlurPanel(arg_16_0._tf)
		setActive(arg_16_0.button, not arg_16_0.shipVO:ShowPropose())

		local var_20_7 = not arg_16_0.shipVO.propose and var_20_1 <= var_20_2
		local var_20_8 = arg_16_0.shipVO.propose

		if arg_16_0.shipVO.propose then
			var_20_8 = not arg_16_0.shipVO:ShowPropose()
		end

		arg_16_0.button:GetComponent(typeof(Button)).interactable = var_20_7 or var_20_8

		onButton(arg_16_0, arg_16_0.button, function()
			if var_20_7 then
				if arg_16_0.bagProxy:getItemCountById(arg_16_0:getProposeItemId()) < 1 then
					if arg_16_0.proposeType == "imas" then
						arg_16_0:showExchangePanel()
					else
						ItemTipPanel.ShowRingBuyTip()
					end

					return
				end

				local var_21_0, var_21_1 = ShipStatus.ShipStatusCheck("onPropose", arg_16_0.shipVO)

				if not var_21_0 then
					pg.TipsMgr.GetInstance():ShowTips(var_21_1)

					return
				end

				arg_16_0:checkPaintingRes(arg_16_0.shipVO, function()
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("word_propose_cost_tip" .. (arg_16_0.proposeType == "imas" and "1" or ""), var_0),
						onYes = function()
							if arg_16_0.intimacydescTime then
								arg_16_0:onUpdateIntimacydescTime(pg.TimeMgr.GetInstance():GetServerTime())
							end

							arg_16_0:hideWindow()
							setActive(arg_16_0.window, false)
							arg_16_0:doPlay()

							return
						end
					})

					return
				end)
			elseif var_20_8 then
				function arg_16_0.afterRegisterCall()
					arg_16_0.afterRegisterCall = nil

					pg.TipsMgr.GetInstance():ShowTips(i18n("word_propose_switch_tip"))
					arg_16_0:closeView()

					return
				end

				arg_16_0:emit(ProposeMediator.REGISTER_SHIP, arg_16_0.shipVO.id)
			else
				arg_16_0:closeView()
			end

			return
		end, SFX_PANEL)
		setActive(arg_16_0.giftButton, not LOCK_SHIP_GIFT)
		onButton(arg_16_0, arg_16_0.giftButton, function()
			if LOCK_SHIP_GIFT then
				return
			end

			arg_16_0:emit(ProposeMediator.GIFT_SHIP, arg_16_0.shipVO.id)

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function var_0_0.getProposeText(arg_26_0)
	local var_26_0 = ""

	if PLATFORM_CODE ~= PLATFORM_CH then
		if PLATFORM_CODE == PLATFORM_CHT then
			var_26_0 = i18n("intimacy_desc_propose", pg.TimeMgr.GetInstance():ChieseDescTime(arg_26_0.shipVO.proposeTime, true))

			if not IsNil(GetComponent(arg_26_0.intimacyDesc, "VerticalText")) then
				GetComponent(arg_26_0.intimacyDesc, "VerticalText").enabled = true
				var_26_0 = i18n("intimacy_desc_propose_vertical", pg.TimeMgr.GetInstance():ChieseDescTime(arg_26_0.shipVO.proposeTime, true))
			end
		elseif PLATFORM_CODE == PLATFORM_KR then
			var_26_0 = i18n("intimacy_desc_propose", pg.TimeMgr.GetInstance():STimeDescS(arg_26_0.shipVO.proposeTime, "%Y년%m월%d일", true))

			if not IsNil(GetComponent(arg_26_0.intimacyDesc, "VerticalText")) then
				GetComponent(arg_26_0.intimacyDesc, "VerticalText").enabled = true
				var_26_0 = i18n("intimacy_desc_propose_vertical", pg.TimeMgr.GetInstance():STimeDescS(arg_26_0.shipVO.proposeTime, "%Y년%m월%d일"))
			end
		else
			var_26_0 = i18n("intimacy_desc_propose", pg.TimeMgr.GetInstance():STimeDescS(arg_26_0.shipVO.proposeTime, "%Y/%m/%d", true))

			if not IsNil(GetComponent(arg_26_0.intimacyDesc, "VerticalText")) then
				GetComponent(arg_26_0.intimacyDesc, "VerticalText").enabled = true
				var_26_0 = i18n("intimacy_desc_propose_vertical", pg.TimeMgr.GetInstance():STimeDescS(arg_26_0.shipVO.proposeTime, "%Y/%m/%d"))
			end
		end

		return var_26_0
	end
end

function var_0_0.getProposeItemId(arg_27_0)
	if arg_27_0.proposeType == "imas" then
		return ITEM_ID_FOR_PROPOSE_IMAS
	else
		return ITEM_ID_FOR_PROPOSE
	end

	return
end

function var_0_0.onUpdateItemCount(arg_28_0)
	local var_28_0 = arg_28_0.bagProxy:getItemCountById(arg_28_0:getProposeItemId())
	local var_28_1 = arg_28_0.shipVO.propose or var_28_0 > 0

	setActive(arg_28_0.ringAchieved, var_28_1)
	setActive(arg_28_0.ringNoAchieved, var_28_0 <= 0 and not arg_28_0.shipVO.propose)
	setText(arg_28_0.ringValue, i18n(arg_28_0.proposeType == "imas" and "intimacy_desc_tiara" or "intimacy_desc_ring"))

	if arg_28_0.shipVO.propose or var_28_0 > 0 then
		setTextColor(arg_28_0.ringValue, Color.white)
	else
		setTextColor(arg_28_0.ringValue, Color.New(0.5843137254901961, 0.5215686274509804, 0.40784313725490196))
	end

	if arg_28_0.proposeType == "imas" then
		local var_28_2 = not arg_28_0.shipVO.propose and var_28_0 == 0

		setActive(arg_28_0.window:Find("ringCount/bg_exchange"), not arg_28_0.shipVO.propose and var_28_0 == 0)
		setActive(arg_28_0.window:Find("ringCount/icon/btn_exchange"), var_28_2)
		onButton(arg_28_0, arg_28_0.window:Find("ringCount/icon/btn_exchange"), function()
			arg_28_0:showExchangePanel()

			return
		end, SFX_PANEL)
	else
		setActive(arg_28_0.window:Find("ringCount/icon/base"), PLATFORM_CODE ~= PLATFORM_CH)
		setActive(arg_28_0.window:Find("ringCount/icon/hx"), PLATFORM_CODE == PLATFORM_CH)
	end

	return
end

function var_0_0.onUpdateIntimacydescTime(arg_30_0, arg_30_1)
	local var_30_0 = PLATFORM_CODE == PLATFORM_JP and (arg_30_0.proposeType == "imas" and "%Y.%m.%d" or "%B.%d,    %y") or PLATFORM_CODE == PLATFORM_US and "%B %d, %Y" or arg_30_0.proposeType == "imas" and i18n("intimacy_desc_day") .. " %Y.%m.%d" or "%B.%d,    %y"

	setText(arg_30_0.intimacydescTime, pg.TimeMgr.GetInstance():STimeDescS(arg_30_1, var_30_0))

	return
end

function var_0_0.onBackPressed(arg_31_0)
	if isActive(arg_31_0.exchangePanel) then
		arg_31_0:hideExchangePanel()

		return
	end

	if arg_31_0.window and isActive(arg_31_0.window) then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		triggerButton(arg_31_0._tf:Find("close_end"))
	end

	return
end

function var_0_0.willExit(arg_32_0)
	if arg_32_0._currentVoice then
		arg_32_0._currentVoice:PlaybackStop()
	end

	arg_32_0._currentVoice = nil

	pg.BgmMgr.GetInstance():ContinuePlay()

	if not IsNil(arg_32_0.actorPainting) then
		local var_32_0 = tf(arg_32_0.actorPainting)

		if var_32_0:Find("temp_mask") then
			Destroy(var_32_0:Find("temp_mask"))
		end

		var_32_0:GetComponent(typeof(Image)).material = nil

		PoolMgr.GetInstance():ReturnPainting(arg_32_0.paintingName, arg_32_0.actorPainting)

		arg_32_0.actorPainting = nil
	end

	if arg_32_0.delayTId then
		LeanTween.cancel(arg_32_0.delayTId)
	end

	if arg_32_0.commonTF then
		setActive(arg_32_0.commonTF, true)
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_32_0._tf)

	if arg_32_0.l2dChar then
		arg_32_0.l2dChar:ClearPics()

		arg_32_0.l2dChar = nil
	end

	if arg_32_0.live2dRequestId then
		pg.Live2DMgr.GetInstance():StopLoadingLive2d(arg_32_0.live2dRequestId)

		arg_32_0.live2dRequestId = nil
	end

	if arg_32_0._delayVoiceTweenID then
		LeanTween.cancel(arg_32_0._delayVoiceTweenID)

		arg_32_0._delayVoiceTweenID = nil
	end

	if arg_32_0.tweenList then
		cancelTweens(arg_32_0.tweenList)

		arg_32_0.tweenList = nil
	end

	if arg_32_0.contextData.callback then
		arg_32_0.contextData.callback()
	end

	if arg_32_0.finishCallback then
		arg_32_0.finishCallback()

		arg_32_0.finishCallback = nil
	end

	return
end

function var_0_0.setMask(arg_33_0, arg_33_1)
	setActive(arg_33_0.maskTF, arg_33_1)

	return
end

function var_0_0.bgAddAnimation(arg_34_0, arg_34_1)
	setActive(arg_34_0.storybg, true)
	arg_34_0:showbgAdd(true, arg_34_1)

	return
end

function var_0_0.showbgChurch(arg_35_0)
	table.insert(arg_35_0.tweenList, LeanTween.scale(arg_35_0.storybg, Vector3(1, 1, 1), 6).uniqueId)
	setActive(arg_35_0.churchLight, true)
	table.insert(arg_35_0.tweenList, LeanTween.delayedCall(6, System.Action(function()
		setActive(arg_35_0.churchLight, false)

		return
	end)).uniqueId)

	return
end

function var_0_0.showbgAdd(arg_37_0, arg_37_1, arg_37_2)
	table.insert(arg_37_0.tweenList, LeanTween.alphaCanvas(GetOrAddComponent(arg_37_0.bgAdd, typeof(CanvasGroup)), arg_37_1 and 0 or 1, arg_37_2):setFrom(arg_37_1 and 1 or 0).uniqueId)
	setActive(arg_37_0.bgAdd, true)

	return
end

function var_0_0.showBlackBG(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_2 = GetOrAddComponent(arg_38_0.blackBG, typeof(CanvasGroup))

	setActive(arg_38_0.blackBG, true)
	table.insert(arg_38_0.tweenList, LeanTween.alphaCanvas(var_38_2, var_38_1, arg_38_2):setFrom(var_38_0):setOnComplete(System.Action(function()
		if arg_38_1 then
			setActive(arg_38_0.blackBG, false)
		end

		if arg_38_3 then
			arg_38_3()
		end

		return
	end)).uniqueId)

	return
end

function var_0_0.showPainting(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	if arg_40_1 then
		table.insert({}, function(arg_41_0)
			arg_40_0:loadChar(arg_40_0.targetActorTF, "duihua", arg_41_0)

			return
		end)
	end

	seriesAsync({}, function()
		table.insert(arg_40_0.tweenList, LeanTween.alphaCanvas(GetOrAddComponent(arg_40_0.targetActorTF, typeof(CanvasGroup)), arg_40_1 and 1 or 0, arg_40_2):setFrom(arg_40_1 and 0 or 1):setOnComplete(System.Action(function()
			if arg_40_3 then
				arg_40_3()
			end

			return
		end)).uniqueId)

		return
	end)

	return
end

var_0_0.Live2DProposeDelayTime = 2

function var_0_0.showLive2D(arg_44_0, arg_44_1)
	setActive(arg_44_0.targetActorTF:Find("fitter"), false)
	setActive(arg_44_0.targetActorTF:Find("live2d"), true)
	table.insert(arg_44_0.tweenList, LeanTween.alphaCanvas(GetOrAddComponent(arg_44_0.targetActorTF, typeof(CanvasGroup)), 1, var_0_0.Live2DProposeDelayTime):setFrom(0):setOnComplete(System.Action(function()
		arg_44_0:changeParamaterValue("Paramring", 1)
		arg_44_0.l2dChar:SetAction(pg.AssistantInfo.action2Id[arg_44_1])

		return
	end)).uniqueId)

	return
end

function var_0_0.changeParamaterValue(arg_46_0, arg_46_1, arg_46_2)
	if not arg_46_1 or string.len(arg_46_1) == 0 then
		return
	end

	local var_46_0 = arg_46_0.l2dChar:GetCubismParameter(arg_46_1)

	if not var_46_0 then
		return
	end

	arg_46_0.l2dChar:AddParameterValue(var_46_0, arg_46_2, CubismParameterBlendMode.Override)

	return
end

function var_0_0.hideWindow(arg_47_0)
	local var_47_0 = GetOrAddComponent(arg_47_0.window, typeof(CanvasGroup))

	var_47_0.interactable = false

	table.insert(arg_47_0.tweenList, LeanTween.alphaCanvas(var_47_0, 0, 0.2):setFrom(1):setOnComplete(System.Action(function()
		var_47_0.interactable = true

		return
	end)).uniqueId)

	return
end

function var_0_0.stampWindow(arg_49_0)
	arg_49_0.proposeEndFlag = true

	arg_49_0:loadChar(nil, nil, function()
		return
	end)
	setActive(arg_49_0.window, true)
	setActive(arg_49_0.button, false)
	setActive(arg_49_0.giftButton, false)
	setActive(arg_49_0.targetActorTF:Find("live2d"), false)

	local var_49_0

	if arg_49_0.intimacyDescPic then
		setActive(arg_49_0.intimacyDescPic, true)

		var_49_0 = GetOrAddComponent(arg_49_0.intimacyDescPic, typeof(CanvasGroup))
	end

	if arg_49_0.intimacyDesc then
		setActive(arg_49_0.intimacyDesc, not arg_49_0.intimacyDescPic)
		setText(arg_49_0.intimacyDesc, (arg_49_0:getProposeText()))

		var_49_0 = GetOrAddComponent(arg_49_0.intimacyDesc, typeof(CanvasGroup))
	end

	setText(arg_49_0.intimacyBuffDesc, "")
	setActive(arg_49_0.doneTF, false)

	var_49_0.alpha = 0

	local var_49_1 = GetOrAddComponent(arg_49_0.window, typeof(CanvasGroup))

	var_49_1.interactable = false

	table.insert(arg_49_0.tweenList, LeanTween.alphaCanvas(var_49_1, 1, 0.8):setFrom(0).uniqueId)
	table.insert(arg_49_0.tweenList, LeanTween.delayedCall(1.5, System.Action(function()
		table.insert(arg_49_0.tweenList, LeanTween.alphaCanvas(var_49_0, 1, 2):setFrom(0).uniqueId)

		return
	end)).uniqueId)

	arg_49_0.delayTId = LeanTween.delayedCall(5, System.Action(function()
		if not var_49_1 then
			return
		end

		var_49_1.interactable = true

		setActive(arg_49_0.doneTF, true)
		arg_49_0:setMask(false)
		setActive(arg_49_0._tf:Find("close_end"), true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_SEAL)

		return
	end)).id

	return
end

function var_0_0.showProposePanel(arg_53_0)
	arg_53_0.proposeSkin = ShipGroup.getProposeSkin(arg_53_0.shipGroupID)

	if arg_53_0.proposeSkin and arg_53_0.actorPainting then
		local var_53_0 = tf(arg_53_0.actorPainting)

		if var_53_0:Find("temp_mask") then
			Destroy(var_53_0:Find("temp_mask"))
		end

		var_53_0:GetComponent(typeof(Image)).material = nil

		PoolMgr.GetInstance():ReturnPainting(arg_53_0.paintingName, arg_53_0.actorPainting)

		arg_53_0.actorPainting = nil
	end

	if not arg_53_0.proposePanel then
		table.insert({}, function(arg_54_0)
			PoolMgr.GetInstance():GetUI("ProposeRingUI", true, function(arg_55_0)
				if arg_53_0.exited then
					PoolMgr.GetInstance():ReturnUI(var_0, arg_55_0)

					return
				end

				arg_53_0.proposePanel = tf(arg_55_0)

				setParent(tf(arg_55_0), arg_53_0._tf:Find("contain"))
				eachChild(arg_53_0.proposePanel:Find("ringBox"), function(arg_56_0)
					setActive(arg_56_0, arg_56_0.name == arg_53_0.proposeType)

					if arg_56_0.name == arg_53_0.proposeType then
						arg_53_0.ringBoxTF = arg_56_0
					end

					return
				end)

				arg_53_0.ringBoxCG = GetOrAddComponent(arg_53_0.ringBoxTF, typeof(CanvasGroup))
				arg_53_0.ringBoxFull = arg_53_0.ringBoxTF:Find("full")
				arg_53_0.churchBefore = arg_53_0.proposePanel:Find("before")
				arg_53_0.churchLight = arg_53_0.churchBefore:Find("light")

				setParent(arg_53_0.churchLight, arg_53_0._tf)
				arg_53_0.churchLight:SetSiblingIndex(2)

				arg_53_0.blackBG = arg_53_0.churchBefore:Find("blackbg")
				arg_53_0.doorLightBG = arg_53_0.churchBefore:Find("door_light")
				arg_53_0.door = arg_53_0.churchBefore:Find("door")
				arg_53_0.doorAni = GetOrAddComponent(arg_53_0.door, "SpineAnimUI")

				setParent(arg_53_0.churchBefore, arg_53_0._tf:Find("contain"))

				arg_53_0.ringTipTF = arg_53_0.proposePanel:Find("tip")
				arg_53_0.ringTipCG = GetOrAddComponent(arg_53_0.ringTipTF, typeof(CanvasGroup))

				setText(arg_53_0.ringTipTF:Find("Text"), i18n(arg_53_0.proposeType == "imas" and "word_propose_tiara_tip" or "word_propose_ring_tip"))
				setActive(arg_53_0.ringTipTF:Find("finger"), false)
				LoadImageSpriteAsync(arg_53_0.bgName, arg_53_0.storybg)

				arg_53_0.storybg.localScale = Vector3(1.2, 1.2, 1.2)

				if arg_53_0.weddingReview then
					local var_55_0 = arg_53_0.reviewSkinID or arg_53_0.shipVO:getSkinId()

					arg_53_0.handId = pg.ship_skin_template[var_55_0].hand_id

					if SPECIAL_PROPOSE and SPECIAL_PROPOSE[1] == pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y%m%d", true) then
						for iter_55_0, iter_55_1 in ipairs(SPECIAL_PROPOSE[2]) do
							if iter_55_1[1] == var_55_0 then
								arg_53_0.handId = iter_55_1[2]
							end
						end
					end

					local var_55_1 = ({
						default = "",
						meta = "Meta_",
						imas = "Imas_"
					})[arg_53_0.proposeType] .. "ProposeHand_" .. arg_53_0.handId

					arg_53_0.handName = ({
						default = "",
						meta = "Meta_",
						imas = "Imas_"
					})[arg_53_0.proposeType] .. "ProposeHand_" .. arg_53_0.handId

					PoolMgr.GetInstance():GetUI(var_55_1, true, function(arg_57_0)
						if arg_53_0.exited then
							PoolMgr.GetInstance():ReturnUI(var_55_1, arg_57_0)

							return
						end

						arg_53_0.transHand = tf(arg_57_0)

						setActive(arg_53_0.transHand, false)
						setParent(arg_53_0.transHand, arg_53_0.proposePanel)
						arg_53_0.transHand:SetAsFirstSibling()

						arg_53_0.handTF = arg_53_0.transHand:Find("hand")
						arg_53_0.ringTF = arg_53_0.transHand:Find("ring")
						arg_53_0.ringCG = GetOrAddComponent(arg_53_0.ringTF, typeof(CanvasGroup))
						arg_53_0.ringAnim = arg_53_0.ringTF:GetComponent(typeof(Animator))
						arg_53_0.ringAnim.enabled = false
						arg_53_0.ringLight = arg_53_0.ringTF:Find("ring_light")
						arg_53_0.ringLightCG = GetOrAddComponent(arg_53_0.ringLight, typeof(CanvasGroup))

						arg_54_0()

						return
					end)

					return
				end
			end)

			return
		end)
	end

	table.insert({}, function(arg_58_0)
		table.insert(arg_53_0.tweenList, LeanTween.scale(arg_53_0.door, Vector3(2.1, 2.1, 2.1), 4).uniqueId)
		arg_53_0.doorAni:SetActionCallBack(function(arg_59_0)
			if arg_59_0 == "FINISH" then
				arg_53_0.doorAni:SetActionCallBack(nil)
				setActive(arg_53_0.door, false)
				arg_53_0:showBlackBG(true, 0.1)
				setActive(arg_53_0.doorLightBG, false)
				arg_58_0()
			end

			return
		end)
		table.insert(arg_53_0.tweenList, LeanTween.delayedCall(2, System.Action(function()
			arg_53_0:showbgAdd(false, 2)

			return
		end)).uniqueId)
		table.insert(arg_53_0.tweenList, LeanTween.alpha(rtf(arg_53_0.doorLightBG), 1, 2):setFrom(0).uniqueId)
		arg_53_0:showBlackBG(false, 0.1)
		arg_53_0.doorAni:SetAction("OPEN", 0)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_DOOR)

		return
	end)
	table.insert({}, function(arg_61_0)
		arg_53_0.handTF:GetComponent(typeof(Image)).color = Color.New(1, 1, 1, 0)

		arg_53_0:bgAddAnimation(2)
		table.insert(arg_53_0.tweenList, LeanTween.delayedCall(2, System.Action(function()
			arg_53_0:showPainting(true, 1.5, function()
				table.insert(arg_53_0.tweenList, LeanTween.delayedCall(1.5, System.Action(arg_61_0)).uniqueId)

				return
			end)

			return
		end)).uniqueId)

		return
	end)
	table.insert({}, function(arg_64_0)
		arg_53_0:showBlackBG(false, 1.2, function()
			arg_53_0:showBlackBG(true, 1.2)

			return
		end)
		arg_53_0:showPainting(false, 1, arg_64_0)

		return
	end)
	table.insert({}, function(arg_66_0)
		setAnchoredPosition(arg_53_0.handTF, {
			y = arg_53_0.handTF.rect.height
		})
		setAnchoredPosition(arg_53_0.ringTF, {
			y = 0
		})
		setActive(arg_53_0.proposePanel, true)
		setActive(arg_53_0.transHand, true)

		arg_53_0.ringBoxCG.alpha = 0
		arg_53_0.ringCG.alpha = 0

		arg_66_0()

		return
	end)

	if arg_53_0.proposeType ~= "imas" then
		table.insert({}, function(arg_67_0)
			table.insert(arg_53_0.tweenList, LeanTween.alpha(rtf(arg_53_0.handTF), 1, 1.2).uniqueId)
			table.insert(arg_53_0.tweenList, LeanTween.moveY(rtf(arg_53_0.handTF), 0, 2):setOnComplete(System.Action(function()
				table.insert(arg_53_0.tweenList, LeanTween.alphaCanvas(arg_53_0.ringBoxCG, 1, 1.5):setFrom(0):setOnComplete(System.Action(arg_67_0)).uniqueId)

				return
			end)).uniqueId)

			return
		end)
		table.insert({}, function(arg_69_0)
			table.insert(arg_53_0.tweenList, LeanTween.alpha(rtf(arg_53_0.ringBoxFull), 0, 0.6):setOnComplete(System.Action(arg_69_0)).uniqueId)
			table.insert(arg_53_0.tweenList, LeanTween.alphaCanvas(arg_53_0.ringCG, 1, 0.6).uniqueId)

			return
		end)
	end

	table.insert({}, function(arg_70_0)
		arg_53_0.ringCG.alpha = 1

		arg_53_0:setMask(false)
		table.insert(arg_53_0.tweenList, LeanTween.delayedCall(0.1, System.Action(arg_70_0)).uniqueId)

		return
	end)
	table.insert({}, function(arg_71_0)
		arg_53_0.ringAnim.enabled = true

		arg_53_0.ringAnim:Play("movein")
		table.insert(arg_53_0.tweenList, LeanTween.delayedCall(arg_53_0.proposeType == "imas" and 1 or 0.5, System.Action(arg_71_0)).uniqueId)

		return
	end)
	seriesAsync({}, function()
		arg_53_0.ringAnim:Play("blink")
		table.insert(arg_53_0.tweenList, LeanTween.alphaCanvas(arg_53_0.ringTipCG, 1, 1.5):setFrom(0):setOnComplete(System.Action(function()
			setActive(arg_53_0.ringTipTF:Find("finger"), true)
			arg_53_0:enableRingDrag(true)

			return
		end)).uniqueId)

		return
	end)

	return
end

function var_0_0.ringOn(arg_74_0)
	if arg_74_0.isRingOn then
		return
	end

	setActive(arg_74_0.ringTipTF, false)

	arg_74_0.isRingOn = true

	arg_74_0.ringTF:GetComponent("DftAniEvent"):SetEndEvent(function(arg_75_0)
		arg_74_0.ringAnim.enabled = false
		arg_74_0.isRingOn = false

		if not arg_74_0.weddingReview then
			arg_74_0:emit(ProposeMediator.ON_PROPOSE, arg_74_0.shipVO.id)
		else
			arg_74_0:RingFadeout()
		end

		return
	end)

	arg_74_0.ringAnim.enabled = true

	arg_74_0.ringAnim:Play("wear")

	if arg_74_0.handId == "101" then
		table.insert(arg_74_0.tweenList, LeanTween.alphaCanvas(GetOrAddComponent(arg_74_0.handTF, typeof(CanvasGroup)), 0, 2).uniqueId)
	end

	return
end

function var_0_0.enableRingDrag(arg_76_0, arg_76_1)
	if not arg_76_0.press then
		arg_76_0:addRingDragListenter()
	end

	arg_76_0.press.enabled = arg_76_1

	return
end

function var_0_0.addRingDragListenter(arg_77_0)
	arg_77_0.press = GetOrAddComponent(arg_77_0.proposePanel, "EventTriggerListener")

	local var_77_0

	arg_77_0.press:AddBeginDragFunc(function()
		return
	end)
	arg_77_0.press:AddDragFunc(function(arg_79_0, arg_79_1)
		var_77_0 = var_77_0 or arg_79_1.position

		if arg_79_1.position.y - var_77_0.y > 100 then
			arg_77_0:setMask(true)
			arg_77_0:ringOn()
			arg_77_0:enableRingDrag(false)
		end

		return
	end)
	arg_77_0.press:AddDragEndFunc(function(arg_80_0, arg_80_1)
		return
	end)

	return
end

function var_0_0.RingFadeout(arg_81_0)
	if arg_81_0.proposeType == "imas" then
		table.insert({}, function(arg_82_0)
			setActive(arg_81_0.ringLight:GetChild(0), true)
			table.insert(arg_81_0.tweenList, LeanTween.delayedCall(3.5, System.Action(function()
				setActive(var_0, false)
				arg_82_0()

				return
			end)).uniqueId)

			return
		end)
	else
		table.insert({}, function(arg_84_0)
			table.insert(arg_81_0.tweenList, LeanTween.alphaCanvas(arg_81_0.ringLightCG, 0.7, 0.5):setFrom(0).uniqueId)
			table.insert(arg_81_0.tweenList, LeanTween.scale(arg_81_0.ringLight, Vector3(8, 8, 8), 1).uniqueId)
			table.insert(arg_81_0.tweenList, LeanTween.rotate(arg_81_0.ringLight, 90, 3):setOnComplete(System.Action(arg_84_0)).uniqueId)

			return
		end)
		table.insert({}, function(arg_85_0)
			table.insert(arg_81_0.tweenList, LeanTween.delayedCall(0.5, System.Action(arg_85_0)).uniqueId)

			return
		end)
	end

	seriesAsync({}, function()
		arg_81_0:displayShipWord("propose")

		return
	end)
	table.insert(arg_81_0.tweenList, LeanTween.delayedCall(1.2, System.Action(function()
		arg_81_0:showbgAdd(false, 1.8)

		return
	end)).uniqueId)
	table.insert(arg_81_0.tweenList, LeanTween.delayedCall(3.2, System.Action(function()
		setActive(arg_81_0.proposePanel, false)
		arg_81_0:showbgAdd(true, 2)

		return
	end)).uniqueId)

	return
end

function var_0_0.displayShipWord(arg_89_0, arg_89_1)
	local var_89_0, var_89_1, var_89_2 = ShipWordHelper.GetWordAndCV(ShipGroup.getDefaultSkin(arg_89_0.shipGroupID).id, arg_89_1)
	local var_89_3 = arg_89_0.reviewSkinID and arg_89_0.reviewSkinID or arg_89_0.proposeSkin and arg_89_0.proposeSkin.id or arg_89_0.shipVO:getSkinId()
	local var_89_4 = ShipWordHelper.GetL2dCvCalibrate(var_89_3, arg_89_1)

	arg_89_0:showStoryUI(var_89_2)

	if var_89_1 then
		local function var_89_5()
			if arg_89_0._currentVoice then
				arg_89_0._currentVoice:PlaybackStop()
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_89_1, function(arg_91_0)
				arg_89_0._currentVoice = arg_91_0

				return
			end)

			return
		end

		local var_89_6 = var_0_0.Live2DProposeDelayTime

		if not arg_89_0:useL2dOrPainting() then
			var_89_6 = 0
		end

		table.insert(arg_89_0.tweenList, LeanTween.delayedCall(var_89_6, System.Action(function()
			if arg_89_0.l2dChar and var_89_4 and var_89_4 ~= 0 then
				arg_89_0._delayVoiceTweenID = LeanTween.delayedCall(var_89_4, System.Action(function()
					var_89_5()

					arg_89_0._delayVoiceTweenID = nil

					return
				end)).uniqueId
			else
				var_89_5()
			end

			return
		end)).uniqueId)
	end

	return
end

function var_0_0.useL2dOrPainting(arg_94_0)
	return checkABExist("live2d/" .. string.lower(arg_94_0.paintingName))
end

function var_0_0.showStoryUI(arg_95_0, arg_95_1)
	if not arg_95_0.storyTF then
		table.insert({}, function(arg_96_0)
			PoolMgr.GetInstance():GetUI("ProposeStoryUI", true, function(arg_97_0)
				if arg_95_0.exited then
					PoolMgr.GetInstance():ReturnUI(var_0, arg_97_0)

					return
				end

				arg_95_0.storyTF = tf(arg_97_0)

				setParent(tf(arg_97_0), arg_95_0._tf:Find("contain"))

				arg_95_0.storyCG = GetOrAddComponent(arg_95_0.storyTF, typeof(CanvasGroup))
				arg_95_0.storyContent = arg_95_0.storyTF:Find("dialogue/content")
				arg_95_0.typeWriter = arg_95_0.storyContent:GetComponent(typeof(Typewriter))
				arg_95_0.targetNameTF = arg_95_0.storyTF:Find("dialogue/content/name")
				arg_95_0._renamePanel = arg_95_0.storyTF:Find("changeName_panel")

				setText(findTF(arg_95_0._renamePanel, "frame/name_field/Placeholder"), i18n("rename_input"))
				setActive(arg_95_0._renamePanel, false)
				onButton(arg_95_0, arg_95_0.storyTF, function()
					if arg_95_0.inTypeWritter then
						arg_95_0.typeWriter:setSpeed(arg_95_0.typeWritterSpeedUp)

						return
					end

					if not arg_95_0.initStory then
						return
					end

					table.insert(arg_95_0.tweenList, LeanTween.alphaCanvas(arg_95_0.storyCG, 0, 1):setFrom(1):setOnComplete(System.Action(function()
						setActive(arg_95_0.storyTF, false)

						return
					end)).uniqueId)

					if arg_95_0._currentVoice then
						arg_95_0._currentVoice:PlaybackStop()
					end

					arg_95_0._currentVoice = nil

					arg_95_0:setMask(true)
					table.insert(arg_95_0.tweenList, LeanTween.delayedCall(0.5, System.Action(function()
						if arg_95_0.weddingReview then
							arg_95_0:closeView()
						else
							arg_95_0:initChangeNamePanel()
							arg_95_0:stampWindow()
						end

						return
					end)).uniqueId)

					return
				end)
				arg_96_0()

				return
			end)

			return
		end)
	end

	seriesAsync({}, function()
		if arg_95_0:useL2dOrPainting() then
			arg_95_0:showLive2D("wedding")
		else
			arg_95_0:showPainting(true, 2)
		end

		setText(arg_95_0.targetNameTF:Find("Text"), (ShipGroup.getDefaultShipNameByGroupID(arg_95_0.shipGroupID)))
		setText(arg_95_0.storyContent, "")

		arg_95_0.storyCG.alpha = 0

		setActive(arg_95_0.storyTF, true)

		arg_95_0.initStory = false

		table.insert(arg_95_0.tweenList, LeanTween.alphaCanvas(arg_95_0.storyCG, 1, 1):setFrom(0):setDelay(1):setOnComplete(System.Action(function()
			if findTF(arg_95_0.targetActorTF, "fitter").childCount > 0 then
				ShipExpressionHelper.SetExpression(findTF(arg_95_0.targetActorTF, "fitter"):GetChild(0), arg_95_0.paintingName, "propose")
			end

			setText(arg_95_0.storyContent, arg_95_1)

			arg_95_0.onWords = true

			if arg_95_1 and arg_95_1 ~= "" then
				arg_95_0:TypeWriter()
			end

			arg_95_0.initStory = true

			arg_95_0:setMask(false)

			if not arg_95_0.weddingReview then
				arg_95_0:showTip()
			end

			return
		end)).uniqueId)

		return
	end)

	return
end

function var_0_0.TypeWriter(arg_103_0)
	arg_103_0.inTypeWritter = true
	arg_103_0.typeWritterSpeedUp = 0.01

	arg_103_0.typeWriter:setSpeed(0.1)
	arg_103_0.typeWriter:Play()

	function arg_103_0.typeWriter.endFunc()
		arg_103_0.inTypeWritter = false
		arg_103_0.typeWritterSpeedUp = nil

		return
	end

	return
end

function var_0_0.loadChar(arg_105_0, arg_105_1, arg_105_2, arg_105_3)
	arg_105_1 = arg_105_1 or arg_105_0._paintingTF
	arg_105_2 = arg_105_2 or "wedding"

	local var_105_0 = {}

	if not arg_105_0.actorPainting then
		table.insert(var_105_0, function(arg_106_0)
			arg_105_0.paintingName = arg_105_0.reviewSkinID and pg.ship_skin_template[arg_105_0.reviewSkinID].painting or arg_105_0.proposeSkin and arg_105_0.proposeSkin.painting or arg_105_0.shipVO:getPainting()

			local var_106_0 = arg_105_0.paintingName

			if checkABExist("painting/" .. arg_105_0.paintingName .. "_n") and PlayerPrefs.GetInt("paint_hide_other_obj_" .. var_106_0, 0) ~= 0 then
				var_106_0 = var_106_0 .. "_n"
			end

			PoolMgr.GetInstance():GetPainting(var_106_0, true, function(arg_107_0)
				local var_107_0 = findTF(arg_107_0, "Touch")

				if not IsNil(var_107_0) then
					setActive(var_107_0, false)
				end

				arg_105_0.actorPainting = arg_107_0

				ShipExpressionHelper.SetExpression(arg_105_0.actorPainting, arg_105_0.paintingName, (arg_105_0.weddingReview or arg_105_0.shipVO and arg_105_0.shipVO.propose) and "propose" or nil)
				arg_106_0()

				return
			end)

			if checkABExist("live2d/" .. string.lower(arg_105_0.paintingName)) then
				arg_105_0:createLive2D(arg_105_0.paintingName)
			end

			return
		end)
	end

	seriesAsync(var_105_0, function()
		if not IsNil(arg_105_1) then
			local var_108_0 = findTF(arg_105_1, "fitter")

			assert(var_108_0, "请添加子物体fitter")

			local var_108_1 = GetOrAddComponent(var_108_0, "PaintingScaler")

			var_108_1.FrameName = arg_105_2
			var_108_1.Tween = 1

			setParent(arg_105_0.actorPainting, var_108_0)
		end

		if arg_105_3 then
			arg_105_3()
		end

		return
	end)

	return
end

function var_0_0.createLive2D(arg_109_0, arg_109_1)
	arg_109_0.live2dRequestId = pg.Live2DMgr.GetInstance():GetLive2DModelAsync(arg_109_1, function(arg_110_0)
		GetOrAddComponent(arg_110_0.transform, typeof(DftAniEvent))

		local var_110_0 = arg_109_0.targetActorTF:Find("live2d")

		HotfixHelper.SetLayerRecursively(arg_110_0, LayerMask.NameToLayer("UI"))
		arg_110_0.transform:SetParent(var_110_0, true)

		local var_110_1 = arg_109_0.reviewSkinID and arg_109_0.reviewSkinID or arg_109_0.proposeSkin and arg_109_0.proposeSkin.id or arg_109_0.shipVO:getSkinId()

		Live2DPainting.SetL2dSortingLayer(arg_110_0, LayerWeightConst.L2D_DEFAULT_LAYER)

		arg_110_0.transform.localPosition = BuildVector3(pg.ship_skin_template[var_110_1].live2d_offset) + Vector3(0, 0, 100)

		local var_110_2 = 52

		if pg.ship_skin_template[var_110_1].live2d_offset and #pg.ship_skin_template[var_110_1].live2d_offset >= 4 then
			var_110_2 = pg.ship_skin_template[var_110_1].live2d_offset[4]
		end

		arg_110_0.transform.localScale = Vector3(var_110_2, var_110_2, var_110_2)
		arg_109_0.l2dChar = GetComponent(arg_110_0, "Live2dChar")
		arg_109_0.l2dChar.name = arg_109_1

		local var_110_3 = pg.AssistantInfo.action2Id.idle

		function arg_109_0.l2dChar.FinishAction(arg_111_0)
			if var_110_3 ~= arg_111_0 then
				arg_109_0.l2dChar:SetAction(var_110_3)
			end

			return
		end

		arg_109_0.l2dChar:SetAction(pg.AssistantInfo.action2Id.idle)

		if pg.ship_skin_template[var_110_1].lip_sync_gain and pg.ship_skin_template[var_110_1].lip_sync_gain ~= 0 then
			var_110_0:GetChild(0):GetComponent("CubismCriSrcMouthInput").Gain = pg.ship_skin_template[var_110_1].lip_sync_gain
		end

		if arg_109_1 == "mojiaduoer_4" then
			arg_109_0.l2dChar:AddParameterValue(arg_109_0.l2dChar:GetCubismParameter("ParamAngleX1"), 3, CubismParameterBlendMode.Override)
			arg_109_0.l2dChar:AddParameterValue(arg_109_0.l2dChar:GetCubismParameter("touch_drag45"), 7, CubismParameterBlendMode.Override)
		end

		local var_110_4 = arg_109_0.l2dChar:GetCubismParameter("l2d_hx")

		if var_110_4 then
			if HXSet.isHx() then
				arg_109_0.l2dChar:AddParameterValue(var_110_4, 1, CubismParameterBlendMode.Override)
			else
				arg_109_0.l2dChar:AddParameterValue(var_110_4, 0, CubismParameterBlendMode.Override)
			end
		end

		if pg.ship_skin_template[var_110_1].lip_smoothing and pg.ship_skin_template[var_110_1].lip_smoothing ~= 0 then
			var_110_0:GetChild(0):GetComponent("CubismCriSrcMouthInput").Smoothing = pg.ship_skin_template[var_110_1].lip_smoothing
		end

		return
	end)

	return
end

function var_0_0.showTip(arg_112_0)
	if not arg_112_0.proposeSkin then
		return
	end

	local var_112_0 = arg_112_0.storyTF:Find("tip")

	setText(var_112_0:Find("Image_bg/Text"), i18n("achieve_propose_tip", arg_112_0.proposeSkin.name))
	eachChild(var_112_0:Find("Image_bg/Image"), function(arg_113_0)
		setActive(arg_113_0, arg_113_0.name == arg_112_0.proposeType)

		return
	end)

	local var_112_1 = GetOrAddComponent(var_112_0, typeof(CanvasGroup))

	setActive(var_112_0, true)
	table.insert(arg_112_0.tweenList, LeanTween.alphaCanvas(var_112_1, 1, 0.01):setFrom(0).uniqueId)
	table.insert(arg_112_0.tweenList, LeanTween.alphaCanvas(var_112_1, 0, 1.5):setFrom(1):setDelay(4).uniqueId)

	return
end

function var_0_0.initChangeNamePanel(arg_114_0)
	setText(arg_114_0._renamePanel:Find("frame/border/title"), i18n("word_propose_changename_title", arg_114_0.shipVO:getName()))
	setText(arg_114_0._renamePanel:Find("frame/setting_ship_name/text"), i18n("word_propose_changename_tip1"))
	setText(arg_114_0._renamePanel:Find("frame/text"), i18n("word_propose_changename_tip2"))

	arg_114_0._renameConfirmBtn = arg_114_0._renamePanel:Find("frame/queren")
	arg_114_0._renameCancelBtn = arg_114_0._renamePanel:Find("frame/cancel")
	arg_114_0._renameToggle = findTF(arg_114_0._renamePanel, "frame/setting_ship_name"):GetComponent(typeof(Toggle))
	arg_114_0._renameRevert = arg_114_0._renamePanel:Find("frame/revert_button")
	arg_114_0._closeBtn = arg_114_0._renamePanel:Find("frame/close_btn")

	onButton(arg_114_0, arg_114_0._renameConfirmBtn, function()
		pg.PushNotificationMgr.GetInstance():setSwitchShipName(arg_114_0._renameToggle.isOn)
		arg_114_0:emit(ProposeMediator.RENAME_SHIP, arg_114_0.shipVO.id, (getInputText(findTF(arg_114_0._renamePanel, "frame/name_field"))))

		return
	end, SFX_CONFIRM)
	onButton(arg_114_0, arg_114_0._renameRevert, function()
		local var_116_0 = arg_114_0.shipVO:isRemoulded() and pg.ship_skin_template[arg_114_0.shipVO:getRemouldSkinId()].name or pg.ship_data_statistics[arg_114_0.shipVO.configId].name

		setInputText(findTF(arg_114_0._renamePanel, "frame/name_field"), var_116_0)

		return
	end, SFX_PANEL)
	onButton(arg_114_0, arg_114_0._renameCancelBtn, function()
		arg_114_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_114_0, arg_114_0._closeBtn, function()
		arg_114_0:closeView()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.DisplayRenamePanel(arg_119_0)
	if arg_119_0.shipVO:IsXIdol() then
		arg_119_0:closeView()
	else
		setParent(arg_119_0._renamePanel, arg_119_0._tf)
		setActive(arg_119_0._renamePanel, true)
		setInputText(findTF(arg_119_0._renamePanel, "frame/name_field"), (arg_119_0.shipVO:getName()))
		setIntimacyIcon(arg_119_0.intimacyTF, arg_119_0.shipVO:getIntimacyIcon())
	end

	return
end

function var_0_0.showExchangePanel(arg_120_0)
	setActive(arg_120_0.exchangePanel, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_120_0.exchangePanel)

	return
end

function var_0_0.hideExchangePanel(arg_121_0)
	setActive(arg_121_0.exchangePanel, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_121_0.exchangePanel, arg_121_0._tf)

	return
end

function var_0_0.checkPaintingRes(arg_122_0, arg_122_1, arg_122_2)
	local var_122_0 = arg_122_1:getProposeSkin()

	if var_122_0 and var_122_0.id > 0 then
		PaintingGroupConst.AddPaintingNameBySkinID({}, var_122_0.id)
	end

	PaintingGroupConst.PaintingDownload({
		isShowBox = true,
		paintingNameList = {},
		finishFunc = arg_122_2
	})

	return
end

return var_0_0
