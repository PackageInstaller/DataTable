local LevelStageView = class("LevelStageView", import("..base.BaseSubView"))

function LevelStageView:Ctor(...)
	LevelStageView.super.Ctor(self, ...)

	self.isFrozen = nil

	self:bind(LevelUIConst.ON_FROZEN, function()
		self.isFrozen = true

		if self.cgComp then
			self.cgComp.blocksRaycasts = false
		end

		return
	end)
	self:bind(LevelUIConst.ON_UNFROZEN, function()
		self.isFrozen = nil

		if self.cgComp then
			self.cgComp.blocksRaycasts = true
		end

		return
	end)

	self.toastQueue = {}

	self:bind(LevelUIConst.ADD_TOAST_QUEUE, function(arg_4_0, arg_4_1)
		table.insert(self.toastQueue, arg_4_1)

		if #self.toastQueue > 1 then
			return
		end

		self:Toast()

		return
	end)

	return
end

function LevelStageView:getUIName()
	return "LevelStageView"
end

function LevelStageView:OnInit()
	self:InitUI()
	self:AddListener()

	self.loader = AutoLoader.New()
	self.cgComp = GetOrAddComponent(self._go, typeof(CanvasGroup))
	self.cgComp.blocksRaycasts = not self.isFrozen

	self:Show()

	return
end

function LevelStageView:OnDestroy()
	if self.stageTimer then
		self.stageTimer:Stop()

		self.stageTimer = nil
	end

	self:ClearSubViews()
	self:DestroyAutoFightPanel()
	self:DestroyWinConditionPanel()
	self:DestroyToast()
	self.loader:Clear()
	self:Hide()

	return
end

local var_0_1 = -300

function LevelStageView:InitUI()
	self.topStage = self._tf:Find("top_stage")

	setActive(self.topStage, true)

	self.bottomStage = self._tf:Find("bottom_stage")
	self.normalRole = findTF(self.bottomStage, "Normal")
	self.funcBtn = self.normalRole:Find("func_button")
	self.retreatBtn = self.normalRole:Find("retreat_button")
	self.switchBtn = self.normalRole:Find("switch_button")
	self.helpBtn = self.normalRole:Find("help_button")
	self.shengfuBtn = self.normalRole:Find("shengfu/shengfu_button")
	self.actionRole = findTF(self.bottomStage, "Action")
	self.missileStrikeRole = findTF(self.actionRole, "MissileStrike")
	self.airExpelRole = findTF(self.actionRole, "AirExpel")

	setActive(self.bottomStage, true)
	setAnchoredPosition(self.normalRole, {
		x = 0,
		y = 0
	})
	setActive(self.normalRole, true)
	setAnchoredPosition(self.actionRole, {
		x = 0,
		y = var_0_1
	})
	setActive(self.actionRole, false)
	eachChild(self.actionRole, function(arg_9_0)
		setActive(arg_9_0, false)

		return
	end)

	self.leftStage = self._tf:Find("left_stage")

	setActive(self.leftStage, true)

	self.rightStage = self._tf:Find("right_stage")
	self.bombPanel = self.rightStage:Find("bomb_panel")
	self.panelBarrier = self.rightStage:Find("panel_barrier")
	self.strategyPanelAnimator = self.rightStage:Find("event"):GetComponent(typeof(Animator))
	self.autoBattleBtn = self.rightStage:Find("event/collapse/lock_fleet")
	self.showDetailBtn = self.rightStage:Find("event/detail/show_detail")

	setActive(self.panelBarrier, false)
	setActive(self.rightStage, true)

	self.airSupremacy = self.topStage:Find("msg_panel/air_supremacy")

	setAnchoredPosition(self.topStage, {
		y = self.topStage.rect.height
	})
	setAnchoredPosition(self.leftStage, {
		x = -self.leftStage.rect.width - 200
	})
	setAnchoredPosition(self.rightStage, {
		x = self.rightStage.rect.width + 300
	})
	setAnchoredPosition(self.bottomStage, {
		y = -self.bottomStage.rect.height
	})

	self.attachSubViews = {}

	return
end

function LevelStageView:AddListener()
	self:bind(LevelUIConst.TRIGGER_ACTION, function()
		self:tryAutoTrigger()

		return
	end)
	self:bind(LevelUIConst.STRATEGY_PANEL_AUTOFIGHT_ACTIVE, function(arg_12_0, arg_12_1)
		self.strategyPanelAnimator:SetBool("IsActive", arg_12_1)

		self.bottomStageInactive = arg_12_1

		self:ShiftBottomStage(not arg_12_1)

		return
	end)
	self:bind(LevelUIConst.ON_CLICK_GRID_QUAD, function(arg_13_0, arg_13_1)
		self:ClickGridCellNormal(arg_13_1)

		return
	end)
	onButton(self, self.topStage:Find("option"), function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(self, self.topStage:Find("back_button"), function()
		self:emit(LevelUIConst.SWITCH_TO_MAP)

		return
	end, SFX_CANCEL)
	onButton(self, self.retreatBtn, function()
		local var_16_0 = "levelScene_whether_to_retreat"

		if self.contextData.chapterVO:existOni() then
			var_16_0 = "levelScene_oni_retreat"
		elseif self.contextData.chapterVO:isPlayingWithBombEnemy() then
			var_16_0 = "levelScene_bomb_retreat"
		elseif self.contextData.chapterVO:getPlayType() == ChapterConst.TypeTransport and not self.contextData.map:isSkirmish() then
			var_16_0 = "levelScene_escort_retreat"
		elseif self.contextData.map:isRemaster() then
			var_16_0 = "archives_whether_to_retreat"
		end

		self:HandleShowMsgBox({
			content = i18n(var_16_0),
			onYes = ChapterOpCommand.PrepareChapterRetreat
		})

		return
	end, SFX_UI_WEIGHANCHOR_WITHDRAW)
	onButton(self, self.switchBtn, function()
		local var_17_0 = self.contextData.chapterVO:getNextValidIndex()

		if var_17_0 > 0 then
			self:emit(LevelMediator2.ON_OP, {
				type = ChapterConst.OpSwitch,
				id = self.contextData.chapterVO.fleets[var_17_0].id
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("formation_switch_failed"))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.autoBattleBtn, function()
		local var_18_0 = getProxy(ChapterProxy)

		var_18_0:UpdateSkipPrecombat(not var_18_0:GetSkipPrecombat())

		return
	end, SFX_PANEL)
	onButton(self, self.showDetailBtn, function()
		self._showStrategyDetail = not self._showStrategyDetail and true

		self:updateStageStrategy()

		return
	end, SFX_PANEL)
	onButton(self, self.funcBtn, function()
		local var_20_0 = self.contextData.chapterVO

		if not self.contextData.chapterVO:inWartime() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_time_out"))

			return
		end

		local var_20_1 = var_20_0.fleet
		local var_20_2 = var_20_0:getChapterCell(var_20_0.fleet.line.row, var_20_0.fleet.line.column)
		local var_20_3 = false

		local function var_20_4(arg_21_0)
			return pg.expedition_data_template[arg_21_0.attachmentId].dungeon_id > 0
		end

		if var_20_0:existVisibleChampion(var_20_0.fleet.line.row, var_20_0.fleet.line.column) then
			var_20_3 = true

			if chapter_skip_battle == 1 then
				if pg.SdkMgr.GetInstance():CheckPretest() then
					self:emit(LevelMediator2.ON_OP, {
						type = ChapterConst.OpSkipBattle,
						id = var_20_1.id
					})

					goto label_20_0
				end
			end

			if not var_20_4((var_20_0:getChampion(var_20_0.fleet.line.row, var_20_0.fleet.line.column))) then
				self:emit(LevelMediator2.ON_OP, {
					type = ChapterConst.OpPreClear,
					id = var_20_1.id
				})
			elseif var_20_0:IsSkipPrecombat() then
				self:emit(LevelMediator2.ON_START)
			else
				self:emit(LevelMediator2.ON_STAGE)
			end
		elseif var_20_2.attachment == ChapterConst.AttachAmbush and var_20_2.flag == ChapterConst.CellFlagAmbush then
			local var_20_5

			var_20_5 = coroutine.wrap(function()
				self:emit(LevelUIConst.DO_AMBUSH_WARNING, var_20_5)
				coroutine.yield()
				self:emit(LevelUIConst.DISPLAY_AMBUSH_INFO, var_20_5)
				coroutine.yield()

				return
			end)

			;(nil)()

			var_20_3 = true
		elseif ChapterConst.IsEnemyAttach(var_20_2.attachment) then
			if var_20_2.flag == ChapterConst.CellFlagActive then
				var_20_3 = true

				if chapter_skip_battle == 1 then
					if pg.SdkMgr.GetInstance():CheckPretest() then
						self:emit(LevelMediator2.ON_OP, {
							type = ChapterConst.OpSkipBattle,
							id = var_20_1.id
						})

						goto label_20_0
					end
				end

				if not var_20_4(var_20_2) then
					self:emit(LevelMediator2.ON_OP, {
						type = ChapterConst.OpPreClear,
						id = var_20_1.id
					})
				elseif var_20_0:IsSkipPrecombat() then
					self:emit(LevelMediator2.ON_START)
				else
					self:emit(LevelMediator2.ON_STAGE)
				end
			end
		elseif var_20_2.attachment == ChapterConst.AttachBox then
			if var_20_2.flag == ChapterConst.CellFlagActive then
				var_20_3 = true

				self:emit(LevelMediator2.ON_OP, {
					type = ChapterConst.OpBox,
					id = var_20_1.id
				})
			end
		elseif var_20_2.attachment == ChapterConst.AttachSupply and var_20_2.attachmentId > 0 then
			var_20_3 = true

			local var_20_6, var_20_7 = var_20_0:getFleetAmmo(var_20_0.fleet)

			if var_20_7 < var_20_6 then
				self:emit(LevelMediator2.ON_OP, {
					type = ChapterConst.OpSupply,
					id = var_20_1.id
				})
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("level_ammo_enough"))
			end
		elseif var_20_2.attachment == ChapterConst.AttachStory then
			var_20_3 = true

			local var_20_8 = pg.map_event_template[var_20_2.attachmentId].gametip

			if pg.map_event_template[var_20_2.attachmentId].memory == 0 then
				return
			end

			local var_20_9 = pg.NewStoryMgr.GetInstance():StoryId2StoryName(pg.map_event_template[var_20_2.attachmentId].memory)

			pg.ConnectionMgr.GetInstance():Send(11017, {
				story_id = pg.map_event_template[var_20_2.attachmentId].memory
			}, 11018, function(arg_23_0)
				return
			end)
			pg.NewStoryMgr.GetInstance():Play(var_20_9, function(arg_24_0, arg_24_1)
				local var_24_0 = arg_24_1 or 1

				if var_20_2.flag == ChapterConst.CellFlagActive then
					self:emit(LevelMediator2.ON_OP, {
						type = ChapterConst.OpStory,
						id = var_20_1.id,
						arg1 = var_24_0
					})
				end

				if var_20_8 ~= "" then
					local var_24_1

					for iter_24_0, iter_24_1 in ipairs(pg.memory_template.all) do
						if table.contains(pg.memory_template[iter_24_1].unlock_pre, var_20_9) then
							var_24_1 = pg.memory_template[iter_24_1].title
						end
					end

					pg.TipsMgr.GetInstance():ShowTips(i18n(var_20_8, var_24_1))
				end

				return
			end)
		end

		::label_20_0::

		if not var_20_3 then
			if var_20_0:getRound() == ChapterConst.RoundEnemy then
				self:emit(LevelMediator2.ON_OP, {
					type = ChapterConst.OpEnemyRound
				})
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("level_click_to_move"))
			end
		end

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		if self.contextData.chapterVO then
			if self.contextData.chapterVO:existOni() then
				self:HandleShowMsgBox({
					type = MSGBOX_TYPE_HELP,
					helps = i18n("levelScene_sphunt_help_tip")
				})
			elseif self.contextData.chapterVO:isTypeDefence() then
				self:HandleShowMsgBox({
					type = MSGBOX_TYPE_HELP,
					helps = i18n("help_battle_defense")
				})
			elseif self.contextData.chapterVO:isPlayingWithBombEnemy() then
				self:HandleShowMsgBox({
					type = MSGBOX_TYPE_HELP,
					helps = i18n("levelScene_bomb_help_tip")
				})
			else
				if pg.map_event_list[self.contextData.chapterVO.id] then
					if next(noEmptyStr(pg.map_event_list[self.contextData.chapterVO.id].help_pictures) or {}) then
						local var_25_0 = {
							disableScroll = true,
							pageMode = true,
							defaultpage = 1,
							ImageMode = true,
							windowSize = {
								x = 1263,
								y = 873
							},
							windowPos = {
								y = -70
							},
							helpSize = {
								x = 1176,
								y = 1024
							}
						}

						for iter_25_0, iter_25_1 in pairs(pg.map_event_list[self.contextData.chapterVO.id].help_pictures) do
							table.insert(var_25_0, {
								icon = {
									path = "",
									atlas = iter_25_1
								}
							})
						end

						self:HandleShowMsgBox({
							type = MSGBOX_TYPE_HELP,
							helps = var_25_0
						})

						goto label_25_0
					end
				end

				self:HandleShowMsgBox({
					type = MSGBOX_TYPE_HELP,
					helps = pg.gametip.help_level_ui.tip
				})
			end
		end

		::label_25_0::

		return
	end, SFX_PANEL)
	onButton(self, self.airSupremacy, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("help_battle_ac")
		})

		return
	end, SFX_UI_CLICK)
	onButton(self, self.shengfuBtn, function()
		self:DisplayWinConditionPanel()

		return
	end)

	return
