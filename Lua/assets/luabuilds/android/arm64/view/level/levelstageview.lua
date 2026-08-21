local var_0_0 = class("LevelStageView", import("..base.BaseSubView"))

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	arg_1_0.isFrozen = nil

	arg_1_0:bind(LevelUIConst.ON_FROZEN, function()
		arg_1_0.isFrozen = true

		if arg_1_0.cgComp then
			arg_1_0.cgComp.blocksRaycasts = false
		end

		return
	end)
	arg_1_0:bind(LevelUIConst.ON_UNFROZEN, function()
		arg_1_0.isFrozen = nil

		if arg_1_0.cgComp then
			arg_1_0.cgComp.blocksRaycasts = true
		end

		return
	end)

	arg_1_0.toastQueue = {}

	arg_1_0:bind(LevelUIConst.ADD_TOAST_QUEUE, function(arg_4_0, arg_4_1)
		table.insert(arg_1_0.toastQueue, arg_4_1)

		if #arg_1_0.toastQueue > 1 then
			return
		end

		arg_1_0:Toast()

		return
	end)

	return
end

function var_0_0.getUIName(arg_5_0)
	return "LevelStageView"
end

function var_0_0.OnInit(arg_6_0)
	arg_6_0:InitUI()
	arg_6_0:AddListener()

	arg_6_0.loader = AutoLoader.New()
	arg_6_0.cgComp = GetOrAddComponent(arg_6_0._go, typeof(CanvasGroup))
	arg_6_0.cgComp.blocksRaycasts = not arg_6_0.isFrozen

	arg_6_0:Show()

	return
end

function var_0_0.OnDestroy(arg_7_0)
	if arg_7_0.stageTimer then
		arg_7_0.stageTimer:Stop()

		arg_7_0.stageTimer = nil
	end

	arg_7_0:ClearSubViews()
	arg_7_0:DestroyAutoFightPanel()
	arg_7_0:DestroyWinConditionPanel()
	arg_7_0:DestroyToast()
	arg_7_0.loader:Clear()
	arg_7_0:Hide()

	return
end

local var_0_1 = -300

function var_0_0.InitUI(arg_8_0)
	arg_8_0.topStage = arg_8_0._tf:Find("top_stage")

	setActive(arg_8_0.topStage, true)

	arg_8_0.bottomStage = arg_8_0._tf:Find("bottom_stage")
	arg_8_0.normalRole = findTF(arg_8_0.bottomStage, "Normal")
	arg_8_0.funcBtn = arg_8_0.normalRole:Find("func_button")
	arg_8_0.retreatBtn = arg_8_0.normalRole:Find("retreat_button")
	arg_8_0.switchBtn = arg_8_0.normalRole:Find("switch_button")
	arg_8_0.helpBtn = arg_8_0.normalRole:Find("help_button")
	arg_8_0.shengfuBtn = arg_8_0.normalRole:Find("shengfu/shengfu_button")
	arg_8_0.actionRole = findTF(arg_8_0.bottomStage, "Action")
	arg_8_0.missileStrikeRole = findTF(arg_8_0.actionRole, "MissileStrike")
	arg_8_0.airExpelRole = findTF(arg_8_0.actionRole, "AirExpel")

	setActive(arg_8_0.bottomStage, true)
	setAnchoredPosition(arg_8_0.normalRole, {
		x = 0,
		y = 0
	})
	setActive(arg_8_0.normalRole, true)
	setAnchoredPosition(arg_8_0.actionRole, {
		x = 0,
		y = var_0_1
	})
	setActive(arg_8_0.actionRole, false)
	eachChild(arg_8_0.actionRole, function(arg_9_0)
		setActive(arg_9_0, false)

		return
	end)

	arg_8_0.leftStage = arg_8_0._tf:Find("left_stage")

	setActive(arg_8_0.leftStage, true)

	arg_8_0.rightStage = arg_8_0._tf:Find("right_stage")
	arg_8_0.bombPanel = arg_8_0.rightStage:Find("bomb_panel")
	arg_8_0.panelBarrier = arg_8_0.rightStage:Find("panel_barrier")
	arg_8_0.strategyPanelAnimator = arg_8_0.rightStage:Find("event"):GetComponent(typeof(Animator))
	arg_8_0.autoBattleBtn = arg_8_0.rightStage:Find("event/collapse/lock_fleet")
	arg_8_0.showDetailBtn = arg_8_0.rightStage:Find("event/detail/show_detail")

	setActive(arg_8_0.panelBarrier, false)
	setActive(arg_8_0.rightStage, true)

	arg_8_0.airSupremacy = arg_8_0.topStage:Find("msg_panel/air_supremacy")

	setAnchoredPosition(arg_8_0.topStage, {
		y = arg_8_0.topStage.rect.height
	})
	setAnchoredPosition(arg_8_0.leftStage, {
		x = -arg_8_0.leftStage.rect.width - 200
	})
	setAnchoredPosition(arg_8_0.rightStage, {
		x = arg_8_0.rightStage.rect.width + 300
	})
	setAnchoredPosition(arg_8_0.bottomStage, {
		y = -arg_8_0.bottomStage.rect.height
	})

	arg_8_0.attachSubViews = {}

	return
end

function var_0_0.AddListener(arg_10_0)
	arg_10_0:bind(LevelUIConst.TRIGGER_ACTION, function()
		arg_10_0:tryAutoTrigger()

		return
	end)
	arg_10_0:bind(LevelUIConst.STRATEGY_PANEL_AUTOFIGHT_ACTIVE, function(arg_12_0, arg_12_1)
		arg_10_0.strategyPanelAnimator:SetBool("IsActive", arg_12_1)

		arg_10_0.bottomStageInactive = arg_12_1

		arg_10_0:ShiftBottomStage(not arg_12_1)

		return
	end)
	arg_10_0:bind(LevelUIConst.ON_CLICK_GRID_QUAD, function(arg_13_0, arg_13_1)
		arg_10_0:ClickGridCellNormal(arg_13_1)

		return
	end)
	onButton(arg_10_0, arg_10_0.topStage:Find("option"), function()
		arg_10_0:emit(BaseUI.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(arg_10_0, arg_10_0.topStage:Find("back_button"), function()
		arg_10_0:emit(LevelUIConst.SWITCH_TO_MAP)

		return
	end, SFX_CANCEL)
	onButton(arg_10_0, arg_10_0.retreatBtn, function()
		local var_16_0 = "levelScene_whether_to_retreat"

		if arg_10_0.contextData.chapterVO:existOni() then
			var_16_0 = "levelScene_oni_retreat"
		elseif arg_10_0.contextData.chapterVO:isPlayingWithBombEnemy() then
			var_16_0 = "levelScene_bomb_retreat"
		elseif arg_10_0.contextData.chapterVO:getPlayType() == ChapterConst.TypeTransport and not arg_10_0.contextData.map:isSkirmish() then
			var_16_0 = "levelScene_escort_retreat"
		elseif arg_10_0.contextData.map:isRemaster() then
			var_16_0 = "archives_whether_to_retreat"
		end

		arg_10_0:HandleShowMsgBox({
			content = i18n(var_16_0),
			onYes = ChapterOpCommand.PrepareChapterRetreat
		})

		return
	end, SFX_UI_WEIGHANCHOR_WITHDRAW)
	onButton(arg_10_0, arg_10_0.switchBtn, function()
		local var_17_0 = arg_10_0.contextData.chapterVO:getNextValidIndex()

		if var_17_0 > 0 then
			arg_10_0:emit(LevelMediator2.ON_OP, {
				type = ChapterConst.OpSwitch,
				id = arg_10_0.contextData.chapterVO.fleets[var_17_0].id
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("formation_switch_failed"))
		end

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.autoBattleBtn, function()
		local var_18_0 = getProxy(ChapterProxy)

		var_18_0:UpdateSkipPrecombat(not var_18_0:GetSkipPrecombat())

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.showDetailBtn, function()
		arg_10_0._showStrategyDetail = not arg_10_0._showStrategyDetail and true

		arg_10_0:updateStageStrategy()

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.funcBtn, function()
		local var_20_0 = arg_10_0.contextData.chapterVO

		if not arg_10_0.contextData.chapterVO:inWartime() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_time_out"))

			return
		end

		local var_20_1 = var_20_0.fleet
		local var_20_2 = var_20_0:getChapterCell(var_20_0.fleet.line.row, var_20_0.fleet.line.column)
		local var_20_3 = false

		if var_20_0:existVisibleChampion(var_20_0.fleet.line.row, var_20_0.fleet.line.column) then
			var_20_3 = true

			if chapter_skip_battle == 1 then
				if pg.SdkMgr.GetInstance():CheckPretest() then
					arg_10_0:emit(LevelMediator2.ON_OP, {
						type = ChapterConst.OpSkipBattle,
						id = var_20_1.id
					})

					goto label_20_0
				end
			end

			if not (function(arg_21_0)
				return pg.expedition_data_template[arg_21_0.attachmentId].dungeon_id > 0
			end)((var_20_0:getChampion(var_20_0.fleet.line.row, var_20_0.fleet.line.column))) then
				arg_10_0:emit(LevelMediator2.ON_OP, {
					type = ChapterConst.OpPreClear,
					id = var_20_1.id
				})
			elseif var_20_0:IsSkipPrecombat() then
				arg_10_0:emit(LevelMediator2.ON_START)
			else
				arg_10_0:emit(LevelMediator2.ON_STAGE)
			end
		elseif var_20_2.attachment == ChapterConst.AttachAmbush and var_20_2.flag == ChapterConst.CellFlagAmbush then
			local var_20_4

			coroutine.wrap(function()
				arg_10_0:emit(LevelUIConst.DO_AMBUSH_WARNING, var_20_4)
				coroutine.yield()
				arg_10_0:emit(LevelUIConst.DISPLAY_AMBUSH_INFO, var_20_4)
				coroutine.yield()

				return
			end)()

			var_20_3 = true
		elseif ChapterConst.IsEnemyAttach(var_20_2.attachment) then
			if var_20_2.flag == ChapterConst.CellFlagActive then
				var_20_3 = true

				if chapter_skip_battle == 1 then
					if pg.SdkMgr.GetInstance():CheckPretest() then
						arg_10_0:emit(LevelMediator2.ON_OP, {
							type = ChapterConst.OpSkipBattle,
							id = var_20_1.id
						})

						goto label_20_0
					end
				end

				if not (function(arg_21_0)
					return pg.expedition_data_template[arg_21_0.attachmentId].dungeon_id > 0
				end)(var_20_2) then
					arg_10_0:emit(LevelMediator2.ON_OP, {
						type = ChapterConst.OpPreClear,
						id = var_20_1.id
					})
				elseif var_20_0:IsSkipPrecombat() then
					arg_10_0:emit(LevelMediator2.ON_START)
				else
					arg_10_0:emit(LevelMediator2.ON_STAGE)
				end
			end
		elseif var_20_2.attachment == ChapterConst.AttachBox then
			if var_20_2.flag == ChapterConst.CellFlagActive then
				var_20_3 = true

				arg_10_0:emit(LevelMediator2.ON_OP, {
					type = ChapterConst.OpBox,
					id = var_20_1.id
				})
			end
		elseif var_20_2.attachment == ChapterConst.AttachSupply and var_20_2.attachmentId > 0 then
			var_20_3 = true

			local var_20_5, var_20_6 = var_20_0:getFleetAmmo(var_20_0.fleet)

			if var_20_6 < var_20_5 then
				arg_10_0:emit(LevelMediator2.ON_OP, {
					type = ChapterConst.OpSupply,
					id = var_20_1.id
				})
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("level_ammo_enough"))
			end
		elseif var_20_2.attachment == ChapterConst.AttachStory then
			var_20_3 = true

			local var_20_7 = pg.map_event_template[var_20_2.attachmentId].gametip

			if pg.map_event_template[var_20_2.attachmentId].memory == 0 then
				return
			end

			local var_20_8 = pg.NewStoryMgr.GetInstance():StoryId2StoryName(pg.map_event_template[var_20_2.attachmentId].memory)

			pg.ConnectionMgr.GetInstance():Send(11017, {
				story_id = pg.map_event_template[var_20_2.attachmentId].memory
			}, 11018, function(arg_23_0)
				return
			end)
			pg.NewStoryMgr.GetInstance():Play(var_20_8, function(arg_24_0, arg_24_1)
				local var_24_0 = arg_24_1 or 1

				if var_20_2.flag == ChapterConst.CellFlagActive then
					arg_10_0:emit(LevelMediator2.ON_OP, {
						type = ChapterConst.OpStory,
						id = var_20_1.id,
						arg1 = var_24_0
					})
				end

				if var_20_7 ~= "" then
					local var_24_1

					for iter_24_0, iter_24_1 in ipairs(pg.memory_template.all) do
						if table.contains(pg.memory_template[iter_24_1].unlock_pre, var_20_8) then
							var_24_1 = pg.memory_template[iter_24_1].title
						end
					end

					pg.TipsMgr.GetInstance():ShowTips(i18n(var_20_7, var_24_1))
				end

				return
			end)
		end

		::label_20_0::

		if not var_20_3 then
			if var_20_0:getRound() == ChapterConst.RoundEnemy then
				arg_10_0:emit(LevelMediator2.ON_OP, {
					type = ChapterConst.OpEnemyRound
				})
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("level_click_to_move"))
			end
		end

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.helpBtn, function()
		if arg_10_0.contextData.chapterVO then
			if arg_10_0.contextData.chapterVO:existOni() then
				arg_10_0:HandleShowMsgBox({
					type = MSGBOX_TYPE_HELP,
					helps = i18n("levelScene_sphunt_help_tip")
				})
			elseif arg_10_0.contextData.chapterVO:isTypeDefence() then
				arg_10_0:HandleShowMsgBox({
					type = MSGBOX_TYPE_HELP,
					helps = i18n("help_battle_defense")
				})
			elseif arg_10_0.contextData.chapterVO:isPlayingWithBombEnemy() then
				arg_10_0:HandleShowMsgBox({
					type = MSGBOX_TYPE_HELP,
					helps = i18n("levelScene_bomb_help_tip")
				})
			else
				if pg.map_event_list[arg_10_0.contextData.chapterVO.id] then
					local var_25_0 = noEmptyStr(pg.map_event_list[arg_10_0.contextData.chapterVO.id].help_pictures) or {}

					if next(var_25_0) then
						for iter_25_0, iter_25_1 in pairs(pg.map_event_list[arg_10_0.contextData.chapterVO.id].help_pictures) do
							table.insert({
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
							}, {
								icon = {
									path = "",
									atlas = iter_25_1
								}
							})
						end

						arg_10_0:HandleShowMsgBox({
							type = MSGBOX_TYPE_HELP,
							helps = {
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
						})

						goto label_25_0
					end
				end

				arg_10_0:HandleShowMsgBox({
					type = MSGBOX_TYPE_HELP,
					helps = pg.gametip.help_level_ui.tip
				})
			end
		end

		::label_25_0::

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.airSupremacy, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("help_battle_ac")
		})

		return
	end, SFX_UI_CLICK)
	onButton(arg_10_0, arg_10_0.shengfuBtn, function()
		arg_10_0:DisplayWinConditionPanel()

		return
	end)

	return
