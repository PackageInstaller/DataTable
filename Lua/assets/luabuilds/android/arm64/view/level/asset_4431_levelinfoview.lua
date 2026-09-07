local LevelInfoView = class("LevelInfoView", import("..base.BaseSubView"))

LevelInfoView.CHAPTER_GUIDE_NAME = "CHAPTER_AUTO_GUIDE"

function LevelInfoView:getUIName()
	return "LevelStageInfoView"
end

function LevelInfoView:OnInit()
	self.loader = AutoLoader.New()

	self:InitUI()

	return
end

function LevelInfoView:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	self.onConfirm = nil
	self.onCancel = nil

	if self.LTid then
		LeanTween.cancel(self.LTid)

		self.LTid = nil
	end

	self.loader:Clear()

	return
end

function LevelInfoView:Show()
	setActive(self._tf, true)
	self:BlurPanel(self._tf)
	self:CheckGuide()

	return
end

function LevelInfoView:CheckGuide()
	if ChapterAutoProxy.IsSystemOpen() and pg.chapter_auto_statistics[self.chapter.id] then
		if not pg.NewStoryMgr.GetInstance():IsPlayed(LevelInfoView.CHAPTER_GUIDE_NAME) then
			pg.NewGuideMgr.GetInstance():Play(LevelInfoView.CHAPTER_GUIDE_NAME)
			pg.m02:sendNotification(GAME.STORY_UPDATE, {
				storyId = LevelInfoView.CHAPTER_GUIDE_NAME
			})
		end
	end

	return
end

function LevelInfoView:Hide()
	self:clear()
	setActive(self._tf, false)
	self:UnOverlayPanel(self._tf, self._parentTf)

	return
end

function LevelInfoView:setCBFunc(arg_7_1, arg_7_2)
	self.onConfirm = arg_7_1
	self.onCancel = arg_7_2

	return
end

function LevelInfoView:InitUI()
	self.titleBG = self._tf:Find("panel/title")
	self.titleBGDecoration = self._tf:Find("panel/title/Image")
	self.titleIcon = self._tf:Find("panel/title/icon")
	self.txTitle = self._tf:Find("panel/title_form")
	self.txTitleOriginPosY = self.txTitle.anchoredPosition.y
	self.txTitleHead = self._tf:Find("panel/title_head")

	setActive(self.txTitleHead, false)

	self.txIntro = self._tf:Find("panel/intro")
	self.txCost = self._tf:Find("panel/cost/text")
	self.progressBar = self._tf:Find("panel/progress")
	self.txProgress = self._tf:Find("panel/progress/Text/value")
	self.progress = self._tf:Find("panel/progress")
	self.head = self._tf:Find("panel/head/Image")
	self.trAchieveTpl = self._tf:Find("panel/achieve")
	self.trAchieves = self._tf:Find("panel/achieves")
	self.passStateMask = self._tf:Find("panel/passState")
	self.passState = self._tf:Find("panel/passState/Image")

	setActive(self.passState, true)

	self.winCondDesc = self._tf:Find("panel/win_conditions/desc")
	self.winCondAwardBtn = self._tf:Find("panel/win_conditions/icon")
	self.loseCondDesc = self._tf:Find("panel/lose_conditions/desc")
	self.achieveList = UIItemList.New(self.trAchieves, self.trAchieveTpl)

	setActive(self.trAchieveTpl, false)

	self.trDropTpl = self._tf:Find("panel/drops/frame/list/item")
	self.trDrops = self._tf:Find("panel/drops/frame/list")
	self.dropList = UIItemList.New(self.trDrops, self.trDropTpl)

	self.dropList:make(function(arg_9_0, arg_9_1, arg_9_2)
		self:updateDrop(arg_9_0, arg_9_1, arg_9_2)

		return
	end)
	setActive(self.trDropTpl, false)

	self.btnAuto = self._tf:Find("panel/auto_button")
	self.btnConfirm = self._tf:Find("panel/start_button")
	self.btnConfirm_l = self._tf:Find("panel/start_button_l")
	self.btnCancel = self._tf:Find("panel/btnBack")
	self.quickPlayGroup = self._tf:Find("panel/quickPlay")
	self.descQuickPlay = self.quickPlayGroup:Find("desc")
	self.toggleQuickPlay = self.quickPlayGroup:GetComponent(typeof(Toggle))
	self.bottomExtra = self._tf:Find("panel/BottomExtra")
	self.layoutView = GetComponent(self.bottomExtra:Find("LoopGroup/view"), typeof(LayoutElement))
	self.rtViewContainer = self.bottomExtra:Find("LoopGroup/view/container")

	setText(self.bottomExtra:Find("LoopGroup/Loop/Text"), i18n("autofight_farm"))

	self.loopToggle = self.bottomExtra:Find("LoopGroup/Loop/Toggle")
	self.loopOn = self.loopToggle:Find("on")
	self.loopOff = self.loopToggle:Find("off")
	self.loopHelp = self.bottomExtra:Find("ButtonHelp")
	self.costLimitTip = self.bottomExtra:Find("LoopGroup/view/container/CostLimit")

	setActive(self.costLimitTip, false)

	self.autoFightToggle = self.bottomExtra:Find("LoopGroup/view/container/AutoFight")

	setText(self.autoFightToggle:Find("Text"), i18n("autofight"))

	self.delayTween = {}
	self.doEaseIn = true

	return