end

function LevelStageView:SetSeriesOperation(arg_28_1)
	self.seriesOperation = arg_28_1

	return
end

function LevelStageView:SetGrid(arg_29_1)
	self.grid = arg_29_1

	return
end

function LevelStageView:SetPlayer(arg_30_1)
	return
end

function LevelStageView:SwitchToChapter(arg_31_1)
	local var_31_0 = findTF(self.rightStage, "target")
	local var_31_1 = findTF(self.rightStage, "skip_events")

	setActive(findTF(self.topStage, "msg_panel/ambush"), arg_31_1:existAmbush())
	setActive(self.airSupremacy, OPEN_AIR_DOMINANCE and arg_31_1:getConfig("air_dominance") > 0)

	local var_31_2 = arg_31_1:isLoop()

	setActive(self.autoBattleBtn, var_31_2)

	if var_31_2 then
		self:UpdateSkipPreCombatMark()
		self:UpdateAutoFightPanel()
		self:UpdateAutoFightMark()
	end

	self.achieveOriginalY = -240

	setText(var_31_1:Find("Label"), i18n("map_event_skip"))

	local var_31_3 = "skip_events_on_" .. arg_31_1.id

	if arg_31_1:getConfig("event_skip") == 1 then
		if arg_31_1.progress > 0 or arg_31_1.defeatCount > 0 or arg_31_1.passCount > 0 then
			setActive(var_31_1, true)

			var_31_0.anchoredPosition = Vector2.New(var_31_0.anchoredPosition.x, self.achieveOriginalY - 40)
			GetComponent(var_31_1, typeof(Toggle)).isOn = PlayerPrefs.GetInt(var_31_3, 1) == 1

			onToggle(self, var_31_1, function(arg_32_0)
				PlayerPrefs.SetInt(var_31_3, arg_32_0 and 1 or 0)

				return
			end)
		else
			setActive(var_31_1, false)

			if not PlayerPrefs.HasKey(var_31_3) then
				PlayerPrefs.SetInt(var_31_3, 0)
			end
		end
	else
		setActive(var_31_1, false)

		var_31_0.anchoredPosition = Vector2.New(var_31_0.anchoredPosition.x, self.achieveOriginalY)
	end

	setActive(var_31_0, arg_31_1:existAchieve())
	setActive(self.retreatBtn, true)
	self.seriesOperation()

	return
end

function LevelStageView:SwitchToMap()
	self:DestroyAutoFightPanel()

	return
end

function LevelStageView:UpdateSkipPreCombatMark()
	local var_34_0 = getProxy(ChapterProxy):GetSkipPrecombat() and "auto_battle_on" or "auto_battle_off"

	self.loader:GetOffSpriteRequest(self.autoBattleBtn)
	self.loader:GetSprite("ui/levelstageview_atlas", var_34_0, self.autoBattleBtn, true)

	return
end

function LevelStageView:updateStageInfo()
	local var_35_0 = self.contextData.chapterVO
	local var_35_1 = findTF(self.topStage, "timer")
	local var_35_2 = findTF(self.topStage, "unlimit")

	setWidgetText(var_35_1, "--:--:--")

	if self.stageTimer then
		self.stageTimer:Stop()
	end

	if self.contextData.chapterVO:getRemainTime() > self.contextData.chapterVO:getConfig("time") or self.contextData.chapterVO:getConfig("time") >= 0 then
		setActive(var_35_1, false)
		setActive(var_35_2, true)
	else
		setActive(var_35_1, true)
		setActive(var_35_2, false)

		self.stageTimer = Timer.New(function()
			if IsNil(var_35_1) then
				return
			end

			setWidgetText(var_35_1, pg.TimeMgr.GetInstance():DescCDTime((var_35_0:getRemainTime())))

			return
		end, 1, -1)

		self.stageTimer:Start()
		self.stageTimer.func()
	end

	return
end

function LevelStageView:updateAmbushRate(arg_37_1, arg_37_2)
	local var_37_0 = self.contextData.chapterVO

	if not self.contextData.chapterVO:existAmbush() then
		return
	end

	local var_37_1 = var_37_0.fleet
	local var_37_2 = findTF(self.topStage, "msg_panel/ambush/value2")

	setText(findTF(self.topStage, "msg_panel/ambush/label1"), i18n("level_scene_title_word_1"))
	setText(findTF(self.topStage, "msg_panel/ambush/value1"), math.floor((var_37_0.fleet:getInvestSums())))
	setText(findTF(self.topStage, "msg_panel/ambush/label2"), i18n("level_scene_title_word_2"))

	if not var_37_0.activateAmbush then
		setText(var_37_2, i18n("ambush_display_none"))
		setTextColor(var_37_2, Color.New(0.4, 0.4, 0.4))
	else
		local var_37_3, var_37_4 = ChapterConst.GetAmbushDisplay((not arg_37_2 or not var_37_0:existEnemy(ChapterConst.SubjectPlayer, arg_37_1.row, arg_37_1.column)) and var_37_0:getAmbushRate(var_37_1, arg_37_1))

		setText(var_37_2, var_37_3)
		setTextColor(var_37_2, var_37_4)
	end

	return
end