end

function var_0_0.SetSeriesOperation(arg_28_0, arg_28_1)
	arg_28_0.seriesOperation = arg_28_1

	return
end

function var_0_0.SetGrid(arg_29_0, arg_29_1)
	arg_29_0.grid = arg_29_1

	return
end

function var_0_0.SetPlayer(arg_30_0, arg_30_1)
	return
end

function var_0_0.SwitchToChapter(arg_31_0, arg_31_1)
	local var_31_0 = findTF(arg_31_0.rightStage, "target")
	local var_31_1 = findTF(arg_31_0.rightStage, "skip_events")

	setActive(findTF(arg_31_0.topStage, "msg_panel/ambush"), arg_31_1:existAmbush())

	local var_31_2 = OPEN_AIR_DOMINANCE and arg_31_1:getConfig("air_dominance") > 0

	setActive(arg_31_0.airSupremacy, var_31_2)

	local var_31_3 = arg_31_1:isLoop()

	setActive(arg_31_0.autoBattleBtn, var_31_3)

	if var_31_3 then
		arg_31_0:UpdateSkipPreCombatMark()
		arg_31_0:UpdateAutoFightPanel()
		arg_31_0:UpdateAutoFightMark()
	end

	arg_31_0.achieveOriginalY = -240

	setText(var_31_1:Find("Label"), i18n("map_event_skip"))

	local var_31_4 = "skip_events_on_" .. arg_31_1.id

	if arg_31_1:getConfig("event_skip") == 1 then
		if arg_31_1.progress > 0 or arg_31_1.defeatCount > 0 or arg_31_1.passCount > 0 then
			setActive(var_31_1, true)

			var_31_0.anchoredPosition = Vector2.New(var_31_0.anchoredPosition.x, arg_31_0.achieveOriginalY - 40)
			GetComponent(var_31_1, typeof(Toggle)).isOn = PlayerPrefs.GetInt(var_31_4, 1) == 1

			onToggle(arg_31_0, var_31_1, function(arg_32_0)
				PlayerPrefs.SetInt(var_31_4, arg_32_0 and 1 or 0)

				return
			end)
		else
			setActive(var_31_1, false)

			if not PlayerPrefs.HasKey(var_31_4) then
				PlayerPrefs.SetInt(var_31_4, 0)
			end
		end
	else
		setActive(var_31_1, false)

		var_31_0.anchoredPosition = Vector2.New(var_31_0.anchoredPosition.x, arg_31_0.achieveOriginalY)
	end

	setActive(var_31_0, arg_31_1:existAchieve())
	setActive(arg_31_0.retreatBtn, true)
	arg_31_0.seriesOperation()

	return
end

function var_0_0.SwitchToMap(arg_33_0)
	arg_33_0:DestroyAutoFightPanel()

	return
end

function var_0_0.UpdateSkipPreCombatMark(arg_34_0)
	local var_34_0 = getProxy(ChapterProxy):GetSkipPrecombat() and "auto_battle_on" or "auto_battle_off"

	arg_34_0.loader:GetOffSpriteRequest(arg_34_0.autoBattleBtn)
	arg_34_0.loader:GetSprite("ui/levelstageview_atlas", var_34_0, arg_34_0.autoBattleBtn, true)

	return
end

function var_0_0.updateStageInfo(arg_35_0)
	local var_35_0 = arg_35_0.contextData.chapterVO
	local var_35_1 = findTF(arg_35_0.topStage, "timer")
	local var_35_2 = findTF(arg_35_0.topStage, "unlimit")

	setWidgetText(var_35_1, "--:--:--")

	if arg_35_0.stageTimer then
		arg_35_0.stageTimer:Stop()
	end

	if arg_35_0.contextData.chapterVO:getRemainTime() > arg_35_0.contextData.chapterVO:getConfig("time") or arg_35_0.contextData.chapterVO:getConfig("time") >= 0 then
		setActive(var_35_1, false)
		setActive(var_35_2, true)
	else
		setActive(var_35_1, true)
		setActive(var_35_2, false)

		arg_35_0.stageTimer = Timer.New(function()
			if IsNil(var_35_1) then
				return
			end

			setWidgetText(var_35_1, pg.TimeMgr.GetInstance():DescCDTime((var_35_0:getRemainTime())))

			return
		end, 1, -1)

		arg_35_0.stageTimer:Start()
		arg_35_0.stageTimer.func()
	end

	return
end