end

local var_0_1 = 525
local var_0_2 = 373

function LevelInfoView:set(arg_10_1, arg_10_2)
	self:cancelTween()

	local var_10_0 = getProxy(ChapterProxy):getChapterById(arg_10_1, true)

	self.chapter = var_10_0
	self.posStart = arg_10_2 or Vector3(0, 0, 0)

	local var_10_1 = getProxy(ChapterProxy):getMapById(var_10_0:getConfig("map"))
	local var_10_2 = var_10_0:getConfigTable()
	local var_10_3 = string.split(var_10_2.name, "|")
	local var_10_4 = var_10_0:getPlayType() == ChapterConst.TypeDefence

	GetSpriteFromAtlasAsync("ui/levelstageinfoview_atlas", var_10_4 and "title_print_defense" or "title_print", function(arg_11_0)
		if not IsNil(self.titleBGDecoration) then
			self.titleBGDecoration:GetComponent(typeof(Image)).sprite = arg_11_0
		end

		return
	end)
	GetSpriteFromAtlasAsync("ui/levelstageinfoview_atlas", var_10_4 and "titlebar_bg_defense" or "titlebar_bg", function(arg_12_0)
		if not IsNil(self.titleBG) then
			self.titleBG:GetComponent(typeof(Image)).sprite = arg_12_0
		end

		return
	end)
	setActive(self.titleIcon, var_10_4)

	local var_10_5 = self.progressBar.sizeDelta

	if var_10_4 then
		var_10_5.x = var_0_2 or var_0_1
	end

	self.progressBar.sizeDelta = var_10_5

	setText(self.txTitle:Find("title_index"), var_10_2.chapter_name .. "  ")
	setText(self.txTitle:Find("title"), var_10_3[1])
	setText(self.txTitle:Find("title_en"), var_10_3[2] or "")
	setActive(self.txTitleHead, var_10_3[3] and #var_10_3[3] > 0)
	setAnchoredPosition(self.txTitle, {
		y = (var_10_3[3] and #var_10_3[3] > 0 or nil) and (self.txTitleOriginPosY or self.txTitleOriginPosY + 8)
	})
	setText(self.txTitleHead, var_10_3[3] or "")
	setText(self.winCondDesc, i18n("text_win_condition") .. "：" .. i18n(var_10_0:getConfig("win_condition_display")))
	setText(self.loseCondDesc, i18n("text_lose_condition") .. "：" .. i18n(var_10_0:getConfig("lose_condition_display")))
	setActive(self.winCondAwardBtn, var_10_0:getPlayType() == ChapterConst.TypeDefence)

	if not var_10_0:existAchieve() then
		setActive(self.passState, false)
		setActive(self.progress, false)
		setActive(self.trAchieves, false)
	else
		setActive(self.passState, true)
		setActive(self.progress, true)
		setActive(self.trAchieves, true)

		self.passState.localPosition = Vector3(-self.passState.rect.width, 0, 0)

		local var_10_6 = var_10_0:hasMitigation()

		setActive(self.passState, var_10_6)

		if var_10_6 then
			setImageSprite(self.passState, GetSpriteFromAtlas("passstate", (var_10_0:getRiskLevel())), true)
		end

		setWidgetText(self.progress, i18n("levelScene_threat_to_rule_out", ": "))
		table.insert(self.delayTween, LeanTween.value(go(self.progress), 0, var_10_0.progress, 0.5):setDelay(0.15):setOnUpdate(System.Action_float(function(arg_13_0)
			setSlider(self.progress, 0, 100, arg_13_0)
			setText(self.txProgress, math.floor(arg_13_0) .. "%")

			return
		end)).uniqueId)
		self.achieveList:align(#var_10_0.achieves)
		self.achieveList:each(function(arg_14_0, arg_14_1)
			local var_14_0 = findTF(arg_14_1, "desc")

			setText(var_14_0, ChapterConst.GetAchieveDesc(var_10_0.achieves[arg_14_0 + 1].type, var_10_0))
			setTextColor(var_14_0, Color.white)
			setActive(findTF(arg_14_1, "star"), false)
			setActive(findTF(arg_14_1, "star_empty"), true)

			local var_14_1 = ChapterConst.IsAchieved(var_10_0.achieves[arg_14_0 + 1])

			table.insert(self.delayTween, LeanTween.delayedCall(0.15 + (arg_14_0 + 1) * 0.15, System.Action(function()
				if not IsNil(arg_14_1) then
					setTextColor(findTF(arg_14_1, "desc"), (var_14_1 or nil) and (Color.yellow or Color.white))
					setActive(findTF(arg_14_1, "star"), var_14_1)
					setActive(findTF(arg_14_1, "star_empty"), not var_14_1)
				end

				return
			end)).uniqueId)

			return
		end)
	end

	setText(self.txIntro, var_10_2.profiles)
	setText(self.txCost, var_10_2.oil)

	if var_10_2.icon and var_10_2.icon[1] then
		setActive(self.head.parent, true)
		setImageSprite(self.head, LoadSprite("qicon/" .. var_10_2.icon[1]))
	else
		setActive(self.head.parent, false)
	end

	self.awards = LevelInfoView.getChapterAwards(self.chapter)

	self.dropList:align(#self.awards)

	local var_10_7 = var_10_0:existLoop()

	setActive(self.bottomExtra, var_10_7)

	if var_10_7 then
		local var_10_8 = var_10_0:canActivateLoop()
		local var_10_9 = "chapter_loop_flag_" .. var_10_0.id
		local var_10_10 = PlayerPrefs.GetInt("chapter_loop_flag_" .. var_10_0.id, -1)
		local var_10_11 = (var_10_10 == 1 or var_10_10 == -1) and var_10_8
		local var_10_12 = #var_10_0:getConfig("use_oil_limit") > 0

		setActive(self.loopOn, (var_10_10 == 1 or var_10_10 == -1) and var_10_8)
		setActive(self.loopOff, not var_10_11)
		setActive(self.costLimitTip, var_10_12)
		onNextTick(function()
			Canvas.ForceUpdateCanvases()

			if var_10_11 then
				self.layoutView.preferredWidth = self.rtViewContainer.rect.width or 0
			end

			return
		end)
		onButton(self, self.loopToggle, function()
			if not var_10_8 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_activate_loop_mode_failed"))

				return
			end

			local var_17_0 = not self.loopOn.gameObject.activeSelf

			PlayerPrefs.SetInt(var_10_9, not self.loopOn.gameObject.activeSelf and 1 or 0)
			PlayerPrefs.Save()
			setActive(self.loopOn, var_17_0)
			setActive(self.loopOff, not var_17_0)

			local var_17_1 = 0
			local var_17_2 = 0

			if var_17_0 then
				var_17_2 = self.rtViewContainer.rect.width
			else
				var_17_1 = self.rtViewContainer.rect.width
			end

			if self.LTid then
				LeanTween.cancel(self.LTid)

				self.LTid = nil
			end

			self.LTid = LeanTween.value(var_17_1, var_17_2, 0.3):setOnUpdate(System.Action_float(function(arg_18_0)
				self.layoutView.preferredWidth = arg_18_0

				return
			end)):setOnComplete(System.Action(function()
				self.LTid = nil

				return
			end)).uniqueId

			return
		end, SFX_PANEL)
		onButton(self, self.loopHelp, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = i18n("levelScene_loop_help_tip")
			})

			return
		end)

		local var_10_13 = AutoBotCommand.autoBotSatisfied()
		local var_10_14 = "chapter_autofight_flag_" .. var_10_0.id
		local var_10_15 = var_10_13 and PlayerPrefs.GetInt("chapter_autofight_flag_" .. var_10_0.id, 1) == 1

		onToggle(self, self.autoFightToggle, function(arg_21_0)
			if arg_21_0 ~= var_10_15 then
				var_10_15 = arg_21_0

				PlayerPrefs.SetInt(var_10_14, var_10_15 and 1 or 0)
				PlayerPrefs.Save()
			end

			return
		end, SFX_UI_TAG)
		triggerToggle(self.autoFightToggle, var_10_15)
		setActive(self.autoFightToggle, var_10_13)
	end

	onButton(self, self.btnConfirm, function()
		if getProxy(BayProxy):getShipCount() >= getProxy(PlayerProxy):getRawData():getMaxShipBag() then
			NoPosMsgBox(i18n("switch_to_shop_tip_noDockyard"), openDockyardClear, gotoChargeScene, openDockyardIntensify)

			return
		end

		if not self.onConfirm then
			return
		end

		self.onConfirm(arg_10_1, var_10_7 and self.loopOn.gameObject.activeSelf and 1 or 0)

		return
	end, SFX_UI_WEIGHANCHOR_GO)
	onButton(self, self.btnConfirm_l, function()
		triggerButton(self.btnConfirm)

		return
	end, SFX_UI_WEIGHANCHOR_GO)
	onButton(self, self.btnCancel, function()
		if self.onCancel then
			self.onCancel()
		end

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("bg"), function()
		if self.onCancel then
			self.onCancel()
		end

		return
	end, SFX_CANCEL)

	if not var_10_0:getConfig("risk_levels") then
		-- block empty
	end

	onButton(self, self.passState, function()
		if not var_10_0:hasMitigation() then
			return
		end

		local var_26_0 = i18n("level_risk_level_desc", var_10_0:getChapterState()) .. i18n("level_risk_level_mitigation_rate", var_10_0:getRemainPassCount(), var_10_0:getMitigationRate())

		if var_10_1:getMapType() == Map.ELITE then
			var_26_0 = var_26_0 .. "\n" .. i18n("level_diffcult_chapter_state_safety")
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = var_26_0
		})

		return
	end, SFX_PANEL)
	onButton(self, self.head, function()
		triggerButton(self.passState)

		return
	end, SFX_PANEL)
	onButton(self, self.winCondAwardBtn, function()
		self:ShowChapterRewardPanel()

		return
	end)
	setText(self.descQuickPlay, i18n("desc_quick_play"))

	local var_10_17 = var_10_0:CanQuickPlay()

	setActive(self.quickPlayGroup, var_10_17)

	if var_10_17 then
		local var_10_18 = "chapter_quickPlay_flag_" .. var_10_0.id
		local var_10_19 = PlayerPrefs.GetInt("chapter_quickPlay_flag_" .. var_10_0.id, 1)

		onToggle(self, self.toggleQuickPlay, function(arg_29_0)
			PlayerPrefs.SetInt(var_10_18, arg_29_0 and 1 or 0)
			PlayerPrefs.Save()

			return
		end, SFX_PANEL)
		triggerToggle(self.toggleQuickPlay, var_10_19 == 1)
	end

	if self.doEaseIn then
		local var_10_20 = self._tf:Find("panel")

		var_10_20.transform.localPosition = self.posStart

		table.insert(self.delayTween, LeanTween.move(var_10_20, Vector3.zero, 0.2).uniqueId)

		var_10_20.localScale = Vector3.zero

		table.insert(self.delayTween, LeanTween.scale(var_10_20, Vector3(1, 1, 1), 0.2).uniqueId)
		table.insert(self.delayTween, LeanTween.moveX(self.passState, 0, 0.35):setEase(LeanTweenType.easeInOutSine):setDelay(0.3).uniqueId)
	end

	self:UpdateChapterAutoBtn()

	return
