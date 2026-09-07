local EducateScene = class("EducateScene", import(".base.EducateBaseUI"))

function EducateScene:getUIName()
	return "EducateUI"
end

function EducateScene:preload(arg_2_1)
	pg.PerformMgr.GetInstance():CheckLoad(function()
		arg_2_1()

		return
	end)

	return
end

function EducateScene:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function EducateScene:PlayBGM()
	local var_5_0 = getProxy(EducateProxy):GetCharData():GetBgm()

	if var_5_0 then
		pg.BgmMgr.GetInstance():Push(self.__cname, var_5_0)
	end

	return
end

function EducateScene:initData()
	return
end

function EducateScene:findUI()
	self.mainAnim = self._tf:Find("anim_root"):GetComponent(typeof(Animation))
	self.bgTF = self._tf:Find("anim_root/bg")
	self.blurPanel = self._tf:Find("anim_root/blur_panel")
	self.blurPanelAnim = self.blurPanel:GetComponent(typeof(Animation))
	self.topTF = self.blurPanel:Find("top")
	self.favorBtn = self.topTF:Find("favor")
	self.favorLvTF = self.favorBtn:Find("anim_root/Text")
	self.favorMaxTF = self.favorBtn:Find("anim_root/max")
	self.favorBtnAnim = self.favorBtn:Find("anim_root"):GetComponent(typeof(Animation))
	self.favorBtnAnimEvent = self.favorBtn:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	self.favorBtnAnimEvent:SetTriggerEvent(function()
		self:updateFavorBtn()

		return
	end)

	self.mainTF = self._tf:Find("anim_root/main")
	self.paintTF = self.mainTF:Find("painting")
	self.dialogueTF = self.blurPanel:Find("dialogue")
	self.dialogueContent = self.dialogueTF:Find("content")

	setActive(self.dialogueTF, false)

	self.bubbleTF = self._tf:Find("anim_root/blur_panel/bubble")

	setActive(self.bubbleTF, false)

	self.bubbleBtn = self.bubbleTF:Find("bubble")
	self.optionsTF = self.mainTF:Find("options")
	self.chatBtn = self.optionsTF:Find("options/chat")
	self.giftBtn = self.optionsTF:Find("options/gift")

	setActive(self.optionsTF, false)

	self.bottomTF = self.blurPanel:Find("bottom")
	self.bookBtn = self.bottomTF:Find("left/btns/book")

	setText(self.bookBtn:Find("unlock/Text"), i18n("child_btn_collect"))

	self.mindBtn = self.bottomTF:Find("left/btns/mind")

	setText(self.mindBtn:Find("unlock/Text"), i18n("child_btn_mind"))

	self.bagBtn = self.bottomTF:Find("left/btns/bag")

	setText(self.bagBtn:Find("unlock/Text"), i18n("child_btn_bag"))

	self.datePanel = EducateDatePanel.New(self.topTF:Find("date"), self.event, {
		isMain = true
	})

	self.datePanel:RegisterView(self)

	self.favorPanel = EducateFavorPanel.New(self.topTF:Find("favor_panel"), self.event)

	self.favorPanel:RegisterView(self)

	self.resPanel = EducateResPanel.New(self.topTF:Find("res"), self.event)

	self.resPanel:RegisterView(self)

	self.topPanel = EducateTopPanel.New(self.topTF:Find("top_right"), self.event)

	self.topPanel:RegisterView(self)

	self.targetPanel = EducateTargetPanel.New(self.topTF:Find("target"), self.event)

	self.targetPanel:RegisterView(self)

	self.bottomPanel = EducateBottomPanel.New(self.bottomTF:Find("right"), self.event, {
		isMainEnter = self.contextData.isMainEnter
	})

	self.bottomPanel:RegisterView(self)

	self.archivePanel = EducateArchivePanel.New(self.mainTF:Find("archive_panel"), self.event, {
		isShow = true,
		isMainEnter = self.contextData.isMainEnter
	})

	self.archivePanel:RegisterView(self)

	return
end

function EducateScene:_loadSubViews()
	self.datePanel:Load()
	self.favorPanel:Load()
	self.resPanel:Load()
	self.topPanel:Load()
	self.targetPanel:Load()
	self.bottomPanel:Load()
	self.archivePanel:Load()
	self:OverlayPanel(self.blurPanel, {
		pbList = {
			self.blurPanel:Find("bottom/left")
		}
	})
	self.mainAnim:Play(self.contextData.isMainEnter and "anim_educate_educateUI_bg_in" or "anim_educate_educateUI_bg_show")
	self.blurPanelAnim:Play(self.contextData.isMainEnter and "anim_educate_educateUI_in" or "anim_educate_educateUI_show")

	return
end

