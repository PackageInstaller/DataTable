local var_0_0 = class("BattleMediator", import("..base.ContextMediator"))

var_0_0.ON_BATTLE_RESULT = "BattleMediator:ON_BATTLE_RESULT"
var_0_0.ON_PAUSE = "BattleMediator:ON_PAUSE"
var_0_0.ENTER = "BattleMediator:ENTER"
var_0_0.ON_BACK_PRE_SCENE = "BattleMediator:ON_BACK_PRE_SCENE"
var_0_0.ON_LEAVE = "BattleMediator:ON_LEAVE"
var_0_0.ON_QUIT_BATTLE_MANUALLY = "BattleMediator:ON_QUIT_BATTLE_MANUALLY"
var_0_0.HIDE_ALL_BUTTONS = "BattleMediator:HIDE_ALL_BUTTONS"
var_0_0.ON_CHAT = "BattleMediator:ON_CHAT"
var_0_0.CLOSE_CHAT = "BattleMediator:CLOSE_CHAT"
var_0_0.ON_AUTO = "BattleMediator:ON_AUTO"
var_0_0.UPDATE_AUTO_COUNT = "BattleMediator:UPDATE_AUTO_COUNT"
var_0_0.ON_PUZZLE_RELIC = "BattleMediator.ON_PUZZLE_RELIC"
var_0_0.ON_PUZZLE_CARD = "BattleMediator.ON_PUZZLE_CARD"

function var_0_0.register(arg_1_0)
	pg.BrightnessMgr.GetInstance():SetScreenNeverSleep(true)
	arg_1_0:GenBattleData()

	arg_1_0.contextData.battleData = arg_1_0._battleData

	local var_1_0 = ys.Battle.BattleState.GetInstance()
	local var_1_1 = arg_1_0.contextData.system

	arg_1_0:bind(var_0_0.ON_BATTLE_RESULT, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.FINISH_STAGE, {
			token = arg_1_0.contextData.token,
			mainFleetId = arg_1_0.contextData.mainFleetId,
			stageId = arg_1_0.contextData.stageId,
			rivalId = arg_1_0.contextData.rivalId,
			memory = arg_1_0.contextData.memory,
			bossId = arg_1_0.contextData.bossId,
			exitCallback = arg_1_0.contextData.exitCallback,
			system = var_1_1,
			statistics = arg_2_1,
			actId = arg_1_0.contextData.actId,
			mode = arg_1_0.contextData.mode,
			puzzleCombatID = arg_1_0.contextData.puzzleCombatID,
			useVariableTicket = arg_1_0.contextData.useVariableTicket,
			isSimulate = arg_1_0.contextData.isSimulate
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_AUTO, function(arg_3_0, arg_3_1)
		arg_1_0:onAutoBtn(arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_PAUSE, function(arg_4_0)
		arg_1_0:onPauseBtn()

		return
	end)
	arg_1_0:bind(var_0_0.ON_LEAVE, function(arg_5_0)
		arg_1_0:warnFunc()

		return
	end)
	arg_1_0:bind(var_0_0.ON_CHAT, function(arg_6_0, arg_6_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = NotificationMediator,
			viewComponent = NotificationLayer,
			data = {
				form = NotificationLayer.FORM_BATTLE
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ENTER, function(arg_7_0)
		var_1_0:EnterBattle(arg_1_0._battleData, arg_1_0.contextData.prePause)

		return
	end)
	arg_1_0:bind(var_0_0.ON_BACK_PRE_SCENE, function()
		local var_8_0 = getProxy(ContextProxy)
		local var_8_1 = var_8_0:getContextByMediator(DailyLevelMediator)
		local var_8_2 = var_8_0:getContextByMediator(LevelMediator2)
		local var_8_3 = var_8_0:getContextByMediator(ChallengeMainMediator)
		local var_8_4 = var_8_0:getContextByMediator(ActivityBossMediatorTemplate)
		local var_8_5 = var_8_0:getContextByMediator(WorldMediator)
		local var_8_6 = var_8_0:getContextByMediator(WorldBossMediator)
		local var_8_7, var_8_8 = var_8_0:getContextByMediator(BossSinglePreCombatMediator)

		if var_8_6 and arg_1_0.contextData.bossId then
			arg_1_0:sendNotification(GAME.WORLD_BOSS_BATTLE_QUIT, {
				id = arg_1_0.contextData.bossId
			})

			local var_8_9 = var_8_6:getContextByMediator(WorldBossFormationMediator)

			if var_8_9 then
				var_8_6:removeChild(var_8_9)
			end
		elseif var_8_5 then
			local var_8_10 = var_8_5:getContextByMediator(WorldPreCombatMediator) or var_8_5:getContextByMediator(WorldBossInformationMediator)

			if var_8_10 then
				var_8_5:removeChild(var_8_10)
			end
		elseif var_8_1 then
			var_8_1:removeChild((var_8_1:getContextByMediator(PreCombatMediator)))
		elseif var_8_3 then
			arg_1_0:sendNotification(GAME.CHALLENGE2_RESET, {
				mode = arg_1_0.contextData.mode
			})
			var_8_3:removeChild((var_8_3:getContextByMediator(ChallengePreCombatMediator)))
		elseif var_8_2 then
			if var_1_1 == SYSTEM_DUEL then
				-- block empty
			elseif var_1_1 == SYSTEM_SCENARIO then
				local var_8_11 = var_8_2:getContextByMediator(ChapterPreCombatMediator)

				if var_8_11 then
					var_8_2:removeChild(var_8_11)
				end
			elseif var_1_1 ~= SYSTEM_PERFORM and var_1_1 ~= SYSTEM_SIMULATION then
				local var_8_12 = var_8_2:getContextByMediator(PreCombatMediator)

				if var_8_12 then
					var_8_2:removeChild(var_8_12)
				end
			end
		elseif var_8_4 then
			local var_8_13 = var_8_4:getContextByMediator(PreCombatMediator)

			if var_8_13 then
				var_8_4:removeChild(var_8_13)
			end
		elseif var_8_7 then
			local var_8_14 = var_8_8:removeChild(var_8_7)
		end

		arg_1_0:sendNotification(GAME.GO_BACK)

		return
	end)
	arg_1_0:bind(var_0_0.ON_QUIT_BATTLE_MANUALLY, function(arg_9_0)
		if var_1_1 == SYSTEM_SCENARIO then
			getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.MANUAL)
		elseif var_1_1 == SYSTEM_WORLD then
			nowWorld():TriggerAutoFight(false)
		elseif var_1_1 == SYSTEM_ACT_BOSS then
			if getProxy(ContextProxy):getCurrentContext():getContextByMediator(ContinuousOperationMediator) then
				({
					isLayer = true,
					isAutoFight = false
				}).rewards = getProxy(ChapterProxy):PopActBossRewards()
				;({
					isLayer = true,
					isAutoFight = false
				}).continuousBattleTimes = arg_1_0.contextData.continuousBattleTimes
				;({
					isLayer = true,
					isAutoFight = false
				}).totalBattleTimes = arg_1_0.contextData.totalBattleTimes
				;({
					mediator = ActivityBossTotalRewardPanelMediator,
					viewComponent = ActivityBossTotalRewardPanel
				}).data = {
					isLayer = true,
					isAutoFight = false
				}

				getProxy(ContextProxy):GetPrevContext(1):addChild(Context.New({
					mediator = ActivityBossTotalRewardPanelMediator,
					viewComponent = ActivityBossTotalRewardPanel
				}))
			end
		elseif var_1_1 == SYSTEM_BOSS_RUSH or var_1_1 == SYSTEM_BOSS_RUSH_COLLABRATE then
			local var_9_0 = getProxy(ContextProxy):getCurrentContext()

			if var_9_0:getContextByMediator(ContinuousOperationMediator) then
				getProxy(ContextProxy):GetPrevContext(1):addChild(Context.New({
					mediator = BossRushTotalRewardPanelMediator,
					viewComponent = BossRushTotalRewardPanel,
					data = {
						isAutoFight = false,
						isLayer = true,
						rewards = getProxy(ActivityProxy):PopBossRushAwards()
					}
				}))
			end
		elseif var_1_1 == SYSTEM_BOSS_SINGLE or var_1_1 == SYSTEM_BOSS_SINGLE_VARIABLE then
			local var_9_1 = getProxy(ContextProxy):getCurrentContext()

			if var_9_1:getContextByMediator(BossSingleContinuousOperationMediator) then
				({
					isLayer = true,
					isAutoFight = false
				}).rewards = getProxy(ChapterProxy):PopBossSingleRewards()
				;({
					isLayer = true,
					isAutoFight = false
				}).continuousBattleTimes = arg_1_0.contextData.continuousBattleTimes
				;({
					isLayer = true,
					isAutoFight = false
				}).totalBattleTimes = arg_1_0.contextData.totalBattleTimes
				;({
					mediator = BossSingleTotalRewardPanelMediator,
					viewComponent = BossSingleTotalRewardPanel
				}).data = {
					isLayer = true,
					isAutoFight = false
				}

				getProxy(ContextProxy):GetPrevContext(1):addChild(Context.New({
					mediator = BossSingleTotalRewardPanelMediator,
					viewComponent = BossSingleTotalRewardPanel
				}))
			end
		end

		return
	end)
	arg_1_0:bind(var_0_0.ON_PUZZLE_RELIC, function(arg_10_0, arg_10_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = CardPuzzleRelicDeckMediator,
			viewComponent = CardPuzzleRelicDeckLayerCombat,
			data = arg_10_1
		}))
		var_1_0:Pause()

		return
	end)
	arg_1_0:bind(var_0_0.ON_PUZZLE_CARD, function(arg_11_0, arg_11_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = CardPuzzleCardDeckMediator,
			viewComponent = CardPuzzleCardDeckLayerCombat,
			data = arg_11_1
		}))
		var_1_0:Pause()

		return
	end)

	if arg_1_0.contextData.continuousBattleTimes and arg_1_0.contextData.continuousBattleTimes > 0 then
		if arg_1_0.contextData.system == SYSTEM_BOSS_SINGLE or arg_1_0.contextData.system == SYSTEM_BOSS_SINGLE_VARIABLE then
			local var_1_2 = getProxy(ContextProxy):getCurrentContext()

			if not var_1_2:getContextByMediator(BossSingleContinuousOperationMediator) then
				arg_1_0:addSubLayers(Context.New({
					mediator = BossSingleContinuousOperationMediator,
					viewComponent = BossSingleContinuousOperationPanel,
					data = CreateShell(arg_1_0.contextData)
				}))
			end
		else
			local var_1_3 = getProxy(ContextProxy):getCurrentContext()

			if not var_1_3:getContextByMediator(ContinuousOperationMediator) then
				arg_1_0:addSubLayers(Context.New({
					mediator = ContinuousOperationMediator,
					viewComponent = ContinuousOperationPanel,
					data = CreateShell(arg_1_0.contextData)
				}))
			end
		end

		arg_1_0.contextData.battleData.hideAllButtons = true
	end

	local var_1_4 = getProxy(PlayerProxy)

	if var_1_4 then
		arg_1_0.player = var_1_4:getData()

		var_1_4:setFlag("battle", true)
		var_1_4:setFlag("random_skin", true)
	end

	return