end

function LevelInfoView:UpdateChapterAutoBtn()
	local var_30_0 = ChapterAutoProxy.IsSystemOpen()

	setActive(self.btnAuto, pg.chapter_auto_statistics[self.chapter.id])
	setActive(self.btnConfirm, pg.chapter_auto_statistics[self.chapter.id])
	setActive(self.btnConfirm_l, not pg.chapter_auto_statistics[self.chapter.id])

	if not pg.chapter_auto_statistics[self.chapter.id] then
		return
	end

	local var_30_2 = var_30_0 and self.chapter:isClear() and getProxy(ChapterAutoProxy):GetRecord(ChapterAutoProxy.TYPE.SLG, self.chapter.id) > 0

	setGray(self.btnAuto, not (var_30_0 and self.chapter:isClear() and getProxy(ChapterAutoProxy):GetRecord(ChapterAutoProxy.TYPE.SLG, self.chapter.id) > 0), true)
	onButton(self, self.btnAuto, function()
		if var_30_2 then
			self:ShowChapterAutoPanel()
		elseif var_30_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auto_chapter_unlock_tip"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("auto_battle_unlock_tip"))
		end

		return
	end, SFX_PANEL)

	return
end

function LevelInfoView:cancelTween()
	_.each(self.delayTween, function(arg_33_0)
		LeanTween.cancel(arg_33_0)

		return
	end)

	self.delayTween = {}

	return