function EducateScene:addListener()
	onButton(self, self.chatBtn, function()
		pg.TipsMgr.GetInstance():ShowTips("触发对话[待开发]...")

		return
	end, SFX_PANEL)
	onButton(self, self.giftBtn, function()
		pg.TipsMgr.GetInstance():ShowTips("送礼(?)...")

		return
	end, SFX_PANEL)
	onButton(self, self.favorBtn, function()
		self.favorPanel:Show()

		return
	end, SFX_PANEL)
	onButton(self, self.bookBtn, function()
		self:emit(EducateScene.EDUCATE_GO_SUBLAYER, Context.New({
			mediator = EducateCollectEntranceMediator,
			viewComponent = EducateCollectEntranceLayer
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.mindBtn, function()
		if isActive(self.mindBtn:Find("lock")) then
			return
		end

		self:emit(EducateScene.EDUCATE_GO_SUBLAYER, Context.New({
			mediator = EducateMindMediator,
			viewComponent = EducateMindLayer,
			data = {
				onExit = function()
					self:checkBubbleShow()

					return
				end
			}
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.bagBtn, function()
		if isActive(self.bagBtn:Find("lock")) then
			return
		end

		self:emit(EducateScene.EDUCATE_GO_SUBLAYER, Context.New({
			mediator = EducateBagMediator,
			viewComponent = EducateBagLayer
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.paintTF:Find("fitter"), function()
		self:ShowDialogue()

		return
	end, SFX_PANEL)

	return
end

function EducateScene:didEnter()
	if self.contextData.onEnter then
		self.contextData.onEnter()

		self.contextData.onEnter = nil
	end

	self:updatePaintingUI()
	self:updateUnlockBtns()
	self:updateNewTips()
	self:updateMindTip()
	self:updateFavorBtn()
	self:SeriesCheck()

	return
end

function EducateScene:SeriesCheck()
	local var_20_0 = {}

	table.insert(var_20_0, function(arg_21_0)
		self:CheckNewChar(arg_21_0)

		return
	end)
	table.insert(var_20_0, function(arg_22_0)
		if getProxy(EducateProxy):GetPlanProxy():CheckExcute() then
			self:emit(EducateMediator.ON_EXECTUE_PLANS)
		else
			arg_22_0()
		end

		return
	end)
	table.insert(var_20_0, function(arg_23_0)
		self:CheckTips(arg_23_0)

		return
	end)
	table.insert(var_20_0, function(arg_24_0)
		if getProxy(EducateProxy):GetEventProxy():NeedGetHomeEventData() then
			self:emit(EducateMediator.ON_GET_EVENT, arg_24_0)
		else
			arg_24_0()
		end

		return
	end)
	self:checkBubbleShow()
	table.insert(var_20_0, function(arg_25_0)
		if not self.contextData.ingoreGuideCheck then
			EducateGuideSequence.CheckGuide(self.__cname, arg_25_0)
		else
			self.contextData.ingoreGuideCheck = nil

			arg_25_0()
		end

		return
	end)
	seriesAsync(var_20_0, function()
		return
	end)

	return
end

function EducateScene:OnCheckGuide(arg_27_1)
	EducateGuideSequence.CheckGuide(self.__cname, function()
		existCall(arg_27_1)

		return
	end)

	return
end

function EducateScene:CheckTips(arg_29_1)
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in ipairs(EducateTipHelper.GetSystemUnlockTips()) do
		table.insert(var_29_0, function(arg_30_0)
			self:emit(EducateScene.EDUCATE_ON_UNLOCK_TIP, {
				type = EducateUnlockTipLayer.UNLOCK_TYPE_SYSTEM,
				single = iter_29_1,
				onExit = arg_30_0
			})

			return
		end)
	end

	seriesAsync(var_29_0, function()
		arg_29_1()

		return
	end)

	return
end

function EducateScene:CheckNewChar(arg_32_1)
	if getProxy(EducateProxy):GetCharData():GetCallName() == "" then
		setActive(self._tf, false)

		local var_32_0 = {}

		table.insert(var_32_0, function(arg_33_0)
			pg.PerformMgr.GetInstance():PlayGroup(EducateConst.FIRST_ENTER_PERFORM_IDS, arg_33_0)

			return
		end)
		table.insert(var_32_0, function(arg_34_0)
			self:emit(EducateScene.EDUCATE_GO_SUBLAYER, Context.New({
				mediator = EducateNewCharMediator,
				viewComponent = EducateNewCharLayer,
				data = {
					callback = arg_34_0
				}
			}))

			return
		end)
		table.insert(var_32_0, function(arg_35_0)
			pg.PerformMgr.GetInstance():PlayOne(EducateConst.AFTER_SET_CALLNAME_PERFORM_ID, arg_35_0)

			return
		end)
		seriesAsync(var_32_0, function()
			setActive(self._tf, true)
			self:_loadSubViews()
			arg_32_1()

			return
		end)
	else
		self:_loadSubViews()
		arg_32_1()
	end

	return
end

function EducateScene:showBubble(arg_37_1)
	setActive(self.bubbleTF, true)
	onButton(self, self.bubbleBtn, function()
		arg_37_1()
		setActive(self.bubbleTF, false)

		return
	end, SFX_PANEL)

	return
end

function EducateScene:PlayPerformWithDrops(arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = EducateHelper.GetCommonShowDrops(arg_39_2)

	local function var_39_1()
		if #var_39_0 > 0 then
			self:emit(EducateScene.EDUCATE_ON_AWARD, {
				items = var_39_0,
				removeFunc = function()
					if arg_39_3 then
						arg_39_3()
					end

					return
				end
			})
		elseif arg_39_3 then
			arg_39_3()
		end

		return
	end

	if #arg_39_1 > 0 then
		pg.PerformMgr.GetInstance():PlayGroup(arg_39_1, var_39_1, (EducateHelper.GetDialogueShowDrops(arg_39_2)))
	elseif var_39_1 then
		var_39_1()
	end

	return
end

function EducateScene:ShowFavorUpgrade(arg_42_1, arg_42_2, arg_42_3)
	self:PlayPerformWithDrops(arg_42_2, arg_42_1, function()
		if #arg_42_1 > 0 then
			self:emit(EducateScene.EDUCATE_ON_AWARD, {
				items = arg_42_1,
				removeFunc = function()
					self.favorBtnAnim:Play("anim_educate_favor_levelup")

					if arg_42_3 then
						arg_42_3()
					end

					return
				end
			})
		else
			self.favorBtnAnim:Play("anim_educate_favor_levelup")

			if arg_42_3 then
				arg_42_3()
			end
		end

		return
	end)

	return
end

function EducateScene:ShowSpecialEvent(arg_45_1, arg_45_2, arg_45_3)
	self:PlayPerformWithDrops(pg.child_event_special[arg_45_1].performance, arg_45_2, function()
		if #arg_45_2 > 0 then
			self:emit(EducateScene.EDUCATE_ON_AWARD, {
				items = arg_45_2,
				removeFunc = function()
					if arg_45_3 then
						arg_45_3()
					end

					return
				end
			})
		elseif arg_45_3 then
			arg_45_3()
		end

		return
	end)

	return
end

function EducateScene:checkBubbleShow()
	local var_48_0 = getProxy(EducateProxy):GetEventProxy():GetHomeSpecEvents()

	if #var_48_0 > 0 then
		setActive(self.bubbleBtn:Find("Text"), true)
		setActive(self.bubbleBtn:Find("Image"), false)
		self:showBubble(function()
			self:emit(EducateMediator.ON_SPECIAL_EVENT_TRIGGER, {
				id = var_48_0[1].id,
				callback = function()
					self:checkBubbleShow()
					EducateGuideSequence.CheckGuide(self.__cname, function()
						return
					end)

					return
				end
			})

			return
		end)
	elseif getProxy(EducateProxy):GetCharData():CheckFavor() then
		setActive(self.bubbleBtn:Find("Text"), false)
		setActive(self.bubbleBtn:Find("Image"), true)
		self:showBubble(function()
			self:emit(EducateMediator.ON_UPGRADE_FAVOR, function()
				self:checkBubbleShow()
				EducateGuideSequence.CheckGuide(self.__cname, function()
					return
				end)

				return
			end)

			return
		end)
	else
		setActive(self.bubbleTF, false)
		removeOnButton(self.bubbleTF)
	end

	return
end

function EducateScene:updateResPanel()
	self.resPanel:Flush()

	return
end

function EducateScene:updateArchivePanel()
	self.archivePanel:Flush()

	return
end

function EducateScene:showArchivePanel()
	self.archivePanel:showPanel()

	return
end

function EducateScene:updateDatePanel()
	self.datePanel:Flush()
	self:updateUnlockBtns()

	return
end

function EducateScene:updateUnlockBtns()
	local var_59_0 = EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_MEMORY)

	setActive(self.bookBtn:Find("lock"), not var_59_0)
	setActive(self.bookBtn:Find("unlock"), var_59_0)

	local var_59_1 = EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_BAG)

	setActive(self.bagBtn:Find("lock"), not var_59_1)
	setActive(self.bagBtn:Find("unlock"), var_59_1)

	local var_59_2 = EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_FAVOR_AND_MIND)

	setActive(self.mindBtn:Find("lock"), not var_59_2)
	setActive(self.mindBtn:Find("unlock"), var_59_2)
	setActive(self.favorBtn, var_59_2)

	return
end

function EducateScene:updateMindTip()
	setActive(self.mindBtn:Find("unlock/tip"), getProxy(EducateProxy):GetTaskProxy():IsShowMindTasksTip())

	return
end

function EducateScene:updateWeekDay(arg_61_1)
	self.datePanel:UpdateWeekDay(arg_61_1)

	return
end

function EducateScene:updateFavorBtn()
	local var_62_0 = getProxy(EducateProxy):GetCharData()
	local var_62_1 = var_62_0:GetFavor()

	setText(self.favorLvTF, var_62_1.lv)
	setActive(self.favorMaxTF, var_62_1.lv == var_62_0:GetFavorMaxLv())

	return
end

function EducateScene:updateTargetPanel()
	self.targetPanel:Flush()

	return
end

function EducateScene:updateBottomPanel()
	self.bottomPanel:Flush()

	return
end

function EducateScene:updatePaintingUI()
	local var_65_0 = getProxy(EducateProxy):GetCharData()

	self.bgName = var_65_0:GetBGName()
	self.paintingName = var_65_0:GetPaintingName()
	self.wordList, self.faceList = var_65_0:GetMainDialogueInfo()

	setImageSprite(self.bgTF, LoadSprite("bg/" .. self.bgName), false)
	setPaintingPrefab(self.paintTF, self.paintingName, "yangcheng")

	return
end

function EducateScene:ShowDialogue()
	if LeanTween.isTweening(self.dialogueTF) then
		return
	end

	local var_66_0 = math.random(#self.wordList)

	self.callName = self.callName or getProxy(EducateProxy):GetCharData():GetCallName()

	setText(self.dialogueContent, (string.gsub(pg.child_word[self.wordList[var_66_0]].word, "$1", self.callName)))

	local var_66_1 = GetSpriteFromAtlas("paintingface/" .. self.paintingName, self.faceList[var_66_0])
	local var_66_2 = self.paintTF:Find("fitter"):GetChild(0):Find("face")

	if var_66_2 and var_66_1 then
		setImageSprite(var_66_2, var_66_1)
		setActive(var_66_2, true)
	end

	self.dialogueTF.localScale = Vector3.zero

	setActive(self.dialogueTF, true)
	LeanTween.scale(self.dialogueTF, Vector3.one, 0.3):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
		LeanTween.scale(self.dialogueTF, Vector3.zero, 0.3):setEase(LeanTweenType.easeInBack):setDelay(3):setOnComplete(System.Action(function()
			setActive(self.dialogueTF, false)

			if var_66_2 then
				setActive(var_66_2, false)
			end

			return
		end))

		return
	end))

	return
end

function EducateScene:updateNewTips()
	self:updateBookNewTip()
	self:updateMindNewTip()

	return
end

function EducateScene:updateBookNewTip()
	setActive(self.bookBtn:Find("unlock/new"), underscore.any(pg.child_memory.all, function(arg_71_0)
		return EducateTipHelper.IsShowNewTip(EducateTipHelper.NEW_MEMORY, arg_71_0)
	end) or EducateTipHelper.IsShowNewTip(EducateTipHelper.NEW_POLAROID))

	return
end

function EducateScene:updateMindNewTip()
	setActive(self.mindBtn:Find("unlock/new"), EducateTipHelper.IsShowNewTip(EducateTipHelper.NEW_MIND_TASK))

	return
end

function EducateScene:FlushView()
	self.datePanel:Flush()
	self.favorPanel:Flush()
	self.resPanel:Flush()
	self.targetPanel:Flush()
	self.bottomPanel:Flush()
	self.archivePanel:Flush()
	self:updatePaintingUI()
	self:updateUnlockBtns()
	self:updateNewTips()
	self:updateMindTip()
	self:updateFavorBtn()
	self:SeriesCheck()

	return
end

function EducateScene:onBackPressed()
	self:emit(EducateScene.EDUCATE_GO_SCENE, SCENE.NEW_EDUCATE_SELECT, {
		isTb1 = true
	})

	return
end

function EducateScene:willExit()
	self.contextData.isMainEnter = nil

	self.datePanel:Destroy()

	self.datePanel = nil

	self.favorPanel:Destroy()

	self.favorPanel = nil

	self.resPanel:Destroy()

	self.resPanel = nil

	self.topPanel:Destroy()

	self.topPanel = nil

	self.targetPanel:Destroy()

	self.targetPanel = nil

	self.bottomPanel:Destroy()

	self.bottomPanel = nil

	self.archivePanel:Destroy()

	self.archivePanel = nil

	if LeanTween.isTweening(self.dialogueTF) then
		LeanTween.cancel(self.dialogueTF)
	end

	self:UnOverlayPanel(self.blurPanel, self._tf)

	return
end

return EducateScene
