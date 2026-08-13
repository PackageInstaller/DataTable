class = var_0_10000

local var_0_0 = "LevelStageView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseSubView"))

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	arg_1_0.isFrozen = nil

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	LevelUIConst = var_4

	var_1_1(var_1_0, var_4.ON_FROZEN, function()
		arg_1_0.isFrozen = true

		if arg_1_0.cgComp then
			arg_1_0.cgComp.blocksRaycasts = false
		end

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	LevelUIConst = var_4

	var_1_3(var_1_2, var_4.ON_UNFROZEN, function()
		arg_1_0.isFrozen = nil

		if arg_1_0.cgComp then
			arg_1_0.cgComp.blocksRaycasts = true
		end

		return
	end)

	arg_1_0.toastQueue = {}

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.bind

	LevelUIConst = var_4

	var_1_5(var_1_4, var_4.ADD_TOAST_QUEUE, function(arg_4_0, arg_4_1)
		table = var_2_10002

		var_2_10002.insert(arg_1_0.toastQueue, arg_4_1)

		if #arg_1_0.toastQueue > 1 then
			return
		end

		local var_4_0 = arg_1_0

		var_2.Toast(var_4_0)

		return
	end)

	return
end

function var_0_1.getUIName(arg_5_0)
	return "LevelStageView"
end

function var_0_1.OnInit(arg_6_0)
	arg_6_0:InitUI()
	arg_6_0:AddListener()

	AutoLoader = var_1
	arg_6_0.loader = var_1.New()
	GetOrAddComponent = var_1

	local var_6_0 = arg_6_0._go

	typeof = var_1_10004
	CanvasGroup = var_1_10006
	arg_6_0.cgComp = var_1(var_6_0, var_1_10004(var_1_10006))
	arg_6_0.cgComp.blocksRaycasts = not arg_6_0.isFrozen

	arg_6_0:Show()

	return
end

function var_0_1.OnDestroy(arg_7_0)
	if arg_7_0.stageTimer then
		local var_7_0 = arg_7_0.stageTimer

		var_1.Stop(var_7_0)

		arg_7_0.stageTimer = nil
	end

	arg_7_0:ClearSubViews()
	arg_7_0:DestroyAutoFightPanel()
	arg_7_0:DestroyWinConditionPanel()
	arg_7_0:DestroyToast()

	local var_7_1 = arg_7_0.loader

	var_1.Clear(var_7_1)
	arg_7_0:Hide()

	return
end

local var_0_2 = -300

function var_0_1.InitUI(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.topStage = var_1.Find(var_8_0, "top_stage")
	setActive = var_1

	var_1(arg_8_0.topStage, true)

	local var_8_1 = arg_8_0._tf

	arg_8_0.bottomStage = var_1.Find(var_8_1, "bottom_stage")
	findTF = var_1
	arg_8_0.normalRole = var_1(arg_8_0.bottomStage, "Normal")

	local var_8_2 = arg_8_0.normalRole

	arg_8_0.funcBtn = var_1.Find(var_8_2, "func_button")

	local var_8_3 = arg_8_0.normalRole

	arg_8_0.retreatBtn = var_1.Find(var_8_3, "retreat_button")

	local var_8_4 = arg_8_0.normalRole

	arg_8_0.switchBtn = var_1.Find(var_8_4, "switch_button")

	local var_8_5 = arg_8_0.normalRole

	arg_8_0.helpBtn = var_1.Find(var_8_5, "help_button")

	local var_8_6 = arg_8_0.normalRole

	arg_8_0.shengfuBtn = var_1.Find(var_8_6, "shengfu/shengfu_button")
	findTF = var_1
	arg_8_0.actionRole = var_1(arg_8_0.bottomStage, "Action")
	findTF = var_1
	arg_8_0.missileStrikeRole = var_1(arg_8_0.actionRole, "MissileStrike")
	findTF = var_1
	arg_8_0.airExpelRole = var_1(arg_8_0.actionRole, "AirExpel")
	setActive = var_1

	var_1(arg_8_0.bottomStage, true)

	setAnchoredPosition = var_1

	var_1(arg_8_0.normalRole, {
		x = 0,
		y = 0
	})

	setActive = var_1

	var_1(arg_8_0.normalRole, true)

	setAnchoredPosition = var_1

	var_1(arg_8_0.actionRole, {
		x = 0,
		y = var_0_2
	})

	setActive = var_1

	var_1(arg_8_0.actionRole, false)

	eachChild = var_1

	var_1(arg_8_0.actionRole, function(arg_9_0)
		setActive = var_2_10001

		var_2_10001(arg_9_0, false)

		return
	end)

	local var_8_7 = arg_8_0._tf

	arg_8_0.leftStage = var_1.Find(var_8_7, "left_stage")
	setActive = var_1

	var_1(arg_8_0.leftStage, true)

	local var_8_8 = arg_8_0._tf

	arg_8_0.rightStage = var_1.Find(var_8_8, "right_stage")

	local var_8_9 = arg_8_0.rightStage

	arg_8_0.bombPanel = var_1.Find(var_8_9, "bomb_panel")

	local var_8_10 = arg_8_0.rightStage

	arg_8_0.panelBarrier = var_1.Find(var_8_10, "panel_barrier")

	local var_8_11 = arg_8_0.rightStage
	local var_8_12 = var_1.Find(var_8_11, "event")
	local var_8_13 = var_1.GetComponent

	typeof = var_4
	Animator = var_1_10006
	arg_8_0.strategyPanelAnimator = var_8_13(var_8_12, var_4(var_1_10006))

	local var_8_14 = arg_8_0.rightStage

	arg_8_0.autoBattleBtn = var_1.Find(var_8_14, "event/collapse/lock_fleet")

	local var_8_15 = arg_8_0.rightStage

	arg_8_0.showDetailBtn = var_1.Find(var_8_15, "event/detail/show_detail")
	setActive = var_1

	var_1(arg_8_0.panelBarrier, false)

	setActive = var_1

	var_1(arg_8_0.rightStage, true)

	local var_8_16 = arg_8_0.topStage

	arg_8_0.airSupremacy = var_1.Find(var_8_16, "msg_panel/air_supremacy")
	setAnchoredPosition = var_1

	var_1(arg_8_0.topStage, {
		y = arg_8_0.topStage.rect.height
	})

	setAnchoredPosition = var_1

	var_1(arg_8_0.leftStage, {
		x = -arg_8_0.leftStage.rect.width - 200
	})

	setAnchoredPosition = var_1

	var_1(arg_8_0.rightStage, {
		x = arg_8_0.rightStage.rect.width + 300
	})

	setAnchoredPosition = var_1

	var_1(arg_8_0.bottomStage, {
		y = -arg_8_0.bottomStage.rect.height
	})

	arg_8_0.attachSubViews = {}

	return
end

function var_0_1.AddListener(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.bind

	LevelUIConst = var_1_10004

	var_10_1(var_10_0, var_1_10004.TRIGGER_ACTION, function()
		local var_11_0 = arg_10_0

		var_0.tryAutoTrigger(var_11_0)

		return
	end)

	local var_10_2 = arg_10_0
	local var_10_3 = arg_10_0.bind

	LevelUIConst = var_4

	var_10_3(var_10_2, var_4.STRATEGY_PANEL_AUTOFIGHT_ACTIVE, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_10_0.strategyPanelAnimator

		var_2.SetBool(var_12_0, "IsActive", arg_12_1)

		arg_10_0.bottomStageInactive = arg_12_1

		local var_12_1 = arg_10_0

		var_2.ShiftBottomStage(var_12_1, not arg_12_1)

		return
	end)

	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_0.bind

	LevelUIConst = var_4

	var_10_5(var_10_4, var_4.ON_CLICK_GRID_QUAD, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_10_0

		var_2.ClickGridCellNormal(var_13_0, arg_13_1)

		return
	end)

	onButton = var_10_5

	local var_10_6 = arg_10_0
	local var_10_7 = arg_10_0.topStage
	local var_10_8 = var_4.Find(var_10_7, "option")

	local function var_10_9()
		local var_14_0 = arg_10_0
		local var_14_1 = var_0.emit

		BaseUI = var_2_10003

		var_14_1(var_14_0, var_2_10003.ON_HOME)

		return
	end

	SFX_CANCEL = var_10_7

	var_10_5(var_10_6, var_10_8, var_10_9, var_10_7)

	onButton = var_10_5

	local var_10_10 = arg_10_0
	local var_10_11 = arg_10_0.topStage
	local var_10_12 = var_4.Find(var_10_11, "back_button")

	local function var_10_13()
		local var_15_0 = arg_10_0
		local var_15_1 = var_0.emit

		LevelUIConst = var_2_10003

		var_15_1(var_15_0, var_2_10003.SWITCH_TO_MAP)

		return
	end

	SFX_CANCEL = var_10_11

	var_10_5(var_10_10, var_10_12, var_10_13, var_10_11)

	onButton = var_10_5

	local var_10_14 = arg_10_0
	local var_10_15 = arg_10_0.retreatBtn

	local function var_10_16()
		local var_16_0 = arg_10_0.contextData.chapterVO
		local var_16_1 = arg_10_0.contextData.map
		local var_16_2 = "levelScene_whether_to_retreat"

		if var_16_0:existOni() then
			var_16_2 = "levelScene_oni_retreat"
		elseif var_16_0:isPlayingWithBombEnemy() then
			var_16_2 = "levelScene_bomb_retreat"
		else
			local var_16_3 = var_16_0:getPlayType()

			ChapterConst = var_2_10004

			if var_16_3 == var_2_10004.TypeTransport and not var_16_1:isSkirmish() then
				var_16_2 = "levelScene_escort_retreat"
			elseif var_16_1:isRemaster() then
				var_16_2 = "archives_whether_to_retreat"
			end
		end

		local var_16_4 = arg_10_0
		local var_16_5 = var_3.HandleShowMsgBox
		local var_16_6 = {}

		i18n = var_2_10007
		var_16_6.content = var_2_10007(var_16_2)
		ChapterOpCommand = var_7
		var_16_6.onYes = var_7.PrepareChapterRetreat

		var_16_5(var_16_4, var_16_6)

		return
	end

	SFX_UI_WEIGHANCHOR_WITHDRAW = var_10_11

	var_10_5(var_10_14, var_10_15, var_10_16, var_10_11)

	onButton = var_10_5

	local var_10_17 = arg_10_0
	local var_10_18 = arg_10_0.switchBtn

	local function var_10_19()
		local var_17_0 = arg_10_0.contextData.chapterVO
		local var_17_1 = var_0.getNextValidIndex(var_17_0)
		local var_17_3

		if 0 < var_17_1 then
			local var_17_2 = arg_10_0

			var_17_3 = var_17_3.emit
			LevelMediator2 = var_2_10005
			var_2_10005 = var_2_10005.ON_OP

			local var_17_4 = {}

			ChapterConst = var_2_10007
			var_17_4.type = var_2_10007.OpSwitch
			var_17_4.id = var_0.fleets[var_17_1].id

			var_17_3(var_17_2, var_2_10005, var_17_4)
		else
			pg = var_17_3

			local var_17_5 = var_17_3.TipsMgr.GetInstance()
			local var_17_6 = var_2.ShowTips

			i18n = var_2_10005

			var_17_6(var_17_5, var_2_10005("formation_switch_failed"))
		end

		return
	end

	SFX_PANEL = var_10_11

	var_10_5(var_10_17, var_10_18, var_10_19, var_10_11)

	onButton = var_10_5

	local var_10_20 = arg_10_0
	local var_10_21 = arg_10_0.autoBattleBtn

	local function var_10_22()
		getProxy = var_2_10000
		ChapterProxy = var_2_10002

		local var_18_0 = var_2_10000(var_2_10002)
		local var_18_1 = var_0.GetSkipPrecombat(var_18_0)

		var_0:UpdateSkipPrecombat(not var_18_1)

		return
	end

	SFX_PANEL = var_10_11

	var_10_5(var_10_20, var_10_21, var_10_22, var_10_11)

	onButton = var_10_5

	local var_10_23 = arg_10_0
	local var_10_24 = arg_10_0.showDetailBtn

	local function var_10_25()
		arg_10_0._showStrategyDetail = not arg_10_0._showStrategyDetail and true

		local var_19_0 = arg_10_0

		var_0.updateStageStrategy(var_19_0)

		return
	end

	SFX_PANEL = var_10_11

	var_10_5(var_10_23, var_10_24, var_10_25, var_10_11)

	onButton = var_10_5

	local var_10_26 = arg_10_0
	local var_10_27 = arg_10_0.funcBtn

	local function var_10_28()
		local var_20_0 = arg_10_0.contextData.chapterVO

		if not var_0.inWartime(var_20_0) then
			pg = var_1

			local var_20_1 = var_1.TipsMgr.GetInstance()
			local var_20_2 = var_1.ShowTips

			i18n = var_2_10004

			var_20_2(var_20_1, var_2_10004("levelScene_time_out"))

			return
		end

		local var_20_3 = var_0.fleet.line
		local var_20_4 = var_0:getChapterCell(var_20_3.row, var_20_3.column)
		local var_20_5 = false

		local function var_20_6(arg_21_0)
			local var_21_0 = arg_21_0.attachmentId

			pg = var_3_10002

			return var_3_10002.expedition_data_template[var_21_0].dungeon_id > 0
		end

		local var_20_8, var_20_9

		if var_0:existVisibleChampion(var_20_3.row, var_20_3.column) then
			var_20_5 = true

			local var_20_7 = var_0:getChampion(var_20_3.row, var_20_3.column)

			chapter_skip_battle = var_20_9

			local var_20_10

			if var_20_9 == 1 then
				pg = var_20_9
				var_20_8 = var_20_9.SdkMgr.GetInstance()

				if var_20_9.CheckPretest(var_20_8) then
					var_20_8 = arg_10_0
					var_20_9 = var_20_9.emit
					LevelMediator2 = var_20_10
					var_20_10 = var_20_10.ON_OP
					var_2_10011 = {}
					ChapterConst = var_2_10012
					var_2_10011.type = var_2_10012.OpSkipBattle
					var_2_10011.id = var_1.id

					var_20_9(var_20_8, var_20_10, var_2_10011)

					goto label_20_0
				end
			end

			if not var_20_6(var_20_7) then
				var_20_8 = arg_10_0
				var_20_9 = var_20_9.emit
				LevelMediator2 = var_20_10
				var_20_10 = var_20_10.ON_OP
				var_2_10011 = {}
				ChapterConst = var_2_10012
				var_2_10011.type = var_2_10012.OpPreClear
				var_2_10011.id = var_1.id

				var_20_9(var_20_8, var_20_10, var_2_10011)
			else
				var_20_8 = var_0

				if var_0.IsSkipPrecombat(var_20_8) then
					var_20_8 = arg_10_0
					var_20_9 = var_20_9.emit
					LevelMediator2 = var_20_10

					var_20_9(var_20_8, var_20_10.ON_START)
				else
					var_20_8 = arg_10_0
					var_20_9 = var_20_9.emit
					LevelMediator2 = var_20_10

					var_20_9(var_20_8, var_20_10.ON_STAGE)
				end
			end
		else
			local var_20_11 = var_20_4.attachment

			ChapterConst = var_20_9

			if var_20_11 == var_20_9.AttachAmbush then
				var_20_11 = var_20_4.flag
				ChapterConst = var_20_9

				if var_20_11 == var_20_9.CellFlagAmbush then
					var_20_11 = nil
					coroutine = var_20_9

					var_20_9.wrap(function()
						local var_22_0 = arg_10_0
						local var_22_1 = var_0.emit

						LevelUIConst = var_3_10003

						var_22_1(var_22_0, var_3_10003.DO_AMBUSH_WARNING, var_20_11)

						coroutine = var_22_1

						var_22_1.yield()

						local var_22_2 = arg_10_0
						local var_22_3 = var_0.emit

						LevelUIConst = var_3

						var_22_3(var_22_2, var_3.DISPLAY_AMBUSH_INFO, var_20_11)

						coroutine = var_22_3

						var_22_3.yield()

						return
					end)()

					var_20_5 = true

					goto label_20_0
				end
			end

			ChapterConst = var_20_11

			if var_20_11.IsEnemyAttach(var_20_4.attachment) then
				local var_20_12 = var_20_4.flag

				ChapterConst = var_20_9

				if var_20_12 == var_20_9.CellFlagActive then
					var_20_5 = true
					chapter_skip_battle = var_20_12

					if var_20_12 == 1 then
						pg = var_20_12

						local var_20_13 = var_20_12.SdkMgr.GetInstance()

						if var_6.CheckPretest(var_20_13) then
							local var_20_14 = arg_10_0
							local var_20_15 = var_6.emit

							LevelMediator2 = var_20_8
							var_20_8 = var_20_8.ON_OP

							local var_20_16 = {}

							ChapterConst = var_2_10011
							var_20_16.type = var_2_10011.OpSkipBattle
							var_20_16.id = var_1.id

							var_20_15(var_20_14, var_20_8, var_20_16)

							goto label_20_0
						end
					end

					if not var_20_6(var_20_4) then
						local var_20_17 = arg_10_0
						local var_20_18 = var_6.emit

						LevelMediator2 = var_20_8
						var_20_8 = var_20_8.ON_OP

						local var_20_19 = {}

						ChapterConst = var_2_10011
						var_20_19.type = var_2_10011.OpPreClear
						var_20_19.id = var_1.id

						var_20_18(var_20_17, var_20_8, var_20_19)
					elseif var_0:IsSkipPrecombat() then
						local var_20_20 = arg_10_0
						local var_20_21 = var_6.emit

						LevelMediator2 = var_20_8

						var_20_21(var_20_20, var_20_8.ON_START)
					else
						local var_20_22 = arg_10_0
						local var_20_23 = var_6.emit

						LevelMediator2 = var_20_8

						var_20_23(var_20_22, var_20_8.ON_STAGE)
					end
				end
			else
				local var_20_24 = var_20_4.attachment

				ChapterConst = var_20_9

				if var_20_24 == var_20_9.AttachBox then
					local var_20_25 = var_20_4.flag

					ChapterConst = var_20_9

					if var_20_25 == var_20_9.CellFlagActive then
						var_20_5 = true

						local var_20_26 = arg_10_0
						local var_20_27 = var_6.emit

						LevelMediator2 = var_20_8
						var_20_8 = var_20_8.ON_OP

						local var_20_28 = {}

						ChapterConst = var_2_10011
						var_20_28.type = var_2_10011.OpBox
						var_20_28.id = var_1.id

						var_20_27(var_20_26, var_20_8, var_20_28)
					end
				else
					local var_20_29 = var_20_4.attachment

					ChapterConst = var_20_9

					if var_20_29 == var_20_9.AttachSupply then
						local var_20_30 = var_20_4.attachmentId

						if 0 < var_20_30 then
							var_20_5 = true

							local var_20_31 = var_0
							local var_20_32

							var_20_32, var_20_9 = var_0.getFleetAmmo(var_20_31, var_0.fleet)

							if var_20_9 < var_20_32 then
								local var_20_33 = arg_10_0

								var_20_31 = var_20_31.emit
								LevelMediator2 = var_2_10011
								var_2_10011 = var_2_10011.ON_OP

								local var_20_34 = {}

								ChapterConst = var_2_10013
								var_20_34.type = var_2_10013.OpSupply
								var_20_34.id = var_1.id

								var_20_31(var_20_33, var_2_10011, var_20_34)
							else
								pg = var_20_31

								local var_20_35 = var_20_31.TipsMgr.GetInstance()
								local var_20_36 = var_8.ShowTips

								i18n = var_2_10011

								var_20_36(var_20_35, var_2_10011("level_ammo_enough"))
							end

							goto label_20_0
						end
					end

					local var_20_37 = var_20_4.attachment

					ChapterConst = var_20_9

					if var_20_37 == var_20_9.AttachStory then
						var_20_5 = true
						pg = var_20_37

						local var_20_38 = var_20_37.map_event_template[var_20_4.attachmentId].memory

						pg = var_20_9
						var_20_9 = var_20_9.map_event_template[var_20_4.attachmentId].gametip

						if var_20_38 == 0 then
							return
						end

						pg = var_8

						local var_20_39 = var_8.NewStoryMgr.GetInstance()
						local var_20_40 = var_8.StoryId2StoryName(var_20_39, var_20_38)

						pg = var_20_8
						var_2_10011 = var_20_8.ConnectionMgr.GetInstance()

						var_20_8.Send(var_2_10011, 11017, {
							story_id = var_20_38
						}, 11018, function(arg_23_0)
							return
						end)

						pg = var_20_8
						var_2_10011 = var_20_8.NewStoryMgr.GetInstance()

						var_20_8.Play(var_2_10011, var_20_40, function(arg_24_0, arg_24_1)
							local var_24_0 = arg_24_1 or 1
							local var_24_1 = var_20_4.flag

							ChapterConst = var_3_10005

							if var_24_1 == var_3_10005.CellFlagActive then
								local var_24_2 = arg_10_0
								local var_24_3 = var_4.emit

								LevelMediator2 = var_3_10007
								var_3_10007 = var_3_10007.ON_OP

								local var_24_4 = {}

								ChapterConst = var_3_10009
								var_24_4.type = var_3_10009.OpStory
								var_24_4.id = var_0.id
								var_24_4.arg1 = var_24_0

								var_24_3(var_24_2, var_3_10007, var_24_4)
							end

							if var_20_9 ~= "" then
								local var_24_5

								ipairs = var_5
								pg = var_3_10007

								for iter_24_0, iter_24_1 in var_5(var_3_10007.memory_template.all) do
									pg = var_3_10010
									var_3_10010 = var_3_10010.memory_template[iter_24_1]
									table = var_3_10011

									if var_3_10011.contains(var_3_10010.unlock_pre, var_20_40) then
										var_24_5 = var_3_10010.title
									end
								end

								pg = var_5

								local var_24_6 = var_5.TipsMgr.GetInstance()
								local var_24_7 = var_5.ShowTips

								i18n = iter_24_0

								var_24_7(var_24_6, iter_24_0(var_20_9, var_24_5))
							end

							return
						end)
					end
				end
			end
		end

		::label_20_0::

		if not var_20_5 then
			local var_20_41 = var_0:getRound()

			ChapterConst = var_20_9

			if var_20_41 == var_20_9.RoundEnemy then
				local var_20_42 = arg_10_0

				var_20_41 = var_20_41.emit
				LevelMediator2 = var_20_8
				var_20_8 = var_20_8.ON_OP

				local var_20_43 = {}

				ChapterConst = var_2_10011
				var_20_43.type = var_2_10011.OpEnemyRound

				var_20_41(var_20_42, var_20_8, var_20_43)
			else
				pg = var_20_41

				local var_20_44 = var_20_41.TipsMgr.GetInstance()
				local var_20_45 = var_6.ShowTips

				i18n = var_20_8

				var_20_45(var_20_44, var_20_8("level_click_to_move"))
			end
		end

		return
	end

	SFX_PANEL = var_10_11

	var_10_5(var_10_26, var_10_27, var_10_28, var_10_11)

	onButton = var_10_5

	local var_10_29 = arg_10_0
	local var_10_30 = arg_10_0.helpBtn

	local function var_10_31()
		if arg_10_0.contextData.chapterVO then
			if var_0:existOni() then
				local var_25_0 = arg_10_0
				local var_25_1 = var_1.HandleShowMsgBox

				var_2_10004 = {}
				MSGBOX_TYPE_HELP = iter_25_0
				var_2_10004.type = iter_25_0
				i18n = iter_25_0
				var_2_10004.helps = iter_25_0("levelScene_sphunt_help_tip")

				var_25_1(var_25_0, var_2_10004)
			elseif var_0:isTypeDefence() then
				local var_25_2 = arg_10_0
				local var_25_3 = var_1.HandleShowMsgBox

				var_2_10004 = {}
				MSGBOX_TYPE_HELP = iter_25_0
				var_2_10004.type = iter_25_0
				i18n = iter_25_0
				var_2_10004.helps = iter_25_0("help_battle_defense")

				var_25_3(var_25_2, var_2_10004)
			else
				local var_25_4 = var_0
				local var_25_5

				if var_0.isPlayingWithBombEnemy(var_25_4) then
					var_25_4 = arg_10_0
					var_25_5 = var_25_5.HandleShowMsgBox
					var_2_10004 = {}
					MSGBOX_TYPE_HELP = iter_25_0
					var_2_10004.type = iter_25_0
					i18n = iter_25_0
					var_2_10004.helps = iter_25_0("levelScene_bomb_help_tip")

					var_25_5(var_25_4, var_2_10004)
				else
					pg = var_25_5

					if var_25_5.map_event_list[var_0.id] then
						next = var_1
						noEmptyStr = var_25_4
						pg = iter_25_0

						local var_25_6

						if not var_25_4(iter_25_0.map_event_list[var_0.id].help_pictures) then
							var_25_6 = {}
						end

						if var_1(var_25_6) then
							local var_25_7 = {
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

							pairs = var_2
							pg = var_2_10004

							for iter_25_0, iter_25_1 in var_2(var_2_10004.map_event_list[var_0.id].help_pictures) do
								table = var_2_10007

								var_2_10007.insert(var_25_7, {
									icon = {
										path = "",
										atlas = iter_25_1
									}
								})
							end

							local var_25_8 = arg_10_0
							local var_25_9 = var_2.HandleShowMsgBox

							iter_25_0 = {}
							MSGBOX_TYPE_HELP = iter_25_1
							iter_25_0.type = iter_25_1
							iter_25_0.helps = var_25_7

							var_25_9(var_25_8, iter_25_0)

							goto label_25_0
						end
					end

					local var_25_10 = arg_10_0
					local var_25_11 = var_1.HandleShowMsgBox
					local var_25_12 = {}

					MSGBOX_TYPE_HELP = iter_25_0
					var_25_12.type = iter_25_0
					pg = iter_25_0
					var_25_12.helps = iter_25_0.gametip.help_level_ui.tip

					var_25_11(var_25_10, var_25_12)
				end
			end
		end

		::label_25_0::

		return
	end

	SFX_PANEL = var_10_11

	var_10_5(var_10_29, var_10_30, var_10_31, var_10_11)

	onButton = var_10_5

	local var_10_32 = arg_10_0
	local var_10_33 = arg_10_0.airSupremacy

	local function var_10_34()
		pg = var_2_10000

		local var_26_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_26_1 = var_0.ShowMsgBox
		local var_26_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_26_2.type = var_2_10004
		i18n = var_2_10004
		var_26_2.helps = var_2_10004("help_battle_ac")

		var_26_1(var_26_0, var_26_2)

		return
	end

	SFX_UI_CLICK = var_10_11

	var_10_5(var_10_32, var_10_33, var_10_34, var_10_11)

	onButton = var_10_5

	var_10_5(arg_10_0, arg_10_0.shengfuBtn, function()
		local var_27_0 = arg_10_0

		var_0.DisplayWinConditionPanel(var_27_0)

		return
	end)

	return
end

function var_0_1.SetSeriesOperation(arg_28_0, arg_28_1)
	arg_28_0.seriesOperation = arg_28_1

	return
end

function var_0_1.SetGrid(arg_29_0, arg_29_1)
	arg_29_0.grid = arg_29_1

	return
end

function var_0_1.SetPlayer(arg_30_0, arg_30_1)
	return
end

function var_0_1.SwitchToChapter(arg_31_0, arg_31_1)
	findTF = var_1_10002

	local var_31_0 = var_1_10002(arg_31_0.topStage, "msg_panel/ambush")

	findTF = var_1_10003

	local var_31_1 = var_1_10003(arg_31_0.rightStage, "target")

	findTF = var_4

	local var_31_2 = var_4(arg_31_0.rightStage, "skip_events")

	setActive = var_5

	var_5(var_31_0, arg_31_1:existAmbush())

	setActive = var_5

	local var_31_3 = arg_31_0.airSupremacy

	OPEN_AIR_DOMINANCE = var_31_4

	local var_31_4 = var_31_4 and arg_31_1:getConfig("air_dominance") > 0

	var_5(var_31_3, var_31_4)

	local var_31_5 = arg_31_1:isLoop()

	setActive = var_6

	var_6(arg_31_0.autoBattleBtn, var_31_5)

	if var_31_5 then
		arg_31_0:UpdateSkipPreCombatMark()
		arg_31_0:UpdateAutoFightPanel()
		arg_31_0:UpdateAutoFightMark()
	end

	arg_31_0.achieveOriginalY = -240
	setText = var_6

	local var_31_6 = var_31_2:Find("Label")

	i18n = var_9

	var_6(var_31_6, var_9("map_event_skip"))

	local var_31_7 = "skip_events_on_" .. arg_31_1.id

	if arg_31_1:getConfig("event_skip") == 1 then
		local var_31_8 = arg_31_1.progress

		if not (0 < var_31_8) then
			var_31_8 = arg_31_1.defeatCount

			if not (0 < var_31_8) then
				var_31_8 = arg_31_1.passCount

				if 0 < var_31_8 then
					setActive = var_31_8

					var_31_8(var_31_2, true)

					Vector2 = var_31_8
					var_31_1.anchoredPosition = var_31_8.New(var_31_1.anchoredPosition.x, arg_31_0.achieveOriginalY - 40)
					GetComponent = var_31_8

					local var_31_9 = var_31_2

					typeof = var_10
					Toggle = var_1_10012
					var_31_8 = var_31_8(var_31_9, var_10(var_1_10012))
					PlayerPrefs = var_8
					var_31_8.isOn = var_8.GetInt(var_31_7, 1) == 1
					onToggle = var_31_8

					var_31_8(arg_31_0, var_31_2, function(arg_32_0)
						PlayerPrefs = var_2_10001

						var_2_10001.SetInt(var_31_7, arg_32_0 and 1 or 0)

						return
					end)
				else
					setActive = var_31_8

					var_31_8(var_31_2, false)

					PlayerPrefs = var_31_8

					if not var_31_8.HasKey(var_31_7) then
						PlayerPrefs = var_31_8

						var_31_8.SetInt(var_31_7, 0)
					end
				end

				goto label_31_0

				setActive = var_31_8

				var_31_8(var_31_2, false)

				Vector2 = var_31_8
				var_31_1.anchoredPosition = var_31_8.New(var_31_1.anchoredPosition.x, arg_31_0.achieveOriginalY)

				::label_31_0::

				setActive = var_31_8

				var_31_8(var_31_1, arg_31_1:existAchieve())

				setActive = var_31_8

				var_31_8(arg_31_0.retreatBtn, true)
				arg_31_0.seriesOperation()

				return
			end
		end
	end
end

function var_0_1.SwitchToMap(arg_33_0)
	arg_33_0:DestroyAutoFightPanel()

	return
end

function var_0_1.UpdateSkipPreCombatMark(arg_34_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10003

	local var_34_0 = var_1_10001(var_1_10003)
	local var_34_1 = var_1.GetSkipPrecombat(var_34_0) and "auto_battle_on" or "auto_battle_off"
	local var_34_2 = arg_34_0.loader

	var_3.GetOffSpriteRequest(var_34_2, arg_34_0.autoBattleBtn)

	local var_34_3 = arg_34_0.loader

	var_3.GetSprite(var_34_3, "ui/levelstageview_atlas", var_34_1, arg_34_0.autoBattleBtn, true)

	return
end

function var_0_1.updateStageInfo(arg_35_0)
	local var_35_0 = arg_35_0.contextData.chapterVO

	findTF = var_1_10002

	local var_35_1 = var_1_10002(arg_35_0.topStage, "timer")

	findTF = var_1_10003

	local var_35_2 = var_1_10003(arg_35_0.topStage, "unlimit")

	setWidgetText = var_4

	var_4(var_35_1, "--:--:--")

	if arg_35_0.stageTimer then
		local var_35_3 = arg_35_0.stageTimer

		var_4.Stop(var_35_3)
	end

	if var_35_0:getRemainTime() > var_35_0:getConfig("time") or var_35_0:getConfig("time") >= 0 then
		setActive = var_4

		var_4(var_35_1, false)

		setActive = var_4

		var_4(var_35_2, true)
	else
		setActive = var_4

		var_4(var_35_1, true)

		setActive = var_4

		var_4(var_35_2, false)

		Timer = var_4
		arg_35_0.stageTimer = var_4.New(function()
			IsNil = var_2_10000

			if var_2_10000(var_35_1) then
				return
			end

			local var_36_0 = var_35_0
			local var_36_1 = var_0.getRemainTime(var_36_0)

			setWidgetText = var_2_10001

			local var_36_2 = var_35_1

			pg = var_2_10004

			local var_36_3 = var_2_10004.TimeMgr.GetInstance()

			var_2_10001(var_36_2, var_4.DescCDTime(var_36_3, var_36_1))

			return
		end, 1, -1)

		local var_35_4 = arg_35_0.stageTimer

		var_4.Start(var_35_4)
		arg_35_0.stageTimer.func()
	end

	return
end

function var_0_1.updateAmbushRate(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0.contextData.chapterVO

	if not var_3.existAmbush(var_37_0) then
		return
	end

	local var_37_1 = var_3.fleet
	local var_37_2 = var_4.getInvestSums(var_37_1)

	findTF = var_37_0

	local var_37_3 = var_37_0(arg_37_0.topStage, "msg_panel/ambush/label1")

	findTF = var_37_1

	local var_37_4 = var_37_1(arg_37_0.topStage, "msg_panel/ambush/label2")

	findTF = var_8

	local var_37_5 = var_8(arg_37_0.topStage, "msg_panel/ambush/value1")

	findTF = var_9

	local var_37_6 = var_9(arg_37_0.topStage, "msg_panel/ambush/value2")

	setText = var_10

	local var_37_7 = var_37_3

	i18n = var_1_10013

	var_10(var_37_7, var_1_10013("level_scene_title_word_1"))

	setText = var_10

	local var_37_8 = var_37_5

	math = var_13

	var_10(var_37_8, var_13.floor(var_37_2))

	setText = var_10

	local var_37_9 = var_37_4

	i18n = var_13

	var_10(var_37_9, var_13("level_scene_title_word_2"))

	if not var_3.activateAmbush then
		setText = var_10

		local var_37_10 = var_37_6

		i18n = var_13

		var_10(var_37_10, var_13("ambush_display_none"))

		setTextColor = var_10

		local var_37_11 = var_37_6

		Color = var_13

		var_10(var_37_11, var_13.New(0.4, 0.4, 0.4))

		goto label_37_0
	end

	local var_37_12 = var_3:getAmbushRate(var_4, arg_37_1)

	ChapterConst = var_11

	local var_37_13 = var_11.GetAmbushDisplay

	if arg_37_2 then
		do
			local var_37_14 = var_3
			local var_37_15 = var_3.existEnemy

			ChapterConst = var_1_10016

			local var_37_16

			if not var_37_15(var_37_14, var_1_10016.SubjectPlayer, arg_37_1.row, arg_37_1.column) then
				var_37_16 = var_37_12
			else
				var_37_16 = false
			end

			if false then
				var_37_16 = true
			end

			local var_37_17, var_37_18 = var_37_13(var_37_16)

			setText = var_37_16

			var_37_16(var_37_6, var_37_17)

			setTextColor = var_37_16

			var_37_16(var_37_6, var_37_18)
		end

		::label_37_0::

		return
	end
end

function var_0_1.updateStageAchieve(arg_38_0)
	local var_38_0 = arg_38_0.contextData.chapterVO

	if not var_1.existAchieve(var_38_0) then
		return
	end

	local var_38_1 = var_1.achieves

	findTF = var_1_10003

	local var_38_2 = var_1_10003(arg_38_0.rightStage, "target")

	setActive = var_38_0

	var_38_0(var_38_2, true)

	findTF = var_38_0

	local var_38_3 = var_38_0(var_38_2, "detail")

	findTF = var_5

	local var_38_4 = var_5(var_38_3, "achieve")

	findTF = var_6

	local var_38_5 = var_6(var_38_3, "achieves")

	findTF = var_7

	local var_38_6 = var_7(var_38_3, "click")

	findTF = var_8

	local var_38_7 = var_8(var_38_2, "collapse")

	findTF = var_9

	local var_38_8 = var_9(var_38_7, "star")

	findTF = var_10

	local var_38_9 = var_10(var_38_7, "stars")

	setActive = var_11

	var_11(var_38_4, false)

	setActive = var_11

	var_11(var_38_8, false)

	removeAllChildren = var_11

	var_11(var_38_5)

	removeAllChildren = var_11

	var_11(var_38_9)

	ipairs = var_11

	for iter_38_0, iter_38_1 in var_11(var_38_1) do
		cloneTplTo = var_1_10016
		var_1_10016 = var_1_10016(var_38_4, var_38_5)
		ChapterConst = var_1_10017
		var_1_10017 = var_1_10017.IsAchieved(iter_38_1)
		setActive = var_18
		findTF = var_1_10020

		var_18(var_1_10020(var_1_10016, "star"), var_1_10017)

		findTF = var_18

		local var_38_10 = var_18(var_1_10016, "desc")

		setText = var_19

		local var_38_11 = var_38_10

		ChapterConst = var_22

		var_19(var_38_11, var_22.GetAchieveDesc(iter_38_1.type, var_1))

		setTextColor = var_19

		local var_38_12 = var_38_10

		if var_1_10017 then
			Color = var_38_13

			local var_38_13

			if not var_38_13.yellow then
				Color = var_38_13
				var_38_13 = var_38_13.white
			end

			var_19(var_38_12, var_38_13)

			cloneTplTo = var_19

			local var_38_14 = var_19(var_38_8, var_38_9)

			var_1_10020 = var_19.GetComponent
			typeof = var_23
			Image = var_25
			var_1_10020 = var_1_10020(var_38_14, var_23(var_25))
			var_1_10020.enabled = var_1_10017
		end
	end

	onButton = var_11

	local var_38_15 = arg_38_0
	local var_38_16 = var_38_6

	local function var_38_17()
		shiftPanel = var_2_10000

		local var_39_0 = var_38_3
		local var_39_1 = var_38_3.rect.width + 200
		local var_39_2
		local var_39_3 = 0.3
		local var_39_4 = 0
		local var_39_5 = true
		local var_39_6

		LeanTweenType = var_2_10009

		var_2_10000(var_39_0, var_39_1, var_39_2, var_39_3, var_39_4, var_39_5, var_39_6, var_2_10009.easeOutSine)

		shiftPanel = var_2_10000

		local var_39_7 = var_38_7
		local var_39_8 = 0
		local var_39_9
		local var_39_10 = 0.3
		local var_39_11 = 0
		local var_39_12 = true
		local var_39_13

		LeanTweenType = var_9

		var_2_10000(var_39_7, var_39_8, var_39_9, var_39_10, var_39_11, var_39_12, var_39_13, var_9.easeOutSine)

		return
	end

	SFX_PANEL = var_1_10016

	var_11(var_38_15, var_38_16, var_38_17, var_1_10016)

	onButton = var_11

	local var_38_18 = arg_38_0
	local var_38_19 = var_38_7

	local function var_38_20()
		shiftPanel = var_2_10000

		local var_40_0 = var_38_3
		local var_40_1 = 30
		local var_40_2
		local var_40_3 = 0.3
		local var_40_4 = 0
		local var_40_5 = true
		local var_40_6

		LeanTweenType = var_2_10009

		var_2_10000(var_40_0, var_40_1, var_40_2, var_40_3, var_40_4, var_40_5, var_40_6, var_2_10009.easeOutSine)

		shiftPanel = var_2_10000

		local var_40_7 = var_38_7
		local var_40_8 = var_38_7.rect.width + 200
		local var_40_9
		local var_40_10 = 0.3
		local var_40_11 = 0
		local var_40_12 = true
		local var_40_13

		LeanTweenType = var_9

		var_2_10000(var_40_7, var_40_8, var_40_9, var_40_10, var_40_11, var_40_12, var_40_13, var_9.easeOutSine)

		return
	end

	SFX_PANEL = var_1_10016

	var_11(var_38_18, var_38_19, var_38_20, var_1_10016)

	if not arg_38_0.isAchieveFirstInit then
		arg_38_0.isAchieveFirstInit = true
		triggerButton = var_11

		var_11(var_38_6)
	end

	return
end

function var_0_1.updateStageBarrier(arg_41_0)
	local var_41_0 = arg_41_0.contextData.chapterVO

	setActive = var_1_10002

	var_1_10002(arg_41_0.panelBarrier, var_41_0:existOni())

	if not var_41_0:existOni() then
		return
	end

	local var_41_1 = arg_41_0.panelBarrier
	local var_41_2 = var_2.Find(var_41_1, "btn_barrier")

	setText = var_1_10003

	var_1_10003(var_41_2:Find("nums"), var_41_0.modelCount)

	onButton = var_1_10003

	local var_41_3 = arg_41_0
	local var_41_4 = var_41_2

	local function var_41_5()
		local var_42_0 = arg_41_0.grid.quadState

		ChapterConst = var_2_10001

		if var_42_0 == var_2_10001.QuadStateBarrierSetting then
			local var_42_1 = arg_41_0.grid
			local var_42_2 = var_0.updateQuadCells

			ChapterConst = var_2_10003

			var_42_2(var_42_1, var_2_10003.QuadStateNormal)

			return
		end

		local var_42_3 = arg_41_0.grid
		local var_42_4 = var_0.updateQuadCells

		ChapterConst = var_2_10003

		var_42_4(var_42_3, var_2_10003.QuadStateBarrierSetting)

		return
	end

	SFX_PANEL = var_8

	var_1_10003(var_41_3, var_41_4, var_41_5, var_8)

	return
end

function var_0_1.updateBombPanel(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0.contextData.chapterVO

	setActive = var_1_10003

	var_1_10003(arg_43_0.bombPanel, var_43_0:isPlayingWithBombEnemy())

	if var_43_0:isPlayingWithBombEnemy() then
		setText = var_3

		local var_43_1 = arg_43_0.bombPanel
		local var_43_2 = var_5.Find(var_43_1, "tx_step")
		local var_43_3 = var_43_0:getBombChapterInfo().action_times

		math = var_43_1

		var_3(var_43_2, var_43_3 - var_43_1.floor(var_43_0.roundIndex / 2))

		local var_43_4 = arg_43_0.bombPanel
		local var_43_5 = var_3.Find(var_43_4, "tx_score")

		tonumber = var_1_10004
		getText = var_6

		local var_43_6 = var_1_10004(var_6(var_43_5))
		local var_43_7 = var_43_0.modelCount

		LeanTween = var_6

		local var_43_8 = var_6.cancel

		go = var_8

		var_43_8(var_8(var_43_5))

		if arg_43_1 and var_43_6 ~= var_43_7 then
			LeanTween = var_43_8
			var_43_8 = var_43_8.scale
			go = var_8

			local var_43_9 = var_8(var_43_5)

			Vector3 = var_9

			var_43_8(var_43_9, var_9(1.5, 1.5, 1), 0.2)

			var_43_8 = (var_43_7 - var_43_6) * 0.1
			LeanTween = var_7

			local var_43_10 = var_7.value

			go = var_9

			local var_43_11 = var_43_10(var_9(var_43_5), var_43_6, var_43_7, var_43_8)
			local var_43_12 = var_7.setOnUpdate

			System = var_10

			local var_43_13 = var_43_12(var_43_11, var_10.Action_float(function(arg_44_0)
				setText = var_2_10001

				local var_44_0 = var_43_5

				math = var_2_10004

				var_2_10001(var_44_0, var_2_10004.floor(arg_44_0))

				return
			end))
			local var_43_14 = var_7.setOnComplete

			System = var_10

			local var_43_15 = var_43_14(var_43_13, var_10.Action(function()
				setText = var_2_10000

				var_2_10000(var_43_5, var_43_7)

				return
			end))
			local var_43_16 = var_7.setEase

			LeanTweenType = var_10

			local var_43_17 = var_43_16(var_43_15, var_10.easeInOutSine)

			var_7.setDelay(var_43_17, 0.2)

			LeanTween = var_7

			local var_43_18 = var_7.scale

			go = var_43_17

			local var_43_19 = var_43_17(var_43_5)

			Vector3 = var_10

			local var_43_20 = var_43_18(var_43_19, var_10.one, 0.3)

			var_7.setDelay(var_43_20, 1 + var_43_8)
		else
			Vector3 = var_43_8
			var_43_5.localScale = var_43_8.one
			setText = var_6

			var_6(var_43_5, var_43_7)
		end
	end

	return
end

function var_0_1.updateFleetBuff(arg_46_0)
	local var_46_0 = arg_46_0.contextData.chapterVO.fleet
	local var_46_1 = var_1:GetShowingStrategies()

	if var_1:getChapterSupportFleet() then
		var_1_10007 = var_1

		if not var_1.IsSupportSubmarineStage(var_1_10007) then
			table = var_5

			local var_46_2 = var_5.insert

			var_1_10007 = var_46_1
			ChapterConst = var_1_10008

			var_46_2(var_1_10007, var_1_10008.StrategyAirSupportFriendly)
		end
	end

	local var_46_3 = {}

	if var_1:GetSubmarineFleet() then
		_ = var_1_10007

		if var_1_10007.filter(var_6:getStrategies(), function(arg_47_0)
			pg = var_2_10001

			local var_47_0 = var_2_10001.strategy_data_template[arg_47_0.id].type

			ChapterConst = var_2_10003

			return var_47_0 == var_2_10003.StgTypePassive and arg_47_0.count > 0
		end) and #var_1_10007 > 0 then
			_ = var_8

			var_8.each(var_1_10007, function(arg_48_0)
				table = var_2_10001

				var_2_10001.insert(var_46_3, {
					id = arg_48_0.id,
					count = arg_48_0.count
				})

				return
			end)
		end
	end

	underscore = var_1_10007

	local var_46_4 = var_1_10007.filter(var_1:GetWeather(), function(arg_49_0)
		pg = var_2_10001

		local var_49_0 = var_2_10001.weather_data_template[arg_49_0]

		noEmptyStr = var_2_10002

		return var_2_10002(var_49_0.buff_icon)
	end)
	local var_46_5 = 0
	local var_46_6 = var_1

	if var_1.ExistDivingChampion(var_46_6) then
		var_46_5 = 1
	end

	_ = var_9

	local var_46_7 = var_9.map

	_ = var_46_6

	local var_46_8 = var_46_7(var_46_6.values(var_46_0:getCommanders()), function(arg_50_0)
		return arg_50_0:getSkills()[1]
	end)

	findTF = var_10

	local var_46_9 = var_10(arg_46_0.topStage, "icon_list/fleet_buffs")

	UIItemList = var_11

	local var_46_10 = var_11.New(var_46_9, var_46_9:GetChild(0))

	var_11.make(var_46_10, function(arg_51_0, arg_51_1, arg_51_2)
		setActive = var_2_10003
		findTF = var_2_10005

		var_2_10003(var_2_10005(arg_51_2, "frame"), false)

		setActive = var_2_10003
		findTF = var_5

		var_2_10003(var_5(arg_51_2, "Text"), false)

		setActive = var_2_10003
		findTF = var_5

		var_2_10003(var_5(arg_51_2, "times"), false)

		UIItemList = var_2_10003

		if arg_51_0 == var_2_10003.EventUpdate then
			GetComponent = var_3

			local var_51_0 = arg_51_2

			typeof = var_6
			LayoutElement = var_8

			local var_51_1 = var_3(var_51_0, var_6(var_8))

			var_51_1.preferredWidth = 64
			var_51_1.preferredHeight = 64

			if arg_51_1 + 1 <= #var_46_1 then
				local var_51_2 = var_46_1[arg_51_1 + 1]

				pg = var_5

				local var_51_3 = var_5.strategy_data_template[var_51_2]

				GetImageSpriteFromAtlasAsync = var_6

				var_6("strategyicon/" .. var_51_3.icon, "", arg_51_2)

				local var_51_4
				local var_51_5 = var_51_3.type

				ChapterConst = var_8

				if var_51_5 == var_8.StgTypeBindFleetPassive then
					var_2_10009 = var_46_0
					var_51_4 = var_7.GetStrategyCount(var_2_10009, var_51_2)
					setActive = var_7
					findTF = var_2_10009

					var_7(var_2_10009(arg_51_2, "times"), true)

					setText = var_7
					findTF = var_2_10009

					var_7(var_2_10009(arg_51_2, "times"), var_51_4)
				end

				if var_51_3.iconSize ~= "" then
					var_51_1.preferredWidth = var_7[1]
					var_51_1.preferredHeight = var_7[2]
				end

				onButton = var_8
				var_2_10010 = arg_46_0

				local var_51_6 = arg_51_2

				local function var_51_7()
					local var_52_0 = arg_46_0
					local var_52_1 = var_0.HandleShowMsgBox
					local var_52_2 = {
						yesText = "text_confirm",
						hideNo = true,
						content = ""
					}

					MSGBOX_TYPE_SINGLE_ITEM = var_3_10004
					var_52_2.type = var_3_10004

					local var_52_3 = {}

					DROP_TYPE_STRATEGY = var_3_10005
					var_52_3.type = var_3_10005
					var_52_3.id = var_51_3.id
					var_52_3.cfg = var_51_3
					var_52_3.count = var_51_4
					var_52_2.drop = var_52_3

					var_52_1(var_52_0, var_52_2)

					return
				end

				SFX_PANEL = var_2_10013

				var_8(var_2_10010, var_51_6, var_51_7, var_2_10013)

				return
			end

			if arg_51_1 - #var_46_1 + 1 <= #var_46_4 then
				pg = var_4

				local var_51_8 = var_4.weather_data_template[var_46_4[arg_51_1 + 1]]

				GetImageSpriteFromAtlasAsync = var_5

				var_5("strategyicon/" .. var_51_8.buff_icon, "", arg_51_2)

				onButton = var_5

				local var_51_9 = arg_46_0
				local var_51_10 = arg_51_2

				function var_2_10009()
					local var_53_0 = arg_46_0
					local var_53_1 = var_0.HandleShowMsgBox
					local var_53_2 = {
						hideNo = true
					}

					MSGBOX_TYPE_DROP_ITEM = var_3_10004
					var_53_2.type = var_3_10004
					var_53_2.name = var_51_8.name
					var_53_2.content = var_51_8.buff_desc
					var_53_2.iconPath = {
						"strategyicon/" .. var_51_8.buff_icon
					}
					pg = var_4
					var_53_2.yesText = var_4.MsgboxMgr.TEXT_CONFIRM

					var_53_1(var_53_0, var_53_2)

					return
				end

				SFX_PANEL = var_2_10010

				var_5(var_51_9, var_51_10, var_2_10009, var_2_10010)

				return
			end

			if arg_51_1 - #var_46_4 + 1 <= #var_46_3 then
				local var_51_11 = var_46_3[arg_51_1 + 1]

				pg = var_5

				local var_51_12 = var_5.strategy_data_template[var_51_11.id]

				GetImageSpriteFromAtlasAsync = var_6

				var_6("strategyicon/" .. var_51_12.icon, "", arg_51_2)

				setActive = var_6
				findTF = var_8

				var_6(var_8(arg_51_2, "times"), true)

				setText = var_6
				findTF = var_8

				var_6(var_8(arg_51_2, "times"), var_51_11.count)

				onButton = var_6

				local var_51_13 = arg_46_0

				var_2_10009 = arg_51_2

				local function var_51_14()
					local var_54_0 = arg_46_0
					local var_54_1 = var_0.HandleShowMsgBox
					local var_54_2 = {
						yesText = "text_confirm",
						hideNo = true,
						content = ""
					}

					MSGBOX_TYPE_SINGLE_ITEM = var_3_10004
					var_54_2.type = var_3_10004

					local var_54_3 = {}

					DROP_TYPE_STRATEGY = var_3_10005
					var_54_3.type = var_3_10005
					var_54_3.id = var_51_12.id
					var_54_3.cfg = var_51_12
					var_54_2.drop = var_54_3
					string = var_54_3

					local var_54_4 = var_54_3.format

					i18n = var_3_10006
					var_54_2.extendDesc = var_54_4(var_3_10006("word_rest_times"), var_51_11.count)

					var_54_1(var_54_0, var_54_2)

					return
				end

				SFX_PANEL = var_11

				var_6(var_51_13, var_2_10009, var_51_14, var_11)

				return
			end

			if arg_51_1 - #var_46_3 + 1 <= var_46_5 then
				GetImageSpriteFromAtlasAsync = var_4

				var_4("strategyicon/submarine_approach", "", arg_51_2)

				onButton = var_4

				local var_51_15 = arg_46_0
				local var_51_16 = arg_51_2

				local function var_51_17()
					local var_55_0 = arg_46_0
					local var_55_1 = var_0.HandleShowMsgBox
					local var_55_2 = {
						yesText = "text_confirm",
						hideNo = true
					}

					MSGBOX_TYPE_DROP_ITEM = var_3_10004
					var_55_2.type = var_3_10004
					i18n = var_3_10004
					var_55_2.name = var_3_10004("submarine_approach")
					i18n = var_4
					var_55_2.content = var_4("submarine_approach_desc")
					var_55_2.iconPath = {
						"strategyicon/submarine_approach"
					}

					var_55_1(var_55_0, var_55_2)

					return
				end

				SFX_PANEL = var_2_10009

				var_4(var_51_15, var_51_16, var_51_17, var_2_10009)

				return
			end

			arg_51_1 = arg_51_1 - var_46_5

			local var_51_18 = var_46_8[arg_51_1 + 1]

			GetImageSpriteFromAtlasAsync = var_5

			var_5("commanderskillicon/" .. var_51_18:getConfig("icon"), "", arg_51_2)

			setText = var_5
			findTF = var_7

			var_5(var_7(arg_51_2, "Text"), "Lv." .. var_51_18:getConfig("lv"))

			setActive = var_5
			findTF = var_7

			var_5(var_7(arg_51_2, "Text"), true)

			setActive = var_5
			findTF = var_7

			var_5(var_7(arg_51_2, "frame"), true)

			onButton = var_5

			local var_51_19 = arg_46_0
			local var_51_20 = arg_51_2

			local function var_51_21()
				local var_56_0 = arg_46_0
				local var_56_1 = var_0.emit

				LevelMediator2 = var_3_10003

				var_56_1(var_56_0, var_3_10003.ON_COMMANDER_SKILL, var_51_18)

				return
			end

			SFX_PANEL = var_10

			var_5(var_51_19, var_51_20, var_51_21, var_10)
		end

		return
	end)
	var_11:align(#var_46_1 + #var_46_3 + #var_46_4 + var_46_5 + #var_46_8)

	OPEN_AIR_DOMINANCE = var_12

	if var_12 and var_1:getConfig("air_dominance") > 0 then
		arg_46_0:updateAirDominance()
	end

	arg_46_0:updateEnemyCount()
	arg_46_0:updateChapterBuff()

	return
end

function var_0_1.updateEnemyCount(arg_57_0)
	local var_57_0 = arg_57_0.contextData.chapterVO

	findTF = var_1_10002

	local var_57_1 = var_1_10002(arg_57_0.topStage, "icon_list/enemy_count")

	tobool = var_1_10003
	underscore = var_5

	local var_57_2 = var_1_10003(var_5.detect(var_57_0.achieves, function(arg_58_0)
		local var_58_0 = arg_58_0.type

		ChapterConst = var_2_10002

		if var_58_0 ~= var_2_10002.AchieveType3 then
			var_58_0 = arg_58_0.type
			ChapterConst = var_2

			local var_58_1

			if var_58_0 == var_2.AchieveType6 then
				ChapterConst = var_58_0
				var_58_1 = not var_58_0.IsAchieved(arg_58_0)
			else
				var_58_1 = false
			end

			if false then
				var_58_1 = true
			end

			return var_58_1
		end
	end))

	setActive = var_4

	var_4(var_57_1, var_57_2)

	if var_57_2 then
		local var_57_3 = var_57_0:getDisplayEnemyCount()

		setText = var_5

		var_5(var_57_1:Find("Text"), var_57_3)

		GetImageSpriteFromAtlasAsync = var_5

		var_5("enemycount", var_57_3 > 0 and "danger" or "safe", var_57_1)

		onButton = var_5

		local var_57_4 = arg_57_0
		local var_57_5 = var_57_1

		local function var_57_6()
			if var_57_3 > 0 then
				local var_59_0 = arg_57_0
				local var_59_1 = var_0.HandleShowMsgBox
				local var_59_2 = {
					hideNo = true
				}

				MSGBOX_TYPE_DROP_ITEM = var_2_10004
				var_59_2.type = var_2_10004
				i18n = var_2_10004
				var_59_2.name = var_2_10004("star_require_enemy_title")
				i18n = var_2_10004
				var_59_2.content = var_2_10004("star_require_enemy_text", var_57_3)
				var_59_2.iconPath = {
					"enemycount",
					"danger"
				}
				i18n = var_2_10004
				var_59_2.yesText = var_2_10004("star_require_enemy_check")

				function var_59_2.onYes()
					local var_60_0 = var_57_0
					local var_60_1 = var_0.getNearestEnemyCell(var_60_0)
					local var_60_2 = arg_57_0.grid

					var_1.focusOnCell(var_60_2, var_60_1)

					local var_60_3 = arg_57_0.grid

					if var_1.GetEnemyCellView(var_60_3, var_60_1) and var_1.TweenShining then
						var_1:TweenShining(2)
					end

					return
				end

				var_59_1(var_59_0, var_59_2)
			else
				local var_59_3 = arg_57_0
				local var_59_4 = var_0.HandleShowMsgBox
				local var_59_5 = {
					hideNo = true
				}

				MSGBOX_TYPE_DROP_ITEM = var_2_10004
				var_59_5.type = var_2_10004
				i18n = var_2_10004
				var_59_5.name = var_2_10004("star_require_enemy_title")
				i18n = var_4
				var_59_5.content = var_4("star_require_enemy_text", var_57_3)
				var_59_5.iconPath = {
					"enemycount",
					"safe"
				}

				var_59_4(var_59_3, var_59_5)
			end

			return
		end

		SFX_PANEL = var_10

		var_5(var_57_4, var_57_5, var_57_6, var_10)
	end

	return
end

function var_0_1.updateChapterBuff(arg_61_0)
	local var_61_0 = arg_61_0.contextData.chapterVO

	findTF = var_1_10002

	local var_61_1 = var_1_10002(arg_61_0.topStage, "icon_list/chapter_buff")
	local var_61_2 = var_61_0
	local var_61_3 = var_61_0.hasMitigation(var_61_2)

	SetActive = var_4

	var_4(var_61_1, var_61_3)

	if var_61_3 then
		local var_61_4 = var_61_0:getRiskLevel()

		GetImageSpriteFromAtlasAsync = var_61_2

		var_61_2("passstate", var_61_4 .. "_icon", var_61_1)

		onButton = var_61_2

		local var_61_5 = arg_61_0
		local var_61_6 = var_61_1

		local function var_61_7()
			local var_62_0 = var_61_0

			if not var_0.hasMitigation(var_62_0) then
				return
			end

			local var_62_1 = arg_61_0
			local var_62_2 = var_0.HandleShowMsgBox
			local var_62_3 = {
				hideNo = true
			}

			MSGBOX_TYPE_DROP_ITEM = var_2_10004
			var_62_3.type = var_2_10004

			local var_62_4 = var_61_0

			var_62_3.name = var_4.getChapterState(var_62_4)
			var_62_3.iconPath = {
				"passstate",
				var_61_4 .. "_icon"
			}
			i18n = var_4

			local var_62_5 = "level_risk_level_mitigation_rate"
			local var_62_6 = var_61_0
			local var_62_7 = var_7.getRemainPassCount(var_62_6)
			local var_62_8 = var_61_0

			var_62_3.content = var_4(var_62_5, var_62_7, var_8.getMitigationRate(var_62_8))

			var_62_2(var_62_1, var_62_3)

			return
		end

		SFX_PANEL = var_1_10010

		var_61_2(var_61_5, var_61_6, var_61_7, var_1_10010)
	end

	return
end

function var_0_1.updateAirDominance(arg_63_0)
	local var_63_0 = arg_63_0.contextData.chapterVO
	local var_63_1, var_63_2, var_63_3 = var_1.getAirDominanceValue(var_63_0)

	if not var_63_3 or var_63_3 ~= var_63_2 then
		local var_63_4 = arg_63_0.contextData.chapterVO

		var_4.setAirDominanceStatus(var_63_4, var_63_2)

		getProxy = var_4
		ChapterProxy = var_63_4

		local var_63_5 = var_4(var_63_4)

		var_4.updateChapter(var_63_5, arg_63_0.contextData.chapterVO)
	end

	arg_63_0.isChange = var_63_3 and (var_63_2 == 0 and 3 or var_63_2) - (var_63_3 == 0 and 3 or var_63_3)

	local var_63_6 = arg_63_0
	local var_63_7 = arg_63_0.updateAirDominanceTitle
	local var_63_8 = var_63_1
	local var_63_9 = var_63_2
	local var_63_10

	if not arg_63_0.isChange then
		var_63_10 = 0
	end

	var_63_7(var_63_6, var_63_8, var_63_9, var_63_10)

	return
end

function var_0_1.updateAirDominanceTitle(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	findTF = var_1_10004

	local var_64_0 = var_1_10004(arg_64_0.airSupremacy, "label1")

	findTF = var_1_10005

	local var_64_1 = var_1_10005(arg_64_0.airSupremacy, "label2")

	findTF = var_6

	local var_64_2 = var_6(arg_64_0.airSupremacy, "value1")

	findTF = var_7

	local var_64_3 = var_7(arg_64_0.airSupremacy, "value2")

	findTF = var_8

	local var_64_4 = var_8(arg_64_0.airSupremacy, "up")

	findTF = var_9

	local var_64_5 = var_9(arg_64_0.airSupremacy, "down")

	setText = var_64_9

	local var_64_6 = var_64_0

	i18n = var_1_10013

	var_64_9(var_64_6, var_1_10013("level_scene_title_word_3"))

	setText = var_64_9

	local var_64_7 = var_64_1

	i18n = var_13

	var_64_9(var_64_7, var_13("level_scene_title_word_4"))

	setText = var_64_9

	local var_64_8 = var_64_2

	math = var_13

	var_64_9(var_64_8, var_13.floor(arg_64_1))

	setActive = var_64_9

	var_64_9(var_64_4, false)

	setActive = var_64_9

	var_64_9(var_64_5, false)

	local var_64_9, var_64_12

	if arg_64_3 ~= 0 then
		LeanTween = var_64_9
		var_64_9 = var_64_9.isTweening
		go = var_12

		if var_64_9(var_12(var_64_3)) then
			LeanTween = var_64_9
			var_64_9 = var_64_9.cancel
			go = var_12

			var_64_9(var_12(var_64_3))
		end

		LeanTween = var_64_9
		var_64_9 = var_64_9.value
		go = var_12

		local var_64_10 = var_64_9(var_12(var_64_3), 1, 0, 0.5)

		var_64_9 = var_64_9.setOnUpdate
		System = var_64_12

		local var_64_11 = var_64_9(var_64_10, var_64_12.Action_float(function(arg_65_0)
			setTextAlpha = var_2_10001

			var_2_10001(var_64_3, arg_65_0)

			return
		end))

		var_64_9 = var_64_9.setOnComplete
		System = var_64_12

		var_64_9(var_64_11, var_64_12.Action(function()
			setText = var_2_10000

			local var_66_0 = var_64_3

			ChapterConst = var_2_10003

			var_2_10000(var_66_0, var_2_10003.AirDominance[arg_64_2].name)

			setTextColor = var_2_10000

			local var_66_1 = var_64_3

			ChapterConst = var_3

			var_2_10000(var_66_1, var_3.AirDominance[arg_64_2].color)

			LeanTween = var_2_10000

			local var_66_2 = var_2_10000.value

			go = var_66_1

			local var_66_3 = var_66_2(var_66_1(var_64_3), 0, 1, 0.5)
			local var_66_4 = var_0.setOnUpdate

			System = var_3

			var_66_4(var_66_3, var_3.Action_float(function(arg_67_0)
				setTextAlpha = var_3_10001

				var_3_10001(var_64_3, arg_67_0)

				return
			end))

			return
		end))

		function var_64_9(arg_68_0)
			setActive = var_2_10001

			var_2_10001(arg_68_0, false)

			return
		end

		var_64_12 = var_64_4

		local var_64_13 = var_64_4.GetComponent

		typeof = var_14
		DftAniEvent = var_1_10016
		var_64_12 = var_64_13(var_64_12, var_14(var_1_10016))

		var_11.SetEndEvent(var_64_12, var_64_9)

		var_64_12 = var_64_5

		local var_64_14 = var_64_5.GetComponent

		typeof = var_14
		DftAniEvent = var_1_10016
		var_64_12 = var_64_14(var_64_12, var_14(var_1_10016))

		var_11.SetEndEvent(var_64_12, var_64_9)

		setActive = var_11

		var_11(var_64_4, arg_64_3 > 0)

		setActive = var_11

		var_11(var_64_5, arg_64_3 < 0)
	else
		setText = var_64_9

		local var_64_15 = var_64_3

		ChapterConst = var_64_12

		var_64_9(var_64_15, var_64_12.AirDominance[arg_64_2].name)

		setTextColor = var_64_9

		local var_64_16 = var_64_3

		ChapterConst = var_13

		var_64_9(var_64_16, var_13.AirDominance[arg_64_2].color)
	end

	return
end

function var_0_1.UpdateDefenseStatus(arg_69_0)
	local var_69_0 = arg_69_0.contextData.chapterVO
	local var_69_1 = var_1.getPlayType(var_69_0)

	ChapterConst = var_1_10003

	local var_69_2 = var_69_1 == var_1_10003.TypeDefence

	findTF = var_3

	local var_69_3 = var_3(arg_69_0.bottomStage, "Normal/shengfu")

	setActive = var_69_0

	var_69_0(var_69_3, var_69_2)

	if not var_69_2 then
		return
	end

	findTF = var_69_0

	local var_69_4 = var_69_0(var_69_3, "hp")
	local var_69_5 = var_4.GetComponent

	typeof = var_7
	Text = var_1_10009

	local var_69_6 = var_69_5(var_69_4, var_7(var_1_10009))
	local var_69_7 = var_1.id

	pg = var_69_4

	local var_69_8 = var_69_4.chapter_defense[var_69_7]

	i18n = var_7

	local var_69_9 = "desc_base_hp"
	local var_69_10 = "<color=#92FC63>"

	tostring = var_1_10011
	var_69_6.text = var_7(var_69_9, var_69_10 .. var_1_10011(var_1.BaseHP) .. "</color>", var_69_8.port_hp)

	return
end

function var_0_1.DisplayWinConditionPanel(arg_70_0)
	if not arg_70_0.winCondPanel then
		WinConditionDisplayPanel = var_1
		arg_70_0.winCondPanel = var_1.New(arg_70_0._tf.parent, arg_70_0.event, arg_70_0.contextData)

		local var_70_0 = arg_70_0.winCondPanel

		var_1.Load(var_70_0)
	end

	local var_70_1 = arg_70_0.winCondPanel

	var_1.ActionInvoke(var_70_1, "Enter", arg_70_0.contextData.chapterVO)

	return
end

function var_0_1.DestroyWinConditionPanel(arg_71_0)
	if not arg_71_0.winCondPanel then
		return
	end

	local var_71_0 = arg_71_0.winCondPanel

	var_1.Destroy(var_71_0)

	arg_71_0.winCondPanel = nil

	return
end

function var_0_1.UpdateComboPanel(arg_72_0)
	local var_72_0 = arg_72_0.contextData.chapterVO

	pg = var_1_10002

	if var_1_10002.chapter_pop_template[var_72_0.id] and var_2.combo_on then
		local var_72_1 = arg_72_0
		local var_72_2, var_72_3 = arg_72_0.GetSubView(var_72_1, "LevelStageComboPanel")

		if var_72_3 then
			var_1_10007 = var_72_2

			var_72_2.Load(var_1_10007)

			var_1_10007 = var_72_2.buffer

			var_72_1.SetParent(var_1_10007, arg_72_0.leftStage, false)
		end

		getProxy = var_72_1
		ChapterProxy = var_1_10007

		local var_72_4 = var_72_1(var_1_10007)
		local var_72_5 = var_5.GetComboHistory(var_72_4, var_72_0.id)
		local var_72_6 = var_72_2.buffer

		var_6.UpdateView(var_72_6, var_72_5 or var_72_0)

		local var_72_7 = var_72_2.buffer

		var_6.UpdateViewAnimated(var_72_7, var_72_0)
	end

	return
end

function var_0_1.UpdateDOALinkFeverPanel(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_0.contextData.chapterVO
	local var_73_1 = var_2.GetBindActID(var_73_0)

	if not var_2:getConfig("levelstage_bar") or var_4 == "" then
		existCall = var_73_0

		var_73_0(arg_73_1)

		return
	end

	local var_73_2, var_73_3 = arg_73_0:GetSubView(var_4)

	if var_73_3 then
		var_73_2:Load()

		local var_73_4 = var_73_2.buffer

		var_7.SetParent(var_73_4, arg_73_0._tf, false)
	end

	local var_73_5 = var_73_2.buffer

	var_7.UpdateView(var_73_5, var_2, arg_73_1)

	return
end

Vector2 = var_2

local var_0_3 = var_2(396, 128)

Vector2 = var_3

local var_0_4 = var_3(128, 128)

function var_0_1.updateStageStrategy(arg_74_0)
	local var_74_0 = arg_74_0.contextData.chapterVO

	findTF = var_1_10002

	local var_74_1 = var_1_10002(arg_74_0.rightStage, "event")

	findTF = var_1_10003

	local var_74_2 = var_1_10003(var_74_1, "detail")

	findTF = var_4

	local var_74_3 = var_4(var_74_2, "click")

	findTF = var_5

	local var_74_4 = var_5(var_74_2, "items")
	local var_74_5 = var_5.GetComponent

	typeof = var_1_10009
	GridLayoutGroup = var_1_10011

	local var_74_6 = var_74_5(var_74_4, var_1_10009(var_1_10011))
	local var_74_7

	if not arg_74_0._showStrategyDetail or not var_0_3 then
		var_74_7 = var_0_4
	end

	var_74_6.cellSize = var_74_7
	findTF = var_74_7

	local var_74_8 = var_74_7(var_5, "item")

	findTF = var_74_4

	local var_74_9 = var_74_4(var_74_1, "collapse")

	setActive = var_9

	var_9(var_74_8, false)

	local var_74_10 = var_74_0
	local var_74_11 = var_74_0.GetInteractableStrategies(var_74_10)
	local var_74_12

	local function var_74_13(arg_75_0, arg_75_1, arg_75_2)
		UIItemList = var_2_10003

		if arg_75_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_75_0 = arg_75_2:Find("detail")

		setActive = var_2_10004

		var_2_10004(var_75_0, arg_74_0._showStrategyDetail)

		local var_75_1 = arg_75_2:Find("icon")
		local var_75_2 = var_74_11[arg_75_1 + 1]
		local var_75_3
		local var_75_4
		local var_75_5 = var_75_2.id

		ChapterConst = var_2_10009

		if var_75_5 == var_2_10009.StrategyHuntingRange then
			ChapterConst = var_75_5
			var_75_3 = var_75_5.StgTypeConst
			var_75_4 = arg_74_0.contextData.huntingRangeVisibility % 2 == 1 and "range_invisible" or "range_visible"
			setText = var_75_5

			local var_75_6 = var_75_0

			i18n = var_2_10011

			var_75_5(var_75_6, var_2_10011("help_sub_limits"))
		else
			var_75_5 = var_75_2.id
			ChapterConst = var_9

			if var_75_5 == var_9.StrategySubAutoAttack then
				ChapterConst = var_75_5
				var_75_3 = var_75_5.StgTypeConst
				var_75_4 = var_74_0.subAutoAttack == 0 and "sub_dont_auto_attack" or "sub_auto_attack"
				setText = var_75_5

				local var_75_7 = var_75_0

				i18n = var_2_10011

				var_75_5(var_75_7, var_2_10011("help_sub_display"))
			else
				pg = var_75_5
				var_75_3 = var_75_5.strategy_data_template[var_75_2.id].type
				var_75_4 = var_75_5.icon
				setText = var_9

				var_9(var_75_0, var_75_5.desc)
			end
		end

		GetImageSpriteFromAtlasAsync = var_75_5

		var_75_5("strategyicon/" .. var_75_4, "", var_75_1:Find("icon"))

		onButton = var_75_5

		local var_75_8 = arg_74_0
		local var_75_9 = var_75_1

		local function var_75_10()
			local var_76_0 = var_75_2.id

			ChapterConst = var_3_10001

			if var_76_0 == var_3_10001.StrategyHuntingRange then
				local var_76_1 = arg_74_0.grid

				var_0.toggleHuntingRange(var_76_1)
				var_74_13(arg_75_0, arg_75_1, arg_75_2)
			else
				local var_76_2 = var_75_2.id

				ChapterConst = var_1

				if var_76_2 == var_1.StrategySubAutoAttack then
					pg = var_76_2

					local var_76_3 = var_76_2.TipsMgr.GetInstance()
					local var_76_4 = var_0.ShowTips

					i18n = var_3_10003

					var_76_4(var_76_3, var_3_10003("ai_change_" .. 1 - var_74_0.subAutoAttack + 1))

					local var_76_5 = arg_74_0
					local var_76_6 = var_0.emit

					LevelMediator2 = var_3_10003
					var_3_10003 = var_3_10003.ON_OP

					local var_76_7 = {}

					ChapterConst = var_3_10005
					var_76_7.type = var_3_10005.OpSubState
					var_76_7.arg1 = 1 - var_74_0.subAutoAttack

					var_76_6(var_76_5, var_3_10003, var_76_7)
				else
					local var_76_8 = var_75_2.id

					ChapterConst = var_1

					local var_76_11

					if var_76_8 == var_1.StrategyExchange then
						local var_76_9 = var_74_0
						local var_76_10 = var_0.getNextValidIndex(var_76_9)

						if 0 < var_76_10 and var_75_2.count > 0 then
							var_76_11 = var_74_0.fleet

							local var_76_12 = arg_74_0
							local var_76_13 = var_2.HandleShowMsgBox

							var_3_10005 = {}
							i18n = var_3_10006
							var_3_10005.content = var_3_10006("levelScene_who_to_exchange")

							function var_3_10005.onYes()
								local var_77_0 = arg_74_0
								local var_77_1 = var_0.emit

								LevelMediator2 = var_4_10003

								local var_77_2 = var_4_10003.ON_OP
								local var_77_3 = {}

								ChapterConst = var_4_10005
								var_77_3.type = var_4_10005.OpStrategy
								var_77_3.id = var_76_11.id
								ChapterConst = var_5
								var_77_3.arg1 = var_5.StrategyExchange
								var_77_3.arg2 = var_74_0.fleets[var_76_10].id

								var_77_1(var_77_0, var_77_2, var_77_3)

								return
							end

							var_76_13(var_76_12, var_3_10005)
						end
					else
						local var_76_14 = var_75_2.id

						ChapterConst = var_76_11

						if var_76_14 == var_76_11.StrategySubTeleport then
							local var_76_15 = arg_74_0

							var_0.SwitchSubTeleportBottomStage(var_76_15)

							local var_76_16 = arg_74_0

							var_0.SwitchBottomStagePanel(var_76_16, true)

							local var_76_17 = arg_74_0.grid

							var_0.ShowStaticHuntingRange(var_76_17)

							local var_76_18 = arg_74_0.grid

							var_0.PrepareSubTeleport(var_76_18)

							local var_76_19 = arg_74_0.grid
							local var_76_20 = var_0.updateQuadCells

							ChapterConst = var_3_10003

							var_76_20(var_76_19, var_3_10003.QuadStateTeleportSub)
						else
							local var_76_21 = var_75_2.id

							ChapterConst = var_1

							local var_76_22

							if var_76_21 == var_1.StrategyMissileStrike then
								var_3_10003 = var_74_0.fleet

								if not var_0.canUseStrategy(var_3_10003, var_75_2) then
									return
								end

								var_3_10003 = arg_74_0

								var_76_22.SwitchMissileBottomStagePanel(var_3_10003)

								var_3_10003 = arg_74_0

								var_76_22.SwitchBottomStagePanel(var_3_10003, true)

								var_3_10003 = arg_74_0.grid
								var_76_22 = var_76_22.updateQuadCells
								ChapterConst = var_4

								var_76_22(var_3_10003, var_4.QuadStateMissileStrike)
							else
								local var_76_23 = var_75_2.id

								ChapterConst = var_76_22

								local var_76_25

								if var_76_23 == var_76_22.StrategyAirSupport then
									local var_76_24 = var_74_0

									var_3_10003 = var_0.getChapterSupportFleet(var_76_24)

									if not var_0.canUseStrategy(var_3_10003, var_75_2) then
										return
									end

									var_3_10003 = arg_74_0

									var_76_25.SwitchAirSupportBottomStagePanel(var_3_10003)

									var_3_10003 = arg_74_0

									var_76_25.SwitchBottomStagePanel(var_3_10003, true)

									var_3_10003 = arg_74_0.grid
									var_76_25 = var_76_25.updateQuadCells
									ChapterConst = var_4

									var_76_25(var_3_10003, var_4.QuadStateAirSuport)
								else
									local var_76_26 = var_75_2.id

									ChapterConst = var_76_25

									local var_76_28

									if var_76_26 == var_76_25.StrategyExpel then
										local var_76_27 = var_74_0

										var_3_10003 = var_0.getChapterSupportFleet(var_76_27)

										if not var_0.canUseStrategy(var_3_10003, var_75_2) then
											return
										end

										var_3_10003 = arg_74_0

										var_76_28.SwitchAirExpelBottomStagePanel(var_3_10003)

										var_3_10003 = arg_74_0

										var_76_28.SwitchBottomStagePanel(var_3_10003, true)

										var_3_10003 = arg_74_0.grid
										var_76_28 = var_76_28.updateQuadCells
										ChapterConst = var_4

										var_76_28(var_3_10003, var_4.QuadStateExpel)
									else
										local var_76_29 = var_75_3

										ChapterConst = var_76_28

										if var_76_29 == var_76_28.StgTypeForm then
											local var_76_30 = var_74_0.fleet

											table = var_1

											local var_76_31 = var_1.indexof

											ChapterConst = var_3_10003

											local var_76_32 = var_76_31(var_3_10003.StrategyForms, var_75_2.id)
											local var_76_33 = arg_74_0
											local var_76_34 = var_2.emit

											LevelMediator2 = var_3_10005

											local var_76_35 = var_3_10005.ON_OP
											local var_76_36 = {}

											ChapterConst = var_3_10007
											var_76_36.type = var_3_10007.OpStrategy
											var_76_36.id = var_76_30.id
											ChapterConst = var_7

											local var_76_37 = var_7.StrategyForms

											ChapterConst = var_3_10008
											var_76_36.arg1 = var_76_37[var_76_32 % #var_3_10008.StrategyForms + 1]

											var_76_34(var_76_33, var_76_35, var_76_36)
										else
											local var_76_38 = arg_74_0
											local var_76_39 = var_0.emit

											LevelUIConst = var_3_10003

											var_76_39(var_76_38, var_3_10003.DISPLAY_STRATEGY_INFO, var_75_2)
										end
									end
								end
							end
						end
					end
				end
			end

			return
		end

		SFX_PANEL = var_2_10013

		var_75_5(var_75_8, var_75_9, var_75_10, var_2_10013)

		ChapterConst = var_75_5

		if var_75_3 == var_75_5.StgTypeForm then
			setText = var_8

			var_8(var_75_1:Find("nums"), "")

			setActive = var_8

			var_8(var_75_1:Find("mask"), false)

			setActive = var_8

			var_8(var_75_1:Find("selected"), true)
		else
			setText = var_8

			local var_75_11 = var_75_1:Find("nums")
			local var_75_12

			if not var_75_2.count then
				var_75_12 = ""
			end

			var_8(var_75_11, var_75_12)

			setActive = var_8

			var_8(var_75_1:Find("mask"), var_75_2.count == 0)

			setActive = var_8

			var_8(var_75_1:Find("selected"), false)
		end

		return
	end

	UIItemList = var_74_10

	var_74_10.StaticAlign(var_5, var_74_8, #var_74_11, var_74_13)

	onButton = var_11

	local var_74_14 = arg_74_0
	local var_74_15 = var_74_3

	local function var_74_16()
		shiftPanel = var_2_10000

		local var_78_0 = var_74_2
		local var_78_1 = var_74_2.rect.width + 200
		local var_78_2
		local var_78_3 = 0.3
		local var_78_4 = 0
		local var_78_5 = true
		local var_78_6

		LeanTweenType = var_2_10009

		var_2_10000(var_78_0, var_78_1, var_78_2, var_78_3, var_78_4, var_78_5, var_78_6, var_2_10009.easeOutSine)

		shiftPanel = var_2_10000

		local var_78_7 = var_74_9
		local var_78_8 = -30
		local var_78_9
		local var_78_10 = 0.3
		local var_78_11 = 0
		local var_78_12 = true
		local var_78_13

		LeanTweenType = var_9

		var_2_10000(var_78_7, var_78_8, var_78_9, var_78_10, var_78_11, var_78_12, var_78_13, var_9.easeOutSine)

		return
	end

	SFX_PANEL = var_16

	var_11(var_74_14, var_74_15, var_74_16, var_16)

	onButton = var_11

	local var_74_17 = arg_74_0
	local var_74_18 = var_74_9

	local function var_74_19()
		shiftPanel = var_2_10000

		local var_79_0 = var_74_2
		local var_79_1 = 35
		local var_79_2
		local var_79_3 = 0.3
		local var_79_4 = 0
		local var_79_5 = true
		local var_79_6

		LeanTweenType = var_2_10009

		var_2_10000(var_79_0, var_79_1, var_79_2, var_79_3, var_79_4, var_79_5, var_79_6, var_2_10009.easeOutSine)

		shiftPanel = var_2_10000

		local var_79_7 = var_74_9
		local var_79_8 = var_74_9.rect.width + 200
		local var_79_9
		local var_79_10 = 0.3
		local var_79_11 = 0
		local var_79_12 = true
		local var_79_13

		LeanTweenType = var_9

		var_2_10000(var_79_7, var_79_8, var_79_9, var_79_10, var_79_11, var_79_12, var_79_13, var_9.easeOutSine)

		return
	end

	SFX_PANEL = var_16

	var_11(var_74_17, var_74_18, var_74_19, var_16)

	return
end

function var_0_1.GetSubView(arg_80_0, arg_80_1)
	if arg_80_0.attachSubViews[arg_80_1] then
		return arg_80_0.attachSubViews[arg_80_1]
	end

	_G = var_2

	local var_80_0 = var_2[arg_80_1].New(arg_80_0)

	assert = var_1_10003

	var_1_10003(var_80_0, "cant't find subview " .. (arg_80_1 or "nil"))

	arg_80_0.attachSubViews[arg_80_1] = var_80_0

	return var_80_0, true
end

function var_0_1.RemoveSubView(arg_81_0, arg_81_1)
	if not arg_81_0.attachSubViews[arg_81_1] then
		return false
	end

	local var_81_0 = arg_81_0.attachSubViews[arg_81_1]

	var_2.Destroy(var_81_0)

	arg_81_0.attachSubViews[arg_81_1] = nil

	return true
end

function var_0_1.ClearSubViews(arg_82_0)
	pairs = var_1_10001

	for iter_82_0, iter_82_1 in var_1_10001(arg_82_0.attachSubViews) do
		iter_82_1:Destroy()
	end

	table = var_1

	var_1.clear(arg_82_0.attachSubViews)

	return
end

function var_0_1.updateStageFleet(arg_83_0)
	local var_83_0 = arg_83_0.contextData.chapterVO

	findTF = var_1_10002

	local var_83_1 = var_1_10002(arg_83_0.leftStage, "fleet")

	findTF = var_1_10003

	local var_83_2 = var_1_10003(var_83_1, "shiptpl")
	local var_83_3 = arg_83_0.topStage
	local var_83_4 = var_4.Find(var_83_3, "msg_panel/fleet_info/number")

	setActive = var_5

	var_5(var_83_2, false)

	setText = var_5

	var_5(var_83_4, var_83_0.fleet.id)

	local var_83_5 = var_83_0.fleet
	local var_83_6 = var_5.getShips(var_83_5, true)

	local function var_83_7(arg_84_0, arg_84_1)
		UIItemList = var_2_10002

		local var_84_0 = var_2_10002.New(arg_84_0, var_83_2)

		var_2.make(var_84_0, function(arg_85_0, arg_85_1, arg_85_2)
			UIItemList = var_3_10003

			if arg_85_0 == var_3_10003.EventUpdate then
				local var_85_0 = arg_84_1[arg_85_1 + 1]

				updateShip = var_4

				var_4(arg_85_2, var_85_0)

				local var_85_1 = var_85_0.hpRant
				local var_85_2 = var_85_0
				local var_85_3 = var_85_0.getShipProperties(var_85_2)

				math = var_6

				local var_85_4 = var_6.floor
				local var_85_5

				if not var_85_0.hpChange then
					var_85_5 = 0
				end

				local var_85_6 = var_85_5 / 16

				AttributeType = var_3_10009

				local var_85_7 = var_85_4(var_85_6 * var_85_3[var_3_10009.Durability])

				findTF = var_85_2

				local var_85_8 = var_85_2(arg_85_2, "HP_POP")

				setActive = var_8

				var_8(var_85_8, true)

				setActive = var_8
				findTF = var_10

				var_8(var_10(var_85_8, "heal"), false)

				setActive = var_8
				findTF = var_10

				var_8(var_10(var_85_8, "normal"), false)

				local function var_85_9(arg_86_0, arg_86_1)
					setActive = var_4_10002

					var_4_10002(arg_86_0, true)

					setText = var_4_10002
					findTF = var_4

					var_4_10002(var_4(arg_86_0, "text"), arg_86_1)

					setTextAlpha = var_4_10002
					findTF = var_4

					var_4_10002(var_4(arg_86_0, "text"), 0)

					LeanTween = var_4_10002

					var_4_10002.moveY(arg_86_0, 60, 1)

					LeanTween = var_2

					local var_86_0 = var_2.textAlpha

					findTF = var_4

					var_86_0(var_4(arg_86_0, "text"), 1, 0.3)

					LeanTween = var_86_0

					local var_86_1 = var_86_0.textAlpha

					findTF = var_4

					local var_86_2 = var_86_1(var_4(arg_86_0, "text"), 0, 0.5)
					local var_86_3 = var_2.setDelay(var_86_2, 0.7)
					local var_86_4 = var_2.setOnComplete

					System = var_5

					var_86_4(var_86_3, var_5.Action(function()
						local var_87_0 = arg_86_0

						Vector3 = var_5_10001
						var_87_0.localPosition = var_5_10001(0, 0, 0)

						return
					end))

					return
				end

				local var_85_10

				if 0 < var_85_7 then
					var_85_10 = var_85_9
					findTF = var_11

					var_85_10(var_11(var_85_8, "heal"), var_85_7)
				elseif var_85_7 < 0 then
					LeanTween = var_85_10
					var_85_10 = var_85_10.delayedCall

					local var_85_11 = 0.6

					System = var_12

					var_85_10(var_85_11, var_12.Action(function()
						local var_88_0 = arg_85_2.transform.localPosition.x

						LeanTween = var_4_10001

						local var_88_1 = var_4_10001.moveX(arg_85_2, var_88_0, 0.05)
						local var_88_2 = var_1.setEase

						LeanTweenType = var_4

						local var_88_3 = var_88_2(var_88_1, var_4.easeInOutSine)

						var_1.setLoopPingPong(var_88_3, 4)

						LeanTween = var_1

						local var_88_4 = var_1.alpha

						findTF = var_88_3

						var_88_4(var_88_3(arg_85_2, "red"), 0.5, 0.4)

						LeanTween = var_88_4

						local var_88_5 = var_88_4.alpha

						findTF = var_3

						local var_88_6 = var_88_5(var_3(arg_85_2, "red"), 0, 0.4)

						var_1.setDelay(var_88_6, 0.4)

						local var_88_7 = var_85_9

						findTF = var_88_6

						var_88_7(var_88_6(var_85_8, "normal"), var_85_7)

						return
					end))
				end

				findTF = var_85_10

				local var_85_12 = var_85_10(arg_85_2, "blood")

				findTF = var_10

				local var_85_13 = var_10(arg_85_2, "blood/fillarea/green")

				findTF = var_11

				local var_85_14 = var_11(arg_85_2, "blood/fillarea/red")

				ChapterConst = var_12

				local var_85_15 = var_85_1 < var_12.HpGreen
				local var_85_16 = var_85_1 == 0

				setActive = var_14

				var_14(var_85_13, not var_85_15)

				setActive = var_14

				var_14(var_85_14, var_85_15)

				local var_85_17 = var_85_12
				local var_85_18 = var_85_12.GetComponent

				typeof = var_17
				Slider = var_3_10019

				local var_85_19 = var_85_18(var_85_17, var_17(var_3_10019))

				var_85_19.fillRect = var_85_15 and var_85_14 or var_85_13
				setSlider = var_85_19

				var_85_19(var_85_12, 0, 10000, var_85_1)

				setActive = var_85_19
				findTF = var_16

				var_85_19(var_16(arg_85_2, "repairmask"), var_85_15)

				setActive = var_85_19
				findTF = var_16

				var_85_19(var_16(arg_85_2, "repairmask/broken"), var_85_16)

				onButton = var_85_19

				local var_85_20 = arg_83_0
				local var_85_21 = arg_85_2
				local var_85_22 = arg_85_2.Find(var_85_21, "repairmask")

				local function var_85_23()
					local var_89_0 = arg_83_0
					local var_89_1 = var_0.emit

					LevelUIConst = var_4_10003

					var_89_1(var_89_0, var_4_10003.DISPLAY_REPAIR_WINDOW, var_85_0)

					return
				end

				SFX_PANEL = var_85_21

				var_85_19(var_85_20, var_85_22, var_85_23, var_85_21)

				findTF = var_85_19

				local var_85_24 = var_85_19(arg_85_2, "repairmask/icon").gameObject

				if not var_85_15 then
					LeanTween = var_85_25

					var_85_25.cancel(var_85_24)

					setImageAlpha = var_85_25

					var_85_25(var_85_24, 1)
				end

				local var_85_25

				if var_85_15 then
					LeanTween = var_85_25

					if not var_85_25.isTweening(var_85_24) then
						LeanTween = var_85_25
						var_85_25 = var_85_25.alpha
						rtf = var_17

						local var_85_26 = var_85_25(var_17(var_85_24), 0, 2)

						var_85_25.setLoopPingPong(var_85_26)
					end
				end

				GetOrAddComponent = var_85_25

				local var_85_27 = var_85_25(arg_85_2, "UILongPressTrigger").onLongPressed

				pg = var_16

				var_16.DelegateInfo.Add(arg_83_0, var_85_27)
				var_85_27:RemoveAllListeners()
				var_85_27:AddListener(function()
					local var_90_0 = arg_83_0
					local var_90_1 = var_0.emit

					LevelMediator2 = var_4_10003

					var_90_1(var_90_0, var_4_10003.ON_STAGE_SHIPINFO, {
						shipId = var_85_0.id,
						shipVOs = var_83_6
					})

					return
				end)
			end

			return
		end)
		var_2:align(#arg_84_1)

		return
	end

	local var_83_8 = var_83_1:Find("main")
	local var_83_9 = var_83_0.fleet
	local var_83_10 = var_10.getShipsByTeam

	TeamType = var_1_10013

	var_83_7(var_83_8, var_83_10(var_83_9, var_1_10013.Main, true))

	local var_83_11 = var_6
	local var_83_12 = var_83_1:Find("vanguard")
	local var_83_13 = var_83_0.fleet
	local var_83_14 = var_10.getShipsByTeam

	TeamType = var_13

	var_83_11(var_83_12, var_83_14(var_83_13, var_13.Vanguard, true))

	local var_83_15 = var_83_0.fleet

	var_7.clearShipHpChange(var_83_15)

	return
end

function var_0_1.updateSupportFleet(arg_91_0)
	local var_91_0 = arg_91_0.contextData.chapterVO
	local var_91_1 = var_1.getChapterSupportFleet(var_91_0)

	findTF = var_1_10002

	local var_91_2 = var_1_10002(arg_91_0.leftStage, "support_fleet")

	setActive = var_91_0

	local var_91_3 = var_91_2

	tobool = var_1_10006

	var_91_0(var_91_3, var_1_10006(var_91_1))

	if var_91_1 then
		findTF = var_91_0

		local var_91_4 = var_91_0(var_91_2, "show/ship_container")

		removeAllChildren = var_4

		var_4(var_91_4)

		findTF = var_4

		local var_91_5 = var_4(var_91_2, "show/shiptpl")
		local var_91_6 = var_91_1:getShips()

		pairs = var_6

		for iter_91_0, iter_91_1 in var_6(var_91_6) do
			cloneTplTo = var_1_10011
			var_1_10011 = var_1_10011(var_91_5, var_91_4)
			setActive = var_1_10012

			var_1_10012(var_1_10011, true)

			updateShip = var_1_10012

			var_1_10012(var_1_10011, iter_91_1)
		end

		local var_91_7 = var_91_2:Find("hide")
		local var_91_8 = var_91_2
		local var_91_9 = var_91_2.Find(var_91_8, "show")

		local function var_91_10(arg_92_0)
			setActive = var_2_10001

			var_2_10001(var_91_7, true)

			setActive = var_2_10001

			var_2_10001(var_91_9, true)

			shiftPanel = var_2_10001

			local var_92_0 = var_91_9
			local var_92_1
			local var_92_2 = arg_92_0 and -325.1 or -855
			local var_92_3 = 0.3
			local var_92_4 = 0
			local var_92_5 = true
			local var_92_6

			LeanTweenType = var_2_10010

			var_2_10001(var_92_0, var_92_1, var_92_2, var_92_3, var_92_4, var_92_5, var_92_6, var_2_10010.easeOutSine, function()
				setActive = var_3_10000

				var_3_10000(var_91_7, not arg_92_0)

				setActive = var_3_10000

				var_3_10000(var_91_9, arg_92_0)

				return
			end)

			shiftPanel = var_2_10001

			local var_92_7 = var_91_7
			local var_92_8
			local var_92_9 = arg_92_0 and -1017 or -563.97
			local var_92_10 = 0.3
			local var_92_11 = 0
			local var_92_12 = true
			local var_92_13

			LeanTweenType = var_10

			var_2_10001(var_92_7, var_92_8, var_92_9, var_92_10, var_92_11, var_92_12, var_92_13, var_10.easeOutSine)

			return
		end

		onButton = var_91_8

		local var_91_11 = arg_91_0
		local var_91_12 = var_91_7

		local function var_91_13()
			var_91_10(true)

			return
		end

		SFX_PANEL = var_1_10014

		var_91_8(var_91_11, var_91_12, var_91_13, var_1_10014)

		onButton = var_91_8

		var_91_8(arg_91_0, var_91_9, function()
			var_91_10(false)

			return
		end)
	end

	return
end

function var_0_1.ShiftStagePanelIn(arg_96_0, arg_96_1)
	shiftPanel = var_1_10002

	local var_96_0 = arg_96_0.topStage
	local var_96_1 = 0
	local var_96_2 = 0
	local var_96_3 = 0.3
	local var_96_4 = 0
	local var_96_5 = true
	local var_96_6

	LeanTweenType = var_1_10011

	var_1_10002(var_96_0, var_96_1, var_96_2, var_96_3, var_96_4, var_96_5, var_96_6, var_1_10011.easeOutSine, arg_96_1)
	arg_96_0:ShiftBottomStage(true)

	shiftPanel = var_2

	local var_96_7 = arg_96_0.leftStage
	local var_96_8 = 0
	local var_96_9 = 0
	local var_96_10 = 0.3
	local var_96_11 = 0
	local var_96_12 = true
	local var_96_13

	LeanTweenType = var_11

	var_2(var_96_7, var_96_8, var_96_9, var_96_10, var_96_11, var_96_12, var_96_13, var_11.easeOutSine)

	shiftPanel = var_2

	local var_96_14 = arg_96_0.rightStage
	local var_96_15 = 0
	local var_96_16 = 0
	local var_96_17 = 0.3
	local var_96_18 = 0
	local var_96_19 = true
	local var_96_20

	LeanTweenType = var_11

	var_2(var_96_14, var_96_15, var_96_16, var_96_17, var_96_18, var_96_19, var_96_20, var_11.easeOutSine)

	return
end

function var_0_1.ShiftStagePanelOut(arg_97_0, arg_97_1)
	shiftPanel = var_1_10002

	local var_97_0 = arg_97_0.topStage
	local var_97_1 = 0
	local var_97_2 = arg_97_0.topStage.rect.height
	local var_97_3 = 0.3
	local var_97_4 = 0
	local var_97_5 = true
	local var_97_6

	LeanTweenType = var_1_10011

	var_1_10002(var_97_0, var_97_1, var_97_2, var_97_3, var_97_4, var_97_5, var_97_6, var_1_10011.easeOutSine, arg_97_1)
	arg_97_0:ShiftBottomStage(false)

	shiftPanel = var_2

	local var_97_7 = arg_97_0.leftStage
	local var_97_8 = -arg_97_0.leftStage.rect.width - 200
	local var_97_9 = 0
	local var_97_10 = 0.3
	local var_97_11 = 0
	local var_97_12 = true
	local var_97_13

	LeanTweenType = var_11

	var_2(var_97_7, var_97_8, var_97_9, var_97_10, var_97_11, var_97_12, var_97_13, var_11.easeOutSine)

	shiftPanel = var_2

	local var_97_14 = arg_97_0.rightStage
	local var_97_15 = arg_97_0.rightStage.rect.width + 300
	local var_97_16 = 0
	local var_97_17 = 0.3
	local var_97_18 = 0
	local var_97_19 = true
	local var_97_20

	LeanTweenType = var_11

	var_2(var_97_14, var_97_15, var_97_16, var_97_17, var_97_18, var_97_19, var_97_20, var_11.easeOutSine)

	return
end

function var_0_1.ShiftBottomStage(arg_98_0, arg_98_1)
	arg_98_1 = not arg_98_0.bottomStageInactive and arg_98_1

	local var_98_0 = arg_98_1 and 0 or -arg_98_0.bottomStage.rect.height

	shiftPanel = var_1_10003

	local var_98_1 = arg_98_0.bottomStage
	local var_98_2 = 0
	local var_98_3 = var_98_0
	local var_98_4 = 0.3
	local var_98_5 = 0
	local var_98_6 = true
	local var_98_7

	LeanTweenType = var_1_10012

	var_1_10003(var_98_1, var_98_2, var_98_3, var_98_4, var_98_5, var_98_6, var_98_7, var_1_10012.easeOutSine)

	return
end

function var_0_1.SwitchSubTeleportBottomStage(arg_99_0)
	setActive = var_1_10001

	var_1_10001(arg_99_0.missileStrikeRole, true)

	setText = var_1_10001
	findTF = var_3

	local var_99_0 = var_3(arg_99_0.missileStrikeRole, "confirm_button/Text")

	i18n = var_4

	var_1_10001(var_99_0, var_4("levelscene_deploy_submarine"))

	setText = var_1_10001
	findTF = var_99_0

	local var_99_1 = var_99_0(arg_99_0.missileStrikeRole, "cancel_button/Text")

	i18n = var_4

	var_1_10001(var_99_1, var_4("levelscene_deploy_submarine_cancel"))

	onButton = var_1_10001

	local var_99_2 = arg_99_0
	local var_99_3 = arg_99_0.missileStrikeRole
	local var_99_4 = var_4.Find(var_99_3, "confirm_button")

	local function var_99_5()
		local var_100_0 = arg_99_0.contextData.chapterVO
		local var_100_1 = var_0.GetSubmarineFleet(var_100_0).startPos

		if not arg_99_0.grid.subTeleportTargetLine then
			return
		end

		local var_100_2 = var_0:findPath(nil, var_100_1, var_3)
		local var_100_3 = arg_99_0.grid
		local var_100_4 = var_5.TransformLine2PlanePos(var_100_3, var_100_1)
		local var_100_5 = arg_99_0.grid
		local var_100_6 = var_6.TransformLine2PlanePos(var_100_5, var_3)

		math = var_100_3

		local var_100_7 = var_100_3.ceil

		pg = var_9

		local var_100_8 = var_9.strategy_data_template

		ChapterConst = var_2_10010

		local var_100_9 = var_100_8[var_2_10010.StrategySubTeleport].arg[2]
		local var_100_10 = var_1
		local var_100_11 = var_100_7(var_100_9 * #var_1.getShips(var_100_10, false) * var_100_2 - 1e-05)

		pg = var_100_5

		local var_100_12 = var_100_5.MsgboxMgr.GetInstance()
		local var_100_13 = var_8.ShowMsgBox
		local var_100_14 = {}

		i18n = var_100_10
		var_100_14.content = var_100_10("tips_confirm_teleport_sub", var_100_4, var_100_6, var_100_2, var_100_11)

		function var_100_14.onYes()
			local var_101_0 = arg_99_0
			local var_101_1 = var_0.emit

			LevelMediator2 = var_3_10003

			local var_101_2 = var_3_10003.ON_OP
			local var_101_3 = {}

			ChapterConst = var_3_10005
			var_101_3.type = var_3_10005.OpSubTeleport
			var_101_3.id = var_0.id
			var_101_3.arg1 = var_0.row
			var_101_3.arg2 = var_0.column

			var_101_1(var_101_0, var_101_2, var_101_3)

			return
		end

		var_100_13(var_100_12, var_100_14)

		return
	end

	SFX_UI_CLICK = var_99_3

	var_1_10001(var_99_2, var_99_4, var_99_5, var_99_3)

	onButton = var_1_10001

	local var_99_6 = arg_99_0
	local var_99_7 = arg_99_0.missileStrikeRole
	local var_99_8 = var_4.Find(var_99_7, "cancel_button")

	local function var_99_9()
		local var_102_0 = arg_99_0

		var_0.SwitchBottomStagePanel(var_102_0, false)

		local var_102_1 = arg_99_0.grid

		var_0.TurnOffSubTeleport(var_102_1)

		local var_102_2 = arg_99_0.grid
		local var_102_3 = var_0.updateQuadCells

		ChapterConst = var_3

		var_102_3(var_102_2, var_3.QuadStateNormal)

		return
	end

	SFX_UI_CLICK = var_99_7

	var_1_10001(var_99_6, var_99_8, var_99_9, var_99_7)

	return
end

function var_0_1.SwitchMissileBottomStagePanel(arg_103_0)
	setActive = var_1_10001

	var_1_10001(arg_103_0.missileStrikeRole, true)

	setText = var_1_10001
	findTF = var_3

	local var_103_0 = var_3(arg_103_0.missileStrikeRole, "confirm_button/Text")

	i18n = var_4

	var_1_10001(var_103_0, var_4("missile_attack_area_confirm"))

	setText = var_1_10001
	findTF = var_103_0

	local var_103_1 = var_103_0(arg_103_0.missileStrikeRole, "cancel_button/Text")

	i18n = var_4

	var_1_10001(var_103_1, var_4("missile_attack_area_cancel"))

	onButton = var_1_10001

	local var_103_2 = arg_103_0
	local var_103_3 = arg_103_0.missileStrikeRole
	local var_103_4 = var_4.Find(var_103_3, "confirm_button")

	local function var_103_5()
		if not arg_103_0.grid.missileStrikeTargetLine then
			return
		end

		local var_104_0 = arg_103_0.contextData.chapterVO.fleet

		;(function()
			local var_105_0 = arg_103_0
			local var_105_1 = var_0.emit

			LevelMediator2 = var_3_10003

			local var_105_2 = var_3_10003.ON_OP
			local var_105_3 = {}

			ChapterConst = var_3_10005
			var_105_3.type = var_3_10005.OpStrategy
			var_105_3.id = var_104_0.id
			ChapterConst = var_5
			var_105_3.arg1 = var_5.StrategyMissileStrike
			var_105_3.arg2 = var_0.row
			var_105_3.arg3 = var_0.column

			var_105_1(var_105_0, var_105_2, var_105_3)

			return
		end)()

		return
	end

	SFX_UI_CLICK = var_103_3

	var_1_10001(var_103_2, var_103_4, var_103_5, var_103_3)

	onButton = var_1_10001

	local var_103_6 = arg_103_0
	local var_103_7 = arg_103_0.missileStrikeRole
	local var_103_8 = var_4.Find(var_103_7, "cancel_button")

	local function var_103_9()
		local var_106_0 = arg_103_0

		var_0.SwitchBottomStagePanel(var_106_0, false)

		local var_106_1 = arg_103_0.grid

		var_0.HideMissileAimingMark(var_106_1)

		local var_106_2 = arg_103_0.grid
		local var_106_3 = var_0.updateQuadCells

		ChapterConst = var_3

		var_106_3(var_106_2, var_3.QuadStateNormal)

		return
	end

	SFX_UI_CLICK = var_103_7

	var_1_10001(var_103_6, var_103_8, var_103_9, var_103_7)

	return
end

function var_0_1.SwitchAirSupportBottomStagePanel(arg_107_0)
	setActive = var_1_10001

	var_1_10001(arg_107_0.missileStrikeRole, true)

	setText = var_1_10001
	findTF = var_3

	local var_107_0 = var_3(arg_107_0.missileStrikeRole, "confirm_button/Text")

	i18n = var_4

	var_1_10001(var_107_0, var_4("missile_attack_area_confirm"))

	setText = var_1_10001
	findTF = var_107_0

	local var_107_1 = var_107_0(arg_107_0.missileStrikeRole, "cancel_button/Text")

	i18n = var_4

	var_1_10001(var_107_1, var_4("missile_attack_area_cancel"))

	onButton = var_1_10001

	local var_107_2 = arg_107_0
	local var_107_3 = arg_107_0.missileStrikeRole
	local var_107_4 = var_4.Find(var_107_3, "confirm_button")

	local function var_107_5()
		if not arg_107_0.grid.missileStrikeTargetLine then
			return
		end

		local var_108_0 = arg_107_0.contextData.chapterVO
		local var_108_1 = var_1.getChapterSupportFleet(var_108_0)

		;(function()
			local var_109_0 = arg_107_0
			local var_109_1 = var_0.emit

			LevelMediator2 = var_3_10003

			local var_109_2 = var_3_10003.ON_OP
			local var_109_3 = {}

			ChapterConst = var_3_10005
			var_109_3.type = var_3_10005.OpStrategy
			var_109_3.id = var_108_1.id
			ChapterConst = var_5
			var_109_3.arg1 = var_5.StrategyAirSupport
			var_109_3.arg2 = var_0.row
			var_109_3.arg3 = var_0.column

			var_109_1(var_109_0, var_109_2, var_109_3)

			return
		end)()

		return
	end

	SFX_UI_CLICK = var_107_3

	var_1_10001(var_107_2, var_107_4, var_107_5, var_107_3)

	onButton = var_1_10001

	local var_107_6 = arg_107_0
	local var_107_7 = arg_107_0.missileStrikeRole
	local var_107_8 = var_4.Find(var_107_7, "cancel_button")

	local function var_107_9()
		local var_110_0 = arg_107_0

		var_0.SwitchBottomStagePanel(var_110_0, false)

		local var_110_1 = arg_107_0.grid

		var_0.HideAirSupportAimingMark(var_110_1)

		local var_110_2 = arg_107_0.grid
		local var_110_3 = var_0.updateQuadCells

		ChapterConst = var_3

		var_110_3(var_110_2, var_3.QuadStateNormal)

		return
	end

	SFX_UI_CLICK = var_107_7

	var_1_10001(var_107_6, var_107_8, var_107_9, var_107_7)

	return
end

function var_0_1.SwitchAirExpelBottomStagePanel(arg_111_0)
	setActive = var_1_10001

	var_1_10001(arg_111_0.airExpelRole, true)

	setText = var_1_10001
	findTF = var_3

	local var_111_0 = var_3(arg_111_0.airExpelRole, "cancel_button/Text")

	i18n = var_4

	var_1_10001(var_111_0, var_4("levelscene_airexpel_cancel"))

	onButton = var_1_10001

	local var_111_1 = arg_111_0
	local var_111_2 = arg_111_0.airExpelRole
	local var_111_3 = var_4.Find(var_111_2, "cancel_button")

	local function var_111_4()
		local var_112_0 = arg_111_0

		var_0.SwitchBottomStagePanel(var_112_0, false)

		local var_112_1 = arg_111_0.grid

		var_0.HideAirExpelAimingMark(var_112_1)

		local var_112_2 = arg_111_0.grid

		var_0.CleanAirSupport(var_112_2)

		local var_112_3 = arg_111_0.grid
		local var_112_4 = var_0.updateQuadCells

		ChapterConst = var_3

		var_112_4(var_112_3, var_3.QuadStateNormal)

		return
	end

	SFX_UI_CLICK = var_111_2

	var_1_10001(var_111_1, var_111_3, var_111_4, var_111_2)

	return
end

function var_0_1.SwitchBottomStagePanel(arg_113_0, arg_113_1)
	setActive = var_1_10002

	var_1_10002(arg_113_0.actionRole, true)

	setActive = var_1_10002

	var_1_10002(arg_113_0.normalRole, true)

	shiftPanel = var_1_10002

	var_1_10002(arg_113_0.actionRole, 0, arg_113_1 and 0 or var_0_2, 0.3, 0, true, true, nil, function()
		setActive = var_2_10000

		var_2_10000(arg_113_0.actionRole, arg_113_1)

		return
	end)

	shiftPanel = var_1_10002

	local var_113_0 = arg_113_0.normalRole
	local var_113_1 = 0
	local var_113_2

	if not arg_113_1 or not var_0_2 then
		var_113_2 = 0
	end

	var_1_10002(var_113_0, var_113_1, var_113_2, 0.3, 0, true, true, nil, function()
		setActive = var_2_10000

		var_2_10000(arg_113_0.normalRole, not arg_113_1)

		if not arg_113_1 then
			eachChild = var_0

			var_0(arg_113_0.actionRole, function(arg_116_0)
				setActive = var_3_10001

				var_3_10001(arg_116_0, false)

				return
			end)
		end

		return
	end)

	shiftPanel = var_1_10002

	local var_113_3 = arg_113_0.leftStage
	local var_113_4

	if not arg_113_1 or not (-arg_113_0.leftStage.rect.width - 200) then
		var_113_4 = 0
	end

	var_1_10002(var_113_3, var_113_4, 0, 0.3, 0, true)

	shiftPanel = var_1_10002

	local var_113_5 = arg_113_0.rightStage
	local var_113_6

	if not arg_113_1 or not (arg_113_0.rightStage.rect.width + 300) then
		var_113_6 = 0
	end

	var_1_10002(var_113_5, var_113_6, 0, 0.3, 0, true)

	return
end

function var_0_1.ClickGridCellNormal(arg_117_0, arg_117_1)
	local var_117_0 = arg_117_0.contextData.chapterVO.fleet

	_ = var_1_10004

	if var_1_10004.detect(var_2.fleets, function(arg_118_0)
		local var_118_0 = arg_118_0:getFleetType()

		FleetType = var_2_10002

		return var_118_0 == var_2_10002.Normal and arg_118_0.line.row == arg_117_1.row and arg_118_0.line.column == arg_117_1.column
	end) and var_4:isValid() and var_4.id ~= var_117_0.id then
		local var_117_1 = arg_117_0
		local var_117_2 = arg_117_0.emit

		LevelMediator2 = var_1_10008

		local var_117_3 = var_1_10008.ON_OP
		local var_117_4 = {}

		ChapterConst = var_1_10010
		var_117_4.type = var_1_10010.OpSwitch
		var_117_4.id = var_4.id

		var_117_2(var_117_1, var_117_3, var_117_4)

		return
	end

	if arg_117_0:tryAutoTrigger(nil, true) then
		return
	end

	if arg_117_1.row == var_117_0.line.row and arg_117_1.column == var_117_0.line.column then
		return
	end

	local var_117_5 = var_2
	local var_117_6 = var_2.getChapterCell(var_117_5, arg_117_1.row, arg_117_1.column).attachment

	ChapterConst = var_117_5

	local var_117_9, var_117_10

	if var_117_6 == var_117_5.AttachStory then
		local var_117_7 = var_6.data

		ChapterConst = var_117_9

		if var_117_7 == var_117_9.StoryObstacle then
			local var_117_8 = var_6.flag

			ChapterConst = var_117_9

			if var_117_8 == var_117_9.CellFlagTriggerActive then
				pg = var_117_8

				if var_117_8.map_event_template[var_6.attachmentId] and var_7.gametip then
					var_117_9 = #var_7.gametip

					if 0 < var_117_9 then
						var_117_10 = var_2
						var_117_9 = var_2.getPlayType(var_117_10)
						ChapterConst = var_9

						if var_117_9 ~= var_9.TypeDefence then
							pg = var_117_9
							var_117_10 = var_117_9.TipsMgr.GetInstance()
							var_117_9 = var_117_9.ShowTips
							i18n = var_1_10011

							var_117_9(var_117_10, var_1_10011(var_7.gametip))
						end
					end
				end

				do return end

				goto label_117_0
			end
		end
	end

	do
		local var_117_11 = var_2
		local var_117_12 = var_2.considerAsStayPoint

		ChapterConst = var_117_10

		if not var_117_12(var_117_11, var_117_10.SubjectPlayer, arg_117_1.row, arg_117_1.column) then
			return
		elseif var_2:existMoveLimit() then
			local var_117_13 = var_2
			local var_117_14 = var_2.calcWalkableCells

			ChapterConst = var_117_10

			local var_117_15 = var_117_14(var_117_13, var_117_10.SubjectPlayer, var_117_0.line.row, var_117_0.line.column, var_117_0:getSpeed())

			_ = var_117_9

			if not var_117_9.any(var_117_15, function(arg_119_0)
				return arg_119_0.row == arg_117_1.row and arg_119_0.column == arg_117_1.column
			end) then
				pg = var_117_9
				var_117_10 = var_117_9.TipsMgr.GetInstance()
				var_117_9 = var_117_9.ShowTips
				i18n = var_11

				var_117_9(var_117_10, var_11("destination_not_in_range"))

				return
			end
		end
	end

	::label_117_0::

	local var_117_16 = var_2
	local var_117_17 = var_2.findPath

	ChapterConst = var_117_10

	local var_117_18 = var_117_17(var_117_16, var_117_10.SubjectPlayer, var_117_0.line, {
		row = arg_117_1.row,
		column = arg_117_1.column
	})

	PathFinding = var_117_9

	local var_117_20, var_117_21

	if var_117_18 < var_117_9.PrioObstacle then
		local var_117_19 = arg_117_0

		var_117_20 = arg_117_0.emit
		LevelMediator2 = var_117_21
		var_117_21 = var_117_21.ON_OP

		local var_117_22 = {}

		ChapterConst = var_13
		var_117_22.type = var_13.OpMove
		var_117_22.id = var_117_0.id
		var_117_22.arg1 = arg_117_1.row
		var_117_22.arg2 = arg_117_1.column

		var_117_20(var_117_19, var_117_21, var_117_22)
	else
		PathFinding = var_117_20

		local var_117_24

		if var_117_18 < var_117_20.PrioForbidden then
			pg = var_117_24

			local var_117_23 = var_117_24.TipsMgr.GetInstance()

			var_117_24 = var_117_24.ShowTips
			i18n = var_117_21

			var_117_24(var_117_23, var_117_21("destination_can_not_reach"))
		else
			pg = var_117_24

			local var_117_25 = var_117_24.TipsMgr.GetInstance()
			local var_117_26 = var_8.ShowTips

			i18n = var_117_21

			var_117_26(var_117_25, var_117_21("destination_can_not_reach"))
		end
	end

	return
end

function var_0_1.tryAutoAction(arg_120_0, arg_120_1)
	if arg_120_0.doingAutoAction then
		return
	end

	arg_120_0.doingAutoAction = true

	if not arg_120_0.contextData.chapterVO then
		existCall = var_1_10003

		var_1_10003(arg_120_1)

		return
	end

	if arg_120_0:SafeCheck() then
		existCall = var_1_10004

		var_1_10004(arg_120_1)

		return
	end

	local var_120_0 = {}
	local var_120_1 = false

	pairs = var_1_10006

	for iter_120_0, iter_120_1 in var_1_10006(var_2.cells) do
		local var_120_2 = iter_120_1.trait

		ChapterConst = var_1_10012

		if var_120_2 == var_1_10012.TraitLurk then
			var_120_1 = true

			break
		end
	end

	if not var_120_1 then
		ipairs = var_120_5

		for iter_120_2, iter_120_3 in var_120_5(var_2.champions) do
			local var_120_3 = iter_120_3.trait

			ChapterConst = var_1_10012

			if var_120_3 == var_1_10012.TraitLurk then
				var_120_1 = true

				break
			end
		end
	end

	local var_120_5

	if var_120_1 then
		local var_120_4 = var_2

		var_120_5 = var_2.existOni(var_120_4)

		local var_120_6 = var_2:isPlayingWithBombEnemy()

		if not var_120_5 and not var_120_6 then
			table = var_120_4

			var_120_4.insert(var_120_0, function(arg_121_0)
				local var_121_0 = arg_120_0
				local var_121_1 = var_1.emit

				LevelUIConst = var_2_10004

				var_121_1(var_121_0, var_2_10004.DO_TRACKING, arg_121_0)

				return
			end)
		else
			table = var_120_4

			var_120_4.insertto(var_120_0, {
				function(arg_122_0)
					local var_122_0

					if var_120_5 then
						var_122_0 = "SpUnit"
					elseif var_120_6 then
						var_122_0 = "SpBomb"
					end

					assert = var_2

					var_2(var_122_0)

					local var_122_1 = arg_120_0
					local var_122_2 = var_2.emit

					LevelUIConst = var_2_10005

					var_122_2(var_122_1, var_2_10005.DO_PLAY_ANIM, {
						name = var_122_0,
						callback = function(arg_123_0)
							setActive = var_3_10001

							var_3_10001(arg_123_0, false)
							arg_122_0()

							return
						end
					})

					return
				end,
				function(arg_124_0)
					local var_124_0 = var_0

					if var_1.getSpAppearStory(var_124_0) and #var_1 > 0 then
						pg = var_2

						local var_124_1 = var_2.NewStoryMgr.GetInstance()

						var_2.Play(var_124_1, var_1, arg_124_0)

						return
					end

					arg_124_0()

					return
				end,
				function(arg_125_0)
					local var_125_0 = var_0

					if var_1.getSpAppearGuide(var_125_0) and #var_1 > 0 then
						pg = var_2

						local var_125_1 = var_2.SystemGuideMgr.GetInstance()

						var_2.PlayByGuideId(var_125_1, var_1, nil, arg_125_0)

						return
					end

					arg_125_0()

					return
				end
			})
		end

		table = var_120_4

		var_120_4.insertto(var_120_0, {
			function(arg_126_0)
				parallelAsync = var_2_10001

				var_2_10001({
					function(arg_127_0)
						local var_127_0 = arg_120_0

						var_1.tryPlayChapterStory(var_127_0, arg_127_0)

						return
					end,
					function(arg_128_0)
						local var_128_0 = var_0

						if var_1.GetBossCell(var_128_0) then
							local var_128_1 = var_1.trait

							ChapterConst = var_128_0

							if var_128_1 == var_128_0.TraitLurk then
								local var_128_2 = arg_120_0.grid

								var_2.focusOnCell(var_128_2, var_1, arg_128_0)

								return
							end
						end

						arg_128_0()

						return
					end
				}, arg_126_0)

				return
			end,
			function(arg_129_0)
				local var_129_0 = arg_120_0
				local var_129_1 = var_1.updateTrait

				ChapterConst = var_2_10004

				var_129_1(var_129_0, var_2_10004.TraitVirgin)

				local var_129_2 = arg_120_0.grid

				var_1.updateAttachments(var_129_2)

				local var_129_3 = arg_120_0.grid

				var_1.updateChampions(var_129_3)

				local var_129_4 = arg_120_0
				local var_129_5 = var_1.updateTrait

				ChapterConst = var_4

				var_129_5(var_129_4, var_4.TraitNone)

				local var_129_6 = arg_120_0
				local var_129_7 = var_1.emit

				LevelMediator2 = var_4

				var_129_7(var_129_6, var_4.ON_OVERRIDE_CHAPTER)

				Timer = var_129_7

				local var_129_8 = var_129_7.New(arg_129_0, 0.5, 1)

				var_1.Start(var_129_8)

				return
			end
		})
	end

	seriesAsync = var_120_5

	var_120_5({
		function(arg_130_0)
			local var_130_0 = arg_120_0
			local var_130_1 = var_1.emit

			LevelUIConst = var_2_10004

			var_130_1(var_130_0, var_2_10004.FROZEN)

			getProxy = var_130_1
			ChapterProxy = var_130_0

			local var_130_2 = var_130_1(var_130_0)

			if var_1.GetLastDefeatedEnemy(var_130_2, var_0.id) then
				local var_130_3 = var_1.attachment

				ChapterConst = var_130_2

				if var_130_3 == var_130_2.AttachAmbush then
					ChapterConst = var_130_3

					if var_130_3.IsBossCell(var_1) then
						ChapterConst = var_130_3

						local var_130_4 = var_130_3.GetDestroyFX(var_1)
						local var_130_5 = arg_120_0.grid
						local var_130_6 = var_3.PlayAttachmentEffect
						local var_130_7 = var_1.line.row
						local var_130_8 = var_1.line.column
						local var_130_9 = var_130_4

						Vector2 = var_2_10009

						var_130_6(var_130_5, var_130_7, var_130_8, var_130_9, var_2_10009.zero)
					end

					local var_130_10 = arg_120_0

					var_2.PopBar(var_130_10)

					local var_130_11 = arg_120_0

					var_2.UpdateComboPanel(var_130_11)
					arg_130_0()

					return
				end
			end
		end,
		function(arg_131_0)
			if not (function()
				getProxy = var_3_10000
				ChapterProxy = var_3_10002

				local var_132_0 = var_3_10000(var_3_10002)

				if not var_0.GetLastDefeatedEnemy(var_132_0, var_0.id) then
					return
				end

				pg = var_3_10001

				local var_132_1

				if var_3_10001.expedition_data_template[var_0.attachmentId] then
					::label_132_0::

					var_132_1 = var_1.type
					ChapterConst = var_3
					var_132_1 = var_132_1 == var_3.ExpeditionTypeMulBoss
				end

				return var_132_1
			end)() then
				return arg_131_0()
			end

			local var_131_0 = arg_120_0
			local var_131_1 = var_2.emit

			LevelUIConst = var_2_10005

			var_131_1(var_131_0, var_2_10005.DO_PLAY_ANIM, {
				name = "BossRetreatBar",
				callback = function(arg_133_0)
					setActive = var_3_10001

					var_3_10001(arg_133_0, false)
					arg_131_0()

					return
				end
			})

			return
		end,
		function(arg_134_0)
			local var_134_0 = arg_120_0

			var_1.UpdateDOALinkFeverPanel(var_134_0, arg_134_0)

			return
		end,
		function(arg_135_0)
			seriesAsync = var_2_10001

			var_2_10001(var_120_0, arg_135_0)

			return
		end,
		function(arg_136_0)
			local var_136_0 = var_0
			local var_136_1, var_136_2 = var_1.GetAttachmentStories(var_136_0)

			if var_136_1 then
				table = var_136_0

				var_136_0.SerialIpairsAsync(var_136_1, function(arg_137_0, arg_137_1, arg_137_2)
					if arg_137_0 <= var_136_2 and arg_137_1 then
						type = var_3

						if var_3(arg_137_1) == "number" and 0 < arg_137_1 then
							pg = var_3

							local var_137_0 = var_3.NewStoryMgr
							local var_137_1 = var_3.StoryId2StoryName(var_137_0, arg_137_1)

							ChapterOpCommand = var_3_10004

							local var_137_2 = var_3_10004.PlayChapterStory
							local var_137_3 = var_137_1
							local var_137_4 = arg_137_2
							local var_137_5 = var_0

							var_137_2(var_137_3, var_137_4, var_8.IsAutoFight(var_137_5))

							return
						end
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
			local var_138_0 = arg_120_0.contextData.chapterVO.id

			getProxy = var_2_10002
			ChapterProxy = var_2_10004

			local var_138_1 = var_2_10002(var_2_10004)

			if not var_2.getUpdatedExtraFlags(var_138_1, var_138_0) or #var_2 < 1 then
				arg_138_0()

				return
			end

			ipairs = var_2_10003

			for iter_138_0, iter_138_1 in var_2_10003(var_2) do
				pg = var_2_10008

				local var_138_2

				if not var_2_10008.chapter_status_effect[iter_138_1] or not var_2_10008.camera_focus then
					var_138_2 = ""
				end

				type = var_2_10010

				if var_2_10010(var_138_2) == "table" then
					local var_138_3 = arg_120_0.grid

					var_2_10010.focusOnCell(var_138_3, {
						row = var_138_2[1],
						column = var_138_2[2]
					}, arg_138_0)

					return
				end
			end

			arg_138_0()

			return
		end,
		function(arg_139_0)
			if arg_120_0.exited then
				return
			end

			local var_139_0 = arg_120_0
			local var_139_1 = var_1.emit

			LevelUIConst = var_2_10004

			var_139_1(var_139_0, var_2_10004.UN_FROZEN)
			;(function()
				getProxy = var_3_10000
				ChapterProxy = var_3_10002

				local var_140_0 = var_3_10000(var_3_10002)

				if not var_0.getActiveChapter(var_140_0, true) then
					return
				end

				local var_140_1 = var_1.id

				var_0:RecordComboHistory(var_140_1, nil)
				var_0:RecordLastDefeatedEnemy(var_140_1, nil)
				var_0:extraFlagUpdated(var_140_1)
				var_0:RemoveExtendChapterData(var_140_1, "FleetMoveDistance")

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

		if var_120_1 then
			local var_141_0 = arg_120_0

			if var_0.TryEnterChapterStoryStage(var_141_0) then
				goto label_141_0
			end
		end

		existCall = var_0

		var_0(arg_120_1)

		::label_141_0::

		return
	end)

	return
end

function var_0_1.tryPlayChapterStory(arg_142_0, arg_142_1)
	local var_142_0 = arg_142_0.contextData.chapterVO
	local var_142_1 = var_2.getWaveCount(var_142_0)

	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_143_0)
			pg = var_2_10001

			local var_143_0 = var_2_10001.SystemGuideMgr.GetInstance()

			var_1.PlayChapter(var_143_0, var_0, arg_143_0)

			return
		end,
		function(arg_144_0)
			local var_144_0 = var_0

			if var_1.getConfig(var_144_0, "story_refresh") and var_1[var_142_1] then
				type = var_144_0

				if var_144_0(var_2) == "string" and var_2 ~= "" then
					local var_144_1 = var_0

					if not var_3.IsRemaster(var_144_1) then
						ChapterOpCommand = var_3

						local var_144_2 = var_3.PlayChapterStory
						local var_144_3 = var_2
						local var_144_4 = arg_144_0
						local var_144_5 = var_0

						var_144_2(var_144_3, var_144_4, var_7.IsAutoFight(var_144_5))

						return
					end
				end
			end

			arg_144_0()

			return
		end,
		function(arg_145_0)
			local var_145_0 = var_0

			if var_1.getConfig(var_145_0, "story_refresh_boss") then
				type = var_2_10002

				if var_2_10002(var_1) == "string" and var_1 ~= "" then
					local var_145_1 = var_0

					if not var_2.IsRemaster(var_145_1) then
						local var_145_2 = var_0

						if var_2.IsFinalBossRefreshed(var_145_2) then
							ChapterOpCommand = var_2

							local var_145_3 = var_2.PlayChapterStory
							local var_145_4 = var_1
							local var_145_5 = arg_145_0
							local var_145_6 = var_0

							var_145_3(var_145_4, var_145_5, var_6.IsAutoFight(var_145_6))

							return
						end
					end
				end
			end

			arg_145_0()

			return
		end,
		function(arg_146_0)
			if var_142_1 == 1 then
				pg = var_1

				if var_1.map_event_list[var_0.id] then
					pg = var_1

					if var_1.map_event_list[var_0.id].help_open == 1 then
						PlayerPrefs = var_1

						if var_1.GetInt("help_displayed_on_" .. var_0.id, 0) == 0 then
							triggerButton = var_1

							var_1(arg_142_0.helpBtn)

							PlayerPrefs = var_1

							var_1.SetInt("help_displayed_on_" .. var_0.id, 1)
						end
					end
				end
			end

			arg_146_0()

			return
		end,
		function()
			existCall = var_2_10000

			var_2_10000(arg_142_1)

			return
		end
	})

	return
end

function var_0_1.TryEnterChapterStoryStage(arg_148_0, arg_148_1)
	local var_148_0 = arg_148_0.contextData.chapterVO
	local var_148_1 = var_2.getWaveCount(var_148_0)
	local var_148_2 = var_2

	if var_2.getConfig(var_148_2, "story_refresh") and var_4[var_148_1] then
		type = var_148_2

		if var_148_2(var_5) == "number" and not var_2:IsRemaster() then
			pg = var_6

			local var_148_3 = var_6.NewStoryMgr.GetInstance()
			local var_148_4 = var_6.IsPlayed

			pg = var_1_10009

			local var_148_5 = var_1_10009.NewStoryMgr.GetInstance()

			if not var_148_4(var_148_3, var_9.StoryId2StoryName(var_148_5, var_5)) then
				local var_148_6 = arg_148_0
				local var_148_7 = arg_148_0.emit

				LevelMediator2 = var_9

				var_148_7(var_148_6, var_9.ON_PERFORM_COMBAT, var_5)

				return true
			end
		end
	end

	if var_2:getConfig("story_refresh_boss") then
		type = var_7

		if var_7(var_6) == "number" and not var_2:IsRemaster() and var_2:IsFinalBossRefreshed() then
			pg = var_7

			local var_148_8 = var_7.NewStoryMgr.GetInstance()
			local var_148_9 = var_7.IsPlayed

			pg = var_1_10010

			local var_148_10 = var_1_10010.NewStoryMgr.GetInstance()

			if not var_148_9(var_148_8, var_10.StoryId2StoryName(var_148_10, var_6)) then
				local var_148_11 = arg_148_0
				local var_148_12 = arg_148_0.emit

				LevelMediator2 = var_10

				var_148_12(var_148_11, var_10.ON_PERFORM_COMBAT, var_6)

				return true
			end
		end
	end

	return
end

function var_0_1.TryEnterChapterSupportSubmarineStage(arg_149_0, arg_149_1)
	local var_149_0 = arg_149_0.contextData.chapterVO
	local var_149_1 = var_2.getChapterSupportFleet(var_149_0)
	local var_149_2 = {}

	if var_2:getChapterSupportFleet() then
		local var_149_3 = arg_149_0
		local var_149_4 = arg_149_0.emit

		LevelMediator2 = var_1_10008

		var_149_4(var_149_3, var_1_10008.ON_SUPPORT_SUBMARINE)
	else
		local var_149_5 = arg_149_0
		local var_149_6 = arg_149_0.emit

		LevelMediator2 = var_1_10008

		local var_149_7 = var_1_10008.ON_OP
		local var_149_8 = {}

		ChapterConst = var_1_10010
		var_149_8.type = var_1_10010.OPSubStrike
		ys = var_10
		var_149_8.arg1 = var_10.Battle.BattleConst.BattleScore.C
		var_149_8.callback = arg_149_1

		var_149_6(var_149_5, var_149_7, var_149_8)
	end

	return
end

local var_0_5 = {}

ChapterConst = var_5
var_0_5[var_5.KizunaJammingDodge] = "kizunaOperationSafe"
ChapterConst = var_5
var_0_5[var_5.KizunaJammingEngage] = "kizunaOperationDanger"
ChapterConst = var_5
var_0_5[var_5.StatusDay] = "HololiveDayBar"
ChapterConst = var_5
var_0_5[var_5.StatusNight] = "HololiveNightBar"
ChapterConst = var_5
var_0_5[var_5.StatusAirportUnderControl] = "AirportCaptureBar"
ChapterConst = var_5
var_0_5[var_5.StatusSunset] = "SunsetBar"
ChapterConst = var_5
var_0_5[var_5.StatusMaze1] = "MazeBar"
ChapterConst = var_5
var_0_5[var_5.StatusMaze2] = "MazeBar"
ChapterConst = var_5
var_0_5[var_5.StatusMaze3] = "MazeBar"
ChapterConst = var_5
var_0_5[var_5.StatusMissile1] = "MissileBar"
ChapterConst = var_5
var_0_5[var_5.StatusMissileInit] = "MissileWarningBar"
ChapterConst = var_5
var_0_5[var_5.StatusMissile1B] = "MissileBar"
ChapterConst = var_5
var_0_5[var_5.StatusMissileInitB] = "MissileWarningBar"
ChapterConst = var_5
var_0_5[var_5.StatusMusashiGame1] = "MusashiGameBar_1"
ChapterConst = var_5
var_0_5[var_5.StatusMusashiGame2] = "MusashiGameBar_2"
ChapterConst = var_5
var_0_5[var_5.StatusMusashiGame3] = "MusashiGameBar_3"
ChapterConst = var_5
var_0_5[var_5.StatusMusashiGame4] = "MusashiGameBar_4"
ChapterConst = var_5
var_0_5[var_5.StatusMusashiGame5] = "MusashiGameBar_5"
ChapterConst = var_5
var_0_5[var_5.StatusMusashiGame6] = "MusashiGameBar_6"
ChapterConst = var_5
var_0_5[var_5.StatusMusashiGame7] = "MusashiGameBar_7"
ChapterConst = var_5
var_0_5[var_5.StatusMusashiGame8] = "MusashiGameBar_8"

function var_0_1.PopBar(arg_150_0)
	local var_150_0 = arg_150_0.contextData.chapterVO.id

	getProxy = var_1_10002
	ChapterProxy = var_1_10004

	local var_150_1 = var_1_10002(var_1_10004)

	if not var_2.getUpdatedExtraFlags(var_150_1, var_150_0) or #var_2 < 1 then
		return
	end

	local var_150_2 = var_2[1]

	if not var_0_5[var_150_2] then
		return
	end

	local var_150_3, var_150_4 = arg_150_0:GetSubView(var_4)

	if var_150_4 then
		var_150_3:Load()
	end

	local var_150_5 = var_150_3.buffer

	var_7.PlayAnim(var_150_5)

	return
end

function var_0_1.updateTrait(arg_151_0, arg_151_1)
	local var_151_0 = arg_151_0.contextData.chapterVO

	pairs = var_1_10003

	for iter_151_0, iter_151_1 in var_1_10003(var_151_0.cells) do
		local var_151_1 = iter_151_1.trait

		ChapterConst = var_1_10009

		if var_151_1 ~= var_1_10009.TraitNone then
			iter_151_1.trait = arg_151_1
		end
	end

	ipairs = var_3

	for iter_151_2, iter_151_3 in var_3(var_151_0.champions) do
		local var_151_2 = iter_151_3.trait

		ChapterConst = var_1_10009

		if var_151_2 ~= var_1_10009.TraitNone then
			iter_151_3.trait = arg_151_1
		end
	end

	return
end

function var_0_1.CheckFleetChange(arg_152_0)
	local var_152_0 = arg_152_0.contextData.chapterVO
	local var_152_1 = var_1.GetActiveFleet(var_152_0)

	_ = var_1_10003

	if var_1_10003.detect(var_1.fleets, function(arg_153_0)
		return not arg_153_0:isValid()
	end) then
		local var_152_2 = arg_152_0
		local var_152_3 = arg_152_0.emit

		LevelMediator2 = var_1_10007

		local var_152_4 = var_1_10007.ON_OP
		local var_152_5 = {}

		ChapterConst = var_1_10009
		var_152_5.type = var_1_10009.OpRetreat
		var_152_5.id = var_3.id

		var_152_3(var_152_2, var_152_4, var_152_5)

		local var_152_6 = var_3
		local var_152_7 = var_3.getFleetType(var_152_6)

		TeamType = var_5

		if var_152_7 == var_5.Normal then
			getProxy = var_152_7
			ChapterProxy = var_152_6

			local var_152_8 = var_152_7(var_152_6)
			local var_152_9 = var_4.StopAutoFight

			ChapterConst = var_152_4

			var_152_9(var_152_8, var_152_4.AUTOFIGHT_STOP_REASON.BATTLE_FAILED)
		end
	end

	if not var_152_1:isValid() then
		if var_1:getNextValidIndex() > 0 then
			local var_152_10 = var_1.fleets[var_4]

			local function var_152_11()
				local var_154_0 = arg_152_0
				local var_154_1 = var_0.emit

				LevelMediator2 = var_2_10003

				local var_154_2 = var_2_10003.ON_OP
				local var_154_3 = {}

				ChapterConst = var_2_10005
				var_154_3.type = var_2_10005.OpSwitch
				var_154_3.id = var_152_10.id

				var_154_1(var_154_0, var_154_2, var_154_3)

				return
			end

			local var_152_12 = arg_152_0
			local var_152_13 = arg_152_0.HandleShowMsgBox
			local var_152_14 = {
				modal = true,
				hideNo = true
			}

			i18n = var_1_10011
			var_152_14.content = var_1_10011("formation_switch_tip", var_152_10.name)
			var_152_14.onYes = var_152_11
			var_152_14.onNo = var_152_11

			var_152_13(var_152_12, var_152_14)
		end

		return true
	end

	return false
end

function var_0_1.tryAutoTrigger(arg_155_0, arg_155_1, arg_155_2)
	local var_155_0 = arg_155_0.contextData.chapterVO

	if arg_155_0:DoBreakAction() then
		return
	end

	if arg_155_0:CheckFleetChange() then
		return
	end

	return ((function()
		local var_156_0 = var_155_0

		if var_0.checkAnyInteractive(var_156_0) then
			if arg_155_1 then
				local var_156_1 = var_155_0

				if var_0.IsAutoFight(var_156_1) then
					triggerButton = var_0

					var_0(arg_155_0.funcBtn)

					do return true end

					goto label_156_0

					local var_156_2 = var_155_0
					local var_156_3 = var_0.getRound(var_156_2)

					ChapterConst = var_2_10001

					if var_156_3 == var_2_10001.RoundEnemy then
						local var_156_4 = arg_155_0
						local var_156_5 = var_0.emit

						LevelMediator2 = var_2_10003
						var_2_10003 = var_2_10003.ON_OP

						local var_156_6 = {}

						ChapterConst = var_2_10005
						var_156_6.type = var_2_10005.OpEnemyRound

						var_156_5(var_156_4, var_2_10003, var_156_6)

						return true
					else
						local var_156_7 = var_155_0
						local var_156_8 = var_0.getRound(var_156_7)

						ChapterConst = var_1

						if var_156_8 == var_1.RoundPlayer then
							if not arg_155_2 then
								local var_156_9 = arg_155_0.grid
								local var_156_10 = var_0.updateQuadCells

								ChapterConst = var_2_10003

								var_156_10(var_156_9, var_2_10003.QuadStateNormal)
							end

							local var_156_11 = var_155_0

							if var_0.IsAutoFight(var_156_11) then
								local var_156_12 = arg_155_0

								var_0.TryAutoFight(var_156_12)

								return true
							end
						end
					end
				end

				::label_156_0::

				return
			end
		end
	end)())
end

function var_0_1.DoBreakAction(arg_157_0)
	local var_157_0 = arg_157_0.contextData.chapterVO
	local var_157_1, var_157_2 = arg_157_0:SafeCheck()

	if var_157_1 then
		local function var_157_3(arg_158_0)
			local var_158_0

			seriesAsync = var_2_10002

			var_2_10002({
				function(arg_159_0)
					local var_159_0 = arg_157_0
					local var_159_1 = var_1.emit

					LevelUIConst = var_3_10004

					var_159_1(var_159_0, var_3_10004.ADD_MSG_QUEUE, arg_159_0)

					return
				end,
				function(arg_160_0, arg_160_1)
					var_158_0 = arg_160_1
					ChapterOpCommand = var_3_10002

					var_3_10002.PrepareChapterRetreat(arg_160_0)

					return
				end,
				function(arg_161_0)
					existCall = var_3_10001

					var_3_10001(arg_158_0)

					existCall = var_3_10001

					var_3_10001(var_158_0)

					return
				end
			})

			return
		end

		ChapterConst = var_1_10005

		if var_157_2 == var_1_10005.ReasonVictory then
			seriesAsync = var_5

			var_5({
				function(arg_162_0)
					var_157_3(arg_162_0)

					return
				end,
				function(arg_163_0)
					local var_163_0 = var_157_0
					local var_163_1

					if var_1.getConfig(var_163_0, "win_condition_display") then
						var_163_1 = #var_163_1 > 0 and var_163_1 .. "_tip"
					end

					if var_163_1 then
						pg = var_2_10002

						if var_2_10002.gametip[var_163_1] then
							pg = var_2_10002

							local var_163_2 = var_2_10002.TipsMgr.GetInstance()

							var_2_10002 = var_2_10002.ShowTips
							i18n = var_2_10005

							var_2_10002(var_163_2, var_2_10005(var_163_1))

							goto label_163_0
						end
					end

					pg = var_2_10002

					do
						local var_163_3 = var_2_10002.TipsMgr.GetInstance()
						local var_163_4 = var_2.ShowTips

						i18n = var_2_10005

						var_163_4(var_163_3, var_2_10005("levelScene_chapter_win"))
					end

					::label_163_0::

					arg_163_0()

					return
				end
			})
		else
			ChapterConst = var_5

			local var_157_4

			if var_157_2 == var_5.ReasonDefeat then
				var_157_4 = var_157_0:getPlayType()
				ChapterConst = var_1_10006

				if var_157_4 == var_1_10006.TypeTransport then
					pg = var_157_4

					local var_157_5 = var_157_4.TipsMgr.GetInstance()

					var_157_4 = var_157_4.ShowTips
					i18n = var_1_10008

					var_157_4(var_157_5, var_1_10008("levelScene_escort_lose"))
					var_157_3()
				else
					local var_157_6 = arg_157_0

					var_157_4 = arg_157_0.HandleShowMsgBox
					var_1_10008 = {
						modal = true,
						hideNo = true
					}
					i18n = var_1_10009
					var_1_10008.content = var_1_10009("formation_invalide")
					var_1_10008.onYes = var_157_3
					var_1_10008.onClose = var_157_3

					var_157_4(var_157_6, var_1_10008)
				end
			else
				ChapterConst = var_157_4

				local var_157_8

				if var_157_2 == var_157_4.ReasonDefeatDefense then
					local var_157_7 = arg_157_0

					var_157_8 = arg_157_0.HandleShowMsgBox
					var_1_10008 = {
						modal = true,
						hideNo = true
					}
					i18n = var_1_10009
					var_1_10008.content = var_1_10009("harbour_bomb_tip")
					var_1_10008.onYes = var_157_3
					var_1_10008.onClose = var_157_3

					var_157_8(var_157_7, var_1_10008)
				else
					ChapterConst = var_157_8

					if var_157_2 == var_157_8.ReasonVictoryOni then
						var_157_3()
					else
						ChapterConst = var_5

						if var_157_2 == var_5.ReasonDefeatOni then
							var_157_3()
						else
							ChapterConst = var_5

							if var_157_2 == var_5.ReasonDefeatBomb then
								var_157_3()
							else
								ChapterConst = var_5

								local var_157_10

								if var_157_2 == var_5.ReasonOutTime then
									local var_157_9 = arg_157_0

									var_157_10 = arg_157_0.emit
									LevelMediator2 = var_1_10008

									var_157_10(var_157_9, var_1_10008.ON_TIME_UP)
								else
									ChapterConst = var_157_10

									if var_157_2 == var_157_10.ReasonActivityOutTime then
										local var_157_11 = arg_157_0
										local var_157_12 = arg_157_0.HandleShowMsgBox
										local var_157_13 = {
											modal = true,
											hideNo = true
										}

										i18n = var_1_10009
										var_157_13.content = var_1_10009("battle_preCombatMediator_activity_timeout")
										var_157_13.onYes = var_157_3
										var_157_13.onClose = var_157_3

										var_157_12(var_157_11, var_157_13)
									end
								end
							end
						end
					end
				end
			end
		end

		return true
	end

	return var_157_1
end

function var_0_1.SafeCheck(arg_164_0)
	local var_164_0 = arg_164_0.contextData.chapterVO

	if var_1.existOni(var_164_0) then
		local var_164_1 = var_1

		if var_1.checkOniState(var_164_1) == 1 then
			local var_164_2 = true

			ChapterConst = var_164_1

			return var_164_2, var_164_1.ReasonVictoryOni
		elseif var_2 == 2 then
			local var_164_3 = true

			ChapterConst = var_164_1

			return var_164_3, var_164_1.ReasonDefeatOni
		else
			return false
		end
	elseif var_1:isPlayingWithBombEnemy() then
		if var_1:getBombChapterInfo().action_times * 2 <= var_1.roundIndex then
			local var_164_4 = true

			ChapterConst = var_3

			return var_164_4, var_3.ReasonDefeatBomb
		else
			return false
		end
	end

	local var_164_5, var_164_6 = var_1:CheckChapterWin()

	if var_164_5 then
		return true, var_164_6
	end

	local var_164_7, var_164_8 = var_1:CheckChapterLose()

	if var_164_7 then
		return true, var_164_8
	end

	if not var_1:inWartime() then
		local var_164_9 = true

		ChapterConst = var_1_10007

		return var_164_9, var_1_10007.ReasonOutTime
	end

	local var_164_10 = var_1:GetBindActID()
	local var_164_11 = arg_164_0.contextData.map

	if not var_7.isRemaster(var_164_11) and var_164_10 ~= 0 then
		getProxy = var_7
		ActivityProxy = var_164_11

		local var_164_12 = var_7(var_164_11)

		if not var_7.getActivityById(var_164_12, var_164_10) or var_8:isEnd() then
			local var_164_13 = true

			ChapterConst = var_164_12

			return var_164_13, var_164_12.ReasonActivityOutTime
		end
	end

	return false
end

function var_0_1.TryAutoFight(arg_165_0)
	local var_165_0 = arg_165_0.contextData.chapterVO
	local var_165_1 = arg_165_0.contextData.map

	if not var_165_0:IsAutoFight() then
		return
	end

	local var_165_2 = var_165_0:GetAllEnemies()

	_ = var_1_10004

	local var_165_3 = var_1_10004.detect(var_165_2, function(arg_166_0)
		ChapterConst = var_2_10001

		return var_2_10001.IsBossCell(arg_166_0)
	end)
	local var_165_4 = var_165_0
	local var_165_5 = var_165_0.GetFleetOfDuty

	tobool = var_1_10008

	if var_165_5(var_165_4, var_1_10008(var_165_3)) and var_5.id ~= var_165_0.fleet.id then
		local var_165_6 = arg_165_0
		local var_165_7 = arg_165_0.emit

		LevelMediator2 = var_1_10009

		local var_165_8 = var_1_10009.ON_OP
		local var_165_9 = {}

		ChapterConst = var_1_10011
		var_165_9.type = var_1_10011.OpSwitch
		var_165_9.id = var_5.id

		var_165_7(var_165_6, var_165_8, var_165_9)
		arg_165_0:tryAutoTrigger()

		return
	end

	if var_165_0:checkAnyInteractive() then
		arg_165_0:tryAutoTrigger()

		return
	end

	local var_165_10

	ipairs = var_165_4

	for iter_165_0, iter_165_1 in var_165_4(var_165_0:getConfig("box_auto_pick")) do
		underscore = var_165_11

		local var_165_11 = var_165_11.filter

		switch = var_1_10014
		iter_165_2 = iter_165_1

		local var_165_12 = {}

		ChapterConst = var_1_10018
		var_165_12[var_1_10018.AttachBox] = function()
			local var_167_0 = var_165_0

			return var_0.findChapterCells(var_167_0, iter_165_1)
		end
		ChapterConst = var_1_10018
		var_165_12[var_1_10018.AttachSupply] = function()
			local var_168_0 = var_165_0
			local var_168_1, var_168_2 = var_0.getFleetAmmo(var_168_0, var_0)

			if var_168_1 - var_168_2 < 3 then
				return {}
			else
				underscore = var_2

				local var_168_3 = var_2.filter
				local var_168_4 = var_165_0

				return var_168_3(var_4.findChapterCells(var_168_4, iter_165_1), function(arg_169_0)
					return arg_169_0.attachmentId > 0
				end)
			end

			return
		end
		var_165_11 = var_165_11(var_1_10014(iter_165_2, var_165_12), function(arg_170_0)
			local var_170_0 = arg_170_0.flag

			ChapterConst = var_2_10002

			return var_170_0 ~= var_2_10002.CellFlagDisabled
		end)
		ipairs = var_1_10013

		for iter_165_2, iter_165_3 in var_1_10013(var_165_11) do
			local var_165_13 = var_165_0

			var_1_10018 = var_165_0.findPath
			ChapterConst = var_1_10021

			local var_165_14

			var_1_10018, var_165_14 = var_1_10018(var_165_13, var_1_10021.SubjectPlayer, var_5.line, iter_165_3)
			PathFinding = var_165_13

			if var_1_10018 < var_165_13.PrioObstacle then
				var_165_10 = var_165_10 or {}
				table = var_20

				var_20.insert(var_165_10, {
					target = iter_165_3,
					priority = var_1_10018,
					path = var_165_14
				})
			end
		end

		if var_165_10 then
			table = var_1_10013
			var_1_10013 = var_1_10013.sort

			local var_165_15 = var_165_10

			CompareFuncs = iter_165_2

			var_1_10013(var_165_15, iter_165_2({
				function(arg_171_0)
					return arg_171_0.priority
				end
			}))

			break
		end
	end

	local var_165_16

	if not var_165_10 then
		if var_165_3 then
			local var_165_17

			var_165_16, var_165_17 = var_165_0:FindBossPath(var_5.line, var_165_3)

			local var_165_18 = {}

			iter_165_0 = nil
			ipairs = iter_165_1

			for iter_165_4, iter_165_5 in iter_165_1(var_165_17) do
				table = iter_165_2

				iter_165_2.insert(var_165_18, iter_165_5)

				local var_165_19 = var_165_0

				iter_165_2 = var_165_0.existEnemy
				ChapterConst = var_19

				if iter_165_2(var_165_19, var_19.SubjectPlayer, iter_165_5.row, iter_165_5.column) then
					var_165_16 = iter_165_4
					iter_165_0 = iter_165_5

					break
				end
			end

			iter_165_1 = {}

			local var_165_20 = {}

			var_1_10013 = iter_165_0 or var_165_3
			var_165_20.target = var_1_10013
			var_1_10013 = var_165_16 or 0
			var_165_20.priority = var_1_10013
			var_165_20.path = var_165_18
			iter_165_1[1] = var_165_20
			var_165_10 = iter_165_1
		else
			underscore = var_165_16
			var_165_10 = var_165_16.map(var_165_2, function(arg_172_0)
				local var_172_0 = var_165_0
				local var_172_1 = var_1.findPath

				ChapterConst = var_2_10004

				local var_172_2, var_172_3 = var_172_1(var_172_0, var_2_10004.SubjectPlayer, var_0.line, arg_172_0)

				return {
					target = arg_172_0,
					priority = var_172_2,
					path = var_172_3
				}
			end)

			function var_165_16(arg_173_0)
				local var_173_0 = arg_173_0.target

				pg = var_2_10002

				local var_173_1 = var_2_10002.expedition_data_template[var_173_0.attachmentId]

				assert = var_3

				var_3(var_173_1, "expedition_data_template not exist: " .. var_173_0.attachmentId)

				local var_173_2 = var_173_0.flag

				ChapterConst = var_2_10004

				if var_173_2 == var_2_10004.CellFlagDisabled then
					return 0
				end

				ChapterConst = var_173_2

				return var_173_2.EnemyPreference[var_173_1.type]
			end

			local var_165_21

			if var_165_0.id == 1604 then
				table = var_165_21
				var_165_21 = var_165_21.sort
				iter_165_0 = var_165_10
				CompareFuncs = iter_165_1

				var_165_21(iter_165_0, iter_165_1({
					function(arg_174_0)
						local var_174_0 = arg_174_0.priority

						PathFinding = var_2_10002

						return var_174_0 < var_2_10002.PrioObstacle and 0 or 1
					end,
					function(arg_175_0)
						return -var_165_16(arg_175_0)
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
				table = var_165_21

				local var_165_22 = var_165_21.sort

				iter_165_0 = var_165_10
				CompareFuncs = iter_165_1

				var_165_22(iter_165_0, iter_165_1({
					function(arg_179_0)
						local var_179_0 = arg_179_0.priority

						PathFinding = var_2_10002

						return var_179_0 < var_2_10002.PrioObstacle and 0 or 1
					end,
					function(arg_180_0)
						return -var_165_16(arg_180_0)
					end,
					function(arg_181_0)
						return arg_181_0.priority
					end
				}))
			end
		end
	end

	if var_165_10 then
		var_165_16 = #var_165_10

		if 0 < var_165_16 then
			var_165_16 = var_165_10[1].priority
			PathFinding = var_8

			if var_165_16 < var_8.PrioObstacle then
				var_165_16 = var_165_10[1].target
				iter_165_0 = arg_165_0

				local var_165_23 = arg_165_0.emit

				LevelMediator2 = iter_165_1

				local var_165_24 = iter_165_1.ON_OP
				local var_165_25 = {}

				ChapterConst = var_1_10013
				var_165_25.type = var_1_10013.OpMove
				var_165_25.id = var_5.id
				var_165_25.arg1 = var_165_16.row
				var_165_25.arg2 = var_165_16.column

				var_165_23(iter_165_0, var_165_24, var_165_25)

				goto label_165_0
			end
		end
	end

	pg = var_165_16

	do
		local var_165_26 = var_165_16.TipsMgr.GetInstance()
		local var_165_27 = var_7.ShowTips

		i18n = iter_165_0

		var_165_27(var_165_26, iter_165_0("autofight_errors_tip"))

		getProxy = var_165_27
		ChapterProxy = var_165_26

		local var_165_28 = var_165_27(var_165_26)

		var_7.SetChapterAutoFlag(var_165_28, var_165_0.id, false)
	end

	::label_165_0::

	return
end

function var_0_1.popStageStrategy(arg_182_0)
	local var_182_0 = arg_182_0.rightStage

	if var_1.Find(var_182_0, "event/collapse").anchoredPosition.x <= 1 then
		triggerButton = var_2

		var_2(var_1)
	end

	return
end

function var_0_1.UpdateAutoFightPanel(arg_183_0)
	local var_183_0 = arg_183_0.contextData.chapterVO

	if var_1.CanActivateAutoFight(var_183_0) then
		if not arg_183_0.autoFightPanel then
			LevelStageAutoFightPanel = var_2

			local var_183_1 = var_2.New
			local var_183_2 = arg_183_0.rightStage

			arg_183_0.autoFightPanel = var_183_1(var_4.Find(var_183_2, "event/collapse"), arg_183_0.event, arg_183_0.contextData)

			local var_183_3 = arg_183_0.autoFightPanel

			var_2.Load(var_183_3)

			arg_183_0.autoFightPanel.isFrozen = arg_183_0.isFrozen
		end

		local var_183_4 = arg_183_0.autoFightPanel.buffer

		var_2.Show(var_183_4)
	elseif arg_183_0.autoFightPanel then
		local var_183_5 = arg_183_0.autoFightPanel.buffer

		var_2.Hide(var_183_5)
	end

	return
end

function var_0_1.UpdateAutoFightMark(arg_184_0)
	if not arg_184_0.autoFightPanel then
		return
	end

	local var_184_0 = arg_184_0.autoFightPanel.buffer

	var_1.UpdateAutoFightMark(var_184_0)

	return
end

function var_0_1.DestroyAutoFightPanel(arg_185_0)
	if not arg_185_0.autoFightPanel then
		return
	end

	local var_185_0 = arg_185_0.autoFightPanel

	var_1.Destroy(var_185_0)

	arg_185_0.autoFightPanel = nil

	return
end

function var_0_1.DestroyToast(arg_186_0)
	if not arg_186_0.toastPanel then
		return
	end

	local var_186_0 = arg_186_0.toastPanel

	var_1.Destroy(var_186_0)

	arg_186_0.toastPanel = nil

	return
end

function var_0_1.Toast(arg_187_0)
	arg_187_0:DestroyToast()

	table = var_1

	if not var_1.remove(arg_187_0.toastQueue, 1) then
		return
	end

	arg_187_0.toastPanel = var_1.Class.New(arg_187_0)

	local var_187_0 = arg_187_0.toastPanel

	var_2.Load(var_187_0)

	arg_187_0.toastPanel.contextData.settings = var_1

	local var_187_1 = arg_187_0.toastPanel.buffer

	var_2.Play(var_187_1, function()
		local var_188_0 = arg_187_0

		var_0.Toast(var_188_0)

		return
	end)

	return
end

function var_0_1.HandleShowMsgBox(arg_189_0, arg_189_1)
	pg = var_1_10002

	local var_189_0 = var_1_10002.MsgboxMgr.GetInstance()

	var_2.ShowMsgBox(var_189_0, arg_189_1)

	return
end

return var_0_1