function LevelStageView:updateStageAchieve()
	if not self.contextData.chapterVO:existAchieve() then
		return
	end

	local var_38_0 = self.contextData.chapterVO.achieves
	local var_38_1 = findTF(self.rightStage, "target")

	setActive(var_38_1, true)

	local var_38_2 = findTF(var_38_1, "detail")
	local var_38_3 = findTF(var_38_2, "achieve")
	local var_38_4 = findTF(var_38_2, "achieves")
	local var_38_5 = findTF(var_38_2, "click")
	local var_38_6 = findTF(var_38_1, "collapse")
	local var_38_7 = findTF(var_38_6, "star")
	local var_38_8 = findTF(var_38_6, "stars")

	setActive(var_38_3, false)
	setActive(var_38_7, false)
	removeAllChildren(var_38_4)
	removeAllChildren(var_38_8)

	for iter_38_0, iter_38_1 in ipairs(var_38_0) do
		local var_38_9 = cloneTplTo(var_38_3, var_38_4)
		local var_38_10 = ChapterConst.IsAchieved(iter_38_1)

		setActive(findTF(var_38_9, "star"), var_38_10)

		local var_38_11 = findTF(var_38_9, "desc")

		setText(var_38_11, ChapterConst.GetAchieveDesc(iter_38_1.type, self.contextData.chapterVO))
		setTextColor(var_38_11, (var_38_10 or nil) and (Color.yellow or Color.white))

		cloneTplTo(var_38_7, var_38_8):GetComponent(typeof(Image)).enabled = var_38_10
	end

	onButton(self, var_38_5, function()
		shiftPanel(var_38_2, var_38_2.rect.width + 200, nil, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
		shiftPanel(var_38_6, 0, nil, 0.3, 0, true, nil, LeanTweenType.easeOutSine)

		return
	end, SFX_PANEL)
	onButton(self, var_38_6, function()
		shiftPanel(var_38_2, 30, nil, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
		shiftPanel(var_38_6, var_38_6.rect.width + 200, nil, 0.3, 0, true, nil, LeanTweenType.easeOutSine)

		return
	end, SFX_PANEL)

	if not self.isAchieveFirstInit then
		self.isAchieveFirstInit = true

		triggerButton(var_38_5)
	end

	return
end

function LevelStageView:updateStageBarrier()
	setActive(self.panelBarrier, self.contextData.chapterVO:existOni())

	if not self.contextData.chapterVO:existOni() then
		return
	end

	local var_41_0 = self.panelBarrier:Find("btn_barrier")

	setText(var_41_0:Find("nums"), self.contextData.chapterVO.modelCount)
	onButton(self, var_41_0, function()
		if self.grid.quadState == ChapterConst.QuadStateBarrierSetting then
			self.grid:updateQuadCells(ChapterConst.QuadStateNormal)

			return
		end

		self.grid:updateQuadCells(ChapterConst.QuadStateBarrierSetting)

		return
	end, SFX_PANEL)

	return
end

function LevelStageView:updateBombPanel(arg_43_1)
	setActive(self.bombPanel, self.contextData.chapterVO:isPlayingWithBombEnemy())

	if self.contextData.chapterVO:isPlayingWithBombEnemy() then
		setText(self.bombPanel:Find("tx_step"), self.contextData.chapterVO:getBombChapterInfo().action_times - math.floor(self.contextData.chapterVO.roundIndex / 2))

		local var_43_0 = self.bombPanel:Find("tx_score")
		local var_43_1 = tonumber(getText(var_43_0))
		local var_43_2 = self.contextData.chapterVO.modelCount

		LeanTween.cancel(go(var_43_0))

		if arg_43_1 and var_43_1 ~= self.contextData.chapterVO.modelCount then
			LeanTween.scale(go(var_43_0), Vector3(1.5, 1.5, 1), 0.2)
			LeanTween.value(go(var_43_0), var_43_1, self.contextData.chapterVO.modelCount, (self.contextData.chapterVO.modelCount - var_43_1) * 0.1):setOnUpdate(System.Action_float(function(arg_44_0)
				setText(var_43_0, math.floor(arg_44_0))

				return
			end)):setOnComplete(System.Action(function()
				setText(var_43_0, var_43_2)

				return
			end)):setEase(LeanTweenType.easeInOutSine):setDelay(0.2)
			LeanTween.scale(go(var_43_0), Vector3.one, 0.3):setDelay(1 + (self.contextData.chapterVO.modelCount - var_43_1) * 0.1)
		else
			var_43_0.localScale = Vector3.one

			setText(var_43_0, self.contextData.chapterVO.modelCount)
		end
	end

	return
end

function LevelStageView:updateFleetBuff()
	local var_46_0 = self.contextData.chapterVO.fleet
	local var_46_1 = self.contextData.chapterVO:GetShowingStrategies()

	if self.contextData.chapterVO:getChapterSupportFleet() and not self.contextData.chapterVO:IsSupportSubmarineStage() then
		table.insert(var_46_1, ChapterConst.StrategyAirSupportFriendly)
	end

	local var_46_2 = {}
	local var_46_3 = self.contextData.chapterVO:GetSubmarineFleet()

	if var_46_3 then
		local var_46_4 = _.filter(var_46_3:getStrategies(), function(arg_47_0)
			return pg.strategy_data_template[arg_47_0.id].type == ChapterConst.StgTypePassive and arg_47_0.count > 0
		end)

		if var_46_4 and #var_46_4 > 0 then
			_.each(var_46_4, function(arg_48_0)
				table.insert(var_46_2, {
					id = arg_48_0.id,
					count = arg_48_0.count
				})

				return
			end)
		end
	end

	local var_46_5 = underscore.filter(self.contextData.chapterVO:GetWeather(), function(arg_49_0)
		return noEmptyStr(pg.weather_data_template[arg_49_0].buff_icon)
	end)
	local var_46_6 = 0

	if self.contextData.chapterVO:ExistDivingChampion() then
		var_46_6 = 1
	end

	local var_46_7 = _.map(_.values(self.contextData.chapterVO.fleet:getCommanders()), function(arg_50_0)
		return arg_50_0:getSkills()[1]
	end)
	local var_46_8 = findTF(self.topStage, "icon_list/fleet_buffs")
	local var_46_9 = UIItemList.New(var_46_8, var_46_8:GetChild(0))

	var_46_9:make(function(arg_51_0, arg_51_1, arg_51_2)
		setActive(findTF(arg_51_2, "frame"), false)
		setActive(findTF(arg_51_2, "Text"), false)
		setActive(findTF(arg_51_2, "times"), false)

		if arg_51_0 == UIItemList.EventUpdate then
			local var_51_0 = GetComponent(arg_51_2, typeof(LayoutElement))

			var_51_0.preferredWidth = 64
			var_51_0.preferredHeight = 64

			if arg_51_1 + 1 <= #var_46_1 then
				local var_51_1 = pg.strategy_data_template[var_46_1[arg_51_1 + 1]]

				GetImageSpriteFromAtlasAsync("strategyicon/" .. pg.strategy_data_template[var_46_1[arg_51_1 + 1]].icon, "", arg_51_2)

				local var_51_2

				if pg.strategy_data_template[var_46_1[arg_51_1 + 1]].type == ChapterConst.StgTypeBindFleetPassive then
					var_51_2 = var_46_0:GetStrategyCount(var_46_1[arg_51_1 + 1])

					setActive(findTF(arg_51_2, "times"), true)
					setText(findTF(arg_51_2, "times"), var_51_2)
				end

				local var_51_3 = pg.strategy_data_template[var_46_1[arg_51_1 + 1]].iconSize

				if pg.strategy_data_template[var_46_1[arg_51_1 + 1]].iconSize ~= "" then
					var_51_0.preferredWidth = var_51_3[1]
					var_51_0.preferredHeight = var_51_3[2]
				end

				onButton(self, arg_51_2, function()
					self:HandleShowMsgBox({
						yesText = "text_confirm",
						hideNo = true,
						content = "",
						type = MSGBOX_TYPE_SINGLE_ITEM,
						drop = {
							type = DROP_TYPE_STRATEGY,
							id = var_51_1.id,
							cfg = var_51_1,
							count = var_51_2
						}
					})

					return
				end, SFX_PANEL)

				return
			end

			arg_51_1 = arg_51_1 - #var_46_1

			if arg_51_1 + 1 <= #var_46_5 then
				local var_51_4 = pg.weather_data_template[var_46_5[arg_51_1 + 1]]

				GetImageSpriteFromAtlasAsync("strategyicon/" .. pg.weather_data_template[var_46_5[arg_51_1 + 1]].buff_icon, "", arg_51_2)
				onButton(self, arg_51_2, function()
					self:HandleShowMsgBox({
						hideNo = true,
						type = MSGBOX_TYPE_DROP_ITEM,
						name = var_51_4.name,
						content = var_51_4.buff_desc,
						iconPath = {
							"strategyicon/" .. var_51_4.buff_icon
						},
						yesText = pg.MsgboxMgr.TEXT_CONFIRM
					})

					return
				end, SFX_PANEL)

				return
			end

			arg_51_1 = arg_51_1 - #var_46_5

			if arg_51_1 + 1 <= #var_46_2 then
				local var_51_5 = var_46_2[arg_51_1 + 1]
				local var_51_6 = pg.strategy_data_template[var_46_2[arg_51_1 + 1].id]

				GetImageSpriteFromAtlasAsync("strategyicon/" .. pg.strategy_data_template[var_46_2[arg_51_1 + 1].id].icon, "", arg_51_2)
				setActive(findTF(arg_51_2, "times"), true)
				setText(findTF(arg_51_2, "times"), var_46_2[arg_51_1 + 1].count)
				onButton(self, arg_51_2, function()
					self:HandleShowMsgBox({
						yesText = "text_confirm",
						hideNo = true,
						content = "",
						type = MSGBOX_TYPE_SINGLE_ITEM,
						drop = {
							type = DROP_TYPE_STRATEGY,
							id = var_51_6.id,
							cfg = var_51_6
						},
						extendDesc = string.format(i18n("word_rest_times"), var_51_5.count)
					})

					return
				end, SFX_PANEL)

				return
			end

			arg_51_1 = arg_51_1 - #var_46_2

			if arg_51_1 + 1 <= var_46_6 then
				GetImageSpriteFromAtlasAsync("strategyicon/submarine_approach", "", arg_51_2)
				onButton(self, arg_51_2, function()
					self:HandleShowMsgBox({
						yesText = "text_confirm",
						hideNo = true,
						type = MSGBOX_TYPE_DROP_ITEM,
						name = i18n("submarine_approach"),
						content = i18n("submarine_approach_desc"),
						iconPath = {
							"strategyicon/submarine_approach"
						}
					})

					return
				end, SFX_PANEL)

				return
			end

			arg_51_1 = arg_51_1 - var_46_6

			local var_51_7 = var_46_7[arg_51_1 + 1]

			GetImageSpriteFromAtlasAsync("commanderskillicon/" .. var_46_7[arg_51_1 + 1]:getConfig("icon"), "", arg_51_2)
			setText(findTF(arg_51_2, "Text"), "Lv." .. var_46_7[arg_51_1 + 1]:getConfig("lv"))
			setActive(findTF(arg_51_2, "Text"), true)
			setActive(findTF(arg_51_2, "frame"), true)
			onButton(self, arg_51_2, function()
				self:emit(LevelMediator2.ON_COMMANDER_SKILL, var_51_7)

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_46_9:align(#var_46_1 + #var_46_2 + #var_46_5 + var_46_6 + #var_46_7)

	if OPEN_AIR_DOMINANCE and self.contextData.chapterVO:getConfig("air_dominance") > 0 then
		self:updateAirDominance()
	end

	self:updateEnemyCount()
	self:updateChapterBuff()

	return
end

function LevelStageView:updateEnemyCount()
	local var_57_0 = self.contextData.chapterVO
	local var_57_1 = findTF(self.topStage, "icon_list/enemy_count")
	local var_57_2 = tobool(underscore.detect(self.contextData.chapterVO.achieves, function(arg_58_0)
		return (arg_58_0.type == ChapterConst.AchieveType3 or arg_58_0.type == ChapterConst.AchieveType6) and not ChapterConst.IsAchieved(arg_58_0)
	end))

	setActive(var_57_1, var_57_2)

	if var_57_2 then
		local var_57_3 = self.contextData.chapterVO:getDisplayEnemyCount()

		setText(var_57_1:Find("Text"), var_57_3)
		GetImageSpriteFromAtlasAsync("enemycount", var_57_3 > 0 and "danger" or "safe", var_57_1)
		onButton(self, var_57_1, function()
			if var_57_3 > 0 then
				self:HandleShowMsgBox({
					hideNo = true,
					type = MSGBOX_TYPE_DROP_ITEM,
					name = i18n("star_require_enemy_title"),
					content = i18n("star_require_enemy_text", var_57_3),
					iconPath = {
						"enemycount",
						"danger"
					},
					yesText = i18n("star_require_enemy_check"),
					onYes = function()
						local var_60_0 = var_57_0:getNearestEnemyCell()

						self.grid:focusOnCell(var_60_0)

						local var_60_1 = self.grid:GetEnemyCellView(var_60_0)

						if var_60_1 and var_60_1.TweenShining then
							var_60_1:TweenShining(2)
						end

						return
					end
				})
			else
				self:HandleShowMsgBox({
					hideNo = true,
					type = MSGBOX_TYPE_DROP_ITEM,
					name = i18n("star_require_enemy_title"),
					content = i18n("star_require_enemy_text", var_57_3),
					iconPath = {
						"enemycount",
						"safe"
					}
				})
			end

			return
		end, SFX_PANEL)
	end

	return
end

function LevelStageView:updateChapterBuff()
	local var_61_0 = self.contextData.chapterVO
	local var_61_1 = findTF(self.topStage, "icon_list/chapter_buff")
	local var_61_2 = self.contextData.chapterVO:hasMitigation()

	SetActive(var_61_1, var_61_2)

	if var_61_2 then
		local var_61_3 = self.contextData.chapterVO:getRiskLevel()

		GetImageSpriteFromAtlasAsync("passstate", var_61_3 .. "_icon", var_61_1)
		onButton(self, var_61_1, function()
			if not var_61_0:hasMitigation() then
				return
			end

			self:HandleShowMsgBox({
				hideNo = true,
				type = MSGBOX_TYPE_DROP_ITEM,
				name = var_61_0:getChapterState(),
				iconPath = {
					"passstate",
					var_61_3 .. "_icon"
				},
				content = i18n("level_risk_level_mitigation_rate", var_61_0:getRemainPassCount(), var_61_0:getMitigationRate())
			})

			return
		end, SFX_PANEL)
	end

	return
end

function LevelStageView:updateAirDominance()
	local var_63_0, var_63_1, var_63_2 = self.contextData.chapterVO:getAirDominanceValue()

	if not var_63_2 or var_63_2 ~= var_63_1 then
		self.contextData.chapterVO:setAirDominanceStatus(var_63_1)
		getProxy(ChapterProxy):updateChapter(self.contextData.chapterVO)
	end

	self.isChange = var_63_2 and (var_63_1 == 0 and 3 or var_63_1) - (var_63_2 == 0 and 3 or var_63_2)

	self:updateAirDominanceTitle(var_63_0, var_63_1, self.isChange or 0)

	return
end

function LevelStageView:updateAirDominanceTitle(arg_64_1, arg_64_2, arg_64_3)
	local var_64_0 = findTF(self.airSupremacy, "value2")
	local var_64_1 = findTF(self.airSupremacy, "up")
	local var_64_2 = findTF(self.airSupremacy, "down")

	setText(findTF(self.airSupremacy, "label1"), i18n("level_scene_title_word_3"))
	setText(findTF(self.airSupremacy, "label2"), i18n("level_scene_title_word_4"))
	setText(findTF(self.airSupremacy, "value1"), math.floor(arg_64_1))
	setActive(var_64_1, false)
	setActive(var_64_2, false)

	if arg_64_3 ~= 0 then
		if LeanTween.isTweening(go(var_64_0)) then
			LeanTween.cancel(go(var_64_0))
		end

		LeanTween.value(go(var_64_0), 1, 0, 0.5):setOnUpdate(System.Action_float(function(arg_65_0)
			setTextAlpha(var_64_0, arg_65_0)

			return
		end)):setOnComplete(System.Action(function()
			setText(var_64_0, ChapterConst.AirDominance[arg_64_2].name)
			setTextColor(var_64_0, ChapterConst.AirDominance[arg_64_2].color)
			LeanTween.value(go(var_64_0), 0, 1, 0.5):setOnUpdate(System.Action_float(function(arg_67_0)
				setTextAlpha(var_64_0, arg_67_0)

				return
			end))

			return
		end))

		local function var_64_3(arg_68_0)
			setActive(arg_68_0, false)

			return
		end

		var_64_1:GetComponent(typeof(DftAniEvent)):SetEndEvent(var_64_3)
		var_64_2:GetComponent(typeof(DftAniEvent)):SetEndEvent(var_64_3)
		setActive(var_64_1, arg_64_3 > 0)
		setActive(var_64_2, arg_64_3 < 0)
	else
		setText(var_64_0, ChapterConst.AirDominance[arg_64_2].name)
		setTextColor(var_64_0, ChapterConst.AirDominance[arg_64_2].color)
	end

	return
end

function LevelStageView:UpdateDefenseStatus()
	local var_69_0 = self.contextData.chapterVO
	local var_69_1 = self.contextData.chapterVO:getPlayType() == ChapterConst.TypeDefence
	local var_69_2 = findTF(self.bottomStage, "Normal/shengfu")

	setActive(var_69_2, var_69_1)

	if not var_69_1 then
		return
	end

	findTF(var_69_2, "hp"):GetComponent(typeof(Text)).text = i18n("desc_base_hp", "<color=#92FC63>" .. tostring(var_69_0.BaseHP) .. "</color>", pg.chapter_defense[var_69_0.id].port_hp)

	return
end

function LevelStageView:DisplayWinConditionPanel()
	if not self.winCondPanel then
		self.winCondPanel = WinConditionDisplayPanel.New(self._tf.parent, self.event, self.contextData)

		self.winCondPanel:Load()
	end

	self.winCondPanel:ActionInvoke("Enter", self.contextData.chapterVO)

	return
end

function LevelStageView:DestroyWinConditionPanel()
	if not self.winCondPanel then
		return
	end

	self.winCondPanel:Destroy()

	self.winCondPanel = nil

	return
end

function LevelStageView:UpdateComboPanel()
	if pg.chapter_pop_template[self.contextData.chapterVO.id] and pg.chapter_pop_template[self.contextData.chapterVO.id].combo_on then
		local var_72_0, var_72_1 = self:GetSubView("LevelStageComboPanel")

		if var_72_1 then
			var_72_0:Load()
			var_72_0.buffer:SetParent(self.leftStage, false)
		end

		var_72_0.buffer:UpdateView(getProxy(ChapterProxy):GetComboHistory(self.contextData.chapterVO.id) or self.contextData.chapterVO)
		var_72_0.buffer:UpdateViewAnimated(self.contextData.chapterVO)
	end

	return
end

function LevelStageView:UpdateDOALinkFeverPanel(arg_73_1)
	local var_73_0 = self.contextData.chapterVO:GetBindActID()
	local var_73_1 = self.contextData.chapterVO:getConfig("levelstage_bar")

	if not var_73_1 or var_73_1 == "" then
		existCall(arg_73_1)

		return
	end

	local var_73_2, var_73_3 = self:GetSubView(var_73_1)

	if var_73_3 then
		var_73_2:Load()
		var_73_2.buffer:SetParent(self._tf, false)
	end

	var_73_2.buffer:UpdateView(self.contextData.chapterVO, arg_73_1)

	return
end

local var_0_2 = Vector2(396, 128)
local var_0_3 = Vector2(128, 128)

function LevelStageView:updateStageStrategy()
	local var_74_0 = self.contextData.chapterVO
	local var_74_1 = findTF(self.rightStage, "event")
	local var_74_2 = findTF(var_74_1, "detail")
	local var_74_3 = findTF(var_74_2, "click")
	local var_74_4 = findTF(var_74_2, "items")

	if self._showStrategyDetail then
		var_74_4:GetComponent(typeof(GridLayoutGroup)).cellSize = var_0_2 or var_0_3
	end

	local var_74_5 = findTF(var_74_4, "item")
	local var_74_6 = findTF(var_74_1, "collapse")

	setActive(var_74_5, false)

	local var_74_7 = var_74_0:GetInteractableStrategies()

	local function var_74_9(arg_75_0, arg_75_1, arg_75_2)
		if arg_75_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_75_0 = arg_75_2:Find("detail")

		setActive(var_75_0, self._showStrategyDetail)

		local var_75_1 = arg_75_2:Find("icon")
		local var_75_2 = var_74_7[arg_75_1 + 1]
		local var_75_3
		local var_75_4

		if var_74_7[arg_75_1 + 1].id == ChapterConst.StrategyHuntingRange then
			var_75_3 = ChapterConst.StgTypeConst
			var_75_4 = self.contextData.huntingRangeVisibility % 2 == 1 and "range_invisible" or "range_visible"

			setText(var_75_0, i18n("help_sub_limits"))
		elseif var_75_2.id == ChapterConst.StrategySubAutoAttack then
			var_75_3 = ChapterConst.StgTypeConst
			var_75_4 = var_74_0.subAutoAttack == 0 and "sub_dont_auto_attack" or "sub_auto_attack"

			setText(var_75_0, i18n("help_sub_display"))
		else
			var_75_3 = pg.strategy_data_template[var_75_2.id].type
			var_75_4 = pg.strategy_data_template[var_75_2.id].icon

			setText(var_75_0, pg.strategy_data_template[var_75_2.id].desc)
		end

		GetImageSpriteFromAtlasAsync("strategyicon/" .. var_75_4, "", var_75_1:Find("icon"))
		onButton(self, var_75_1, function()
			if var_75_2.id == ChapterConst.StrategyHuntingRange then
				self.grid:toggleHuntingRange()
				var_74_9(arg_75_0, arg_75_1, arg_75_2)
			elseif var_75_2.id == ChapterConst.StrategySubAutoAttack then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ai_change_" .. 1 - var_74_0.subAutoAttack + 1))
				self:emit(LevelMediator2.ON_OP, {
					type = ChapterConst.OpSubState,
					arg1 = 1 - var_74_0.subAutoAttack
				})
			elseif var_75_2.id == ChapterConst.StrategyExchange then
				local var_76_0 = var_74_0:getNextValidIndex()

				if var_76_0 > 0 and var_75_2.count > 0 then
					local var_76_1 = var_74_0.fleet

					self:HandleShowMsgBox({
						content = i18n("levelScene_who_to_exchange"),
						onYes = function()
							self:emit(LevelMediator2.ON_OP, {
								type = ChapterConst.OpStrategy,
								id = var_76_1.id,
								arg1 = ChapterConst.StrategyExchange,
								arg2 = var_74_0.fleets[var_76_0].id
							})

							return
						end
					})
				end
			elseif var_75_2.id == ChapterConst.StrategySubTeleport then
				self:SwitchSubTeleportBottomStage()
				self:SwitchBottomStagePanel(true)
				self.grid:ShowStaticHuntingRange()
				self.grid:PrepareSubTeleport()
				self.grid:updateQuadCells(ChapterConst.QuadStateTeleportSub)
			elseif var_75_2.id == ChapterConst.StrategyMissileStrike then
				if not var_74_0.fleet:canUseStrategy(var_75_2) then
					return
				end

				self:SwitchMissileBottomStagePanel()
				self:SwitchBottomStagePanel(true)
				self.grid:updateQuadCells(ChapterConst.QuadStateMissileStrike)
			elseif var_75_2.id == ChapterConst.StrategyAirSupport then
				if not var_74_0:getChapterSupportFleet():canUseStrategy(var_75_2) then
					return
				end

				self:SwitchAirSupportBottomStagePanel()
				self:SwitchBottomStagePanel(true)
				self.grid:updateQuadCells(ChapterConst.QuadStateAirSuport)
			elseif var_75_2.id == ChapterConst.StrategyExpel then
				if not var_74_0:getChapterSupportFleet():canUseStrategy(var_75_2) then
					return
				end

				self:SwitchAirExpelBottomStagePanel()
				self:SwitchBottomStagePanel(true)
				self.grid:updateQuadCells(ChapterConst.QuadStateExpel)
			elseif var_75_3 == ChapterConst.StgTypeForm then
				self:emit(LevelMediator2.ON_OP, {
					type = ChapterConst.OpStrategy,
					id = var_74_0.fleet.id,
					arg1 = ChapterConst.StrategyForms[table.indexof(ChapterConst.StrategyForms, var_75_2.id) % #ChapterConst.StrategyForms + 1]
				})
			else
				self:emit(LevelUIConst.DISPLAY_STRATEGY_INFO, var_75_2)
			end

			return
		end, SFX_PANEL)

		if var_75_3 == ChapterConst.StgTypeForm then
			setText(var_75_1:Find("nums"), "")
			setActive(var_75_1:Find("mask"), false)
			setActive(var_75_1:Find("selected"), true)
		else
			setText(var_75_1:Find("nums"), (not var_75_2.count or nil) and "")
			setActive(var_75_1:Find("mask"), var_75_2.count == 0)
			setActive(var_75_1:Find("selected"), false)
		end

		return
	end

	UIItemList.StaticAlign(var_74_4, var_74_5, #var_74_7, nil)
	onButton(self, var_74_3, function()
		shiftPanel(var_74_2, var_74_2.rect.width + 200, nil, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
		shiftPanel(var_74_6, -30, nil, 0.3, 0, true, nil, LeanTweenType.easeOutSine)

		return
	end, SFX_PANEL)
	onButton(self, var_74_6, function()
		shiftPanel(var_74_2, 35, nil, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
		shiftPanel(var_74_6, var_74_6.rect.width + 200, nil, 0.3, 0, true, nil, LeanTweenType.easeOutSine)

		return
	end, SFX_PANEL)

	return
end

function LevelStageView:GetSubView(arg_80_1)
	if self.attachSubViews[arg_80_1] then
		return self.attachSubViews[arg_80_1]
	end

	local var_80_0 = _G[arg_80_1].New(self)

	assert(var_80_0, "cant't find subview " .. (arg_80_1 or "nil"))

	self.attachSubViews[arg_80_1] = var_80_0

	return var_80_0, true
end

function LevelStageView:RemoveSubView(arg_81_1)
	if not self.attachSubViews[arg_81_1] then
		return false
	end

	self.attachSubViews[arg_81_1]:Destroy()

	self.attachSubViews[arg_81_1] = nil

	return true
end

function LevelStageView:ClearSubViews()
	for iter_82_0, iter_82_1 in pairs(self.attachSubViews) do
		iter_82_1:Destroy()
	end

	table.clear(self.attachSubViews)

	return
end

function LevelStageView:updateStageFleet()
	local var_83_0 = findTF(self.leftStage, "fleet")
	local var_83_1 = findTF(var_83_0, "shiptpl")

	setActive(var_83_1, false)
	setText(self.topStage:Find("msg_panel/fleet_info/number"), self.contextData.chapterVO.fleet.id)

	local var_83_2 = self.contextData.chapterVO.fleet:getShips(true)

	local function var_83_3(arg_84_0, arg_84_1)
		local var_84_0 = UIItemList.New(arg_84_0, var_83_1)

		var_84_0:make(function(arg_85_0, arg_85_1, arg_85_2)
			if arg_85_0 == UIItemList.EventUpdate then
				local var_85_0 = arg_84_1[arg_85_1 + 1]

				updateShip(arg_85_2, arg_84_1[arg_85_1 + 1])

				local var_85_1 = arg_84_1[arg_85_1 + 1].hpRant
				local var_85_2 = math.floor((arg_84_1[arg_85_1 + 1].hpChange or 0) / 16 * arg_84_1[arg_85_1 + 1]:getShipProperties()[AttributeType.Durability])
				local var_85_3 = findTF(arg_85_2, "HP_POP")

				setActive(var_85_3, true)
				setActive(findTF(var_85_3, "heal"), false)
				setActive(findTF(var_85_3, "normal"), false)

				local function var_85_4(arg_86_0, arg_86_1)
					setActive(arg_86_0, true)
					setText(findTF(arg_86_0, "text"), arg_86_1)
					setTextAlpha(findTF(arg_86_0, "text"), 0)
					LeanTween.moveY(arg_86_0, 60, 1)
					LeanTween.textAlpha(findTF(arg_86_0, "text"), 1, 0.3)
					LeanTween.textAlpha(findTF(arg_86_0, "text"), 0, 0.5):setDelay(0.7):setOnComplete(System.Action(function()
						arg_86_0.localPosition = Vector3(0, 0, 0)

						return
					end))

					return
				end

				if var_85_2 > 0 then
					var_85_4(findTF(var_85_3, "heal"), var_85_2)
				elseif var_85_2 < 0 then
					LeanTween.delayedCall(0.6, System.Action(function()
						LeanTween.moveX(arg_85_2, arg_85_2.transform.localPosition.x, 0.05):setEase(LeanTweenType.easeInOutSine):setLoopPingPong(4)
						LeanTween.alpha(findTF(arg_85_2, "red"), 0.5, 0.4)
						LeanTween.alpha(findTF(arg_85_2, "red"), 0, 0.4):setDelay(0.4)
						var_85_4(findTF(var_85_3, "normal"), var_85_2)

						return
					end))
				end

				local var_85_5 = findTF(arg_85_2, "blood")
				local var_85_6 = findTF(arg_85_2, "blood/fillarea/green")
				local var_85_7 = findTF(arg_85_2, "blood/fillarea/red")
				local var_85_8 = var_85_1 < ChapterConst.HpGreen
				local var_85_9 = var_85_1 == 0

				setActive(var_85_6, not (var_85_1 < ChapterConst.HpGreen))
				setActive(var_85_7, var_85_8)

				var_85_5:GetComponent(typeof(Slider)).fillRect = var_85_8 and var_85_7 or var_85_6

				setSlider(var_85_5, 0, 10000, var_85_1)
				setActive(findTF(arg_85_2, "repairmask"), var_85_8)
				setActive(findTF(arg_85_2, "repairmask/broken"), var_85_9)
				onButton(self, arg_85_2:Find("repairmask"), function()
					self:emit(LevelUIConst.DISPLAY_REPAIR_WINDOW, var_85_0)

					return
				end, SFX_PANEL)

				local var_85_10 = findTF(arg_85_2, "repairmask/icon").gameObject

				if not var_85_8 then
					LeanTween.cancel(var_85_10)
					setImageAlpha(var_85_10, 1)
				end

				if var_85_8 and not LeanTween.isTweening(var_85_10) then
					LeanTween.alpha(rtf(var_85_10), 0, 2):setLoopPingPong()
				end

				local var_85_11 = GetOrAddComponent(arg_85_2, "UILongPressTrigger").onLongPressed

				pg.DelegateInfo.Add(self, var_85_11)
				var_85_11:RemoveAllListeners()
				var_85_11:AddListener(function()
					self:emit(LevelMediator2.ON_STAGE_SHIPINFO, {
						shipId = var_85_0.id,
						shipVOs = var_83_2
					})

					return
				end)
			end

			return
		end)
		var_84_0:align(#arg_84_1)

		return
	end

	var_83_3(var_83_0:Find("main"), self.contextData.chapterVO.fleet:getShipsByTeam(TeamType.Main, true))
	var_83_3(var_83_0:Find("vanguard"), self.contextData.chapterVO.fleet:getShipsByTeam(TeamType.Vanguard, true))
	self.contextData.chapterVO.fleet:clearShipHpChange()

	return
end

function LevelStageView:updateSupportFleet()
	local var_91_0 = self.contextData.chapterVO:getChapterSupportFleet()
	local var_91_1 = findTF(self.leftStage, "support_fleet")

	setActive(var_91_1, tobool(var_91_0))

	if var_91_0 then
		local var_91_2 = findTF(var_91_1, "show/ship_container")

		removeAllChildren(var_91_2)

		local var_91_3 = findTF(var_91_1, "show/shiptpl")

		for iter_91_0, iter_91_1 in pairs((var_91_0:getShips())) do
			local var_91_4 = cloneTplTo(var_91_3, var_91_2)

			setActive(var_91_4, true)
			updateShip(var_91_4, iter_91_1)
		end

		local var_91_5 = var_91_1:Find("hide")
		local var_91_6 = var_91_1:Find("show")

		local function var_91_7(arg_92_0)
			setActive(var_91_5, true)
			setActive(var_91_6, true)
			shiftPanel(var_91_6, nil, arg_92_0 and -325.1 or -855, 0.3, 0, true, nil, LeanTweenType.easeOutSine, function()
				setActive(var_91_5, not arg_92_0)
				setActive(var_91_6, arg_92_0)

				return
			end)
			shiftPanel(var_91_5, nil, arg_92_0 and -1017 or -563.97, 0.3, 0, true, nil, LeanTweenType.easeOutSine)

			return
		end

		onButton(self, var_91_5, function()
			var_91_7(true)

			return
		end, SFX_PANEL)
		onButton(self, var_91_6, function()
			var_91_7(false)

			return
		end)
	end

	return
end

function LevelStageView:ShiftStagePanelIn(arg_96_1)
	shiftPanel(self.topStage, 0, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine, arg_96_1)
	self:ShiftBottomStage(true)
	shiftPanel(self.leftStage, 0, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
	shiftPanel(self.rightStage, 0, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)

	return
end

function LevelStageView:ShiftStagePanelOut(arg_97_1)
	shiftPanel(self.topStage, 0, self.topStage.rect.height, 0.3, 0, true, nil, LeanTweenType.easeOutSine, arg_97_1)
	self:ShiftBottomStage(false)
	shiftPanel(self.leftStage, -self.leftStage.rect.width - 200, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
	shiftPanel(self.rightStage, self.rightStage.rect.width + 300, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)

	return
end

function LevelStageView:ShiftBottomStage(arg_98_1)
	if not self.bottomStageInactive then
		-- block empty
	else
		arg_98_1 = false
	end

	local var_98_0

	var_98_0(self.bottomStage, 0, arg_98_1 and 0 or -self.bottomStage.rect.height, 0.3, 0, true, nil, LeanTweenType.easeOutSine)

	return
end

function LevelStageView:SwitchSubTeleportBottomStage()
	setActive(self.missileStrikeRole, true)
	setText(findTF(self.missileStrikeRole, "confirm_button/Text"), i18n("levelscene_deploy_submarine"))
	setText(findTF(self.missileStrikeRole, "cancel_button/Text"), i18n("levelscene_deploy_submarine_cancel"))
	onButton(self, self.missileStrikeRole:Find("confirm_button"), function()
		local var_100_0 = self.contextData.chapterVO:GetSubmarineFleet()
		local var_100_1 = self.grid.subTeleportTargetLine

		if not self.grid.subTeleportTargetLine then
			return
		end

		local var_100_2 = self.contextData.chapterVO:findPath(nil, var_100_0.startPos, self.grid.subTeleportTargetLine)

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("tips_confirm_teleport_sub", self.grid:TransformLine2PlanePos(var_100_0.startPos), self.grid:TransformLine2PlanePos(self.grid.subTeleportTargetLine), var_100_2, (math.ceil(pg.strategy_data_template[ChapterConst.StrategySubTeleport].arg[2] * #var_100_0:getShips(false) * var_100_2 - 1e-05))),
			onYes = function()
				self:emit(LevelMediator2.ON_OP, {
					type = ChapterConst.OpSubTeleport,
					id = var_100_0.id,
					arg1 = var_100_1.row,
					arg2 = var_100_1.column
				})

				return
			end
		})

		return
	end, SFX_UI_CLICK)
	onButton(self, self.missileStrikeRole:Find("cancel_button"), function()
		self:SwitchBottomStagePanel(false)
		self.grid:TurnOffSubTeleport()
		self.grid:updateQuadCells(ChapterConst.QuadStateNormal)

		return
	end, SFX_UI_CLICK)

	return
end

function LevelStageView:SwitchMissileBottomStagePanel()
	setActive(self.missileStrikeRole, true)
	setText(findTF(self.missileStrikeRole, "confirm_button/Text"), i18n("missile_attack_area_confirm"))
	setText(findTF(self.missileStrikeRole, "cancel_button/Text"), i18n("missile_attack_area_cancel"))
	onButton(self, self.missileStrikeRole:Find("confirm_button"), function()
		local var_104_0 = self.grid.missileStrikeTargetLine

		if not self.grid.missileStrikeTargetLine then
			return
		end

		local var_104_1 = self.contextData.chapterVO.fleet

		;(function()
			self:emit(LevelMediator2.ON_OP, {
				type = ChapterConst.OpStrategy,
				id = var_104_1.id,
				arg1 = ChapterConst.StrategyMissileStrike,
				arg2 = var_104_0.row,
				arg3 = var_104_0.column
			})

			return
		end)()

		return
	end, SFX_UI_CLICK)
	onButton(self, self.missileStrikeRole:Find("cancel_button"), function()
		self:SwitchBottomStagePanel(false)
		self.grid:HideMissileAimingMark()
		self.grid:updateQuadCells(ChapterConst.QuadStateNormal)

		return
	end, SFX_UI_CLICK)

	return
end

function LevelStageView:SwitchAirSupportBottomStagePanel()
	setActive(self.missileStrikeRole, true)
	setText(findTF(self.missileStrikeRole, "confirm_button/Text"), i18n("missile_attack_area_confirm"))
	setText(findTF(self.missileStrikeRole, "cancel_button/Text"), i18n("missile_attack_area_cancel"))
	onButton(self, self.missileStrikeRole:Find("confirm_button"), function()
		local var_108_0 = self.grid.missileStrikeTargetLine

		if not self.grid.missileStrikeTargetLine then
			return
		end

		local var_108_1 = self.contextData.chapterVO:getChapterSupportFleet()

		;(function()
			self:emit(LevelMediator2.ON_OP, {
				type = ChapterConst.OpStrategy,
				id = var_108_1.id,
				arg1 = ChapterConst.StrategyAirSupport,
				arg2 = var_108_0.row,
				arg3 = var_108_0.column
			})

			return
		end)()

		return
	end, SFX_UI_CLICK)
	onButton(self, self.missileStrikeRole:Find("cancel_button"), function()
		self:SwitchBottomStagePanel(false)
		self.grid:HideAirSupportAimingMark()
		self.grid:updateQuadCells(ChapterConst.QuadStateNormal)

		return
	end, SFX_UI_CLICK)

	return
end

function LevelStageView:SwitchAirExpelBottomStagePanel()
	setActive(self.airExpelRole, true)
	setText(findTF(self.airExpelRole, "cancel_button/Text"), i18n("levelscene_airexpel_cancel"))
	onButton(self, self.airExpelRole:Find("cancel_button"), function()
		self:SwitchBottomStagePanel(false)
		self.grid:HideAirExpelAimingMark()
		self.grid:CleanAirSupport()
		self.grid:updateQuadCells(ChapterConst.QuadStateNormal)

		return
	end, SFX_UI_CLICK)

	return
end

function LevelStageView:SwitchBottomStagePanel(arg_113_1)
	setActive(self.actionRole, true)
	setActive(self.normalRole, true)
	shiftPanel(self.actionRole, 0, arg_113_1 and 0 or var_0_1, 0.3, 0, true, true, nil, function()
		setActive(self.actionRole, arg_113_1)

		return
	end)
	shiftPanel(self.normalRole, 0, (arg_113_1 or nil) and (var_0_1 or 0), 0.3, 0, true, true, nil, function()
		setActive(self.normalRole, not arg_113_1)

		if not arg_113_1 then
			eachChild(self.actionRole, function(arg_116_0)
				setActive(arg_116_0, false)

				return
			end)
		end

		return
	end)
	shiftPanel(self.leftStage, (arg_113_1 or nil) and (-self.leftStage.rect.width - 200 or 0), 0, 0.3, 0, true)
	shiftPanel(self.rightStage, (arg_113_1 or nil) and (self.rightStage.rect.width + 300 or 0), 0, 0.3, 0, true)

	return
end

function LevelStageView:ClickGridCellNormal(arg_117_1)
	local var_117_0 = _.detect(self.contextData.chapterVO.fleets, function(arg_118_0)
		return arg_118_0:getFleetType() == FleetType.Normal and arg_118_0.line.row == arg_117_1.row and arg_118_0.line.column == arg_117_1.column
	end)

	if var_117_0 and var_117_0:isValid() and var_117_0.id ~= self.contextData.chapterVO.fleet.id then
		self:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpSwitch,
			id = var_117_0.id
		})

		return
	end

	if self:tryAutoTrigger(nil, true) then
		return
	end

	if arg_117_1.row == self.contextData.chapterVO.fleet.line.row and arg_117_1.column == self.contextData.chapterVO.fleet.line.column then
		return
	end

	local var_117_1 = self.contextData.chapterVO:getChapterCell(arg_117_1.row, arg_117_1.column)

	if var_117_1.attachment == ChapterConst.AttachStory and var_117_1.data == ChapterConst.StoryObstacle and var_117_1.flag == ChapterConst.CellFlagTriggerActive then
		if pg.map_event_template[var_117_1.attachmentId] and pg.map_event_template[var_117_1.attachmentId].gametip and #pg.map_event_template[var_117_1.attachmentId].gametip > 0 and self.contextData.chapterVO:getPlayType() ~= ChapterConst.TypeDefence then
			pg.TipsMgr.GetInstance():ShowTips(i18n(pg.map_event_template[var_117_1.attachmentId].gametip))
		end

		return
	elseif not self.contextData.chapterVO:considerAsStayPoint(ChapterConst.SubjectPlayer, arg_117_1.row, arg_117_1.column) then
		return
	elseif self.contextData.chapterVO:existMoveLimit() and not _.any(self.contextData.chapterVO:calcWalkableCells(ChapterConst.SubjectPlayer, self.contextData.chapterVO.fleet.line.row, self.contextData.chapterVO.fleet.line.column, self.contextData.chapterVO.fleet:getSpeed()), function(arg_119_0)
		return arg_119_0.row == arg_117_1.row and arg_119_0.column == arg_117_1.column
	end) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("destination_not_in_range"))

		return
	end

	local var_117_2 = self.contextData.chapterVO:findPath(ChapterConst.SubjectPlayer, self.contextData.chapterVO.fleet.line, {
		row = arg_117_1.row,
		column = arg_117_1.column
	})

	if var_117_2 < PathFinding.PrioObstacle then
		self:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpMove,
			id = self.contextData.chapterVO.fleet.id,
			arg1 = arg_117_1.row,
			arg2 = arg_117_1.column
		})
	elseif var_117_2 < PathFinding.PrioForbidden then
		pg.TipsMgr.GetInstance():ShowTips(i18n("destination_can_not_reach"))
	else
		pg.TipsMgr.GetInstance():ShowTips(i18n("destination_can_not_reach"))
	end

	return
end

function LevelStageView:tryAutoAction(arg_120_1)
	if self.doingAutoAction then
		return
	end

	self.doingAutoAction = true

	local var_120_0 = self.contextData.chapterVO

	if not self.contextData.chapterVO then
		existCall(arg_120_1)

		return
	end

	if self:SafeCheck() then
		existCall(arg_120_1)

		return
	end

	local var_120_1 = {}
	local var_120_2 = false

	for iter_120_0, iter_120_1 in pairs(self.contextData.chapterVO.cells) do
		if iter_120_1.trait == ChapterConst.TraitLurk then
			var_120_2 = true

			break
		end
	end

	if not var_120_2 then
		for iter_120_2, iter_120_3 in ipairs(self.contextData.chapterVO.champions) do
			if iter_120_3.trait == ChapterConst.TraitLurk then
				var_120_2 = true

				break
			end
		end
	end

	if var_120_2 then
		local var_120_3 = self.contextData.chapterVO:existOni()
		local var_120_4 = self.contextData.chapterVO:isPlayingWithBombEnemy()

		if not var_120_3 and not var_120_4 then
			table.insert(var_120_1, function(arg_121_0)
				self:emit(LevelUIConst.DO_TRACKING, arg_121_0)

				return
			end)
		else
			table.insertto(var_120_1, {
				function(arg_122_0)
					local var_122_0

					if var_120_3 then
						var_122_0 = "SpUnit"
					elseif var_120_4 then
						var_122_0 = "SpBomb"
					end

					assert(var_122_0)
					self:emit(LevelUIConst.DO_PLAY_ANIM, {
						name = var_122_0,
						callback = function(arg_123_0)
							setActive(arg_123_0, false)
							arg_122_0()

							return
						end
					})

					return
				end,
				function(arg_124_0)
					local var_124_0 = var_120_0:getSpAppearStory()

					if var_124_0 and #var_124_0 > 0 then
						pg.NewStoryMgr.GetInstance():Play(var_124_0, arg_124_0)

						return
					end

					arg_124_0()

					return
				end,
				function(arg_125_0)
					local var_125_0 = var_120_0:getSpAppearGuide()

					if var_125_0 and #var_125_0 > 0 then
						pg.SystemGuideMgr.GetInstance():PlayByGuideId(var_125_0, nil, arg_125_0)

						return
					end

					arg_125_0()

					return
				end
			})
		end

		table.insertto(var_120_1, {
			function(arg_126_0)
				parallelAsync({
					function(arg_127_0)
						self:tryPlayChapterStory(arg_127_0)

						return
					end,
					function(arg_128_0)
						local var_128_0 = var_120_0:GetBossCell()

						if var_128_0 and var_128_0.trait == ChapterConst.TraitLurk then
							self.grid:focusOnCell(var_128_0, arg_128_0)

							return
						end

						arg_128_0()

						return
					end
				}, arg_126_0)

				return
			end,
			function(arg_129_0)
				self:updateTrait(ChapterConst.TraitVirgin)
				self.grid:updateAttachments()
				self.grid:updateChampions()
				self:updateTrait(ChapterConst.TraitNone)
				self:emit(LevelMediator2.ON_OVERRIDE_CHAPTER)
				Timer.New(arg_129_0, 0.5, 1):Start()

				return
			end
		})
	end

	seriesAsync({
		function(arg_130_0)
			self:emit(LevelUIConst.FROZEN)

			local var_130_0 = getProxy(ChapterProxy):GetLastDefeatedEnemy(var_120_0.id)

			if var_130_0 then
				if var_130_0.attachment == ChapterConst.AttachAmbush then
					if ChapterConst.IsBossCell(var_130_0) then
						self.grid:PlayAttachmentEffect(var_130_0.line.row, var_130_0.line.column, ChapterConst.GetDestroyFX(var_130_0), Vector2.zero)
					end
				end
			end

			self:PopBar()
			self:UpdateComboPanel()
			arg_130_0()

			return
		end,
		function(arg_131_0)
			if not (function()
				local var_132_0 = getProxy(ChapterProxy):GetLastDefeatedEnemy(var_120_0.id)

				if not var_132_0 then
					return
				end

				return pg.expedition_data_template[var_132_0.attachmentId] and pg.expedition_data_template[var_132_0.attachmentId].type == ChapterConst.ExpeditionTypeMulBoss
			end)() then
				return arg_131_0()
			end

			self:emit(LevelUIConst.DO_PLAY_ANIM, {
				name = "BossRetreatBar",
				callback = function(arg_133_0)
					setActive(arg_133_0, false)
					arg_131_0()

					return
				end
			})

			return
		end,
		function(arg_134_0)
			self:UpdateDOALinkFeverPanel(arg_134_0)

			return
		end,
		function(arg_135_0)
			seriesAsync(var_120_1, arg_135_0)

			return
		end,
		function(arg_136_0)
			local var_136_0, var_136_1 = var_120_0:GetAttachmentStories()

			if var_136_0 then
				table.SerialIpairsAsync(var_136_0, function(arg_137_0, arg_137_1, arg_137_2)
					if arg_137_0 <= var_136_1 and arg_137_1 and type(arg_137_1) == "number" and arg_137_1 > 0 then
						ChapterOpCommand.PlayChapterStory(pg.NewStoryMgr:StoryId2StoryName(arg_137_1), arg_137_2, var_120_0:IsAutoFight())

						return
					end

					arg_137_2()

					return
				end, arg_136_0)

				return
			end

			arg_136_0()

			return
		end,
		function(arg_138_0)
			local var_138_0 = getProxy(ChapterProxy):getUpdatedExtraFlags(self.contextData.chapterVO.id)

			if not var_138_0 or #var_138_0 < 1 then
				arg_138_0()

				return
			end

			for iter_138_0, iter_138_1 in ipairs(var_138_0) do
				if pg.chapter_status_effect[iter_138_1] then
					local var_138_1 = pg.chapter_status_effect[iter_138_1].camera_focus or ""

					if type(var_138_1) == "table" then
						self.grid:focusOnCell({
							row = var_138_1[1],
							column = var_138_1[2]
						}, arg_138_0)

						return
					end
				end
			end

			arg_138_0()

			return
		end,
		function(arg_139_0)
			if self.exited then
				return
			end

			self:emit(LevelUIConst.UN_FROZEN)
			;(function()
				local var_140_0 = getProxy(ChapterProxy)
				local var_140_1 = var_140_0:getActiveChapter(true)

				if not var_140_1 then
					return
				end

				local var_140_2 = var_140_1.id

				var_140_0:RecordComboHistory(var_140_1.id, nil)
				var_140_0:RecordLastDefeatedEnemy(var_140_2, nil)
				var_140_0:extraFlagUpdated(var_140_2)
				var_140_0:RemoveExtendChapterData(var_140_2, "FleetMoveDistance")

				return
			end)()
			arg_139_0()

			return
		end
	}, function()
		if self.exited then
			return
		end

		self.doingAutoAction = nil

		if var_120_2 and self:TryEnterChapterStoryStage() then
			-- block empty
		else
			existCall(arg_120_1)
		end

		return
	end)

	return
end

function LevelStageView:tryPlayChapterStory(arg_142_1)
	local var_142_0 = self.contextData.chapterVO
	local var_142_1 = self.contextData.chapterVO:getWaveCount()

	seriesAsync({
		function(arg_143_0)
			pg.SystemGuideMgr.GetInstance():PlayChapter(var_142_0, arg_143_0)

			return
		end,
		function(arg_144_0)
			local var_144_0 = var_142_0:getConfig("story_refresh")
			local var_144_1 = var_144_0 and var_144_0[var_142_1]

			if var_144_0 and var_144_0[var_142_1] and type(var_144_1) == "string" and var_144_1 ~= "" and not var_142_0:IsRemaster() then
				ChapterOpCommand.PlayChapterStory(var_144_1, arg_144_0, var_142_0:IsAutoFight())

				return
			end

			arg_144_0()

			return
		end,
		function(arg_145_0)
			local var_145_0 = var_142_0:getConfig("story_refresh_boss")

			if var_145_0 and type(var_145_0) == "string" and var_145_0 ~= "" and not var_142_0:IsRemaster() and var_142_0:IsFinalBossRefreshed() then
				ChapterOpCommand.PlayChapterStory(var_145_0, arg_145_0, var_142_0:IsAutoFight())

				return
			end

			arg_145_0()

			return
		end,
		function(arg_146_0)
			if var_142_1 == 1 and pg.map_event_list[var_142_0.id] and pg.map_event_list[var_142_0.id].help_open == 1 and PlayerPrefs.GetInt("help_displayed_on_" .. var_142_0.id, 0) == 0 then
				triggerButton(self.helpBtn)
				PlayerPrefs.SetInt("help_displayed_on_" .. var_142_0.id, 1)
			end

			arg_146_0()

			return
		end,
		function()
			existCall(arg_142_1)

			return
		end
	})

	return
end

function LevelStageView:TryEnterChapterStoryStage(arg_148_1)
	local var_148_0 = self.contextData.chapterVO:getWaveCount()
	local var_148_1 = self.contextData.chapterVO:getConfig("story_refresh")
	local var_148_2 = var_148_1 and var_148_1[var_148_0]

	if var_148_1 and var_148_1[var_148_0] and type(var_148_2) == "number" and not self.contextData.chapterVO:IsRemaster() then
		if not pg.NewStoryMgr.GetInstance():IsPlayed(pg.NewStoryMgr.GetInstance():StoryId2StoryName(var_148_2)) then
			self:emit(LevelMediator2.ON_PERFORM_COMBAT, var_148_2)

			return true
		end
	end

	local var_148_3 = self.contextData.chapterVO:getConfig("story_refresh_boss")

	if var_148_3 and type(var_148_3) == "number" and not self.contextData.chapterVO:IsRemaster() and self.contextData.chapterVO:IsFinalBossRefreshed() then
		if not pg.NewStoryMgr.GetInstance():IsPlayed(pg.NewStoryMgr.GetInstance():StoryId2StoryName(var_148_3)) then
			self:emit(LevelMediator2.ON_PERFORM_COMBAT, var_148_3)

			return true
		end
	end

	return
end

function LevelStageView:TryEnterChapterSupportSubmarineStage(arg_149_1)
	local var_149_0 = self.contextData.chapterVO:getChapterSupportFleet()

	if self.contextData.chapterVO:getChapterSupportFleet() then
		self:emit(LevelMediator2.ON_SUPPORT_SUBMARINE)
	else
		self:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OPSubStrike,
			arg1 = ys.Battle.BattleConst.BattleScore.C,
			callback = arg_149_1
		})
	end

	return
end

local var_0_4 = {
	[ChapterConst.KizunaJammingDodge] = "kizunaOperationSafe",
	[ChapterConst.KizunaJammingEngage] = "kizunaOperationDanger",
	[ChapterConst.StatusDay] = "HololiveDayBar",
	[ChapterConst.StatusNight] = "HololiveNightBar",
	[ChapterConst.StatusAirportUnderControl] = "AirportCaptureBar",
	[ChapterConst.StatusSunset] = "SunsetBar",
	[ChapterConst.StatusMaze1] = "MazeBar",
	[ChapterConst.StatusMaze2] = "MazeBar",
	[ChapterConst.StatusMaze3] = "MazeBar",
	[ChapterConst.StatusMissile1] = "MissileBar",
	[ChapterConst.StatusMissileInit] = "MissileWarningBar",
	[ChapterConst.StatusMissile1B] = "MissileBar",
	[ChapterConst.StatusMissileInitB] = "MissileWarningBar",
	[ChapterConst.StatusMusashiGame1] = "MusashiGameBar_1",
	[ChapterConst.StatusMusashiGame2] = "MusashiGameBar_2",
	[ChapterConst.StatusMusashiGame3] = "MusashiGameBar_3",
	[ChapterConst.StatusMusashiGame4] = "MusashiGameBar_4",
	[ChapterConst.StatusMusashiGame5] = "MusashiGameBar_5",
	[ChapterConst.StatusMusashiGame6] = "MusashiGameBar_6",
	[ChapterConst.StatusMusashiGame7] = "MusashiGameBar_7",
	[ChapterConst.StatusMusashiGame8] = "MusashiGameBar_8"
}

function LevelStageView:PopBar()
	local var_150_0 = getProxy(ChapterProxy):getUpdatedExtraFlags(self.contextData.chapterVO.id)

	if not var_150_0 or #var_150_0 < 1 then
		return
	end

	local var_150_1 = var_0_4[var_150_0[1]]

	if not var_0_4[var_150_0[1]] then
		return
	end

	local var_150_2, var_150_3 = self:GetSubView(var_150_1)

	if var_150_3 then
		var_150_2:Load()
	end

	var_150_2.buffer:PlayAnim()

	return
end

function LevelStageView:updateTrait(arg_151_1)
	for iter_151_0, iter_151_1 in pairs(self.contextData.chapterVO.cells) do
		if iter_151_1.trait ~= ChapterConst.TraitNone then
			iter_151_1.trait = arg_151_1
		end
	end

	for iter_151_2, iter_151_3 in ipairs(self.contextData.chapterVO.champions) do
		if iter_151_3.trait ~= ChapterConst.TraitNone then
			iter_151_3.trait = arg_151_1
		end
	end

	return
end

function LevelStageView:CheckFleetChange()
	local var_152_0 = _.detect(self.contextData.chapterVO.fleets, function(arg_153_0)
		return not arg_153_0:isValid()
	end)

	if var_152_0 then
		self:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpRetreat,
			id = var_152_0.id
		})

		if var_152_0:getFleetType() == TeamType.Normal then
			getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.BATTLE_FAILED)
		end
	end

	if not self.contextData.chapterVO:GetActiveFleet():isValid() then
		local var_152_1 = self.contextData.chapterVO:getNextValidIndex()

		if var_152_1 > 0 then
			local var_152_2 = self.contextData.chapterVO.fleets[var_152_1]

			local function var_152_3()
				self:emit(LevelMediator2.ON_OP, {
					type = ChapterConst.OpSwitch,
					id = var_152_2.id
				})

				return
			end

			self:HandleShowMsgBox({
				modal = true,
				hideNo = true,
				content = i18n("formation_switch_tip", self.contextData.chapterVO.fleets[var_152_1].name),
				onYes = var_152_3,
				onNo = var_152_3
			})
		end

		return true
	end

	return false
end

function LevelStageView:tryAutoTrigger(arg_155_1, arg_155_2)
	local var_155_0 = self.contextData.chapterVO

	if self:DoBreakAction() then
		return
	end

	if self:CheckFleetChange() then
		return
	end

	return ((function()
		if var_155_0:checkAnyInteractive() then
			if not arg_155_1 or var_155_0:IsAutoFight() then
				triggerButton(self.funcBtn)

				return true
			end
		elseif var_155_0:getRound() == ChapterConst.RoundEnemy then
			self:emit(LevelMediator2.ON_OP, {
				type = ChapterConst.OpEnemyRound
			})

			return true
		elseif var_155_0:getRound() == ChapterConst.RoundPlayer then
			if not arg_155_2 then
				self.grid:updateQuadCells(ChapterConst.QuadStateNormal)
			end

			if var_155_0:IsAutoFight() then
				self:TryAutoFight()

				return true
			end
		end

		return
	end)())
end

function LevelStageView:DoBreakAction()
	local var_157_0 = self.contextData.chapterVO
	local var_157_1, var_157_2 = self:SafeCheck()

	if var_157_1 then
		local function var_157_3(arg_158_0)
			local var_158_0

			seriesAsync({
				function(arg_159_0)
					self:emit(LevelUIConst.ADD_MSG_QUEUE, arg_159_0)

					return
				end,
				function(arg_160_0, arg_160_1)
					var_158_0 = arg_160_1

					ChapterOpCommand.PrepareChapterRetreat(arg_160_0)

					return
				end,
				function(arg_161_0)
					existCall(arg_158_0)
					existCall(var_158_0)

					return
				end
			})

			return
		end

		if var_157_2 == ChapterConst.ReasonVictory then
			seriesAsync({
				function(arg_162_0)
					var_157_3(arg_162_0)

					return
				end,
				function(arg_163_0)
					local var_163_0 = var_157_0:getConfig("win_condition_display") and #var_163_0 > 0 and var_163_0 .. "_tip"

					if var_163_0 and pg.gametip[var_163_0] then
						pg.TipsMgr.GetInstance():ShowTips(i18n(var_163_0))
					else
						pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_chapter_win"))
					end

					arg_163_0()

					return
				end
			})
		elseif var_157_2 == ChapterConst.ReasonDefeat then
			if self.contextData.chapterVO:getPlayType() == ChapterConst.TypeTransport then
				pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_escort_lose"))
				var_157_3()
			else
				self:HandleShowMsgBox({
					modal = true,
					hideNo = true,
					content = i18n("formation_invalide"),
					onYes = var_157_3,
					onClose = var_157_3
				})
			end
		elseif var_157_2 == ChapterConst.ReasonDefeatDefense then
			self:HandleShowMsgBox({
				modal = true,
				hideNo = true,
				content = i18n("harbour_bomb_tip"),
				onYes = var_157_3,
				onClose = var_157_3
			})
		elseif var_157_2 == ChapterConst.ReasonVictoryOni then
			var_157_3()
		elseif var_157_2 == ChapterConst.ReasonDefeatOni then
			var_157_3()
		elseif var_157_2 == ChapterConst.ReasonDefeatBomb then
			var_157_3()
		elseif var_157_2 == ChapterConst.ReasonOutTime then
			self:emit(LevelMediator2.ON_TIME_UP)
		elseif var_157_2 == ChapterConst.ReasonActivityOutTime then
			self:HandleShowMsgBox({
				modal = true,
				hideNo = true,
				content = i18n("battle_preCombatMediator_activity_timeout"),
				onYes = var_157_3,
				onClose = var_157_3
			})
		end

		return true
	end

	return var_157_1
end

function LevelStageView:SafeCheck()
	if self.contextData.chapterVO:existOni() then
		local var_164_0 = self.contextData.chapterVO:checkOniState()

		if var_164_0 == 1 then
			return true, ChapterConst.ReasonVictoryOni
		elseif var_164_0 == 2 then
			return true, ChapterConst.ReasonDefeatOni
		else
			return false
		end
	elseif self.contextData.chapterVO:isPlayingWithBombEnemy() then
		if self.contextData.chapterVO:getBombChapterInfo().action_times * 2 <= self.contextData.chapterVO.roundIndex then
			return true, ChapterConst.ReasonDefeatBomb
		else
			return false
		end
	end

	local var_164_1, var_164_2 = self.contextData.chapterVO:CheckChapterWin()

	if var_164_1 then
		return true, var_164_2
	end

	local var_164_3, var_164_4 = self.contextData.chapterVO:CheckChapterLose()

	if var_164_3 then
		return true, var_164_4
	end

	if not self.contextData.chapterVO:inWartime() then
		return true, ChapterConst.ReasonOutTime
	end

	local var_164_5 = self.contextData.chapterVO:GetBindActID()

	if not self.contextData.map:isRemaster() and var_164_5 ~= 0 then
		local var_164_6 = getProxy(ActivityProxy):getActivityById(var_164_5)

		if not var_164_6 or var_164_6:isEnd() then
			return true, ChapterConst.ReasonActivityOutTime
		end
	end

	return false
end

function LevelStageView:TryAutoFight()
	local var_165_0 = self.contextData.chapterVO

	if not self.contextData.chapterVO:IsAutoFight() then
		return
	end

	local var_165_2 = self.contextData.chapterVO:GetAllEnemies()
	local var_165_3 = _.detect(var_165_2, function(arg_166_0)
		return ChapterConst.IsBossCell(arg_166_0)
	end)
	local var_165_4 = self.contextData.chapterVO:GetFleetOfDuty(tobool(var_165_3))

	if var_165_4 and var_165_4.id ~= self.contextData.chapterVO.fleet.id then
		self:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpSwitch,
			id = var_165_4.id
		})
		self:tryAutoTrigger()

		return
	end

	if self.contextData.chapterVO:checkAnyInteractive() then
		self:tryAutoTrigger()

		return
	end

	local var_165_5

	for iter_165_0, iter_165_1 in ipairs(self.contextData.chapterVO:getConfig("box_auto_pick")) do
		for iter_165_2, iter_165_3 in ipairs((underscore.filter(switch(iter_165_1, {
			[ChapterConst.AttachBox] = function()
				return var_165_0:findChapterCells(iter_165_1)
			end,
			[ChapterConst.AttachSupply] = function()
				local var_168_0, var_168_1 = var_165_0:getFleetAmmo(var_165_4)

				if var_168_0 - var_168_1 < 3 then
					return {}
				else
					return underscore.filter(var_165_0:findChapterCells(iter_165_1), function(arg_169_0)
						return arg_169_0.attachmentId > 0
					end)
				end

				return
			end
		}), function(arg_170_0)
			return arg_170_0.flag ~= ChapterConst.CellFlagDisabled
		end))) do
			local var_165_6, var_165_7 = self.contextData.chapterVO:findPath(ChapterConst.SubjectPlayer, var_165_4.line, iter_165_3)

			if var_165_6 < PathFinding.PrioObstacle then
				var_165_5 = var_165_5 or {}

				table.insert(var_165_5, {
					target = iter_165_3,
					priority = var_165_6,
					path = var_165_7
				})
			end
		end

		if var_165_5 then
			table.sort(var_165_5, CompareFuncs({
				function(arg_171_0)
					return arg_171_0.priority
				end
			}))

			break
		end
	end

	if not var_165_5 then
		if var_165_3 then
			local var_165_8, var_165_9 = self.contextData.chapterVO:FindBossPath(var_165_4.line, var_165_3)
			local var_165_10 = {}
			local var_165_11

			for iter_165_4, iter_165_5 in ipairs(var_165_9) do
				table.insert(var_165_10, iter_165_5)

				if self.contextData.chapterVO:existEnemy(ChapterConst.SubjectPlayer, iter_165_5.row, iter_165_5.column) then
					var_165_8 = iter_165_4
					var_165_11 = iter_165_5

					break
				end
			end

			var_165_5 = {
				{
					target = var_165_11 or var_165_3,
					priority = var_165_8 or 0,
					path = var_165_10
				}
			}
		else
			var_165_5 = underscore.map(var_165_2, function(arg_172_0)
				local var_172_0, var_172_1 = var_165_0:findPath(ChapterConst.SubjectPlayer, var_165_4.line, arg_172_0)

				return {
					target = arg_172_0,
					priority = var_172_0,
					path = var_172_1
				}
			end)

			local function var_165_12(arg_173_0)
				assert(pg.expedition_data_template[arg_173_0.target.attachmentId], "expedition_data_template not exist: " .. arg_173_0.target.attachmentId)

				if arg_173_0.target.flag == ChapterConst.CellFlagDisabled then
					return 0
				end

				return ChapterConst.EnemyPreference[pg.expedition_data_template[arg_173_0.target.attachmentId].type]
			end

			if self.contextData.chapterVO.id == 1604 then
				table.sort(var_165_5, CompareFuncs({
					function(arg_174_0)
						return arg_174_0.priority < PathFinding.PrioObstacle and 0 or 1
					end,
					function(arg_175_0)
						return -var_165_12(arg_175_0)
					end,
					function(arg_176_0)
						return arg_176_0.priority
					end,
					function(arg_177_0)
						return arg_177_0.target.row
					end,
					function(arg_178_0)
						return -arg_178_0.target.column
					end
				}))
			else
				table.sort(var_165_5, CompareFuncs({
					function(arg_179_0)
						return arg_179_0.priority < PathFinding.PrioObstacle and 0 or 1
					end,
					function(arg_180_0)
						return -var_165_12(arg_180_0)
					end,
					function(arg_181_0)
						return arg_181_0.priority
					end
				}))
			end
		end
	end

	if var_165_5 and #var_165_5 > 0 and var_165_5[1].priority < PathFinding.PrioObstacle then
		self:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpMove,
			id = var_165_4.id,
			arg1 = var_165_5[1].target.row,
			arg2 = var_165_5[1].target.column
		})
	else
		pg.TipsMgr.GetInstance():ShowTips(i18n("autofight_errors_tip"))
		getProxy(ChapterProxy):SetChapterAutoFlag(self.contextData.chapterVO.id, false)
	end

	return