end

function var_0_0.onAutoBtn(arg_12_0, arg_12_1)
	arg_12_0:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_12_1.isOn,
		toggle = arg_12_1.toggle,
		system = arg_12_1.system
	})

	return
end

function var_0_0.updateAutoCount(arg_13_0, arg_13_1)
	local var_13_0 = ys.Battle.BattleState.GetInstance():GetProxyByName(ys.Battle.BattleDataProxy.__name):AutoStatistics(arg_13_1.isOn)

	return
end

function var_0_0.onPauseBtn(arg_14_0)
	local var_14_0 = ys.Battle.BattleState.GetInstance()

	if arg_14_0.contextData.system == SYSTEM_PROLOGUE or arg_14_0.contextData.system == SYSTEM_PERFORM then
		local var_14_1 = {}

		if EPILOGUE_SKIPPABLE then
			table.insert(var_14_1, 1, {
				text = "关爱胡德",
				btnType = pg.MsgboxMgr.BUTTON_RED,
				onCallback = function()
					var_14_0:Deactive()
					arg_14_0:sendNotification(GAME.CHANGE_SCENE, SCENE.CREATE_PLAYER)

					return
				end
			})
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("help_battle_rule"),
			onClose = function()
				ys.Battle.BattleState.GetInstance():Resume()

				return
			end,
			onNo = function()
				ys.Battle.BattleState.GetInstance():Resume()

				return
			end,
			custom = var_14_1
		})
		var_14_0:Pause()
	elseif arg_14_0.contextData.system == SYSTEM_DODGEM then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("help_battle_warspite"),
			onClose = function()
				ys.Battle.BattleState.GetInstance():Resume()

				return
			end,
			onNo = function()
				ys.Battle.BattleState.GetInstance():Resume()

				return
			end,
			custom = {
				{
					text = "text_cancel_fight",
					btnType = pg.MsgboxMgr.BUTTON_RED,
					onCallback = function()
						arg_14_0:warnFunc(function()
							ys.Battle.BattleState.GetInstance():Resume()

							return
						end)

						return
					end
				}
			}
		})
		var_14_0:Pause()
	elseif arg_14_0.contextData.system == SYSTEM_SIMULATION then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("help_battle_rule"),
			onClose = function()
				ys.Battle.BattleState.GetInstance():Resume()

				return
			end,
			onNo = function()
				ys.Battle.BattleState.GetInstance():Resume()

				return
			end,
			custom = {
				{
					text = "text_cancel_fight",
					btnType = pg.MsgboxMgr.BUTTON_RED,
					onCallback = function()
						arg_14_0:warnFunc(function()
							ys.Battle.BattleState.GetInstance():Resume()

							return
						end)

						return
					end
				}
			}
		})
		var_14_0:Pause()
	elseif arg_14_0.contextData.system == SYSTEM_SUBMARINE_RUN or arg_14_0.contextData.system == SYSTEM_SUB_ROUTINE or arg_14_0.contextData.system == SYSTEM_REWARD_PERFORM or arg_14_0.contextData.system == SYSTEM_AIRFIGHT then
		var_14_0:Pause()
		arg_14_0:warnFunc(function()
			ys.Battle.BattleState.GetInstance():Resume()

			return
		end)
	elseif arg_14_0.contextData.system == SYSTEM_CARDPUZZLE then
		arg_14_0:addSubLayers(Context.New({
			mediator = CardPuzzleCombatPauseMediator,
			viewComponent = CardPuzzleCombatPauseLayer
		}))
		var_14_0:Pause()
	else
		arg_14_0.viewComponent:updatePauseWindow()
		var_14_0:Pause()
	end

	return
end

function var_0_0.warnFunc(arg_27_0, arg_27_1)
	local var_27_0 = ys.Battle.BattleState.GetInstance()
	local var_27_2

	local function var_27_3()
		var_27_0:Stop()

		return
	end

	if arg_27_0.contextData.warnMsg and #arg_27_0.contextData.warnMsg > 0 then
		var_27_2 = i18n(arg_27_0.contextData.warnMsg)
	elseif arg_27_0.contextData.system == SYSTEM_CHALLENGE then
		var_27_2 = i18n("battle_battleMediator_clear_warning")
	elseif arg_27_0.contextData.system == SYSTEM_SIMULATION then
		var_27_2 = i18n("tech_simulate_quit")
	elseif arg_27_0.contextData.system == SYSTEM_SCENARIO_SUB_STRIKE then
		var_27_2 = i18n("battle_battleMediator_quest_exist_submarine_support")

		function var_27_3()
			var_27_0:GetCommandByName(ys.Battle.BattleScenarioSubStrikeCommand.__name):CalcBattleEnd()
			arg_27_0.viewComponent:ClosePauseWindow()

			return
		end
	else
		var_27_2 = i18n("battle_battleMediator_quest_exist")
	end

	;({
		text = "text_cancel"
	}).onCallback = function()
		if arg_27_1 then
			arg_27_1()
		end

		local var_30_0 = arg_27_0.viewComponent.leaveBtn:GetComponent(typeof(Animation))

		if var_30_0 then
			var_30_0:Play("msgbox_btn_into")
		end

		return
	end
	;({
		text = "text_cancel"
	}).sound = SFX_CANCEL
	;({})[1] = {
		text = "text_cancel"
	}
	;({})[2] = {
		text = "text_exit",
		btnType = pg.MsgboxMgr.BUTTON_RED,
		onCallback = var_27_3,
		sound = SFX_CONFIRM
	}
	;({
		modal = true,
		hideYes = true,
		hideNo = true,
		content = var_27_2,
		onClose = function()
			if arg_27_1 then
				arg_27_1()
			end

			local var_30_0 = arg_27_0.viewComponent.leaveBtn:GetComponent(typeof(Animation))

			if var_30_0 then
				var_30_0:Play("msgbox_btn_into")
			end

			return
		end
	}).custom = {}

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		modal = true,
		hideYes = true,
		hideNo = true,
		content = var_27_2,
		onClose = function()
			if arg_27_1 then
				arg_27_1()
			end

			local var_30_0 = arg_27_0.viewComponent.leaveBtn:GetComponent(typeof(Animation))

			if var_30_0 then
				var_30_0:Play("msgbox_btn_into")
			end

			return
		end
	})

	return
end

function var_0_0.guideDispatch(arg_31_0)
	return
end

