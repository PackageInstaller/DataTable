local ProposeUI = class("ProposeUI", import("..base.BaseUI"))

ProposeUI.nationSpriteIndex = {
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

function ProposeUI:getUIName()
	return "ProposeUI"
end

function ProposeUI:setShip(arg_2_1)
	self.shipVO = arg_2_1
	self.proposeType = self.shipVO:getProposeType()

	self:setShipGroupID(self.shipVO:getGroupId())

	return
end

function ProposeUI:setShipGroupID(arg_3_1)
	self.shipGroupID = arg_3_1

	return
end

function ProposeUI:setWeddingReviewSkinID(arg_4_1)
	self.reviewSkinID = arg_4_1

	return
end

function ProposeUI:setBagProxy(arg_5_1)
	self.bagProxy = arg_5_1

	return
end

function ProposeUI:setPlayer(arg_6_1)
	self.player = arg_6_1

	return
end

function ProposeUI:init()
	self.storybg = self._tf:Find("close/bg")
	self.bgAdd = self._tf:Find("add")

	setActive(self.storybg, false)
	setActive(self.bgAdd, false)

	self.targetActorTF = self._tf:Find("actor_middle")
	self.maskTF = self._tf:Find("mask")
	self.skipBtn = self._tf:Find("skip_button")
	self.actorPainting = nil
	self.materialFace = self._tf:Find("Resource/face"):GetComponent(typeof(Image)).material
	self.materialPaint = self._tf:Find("Resource/paint"):GetComponent(typeof(Image)).material
	self.finishCallback = self.contextData.finishCallback
	self.commonTF = GameObject.Find("OverlayCamera/Overlay/UIMain/common")
	self.exchangePanel = self._tf:Find("exchange_panel")

	local var_7_0 = self.exchangePanel:Find("window/msg_panel/content")

	setText(var_7_0:Find("text"), i18n("word_propose_cost_tip2"))

	for iter_7_0, iter_7_1 in ipairs(pg.gameset.vow_prop_conversion.description) do
		local var_7_1 = Drop.New({
			count = 1,
			type = DROP_TYPE_ITEM,
			id = iter_7_1
		})

		updateDrop(var_7_0:Find("icon_" .. iter_7_0), var_7_1)
		onButton(self, var_7_0:Find("icon_" .. iter_7_0), function()
			self:emit(BaseUI.ON_DROP, var_7_1)

			return
		end, SFX_PANEL)
	end

	onButton(self, self.exchangePanel:Find("bg"), function()
		self:hideExchangePanel()

		return
	end, SFX_CANCEL)
	onButton(self, self.exchangePanel:Find("window/top/btnBack"), function()
		self:hideExchangePanel()

		return
	end, SFX_CANCEL)
	onButton(self, self.exchangePanel:Find("window/button_container/cancel"), function()
		self:hideExchangePanel()

		return
	end, SFX_CANCEL)
	onButton(self, self.exchangePanel:Find("window/button_container/confirm"), function()
		if getProxy(BagProxy):getItemCountById(ITEM_ID_FOR_PROPOSE) > 0 then
			self:emit(ProposeMediator.EXCHANGE_TIARA)
		else
			ItemTipPanel.ShowRingBuyTip()
		end

		self:hideExchangePanel()

		return
	end, SFX_CONFIRM)

	self.tweenList = {}

	return
end

function ProposeUI:didEnter()
	self:emit(ProposeMediator.HIDE_SHIP_MAIN_WORD)

	if self.commonTF then
		setActive(self.commonTF, false)
	end

	if self.contextData.review then
		self.weddingReview = true
		self.proposeType = self.contextData.group:getProposeType()
		self.bgName = Nation.Nation2BG((self.contextData.group:getNation())) or Nation.Nation2BG(0)

		onButton(self, self.skipBtn, function()
			self:closeView()

			return
		end, SFX_CANCEL)
		pg.UIMgr.GetInstance():BlurPanel(self._tf)
		self:doPlay()
	else
		self:doMain()
	end

	return
end

function ProposeUI:doPlay()
	setActive(self.skipBtn, self.weddingReview)
	self:setMask(true)
	pg.BgmMgr.GetInstance():TempPlay("wedding")
	self:showProposePanel()

	return
end

function ProposeUI:doMain()
	onButton(self, self.skipBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("close0"), function()
		if self.proposeEndFlag then
			self:DisplayRenamePanel()
		else
			self:closeView()
		end

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("close_end"), function()
		if self.proposeEndFlag then
			self:DisplayRenamePanel()
		else
			self:closeView()
		end

		return
	end, SFX_CANCEL)

	local var_16_0 = self.shipVO:getConfigTable().nationality
	local var_16_1 = "Propose" .. Nation.Nation2Side(var_16_0) .. "UI"

	self.bgName = Nation.Nation2BG(var_16_0) or Nation.Nation2BG(0)

	PoolMgr.GetInstance():GetUI(var_16_1, true, function(arg_20_0)
		if self.exited then
			PoolMgr.GetInstance():ReturnUI(var_16_1, arg_20_0)

			return
		end

		self.window = tf(arg_20_0)

		setParent(tf(arg_20_0), self._tf:Find("window"))

		self.intimacyTF = self.window:Find("intimacy/icon")
		self.intimacyValueTF = self.window:Find("intimacy/value")
		self.button = self.window:Find("button")
		self.giftButton = self.window:Find("giftBtn")
		self.intimacyDesc = self.window:Find("desc")
		self.intimacydescTime = self.window:Find("descPic/desc_time")
		self.intimacyDescPic = self.window:Find("descPic")
		self.intimacyBuffDesc = self.window:Find("desc_buff")
		self._paintingTF = self.window:Find("paintMask/paint")
		self.intimacyAchieved = self.window:Find("intimacy/achieved")
		self.intimacyNoAchieved = self.window:Find("intimacy/no_achieved")
		self.ringAchieved = self.window:Find("ringCount/achieved")
		self.ringNoAchieved = self.window:Find("ringCount/no_achieved")
		self.ringValue = self.window:Find("ringCount/value")
		self.nameTF = self.window:Find("title1/Text")
		self.shipNameTF = self.window:Find("title2/Text")
		self.campTF = self.window:Find("Camp")
		self.doneTF = self.window:Find("done")
		self.CampSprite = self.window:Find("CampSprite")

		setActive(self.window, true)
		setText(self.nameTF, self.player.name)
		setText(self.shipNameTF, self.shipVO:getName())

		if self.CampSprite then
			local var_20_0 = getImageSprite(self.CampSprite:Find(Nation.Nation2Print(var_16_0)))

			if not var_20_0 then
				warning("找不到印花, shipConfigId: " .. self.shipVO.configId)
				setActive(self.campTF, false)
			else
				setImageSprite(self.campTF, var_20_0, false)
				setActive(self.campTF, true)
			end
		end

		setIntimacyIcon(self.intimacyTF, self.shipVO:getIntimacyIcon())

		local var_20_1, var_20_2 = self.shipVO:getIntimacyDetail()

		setText(self.intimacyValueTF, i18n("propose_intimacy_tip", var_20_2))

		if var_20_2 >= 100 then
			setTextColor(self.intimacyValueTF, Color.white)
		else
			setTextColor(self.intimacyValueTF, Color.New(0.5843137254901961, 0.5215686274509804, 0.40784313725490196))
		end

		setActive(self.intimacyAchieved, self.shipVO.propose or var_20_2 >= 100)
		setActive(self.intimacyNoAchieved, var_20_2 < 100 and not self.shipVO.propose)
		self:onUpdateItemCount()
		setActive(self.doneTF, self.shipVO.propose)

		local var_20_3, var_20_4 = self.shipVO:getIntimacyInfo()

		if self.shipVO.propose then
			if self.intimacyDescPic then
				setActive(self.intimacyDescPic, true)
				self:onUpdateIntimacydescTime(self.shipVO.proposeTime)
			end

			if self.intimacyDesc then
				setActive(self.intimacyDesc, not self.intimacyDescPic)
				setText(self.intimacyDesc, (self:getProposeText()))
			end
		else
			if self.intimacyDesc and GetComponent(self.intimacyDesc, "VerticalText") then
				GetComponent(self.intimacyDesc, "VerticalText").enabled = false
			end

			if self.intimacyDescPic then
				setActive(self.intimacyDescPic, false)
			end

			if self.intimacyDesc then
				setActive(self.intimacyDesc, true)
				setText(self.intimacyDesc, i18n(var_20_4, self.shipVO.name))
			end
		end

		setText(self.intimacyBuffDesc, "*" .. i18n(var_20_4 .. "_buff"))
		self:loadChar()
		pg.UIMgr.GetInstance():BlurPanel(self._tf)
		setActive(self.button, not self.shipVO:ShowPropose())

		local var_20_5 = not self.shipVO.propose and var_20_1 <= var_20_2
		local var_20_6 = self.shipVO.propose

		if self.shipVO.propose then
			var_20_6 = not self.shipVO:ShowPropose()
		end

		self.button:GetComponent(typeof(Button)).interactable = var_20_5 or var_20_6

		onButton(self, self.button, function()
			if var_20_5 then
				local var_21_0 = self.bagProxy:getItemCountById(self:getProposeItemId())

				if var_21_0 < 1 then
					if self.proposeType == "imas" then
						self:showExchangePanel()
					else
						ItemTipPanel.ShowRingBuyTip()
					end

					return
				end

				local var_21_1, var_21_2 = ShipStatus.ShipStatusCheck("onPropose", self.shipVO)

				if not var_21_1 then
					pg.TipsMgr.GetInstance():ShowTips(var_21_2)

					return
				end

				self:checkPaintingRes(self.shipVO, function()
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("word_propose_cost_tip" .. (self.proposeType == "imas" and "1" or ""), var_21_0),
						onYes = function()
							if self.intimacydescTime then
								self:onUpdateIntimacydescTime(pg.TimeMgr.GetInstance():GetServerTime())
							end

							self:hideWindow()
							setActive(self.window, false)
							self:doPlay()

							return
						end
					})

					return
				end)
			elseif var_20_6 then
				function self.afterRegisterCall()
					self.afterRegisterCall = nil

					pg.TipsMgr.GetInstance():ShowTips(i18n("word_propose_switch_tip"))
					self:closeView()

					return
				end

				self:emit(ProposeMediator.REGISTER_SHIP, self.shipVO.id)
			else
				self:closeView()
			end

			return
		end, SFX_PANEL)
		setActive(self.giftButton, not LOCK_SHIP_GIFT)
		onButton(self, self.giftButton, function()
			if LOCK_SHIP_GIFT then
				return
			end

			self:emit(ProposeMediator.GIFT_SHIP, self.shipVO.id)

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function ProposeUI:getProposeText()
	local var_26_0 = ""

	if PLATFORM_CODE ~= PLATFORM_CH then
		if PLATFORM_CODE == PLATFORM_CHT then
			var_26_0 = i18n("intimacy_desc_propose", pg.TimeMgr.GetInstance():ChieseDescTime(self.shipVO.proposeTime, true))

			if not IsNil(GetComponent(self.intimacyDesc, "VerticalText")) then
				GetComponent(self.intimacyDesc, "VerticalText").enabled = true
				var_26_0 = i18n("intimacy_desc_propose_vertical", pg.TimeMgr.GetInstance():ChieseDescTime(self.shipVO.proposeTime, true))
			end
		elseif PLATFORM_CODE == PLATFORM_KR then
			var_26_0 = i18n("intimacy_desc_propose", pg.TimeMgr.GetInstance():STimeDescS(self.shipVO.proposeTime, "%Y년%m월%d일", true))

			if not IsNil(GetComponent(self.intimacyDesc, "VerticalText")) then
				GetComponent(self.intimacyDesc, "VerticalText").enabled = true
				var_26_0 = i18n("intimacy_desc_propose_vertical", pg.TimeMgr.GetInstance():STimeDescS(self.shipVO.proposeTime, "%Y년%m월%d일"))
			end
		end
	end

	var_26_0 = i18n("intimacy_desc_propose", pg.TimeMgr.GetInstance():STimeDescS(self.shipVO.proposeTime, "%Y/%m/%d", true))

	if not IsNil(GetComponent(self.intimacyDesc, "VerticalText")) then
		GetComponent(self.intimacyDesc, "VerticalText").enabled = true
		var_26_0 = i18n("intimacy_desc_propose_vertical", pg.TimeMgr.GetInstance():STimeDescS(self.shipVO.proposeTime, "%Y/%m/%d"))
	end

	return var_26_0
end

function ProposeUI:getProposeItemId()
	if self.proposeType == "imas" then
		return ITEM_ID_FOR_PROPOSE_IMAS
	else
		return ITEM_ID_FOR_PROPOSE
	end

	return
end

function ProposeUI:onUpdateItemCount()
	local var_28_0 = self.bagProxy:getItemCountById(self:getProposeItemId())

	setActive(self.ringAchieved, self.shipVO.propose or var_28_0 > 0)
	setActive(self.ringNoAchieved, var_28_0 <= 0 and not self.shipVO.propose)
	setText(self.ringValue, i18n(self.proposeType == "imas" and "intimacy_desc_tiara" or "intimacy_desc_ring"))

	if self.shipVO.propose or var_28_0 > 0 then
		setTextColor(self.ringValue, Color.white)
	else
		setTextColor(self.ringValue, Color.New(0.5843137254901961, 0.5215686274509804, 0.40784313725490196))
	end

	if self.proposeType == "imas" then
		local var_28_1 = not self.shipVO.propose and var_28_0 == 0

		setActive(self.window:Find("ringCount/bg_exchange"), not self.shipVO.propose and var_28_0 == 0)
		setActive(self.window:Find("ringCount/icon/btn_exchange"), var_28_1)
		onButton(self, self.window:Find("ringCount/icon/btn_exchange"), function()
			self:showExchangePanel()

			return
		end, SFX_PANEL)
	else
		setActive(self.window:Find("ringCount/icon/base"), PLATFORM_CODE ~= PLATFORM_CH)
		setActive(self.window:Find("ringCount/icon/hx"), PLATFORM_CODE == PLATFORM_CH)
	end

	return
end

function ProposeUI:onUpdateIntimacydescTime(arg_30_1)
	setText(self.intimacydescTime, pg.TimeMgr.GetInstance():STimeDescS(arg_30_1, PLATFORM_CODE == PLATFORM_JP and (self.proposeType == "imas" and "%Y.%m.%d" or "%B.%d,    %y") or PLATFORM_CODE == PLATFORM_US and "%B %d, %Y" or self.proposeType == "imas" and i18n("intimacy_desc_day") .. " %Y.%m.%d" or "%B.%d,    %y"))

	return
end

function ProposeUI:onBackPressed()
	if isActive(self.exchangePanel) then
		self:hideExchangePanel()

		return
	end

	if self.window and isActive(self.window) then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		triggerButton(self._tf:Find("close_end"))
	end

	return
end

function ProposeUI:willExit()
	if self._currentVoice then
		self._currentVoice:PlaybackStop()
	end

	self._currentVoice = nil

	pg.BgmMgr.GetInstance():ContinuePlay()

	if not IsNil(self.actorPainting) then
		local var_32_0 = tf(self.actorPainting)

		if var_32_0:Find("temp_mask") then
			Destroy(var_32_0:Find("temp_mask"))
		end

		var_32_0:GetComponent(typeof(Image)).material = nil

		PoolMgr.GetInstance():ReturnPainting(self.paintingName, self.actorPainting)

		self.actorPainting = nil
	end

	if self.delayTId then
		LeanTween.cancel(self.delayTId)
	end

	if self.commonTF then
		setActive(self.commonTF, true)
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.l2dChar then
		self.l2dChar:ClearPics()

		self.l2dChar = nil
	end

	if self.live2dRequestId then
		pg.Live2DMgr.GetInstance():StopLoadingLive2d(self.live2dRequestId)

		self.live2dRequestId = nil
	end

	if self._delayVoiceTweenID then
		LeanTween.cancel(self._delayVoiceTweenID)

		self._delayVoiceTweenID = nil
	end

	if self.tweenList then
		cancelTweens(self.tweenList)

		self.tweenList = nil
	end

	if self.contextData.callback then
		self.contextData.callback()
	end

	if self.finishCallback then
		self.finishCallback()

		self.finishCallback = nil
	end

	return
end

function ProposeUI:setMask(arg_33_1)
	setActive(self.maskTF, arg_33_1)

	return
end

function ProposeUI:bgAddAnimation(arg_34_1)
	setActive(self.storybg, true)
	self:showbgAdd(true, arg_34_1)

	return
end

function ProposeUI:showbgChurch()
	table.insert(self.tweenList, LeanTween.scale(self.storybg, Vector3(1, 1, 1), 6).uniqueId)
	setActive(self.churchLight, true)
	table.insert(self.tweenList, LeanTween.delayedCall(6, System.Action(function()
		setActive(self.churchLight, false)

		return
	end)).uniqueId)

	return
end

function ProposeUI:showbgAdd(arg_37_1, arg_37_2)
	table.insert(self.tweenList, LeanTween.alphaCanvas(GetOrAddComponent(self.bgAdd, typeof(CanvasGroup)), arg_37_1 and 0 or 1, arg_37_2):setFrom(arg_37_1 and 1 or 0).uniqueId)
	setActive(self.bgAdd, true)

	return
end

function ProposeUI:showBlackBG(arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_1 and 1 or 0
	local var_38_1 = arg_38_1 and 0 or 1
	local var_38_2 = GetOrAddComponent(self.blackBG, typeof(CanvasGroup))

	setActive(self.blackBG, true)
	table.insert(self.tweenList, LeanTween.alphaCanvas(var_38_2, var_38_1, arg_38_2):setFrom(var_38_0):setOnComplete(System.Action(function()
		if arg_38_1 then
			setActive(self.blackBG, false)
		end

		if arg_38_3 then
			arg_38_3()
		end

		return
	end)).uniqueId)

	return
end

function ProposeUI:showPainting(arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = {}

	if arg_40_1 then
		table.insert(var_40_0, function(arg_41_0)
			self:loadChar(self.targetActorTF, "duihua", arg_41_0)

			return
		end)
	end

	seriesAsync(var_40_0, function()
		table.insert(self.tweenList, LeanTween.alphaCanvas(GetOrAddComponent(self.targetActorTF, typeof(CanvasGroup)), arg_40_1 and 1 or 0, arg_40_2):setFrom(arg_40_1 and 0 or 1):setOnComplete(System.Action(function()
			if arg_40_3 then
				arg_40_3()
			end

			return
		end)).uniqueId)

		return
	end)

	return
end

ProposeUI.Live2DProposeDelayTime = 2

function ProposeUI:showLive2D(arg_44_1)
	setActive(self.targetActorTF:Find("fitter"), false)
	setActive(self.targetActorTF:Find("live2d"), true)
	table.insert(self.tweenList, LeanTween.alphaCanvas(GetOrAddComponent(self.targetActorTF, typeof(CanvasGroup)), 1, ProposeUI.Live2DProposeDelayTime):setFrom(0):setOnComplete(System.Action(function()
		self:changeParamaterValue("Paramring", 1)
		self.l2dChar:SetAction(pg.AssistantInfo.action2Id[arg_44_1])

		return
	end)).uniqueId)

	return
end

function ProposeUI:changeParamaterValue(arg_46_1, arg_46_2)
	if not arg_46_1 or string.len(arg_46_1) == 0 then
		return
	end

	local var_46_0 = self.l2dChar:GetCubismParameter(arg_46_1)

	if not var_46_0 then
		return
	end

	self.l2dChar:AddParameterValue(var_46_0, arg_46_2, CubismParameterBlendMode.Override)

	return
end

function ProposeUI:hideWindow()
	local var_47_0 = GetOrAddComponent(self.window, typeof(CanvasGroup))

	var_47_0.interactable = false

	table.insert(self.tweenList, LeanTween.alphaCanvas(var_47_0, 0, 0.2):setFrom(1):setOnComplete(System.Action(function()
		var_47_0.interactable = true

		return
	end)).uniqueId)

	return
end

function ProposeUI:stampWindow()
	self.proposeEndFlag = true

	self:loadChar(nil, nil, function()
		return
	end)
	setActive(self.window, true)
	setActive(self.button, false)
	setActive(self.giftButton, false)
	setActive(self.targetActorTF:Find("live2d"), false)

	local var_49_0

	if self.intimacyDescPic then
		setActive(self.intimacyDescPic, true)

		var_49_0 = GetOrAddComponent(self.intimacyDescPic, typeof(CanvasGroup))
	end

	if self.intimacyDesc then
		setActive(self.intimacyDesc, not self.intimacyDescPic)
		setText(self.intimacyDesc, (self:getProposeText()))

		var_49_0 = GetOrAddComponent(self.intimacyDesc, typeof(CanvasGroup))
	end

	setText(self.intimacyBuffDesc, "")
	setActive(self.doneTF, false)

	var_49_0.alpha = 0

	local var_49_1 = GetOrAddComponent(self.window, typeof(CanvasGroup))

	var_49_1.interactable = false

	table.insert(self.tweenList, LeanTween.alphaCanvas(var_49_1, 1, 0.8):setFrom(0).uniqueId)
	table.insert(self.tweenList, LeanTween.delayedCall(1.5, System.Action(function()
		table.insert(self.tweenList, LeanTween.alphaCanvas(var_49_0, 1, 2):setFrom(0).uniqueId)

		return
	end)).uniqueId)

	self.delayTId = LeanTween.delayedCall(5, System.Action(function()
		if not var_49_1 then
			return
		end

		var_49_1.interactable = true

		setActive(self.doneTF, true)
		self:setMask(false)
		setActive(self._tf:Find("close_end"), true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_SEAL)

		return
	end)).id

	return
end

function ProposeUI:showProposePanel()
	local var_53_0 = {}

	self.proposeSkin = ShipGroup.getProposeSkin(self.shipGroupID)

	if self.proposeSkin and self.actorPainting then
		local var_53_1 = tf(self.actorPainting)

		if var_53_1:Find("temp_mask") then
			Destroy(var_53_1:Find("temp_mask"))
		end

		var_53_1:GetComponent(typeof(Image)).material = nil

		PoolMgr.GetInstance():ReturnPainting(self.paintingName, self.actorPainting)

		self.actorPainting = nil
	end

	if not self.proposePanel then
		table.insert(var_53_0, function(arg_54_0)
			local var_54_0 = "ProposeRingUI"

			PoolMgr.GetInstance():GetUI("ProposeRingUI", true, function(arg_55_0)
				if self.exited then
					PoolMgr.GetInstance():ReturnUI(var_54_0, arg_55_0)

					return
				end

				self.proposePanel = tf(arg_55_0)

				setParent(tf(arg_55_0), self._tf:Find("contain"))
				eachChild(self.proposePanel:Find("ringBox"), function(arg_56_0)
					setActive(arg_56_0, arg_56_0.name == self.proposeType)

					if arg_56_0.name == self.proposeType then
						self.ringBoxTF = arg_56_0
					end

					return
				end)

				self.ringBoxCG = GetOrAddComponent(self.ringBoxTF, typeof(CanvasGroup))
				self.ringBoxFull = self.ringBoxTF:Find("full")
				self.churchBefore = self.proposePanel:Find("before")
				self.churchLight = self.churchBefore:Find("light")

				setParent(self.churchLight, self._tf)
				self.churchLight:SetSiblingIndex(2)

				self.blackBG = self.churchBefore:Find("blackbg")
				self.doorLightBG = self.churchBefore:Find("door_light")
				self.door = self.churchBefore:Find("door")
				self.doorAni = GetOrAddComponent(self.door, "SpineAnimUI")

				setParent(self.churchBefore, self._tf:Find("contain"))

				self.ringTipTF = self.proposePanel:Find("tip")
				self.ringTipCG = GetOrAddComponent(self.ringTipTF, typeof(CanvasGroup))

				setText(self.ringTipTF:Find("Text"), i18n(self.proposeType == "imas" and "word_propose_tiara_tip" or "word_propose_ring_tip"))
				setActive(self.ringTipTF:Find("finger"), false)
				LoadImageSpriteAsync(self.bgName, self.storybg)

				self.storybg.localScale = Vector3(1.2, 1.2, 1.2)

				local var_55_0

				if self.weddingReview then
					var_55_0 = self.reviewSkinID or self.shipVO:getSkinId()
				end

				self.handId = pg.ship_skin_template[var_55_0].hand_id

				if SPECIAL_PROPOSE and SPECIAL_PROPOSE[1] == pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y%m%d", true) then
					for iter_55_0, iter_55_1 in ipairs(SPECIAL_PROPOSE[2]) do
						if iter_55_1[1] == var_55_0 then
							self.handId = iter_55_1[2]
						end
					end
				end

				local var_55_1 = ({
					default = "",
					meta = "Meta_",
					imas = "Imas_"
				})[self.proposeType] .. "ProposeHand_" .. self.handId

				self.handName = var_55_1

				PoolMgr.GetInstance():GetUI(var_55_1, true, function(arg_57_0)
					if self.exited then
						PoolMgr.GetInstance():ReturnUI(var_55_1, arg_57_0)

						return
					end

					self.transHand = tf(arg_57_0)

					setActive(self.transHand, false)
					setParent(self.transHand, self.proposePanel)
					self.transHand:SetAsFirstSibling()

					self.handTF = self.transHand:Find("hand")
					self.ringTF = self.transHand:Find("ring")
					self.ringCG = GetOrAddComponent(self.ringTF, typeof(CanvasGroup))
					self.ringAnim = self.ringTF:GetComponent(typeof(Animator))
					self.ringAnim.enabled = false
					self.ringLight = self.ringTF:Find("ring_light")
					self.ringLightCG = GetOrAddComponent(self.ringLight, typeof(CanvasGroup))

					arg_54_0()

					return
				end)

				return
			end)

			return
		end)
	end

	table.insert(var_53_0, function(arg_58_0)
		table.insert(self.tweenList, LeanTween.scale(self.door, Vector3(2.1, 2.1, 2.1), 4).uniqueId)
		self.doorAni:SetActionCallBack(function(arg_59_0)
			if arg_59_0 == "FINISH" then
				self.doorAni:SetActionCallBack(nil)
				setActive(self.door, false)
				self:showBlackBG(true, 0.1)
				setActive(self.doorLightBG, false)
				arg_58_0()
			end

			return
		end)
		table.insert(self.tweenList, LeanTween.delayedCall(2, System.Action(function()
			self:showbgAdd(false, 2)

			return
		end)).uniqueId)
		table.insert(self.tweenList, LeanTween.alpha(rtf(self.doorLightBG), 1, 2):setFrom(0).uniqueId)
		self:showBlackBG(false, 0.1)
		self.doorAni:SetAction("OPEN", 0)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_DOOR)

		return
	end)
	table.insert(var_53_0, function(arg_61_0)
		self.handTF:GetComponent(typeof(Image)).color = Color.New(1, 1, 1, 0)

		self:bgAddAnimation(2)
		table.insert(self.tweenList, LeanTween.delayedCall(2, System.Action(function()
			self:showPainting(true, 1.5, function()
				table.insert(self.tweenList, LeanTween.delayedCall(1.5, System.Action(arg_61_0)).uniqueId)

				return
			end)

			return
		end)).uniqueId)

		return
	end)
	table.insert(var_53_0, function(arg_64_0)
		self:showBlackBG(false, 1.2, function()
			self:showBlackBG(true, 1.2)

			return
		end)
		self:showPainting(false, 1, arg_64_0)

		return
	end)
	table.insert(var_53_0, function(arg_66_0)
		setAnchoredPosition(self.handTF, {
			y = self.handTF.rect.height
		})
		setAnchoredPosition(self.ringTF, {
			y = 0
		})
		setActive(self.proposePanel, true)
		setActive(self.transHand, true)

		self.ringBoxCG.alpha = 0
		self.ringCG.alpha = 0

		arg_66_0()

		return
	end)

	if self.proposeType ~= "imas" then
		table.insert(var_53_0, function(arg_67_0)
			table.insert(self.tweenList, LeanTween.alpha(rtf(self.handTF), 1, 1.2).uniqueId)
			table.insert(self.tweenList, LeanTween.moveY(rtf(self.handTF), 0, 2):setOnComplete(System.Action(function()
				table.insert(self.tweenList, LeanTween.alphaCanvas(self.ringBoxCG, 1, 1.5):setFrom(0):setOnComplete(System.Action(arg_67_0)).uniqueId)

				return
			end)).uniqueId)

			return
		end)
		table.insert(var_53_0, function(arg_69_0)
			table.insert(self.tweenList, LeanTween.alpha(rtf(self.ringBoxFull), 0, 0.6):setOnComplete(System.Action(arg_69_0)).uniqueId)
			table.insert(self.tweenList, LeanTween.alphaCanvas(self.ringCG, 1, 0.6).uniqueId)

			return
		end)
	end

	table.insert(var_53_0, function(arg_70_0)
		self.ringCG.alpha = 1

		self:setMask(false)
		table.insert(self.tweenList, LeanTween.delayedCall(0.1, System.Action(arg_70_0)).uniqueId)

		return
	end)
	table.insert(var_53_0, function(arg_71_0)
		self.ringAnim.enabled = true

		self.ringAnim:Play("movein")
		table.insert(self.tweenList, LeanTween.delayedCall(self.proposeType == "imas" and 1 or 0.5, System.Action(arg_71_0)).uniqueId)

		return
	end)
	seriesAsync(var_53_0, function()
		self.ringAnim:Play("blink")
		table.insert(self.tweenList, LeanTween.alphaCanvas(self.ringTipCG, 1, 1.5):setFrom(0):setOnComplete(System.Action(function()
			setActive(self.ringTipTF:Find("finger"), true)
			self:enableRingDrag(true)

			return
		end)).uniqueId)

		return
	end)

	return
end

function ProposeUI:ringOn()
	if self.isRingOn then
		return
	end

	setActive(self.ringTipTF, false)

	self.isRingOn = true

	self.ringTF:GetComponent("DftAniEvent"):SetEndEvent(function(arg_75_0)
		self.ringAnim.enabled = false
		self.isRingOn = false

		if not self.weddingReview then
			self:emit(ProposeMediator.ON_PROPOSE, self.shipVO.id)
		else
			self:RingFadeout()
		end

		return
	end)

	self.ringAnim.enabled = true

	self.ringAnim:Play("wear")

	if self.handId == "101" then
		table.insert(self.tweenList, LeanTween.alphaCanvas(GetOrAddComponent(self.handTF, typeof(CanvasGroup)), 0, 2).uniqueId)
	end

	return
end

function ProposeUI:enableRingDrag(arg_76_1)
	if not self.press then
		self:addRingDragListenter()
	end

	self.press.enabled = arg_76_1

	return
end

function ProposeUI:addRingDragListenter()
	self.press = GetOrAddComponent(self.proposePanel, "EventTriggerListener")

	local var_77_0

	self.press:AddBeginDragFunc(function()
		return
	end)
	self.press:AddDragFunc(function(arg_79_0, arg_79_1)
		var_77_0 = var_77_0 or arg_79_1.position

		if arg_79_1.position.y - var_77_0.y > 100 then
			self:setMask(true)
			self:ringOn()
			self:enableRingDrag(false)
		end

		return
	end)
	self.press:AddDragEndFunc(function(arg_80_0, arg_80_1)
		return
	end)

	return
end

function ProposeUI:RingFadeout()
	local var_81_0 = {}

	if self.proposeType == "imas" then
		table.insert(var_81_0, function(arg_82_0)
			local var_82_0 = self.ringLight:GetChild(0)

			setActive(var_82_0, true)
			table.insert(self.tweenList, LeanTween.delayedCall(3.5, System.Action(function()
				setActive(var_82_0, false)
				arg_82_0()

				return
			end)).uniqueId)

			return
		end)
	else
		table.insert(var_81_0, function(arg_84_0)
			table.insert(self.tweenList, LeanTween.alphaCanvas(self.ringLightCG, 0.7, 0.5):setFrom(0).uniqueId)
			table.insert(self.tweenList, LeanTween.scale(self.ringLight, Vector3(8, 8, 8), 1).uniqueId)
			table.insert(self.tweenList, LeanTween.rotate(self.ringLight, 90, 3):setOnComplete(System.Action(arg_84_0)).uniqueId)

			return
		end)
		table.insert(var_81_0, function(arg_85_0)
			table.insert(self.tweenList, LeanTween.delayedCall(0.5, System.Action(arg_85_0)).uniqueId)

			return
		end)
	end

	seriesAsync(var_81_0, function()
		self:displayShipWord("propose")

		return
	end)
	table.insert(self.tweenList, LeanTween.delayedCall(1.2, System.Action(function()
		self:showbgAdd(false, 1.8)

		return
	end)).uniqueId)
	table.insert(self.tweenList, LeanTween.delayedCall(3.2, System.Action(function()
		setActive(self.proposePanel, false)
		self:showbgAdd(true, 2)

		return
	end)).uniqueId)

	return
end

function ProposeUI:displayShipWord(arg_89_1)
	local var_89_0, var_89_1, var_89_2 = ShipWordHelper.GetWordAndCV(ShipGroup.getDefaultSkin(self.shipGroupID).id, arg_89_1)
	local var_89_4 = ShipWordHelper.GetL2dCvCalibrate(self.reviewSkinID and self.reviewSkinID or self.proposeSkin and self.proposeSkin.id or self.shipVO:getSkinId(), arg_89_1)

	self:showStoryUI(var_89_2)

	if var_89_1 then
		local function var_89_5()
			if self._currentVoice then
				self._currentVoice:PlaybackStop()
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_89_1, function(arg_91_0)
				self._currentVoice = arg_91_0

				return
			end)

			return
		end

		table.insert(self.tweenList, LeanTween.delayedCall((not self:useL2dOrPainting() or nil) and 0, System.Action(function()
			if self.l2dChar and var_89_4 and var_89_4 ~= 0 then
				self._delayVoiceTweenID = LeanTween.delayedCall(var_89_4, System.Action(function()
					var_89_5()

					self._delayVoiceTweenID = nil

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

function ProposeUI:useL2dOrPainting()
	return checkABExist("live2d/" .. string.lower(self.paintingName))
end

function ProposeUI:showStoryUI(arg_95_1)
	local var_95_0 = {}

	if not self.storyTF then
		table.insert(var_95_0, function(arg_96_0)
			local var_96_0 = "ProposeStoryUI"

			PoolMgr.GetInstance():GetUI("ProposeStoryUI", true, function(arg_97_0)
				if self.exited then
					PoolMgr.GetInstance():ReturnUI(var_96_0, arg_97_0)

					return
				end

				self.storyTF = tf(arg_97_0)

				setParent(tf(arg_97_0), self._tf:Find("contain"))

				self.storyCG = GetOrAddComponent(self.storyTF, typeof(CanvasGroup))
				self.storyContent = self.storyTF:Find("dialogue/content")
				self.typeWriter = self.storyContent:GetComponent(typeof(Typewriter))
				self.targetNameTF = self.storyTF:Find("dialogue/content/name")
				self._renamePanel = self.storyTF:Find("changeName_panel")

				setText(findTF(self._renamePanel, "frame/name_field/Placeholder"), i18n("rename_input"))
				setActive(self._renamePanel, false)
				onButton(self, self.storyTF, function()
					if self.inTypeWritter then
						self.typeWriter:setSpeed(self.typeWritterSpeedUp)

						return
					end

					if not self.initStory then
						return
					end

					table.insert(self.tweenList, LeanTween.alphaCanvas(self.storyCG, 0, 1):setFrom(1):setOnComplete(System.Action(function()
						setActive(self.storyTF, false)

						return
					end)).uniqueId)

					if self._currentVoice then
						self._currentVoice:PlaybackStop()
					end

					self._currentVoice = nil

					self:setMask(true)
					table.insert(self.tweenList, LeanTween.delayedCall(0.5, System.Action(function()
						if self.weddingReview then
							self:closeView()
						else
							self:initChangeNamePanel()
							self:stampWindow()
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

	seriesAsync(var_95_0, function()
		if self:useL2dOrPainting() then
			self:showLive2D("wedding")
		else
			self:showPainting(true, 2)
		end

		setText(self.targetNameTF:Find("Text"), (ShipGroup.getDefaultShipNameByGroupID(self.shipGroupID)))
		setText(self.storyContent, "")

		self.storyCG.alpha = 0

		setActive(self.storyTF, true)

		self.initStory = false

		table.insert(self.tweenList, LeanTween.alphaCanvas(self.storyCG, 1, 1):setFrom(0):setDelay(1):setOnComplete(System.Action(function()
			if findTF(self.targetActorTF, "fitter").childCount > 0 then
				ShipExpressionHelper.SetExpression(findTF(self.targetActorTF, "fitter"):GetChild(0), self.paintingName, "propose")
			end

			setText(self.storyContent, arg_95_1)

			self.onWords = true

			if arg_95_1 and arg_95_1 ~= "" then
				self:TypeWriter()
			end

			self.initStory = true

			self:setMask(false)

			if not self.weddingReview then
				self:showTip()
			end

			return
		end)).uniqueId)

		return
	end)

	return
end

function ProposeUI:TypeWriter()
	self.inTypeWritter = true
	self.typeWritterSpeedUp = 0.01

	self.typeWriter:setSpeed(0.1)
	self.typeWriter:Play()

	function self.typeWriter.endFunc()
		self.inTypeWritter = false
		self.typeWritterSpeedUp = nil

		return
	end

	return
end

function ProposeUI:loadChar(arg_105_1, arg_105_2, arg_105_3)
	arg_105_1 = arg_105_1 or self._paintingTF
	arg_105_2 = arg_105_2 or "wedding"

	local var_105_0 = {}

	if not self.actorPainting then
		table.insert(var_105_0, function(arg_106_0)
			self.paintingName = self.reviewSkinID and pg.ship_skin_template[self.reviewSkinID].painting or self.proposeSkin and self.proposeSkin.painting or self.shipVO:getPainting()

			local var_106_0 = self.paintingName

			if checkABExist("painting/" .. self.paintingName .. "_n") and PlayerPrefs.GetInt("paint_hide_other_obj_" .. var_106_0, 0) ~= 0 then
				var_106_0 = var_106_0 .. "_n"
			end

			PoolMgr.GetInstance():GetPainting(var_106_0, true, function(arg_107_0)
				local var_107_0 = findTF(arg_107_0, "Touch")

				if not IsNil(var_107_0) then
					setActive(var_107_0, false)
				end

				self.actorPainting = arg_107_0

				ShipExpressionHelper.SetExpression(self.actorPainting, self.paintingName, (self.weddingReview or self.shipVO and self.shipVO.propose) and "propose" or nil)
				arg_106_0()

				return
			end)

			if checkABExist("live2d/" .. string.lower(self.paintingName)) then
				self:createLive2D(self.paintingName)
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

			setParent(self.actorPainting, var_108_0)
		end

		if arg_105_3 then
			arg_105_3()
		end

		return
	end)

	return
end

function ProposeUI:createLive2D(arg_109_1)
	self.live2dRequestId = pg.Live2DMgr.GetInstance():GetLive2DModelAsync(arg_109_1, function(arg_110_0)
		GetOrAddComponent(arg_110_0.transform, typeof(DftAniEvent))

		local var_110_0 = self.targetActorTF:Find("live2d")

		HotfixHelper.SetLayerRecursively(arg_110_0, LayerMask.NameToLayer("UI"))
		arg_110_0.transform:SetParent(var_110_0, true)

		local var_110_1 = self.reviewSkinID and self.reviewSkinID or self.proposeSkin and self.proposeSkin.id or self.shipVO:getSkinId()

		Live2DPainting.SetL2dSortingLayer(arg_110_0, LayerWeightConst.L2D_DEFAULT_LAYER)

		arg_110_0.transform.localPosition = BuildVector3(pg.ship_skin_template[var_110_1].live2d_offset) + Vector3(0, 0, 100)

		local var_110_2 = 52

		if pg.ship_skin_template[var_110_1].live2d_offset and #pg.ship_skin_template[var_110_1].live2d_offset >= 4 then
			var_110_2 = pg.ship_skin_template[var_110_1].live2d_offset[4]
		end

		arg_110_0.transform.localScale = Vector3(var_110_2, var_110_2, var_110_2)
		self.l2dChar = GetComponent(arg_110_0, "Live2dChar")
		self.l2dChar.name = arg_109_1

		local var_110_3 = pg.AssistantInfo.action2Id.idle

		function self.l2dChar.FinishAction(arg_111_0)
			if var_110_3 ~= arg_111_0 then
				self.l2dChar:SetAction(var_110_3)
			end

			return
		end

		self.l2dChar:SetAction(pg.AssistantInfo.action2Id.idle)

		if pg.ship_skin_template[var_110_1].lip_sync_gain and pg.ship_skin_template[var_110_1].lip_sync_gain ~= 0 then
			var_110_0:GetChild(0):GetComponent("CubismCriSrcMouthInput").Gain = pg.ship_skin_template[var_110_1].lip_sync_gain
		end

		if arg_109_1 == "mojiaduoer_4" then
			self.l2dChar:AddParameterValue(self.l2dChar:GetCubismParameter("ParamAngleX1"), 3, CubismParameterBlendMode.Override)
			self.l2dChar:AddParameterValue(self.l2dChar:GetCubismParameter("touch_drag45"), 7, CubismParameterBlendMode.Override)
		end

		local var_110_4 = self.l2dChar:GetCubismParameter("l2d_hx")

		if var_110_4 then
			if HXSet.isHx() then
				self.l2dChar:AddParameterValue(var_110_4, 1, CubismParameterBlendMode.Override)
			else
				self.l2dChar:AddParameterValue(var_110_4, 0, CubismParameterBlendMode.Override)
			end
		end

		if pg.ship_skin_template[var_110_1].lip_smoothing and pg.ship_skin_template[var_110_1].lip_smoothing ~= 0 then
			var_110_0:GetChild(0):GetComponent("CubismCriSrcMouthInput").Smoothing = pg.ship_skin_template[var_110_1].lip_smoothing
		end

		return
	end)

	return
end

function ProposeUI:showTip()
	if not self.proposeSkin then
		return
	end

	local var_112_0 = self.storyTF:Find("tip")

	setText(var_112_0:Find("Image_bg/Text"), i18n("achieve_propose_tip", self.proposeSkin.name))
	eachChild(var_112_0:Find("Image_bg/Image"), function(arg_113_0)
		setActive(arg_113_0, arg_113_0.name == self.proposeType)

		return
	end)

	local var_112_1 = GetOrAddComponent(var_112_0, typeof(CanvasGroup))

	setActive(var_112_0, true)
	table.insert(self.tweenList, LeanTween.alphaCanvas(var_112_1, 1, 0.01):setFrom(0).uniqueId)
	table.insert(self.tweenList, LeanTween.alphaCanvas(var_112_1, 0, 1.5):setFrom(1):setDelay(4).uniqueId)

	return
end

function ProposeUI:initChangeNamePanel()
	setText(self._renamePanel:Find("frame/border/title"), i18n("word_propose_changename_title", self.shipVO:getName()))
	setText(self._renamePanel:Find("frame/setting_ship_name/text"), i18n("word_propose_changename_tip1"))
	setText(self._renamePanel:Find("frame/text"), i18n("word_propose_changename_tip2"))

	self._renameConfirmBtn = self._renamePanel:Find("frame/queren")
	self._renameCancelBtn = self._renamePanel:Find("frame/cancel")
	self._renameToggle = findTF(self._renamePanel, "frame/setting_ship_name"):GetComponent(typeof(Toggle))
	self._renameRevert = self._renamePanel:Find("frame/revert_button")
	self._closeBtn = self._renamePanel:Find("frame/close_btn")

	onButton(self, self._renameConfirmBtn, function()
		pg.PushNotificationMgr.GetInstance():setSwitchShipName(self._renameToggle.isOn)
		self:emit(ProposeMediator.RENAME_SHIP, self.shipVO.id, (getInputText(findTF(self._renamePanel, "frame/name_field"))))

		return
	end, SFX_CONFIRM)
	onButton(self, self._renameRevert, function()
		setInputText(findTF(self._renamePanel, "frame/name_field"), self.shipVO:isRemoulded() and pg.ship_skin_template[self.shipVO:getRemouldSkinId()].name or pg.ship_data_statistics[self.shipVO.configId].name)

		return
	end, SFX_PANEL)
	onButton(self, self._renameCancelBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self._closeBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)

	return
end

function ProposeUI:DisplayRenamePanel()
	if self.shipVO:IsXIdol() then
		self:closeView()
	else
		setParent(self._renamePanel, self._tf)
		setActive(self._renamePanel, true)
		setInputText(findTF(self._renamePanel, "frame/name_field"), (self.shipVO:getName()))
		setIntimacyIcon(self.intimacyTF, self.shipVO:getIntimacyIcon())
	end

	return
end

function ProposeUI:showExchangePanel()
	setActive(self.exchangePanel, true)
	pg.UIMgr.GetInstance():BlurPanel(self.exchangePanel)

	return
end

function ProposeUI:hideExchangePanel()
	setActive(self.exchangePanel, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.exchangePanel, self._tf)

	return
end

function ProposeUI:checkPaintingRes(arg_122_1, arg_122_2)
	local var_122_0 = {}
	local var_122_1 = arg_122_1:getProposeSkin()

	if var_122_1 and var_122_1.id > 0 then
		PaintingGroupConst.AddPaintingNameBySkinID(var_122_0, var_122_1.id)
	end

	PaintingGroupConst.PaintingDownload({
		isShowBox = true,
		paintingNameList = var_122_0,
		finishFunc = arg_122_2
	})

	return
end

return ProposeUI