end

function LevelInfoView:updateDrop(arg_34_1, arg_34_2, arg_34_3)
	if arg_34_1 == UIItemList.EventUpdate then
		local var_34_0 = Drop.Create(self.awards[arg_34_2 + 1])

		updateDrop(arg_34_3, var_34_0)
		onButton(self, arg_34_3, function()
			if ({
				[99] = true
			})[var_34_0:getConfig("type")] then
				self:emit(LevelMediator2.GET_CHAPTER_DROP_SHIP_LIST, self.chapter.id, function(arg_36_0)
					local var_36_0 = {}

					for iter_36_0, iter_36_1 in ipairs((var_34_0:getConfig("display_icon"))) do
						local var_36_1 = iter_36_1[2]

						var_36_0[#var_36_0 + 1] = {
							type = iter_36_1[1],
							id = iter_36_1[2],
							anonymous = iter_36_1[1] == DROP_TYPE_SHIP and not table.contains(arg_36_0, var_36_1)
						}
					end

					self:emit(BaseUI.ON_DROP_LIST, {
						item2Row = true,
						itemList = var_36_0,
						content = var_34_0:getConfig("display")
					})
					self:initTestShowDrop(var_34_0, Clone(var_36_0))

					return
				end)
			else
				self:emit(BaseUI.ON_DROP, var_34_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function LevelInfoView:getChapterAwards()
	local var_37_0 = Clone(self:getConfig("awards"))
	local var_37_1 = self:getStageExtraAwards()

	if var_37_1 then
		for iter_37_0 = #var_37_1, 1, -1 do
			table.insert(var_37_0, 1, var_37_1[iter_37_0])
		end
	end

	local var_37_2 = {
		self:getConfig("boss_expedition_id"),
		self:getConfig("ai_expedition_list")
	}
	local var_37_5
	local var_37_3
	local var_37_4
	local var_37_6

	if self:getPlayType() == ChapterConst.TypeMultiStageBoss then
		table.insert(var_37_2, pg.chapter_model_multistageboss[self.id].boss_expedition_id)

		var_37_3 = {}
		var_37_4 = {}

		function var_37_5(arg_38_0)
			for iter_38_0, iter_38_1 in ipairs(var_37_3) do
				if iter_38_1 == arg_38_0 then
					return false
				end
			end

			return true
		end

		var_37_6 = {}
	end

	for iter_37_1, iter_37_2 in ipairs((_.flatten(var_37_2))) do
		local var_37_7 = checkExist(pg.expedition_activity_template[iter_37_2], {
			"pt_drop_display"
		})

		if var_37_7 and type(var_37_7) == "table" then
			for iter_37_3, iter_37_4 in ipairs(var_37_7) do
				if var_37_5(iter_37_4[2]) then
					table.insert(var_37_3, iter_37_4[2])

					var_37_4[iter_37_4[2]] = {}
				end

				var_37_4[iter_37_4[2]][iter_37_4[1]] = true
				var_37_6[iter_37_4[2]] = var_37_6[iter_37_4[2]] or {}
				var_37_6[iter_37_4[2]][iter_37_4[1]] = iter_37_4[3]
			end
		end
	end

	local var_37_8 = getProxy(ActivityProxy)

	for iter_37_5 = #var_37_3, 1, -1 do
		for iter_37_6, iter_37_7 in pairs(var_37_4[var_37_3[iter_37_5]]) do
			local var_37_9 = var_37_8:getActivityById(iter_37_6)

			if var_37_9 and not var_37_9:isEnd() then
				table.insert(var_37_0, 1, {
					DROP_TYPE_ITEM,
					id2ItemId(var_37_3[iter_37_5]),
					var_37_6[var_37_3[iter_37_5]][iter_37_6]
				})

				break
			end
		end
	end

	return var_37_0
end

function LevelInfoView:initTestShowDrop(arg_39_1, arg_39_2)
	if IsUnityEditor then
		local var_39_0 = pg.MsgboxMgr.GetInstance()._go
		local var_39_1 = var_39_0.transform:Find("button_test_show_drop")

		if IsNil(var_39_1) then
			var_39_1 = GameObject.New("button_test_show_drop")

			var_39_1:AddComponent(typeof(Button))
			var_39_1:AddComponent(typeof(RectTransform))
			var_39_1:AddComponent(typeof(Image))
		end

		local var_39_2 = var_39_1:GetComponent(typeof(RectTransform))

		var_39_2:SetParent(var_39_0.transform, false)

		var_39_2.anchoredPosition = Vector3(-239, 173, 0)
		var_39_2.sizeDelta = Vector2(40, 40)

		onButton(self, var_39_2, function()
			_.each(arg_39_2, function(arg_41_0)
				arg_41_0.anonymous = false

				return
			end)
			self:emit(BaseUI.ON_DROP_LIST, {
				item2Row = true,
				itemList = arg_39_2,
				content = arg_39_1:getConfig("display")
			})

			return
		end)
	end

	return
end

function LevelInfoView:clearTestShowDrop()
	if IsUnityEditor then
		local var_42_0 = pg.MsgboxMgr.GetInstance()._go.transform:Find("button_test_show_drop")

		if not IsNil(var_42_0) then
			Destroy(var_42_0)
		end
	end

	return
end

function LevelInfoView:ShowChapterRewardPanel()
	if self.rewardPanel == nil then
		self.rewardPanel = ChapterRewardPanel.New(self._tf.parent, self.event, self.contextData)

		self.rewardPanel:Load()
	end

	self.rewardPanel:ActionInvoke("Enter", self.chapter)

	return
end

function LevelInfoView:ClearChapterRewardPanel()
	if self.rewardPanel ~= nil then
		self.rewardPanel:Destroy()

		self.rewardPanel = nil
	end

	return
end

function LevelInfoView:ShowChapterAutoPanel()
	if self.autoPanel == nil then
		self.autoPanel = ChapterAutoPanel.New(self._tf, self.event, self.contextData)

		self.autoPanel:Load()
	end

	self.autoPanel:ActionInvoke("Enter", self.chapter)

	return
end

function LevelInfoView:RefreshChapterAutoPanel()
	if self.autoPanel and self.autoPanel:isShowing() then
		self.autoPanel:ActionInvoke("RefreshView")
	end

	return
end

function LevelInfoView:ClearChapterAutoPanel()
	if self.autoPanel ~= nil then
		self.autoPanel:Destroy()

		self.autoPanel = nil
	end

	return
end

function LevelInfoView:clear()
	self:cancelTween()
	self.dropList:each(function(arg_49_0, arg_49_1)
		clearDrop(arg_49_1)

		return
	end)
	self:clearTestShowDrop()
	self:ClearChapterRewardPanel()
	self:ClearChapterAutoPanel()

	return
end

return LevelInfoView