local function var_0_1(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	for iter_32_0, iter_32_1 in ipairs(arg_32_1:getActiveEquipments()) do
		if iter_32_1 then
			({})[#{} + 1] = {
				id = iter_32_1.configId,
				skin = iter_32_1.skinId,
				equipmentInfo = iter_32_1
			}
		else
			({})[#{} + 1] = {
				skin = 0,
				id = iter_32_1,
				equipmentInfo = iter_32_1
			}
		end
	end

	local var_32_0 = {}

	for iter_32_2, iter_32_3 in pairs((ys.Battle.BattleDataFunction.GenerateHiddenBuff(arg_32_1.configId))) do
		local var_32_1 = (function(arg_33_0)
			return {
				level = arg_33_0.level,
				id = ys.Battle.BattleDataFunction.SkillTranform(arg_32_0, (arg_32_1:RemapSkillId(arg_33_0.id, true)))
			}
		end)(iter_32_3)

		var_32_0[var_32_1.id] = var_32_1
	end

	for iter_32_4, iter_32_5 in pairs(arg_32_1.skills) do
		if iter_32_5 and iter_32_5.id == 14900 and not arg_32_1.transforms[16412] then
			-- block empty
		else
			local var_32_2 = (function(arg_33_0)
				return {
					level = arg_33_0.level,
					id = ys.Battle.BattleDataFunction.SkillTranform(arg_32_0, (arg_32_1:RemapSkillId(arg_33_0.id, true)))
				}
			end)(iter_32_5)

			var_32_0[var_32_2.id] = var_32_2
		end
	end

	for iter_32_6, iter_32_7 in ipairs((ys.Battle.BattleDataFunction.GetEquipSkill({}))) do
		local var_32_3 = {
			level = iter_32_7.buffLV,
			id = ys.Battle.BattleDataFunction.SkillTranform(arg_32_0, iter_32_7.buffID)
		}

		var_32_0[var_32_3.id] = var_32_3
	end

	local var_32_4

	;(function()
		var_32_4 = arg_32_1:GetSpWeapon()

		if not var_32_4 then
			return
		end

		local var_34_0 = var_32_4:GetEffect()

		if var_34_0 == 0 then
			return
		end

		local var_34_1 = {}

		var_34_1.level = 1
		var_34_1.id = ys.Battle.BattleDataFunction.SkillTranform(arg_32_0, var_34_0)
		var_32_0[var_34_1.id] = var_34_1

		return
	end)()

	for iter_32_8, iter_32_9 in pairs(arg_32_1:getTriggerSkills()) do
		local var_32_5 = {
			level = iter_32_9.level,
			id = ys.Battle.BattleDataFunction.SkillTranform(arg_32_0, iter_32_9.id)
		}

		var_32_0[var_32_5.id] = var_32_5
	end

	local var_32_6 = arg_32_0 == SYSTEM_WORLD
	local var_32_7 = false

	if arg_32_0 == SYSTEM_WORLD then
		local var_32_8 = WorldConst.FetchWorldShip(arg_32_1.id)

		if var_32_8 then
			var_32_7 = var_32_8:IsBroken()
		end
	end

	if var_32_7 then
		for iter_32_10, iter_32_11 in pairs(var_32_0) do
			if pg.skill_data_template[iter_32_10].world_death_mark[1] == ys.Battle.BattleConst.DEATH_MARK_SKILL.DEACTIVE then
				var_32_0[iter_32_10] = nil
			elseif pg.skill_data_template[iter_32_10].world_death_mark[1] == ys.Battle.BattleConst.DEATH_MARK_SKILL.IGNORE then
				-- block empty
			end
		end
	end

	return {
		id = arg_32_1.id,
		tmpID = arg_32_1.configId,
		skinId = arg_32_1.skinId,
		level = arg_32_1.level,
		equipment = {},
		properties = arg_32_1:getProperties(arg_32_2, arg_32_3, var_32_6),
		baseProperties = arg_32_1:getShipProperties(),
		proficiency = arg_32_1:getEquipProficiencyList(),
		rarity = arg_32_1:getRarity(),
		intimacy = arg_32_1:getCVIntimacy(),
		shipGS = arg_32_1:getShipCombatPower(),
		skills = var_32_0,
		baseList = arg_32_1:getBaseList(),
		preloasList = arg_32_1:getPreLoadCount(),
		name = arg_32_1:getName(),
		deathMark = var_32_7,
		spWeapon = var_32_4
	}
end

local function var_0_2(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:getProperties(arg_35_1)
	local var_35_1 = arg_35_0:getConfig("id")

	return {
		shipGS = 100,
		intimacy = 100,
		rarity = 1,
		deathMark = false,
		id = var_35_1,
		tmpID = var_35_1,
		skinId = arg_35_0:getConfig("skin_id"),
		level = arg_35_0:getConfig("level"),
		equipment = arg_35_0:getConfig("default_equip"),
		properties = var_35_0,
		baseProperties = var_35_0,
		proficiency = {
			1,
			1,
			1
		},
		skills = {},
		baseList = {
			1,
			1,
			1
		},
		preloasList = {
			0,
			0,
			0
		},
		name = var_35_1,
		fleetIndex = arg_35_0:getConfig("location")
	}
end

function var_0_0.GenBattleData(arg_36_0)
	local var_36_9000
	local var_36_0 = {}
	local var_36_1 = arg_36_0.contextData.system

	arg_36_0._battleData = {}
	;({}).battleType = arg_36_0.contextData.system
	;({}).StageTmpId = arg_36_0.contextData.stageId
	;({}).CMDArgs = arg_36_0.contextData.cmdArgs
	;({}).isMemory = arg_36_0.contextData.memory
	;({}).MainUnitList = {}
	;({}).VanguardUnitList = {}
	;({}).SubUnitList = {}
	;({}).AidUnitList = {}
	;({}).SupportUnitList = {}
	;({}).SubFlag = -1
	;({}).ActID = arg_36_0.contextData.actId
	;({}).bossLevel = arg_36_0.contextData.bossLevel
	;({}).bossConfigId = arg_36_0.contextData.bossConfigId

	if pg.battle_cost_template[var_36_1].global_buff_effected > 0 then
		({}).GlobalBuffIDs = underscore.filter(BuffHelper.GetBattleBuffs(var_36_1), function(arg_37_0)
			local var_37_0

			if var_36_1 == SYSTEM_SCENARIO then
				table.insert({
					"dungeon"
				}, "chapter")

				var_37_0 = getProxy(ChapterProxy):getActiveChapter().id
			end

			return underscore.all({
				"dungeon"
			}, function(arg_38_0)
				return switch(arg_38_0, {
					chapter = function()
						return arg_37_0:checkChaper(var_37_0)
					end,
					dungeon = function()
						return arg_37_0:checkDungeon(arg_36_0.contextData.stageId)
					end
				}, function()
					return false
				end)
			end)
		end)
	end

	local var_36_2 = pg.battle_cost_template[var_36_1]
	local var_36_3 = getProxy(BayProxy)
	local var_36_4 = {}

	if var_36_1 == SYSTEM_SCENARIO then
		local var_36_5 = getProxy(ChapterProxy)
		local var_36_6 = var_36_5:getActiveChapter()

		;({}).RepressInfo = var_36_6:getRepressInfo()

		arg_36_0.viewComponent:setChapter(var_36_6)

		;({}).KizunaJamming = var_36_6:getExtraFlags()
		;({}).DefeatCount = var_36_6.fleet:getDefeatCount()
		var_36_0.ChapterBuffIDs, var_36_0.CommanderList = var_36_6:getFleetBattleBuffs(var_36_6.fleet)
		;({}).StageWaveFlags = var_36_6:GetStageFlags()
		;({}).ChapterWeatherIDS = var_36_6:GetWeather(var_36_6.fleet.line.row, var_36_6.fleet.line.column)
		;({}).MapAuraSkills = var_36_5.GetChapterAuraBuffs(var_36_6)
		;({}).MapAidSkills = {}
		;({}).ChapterType = var_36_6:getPlayType()

		for iter_36_0, iter_36_1 in pairs((var_36_5.GetChapterAidBuffs(var_36_6))) do
			local var_36_7 = var_36_6:getFleetByShipVO(iter_36_0)

			table.insert(({}).AidUnitList, (var_0_1(var_36_1, iter_36_0, (_.values(var_36_7:getCommanders())))))

			for iter_36_2, iter_36_3 in ipairs(iter_36_1) do
				table.insert(({}).MapAidSkills, iter_36_3)
			end
		end

		local var_36_8 = var_36_6.fleet:getShipsByTeam(TeamType.Main, false)
		local var_36_9 = var_36_6.fleet:getShipsByTeam(TeamType.Vanguard, false)
		local var_36_10 = {}
		local var_36_11 = _.values(var_36_6.fleet:getCommanders())
		local var_36_12 = {}
		local var_36_13, var_36_14 = var_36_5.getSubAidFlag(var_36_6, arg_36_0.contextData.stageId)

		if var_36_13 == true or var_36_13 > 0 then
			({}).SubFlag = 1
			;({}).TotalSubAmmo = 1
			var_36_10 = var_36_14:getShipsByTeam(TeamType.Submarine, false)
			var_36_12 = _.values(var_36_14:getCommanders())

			local var_36_15, var_36_16 = var_36_6:getFleetBattleBuffs(var_36_14)

			;({}).SubCommanderList = var_36_16
		else
			({}).SubFlag = var_36_13

			if var_36_13 ~= ys.Battle.BattleConst.SubAidFlag.AID_EMPTY then
				({}).TotalSubAmmo = 0
			end
		end

		arg_36_0.mainShips = {}

		for iter_36_4, iter_36_5 in ipairs(var_36_8) do
			(function(arg_42_0, arg_42_1, arg_42_2)
				if table.contains(var_36_4, arg_42_0.id) then
					BattleVertify.cloneShipVertiry = true
				end

				var_36_4[#var_36_4 + 1] = arg_42_0.id

				local var_42_0 = var_0_1(var_36_1, arg_42_0, arg_42_1)

				var_42_0.initHPRate = arg_42_0.hpRant * 0.0001

				table.insert(arg_36_0.mainShips, arg_42_0)
				table.insert(arg_42_2, var_42_0)

				return
			end)(iter_36_5, var_36_11, ({}).MainUnitList)
		end

		for iter_36_6, iter_36_7 in ipairs(var_36_9) do
			(function(arg_42_0, arg_42_1, arg_42_2)
				if table.contains(var_36_4, arg_42_0.id) then
					BattleVertify.cloneShipVertiry = true
				end

				var_36_4[#var_36_4 + 1] = arg_42_0.id

				local var_42_0 = var_0_1(var_36_1, arg_42_0, arg_42_1)

				var_42_0.initHPRate = arg_42_0.hpRant * 0.0001

				table.insert(arg_36_0.mainShips, arg_42_0)
				table.insert(arg_42_2, var_42_0)

				return
			end)(iter_36_7, var_36_11, ({}).VanguardUnitList)
		end

		for iter_36_8, iter_36_9 in ipairs(var_36_10) do
			(function(arg_42_0, arg_42_1, arg_42_2)
				if table.contains(var_36_4, arg_42_0.id) then
					BattleVertify.cloneShipVertiry = true
				end

				var_36_4[#var_36_4 + 1] = arg_42_0.id

				local var_42_0 = var_0_1(var_36_1, arg_42_0, arg_42_1)

				var_42_0.initHPRate = arg_42_0.hpRant * 0.0001

				table.insert(arg_36_0.mainShips, arg_42_0)
				table.insert(arg_42_2, var_42_0)

				return
			end)(iter_36_9, var_36_12, ({}).SubUnitList)
		end

		local var_36_17 = var_36_6:getChapterSupportFleet()

		if var_36_17 then
			for iter_36_10, iter_36_11 in pairs((var_36_17:getShips())) do
				(function(arg_42_0, arg_42_1, arg_42_2)
					if table.contains(var_36_4, arg_42_0.id) then
						BattleVertify.cloneShipVertiry = true
					end

					var_36_4[#var_36_4 + 1] = arg_42_0.id

					local var_42_0 = var_0_1(var_36_1, arg_42_0, arg_42_1)

					var_42_0.initHPRate = arg_42_0.hpRant * 0.0001

					table.insert(arg_36_0.mainShips, arg_42_0)
					table.insert(arg_42_2, var_42_0)

					return
				end)(iter_36_11, {}, ({}).SupportUnitList)
			end
		end

		arg_36_0.viewComponent:setFleet(var_36_8, var_36_9, var_36_10)

		goto label_36_1
	end

	if var_36_1 == SYSTEM_CHALLENGE then
		local var_36_18 = getProxy(ChallengeProxy):getUserChallengeInfo(arg_36_0.contextData.mode)

		;({}).ChallengeInfo = var_36_18

		arg_36_0.viewComponent:setChapter(var_36_18)

		local var_36_19 = var_36_18:getRegularFleet()

		;({}).CommanderList = var_36_19:buildBattleBuffList()

		local var_36_20 = _.values(var_36_19:getCommanders())
		local var_36_21 = {}
		local var_36_22 = var_36_19:getShipsByTeam(TeamType.Main, false)
		local var_36_23 = var_36_19:getShipsByTeam(TeamType.Vanguard, false)
		local var_36_25 = var_36_18:getSubmarineFleet()
		local var_36_26 = var_36_25:getShipsByTeam(TeamType.Submarine, false)

		if #{} > 0 then
			({}).SubFlag = 1
			;({}).TotalSubAmmo = 1
			var_36_21 = _.values(var_36_25:getCommanders())
			;({}).SubCommanderList = var_36_25:buildBattleBuffList()
		else
			({}).SubFlag = 0
			;({}).TotalSubAmmo = 0
		end

		arg_36_0.mainShips = {}

		for iter_36_12, iter_36_13 in ipairs(var_36_22) do
			(function(arg_43_0, arg_43_1, arg_43_2)
				if table.contains(var_36_4, arg_43_0.id) then
					BattleVertify.cloneShipVertiry = true
				end

				var_36_4[#var_36_4 + 1] = arg_43_0.id

				local var_43_0 = var_0_1(var_36_1, arg_43_0, arg_43_1)

				var_43_0.initHPRate = arg_43_0.hpRant * 0.0001

				table.insert(arg_36_0.mainShips, arg_43_0)
				table.insert(arg_43_2, var_43_0)

				return
			end)(iter_36_13, var_36_20, ({}).MainUnitList)
		end

		for iter_36_14, iter_36_15 in ipairs(var_36_23) do
			(function(arg_43_0, arg_43_1, arg_43_2)
				if table.contains(var_36_4, arg_43_0.id) then
					BattleVertify.cloneShipVertiry = true
				end

				var_36_4[#var_36_4 + 1] = arg_43_0.id

				local var_43_0 = var_0_1(var_36_1, arg_43_0, arg_43_1)

				var_43_0.initHPRate = arg_43_0.hpRant * 0.0001

				table.insert(arg_36_0.mainShips, arg_43_0)
				table.insert(arg_43_2, var_43_0)

				return
			end)(iter_36_15, var_36_20, ({}).VanguardUnitList)
		end

		for iter_36_16, iter_36_17 in ipairs(var_36_26) do
			(function(arg_43_0, arg_43_1, arg_43_2)
				if table.contains(var_36_4, arg_43_0.id) then
					BattleVertify.cloneShipVertiry = true
				end

				var_36_4[#var_36_4 + 1] = arg_43_0.id

				local var_43_0 = var_0_1(var_36_1, arg_43_0, arg_43_1)

				var_43_0.initHPRate = arg_43_0.hpRant * 0.0001

				table.insert(arg_36_0.mainShips, arg_43_0)
				table.insert(arg_43_2, var_43_0)

				return
			end)(iter_36_17, var_36_21, ({}).SubUnitList)
		end

		arg_36_0.viewComponent:setFleet(var_36_22, var_36_23, var_36_26)

		goto label_36_1
	end

	if var_36_1 == SYSTEM_WORLD then
		local var_36_27 = nowWorld()
		local var_36_28 = var_36_27:GetActiveMap()
		local var_36_29 = var_36_28:GetFleet()
		local var_36_30 = var_36_28:GetCell(var_36_29.row, var_36_29.column):GetStageEnemy()

		if arg_36_0.contextData.hpRate then
			({}).RepressInfo = {
				repressEnemyHpRant = arg_36_0.contextData.hpRate
			}
		end

		;({}).AffixBuffList = table.mergeArray(var_36_30:GetBattleLuaBuffs(), var_36_28:GetBattleLuaBuffs(WorldMap.FactionEnemy, var_36_30))
		;({}).DefeatCount = var_36_29:getDefeatCount()
		var_36_0.ChapterBuffIDs, var_36_0.CommanderList = var_36_28:getFleetBattleBuffs(var_36_29, true)
		;({}).MapAuraSkills = var_36_28:GetChapterAuraBuffs()
		;({}).MapAuraSkills = (function(arg_44_0)
			for iter_44_0, iter_44_1 in ipairs(arg_44_0) do
				table.insert({}, {
					id = ys.Battle.BattleDataFunction.SkillTranform(var_36_1, iter_44_1.id),
					level = iter_44_1.level
				})
			end

			return {}
		end)(({}).MapAuraSkills)
		;({}).MapAidSkills = {}

		for iter_36_18, iter_36_19 in pairs((var_36_28:GetChapterAidBuffs())) do
			local var_36_31 = var_36_28:GetFleet(iter_36_18.fleetId)

			table.insert(({}).AidUnitList, (var_0_1(var_36_1, WorldConst.FetchShipVO(iter_36_18.id), (_.values(var_36_31:getCommanders(true))))))

			;({}).MapAidSkills = table.mergeArray(({}).MapAidSkills, (function(arg_44_0)
				for iter_44_0, iter_44_1 in ipairs(arg_44_0) do
					table.insert({}, {
						id = ys.Battle.BattleDataFunction.SkillTranform(var_36_1, iter_44_1.id),
						level = iter_44_1.level
					})
				end

				return {}
			end)(iter_36_19))
		end

		local var_36_32 = var_36_29:GetTeamShipVOs(TeamType.Main, false)
		local var_36_33 = var_36_29:GetTeamShipVOs(TeamType.Vanguard, false)
		local var_36_34 = {}
		local var_36_35 = _.values(var_36_29:getCommanders(true))
		local var_36_36 = {}
		local var_36_37 = var_36_27:GetSubAidFlag()

		if var_36_37 == true then
			local var_36_38 = var_36_28:GetSubmarineFleet()

			;({}).SubFlag = 1
			;({}).TotalSubAmmo = 1
			var_36_34 = var_36_38:GetTeamShipVOs(TeamType.Submarine, false)
			var_36_36 = _.values(var_36_38:getCommanders(true))

			local var_36_39, var_36_40 = var_36_28:getFleetBattleBuffs(var_36_38, true)

			;({}).SubCommanderList = var_36_40
		else
			({}).SubFlag = 0

			if var_36_37 ~= ys.Battle.BattleConst.SubAidFlag.AID_EMPTY then
				({}).TotalSubAmmo = 0
			end
		end

		arg_36_0.mainShips = {}

		for iter_36_20, iter_36_21 in ipairs(var_36_32) do
			local var_36_41 = WorldConst.FetchWorldShip(iter_36_21.id).hpRant * 0.0001

			if table.contains(var_36_4, iter_36_21.id) then
				BattleVertify.cloneShipVertiry = true
			end

			var_36_4[#var_36_4 + 1] = iter_36_21.id

			local var_36_42 = var_0_1(var_36_1, iter_36_21, var_36_35)

			var_36_42.initHPRate = var_36_41

			table.insert(arg_36_0.mainShips, iter_36_21)
			table.insert(({}).MainUnitList, var_36_42)
		end

		for iter_36_22, iter_36_23 in ipairs(var_36_33) do
			local var_36_43 = WorldConst.FetchWorldShip(iter_36_23.id).hpRant * 0.0001

			if table.contains(var_36_4, iter_36_23.id) then
				BattleVertify.cloneShipVertiry = true
			end

			var_36_4[#var_36_4 + 1] = iter_36_23.id

			local var_36_44 = var_0_1(var_36_1, iter_36_23, var_36_35)

			var_36_44.initHPRate = var_36_43

			table.insert(arg_36_0.mainShips, iter_36_23)
			table.insert(({}).VanguardUnitList, var_36_44)
		end

		for iter_36_24, iter_36_25 in ipairs(var_36_34) do
			local var_36_45 = WorldConst.FetchWorldShip(iter_36_25.id).hpRant * 0.0001

			if table.contains(var_36_4, iter_36_25.id) then
				BattleVertify.cloneShipVertiry = true
			end

			var_36_4[#var_36_4 + 1] = iter_36_25.id

			local var_36_46 = var_0_1(var_36_1, iter_36_25, var_36_36)

			var_36_46.initHPRate = var_36_45

			table.insert(arg_36_0.mainShips, iter_36_25)
			table.insert(({}).SubUnitList, var_36_46)
		end

		arg_36_0.viewComponent:setFleet(var_36_32, var_36_33, var_36_34)

		if pg.expedition_data_template[arg_36_0.contextData.stageId].difficulty == ys.Battle.BattleConst.Difficulty.WORLD then
			({}).WorldMapId = var_36_28.config.expedition_map_id
			;({}).WorldLevel = WorldConst.WorldLevelCorrect(var_36_28.config.expedition_level, pg.expedition_data_template[arg_36_0.contextData.stageId].type)
		end

		goto label_36_1
	end

	if var_36_1 == SYSTEM_WORLD_BOSS then
		local var_36_47 = nowWorld():GetBossProxy()
		local var_36_48 = var_36_47:GetFleet(arg_36_0.contextData.bossId)
		local var_36_49 = var_36_47:GetBossById(arg_36_0.contextData.bossId)

		if arg_36_0.contextData.hpRate then
			({}).RepressInfo = {
				repressEnemyHpRant = arg_36_0.contextData.hpRate
			}
		end

		local var_36_50 = _.values(var_36_48:getCommanders())

		;({}).CommanderList = var_36_48:buildBattleBuffList()
		arg_36_0.mainShips = var_36_3:getShipsByFleet(var_36_48)

		for iter_36_26, iter_36_27 in ipairs((var_36_48:getTeamByName(TeamType.Main))) do
			if table.contains(var_36_4, iter_36_27) then
				BattleVertify.cloneShipVertiry = true
			end

			var_36_4[#var_36_4 + 1] = iter_36_27

			local var_36_51 = var_36_3:getShipById(iter_36_27)
			local var_36_52 = var_0_1(var_36_1, var_36_51, var_36_50)

			table.insert({}, var_36_51)
			table.insert(({}).MainUnitList, var_36_52)
		end

		for iter_36_28, iter_36_29 in ipairs((var_36_48:getTeamByName(TeamType.Vanguard))) do
			if table.contains(var_36_4, iter_36_29) then
				BattleVertify.cloneShipVertiry = true
			end

			var_36_4[#var_36_4 + 1] = iter_36_29

			local var_36_53 = var_36_3:getShipById(iter_36_29)
			local var_36_54 = var_0_1(var_36_1, var_36_53, var_36_50)

			table.insert({}, var_36_53)
			table.insert(({}).VanguardUnitList, var_36_54)
		end

		arg_36_0.viewComponent:setFleet({}, {}, {})

		;({}).MapAidSkills = {}

		if var_36_49 and var_36_49:IsSelf() then
			local var_36_55, var_36_56, var_36_57 = var_36_47.GetSupportValue()

			if var_36_55 then
				table.insert(({}).MapAidSkills, {
					level = 1,
					id = var_36_57
				})
			end
		end

		goto label_36_1
	end

	::label_36_1::

	if var_36_1 == SYSTEM_HP_SHARE_ACT_BOSS or var_36_1 == SYSTEM_ACT_BOSS or var_36_1 == SYSTEM_ACT_BOSS_SP or var_36_1 == SYSTEM_BOSS_EXPERIMENT then
		if arg_36_0.contextData.mainFleetId then
			local var_36_58 = getProxy(FleetProxy):getActivityFleets()[arg_36_0.contextData.actId]
			local var_36_59 = var_36_58[arg_36_0.contextData.mainFleetId]
			local var_36_60 = _.values(var_36_58[arg_36_0.contextData.mainFleetId]:getCommanders())

			;({}).CommanderList = var_36_58[arg_36_0.contextData.mainFleetId]:buildBattleBuffList()
			arg_36_0.mainShips = {}

			local var_36_61 = {}
			local var_36_62 = {}
			local var_36_63 = {}

			for iter_36_30, iter_36_31 in ipairs((var_36_59:getTeamByName(TeamType.Main))) do
				(function(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
					if table.contains(var_36_4, arg_45_0) then
						BattleVertify.cloneShipVertiry = true
					end

					var_36_4[#var_36_4 + 1] = arg_45_0

					local var_45_0 = var_36_3:getShipById(arg_45_0)

					table.insert(arg_36_0.mainShips, var_45_0)
					table.insert(arg_45_3, var_45_0)
					table.insert(arg_45_2, (var_0_1(var_36_1, var_45_0, arg_45_1)))

					return
				end)(iter_36_31, var_36_60, ({}).MainUnitList, var_36_61)
			end

			for iter_36_32, iter_36_33 in ipairs((var_36_59:getTeamByName(TeamType.Vanguard))) do
				(function(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
					if table.contains(var_36_4, arg_45_0) then
						BattleVertify.cloneShipVertiry = true
					end

					var_36_4[#var_36_4 + 1] = arg_45_0

					local var_45_0 = var_36_3:getShipById(arg_45_0)

					table.insert(arg_36_0.mainShips, var_45_0)
					table.insert(arg_45_3, var_45_0)
					table.insert(arg_45_2, (var_0_1(var_36_1, var_45_0, arg_45_1)))

					return
				end)(iter_36_33, var_36_60, ({}).VanguardUnitList, var_36_62)
			end

			local var_36_64 = var_36_58[arg_36_0.contextData.mainFleetId + 10]
			local var_36_65 = _.values(var_36_58[arg_36_0.contextData.mainFleetId + 10]:getCommanders())

			for iter_36_34, iter_36_35 in ipairs((var_36_58[arg_36_0.contextData.mainFleetId + 10]:getTeamByName(TeamType.Submarine))) do
				(function(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
					if table.contains(var_36_4, arg_45_0) then
						BattleVertify.cloneShipVertiry = true
					end

					var_36_4[#var_36_4 + 1] = arg_45_0

					local var_45_0 = var_36_3:getShipById(arg_45_0)

					table.insert(arg_36_0.mainShips, var_45_0)
					table.insert(arg_45_3, var_45_0)
					table.insert(arg_45_2, (var_0_1(var_36_1, var_45_0, arg_45_1)))

					return
				end)(iter_36_35, var_36_65, ({}).SubUnitList, var_36_63)
			end

			local var_36_66 = getProxy(PlayerProxy):getRawData()
			local var_36_67 = getProxy(ActivityProxy):getActivityById(arg_36_0.contextData.actId)
			local var_36_68 = pg.activity_event_worldboss[var_36_67:getConfig("config_id")].use_oil_limit[arg_36_0.contextData.mainFleetId]
			local var_36_69 = var_36_67:IsOilLimit(arg_36_0.contextData.stageId)
			local var_36_70 = 0
			local var_36_71 = var_36_2.oil_cost > 0

			local function var_36_72(arg_46_0, arg_46_1)
				if var_36_71 then
					local var_46_0 = arg_46_0:getEndCost().oil

					if arg_46_1 > 0 then
						cost = math.clamp(arg_46_1 - arg_46_0:getStartCost().oil, 0, var_46_0)
					end

					var_36_70 = var_36_70 + var_46_0
				end

				return
			end

			local var_36_75 = var_36_59

			if var_36_1 == SYSTEM_ACT_BOSS_SP then
				local var_36_73 = _.map(getProxy(ActivityProxy):GetActivityBossRuntime(arg_36_0.contextData.actId).buffIds, function(arg_47_0)
					return ActivityBossBuff.New({
						configId = arg_47_0
					})
				end)

				;({}).ExtraBuffList = _.map(_.select(var_36_73, function(arg_48_0)
					return arg_48_0:CastOnEnemy()
				end), function(arg_49_0)
					return arg_49_0:GetBuffID()
				end)
				;({}).ChapterBuffIDs = _.map(_.select(var_36_73, function(arg_50_0)
					return not arg_50_0:CastOnEnemy()
				end), function(arg_51_0)
					return arg_51_0:GetBuffID()
				end)

				goto label_36_0
			end

			::label_36_0::

			if var_36_69 then
				local var_36_76 = var_36_68[1] or 0

				var_36_74(var_36_75, var_36_76)

				local var_36_78 = var_36_64

				if var_36_69 then
					do
						local var_36_79 = var_36_68[2] or 0

						var_36_77(var_36_78, var_36_79)
					end

					if var_36_64:isLegalToFight() == true and (var_36_1 == SYSTEM_BOSS_EXPERIMENT or var_36_70 <= var_36_66.oil) then
						({}).SubFlag = 1
						;({}).TotalSubAmmo = 1
					end

					;({}).SubCommanderList = var_36_64:buildBattleBuffList()

					arg_36_0.viewComponent:setFleet(var_36_61, var_36_62, var_36_63)

					goto label_36_1

					if var_36_1 == SYSTEM_GUILD then
						local var_36_80 = getProxy(GuildProxy):getRawData()
						local var_36_81 = var_36_80.GetActiveEvent(var_36_9000):GetBossMission()
						local var_36_82 = var_36_81:GetMainFleet()
						local var_36_83 = _.values(var_36_82.getCommanders(var_36_80))

						;({}).CommanderList = var_36_82:BuildBattleBuffList()
						arg_36_0.mainShips = {}

						for iter_36_36, iter_36_37 in pairs((var_36_82:GetShips())) do
							if iter_36_37.ship:getTeamType() == TeamType.Main then
								table.insert({}, iter_36_37.ship)
							elseif iter_36_37.ship:getTeamType() == TeamType.Vanguard then
								table.insert({}, iter_36_37.ship)
							end
						end

						for iter_36_38, iter_36_39 in ipairs({}) do
							(function(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
								table.insert(arg_36_0.mainShips, arg_52_0)
								table.insert(arg_52_3, arg_52_0)
								table.insert(arg_52_2, (var_0_1(var_36_1, arg_52_0, arg_52_1)))

								return
							end)(iter_36_39, var_36_83, ({}).MainUnitList, {})
						end

						for iter_36_40, iter_36_41 in ipairs({}) do
							(function(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
								table.insert(arg_36_0.mainShips, arg_52_0)
								table.insert(arg_52_3, arg_52_0)
								table.insert(arg_52_2, (var_0_1(var_36_1, arg_52_0, arg_52_1)))

								return
							end)(iter_36_41, var_36_83, ({}).VanguardUnitList, {})
						end

						local var_36_84 = var_36_81:GetSubFleet()
						local var_36_85 = _.values(var_36_84:getCommanders())

						for iter_36_42, iter_36_43 in pairs((var_36_84:GetShips())) do
							if iter_36_43.ship:getTeamType() == TeamType.Submarine then
								table.insert({}, iter_36_43.ship)
							end
						end

						for iter_36_44, iter_36_45 in ipairs({}) do
							(function(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
								table.insert(arg_36_0.mainShips, arg_52_0)
								table.insert(arg_52_3, arg_52_0)
								table.insert(arg_52_2, (var_0_1(var_36_1, arg_52_0, arg_52_1)))

								return
							end)(iter_36_45, var_36_85, ({}).SubUnitList, {})
						end

						if #{} > 0 then
							({}).SubFlag = 1
							;({}).TotalSubAmmo = 1
						end

						;({}).SubCommanderList = var_36_84:BuildBattleBuffList()

						arg_36_0.viewComponent:setFleet({}, {}, {})
					elseif var_36_1 == SYSTEM_BOSS_RUSH or var_36_1 == SYSTEM_BOSS_RUSH_EX or var_36_1 == SYSTEM_BOSS_RUSH_COLLABRATE then
						local var_36_86 = getProxy(ActivityProxy):getActivityById(arg_36_0.contextData.actId):GetSeriesData()

						assert(var_36_86)

						local var_36_87, var_36_88 = var_36_86:GetStageFleets(var_36_86:GetMode(), var_36_86:GetStaegLevel() + 1)
						local var_36_89 = getProxy(FleetProxy):getActivityFleets()[arg_36_0.contextData.actId]

						arg_36_0.mainShips = {}

						local var_36_90 = {}
						local var_36_91 = {}
						local var_36_92 = {}
						local var_36_93 = var_36_89[var_36_87]
						local var_36_94 = _.values(var_36_89[var_36_87]:getCommanders())

						;({}).CommanderList = var_36_89[var_36_87]:buildBattleBuffList()

						for iter_36_46, iter_36_47 in ipairs((var_36_93:getTeamByName(TeamType.Main))) do
							(function(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
								if table.contains(var_36_4, arg_53_0) then
									BattleVertify.cloneShipVertiry = true
								end

								var_36_4[#var_36_4 + 1] = arg_53_0

								local var_53_0 = var_36_3:getShipById(arg_53_0)

								table.insert(arg_36_0.mainShips, var_53_0)
								table.insert(arg_53_3, var_53_0)
								table.insert(arg_53_2, (var_0_1(var_36_1, var_53_0, arg_53_1)))

								return
							end)(iter_36_47, var_36_94, ({}).MainUnitList, var_36_90)
						end

						for iter_36_48, iter_36_49 in ipairs((var_36_93:getTeamByName(TeamType.Vanguard))) do
							(function(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
								if table.contains(var_36_4, arg_53_0) then
									BattleVertify.cloneShipVertiry = true
								end

								var_36_4[#var_36_4 + 1] = arg_53_0

								local var_53_0 = var_36_3:getShipById(arg_53_0)

								table.insert(arg_36_0.mainShips, var_53_0)
								table.insert(arg_53_3, var_53_0)
								table.insert(arg_53_2, (var_0_1(var_36_1, var_53_0, arg_53_1)))

								return
							end)(iter_36_49, var_36_94, ({}).VanguardUnitList, var_36_91)
						end

						local var_36_95 = var_36_89[var_36_88]
						local var_36_96 = _.values(var_36_89[var_36_88]:getCommanders())

						;({}).SubCommanderList = var_36_89[var_36_88]:buildBattleBuffList()

						for iter_36_50, iter_36_51 in ipairs((var_36_95:getTeamByName(TeamType.Submarine))) do
							(function(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
								if table.contains(var_36_4, arg_53_0) then
									BattleVertify.cloneShipVertiry = true
								end

								var_36_4[#var_36_4 + 1] = arg_53_0

								local var_53_0 = var_36_3:getShipById(arg_53_0)

								table.insert(arg_36_0.mainShips, var_53_0)
								table.insert(arg_53_3, var_53_0)
								table.insert(arg_53_2, (var_0_1(var_36_1, var_53_0, arg_53_1)))

								return
							end)(iter_36_51, var_36_96, ({}).SubUnitList, var_36_92)
						end

						local var_36_97 = getProxy(PlayerProxy):getRawData()
						local var_36_98 = 0
						local var_36_99 = var_36_86:GetOilLimit()
						local var_36_100 = var_36_2.oil_cost > 0

						if var_36_95:isLegalToFight() == true and var_36_98 + (function(arg_54_0, arg_54_1)
							local var_54_0 = 0

							if var_36_100 then
								local var_54_1 = arg_54_0:getEndCost().oil

								var_54_0 = var_54_1

								if arg_54_1 > 0 then
									var_54_0 = math.clamp(arg_54_1 - arg_54_0:getStartCost().oil, 0, var_54_1)
								end
							end

							return var_54_0
						end)(var_36_93, var_36_99[1]) + (function(arg_54_0, arg_54_1)
							local var_54_0 = 0

							if var_36_100 then
								local var_54_1 = arg_54_0:getEndCost().oil

								var_54_0 = var_54_1

								if arg_54_1 > 0 then
									var_54_0 = math.clamp(arg_54_1 - arg_54_0:getStartCost().oil, 0, var_54_1)
								end
							end

							return var_54_0
						end)(var_36_95, var_36_99[2]) <= var_36_97.oil then
							({}).SubFlag = 1
							;({}).TotalSubAmmo = 1
						end

						arg_36_0.viewComponent:setFleet(var_36_90, var_36_91, var_36_92)

						if var_36_1 == SYSTEM_BOSS_RUSH_COLLABRATE then
							({}).ChapterBuffIDs = {}
							;({}).DALAidBuffIDs = {}

							local var_36_101 = var_36_86:getConfig("aid_buff")

							if var_36_86:GetBossHpRate() <= var_36_101[1] then
								table.insert(({}).DALAidBuffIDs, var_36_101[2])
							end
						end
					elseif var_36_1 == SYSTEM_LIMIT_CHALLENGE then
						({}).ExtraBuffList = AcessWithinNull(pg.expedition_constellation_challenge_template[LimitChallengeConst.GetChallengeIDByStageID(arg_36_0.contextData.stageId)], "buff_id")

						local var_36_102 = getProxy(FleetProxy)
						local var_36_103 = var_36_102:getFleetById(FleetProxy.CHALLENGE_FLEET_ID)
						local var_36_104 = var_36_102:getFleetById(FleetProxy.CHALLENGE_SUB_FLEET_ID)

						arg_36_0.mainShips = {}

						local var_36_105 = {}
						local var_36_106 = {}
						local var_36_107 = {}
						local var_36_108 = _.values(var_36_103:getCommanders())

						;({}).CommanderList = var_36_103:buildBattleBuffList()

						for iter_36_52, iter_36_53 in ipairs((var_36_103:getTeamByName(TeamType.Main))) do
							(function(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
								if table.contains(var_36_4, arg_55_0) then
									BattleVertify.cloneShipVertiry = true
								end

								var_36_4[#var_36_4 + 1] = arg_55_0

								local var_55_0 = var_36_3:getShipById(arg_55_0)

								table.insert(arg_36_0.mainShips, var_55_0)
								table.insert(arg_55_3, var_55_0)
								table.insert(arg_55_2, (var_0_1(var_36_1, var_55_0, arg_55_1)))

								return
							end)(iter_36_53, var_36_108, ({}).MainUnitList, var_36_105)
						end

						for iter_36_54, iter_36_55 in ipairs((var_36_103:getTeamByName(TeamType.Vanguard))) do
							(function(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
								if table.contains(var_36_4, arg_55_0) then
									BattleVertify.cloneShipVertiry = true
								end

								var_36_4[#var_36_4 + 1] = arg_55_0

								local var_55_0 = var_36_3:getShipById(arg_55_0)

								table.insert(arg_36_0.mainShips, var_55_0)
								table.insert(arg_55_3, var_55_0)
								table.insert(arg_55_2, (var_0_1(var_36_1, var_55_0, arg_55_1)))

								return
							end)(iter_36_55, var_36_108, ({}).VanguardUnitList, var_36_106)
						end

						local var_36_109 = _.values(var_36_104:getCommanders())

						;({}).SubCommanderList = var_36_104:buildBattleBuffList()

						for iter_36_56, iter_36_57 in ipairs((var_36_104:getTeamByName(TeamType.Submarine))) do
							(function(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
								if table.contains(var_36_4, arg_55_0) then
									BattleVertify.cloneShipVertiry = true
								end

								var_36_4[#var_36_4 + 1] = arg_55_0

								local var_55_0 = var_36_3:getShipById(arg_55_0)

								table.insert(arg_36_0.mainShips, var_55_0)
								table.insert(arg_55_3, var_55_0)
								table.insert(arg_55_2, (var_0_1(var_36_1, var_55_0, arg_55_1)))

								return
							end)(iter_36_57, var_36_109, ({}).SubUnitList, var_36_107)
						end

						local var_36_110 = getProxy(PlayerProxy):getRawData()
						local var_36_111 = 0
						local var_36_112 = var_36_2.oil_cost > 0

						if var_36_104:isLegalToFight() == true and var_36_111 + (function(arg_56_0, arg_56_1)
							local var_56_0 = 0

							if var_36_112 then
								local var_56_1 = arg_56_0:getEndCost().oil

								var_56_0 = var_56_1

								if arg_56_1 > 0 then
									var_56_0 = math.clamp(arg_56_1 - arg_56_0:getStartCost().oil, 0, var_56_1)
								end
							end

							return var_56_0
						end)(var_36_103, 0) + (function(arg_56_0, arg_56_1)
							local var_56_0 = 0

							if var_36_112 then
								local var_56_1 = arg_56_0:getEndCost().oil

								var_56_0 = var_56_1

								if arg_56_1 > 0 then
									var_56_0 = math.clamp(arg_56_1 - arg_56_0:getStartCost().oil, 0, var_56_1)
								end
							end

							return var_56_0
						end)(var_36_104, 0) <= var_36_110.oil then
							({}).SubFlag = 1
							;({}).TotalSubAmmo = 1
						end

						arg_36_0.viewComponent:setFleet(var_36_105, var_36_106, var_36_107)
					elseif var_36_1 == SYSTEM_CARDPUZZLE then
						for iter_36_58, iter_36_59 in ipairs(arg_36_0.contextData.cardPuzzleFleet) do
							local var_36_113 = var_0_2(iter_36_59, arg_36_0.contextData.relics)

							if var_36_113.fleetIndex == 1 then
								table.insert({}, var_36_113)
								table.insert(({}).VanguardUnitList, var_36_113)
							elseif var_36_113.fleetIndex == 2 then
								table.insert({}, var_36_113)
								table.insert(({}).MainUnitList, var_36_113)
							end
						end

						;({}).CardPuzzleCardIDList = arg_36_0.contextData.cards
						;({}).CardPuzzleCommonHPValue = arg_36_0.contextData.hp
						;({}).CardPuzzleRelicList = arg_36_0.contextData.relics
						;({}).CardPuzzleCombatID = arg_36_0.contextData.puzzleCombatID
					elseif var_36_1 == SYSTEM_BOSS_SINGLE or var_36_1 == SYSTEM_BOSS_SINGLE_VARIABLE then
						if arg_36_0.contextData.mainFleetId then
							local var_36_114 = getProxy(FleetProxy):getActivityFleets()[arg_36_0.contextData.actId]
							local var_36_115 = var_36_114[arg_36_0.contextData.mainFleetId]
							local var_36_116 = _.values(var_36_114[arg_36_0.contextData.mainFleetId]:getCommanders())

							;({}).CommanderList = var_36_114[arg_36_0.contextData.mainFleetId]:buildBattleBuffList()
							arg_36_0.mainShips = {}

							local var_36_117 = {}
							local var_36_118 = {}
							local var_36_119 = {}

							for iter_36_60, iter_36_61 in ipairs((var_36_115:getTeamByName(TeamType.Main))) do
								var_36_120(iter_36_61, var_36_116, ({}).MainUnitList, var_36_117)
							end

							for iter_36_62, iter_36_63 in ipairs((var_36_115:getTeamByName(TeamType.Vanguard))) do
								var_36_120(iter_36_63, var_36_116, ({}).VanguardUnitList, var_36_118)
							end

							local var_36_121 = var_36_114[arg_36_0.contextData.mainFleetId + (var_36_1 == SYSTEM_BOSS_SINGLE_VARIABLE and 100 or 10)]

							if var_36_114[arg_36_0.contextData.mainFleetId + (var_36_1 == SYSTEM_BOSS_SINGLE_VARIABLE and 100 or 10)] then
								local var_36_122 = _.values(var_36_121:getCommanders())

								for iter_36_64, iter_36_65 in ipairs((var_36_121:getTeamByName(TeamType.Submarine))) do
									var_36_120(iter_36_65, var_36_122, ({}).SubUnitList, var_36_119)
								end
							end

							local var_36_123 = getProxy(PlayerProxy):getRawData()
							local var_36_124 = getProxy(ActivityProxy):getActivityById(arg_36_0.contextData.actId)

							;({}).ChapterBuffIDs = var_36_124:GetBuffIdsByStageId(arg_36_0.contextData.stageId)

							if arg_36_0.contextData.variableBuffList then
								for iter_36_66, iter_36_67 in ipairs(arg_36_0.contextData.variableBuffList) do
									table.insert(({}).ChapterBuffIDs, pg.strategy_data_template[iter_36_67].buff_id)
								end
							end

							local var_36_125 = var_36_124:GetEnemyDataByStageId(arg_36_0.contextData.stageId):GetOilLimit()
							local var_36_126 = 0
							local var_36_127 = var_36_2.oil_cost > 0
							local var_36_129 = var_36_125[1] or 0

							;(function(arg_58_0, arg_58_1)
								if var_36_127 then
									local var_58_0 = arg_58_0:getEndCost().oil

									if arg_58_1 > 0 then
										cost = math.clamp(arg_58_1 - arg_58_0:getStartCost().oil, 0, var_58_0)
									end

									var_36_126 = var_36_126 + var_58_0
								end

								return
							end)(var_36_115, var_36_129)

							if var_36_121 then
								local var_36_130 = var_36_125[2] or 0

								var_36_128(var_36_121, var_36_130)

								if var_36_121:isLegalToFight() == true and var_36_126 <= var_36_123.oil then
									({}).SubFlag = 1
									;({}).TotalSubAmmo = 1
								end

								;({}).SubCommanderList = var_36_121:buildBattleBuffList()
							end

							arg_36_0.viewComponent:setFleet(var_36_117, var_36_118, var_36_119)
						end
					elseif var_36_1 == SYSTEM_SCENARIO_SUB_STRIKE then
						arg_36_0.mainShips = {}

						local var_36_131 = getProxy(ChapterProxy):getActiveChapter()

						arg_36_0.viewComponent:setChapter(var_36_131)
						arg_36_0.viewComponent:setFleet(nil, nil, {})
						;(function(arg_59_0, arg_59_1, arg_59_2)
							for iter_59_0, iter_59_1 in ipairs(arg_59_0) do
								if table.contains(var_36_4, iter_59_1) then
									BattleVertify.cloneShipVertiry = true
								end

								var_36_4[#var_36_4 + 1] = iter_59_1

								local var_59_0 = var_36_3:getShipById(iter_59_1)
								local var_59_1 = var_0_1(var_36_1, var_59_0, nil)

								table.insert(arg_59_1, var_59_0)
								table.insert(arg_36_0.mainShips, var_59_0)
								table.insert(arg_59_2, var_59_1)
							end

							return
						end)(var_36_131:getChapterSupportFleet():getTeamByName(TeamType.Submarine), {}, ({}).SubUnitList)
					elseif arg_36_0.contextData.mainFleetId then
						local var_36_132 = var_36_1 == SYSTEM_DUEL
						local var_36_133 = getProxy(FleetProxy)
						local var_36_136 = var_36_133:getFleetById(arg_36_0.contextData.mainFleetId)

						arg_36_0.mainShips = var_36_3:getShipsByFleet(nil)

						;(function(arg_60_0, arg_60_1, arg_60_2)
							for iter_60_0, iter_60_1 in ipairs(arg_60_0) do
								if table.contains(var_36_4, iter_60_1) then
									BattleVertify.cloneShipVertiry = true
								end

								var_36_4[#var_36_4 + 1] = iter_60_1

								local var_60_0 = var_36_3:getShipById(iter_60_1)
								local var_60_1 = var_0_1(var_36_1, var_60_0, nil, var_36_132)

								table.insert(arg_60_1, var_60_0)
								table.insert(arg_60_2, var_60_1)
							end

							return
						end)(var_36_136:getTeamByName(TeamType.Main), {}, ({}).MainUnitList)
						;(function(arg_60_0, arg_60_1, arg_60_2)
							for iter_60_0, iter_60_1 in ipairs(arg_60_0) do
								if table.contains(var_36_4, iter_60_1) then
									BattleVertify.cloneShipVertiry = true
								end

								var_36_4[#var_36_4 + 1] = iter_60_1

								local var_60_0 = var_36_3:getShipById(iter_60_1)
								local var_60_1 = var_0_1(var_36_1, var_60_0, nil, var_36_132)

								table.insert(arg_60_1, var_60_0)
								table.insert(arg_60_2, var_60_1)
							end

							return
						end)(var_36_136:getTeamByName(TeamType.Vanguard), {}, ({}).VanguardUnitList)
						;(function(arg_60_0, arg_60_1, arg_60_2)
							for iter_60_0, iter_60_1 in ipairs(arg_60_0) do
								if table.contains(var_36_4, iter_60_1) then
									BattleVertify.cloneShipVertiry = true
								end

								var_36_4[#var_36_4 + 1] = iter_60_1

								local var_60_0 = var_36_3:getShipById(iter_60_1)
								local var_60_1 = var_0_1(var_36_1, var_60_0, nil, var_36_132)

								table.insert(arg_60_1, var_60_0)
								table.insert(arg_60_2, var_60_1)
							end

							return
						end)(var_36_136:getTeamByName(TeamType.Submarine), {}, ({}).SubUnitList)
						arg_36_0.viewComponent:setFleet({}, {}, {})

						if BATTLE_DEBUG and BATTLE_FREE_SUBMARINE then
							local var_36_137 = var_36_133:getFleetById(11)
							local var_36_138 = var_36_137:getTeamByName(TeamType.Submarine)

							if #var_36_138 > 0 then
								({}).SubFlag = 1
								;({}).TotalSubAmmo = 1

								local var_36_139 = _.values(var_36_137:getCommanders())

								;({}).SubCommanderList = var_36_137:buildBattleBuffList()

								for iter_36_68, iter_36_69 in ipairs(var_36_138) do
									local var_36_140 = var_36_3:getShipById(iter_36_69)
									local var_36_141 = var_0_1(var_36_1, var_36_140, var_36_139, var_36_132)

									table.insert({}, var_36_140)
									table.insert(({}).SubUnitList, var_36_141)
								end
							end
						end
					end

					if var_36_1 == SYSTEM_WORLD then
						local var_36_142 = nowWorld()
						local var_36_143 = var_36_142:GetActiveMap()
						local var_36_144 = var_36_143:GetFleet()
						local var_36_145 = var_36_143:GetCell(var_36_144.row, var_36_144.column):GetStageEnemy()
						local var_36_146 = var_36_142:GetWorldMapDifficultyBuffLevel()

						;({}).EnemyMapRewards = {
							var_36_146[1] * (1 + pg.world_expedition_data[arg_36_0.contextData.stageId].expedition_sairenvalueA / 16),
							var_36_146[2] * (1 + pg.world_expedition_data[arg_36_0.contextData.stageId].expedition_sairenvalueB / 16),
							var_36_146[3] * (1 + pg.world_expedition_data[arg_36_0.contextData.stageId].expedition_sairenvalueC / 16)
						}
						;({}).FleetMapRewards = var_36_142:GetWorldMapBuffLevel()
					end

					var_36_0.RivalMainUnitList, var_36_0.RivalVanguardUnitList = {}, {}

					local var_36_147

					if var_36_1 == SYSTEM_DUEL and arg_36_0.contextData.rivalId then
						local var_36_148 = getProxy(MilitaryExerciseProxy)

						var_36_147 = var_36_148:getRivalById(arg_36_0.contextData.rivalId)
						arg_36_0.oldRank = var_36_148:getSeasonInfo()
					end

					if var_36_147 then
						({}).RivalVO = var_36_147

						local var_36_149 = 0

						for iter_36_70, iter_36_71 in ipairs(var_36_147.mainShips) do
							var_36_149 = var_36_149 + iter_36_71.level
						end

						for iter_36_72, iter_36_73 in ipairs(var_36_147.vanguardShips) do
							var_36_149 = var_36_149 + iter_36_73.level
						end

						BattleVertify = BattleVertify or {}
						BattleVertify.rivalLevel = var_36_149

						for iter_36_74, iter_36_75 in ipairs(var_36_147.mainShips) do
							if not iter_36_75.hpRant or iter_36_75.hpRant > 0 then
								local var_36_150 = var_0_1(var_36_1, iter_36_75, nil, true)

								if iter_36_75.hpRant then
									var_36_150.initHPRate = iter_36_75.hpRant * 0.0001
								end

								table.insert(({}).RivalMainUnitList, var_36_150)
							end
						end

						for iter_36_76, iter_36_77 in ipairs(var_36_147.vanguardShips) do
							if not iter_36_77.hpRant or iter_36_77.hpRant > 0 then
								local var_36_151 = var_0_1(var_36_1, iter_36_77, nil, true)

								if iter_36_77.hpRant then
									var_36_151.initHPRate = iter_36_77.hpRant * 0.0001
								end

								table.insert(({}).RivalVanguardUnitList, var_36_151)
							end
						end
					end

					local var_36_152 = arg_36_0.contextData.prefabFleet.main_unitList

					if arg_36_0.contextData.prefabFleet.main_unitList then
						for iter_36_78, iter_36_79 in ipairs(var_36_152) do
							for iter_36_80, iter_36_81 in ipairs(iter_36_79.equipment) do
								({})[#{} + 1] = {
									skin = 0,
									id = iter_36_81
								}
							end

							table.insert(({}).MainUnitList, {
								id = iter_36_79.id,
								tmpID = iter_36_79.configId,
								skinId = iter_36_79.skinId,
								level = iter_36_79.level,
								equipment = {},
								properties = iter_36_79.properties,
								baseProperties = iter_36_79.properties,
								proficiency = {
									1,
									1,
									1
								},
								skills = iter_36_79.skills
							})
						end
					end

					if arg_36_0.contextData.prefabFleet.vanguard_unitList then
						for iter_36_82, iter_36_83 in ipairs(arg_36_0.contextData.prefabFleet.vanguard_unitList) do
							for iter_36_84, iter_36_85 in ipairs(iter_36_83.equipment) do
								({})[#{} + 1] = {
									skin = 0,
									id = iter_36_85
								}
							end

							table.insert(({}).VanguardUnitList, {
								id = iter_36_83.id,
								tmpID = iter_36_83.configId,
								skinId = iter_36_83.skinId,
								level = iter_36_83.level,
								equipment = {},
								properties = iter_36_83.properties,
								baseProperties = iter_36_83.properties,
								proficiency = {
									1,
									1,
									1
								},
								skills = iter_36_83.skills
							})
						end
					end

					if arg_36_0.contextData.prefabFleet.submarine_unitList then
						for iter_36_86, iter_36_87 in ipairs(arg_36_0.contextData.prefabFleet.submarine_unitList) do
							for iter_36_88, iter_36_89 in ipairs(iter_36_87.equipment) do
								({})[#{} + 1] = {
									skin = 0,
									id = iter_36_89
								}
							end

							table.insert(({}).SubUnitList, {
								id = iter_36_87.id,
								tmpID = iter_36_87.configId,
								skinId = iter_36_87.skinId,
								level = iter_36_87.level,
								equipment = {},
								properties = iter_36_87.properties,
								baseProperties = iter_36_87.properties,
								proficiency = {
									1,
									1,
									1
								},
								skills = iter_36_87.skills
							})

							if var_36_1 == SYSTEM_SIMULATION and #({}).SubUnitList > 0 then
								({}).SubFlag = 1
								;({}).TotalSubAmmo = 1
							end
						end
					end

					return
				end
			end
		end
	end
end

function var_0_0.listNotificationInterests(arg_61_0)
	return {
		GAME.FINISH_STAGE_DONE,
		GAME.FINISH_STAGE_ERROR,
		GAME.STORY_BEGIN,
		GAME.STORY_END,
		GAME.END_GUIDE,
		GAME.START_GUIDE,
		GAME.PAUSE_BATTLE,
		GAME.RESUME_BATTLE,
		var_0_0.CLOSE_CHAT,
		GAME.QUIT_BATTLE,
		var_0_0.HIDE_ALL_BUTTONS,
		var_0_0.UPDATE_AUTO_COUNT
	}
end

function var_0_0.handleNotification(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_1:getName()
	local var_62_1 = arg_62_1:getBody()
	local var_62_2 = ys.Battle.BattleState.GetInstance()

	if var_62_0 == GAME.FINISH_STAGE_DONE then
		pg.MsgboxMgr.GetInstance():hide()

		local var_62_3 = BattleResultMediator.GetResultView(var_62_1.system)
		local var_62_4 = {}

		if var_62_1.system == SYSTEM_PROLOGUE then
			ys.Battle.BattleState.GetInstance():Deactive()
			arg_62_0:sendNotification(GAME.CHANGE_SCENE, SCENE.CREATE_PLAYER)

			goto label_62_0
		end

		if var_62_1.system == SYSTEM_PERFORM or var_62_1.system == SYSTEM_SIMULATION then
			ys.Battle.BattleState.GetInstance():Deactive()
			arg_62_0.viewComponent:exitBattle()

			if var_62_1.exitCallback then
				var_62_1.exitCallback()
			end

			goto label_62_0
		end

		::label_62_0::

		if var_62_1.system == SYSTEM_SCENARIO then
			var_62_4 = getProxy(ChapterProxy):getActiveChapter().operationBuffList
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).oldMainShips = arg_62_0.mainShips or {}
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).oldPlayer = arg_62_0.player
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).oldRank = arg_62_0.oldRank
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).statistics = var_62_1.statistics
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).score = var_62_1.score
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).drops = var_62_1.drops
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).bossId = var_62_1.bossId
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).name = var_62_1.name
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).prefabFleet = var_62_1.prefabFleet
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).commanderExps = var_62_1.commanderExps
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).actId = arg_62_0.contextData.actId
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).result = var_62_1.result
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).extraDrops = var_62_1.extraDrops
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).extraBuffList = var_62_4
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).isLastBonus = var_62_1.isLastBonus
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).continuousBattleTimes = arg_62_0.contextData.continuousBattleTimes
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).totalBattleTimes = arg_62_0.contextData.totalBattleTimes
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).mode = arg_62_0.contextData.mode
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).cmdArgs = arg_62_0.contextData.cmdArgs
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).variableBuffList = arg_62_0.contextData.variableBuffList
			;({
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}).useVariableTicket = arg_62_0.contextData.useVariableTicket
			;({
				mediator = NewBattleResultMediator,
				viewComponent = NewBattleResultScene
			}).data = {
				system = var_62_1.system,
				rivalId = arg_62_0.contextData.rivalId,
				mainFleetId = arg_62_0.contextData.mainFleetId,
				stageId = arg_62_0.contextData.stageId
			}

			arg_62_0:addSubLayers(Context.New({
				mediator = NewBattleResultMediator,
				viewComponent = NewBattleResultScene
			}))

			if false then
				if var_62_0 == GAME.STORY_BEGIN then
					var_62_2:Pause()
				elseif var_62_0 == GAME.STORY_END then
					var_62_2:Resume()
				elseif var_62_0 == GAME.START_GUIDE then
					var_62_2:Pause()
				elseif var_62_0 == GAME.END_GUIDE then
					var_62_2:Resume()
				elseif var_62_0 == GAME.PAUSE_BATTLE then
					if not var_62_2:IsPause() then
						arg_62_0:onPauseBtn()
					end
				elseif var_62_0 == GAME.RESUME_BATTLE then
					var_62_2:Resume()
				elseif var_62_0 == GAME.FINISH_STAGE_ERROR then
					gcAll(true)

					local var_62_5 = getProxy(ContextProxy)
					local var_62_6 = var_62_5:getContextByMediator(DailyLevelMediator)
					local var_62_7 = var_62_5:getContextByMediator(LevelMediator2)
					local var_62_8 = var_62_5:getContextByMediator(ChallengeMainMediator)
					local var_62_9 = var_62_5:getContextByMediator(ActivityBossMediatorTemplate)

					if var_62_6 then
						var_62_6:removeChild((var_62_6:getContextByMediator(PreCombatMediator)))
					elseif var_62_8 then
						var_62_8:removeChild((var_62_8:getContextByMediator(ChallengePreCombatMediator)))
					elseif var_62_7 then
						if arg_62_0.contextData.system == SYSTEM_DUEL then
							-- block empty
						elseif arg_62_0.contextData.system == SYSTEM_SCENARIO then
							var_62_7:removeChild((var_62_7:getContextByMediator(ChapterPreCombatMediator)))
						elseif arg_62_0.contextData.system ~= SYSTEM_PERFORM and arg_62_0.contextData.system ~= SYSTEM_SIMULATION then
							local var_62_10 = var_62_7:getContextByMediator(PreCombatMediator)

							if var_62_10 then
								var_62_7:removeChild(var_62_10)
							end
						end
					elseif var_62_9 then
						local var_62_11 = var_62_9:getContextByMediator(PreCombatMediator)

						if var_62_11 then
							var_62_9:removeChild(var_62_11)
						end
					end

					arg_62_0:sendNotification(GAME.GO_BACK)
				elseif var_62_0 == var_0_0.CLOSE_CHAT then
					arg_62_0.viewComponent:OnCloseChat()
				elseif var_62_0 == var_0_0.HIDE_ALL_BUTTONS then
					ys.Battle.BattleState.GetInstance():GetProxyByName(ys.Battle.BattleDataProxy.__name):DispatchEvent(ys.Event.New(ys.Battle.BattleEvent.HIDE_INTERACTABLE_BUTTONS, {
						isActive = var_62_1
					}))
				elseif var_62_0 == GAME.QUIT_BATTLE then
					var_62_2:Stop()
				elseif var_62_0 == var_0_0.UPDATE_AUTO_COUNT then
					arg_62_0:updateAutoCount(var_62_1)
				end
			end

			return
		end
	end
end

function var_0_0.remove(arg_63_0)
	pg.BrightnessMgr.GetInstance():SetScreenNeverSleep(false)

	return
end

return var_0_0