end

function LevelStageView:popStageStrategy()
	local var_182_0 = self.rightStage:Find("event/collapse")

	if var_182_0.anchoredPosition.x <= 1 then
		triggerButton(var_182_0)
	end

	return
end

function LevelStageView:UpdateAutoFightPanel()
	if self.contextData.chapterVO:CanActivateAutoFight() then
		if not self.autoFightPanel then
			self.autoFightPanel = LevelStageAutoFightPanel.New(self.rightStage:Find("event/collapse"), self.event, self.contextData)

			self.autoFightPanel:Load()

			self.autoFightPanel.isFrozen = self.isFrozen
		end

		self.autoFightPanel.buffer:Show()
	elseif self.autoFightPanel then
		self.autoFightPanel.buffer:Hide()
	end

	return
end

function LevelStageView:UpdateAutoFightMark()
	if not self.autoFightPanel then
		return
	end

	self.autoFightPanel.buffer:UpdateAutoFightMark()

	return
end

function LevelStageView:DestroyAutoFightPanel()
	if not self.autoFightPanel then
		return
	end

	self.autoFightPanel:Destroy()

	self.autoFightPanel = nil

	return
end

function LevelStageView:DestroyToast()
	if not self.toastPanel then
		return
	end

	self.toastPanel:Destroy()

	self.toastPanel = nil

	return
end

function LevelStageView:Toast()
	self:DestroyToast()

	local var_187_0 = table.remove(self.toastQueue, 1)

	if not var_187_0 then
		return
	end

	self.toastPanel = var_187_0.Class.New(self)

	self.toastPanel:Load()

	self.toastPanel.contextData.settings = var_187_0

	self.toastPanel.buffer:Play(function()
		self:Toast()

		return
	end)

	return
end

function LevelStageView:HandleShowMsgBox(arg_189_1)
	pg.MsgboxMgr.GetInstance():ShowMsgBox(arg_189_1)

	return
end

return LevelStageView