function var_0_0.updateAmbushRate(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0.contextData.chapterVO

	if not arg_37_0.contextData.chapterVO:existAmbush() then
		return
	end

	local var_37_1 = var_37_0.fleet
	local var_37_2 = findTF(arg_37_0.topStage, "msg_panel/ambush/value2")

	setText(findTF(arg_37_0.topStage, "msg_panel/ambush/label1"), i18n("level_scene_title_word_1"))
	setText(findTF(arg_37_0.topStage, "msg_panel/ambush/value1"), math.floor((var_37_0.fleet:getInvestSums())))
	setText(findTF(arg_37_0.topStage, "msg_panel/ambush/label2"), i18n("level_scene_title_word_2"))

	if not var_37_0.activateAmbush then
		setText(var_37_2, i18n("ambush_display_none"))
		setTextColor(var_37_2, Color.New(0.4, 0.4, 0.4))
	else
		local var_37_3 = var_37_0:getAmbushRate(var_37_1, arg_37_1)
		local var_37_4, var_37_5 = ChapterConst.GetAmbushDisplay((not arg_37_2 or not var_37_0:existEnemy(ChapterConst.SubjectPlayer, arg_37_1.row, arg_37_1.column)) and var_37_3)

		setText(var_37_2, var_37_4)
		setTextColor(var_37_2, var_37_5)
	end

	return
end

function var_0_0.updateStageAchieve(arg_38_0)
	if not arg_38_0.contextData.chapterVO:existAchieve() then
		return
	end

	local var_38_0 = arg_38_0.contextData.chapterVO.achieves
	local var_38_1 = findTF(arg_38_0.rightStage, "target")

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

		setText(var_38_11, ChapterConst.GetAchieveDesc(iter_38_1.type, arg_38_0.contextData.chapterVO))

		local var_38_13 = var_38_11

		if var_38_10 then
			local var_38_14 = Color.yellow or Color.white

			var_38_12(var_38_13, var_38_14)

			local var_38_15 = cloneTplTo(var_38_7, var_38_8)

			var_38_15:GetComponent(typeof(Image)).enabled = var_38_10
		end
	end

	onButton(arg_38_0, var_38_5, function()
		shiftPanel(var_38_2, var_38_2.rect.width + 200, nil, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
		shiftPanel(var_38_6, 0, nil, 0.3, 0, true, nil, LeanTweenType.easeOutSine)

		return
	end, SFX_PANEL)
	onButton(arg_38_0, var_38_6, function()
		shiftPanel(var_38_2, 30, nil, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
		shiftPanel(var_38_6, var_38_6.rect.width + 200, nil, 0.3, 0, true, nil, LeanTweenType.easeOutSine)

		return
	end, SFX_PANEL)

	if not arg_38_0.isAchieveFirstInit then
		arg_38_0.isAchieveFirstInit = true

		triggerButton(var_38_5)
	end

	return
end

function var_0_0.updateStageBarrier(arg_41_0)
	setActive(arg_41_0.panelBarrier, arg_41_0.contextData.chapterVO:existOni())

	if not arg_41_0.contextData.chapterVO:existOni() then
		return
	end

	local var_41_0 = arg_41_0.panelBarrier:Find("btn_barrier")

	setText(var_41_0:Find("nums"), arg_41_0.contextData.chapterVO.modelCount)
	onButton(arg_41_0, var_41_0, function()
		if arg_41_0.grid.quadState == ChapterConst.QuadStateBarrierSetting then
			arg_41_0.grid:updateQuadCells(ChapterConst.QuadStateNormal)

			return
		end

		arg_41_0.grid:updateQuadCells(ChapterConst.QuadStateBarrierSetting)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateBombPanel(arg_43_0, arg_43_1)
	setActive(arg_43_0.bombPanel, arg_43_0.contextData.chapterVO:isPlayingWithBombEnemy())

	if arg_43_0.contextData.chapterVO:isPlayingWithBombEnemy() then
		setText(arg_43_0.bombPanel:Find("tx_step"), arg_43_0.contextData.chapterVO:getBombChapterInfo().action_times - math.floor(arg_43_0.contextData.chapterVO.roundIndex / 2))

		local var_43_0 = arg_43_0.bombPanel:Find("tx_score")
		local var_43_1 = tonumber(getText(var_43_0))
		local var_43_2 = arg_43_0.contextData.chapterVO.modelCount

		LeanTween.cancel(go(var_43_0))

		if arg_43_1 and var_43_1 ~= arg_43_0.contextData.chapterVO.modelCount then
			LeanTween.scale(go(var_43_0), Vector3(1.5, 1.5, 1), 0.2)
			LeanTween.value(go(var_43_0), var_43_1, arg_43_0.contextData.chapterVO.modelCount, (arg_43_0.contextData.chapterVO.modelCount - var_43_1) * 0.1):setOnUpdate(System.Action_float(function(arg_44_0)
				setText(var_43_0, math.floor(arg_44_0))

				return
			end)):setOnComplete(System.Action(function()
				setText(var_43_0, var_43_2)

				return
			end)):setEase(LeanTweenType.easeInOutSine):setDelay(0.2)
			LeanTween.scale(go(var_43_0), Vector3.one, 0.3):setDelay(1 + (arg_43_0.contextData.chapterVO.modelCount - var_43_1) * 0.1)
		else
			var_43_0.localScale = Vector3.one

			setText(var_43_0, arg_43_0.contextData.chapterVO.modelCount)
		end
	end

	return
end

function var_0_0.updateFleetBuff(arg_46_0)
	local var_46_0 = arg_46_0.contextData.chapterVO.fleet
	local var_46_1 = arg_46_0.contextData.chapterVO:GetShowingStrategies()

	if arg_46_0.contextData.chapterVO:getChapterSupportFleet() and not arg_46_0.contextData.chapterVO:IsSupportSubmarineStage() then
		table.insert(var_46_1, ChapterConst.StrategyAirSupportFriendly)
	end

	local var_46_2 = {}
	local var_46_3 = arg_46_0.contextData.chapterVO:GetSubmarineFleet()

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

	local var_46_5 = underscore.filter(arg_46_0.contextData.chapterVO:GetWeather(), function(arg_49_0)
		return noEmptyStr(pg.weather_data_template[arg_49_0].buff_icon)
	end)
	local var_46_6 = 0

	if arg_46_0.contextData.chapterVO:ExistDivingChampion() then
		var_46_6 = 1
	end

	local var_46_7 = _.map(_.values(arg_46_0.contextData.chapterVO.fleet:getCommanders()), function(arg_50_0)
		return arg_50_0:getSkills()[1]
	end)
	local var_46_8 = findTF(arg_46_0.topStage, "icon_list/fleet_buffs")
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

				onButton(arg_46_0, arg_51_2, function()
					arg_46_0:HandleShowMsgBox({
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
				GetImageSpriteFromAtlasAsync("strategyicon/" .. pg.weather_data_template[var_46_5[arg_51_1 + 1]].buff_icon, "", arg_51_2)
				onButton(arg_46_0, arg_51_2, function()
					arg_46_0:HandleShowMsgBox({
						hideNo = true,
						type = MSGBOX_TYPE_DROP_ITEM,
						name = var_0.name,
						content = var_0.buff_desc,
						iconPath = {
							"strategyicon/" .. var_0.buff_icon
						},
						yesText = pg.MsgboxMgr.TEXT_CONFIRM
					})

					return
				end, SFX_PANEL)

				return
			end

			arg_51_1 = arg_51_1 - #var_46_5

			if arg_51_1 + 1 <= #var_46_2 then
				local var_51_4 = var_46_2[arg_51_1 + 1]

				GetImageSpriteFromAtlasAsync("strategyicon/" .. pg.strategy_data_template[var_46_2[arg_51_1 + 1].id].icon, "", arg_51_2)
				setActive(findTF(arg_51_2, "times"), true)
				setText(findTF(arg_51_2, "times"), var_46_2[arg_51_1 + 1].count)
				onButton(arg_46_0, arg_51_2, function()
					arg_46_0:HandleShowMsgBox({
						yesText = "text_confirm",
						hideNo = true,
						content = "",
						type = MSGBOX_TYPE_SINGLE_ITEM,
						drop = {
							type = DROP_TYPE_STRATEGY,
							id = var_0.id,
							cfg = var_0
						},
						extendDesc = string.format(i18n("word_rest_times"), var_51_4.count)
					})

					return
				end, SFX_PANEL)

				return
			end

			arg_51_1 = arg_51_1 - #var_46_2

			if arg_51_1 + 1 <= var_46_6 then
				GetImageSpriteFromAtlasAsync("strategyicon/submarine_approach", "", arg_51_2)
				onButton(arg_46_0, arg_51_2, function()
					arg_46_0:HandleShowMsgBox({
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

			local var_51_5 = var_46_7[arg_51_1 + 1]

			GetImageSpriteFromAtlasAsync("commanderskillicon/" .. var_46_7[arg_51_1 + 1]:getConfig("icon"), "", arg_51_2)
			setText(findTF(arg_51_2, "Text"), "Lv." .. var_46_7[arg_51_1 + 1]:getConfig("lv"))
			setActive(findTF(arg_51_2, "Text"), true)
			setActive(findTF(arg_51_2, "frame"), true)
			onButton(arg_46_0, arg_51_2, function()
				arg_46_0:emit(LevelMediator2.ON_COMMANDER_SKILL, var_51_5)

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_46_9:align(#var_46_1 + #var_46_2 + #var_46_5 + var_46_6 + #var_46_7)

	if OPEN_AIR_DOMINANCE and arg_46_0.contextData.chapterVO:getConfig("air_dominance") > 0 then
		arg_46_0:updateAirDominance()
	end

	arg_46_0:updateEnemyCount()
	arg_46_0:updateChapterBuff()

	return
end

function var_0_0.updateEnemyCount(arg_57_0)
	local var_57_0 = arg_57_0.contextData.chapterVO
	local var_57_1 = findTF(arg_57_0.topStage, "icon_list/enemy_count")
	local var_57_2 = tobool(underscore.detect(arg_57_0.contextData.chapterVO.achieves, function(arg_58_0)
		return (arg_58_0.type == ChapterConst.AchieveType3 or arg_58_0.type == ChapterConst.AchieveType6) and not ChapterConst.IsAchieved(arg_58_0)
	end))

	setActive(var_57_1, var_57_2)

	if var_57_2 then
		local var_57_3 = arg_57_0.contextData.chapterVO:getDisplayEnemyCount()

		setText(var_57_1:Find("Text"), var_57_3)
		GetImageSpriteFromAtlasAsync("enemycount", var_57_3 > 0 and "danger" or "safe", var_57_1)
		onButton(arg_57_0, var_57_1, function()
			if var_57_3 > 0 then
				arg_57_0:HandleShowMsgBox({
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

						arg_57_0.grid:focusOnCell(var_60_0)

						local var_60_1 = arg_57_0.grid:GetEnemyCellView(var_60_0)

						if var_60_1 and var_60_1.TweenShining then
							var_60_1:TweenShining(2)
						end

						return
					end
				})
			else
				arg_57_0:HandleShowMsgBox({
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

function var_0_0.updateChapterBuff(arg_61_0)
	local var_61_0 = arg_61_0.contextData.chapterVO
	local var_61_1 = findTF(arg_61_0.topStage, "icon_list/chapter_buff")
	local var_61_2 = arg_61_0.contextData.chapterVO:hasMitigation()

	SetActive(var_61_1, var_61_2)

	if var_61_2 then
		GetImageSpriteFromAtlasAsync("passstate", arg_61_0.contextData.chapterVO:getRiskLevel() .. "_icon", var_61_1)
		onButton(arg_61_0, var_61_1, function()
			if not var_61_0:hasMitigation() then
				return
			end

			arg_61_0:HandleShowMsgBox({
				hideNo = true,
				type = MSGBOX_TYPE_DROP_ITEM,
				name = var_61_0:getChapterState(),
				iconPath = {
					"passstate",
					var_0 .. "_icon"
				},
				content = i18n("level_risk_level_mitigation_rate", var_61_0:getRemainPassCount(), var_61_0:getMitigationRate())
			})

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateAirDominance(arg_63_0)
	local var_63_0, var_63_1, var_63_2 = arg_63_0.contextData.chapterVO:getAirDominanceValue()

	if not var_63_2 or var_63_2 ~= var_63_1 then
		arg_63_0.contextData.chapterVO:setAirDominanceStatus(var_63_1)
		getProxy(ChapterProxy):updateChapter(arg_63_0.contextData.chapterVO)
	end

	arg_63_0.isChange = var_63_2 and (var_63_1 == 0 and 3 or var_63_1) - (var_63_2 == 0 and 3 or var_63_2)

	local var_63_3 = arg_63_0.isChange or 0

	arg_63_0:updateAirDominanceTitle(var_63_0, var_63_1, var_63_3)

	return
end

function var_0_0.updateAirDominanceTitle(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	local var_64_0 = findTF(arg_64_0.airSupremacy, "value2")
	local var_64_1 = findTF(arg_64_0.airSupremacy, "up")
	local var_64_2 = findTF(arg_64_0.airSupremacy, "down")

	setText(findTF(arg_64_0.airSupremacy, "label1"), i18n("level_scene_title_word_3"))
	setText(findTF(arg_64_0.airSupremacy, "label2"), i18n("level_scene_title_word_4"))
	setText(findTF(arg_64_0.airSupremacy, "value1"), math.floor(arg_64_1))
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
		var_64_1:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_68_0)
			setActive(arg_68_0, false)

			return
		end)
		var_64_2:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_68_0)
			setActive(arg_68_0, false)

			return
		end)
		setActive(var_64_1, arg_64_3 > 0)
		setActive(var_64_2, arg_64_3 < 0)
	else
		setText(var_64_0, ChapterConst.AirDominance[arg_64_2].name)
		setTextColor(var_64_0, ChapterConst.AirDominance[arg_64_2].color)
	end

	return
end

function var_0_0.UpdateDefenseStatus(arg_69_0)
	local var_69_0 = arg_69_0.contextData.chapterVO
	local var_69_1 = arg_69_0.contextData.chapterVO:getPlayType() == ChapterConst.TypeDefence
	local var_69_2 = findTF(arg_69_0.bottomStage, "Normal/shengfu")

	setActive(var_69_2, var_69_1)

	if not var_69_1 then
		return
	end

	local var_69_3 = findTF(var_69_2, "hp")

	var_69_3:GetComponent(typeof(Text)).text = i18n("desc_base_hp", "<color=#92FC63>" .. tostring(var_69_0.BaseHP) .. "</color>", pg.chapter_defense[var_69_0.id].port_hp)

	return
end

function var_0_0.DisplayWinConditionPanel(arg_70_0)
	if not arg_70_0.winCondPanel then
		arg_70_0.winCondPanel = WinConditionDisplayPanel.New(arg_70_0._tf.parent, arg_70_0.event, arg_70_0.contextData)

		arg_70_0.winCondPanel:Load()
	end

	arg_70_0.winCondPanel:ActionInvoke("Enter", arg_70_0.contextData.chapterVO)

	return
end

function var_0_0.DestroyWinConditionPanel(arg_71_0)
	if not arg_71_0.winCondPanel then
		return
	end

	arg_71_0.winCondPanel:Destroy()

	arg_71_0.winCondPanel = nil

	return
end

function var_0_0.UpdateComboPanel(arg_72_0)
	if pg.chapter_pop_template[arg_72_0.contextData.chapterVO.id] and pg.chapter_pop_template[arg_72_0.contextData.chapterVO.id].combo_on then
		local var_72_0, var_72_1 = arg_72_0:GetSubView("LevelStageComboPanel")

		if var_72_1 then
			var_72_0:Load()
			var_72_0.buffer:SetParent(arg_72_0.leftStage, false)
		end

		local var_72_2 = getProxy(ChapterProxy)

		var_72_0.buffer:UpdateView(var_72_2:GetComboHistory(arg_72_0.contextData.chapterVO.id) or arg_72_0.contextData.chapterVO)
		var_72_0.buffer:UpdateViewAnimated(arg_72_0.contextData.chapterVO)
	end

	return
end

function var_0_0.UpdateDOALinkFeverPanel(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_0.contextData.chapterVO:GetBindActID()
	local var_73_1 = arg_73_0.contextData.chapterVO:getConfig("levelstage_bar")

	if not var_73_1 or var_73_1 == "" then
		existCall(arg_73_1)

		return
	end

	local var_73_2, var_73_3 = arg_73_0:GetSubView(var_73_1)

	if var_73_3 then
		var_73_2:Load()
		var_73_2.buffer:SetParent(arg_73_0._tf, false)
	end

	var_73_2.buffer:UpdateView(arg_73_0.contextData.chapterVO, arg_73_1)

	return
end

local var_0_2 = Vector2(396, 128)
local var_0_3 = Vector2(128, 128)

function var_0_0.updateStageStrategy(arg_74_0)
	local var_74_0 = arg_74_0.contextData.chapterVO
	local var_74_1 = findTF(arg_74_0.rightStage, "event")
	local var_74_2 = findTF(var_74_1, "detail")
	local var_74_3 = findTF(var_74_2, "click")
	local var_74_4 = findTF(var_74_2, "items")
	local var_74_5 = var_74_4:GetComponent(typeof(GridLayoutGroup))

	if arg_74_0._showStrategyDetail then
		var_74_5.cellSize = var_0_2 or var_0_3

		local var_74_6 = findTF(var_74_4, "item")
		local var_74_7 = findTF(var_74_1, "collapse")

		setActive(var_74_6, false)
		UIItemList.StaticAlign(var_74_4, var_74_6, #var_74_0:GetInteractableStrategies(), function(arg_75_0, arg_75_1, arg_75_2)
			if arg_75_0 ~= UIItemList.EventUpdate then
				return
			end

			local var_75_0 = arg_75_2:Find("detail")

			setActive(var_75_0, arg_74_0._showStrategyDetail)

			local var_75_1 = arg_75_2:Find("icon")
			local var_75_2 = var_0[arg_75_1 + 1]
			local var_75_3
			local var_75_4

			if var_0[arg_75_1 + 1].id == ChapterConst.StrategyHuntingRange then
				var_75_3 = ChapterConst.StgTypeConst
				var_75_4 = arg_74_0.contextData.huntingRangeVisibility % 2 == 1 and "range_invisible" or "range_visible"

				setText(var_75_0, i18n("help_sub_limits"))
			else
				if var_75_2.id == ChapterConst.StrategySubAutoAttack then
					var_75_3 = ChapterConst.StgTypeConst
					var_75_4 = var_74_0.subAutoAttack == 0 and "sub_dont_auto_attack" or "sub_auto_attack"

					setText(var_75_0, i18n("help_sub_display"))

					goto label_75_0

					var_75_3 = pg.strategy_data_template[var_75_2.id].type
					var_75_4 = pg.strategy_data_template[var_75_2.id].icon
				end

				setText(var_75_0, pg.strategy_data_template[var_75_2.id].desc)
			end

			::label_75_0::

			GetImageSpriteFromAtlasAsync("strategyicon/" .. var_75_4, "", var_75_1:Find("icon"))
			onButton(arg_74_0, var_75_1, function()
				if var_75_2.id == ChapterConst.StrategyHuntingRange then
					arg_74_0.grid:toggleHuntingRange()
					var_0(arg_75_0, arg_75_1, arg_75_2)
				elseif var_75_2.id == ChapterConst.StrategySubAutoAttack then
					pg.TipsMgr.GetInstance():ShowTips(i18n("ai_change_" .. 1 - var_74_0.subAutoAttack + 1))
					arg_74_0:emit(LevelMediator2.ON_OP, {
						type = ChapterConst.OpSubState,
						arg1 = 1 - var_74_0.subAutoAttack
					})
				elseif var_75_2.id == ChapterConst.StrategyExchange then
					if var_74_0:getNextValidIndex() > 0 and var_75_2.count > 0 then
						local var_76_0 = var_74_0.fleet

						arg_74_0:HandleShowMsgBox({
							content = i18n("levelScene_who_to_exchange"),
							onYes = function()
								arg_74_0:emit(LevelMediator2.ON_OP, {
									type = ChapterConst.OpStrategy,
									id = var_76_0.id,
									arg1 = ChapterConst.StrategyExchange,
									arg2 = var_74_0.fleets[var_0].id
								})

								return
							end
						})
					end
				elseif var_75_2.id == ChapterConst.StrategySubTeleport then
					arg_74_0:SwitchSubTeleportBottomStage()
					arg_74_0:SwitchBottomStagePanel(true)
					arg_74_0.grid:ShowStaticHuntingRange()
					arg_74_0.grid:PrepareSubTeleport()
					arg_74_0.grid:updateQuadCells(ChapterConst.QuadStateTeleportSub)
				elseif var_75_2.id == ChapterConst.StrategyMissileStrike then
					if not var_74_0.fleet:canUseStrategy(var_75_2) then
						return
					end

					arg_74_0:SwitchMissileBottomStagePanel()
					arg_74_0:SwitchBottomStagePanel(true)
					arg_74_0.grid:updateQuadCells(ChapterConst.QuadStateMissileStrike)
				elseif var_75_2.id == ChapterConst.StrategyAirSupport then
					if not var_74_0:getChapterSupportFleet():canUseStrategy(var_75_2) then
						return
					end

					arg_74_0:SwitchAirSupportBottomStagePanel()
					arg_74_0:SwitchBottomStagePanel(true)
					arg_74_0.grid:updateQuadCells(ChapterConst.QuadStateAirSuport)
				elseif var_75_2.id == ChapterConst.StrategyExpel then
					if not var_74_0:getChapterSupportFleet():canUseStrategy(var_75_2) then
						return
					end

					arg_74_0:SwitchAirExpelBottomStagePanel()
					arg_74_0:SwitchBottomStagePanel(true)
					arg_74_0.grid:updateQuadCells(ChapterConst.QuadStateExpel)
				elseif var_75_3 == ChapterConst.StgTypeForm then
					arg_74_0:emit(LevelMediator2.ON_OP, {
						type = ChapterConst.OpStrategy,
						id = var_74_0.fleet.id,
						arg1 = ChapterConst.StrategyForms[table.indexof(ChapterConst.StrategyForms, var_75_2.id) % #ChapterConst.StrategyForms + 1]
					})
				else
					arg_74_0:emit(LevelUIConst.DISPLAY_STRATEGY_INFO, var_75_2)
				end

				return
			end, SFX_PANEL)

			if var_75_3 == ChapterConst.StgTypeForm then
				setText(var_75_1:Find("nums"), "")
				setActive(var_75_1:Find("mask"), false)
				setActive(var_75_1:Find("selected"), true)
			else
				local var_75_6 = var_75_2.count or ""

				var_75_5(var_75_1:Find("nums"), var_75_6)
				setActive(var_75_1:Find("mask"), var_75_2.count == 0)
				setActive(var_75_1:Find("selected"), false)
			end

			return
		end)
		onButton(arg_74_0, var_74_3, function()
			shiftPanel(var_74_2, var_74_2.rect.width + 200, nil, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
			shiftPanel(var_74_7, -30, nil, 0.3, 0, true, nil, LeanTweenType.easeOutSine)

			return
		end, SFX_PANEL)
		onButton(arg_74_0, findTF(var_74_1, "collapse"), function()
			shiftPanel(var_74_2, 35, nil, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
			shiftPanel(var_74_7, var_74_7.rect.width + 200, nil, 0.3, 0, true, nil, LeanTweenType.easeOutSine)

			return
		end, SFX_PANEL)

		return
	end
end

function var_0_0.GetSubView(arg_80_0, arg_80_1)
	if arg_80_0.attachSubViews[arg_80_1] then
		return arg_80_0.attachSubViews[arg_80_1]
	end

	local var_80_0 = _G[arg_80_1].New(arg_80_0)

	assert(var_80_0, "cant't find subview " .. (arg_80_1 or "nil"))

	arg_80_0.attachSubViews[arg_80_1] = var_80_0

	return var_80_0, true
end

function var_0_0.RemoveSubView(arg_81_0, arg_81_1)
	if not arg_81_0.attachSubViews[arg_81_1] then
		return false
	end

	arg_81_0.attachSubViews[arg_81_1]:Destroy()

	arg_81_0.attachSubViews[arg_81_1] = nil

	return true
end

function var_0_0.ClearSubViews(arg_82_0)
	for iter_82_0, iter_82_1 in pairs(arg_82_0.attachSubViews) do
		iter_82_1:Destroy()
	end

	table.clear(arg_82_0.attachSubViews)

	return
end

function var_0_0.updateStageFleet(arg_83_0)
	local var_83_0 = findTF(arg_83_0.leftStage, "fleet")

	setActive(findTF(var_83_0, "shiptpl"), false)
	setText(arg_83_0.topStage:Find("msg_panel/fleet_info/number"), arg_83_0.contextData.chapterVO.fleet.id)

	local var_83_1 = arg_83_0.contextData.chapterVO.fleet:getShips(true)

	;(function(arg_84_0, arg_84_1)
		local var_84_0 = UIItemList.New(arg_84_0, var_0)

		var_84_0:make(function(arg_85_0, arg_85_1, arg_85_2)
			if arg_85_0 == UIItemList.EventUpdate then
				local var_85_0 = arg_84_1[arg_85_1 + 1]

				updateShip(arg_85_2, arg_84_1[arg_85_1 + 1])

				local var_85_1 = arg_84_1[arg_85_1 + 1].hpRant
				local var_85_2 = arg_84_1[arg_85_1 + 1].hpChange or 0
				local var_85_3 = math.floor(var_85_2 / 16 * arg_84_1[arg_85_1 + 1]:getShipProperties()[AttributeType.Durability])
				local var_85_4 = findTF(arg_85_2, "HP_POP")

				setActive(var_85_4, true)
				setActive(findTF(var_85_4, "heal"), false)
				setActive(findTF(var_85_4, "normal"), false)

				local function var_85_5(arg_86_0, arg_86_1)
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

				if var_85_3 > 0 then
					(function(arg_86_0, arg_86_1)
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
					end)(findTF(var_85_4, "heal"), var_85_3)
				elseif var_85_3 < 0 then
					LeanTween.delayedCall(0.6, System.Action(function()
						LeanTween.moveX(arg_85_2, arg_85_2.transform.localPosition.x, 0.05):setEase(LeanTweenType.easeInOutSine):setLoopPingPong(4)
						LeanTween.alpha(findTF(arg_85_2, "red"), 0.5, 0.4)
						LeanTween.alpha(findTF(arg_85_2, "red"), 0, 0.4):setDelay(0.4)
						var_85_5(findTF(var_85_4, "normal"), var_85_3)

						return
					end))
				end

				local var_85_6 = findTF(arg_85_2, "blood")
				local var_85_7 = findTF(arg_85_2, "blood/fillarea/green")
				local var_85_8 = findTF(arg_85_2, "blood/fillarea/red")
				local var_85_9 = var_85_1 < ChapterConst.HpGreen
				local var_85_10 = var_85_1 == 0

				setActive(var_85_7, not (var_85_1 < ChapterConst.HpGreen))
				setActive(var_85_8, var_85_9)

				var_85_6:GetComponent(typeof(Slider)).fillRect = var_85_9 and var_85_8 or var_85_7

				setSlider(var_85_6, 0, 10000, var_85_1)
				setActive(findTF(arg_85_2, "repairmask"), var_85_9)
				setActive(findTF(arg_85_2, "repairmask/broken"), var_85_10)
				onButton(arg_83_0, arg_85_2:Find("repairmask"), function()
					arg_83_0:emit(LevelUIConst.DISPLAY_REPAIR_WINDOW, var_85_0)

					return
				end, SFX_PANEL)

				local var_85_11 = findTF(arg_85_2, "repairmask/icon").gameObject

				if not var_85_9 then
					LeanTween.cancel(var_85_11)
					setImageAlpha(var_85_11, 1)
				end

				if var_85_9 and not LeanTween.isTweening(var_85_11) then
					LeanTween.alpha(rtf(var_85_11), 0, 2):setLoopPingPong()
				end

				local var_85_12 = GetOrAddComponent(arg_85_2, "UILongPressTrigger").onLongPressed

				pg.DelegateInfo.Add(arg_83_0, var_85_12)
				var_85_12:RemoveAllListeners()
				var_85_12:AddListener(function()
					arg_83_0:emit(LevelMediator2.ON_STAGE_SHIPINFO, {
						shipId = var_85_0.id,
						shipVOs = var_83_1
					})

					return
				end)
			end

			return
		end)
		var_84_0:align(#arg_84_1)

		return
	end)(var_83_0:Find("main"), arg_83_0.contextData.chapterVO.fleet:getShipsByTeam(TeamType.Main, true))
	;(function(arg_84_0, arg_84_1)
		local var_84_0 = UIItemList.New(arg_84_0, var_0)

		var_84_0:make(function(arg_85_0, arg_85_1, arg_85_2)
			if arg_85_0 == UIItemList.EventUpdate then
				local var_85_0 = arg_84_1[arg_85_1 + 1]

				updateShip(arg_85_2, arg_84_1[arg_85_1 + 1])

				local var_85_1 = arg_84_1[arg_85_1 + 1].hpRant
				local var_85_2 = arg_84_1[arg_85_1 + 1].hpChange or 0
				local var_85_3 = math.floor(var_85_2 / 16 * arg_84_1[arg_85_1 + 1]:getShipProperties()[AttributeType.Durability])
				local var_85_4 = findTF(arg_85_2, "HP_POP")

				setActive(var_85_4, true)
				setActive(findTF(var_85_4, "heal"), false)
				setActive(findTF(var_85_4, "normal"), false)

				local function var_85_5(arg_86_0, arg_86_1)
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

				if var_85_3 > 0 then
					(function(arg_86_0, arg_86_1)
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
					end)(findTF(var_85_4, "heal"), var_85_3)
				elseif var_85_3 < 0 then
					LeanTween.delayedCall(0.6, System.Action(function()
						LeanTween.moveX(arg_85_2, arg_85_2.transform.localPosition.x, 0.05):setEase(LeanTweenType.easeInOutSine):setLoopPingPong(4)
						LeanTween.alpha(findTF(arg_85_2, "red"), 0.5, 0.4)
						LeanTween.alpha(findTF(arg_85_2, "red"), 0, 0.4):setDelay(0.4)
						var_85_5(findTF(var_85_4, "normal"), var_85_3)

						return
					end))
				end

				local var_85_6 = findTF(arg_85_2, "blood")
				local var_85_7 = findTF(arg_85_2, "blood/fillarea/green")
				local var_85_8 = findTF(arg_85_2, "blood/fillarea/red")
				local var_85_9 = var_85_1 < ChapterConst.HpGreen
				local var_85_10 = var_85_1 == 0

				setActive(var_85_7, not (var_85_1 < ChapterConst.HpGreen))
				setActive(var_85_8, var_85_9)

				var_85_6:GetComponent(typeof(Slider)).fillRect = var_85_9 and var_85_8 or var_85_7

				setSlider(var_85_6, 0, 10000, var_85_1)
				setActive(findTF(arg_85_2, "repairmask"), var_85_9)
				setActive(findTF(arg_85_2, "repairmask/broken"), var_85_10)
				onButton(arg_83_0, arg_85_2:Find("repairmask"), function()
					arg_83_0:emit(LevelUIConst.DISPLAY_REPAIR_WINDOW, var_85_0)

					return
				end, SFX_PANEL)

				local var_85_11 = findTF(arg_85_2, "repairmask/icon").gameObject

				if not var_85_9 then
					LeanTween.cancel(var_85_11)
					setImageAlpha(var_85_11, 1)
				end

				if var_85_9 and not LeanTween.isTweening(var_85_11) then
					LeanTween.alpha(rtf(var_85_11), 0, 2):setLoopPingPong()
				end

				local var_85_12 = GetOrAddComponent(arg_85_2, "UILongPressTrigger").onLongPressed

				pg.DelegateInfo.Add(arg_83_0, var_85_12)
				var_85_12:RemoveAllListeners()
				var_85_12:AddListener(function()
					arg_83_0:emit(LevelMediator2.ON_STAGE_SHIPINFO, {
						shipId = var_85_0.id,
						shipVOs = var_83_1
					})

					return
				end)
			end

			return
		end)
		var_84_0:align(#arg_84_1)

		return
	end)(var_83_0:Find("vanguard"), arg_83_0.contextData.chapterVO.fleet:getShipsByTeam(TeamType.Vanguard, true))
	arg_83_0.contextData.chapterVO.fleet:clearShipHpChange()

	return
end

function var_0_0.updateSupportFleet(arg_91_0)
	local var_91_0 = arg_91_0.contextData.chapterVO:getChapterSupportFleet()
	local var_91_1 = findTF(arg_91_0.leftStage, "support_fleet")

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

		local var_91_5 = var_91_1:Find("show")

		local function var_91_6(arg_92_0)
			setActive(var_0, true)
			setActive(var_91_5, true)
			shiftPanel(var_91_5, nil, arg_92_0 and -325.1 or -855, 0.3, 0, true, nil, LeanTweenType.easeOutSine, function()
				setActive(var_0, not arg_92_0)
				setActive(var_91_5, arg_92_0)

				return
			end)
			shiftPanel(var_0, nil, arg_92_0 and -1017 or -563.97, 0.3, 0, true, nil, LeanTweenType.easeOutSine)

			return
		end

		onButton(arg_91_0, var_91_1:Find("hide"), function()
			var_91_6(true)

			return
		end, SFX_PANEL)
		onButton(arg_91_0, var_91_1:Find("show"), function()
			var_91_6(false)

			return
		end)
	end

	return
end

function var_0_0.ShiftStagePanelIn(arg_96_0, arg_96_1)
	shiftPanel(arg_96_0.topStage, 0, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine, arg_96_1)
	arg_96_0:ShiftBottomStage(true)
	shiftPanel(arg_96_0.leftStage, 0, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
	shiftPanel(arg_96_0.rightStage, 0, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)

	return
end

function var_0_0.ShiftStagePanelOut(arg_97_0, arg_97_1)
	shiftPanel(arg_97_0.topStage, 0, arg_97_0.topStage.rect.height, 0.3, 0, true, nil, LeanTweenType.easeOutSine, arg_97_1)
	arg_97_0:ShiftBottomStage(false)
	shiftPanel(arg_97_0.leftStage, -arg_97_0.leftStage.rect.width - 200, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)
	shiftPanel(arg_97_0.rightStage, arg_97_0.rightStage.rect.width + 300, 0, 0.3, 0, true, nil, LeanTweenType.easeOutSine)

	return
end

function var_0_0.ShiftBottomStage(arg_98_0, arg_98_1)
	if not arg_98_0.bottomStageInactive then
		-- block empty
	else
		arg_98_1 = false
	end

	local var_98_0

	if false then
		arg_98_1 = true
		var_98_0 = shiftPanel
	end

	var_98_0(arg_98_0.bottomStage, 0, arg_98_1 and 0 or -arg_98_0.bottomStage.rect.height, 0.3, 0, true, nil, LeanTweenType.easeOutSine)

	return
end

function var_0_0.SwitchSubTeleportBottomStage(arg_99_0)
	setActive(arg_99_0.missileStrikeRole, true)
	setText(findTF(arg_99_0.missileStrikeRole, "confirm_button/Text"), i18n("levelscene_deploy_submarine"))
	setText(findTF(arg_99_0.missileStrikeRole, "cancel_button/Text"), i18n("levelscene_deploy_submarine_cancel"))
	onButton(arg_99_0, arg_99_0.missileStrikeRole:Find("confirm_button"), function()
		local var_100_0 = arg_99_0.contextData.chapterVO:GetSubmarineFleet()
		local var_100_1 = arg_99_0.grid.subTeleportTargetLine

		if not arg_99_0.grid.subTeleportTargetLine then
			return
		end

		local var_100_2 = arg_99_0.contextData.chapterVO:findPath(nil, var_100_0.startPos, arg_99_0.grid.subTeleportTargetLine)

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("tips_confirm_teleport_sub", arg_99_0.grid:TransformLine2PlanePos(var_100_0.startPos), arg_99_0.grid:TransformLine2PlanePos(arg_99_0.grid.subTeleportTargetLine), var_100_2, (math.ceil(pg.strategy_data_template[ChapterConst.StrategySubTeleport].arg[2] * #var_100_0:getShips(false) * var_100_2 - 1e-05))),
			onYes = function()
				arg_99_0:emit(LevelMediator2.ON_OP, {
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
	onButton(arg_99_0, arg_99_0.missileStrikeRole:Find("cancel_button"), function()
		arg_99_0:SwitchBottomStagePanel(false)
		arg_99_0.grid:TurnOffSubTeleport()
		arg_99_0.grid:updateQuadCells(ChapterConst.QuadStateNormal)

		return
	end, SFX_UI_CLICK)

	return
end

function var_0_0.SwitchMissileBottomStagePanel(arg_103_0)
	setActive(arg_103_0.missileStrikeRole, true)
	setText(findTF(arg_103_0.missileStrikeRole, "confirm_button/Text"), i18n("missile_attack_area_confirm"))
	setText(findTF(arg_103_0.missileStrikeRole, "cancel_button/Text"), i18n("missile_attack_area_cancel"))
	onButton(arg_103_0, arg_103_0.missileStrikeRole:Find("confirm_button"), function()
		if not arg_103_0.grid.missileStrikeTargetLine then
			return
		end

		local var_104_0 = arg_103_0.contextData.chapterVO.fleet

		;(function()
			arg_103_0:emit(LevelMediator2.ON_OP, {
				type = ChapterConst.OpStrategy,
				id = var_104_0.id,
				arg1 = ChapterConst.StrategyMissileStrike,
				arg2 = var_0.row,
				arg3 = var_0.column
			})

			return
		end)()

		return
	end, SFX_UI_CLICK)
	onButton(arg_103_0, arg_103_0.missileStrikeRole:Find("cancel_button"), function()
		arg_103_0:SwitchBottomStagePanel(false)
		arg_103_0.grid:HideMissileAimingMark()
		arg_103_0.grid:updateQuadCells(ChapterConst.QuadStateNormal)

		return
	end, SFX_UI_CLICK)

	return
end

function var_0_0.SwitchAirSupportBottomStagePanel(arg_107_0)
	setActive(arg_107_0.missileStrikeRole, true)
	setText(findTF(arg_107_0.missileStrikeRole, "confirm_button/Text"), i18n("missile_attack_area_confirm"))
	setText(findTF(arg_107_0.missileStrikeRole, "cancel_button/Text"), i18n("missile_attack_area_cancel"))
	onButton(arg_107_0, arg_107_0.missileStrikeRole:Find("confirm_button"), function()
		if not arg_107_0.grid.missileStrikeTargetLine then
			return
		end

		local var_108_0 = arg_107_0.contextData.chapterVO:getChapterSupportFleet()

		;(function()
			arg_107_0:emit(LevelMediator2.ON_OP, {
				type = ChapterConst.OpStrategy,
				id = var_108_0.id,
				arg1 = ChapterConst.StrategyAirSupport,
				arg2 = var_0.row,
				arg3 = var_0.column
			})

			return
		end)()

		return
	end, SFX_UI_CLICK)
	onButton(arg_107_0, arg_107_0.missileStrikeRole:Find("cancel_button"), function()
		arg_107_0:SwitchBottomStagePanel(false)
		arg_107_0.grid:HideAirSupportAimingMark()
		arg_107_0.grid:updateQuadCells(ChapterConst.QuadStateNormal)

		return
	end, SFX_UI_CLICK)

	return
end

function var_0_0.SwitchAirExpelBottomStagePanel(arg_111_0)
	setActive(arg_111_0.airExpelRole, true)
	setText(findTF(arg_111_0.airExpelRole, "cancel_button/Text"), i18n("levelscene_airexpel_cancel"))
	onButton(arg_111_0, arg_111_0.airExpelRole:Find("cancel_button"), function()
		arg_111_0:SwitchBottomStagePanel(false)
		arg_111_0.grid:HideAirExpelAimingMark()
		arg_111_0.grid:CleanAirSupport()
		arg_111_0.grid:updateQuadCells(ChapterConst.QuadStateNormal)

		return
	end, SFX_UI_CLICK)

	return
end

function var_0_0.SwitchBottomStagePanel(arg_113_0, arg_113_1)
	setActive(arg_113_0.actionRole, true)
	setActive(arg_113_0.normalRole, true)
	shiftPanel(arg_113_0.actionRole, 0, arg_113_1 and 0 or var_0_1, 0.3, 0, true, true, nil, function()
		setActive(arg_113_0.actionRole, arg_113_1)

		return
	end)

	local var_113_1 = arg_113_0.normalRole
	local var_113_2 = 0

	if arg_113_1 then
		local var_113_3 = var_0_1 or 0

		var_113_0(var_113_1, var_113_2, var_113_3, 0.3, 0, true, true, nil, function()
			setActive(arg_113_0.normalRole, not arg_113_1)

			if not arg_113_1 then
				eachChild(arg_113_0.actionRole, function(arg_116_0)
					setActive(arg_116_0, false)

					return
				end)
			end

			return
		end)

		local var_113_5 = arg_113_0.leftStage

		if arg_113_1 then
			local var_113_6 = -arg_113_0.leftStage.rect.width - 200 or 0

			var_113_4(var_113_5, var_113_6, 0, 0.3, 0, true)

			local var_113_8 = arg_113_0.rightStage

			if arg_113_1 then
				local var_113_9 = arg_113_0.rightStage.rect.width + 300 or 0

				var_113_7(var_113_8, var_113_9, 0, 0.3, 0, true)

				return
			end
		end
	end
end

function var_0_0.ClickGridCellNormal(arg_117_0, arg_117_1)
	local var_117_0 = _.detect(arg_117_0.contextData.chapterVO.fleets, function(arg_118_0)
		return arg_118_0:getFleetType() == FleetType.Normal and arg_118_0.line.row == arg_117_1.row and arg_118_0.line.column == arg_117_1.column
	end)

	if var_117_0 and var_117_0:isValid() and var_117_0.id ~= arg_117_0.contextData.chapterVO.fleet.id then
		arg_117_0:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpSwitch,
			id = var_117_0.id
		})

		return
	end

	if arg_117_0:tryAutoTrigger(nil, true) then
		return
	end

	if arg_117_1.row == arg_117_0.contextData.chapterVO.fleet.line.row and arg_117_1.column == arg_117_0.contextData.chapterVO.fleet.line.column then
		return
	end

	local var_117_1 = arg_117_0.contextData.chapterVO:getChapterCell(arg_117_1.row, arg_117_1.column)

	if var_117_1.attachment == ChapterConst.AttachStory and var_117_1.data == ChapterConst.StoryObstacle and var_117_1.flag == ChapterConst.CellFlagTriggerActive then
		if pg.map_event_template[var_117_1.attachmentId] and pg.map_event_template[var_117_1.attachmentId].gametip and #pg.map_event_template[var_117_1.attachmentId].gametip > 0 and arg_117_0.contextData.chapterVO:getPlayType() ~= ChapterConst.TypeDefence then
			pg.TipsMgr.GetInstance():ShowTips(i18n(pg.map_event_template[var_117_1.attachmentId].gametip))
		end

		return
	elseif not arg_117_0.contextData.chapterVO:considerAsStayPoint(ChapterConst.SubjectPlayer, arg_117_1.row, arg_117_1.column) then
		return
	elseif arg_117_0.contextData.chapterVO:existMoveLimit() and not _.any(arg_117_0.contextData.chapterVO:calcWalkableCells(ChapterConst.SubjectPlayer, arg_117_0.contextData.chapterVO.fleet.line.row, arg_117_0.contextData.chapterVO.fleet.line.column, arg_117_0.contextData.chapterVO.fleet:getSpeed()), function(arg_119_0)
		return arg_119_0.row == arg_117_1.row and arg_119_0.column == arg_117_1.column
	end) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("destination_not_in_range"))

		return
	end

	local var_117_2 = arg_117_0.contextData.chapterVO:findPath(ChapterConst.SubjectPlayer, arg_117_0.contextData.chapterVO.fleet.line, {
		row = arg_117_1.row,
		column = arg_117_1.column
	})

	if var_117_2 < PathFinding.PrioObstacle then
		arg_117_0:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpMove,
			id = arg_117_0.contextData.chapterVO.fleet.id,
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

function var_0_0.tryAutoAction(arg_120_0, arg_120_1)
	if arg_120_0.doingAutoAction then
		return
	end

	arg_120_0.doingAutoAction = true

	local var_120_0 = arg_120_0.contextData.chapterVO

	if not arg_120_0.contextData.chapterVO then
		existCall(arg_120_1)

		return
	end

	if arg_120_0:SafeCheck() then
		existCall(arg_120_1)

		return
	end

	local var_120_1 = {}
	local var_120_2 = false

	for iter_120_0, iter_120_1 in pairs(arg_120_0.contextData.chapterVO.cells) do
		if iter_120_1.trait == ChapterConst.TraitLurk then
			var_120_2 = true

			break
		end
	end

	if not var_120_2 then
		for iter_120_2, iter_120_3 in ipairs(arg_120_0.contextData.chapterVO.champions) do
			if iter_120_3.trait == ChapterConst.TraitLurk then
				var_120_2 = true

				break
			end
		end
	end

	if var_120_2 then
		local var_120_3 = arg_120_0.contextData.chapterVO:isPlayingWithBombEnemy()

		if not arg_120_0.contextData.chapterVO:existOni() and not arg_120_0.contextData.chapterVO:isPlayingWithBombEnemy() then
			table.insert(var_120_1, function(arg_121_0)
				arg_120_0:emit(LevelUIConst.DO_TRACKING, arg_121_0)

				return
			end)
		else
			table.insertto(var_120_1, {
				function(arg_122_0)
					local var_122_0

					if var_0 then
						var_122_0 = "SpUnit"
					elseif var_120_3 then
						var_122_0 = "SpBomb"
					end

					assert(var_122_0)
					arg_120_0:emit(LevelUIConst.DO_PLAY_ANIM, {
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
						arg_120_0:tryPlayChapterStory(arg_127_0)

						return
					end,
					function(arg_128_0)
						local var_128_0 = var_120_0:GetBossCell()

						if var_128_0 and var_128_0.trait == ChapterConst.TraitLurk then
							arg_120_0.grid:focusOnCell(var_128_0, arg_128_0)

							return
						end

						arg_128_0()

						return
					end
				}, arg_126_0)

				return
			end,
			function(arg_129_0)
				arg_120_0:updateTrait(ChapterConst.TraitVirgin)
				arg_120_0.grid:updateAttachments()
				arg_120_0.grid:updateChampions()
				arg_120_0:updateTrait(ChapterConst.TraitNone)
				arg_120_0:emit(LevelMediator2.ON_OVERRIDE_CHAPTER)
				Timer.New(arg_129_0, 0.5, 1):Start()

				return
			end
		})
	end

	seriesAsync({
		function(arg_130_0)
			arg_120_0:emit(LevelUIConst.FROZEN)

			local var_130_0 = getProxy(ChapterProxy):GetLastDefeatedEnemy(var_120_0.id)

			if var_130_0 then
				if var_130_0.attachment == ChapterConst.AttachAmbush then
					if ChapterConst.IsBossCell(var_130_0) then
						arg_120_0.grid:PlayAttachmentEffect(var_130_0.line.row, var_130_0.line.column, ChapterConst.GetDestroyFX(var_130_0), Vector2.zero)
					end

					arg_120_0:PopBar()
					arg_120_0:UpdateComboPanel()
					arg_130_0()

					return
				end
			end
		end,
		function(arg_131_0)
			if not (function()
				local var_132_0 = getProxy(ChapterProxy):GetLastDefeatedEnemy(var_120_0.id)

				if not var_132_0 then
					return
				end

				local var_132_1 = pg.expedition_data_template[var_132_0.attachmentId]

				return pg.expedition_data_template[var_132_0.attachmentId] and var_132_1.type == ChapterConst.ExpeditionTypeMulBoss
			end)() then
				return arg_131_0()
			end

			arg_120_0:emit(LevelUIConst.DO_PLAY_ANIM, {
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
			arg_120_0:UpdateDOALinkFeverPanel(arg_134_0)

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
			local var_138_0 = getProxy(ChapterProxy):getUpdatedExtraFlags(arg_120_0.contextData.chapterVO.id)

			if not var_138_0 or #var_138_0 < 1 then
				arg_138_0()

				return
			end

			for iter_138_0, iter_138_1 in ipairs(var_138_0) do
				if pg.chapter_status_effect[iter_138_1] then
					local var_138_1 = pg.chapter_status_effect[iter_138_1].camera_focus or ""

					if type(var_138_1) == "table" then
						arg_120_0.grid:focusOnCell({
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
			if arg_120_0.exited then
				return
			end

			arg_120_0:emit(LevelUIConst.UN_FROZEN)
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
		if arg_120_0.exited then
			return
		end

		arg_120_0.doingAutoAction = nil

		if var_120_2 and arg_120_0:TryEnterChapterStoryStage() then
			-- block empty
		else
			existCall(arg_120_1)
		end

		return
	end)

	return
end

function var_0_0.tryPlayChapterStory(arg_142_0, arg_142_1)
	local var_142_0 = arg_142_0.contextData.chapterVO:getWaveCount()

	seriesAsync({
		function(arg_143_0)
			pg.SystemGuideMgr.GetInstance():PlayChapter(var_0, arg_143_0)

			return
		end,
		function(arg_144_0)
			local var_144_0 = var_0:getConfig("story_refresh")
			local var_144_1 = var_144_0 and var_144_0[var_142_0]

			if var_144_0 and var_144_0[var_142_0] and type(var_144_1) == "string" and var_144_1 ~= "" and not var_0:IsRemaster() then
				ChapterOpCommand.PlayChapterStory(var_144_1, arg_144_0, var_0:IsAutoFight())

				return
			end

			arg_144_0()

			return
		end,
		function(arg_145_0)
			local var_145_0 = var_0:getConfig("story_refresh_boss")

			if var_145_0 and type(var_145_0) == "string" and var_145_0 ~= "" and not var_0:IsRemaster() and var_0:IsFinalBossRefreshed() then
				ChapterOpCommand.PlayChapterStory(var_145_0, arg_145_0, var_0:IsAutoFight())

				return
			end

			arg_145_0()

			return
		end,
		function(arg_146_0)
			if var_142_0 == 1 and pg.map_event_list[var_0.id] and pg.map_event_list[var_0.id].help_open == 1 and PlayerPrefs.GetInt("help_displayed_on_" .. var_0.id, 0) == 0 then
				triggerButton(arg_142_0.helpBtn)
				PlayerPrefs.SetInt("help_displayed_on_" .. var_0.id, 1)
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

function var_0_0.TryEnterChapterStoryStage(arg_148_0, arg_148_1)
	local var_148_0 = arg_148_0.contextData.chapterVO:getWaveCount()
	local var_148_1 = arg_148_0.contextData.chapterVO:getConfig("story_refresh")
	local var_148_2 = var_148_1 and var_148_1[var_148_0]

	if var_148_1 and var_148_1[var_148_0] and type(var_148_2) == "number" and not arg_148_0.contextData.chapterVO:IsRemaster() then
		if not pg.NewStoryMgr.GetInstance():IsPlayed(pg.NewStoryMgr.GetInstance():StoryId2StoryName(var_148_2)) then
			arg_148_0:emit(LevelMediator2.ON_PERFORM_COMBAT, var_148_2)

			return true
		end
	end

	local var_148_3 = arg_148_0.contextData.chapterVO:getConfig("story_refresh_boss")

	if var_148_3 and type(var_148_3) == "number" and not arg_148_0.contextData.chapterVO:IsRemaster() and arg_148_0.contextData.chapterVO:IsFinalBossRefreshed() then
		if not pg.NewStoryMgr.GetInstance():IsPlayed(pg.NewStoryMgr.GetInstance():StoryId2StoryName(var_148_3)) then
			arg_148_0:emit(LevelMediator2.ON_PERFORM_COMBAT, var_148_3)

			return true
		end
	end

	return
end

function var_0_0.TryEnterChapterSupportSubmarineStage(arg_149_0, arg_149_1)
	local var_149_0 = arg_149_0.contextData.chapterVO:getChapterSupportFleet()

	if arg_149_0.contextData.chapterVO:getChapterSupportFleet() then
		arg_149_0:emit(LevelMediator2.ON_SUPPORT_SUBMARINE)
	else
		arg_149_0:emit(LevelMediator2.ON_OP, {
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

function var_0_0.PopBar(arg_150_0)
	local var_150_0 = getProxy(ChapterProxy):getUpdatedExtraFlags(arg_150_0.contextData.chapterVO.id)

	if not var_150_0 or #var_150_0 < 1 then
		return
	end

	local var_150_1 = var_0_4[var_150_0[1]]

	if not var_0_4[var_150_0[1]] then
		return
	end

	local var_150_2, var_150_3 = arg_150_0:GetSubView(var_150_1)

	if var_150_3 then
		var_150_2:Load()
	end

	var_150_2.buffer:PlayAnim()

	return
end

function var_0_0.updateTrait(arg_151_0, arg_151_1)
	for iter_151_0, iter_151_1 in pairs(arg_151_0.contextData.chapterVO.cells) do
		if iter_151_1.trait ~= ChapterConst.TraitNone then
			iter_151_1.trait = arg_151_1
		end
	end

	for iter_151_2, iter_151_3 in ipairs(arg_151_0.contextData.chapterVO.champions) do
		if iter_151_3.trait ~= ChapterConst.TraitNone then
			iter_151_3.trait = arg_151_1
		end
	end

	return
end

function var_0_0.CheckFleetChange(arg_152_0)
	local var_152_0 = _.detect(arg_152_0.contextData.chapterVO.fleets, function(arg_153_0)
		return not arg_153_0:isValid()
	end)

	if var_152_0 then
		arg_152_0:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpRetreat,
			id = var_152_0.id
		})

		if var_152_0:getFleetType() == TeamType.Normal then
			getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.BATTLE_FAILED)
		end
	end

	if not arg_152_0.contextData.chapterVO:GetActiveFleet():isValid() then
		local var_152_1 = arg_152_0.contextData.chapterVO:getNextValidIndex()

		if var_152_1 > 0 then
			arg_152_0:HandleShowMsgBox({
				modal = true,
				hideNo = true,
				content = i18n("formation_switch_tip", arg_152_0.contextData.chapterVO.fleets[var_152_1].name),
				onYes = function()
					arg_152_0:emit(LevelMediator2.ON_OP, {
						type = ChapterConst.OpSwitch,
						id = var_0.id
					})

					return
				end,
				onNo = function()
					arg_152_0:emit(LevelMediator2.ON_OP, {
						type = ChapterConst.OpSwitch,
						id = var_0.id
					})

					return
				end
			})
		end

		return true
	end

	return false
end

function var_0_0.tryAutoTrigger(arg_155_0, arg_155_1, arg_155_2)
	local var_155_0 = arg_155_0.contextData.chapterVO

	if arg_155_0:DoBreakAction() then
		return
	end

	if arg_155_0:CheckFleetChange() then
		return
	end

	return ((function()
		if var_155_0:checkAnyInteractive() then
			if not arg_155_1 or var_155_0:IsAutoFight() then
				triggerButton(arg_155_0.funcBtn)

				return true
			end
		elseif var_155_0:getRound() == ChapterConst.RoundEnemy then
			arg_155_0:emit(LevelMediator2.ON_OP, {
				type = ChapterConst.OpEnemyRound
			})

			return true
		elseif var_155_0:getRound() == ChapterConst.RoundPlayer then
			if not arg_155_2 then
				arg_155_0.grid:updateQuadCells(ChapterConst.QuadStateNormal)
			end

			if var_155_0:IsAutoFight() then
				arg_155_0:TryAutoFight()

				return true
			end
		end

		return
	end)())
end

function var_0_0.DoBreakAction(arg_157_0)
	local var_157_0 = arg_157_0.contextData.chapterVO
	local var_157_1, var_157_2 = arg_157_0:SafeCheck()

	if var_157_1 then
		local function var_157_3(arg_158_0)
			local var_158_0

			seriesAsync({
				function(arg_159_0)
					arg_157_0:emit(LevelUIConst.ADD_MSG_QUEUE, arg_159_0)

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
			if arg_157_0.contextData.chapterVO:getPlayType() == ChapterConst.TypeTransport then
				pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_escort_lose"))
				;(function(arg_158_0)
					local var_158_0

					seriesAsync({
						function(arg_159_0)
							arg_157_0:emit(LevelUIConst.ADD_MSG_QUEUE, arg_159_0)

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
				end)()
			else
				arg_157_0:HandleShowMsgBox({
					modal = true,
					hideNo = true,
					content = i18n("formation_invalide"),
					onYes = function(arg_158_0)
						local var_158_0

						seriesAsync({
							function(arg_159_0)
								arg_157_0:emit(LevelUIConst.ADD_MSG_QUEUE, arg_159_0)

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
					end,
					onClose = function(arg_158_0)
						local var_158_0

						seriesAsync({
							function(arg_159_0)
								arg_157_0:emit(LevelUIConst.ADD_MSG_QUEUE, arg_159_0)

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
				})
			end
		elseif var_157_2 == ChapterConst.ReasonDefeatDefense then
			arg_157_0:HandleShowMsgBox({
				modal = true,
				hideNo = true,
				content = i18n("harbour_bomb_tip"),
				onYes = function(arg_158_0)
					local var_158_0

					seriesAsync({
						function(arg_159_0)
							arg_157_0:emit(LevelUIConst.ADD_MSG_QUEUE, arg_159_0)

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
				end,
				onClose = function(arg_158_0)
					local var_158_0

					seriesAsync({
						function(arg_159_0)
							arg_157_0:emit(LevelUIConst.ADD_MSG_QUEUE, arg_159_0)

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
			})
		elseif var_157_2 == ChapterConst.ReasonVictoryOni then
			(function(arg_158_0)
				local var_158_0

				seriesAsync({
					function(arg_159_0)
						arg_157_0:emit(LevelUIConst.ADD_MSG_QUEUE, arg_159_0)

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
			end)()
		elseif var_157_2 == ChapterConst.ReasonDefeatOni then
			(function(arg_158_0)
				local var_158_0

				seriesAsync({
					function(arg_159_0)
						arg_157_0:emit(LevelUIConst.ADD_MSG_QUEUE, arg_159_0)

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
			end)()
		elseif var_157_2 == ChapterConst.ReasonDefeatBomb then
			(function(arg_158_0)
				local var_158_0

				seriesAsync({
					function(arg_159_0)
						arg_157_0:emit(LevelUIConst.ADD_MSG_QUEUE, arg_159_0)

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
			end)()
		elseif var_157_2 == ChapterConst.ReasonOutTime then
			arg_157_0:emit(LevelMediator2.ON_TIME_UP)
		elseif var_157_2 == ChapterConst.ReasonActivityOutTime then
			arg_157_0:HandleShowMsgBox({
				modal = true,
				hideNo = true,
				content = i18n("battle_preCombatMediator_activity_timeout"),
				onYes = function(arg_158_0)
					local var_158_0

					seriesAsync({
						function(arg_159_0)
							arg_157_0:emit(LevelUIConst.ADD_MSG_QUEUE, arg_159_0)

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
				end,
				onClose = function(arg_158_0)
					local var_158_0

					seriesAsync({
						function(arg_159_0)
							arg_157_0:emit(LevelUIConst.ADD_MSG_QUEUE, arg_159_0)

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
			})
		end

		return true
	end

	return var_157_1
end

function var_0_0.SafeCheck(arg_164_0)
	if arg_164_0.contextData.chapterVO:existOni() then
		local var_164_0 = arg_164_0.contextData.chapterVO:checkOniState()

		if var_164_0 == 1 then
			return true, ChapterConst.ReasonVictoryOni
		elseif var_164_0 == 2 then
			return true, ChapterConst.ReasonDefeatOni
		else
			return false
		end
	elseif arg_164_0.contextData.chapterVO:isPlayingWithBombEnemy() then
		if arg_164_0.contextData.chapterVO:getBombChapterInfo().action_times * 2 <= arg_164_0.contextData.chapterVO.roundIndex then
			return true, ChapterConst.ReasonDefeatBomb
		else
			return false
		end
	end

	local var_164_1, var_164_2 = arg_164_0.contextData.chapterVO:CheckChapterWin()

	if var_164_1 then
		return true, var_164_2
	end

	local var_164_3, var_164_4 = arg_164_0.contextData.chapterVO:CheckChapterLose()

	if var_164_3 then
		return true, var_164_4
	end

	if not arg_164_0.contextData.chapterVO:inWartime() then
		return true, ChapterConst.ReasonOutTime
	end

	local var_164_5 = arg_164_0.contextData.chapterVO:GetBindActID()

	if not arg_164_0.contextData.map:isRemaster() and var_164_5 ~= 0 then
		local var_164_6 = getProxy(ActivityProxy):getActivityById(var_164_5)

		if not var_164_6 or var_164_6:isEnd() then
			return true, ChapterConst.ReasonActivityOutTime
		end
	end

	return false
end

function var_0_0.TryAutoFight(arg_165_0)
	local var_165_0 = arg_165_0.contextData.chapterVO

	if not arg_165_0.contextData.chapterVO:IsAutoFight() then
		return
	end

	local var_165_2 = arg_165_0.contextData.chapterVO:GetAllEnemies()
	local var_165_3 = _.detect(var_165_2, function(arg_166_0)
		return ChapterConst.IsBossCell(arg_166_0)
	end)
	local var_165_4 = arg_165_0.contextData.chapterVO:GetFleetOfDuty(tobool(var_165_3))

	if var_165_4 and var_165_4.id ~= arg_165_0.contextData.chapterVO.fleet.id then
		arg_165_0:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpSwitch,
			id = var_165_4.id
		})
		arg_165_0:tryAutoTrigger()

		return
	end

	if arg_165_0.contextData.chapterVO:checkAnyInteractive() then
		arg_165_0:tryAutoTrigger()

		return
	end

	local var_165_5

	for iter_165_0, iter_165_1 in ipairs(arg_165_0.contextData.chapterVO:getConfig("box_auto_pick")) do
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
			local var_165_6, var_165_7 = arg_165_0.contextData.chapterVO:findPath(ChapterConst.SubjectPlayer, var_165_4.line, iter_165_3)

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
			local var_165_8, var_165_9 = arg_165_0.contextData.chapterVO:FindBossPath(var_165_4.line, var_165_3)
			local var_165_10

			for iter_165_4, iter_165_5 in ipairs(var_165_9) do
				table.insert({}, iter_165_5)

				if arg_165_0.contextData.chapterVO:existEnemy(ChapterConst.SubjectPlayer, iter_165_5.row, iter_165_5.column) then
					var_165_8 = iter_165_4
					var_165_10 = iter_165_5

					break
				end
			end

			var_165_5 = {
				{
					target = var_165_10 or var_165_3,
					priority = var_165_8 or 0,
					path = {}
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

			local function var_165_11(arg_173_0)
				assert(pg.expedition_data_template[arg_173_0.target.attachmentId], "expedition_data_template not exist: " .. arg_173_0.target.attachmentId)

				if arg_173_0.target.flag == ChapterConst.CellFlagDisabled then
					return 0
				end

				return ChapterConst.EnemyPreference[pg.expedition_data_template[arg_173_0.target.attachmentId].type]
			end

			if arg_165_0.contextData.chapterVO.id == 1604 then
				table.sort(var_165_5, CompareFuncs({
					function(arg_174_0)
						return arg_174_0.priority < PathFinding.PrioObstacle and 0 or 1
					end,
					function(arg_175_0)
						return -var_165_11(arg_175_0)
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
						return -var_165_11(arg_180_0)
					end,
					function(arg_181_0)
						return arg_181_0.priority
					end
				}))
			end
		end
	end

	if var_165_5 and #var_165_5 > 0 and var_165_5[1].priority < PathFinding.PrioObstacle then
		arg_165_0:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpMove,
			id = var_165_4.id,
			arg1 = var_165_5[1].target.row,
			arg2 = var_165_5[1].target.column
		})
	else
		pg.TipsMgr.GetInstance():ShowTips(i18n("autofight_errors_tip"))
		getProxy(ChapterProxy):SetChapterAutoFlag(arg_165_0.contextData.chapterVO.id, false)
	end

	return
end

function var_0_0.popStageStrategy(arg_182_0)
	local var_182_0 = arg_182_0.rightStage:Find("event/collapse")

	if var_182_0.anchoredPosition.x <= 1 then
		triggerButton(var_182_0)
	end

	return
end

function var_0_0.UpdateAutoFightPanel(arg_183_0)
	if arg_183_0.contextData.chapterVO:CanActivateAutoFight() then
		if not arg_183_0.autoFightPanel then
			arg_183_0.autoFightPanel = LevelStageAutoFightPanel.New(arg_183_0.rightStage:Find("event/collapse"), arg_183_0.event, arg_183_0.contextData)

			arg_183_0.autoFightPanel:Load()

			arg_183_0.autoFightPanel.isFrozen = arg_183_0.isFrozen
		end

		arg_183_0.autoFightPanel.buffer:Show()
	elseif arg_183_0.autoFightPanel then
		arg_183_0.autoFightPanel.buffer:Hide()
	end

	return
end

function var_0_0.UpdateAutoFightMark(arg_184_0)
	if not arg_184_0.autoFightPanel then
		return
	end

	arg_184_0.autoFightPanel.buffer:UpdateAutoFightMark()

	return
end

function var_0_0.DestroyAutoFightPanel(arg_185_0)
	if not arg_185_0.autoFightPanel then
		return
	end

	arg_185_0.autoFightPanel:Destroy()

	arg_185_0.autoFightPanel = nil

	return
end

function var_0_0.DestroyToast(arg_186_0)
	if not arg_186_0.toastPanel then
		return
	end

	arg_186_0.toastPanel:Destroy()

	arg_186_0.toastPanel = nil

	return
end

function var_0_0.Toast(arg_187_0)
	arg_187_0:DestroyToast()

	local var_187_0 = table.remove(arg_187_0.toastQueue, 1)

	if not var_187_0 then
		return
	end

	arg_187_0.toastPanel = var_187_0.Class.New(arg_187_0)

	arg_187_0.toastPanel:Load()

	arg_187_0.toastPanel.contextData.settings = var_187_0

	arg_187_0.toastPanel.buffer:Play(function()
		arg_187_0:Toast()

		return
	end)

	return
end

function var_0_0.HandleShowMsgBox(arg_189_0, arg_189_1)
	pg.MsgboxMgr.GetInstance():ShowMsgBox(arg_189_1)

	return
end

return var_0_0
