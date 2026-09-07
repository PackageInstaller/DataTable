local BattleMediator = class("BattleMediator", import("..base.ContextMediator"))

BattleMediator.ON_BATTLE_RESULT = "BattleMediator:ON_BATTLE_RESULT"
BattleMediator.ON_PAUSE = "BattleMediator:ON_PAUSE"
BattleMediator.ENTER = "BattleMediator:ENTER"
BattleMediator.ON_BACK_PRE_SCENE = "BattleMediator:ON_BACK_PRE_SCENE"
BattleMediator.ON_LEAVE = "BattleMediator:ON_LEAVE"
BattleMediator.ON_QUIT_BATTLE_MANUALLY = "BattleMediator:ON_QUIT_BATTLE_MANUALLY"
BattleMediator.HIDE_ALL_BUTTONS = "BattleMediator:HIDE_ALL_BUTTONS"
BattleMediator.ON_CHAT = "BattleMediator:ON_CHAT"
BattleMediator.CLOSE_CHAT = "BattleMediator:CLOSE_CHAT"
BattleMediator.ON_AUTO = "BattleMediator:ON_AUTO"
BattleMediator.UPDATE_AUTO_COUNT = "BattleMediator:UPDATE_AUTO_COUNT"
BattleMediator.ON_PUZZLE_RELIC = "BattleMediator.ON_PUZZLE_RELIC"
BattleMediator.ON_PUZZLE_CARD = "BattleMediator.ON_PUZZLE_CARD"

function BattleMediator:register()
	pg.BrightnessMgr.GetInstance():SetScreenNeverSleep(true)
	self:GenBattleData()

	self.contextData.battleData = self._battleData

	local var_1_0 = ys.Battle.BattleState.GetInstance()
	local var_1_1 = self.contextData.system

	self:bind(BattleMediator.ON_BATTLE_RESULT, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.FINISH_STAGE, {
			token = self.contextData.token,
			mainFleetId = self.contextData.mainFleetId,
			stageId = self.contextData.stageId,
			rivalId = self.contextData.rivalId,
			memory = self.contextData.memory,
			bossId = self.contextData.bossId,
			exitCallback = self.contextData.exitCallback,
			system = var_1_1,
			statistics = arg_2_1,
			actId = self.contextData.actId,
			mode = self.contextData.mode,
			puzzleCombatID = self.contextData.puzzleCombatID,
			useVariableTicket = self.contextData.useVariableTicket,
			isSimulate = self.contextData.isSimulate
		})

		return
	end)
	self:bind(BattleMediator.ON_AUTO, function(arg_3_0, arg_3_1)
		self:onAutoBtn(arg_3_1)

		return
	end)
	self:bind(BattleMediator.ON_PAUSE, function(arg_4_0)
		self:onPauseBtn()

		return
	end)
	self:bind(BattleMediator.ON_LEAVE, function(arg_5_0)
		self:warnFunc()

		return
	end)
	self:bind(BattleMediator.ON_CHAT, function(arg_6_0, arg_6_1)
		self:addSubLayers(Context.New({
			mediator = NotificationMediator,
			viewComponent = NotificationLayer,
			data = {
				form = NotificationLayer.FORM_BATTLE
			}
		}))

		return
	end)
	self:bind(BattleMediator.ENTER, function(arg_7_0)
		var_1_0:EnterBattle(self._battleData, self.contextData.prePause)

		return
	end)
	self:bind(BattleMediator.ON_BACK_PRE_SCENE, function()
		local var_8_0 = getProxy(ContextProxy)
		local var_8_1 = var_8_0:getContextByMediator(DailyLevelMediator)
		local var_8_2 = var_8_0:getContextByMediator(LevelMediator2)
		local var_8_3 = var_8_0:getContextByMediator(ChallengeMainMediator)
		local var_8_4 = var_8_0:getContextByMediator(ActivityBossMediatorTemplate)
		local var_8_5 = var_8_0:getContextByMediator(WorldMediator)
		local var_8_6 = var_8_0:getContextByMediator(WorldBossMediator)
		local var_8_7, var_8_8 = var_8_0:getContextByMediator(BossSinglePreCombatMediator)

		if var_8_6 and self.contextData.bossId then
			self:sendNotification(GAME.WORLD_BOSS_BATTLE_QUIT, {
				id = self.contextData.bossId
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
			self:sendNotification(GAME.CHALLENGE2_RESET, {
				mode = self.contextData.mode
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

		self:sendNotification(GAME.GO_BACK)

		return
	end)
	self:bind(BattleMediator.ON_QUIT_BATTLE_MANUALLY, function(arg_9_0)
		if var_1_1 == SYSTEM_SCENARIO then
			getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.MANUAL)
		elseif var_1_1 == SYSTEM_WORLD then
			nowWorld():TriggerAutoFight(false)
		elseif var_1_1 == SYSTEM_ACT_BOSS then
			if getProxy(ContextProxy):getCurrentContext():getContextByMediator(ContinuousOperationMediator) then
				local var_9_0 = {
					mediator = ActivityBossTotalRewardPanelMediator,
					viewComponent = ActivityBossTotalRewardPanel
				}
				local var_9_1 = {
					isLayer = true,
					isAutoFight = false
				}

				var_9_1.rewards = getProxy(ChapterProxy):PopActBossRewards()
				var_9_1.continuousBattleTimes = self.contextData.continuousBattleTimes
				var_9_1.totalBattleTimes = self.contextData.totalBattleTimes
				var_9_0.data = var_9_1

				getProxy(ContextProxy):GetPrevContext(1):addChild(Context.New(var_9_0))
			end
		elseif var_1_1 == SYSTEM_BOSS_RUSH or var_1_1 == SYSTEM_BOSS_RUSH_COLLABRATE then
			if getProxy(ContextProxy):getCurrentContext():getContextByMediator(ContinuousOperationMediator) then
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
			if getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossSingleContinuousOperationMediator) then
				local var_9_2 = {
					mediator = BossSingleTotalRewardPanelMediator,
					viewComponent = BossSingleTotalRewardPanel
				}
				local var_9_3 = {
					isLayer = true,
					isAutoFight = false
				}

				var_9_3.rewards = getProxy(ChapterProxy):PopBossSingleRewards()
				var_9_3.continuousBattleTimes = self.contextData.continuousBattleTimes
				var_9_3.totalBattleTimes = self.contextData.totalBattleTimes
				var_9_2.data = var_9_3

				getProxy(ContextProxy):GetPrevContext(1):addChild(Context.New(var_9_2))
			end
		end

		return
	end)
	self:bind(BattleMediator.ON_PUZZLE_RELIC, function(arg_10_0, arg_10_1)
		self:addSubLayers(Context.New({
			mediator = CardPuzzleRelicDeckMediator,
			viewComponent = CardPuzzleRelicDeckLayerCombat,
			data = arg_10_1
		}))
		var_1_0:Pause()

		return
	end)
	self:bind(BattleMediator.ON_PUZZLE_CARD, function(arg_11_0, arg_11_1)
		self:addSubLayers(Context.New({
			mediator = CardPuzzleCardDeckMediator,
			viewComponent = CardPuzzleCardDeckLayerCombat,
			data = arg_11_1
		}))
		var_1_0:Pause()

		return
	end)

	if self.contextData.continuousBattleTimes and self.contextData.continuousBattleTimes > 0 then
		if self.contextData.system == SYSTEM_BOSS_SINGLE or self.contextData.system == SYSTEM_BOSS_SINGLE_VARIABLE then
			if not getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossSingleContinuousOperationMediator) then
				self:addSubLayers(Context.New({
					mediator = BossSingleContinuousOperationMediator,
					viewComponent = BossSingleContinuousOperationPanel,
					data = CreateShell(self.contextData)
				}))
			end
		elseif not getProxy(ContextProxy):getCurrentContext():getContextByMediator(ContinuousOperationMediator) then
			self:addSubLayers(Context.New({
				mediator = ContinuousOperationMediator,
				viewComponent = ContinuousOperationPanel,
				data = CreateShell(self.contextData)
			}))
		end

		self.contextData.battleData.hideAllButtons = true
	end

	local var_1_2 = getProxy(PlayerProxy)

	if var_1_2 then
		self.player = var_1_2:getData()

		var_1_2:setFlag("battle", true)
		var_1_2:setFlag("random_skin", true)
	end

	return
end

function BattleMediator:onAutoBtn(arg_12_1)
	self:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_12_1.isOn,
		toggle = arg_12_1.toggle,
		system = arg_12_1.system
	})

	return
end

function BattleMediator:updateAutoCount(arg_13_1)
	local var_13_0 = ys.Battle.BattleState.GetInstance():GetProxyByName(ys.Battle.BattleDataProxy.__name):AutoStatistics(arg_13_1.isOn)

	return
end

function BattleMediator:onPauseBtn()
	local var_14_0 = ys.Battle.BattleState.GetInstance()

	if self.contextData.system == SYSTEM_PROLOGUE or self.contextData.system == SYSTEM_PERFORM then
		local var_14_1 = {}

		if EPILOGUE_SKIPPABLE then
			table.insert(var_14_1, 1, {
				text = "关爱胡德",
				btnType = pg.MsgboxMgr.BUTTON_RED,
				onCallback = function()
					var_14_0:Deactive()
					self:sendNotification(GAME.CHANGE_SCENE, SCENE.CREATE_PLAYER)

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
	elseif self.contextData.system == SYSTEM_DODGEM then
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
						self:warnFunc(function()
							ys.Battle.BattleState.GetInstance():Resume()

							return
						end)

						return
					end
				}
			}
		})
		var_14_0:Pause()
	elseif self.contextData.system == SYSTEM_SIMULATION then
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
						self:warnFunc(function()
							ys.Battle.BattleState.GetInstance():Resume()

							return
						end)

						return
					end
				}
			}
		})
		var_14_0:Pause()
	elseif self.contextData.system == SYSTEM_SUBMARINE_RUN or self.contextData.system == SYSTEM_SUB_ROUTINE or self.contextData.system == SYSTEM_REWARD_PERFORM or self.contextData.system == SYSTEM_AIRFIGHT then
		var_14_0:Pause()
		self:warnFunc(function()
			ys.Battle.BattleState.GetInstance():Resume()

			return
		end)
	elseif self.contextData.system == SYSTEM_CARDPUZZLE then
		self:addSubLayers(Context.New({
			mediator = CardPuzzleCombatPauseMediator,
			viewComponent = CardPuzzleCombatPauseLayer
		}))
		var_14_0:Pause()
	else
		self.viewComponent:updatePauseWindow()
		var_14_0:Pause()
	end

	return
end

function BattleMediator:warnFunc(arg_27_1)
	local var_27_0 = ys.Battle.BattleState.GetInstance()
	local var_27_2

	local function var_27_3()
		var_27_0:Stop()

		return
	end

	if self.contextData.warnMsg and #self.contextData.warnMsg > 0 then
		var_27_2 = i18n(self.contextData.warnMsg)
	elseif self.contextData.system == SYSTEM_CHALLENGE then
		var_27_2 = i18n("battle_battleMediator_clear_warning")
	elseif self.contextData.system == SYSTEM_SIMULATION then
		var_27_2 = i18n("tech_simulate_quit")
	elseif self.contextData.system == SYSTEM_SCENARIO_SUB_STRIKE then
		var_27_2 = i18n("battle_battleMediator_quest_exist_submarine_support")

		function var_27_3()
			var_27_0:GetCommandByName(ys.Battle.BattleScenarioSubStrikeCommand.__name):CalcBattleEnd()
			self.viewComponent:ClosePauseWindow()

			return
		end
	else
		var_27_2 = i18n("battle_battleMediator_quest_exist")
	end

	local function var_27_4()
		if arg_27_1 then
			arg_27_1()
		end

		local var_30_0 = self.viewComponent.leaveBtn:GetComponent(typeof(Animation))

		if var_30_0 then
			var_30_0:Play("msgbox_btn_into")
		end

		return
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		modal = true,
		hideYes = true,
		hideNo = true,
		content = var_27_2,
		onClose = var_27_4,
		custom = {
			{
				text = "text_cancel",
				onCallback = var_27_4,
				sound = SFX_CANCEL
			},
			{
				text = "text_exit",
				btnType = pg.MsgboxMgr.BUTTON_RED,
				onCallback = var_27_3,
				sound = SFX_CONFIRM
			}
		}
	})

	return
end

function BattleMediator:guideDispatch()
	return
end

local function var_0_1(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1:getActiveEquipments()) do
		var_32_0[#var_32_0 + 1] = iter_32_1 and {
			id = iter_32_1.configId,
			skin = iter_32_1.skinId,
			equipmentInfo = iter_32_1
		} or {
			skin = 0,
			id = iter_32_1,
			equipmentInfo = iter_32_1
		}
	end

	local var_32_1 = {}

	local function var_32_2(arg_33_0)
		return {
			level = arg_33_0.level,
			id = ys.Battle.BattleDataFunction.SkillTranform(arg_32_0, (arg_32_1:RemapSkillId(arg_33_0.id, true)))
		}
	end

	for iter_32_2, iter_32_3 in pairs((ys.Battle.BattleDataFunction.GenerateHiddenBuff(arg_32_1.configId))) do
		local var_32_3 = var_32_2(iter_32_3)

		var_32_1[var_32_3.id] = var_32_3
	end

	for iter_32_4, iter_32_5 in pairs(arg_32_1.skills) do
		if iter_32_5 and iter_32_5.id == 14900 and not arg_32_1.transforms[16412] then
			-- block empty
		else
			local var_32_4 = var_32_2(iter_32_5)

			var_32_1[var_32_4.id] = var_32_4
		end
	end

	for iter_32_6, iter_32_7 in ipairs((ys.Battle.BattleDataFunction.GetEquipSkill(var_32_0))) do
		local var_32_5 = {
			level = iter_32_7.buffLV,
			id = ys.Battle.BattleDataFunction.SkillTranform(arg_32_0, iter_32_7.buffID)
		}

		var_32_1[var_32_5.id] = var_32_5
	end

	local var_32_6

	;(function()
		var_32_6 = arg_32_1:GetSpWeapon()

		if not var_32_6 then
			return
		end

		local var_34_0 = var_32_6:GetEffect()

		if var_34_0 == 0 then
			return
		end

		local var_34_1 = {}

		var_34_1.level = 1
		var_34_1.id = ys.Battle.BattleDataFunction.SkillTranform(arg_32_0, var_34_0)
		var_32_1[var_34_1.id] = var_34_1

		return
	end)()

	for iter_32_8, iter_32_9 in pairs(arg_32_1:getTriggerSkills()) do
		local var_32_7 = {
			level = iter_32_9.level,
			id = ys.Battle.BattleDataFunction.SkillTranform(arg_32_0, iter_32_9.id)
		}

		var_32_1[var_32_7.id] = var_32_7
	end

	local var_32_8 = arg_32_0 == SYSTEM_WORLD
	local var_32_9 = false

	if arg_32_0 == SYSTEM_WORLD then
		local var_32_10 = WorldConst.FetchWorldShip(arg_32_1.id)

		if var_32_10 then
			var_32_9 = var_32_10:IsBroken()
		end
	end

	if var_32_9 then
		for iter_32_10, iter_32_11 in pairs(var_32_1) do
			if pg.skill_data_template[iter_32_10].world_death_mark[1] == ys.Battle.BattleConst.DEATH_MARK_SKILL.DEACTIVE then
				var_32_1[iter_32_10] = nil
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
		equipment = var_32_0,
		properties = arg_32_1:getProperties(arg_32_2, arg_32_3, var_32_8),
		baseProperties = arg_32_1:getShipProperties(),
		proficiency = arg_32_1:getEquipProficiencyList(),
		rarity = arg_32_1:getRarity(),
		intimacy = arg_32_1:getCVIntimacy(),
		shipGS = arg_32_1:getShipCombatPower(),
		skills = var_32_1,
		baseList = arg_32_1:getBaseList(),
		preloasList = arg_32_1:getPreLoadCount(),
		name = arg_32_1:getName(),
		deathMark = var_32_9,
		spWeapon = var_32_6
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

function BattleMediator:GenBattleData()
	local var_36_0 = {}
	local var_36_1 = self.contextData.system

	self._battleData = var_36_0
	var_36_0.battleType = self.contextData.system
	var_36_0.StageTmpId = self.contextData.stageId
	var_36_0.CMDArgs = self.contextData.cmdArgs
	var_36_0.isMemory = self.contextData.memory
	var_36_0.MainUnitList = {}
	var_36_0.VanguardUnitList = {}
	var_36_0.SubUnitList = {}
	var_36_0.AidUnitList = {}
	var_36_0.SupportUnitList = {}
	var_36_0.SubFlag = -1
	var_36_0.ActID = self.contextData.actId
	var_36_0.bossLevel = self.contextData.bossLevel
	var_36_0.bossConfigId = self.contextData.bossConfigId

	if pg.battle_cost_template[var_36_1].global_buff_effected > 0 then
		var_36_0.GlobalBuffIDs = underscore.filter(BuffHelper.GetBattleBuffs(var_36_1), function(arg_37_0)
			local var_37_0
			local var_37_1 = {
				"dungeon"
			}

			if var_36_1 == SYSTEM_SCENARIO then
				table.insert(var_37_1, "chapter")

				var_37_0 = getProxy(ChapterProxy):getActiveChapter().id
			end

			return underscore.all(var_37_1, function(arg_38_0)
				return switch(arg_38_0, {
					chapter = function()
						return arg_37_0:checkChaper(var_37_0)
					end,
					dungeon = function()
						return arg_37_0:checkDungeon(self.contextData.stageId)
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

		var_36_0.RepressInfo = var_36_6:getRepressInfo()

		self.viewComponent:setChapter(var_36_6)

		var_36_0.KizunaJamming = var_36_6:getExtraFlags()
		var_36_0.DefeatCount = var_36_6.fleet:getDefeatCount()
		var_36_0.ChapterBuffIDs, var_36_0.CommanderList = var_36_6:getFleetBattleBuffs(var_36_6.fleet)
		var_36_0.StageWaveFlags = var_36_6:GetStageFlags()
		var_36_0.ChapterWeatherIDS = var_36_6:GetWeather(var_36_6.fleet.line.row, var_36_6.fleet.line.column)
		var_36_0.MapAuraSkills = var_36_5.GetChapterAuraBuffs(var_36_6)
		var_36_0.MapAidSkills = {}
		var_36_0.ChapterType = var_36_6:getPlayType()

		for iter_36_0, iter_36_1 in pairs((var_36_5.GetChapterAidBuffs(var_36_6))) do
			table.insert(var_36_0.AidUnitList, (var_0_1(var_36_1, iter_36_0, (_.values(var_36_6:getFleetByShipVO(iter_36_0):getCommanders())))))

			for iter_36_2, iter_36_3 in ipairs(iter_36_1) do
				table.insert(var_36_0.MapAidSkills, iter_36_3)
			end
		end

		local var_36_7 = var_36_6.fleet:getShipsByTeam(TeamType.Main, false)
		local var_36_8 = var_36_6.fleet:getShipsByTeam(TeamType.Vanguard, false)
		local var_36_9 = {}
		local var_36_10 = _.values(var_36_6.fleet:getCommanders())
		local var_36_11 = {}
		local var_36_12, var_36_13 = var_36_5.getSubAidFlag(var_36_6, self.contextData.stageId)

		if var_36_12 == true or var_36_12 > 0 then
			var_36_0.SubFlag = 1
			var_36_0.TotalSubAmmo = 1
			var_36_9 = var_36_13:getShipsByTeam(TeamType.Submarine, false)
			var_36_11 = _.values(var_36_13:getCommanders())

			local var_36_14, var_36_15 = var_36_6:getFleetBattleBuffs(var_36_13)

			var_36_0.SubCommanderList = var_36_15
		else
			var_36_0.SubFlag = var_36_12

			if var_36_12 ~= ys.Battle.BattleConst.SubAidFlag.AID_EMPTY then
				var_36_0.TotalSubAmmo = 0
			end
		end

		self.mainShips = {}

		local function var_36_16(arg_42_0, arg_42_1, arg_42_2)
			if table.contains(var_36_4, arg_42_0.id) then
				BattleVertify.cloneShipVertiry = true
			end

			var_36_4[#var_36_4 + 1] = arg_42_0.id

			local var_42_0 = var_0_1(var_36_1, arg_42_0, arg_42_1)

			var_42_0.initHPRate = arg_42_0.hpRant * 0.0001

			table.insert(self.mainShips, arg_42_0)
			table.insert(arg_42_2, var_42_0)

			return
		end

		for iter_36_4, iter_36_5 in ipairs(var_36_7) do
			var_36_16(iter_36_5, var_36_10, var_36_0.MainUnitList)
		end

		for iter_36_6, iter_36_7 in ipairs(var_36_8) do
			var_36_16(iter_36_7, var_36_10, var_36_0.VanguardUnitList)
		end

		for iter_36_8, iter_36_9 in ipairs(var_36_9) do
			var_36_16(iter_36_9, var_36_11, var_36_0.SubUnitList)
		end

		local var_36_17 = var_36_6:getChapterSupportFleet()

		if var_36_17 then
			for iter_36_10, iter_36_11 in pairs((var_36_17:getShips())) do
				var_36_16(iter_36_11, {}, var_36_0.SupportUnitList)
			end
		end

		self.viewComponent:setFleet(var_36_7, var_36_8, var_36_9)
	elseif var_36_1 == SYSTEM_CHALLENGE then
		local var_36_18 = getProxy(ChallengeProxy):getUserChallengeInfo(self.contextData.mode)

		var_36_0.ChallengeInfo = var_36_18

		self.viewComponent:setChapter(var_36_18)

		local var_36_19 = var_36_18:getRegularFleet()

		var_36_0.CommanderList = var_36_19:buildBattleBuffList()

		local var_36_20 = _.values(var_36_19:getCommanders())
		local var_36_21 = {}
		local var_36_22 = var_36_19:getShipsByTeam(TeamType.Main, false)
		local var_36_23 = var_36_19:getShipsByTeam(TeamType.Vanguard, false)
		local var_36_25 = var_36_18:getSubmarineFleet()
		local var_36_26 = var_36_25:getShipsByTeam(TeamType.Submarine, false)

		if #var_36_26 > 0 then
			var_36_0.SubFlag = 1
			var_36_0.TotalSubAmmo = 1
			var_36_21 = _.values(var_36_25:getCommanders())
			var_36_0.SubCommanderList = var_36_25:buildBattleBuffList()
		else
			var_36_0.SubFlag = 0
			var_36_0.TotalSubAmmo = 0
		end

		self.mainShips = {}

		local function var_36_27(arg_43_0, arg_43_1, arg_43_2)
			if table.contains(var_36_4, arg_43_0.id) then
				BattleVertify.cloneShipVertiry = true
			end

			var_36_4[#var_36_4 + 1] = arg_43_0.id

			local var_43_0 = var_0_1(var_36_1, arg_43_0, arg_43_1)

			var_43_0.initHPRate = arg_43_0.hpRant * 0.0001

			table.insert(self.mainShips, arg_43_0)
			table.insert(arg_43_2, var_43_0)

			return
		end

		for iter_36_12, iter_36_13 in ipairs(var_36_22) do
			var_36_27(iter_36_13, var_36_20, var_36_0.MainUnitList)
		end

		for iter_36_14, iter_36_15 in ipairs(var_36_23) do
			var_36_27(iter_36_15, var_36_20, var_36_0.VanguardUnitList)
		end

		for iter_36_16, iter_36_17 in ipairs(var_36_26) do
			var_36_27(iter_36_17, var_36_21, var_36_0.SubUnitList)
		end

		self.viewComponent:setFleet(var_36_22, var_36_23, var_36_26)
	elseif var_36_1 == SYSTEM_WORLD then
		local var_36_28 = nowWorld()
		local var_36_29 = var_36_28:GetActiveMap()
		local var_36_30 = var_36_29:GetFleet()
		local var_36_31 = var_36_29:GetCell(var_36_30.row, var_36_30.column):GetStageEnemy()

		if self.contextData.hpRate then
			var_36_0.RepressInfo = {
				repressEnemyHpRant = self.contextData.hpRate
			}
		end

		var_36_0.AffixBuffList = table.mergeArray(var_36_31:GetBattleLuaBuffs(), var_36_29:GetBattleLuaBuffs(WorldMap.FactionEnemy, var_36_31))

		local function var_36_32(arg_44_0)
			local var_44_0 = {}

			for iter_44_0, iter_44_1 in ipairs(arg_44_0) do
				table.insert(var_44_0, {
					id = ys.Battle.BattleDataFunction.SkillTranform(var_36_1, iter_44_1.id),
					level = iter_44_1.level
				})
			end

			return var_44_0
		end

		var_36_0.DefeatCount = var_36_30:getDefeatCount()
		var_36_0.ChapterBuffIDs, var_36_0.CommanderList = var_36_29:getFleetBattleBuffs(var_36_30, true)
		var_36_0.MapAuraSkills = var_36_29:GetChapterAuraBuffs()
		var_36_0.MapAuraSkills = var_36_32(var_36_0.MapAuraSkills)
		var_36_0.MapAidSkills = {}

		for iter_36_18, iter_36_19 in pairs((var_36_29:GetChapterAidBuffs())) do
			table.insert(var_36_0.AidUnitList, (var_0_1(var_36_1, WorldConst.FetchShipVO(iter_36_18.id), (_.values(var_36_29:GetFleet(iter_36_18.fleetId):getCommanders(true))))))

			var_36_0.MapAidSkills = table.mergeArray(var_36_0.MapAidSkills, var_36_32(iter_36_19))
		end

		local var_36_33 = var_36_30:GetTeamShipVOs(TeamType.Main, false)
		local var_36_34 = var_36_30:GetTeamShipVOs(TeamType.Vanguard, false)
		local var_36_35 = {}
		local var_36_36 = _.values(var_36_30:getCommanders(true))
		local var_36_37 = {}
		local var_36_38 = var_36_28:GetSubAidFlag()

		if var_36_38 == true then
			local var_36_39 = var_36_29:GetSubmarineFleet()

			var_36_0.SubFlag = 1
			var_36_0.TotalSubAmmo = 1
			var_36_35 = var_36_39:GetTeamShipVOs(TeamType.Submarine, false)
			var_36_37 = _.values(var_36_39:getCommanders(true))

			local var_36_40, var_36_41 = var_36_29:getFleetBattleBuffs(var_36_39, true)

			var_36_0.SubCommanderList = var_36_41
		else
			var_36_0.SubFlag = 0

			if var_36_38 ~= ys.Battle.BattleConst.SubAidFlag.AID_EMPTY then
				var_36_0.TotalSubAmmo = 0
			end
		end

		self.mainShips = {}

		for iter_36_20, iter_36_21 in ipairs(var_36_33) do
			local var_36_42 = WorldConst.FetchWorldShip(iter_36_21.id).hpRant * 0.0001

			if table.contains(var_36_4, iter_36_21.id) then
				BattleVertify.cloneShipVertiry = true
			end

			var_36_4[#var_36_4 + 1] = iter_36_21.id

			local var_36_43 = var_0_1(var_36_1, iter_36_21, var_36_36)

			var_36_43.initHPRate = var_36_42

			table.insert(self.mainShips, iter_36_21)
			table.insert(var_36_0.MainUnitList, var_36_43)
		end

		for iter_36_22, iter_36_23 in ipairs(var_36_34) do
			local var_36_44 = WorldConst.FetchWorldShip(iter_36_23.id).hpRant * 0.0001

			if table.contains(var_36_4, iter_36_23.id) then
				BattleVertify.cloneShipVertiry = true
			end

			var_36_4[#var_36_4 + 1] = iter_36_23.id

			local var_36_45 = var_0_1(var_36_1, iter_36_23, var_36_36)

			var_36_45.initHPRate = var_36_44

			table.insert(self.mainShips, iter_36_23)
			table.insert(var_36_0.VanguardUnitList, var_36_45)
		end

		for iter_36_24, iter_36_25 in ipairs(var_36_35) do
			local var_36_46 = WorldConst.FetchWorldShip(iter_36_25.id).hpRant * 0.0001

			if table.contains(var_36_4, iter_36_25.id) then
				BattleVertify.cloneShipVertiry = true
			end

			var_36_4[#var_36_4 + 1] = iter_36_25.id

			local var_36_47 = var_0_1(var_36_1, iter_36_25, var_36_37)

			var_36_47.initHPRate = var_36_46

			table.insert(self.mainShips, iter_36_25)
			table.insert(var_36_0.SubUnitList, var_36_47)
		end

		self.viewComponent:setFleet(var_36_33, var_36_34, var_36_35)

		if pg.expedition_data_template[self.contextData.stageId].difficulty == ys.Battle.BattleConst.Difficulty.WORLD then
			var_36_0.WorldMapId = var_36_29.config.expedition_map_id
			var_36_0.WorldLevel = WorldConst.WorldLevelCorrect(var_36_29.config.expedition_level, pg.expedition_data_template[self.contextData.stageId].type)
		end
	elseif var_36_1 == SYSTEM_WORLD_BOSS then
		local var_36_48 = nowWorld():GetBossProxy()
		local var_36_49 = var_36_48:GetFleet(self.contextData.bossId)
		local var_36_50 = var_36_48:GetBossById(self.contextData.bossId)

		if self.contextData.hpRate then
			var_36_0.RepressInfo = {
				repressEnemyHpRant = self.contextData.hpRate
			}
		end

		local var_36_51 = _.values(var_36_49:getCommanders())

		var_36_0.CommanderList = var_36_49:buildBattleBuffList()
		self.mainShips = var_36_3:getShipsByFleet(var_36_49)

		local var_36_52 = {}
		local var_36_53 = {}

		for iter_36_26, iter_36_27 in ipairs((var_36_49:getTeamByName(TeamType.Main))) do
			if table.contains(var_36_4, iter_36_27) then
				BattleVertify.cloneShipVertiry = true
			end

			var_36_4[#var_36_4 + 1] = iter_36_27

			local var_36_54 = var_36_3:getShipById(iter_36_27)
			local var_36_55 = var_0_1(var_36_1, var_36_54, var_36_51)

			table.insert(var_36_52, var_36_54)
			table.insert(var_36_0.MainUnitList, var_36_55)
		end

		for iter_36_28, iter_36_29 in ipairs((var_36_49:getTeamByName(TeamType.Vanguard))) do
			if table.contains(var_36_4, iter_36_29) then
				BattleVertify.cloneShipVertiry = true
			end

			var_36_4[#var_36_4 + 1] = iter_36_29

			local var_36_56 = var_36_3:getShipById(iter_36_29)
			local var_36_57 = var_0_1(var_36_1, var_36_56, var_36_51)

			table.insert(var_36_53, var_36_56)
			table.insert(var_36_0.VanguardUnitList, var_36_57)
		end

		self.viewComponent:setFleet(var_36_52, var_36_53, {})

		var_36_0.MapAidSkills = {}

		if var_36_50 and var_36_50:IsSelf() then
			local var_36_58, var_36_59, var_36_60 = var_36_48.GetSupportValue()

			if var_36_58 then
				table.insert(var_36_0.MapAidSkills, {
					level = 1,
					id = var_36_60
				})
			end
		end
	elseif var_36_1 == SYSTEM_HP_SHARE_ACT_BOSS or var_36_1 == SYSTEM_ACT_BOSS or var_36_1 == SYSTEM_ACT_BOSS_SP or var_36_1 == SYSTEM_BOSS_EXPERIMENT then
		if self.contextData.mainFleetId then
			local var_36_61 = getProxy(FleetProxy):getActivityFleets()[self.contextData.actId]
			local var_36_62 = var_36_61[self.contextData.mainFleetId]
			local var_36_63 = _.values(var_36_61[self.contextData.mainFleetId]:getCommanders())

			var_36_0.CommanderList = var_36_61[self.contextData.mainFleetId]:buildBattleBuffList()
			self.mainShips = {}

			local var_36_64 = {}
			local var_36_65 = {}
			local var_36_66 = {}

			local function var_36_67(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
				if table.contains(var_36_4, arg_45_0) then
					BattleVertify.cloneShipVertiry = true
				end

				var_36_4[#var_36_4 + 1] = arg_45_0

				local var_45_0 = var_36_3:getShipById(arg_45_0)

				table.insert(self.mainShips, var_45_0)
				table.insert(arg_45_3, var_45_0)
				table.insert(arg_45_2, (var_0_1(var_36_1, var_45_0, arg_45_1)))

				return
			end

			for iter_36_30, iter_36_31 in ipairs((var_36_62:getTeamByName(TeamType.Main))) do
				var_36_67(iter_36_31, var_36_63, var_36_0.MainUnitList, var_36_64)
			end

			for iter_36_32, iter_36_33 in ipairs((var_36_62:getTeamByName(TeamType.Vanguard))) do
				var_36_67(iter_36_33, var_36_63, var_36_0.VanguardUnitList, var_36_65)
			end

			local var_36_68 = var_36_61[self.contextData.mainFleetId + 10]
			local var_36_69 = _.values(var_36_61[self.contextData.mainFleetId + 10]:getCommanders())

			for iter_36_34, iter_36_35 in ipairs((var_36_61[self.contextData.mainFleetId + 10]:getTeamByName(TeamType.Submarine))) do
				var_36_67(iter_36_35, var_36_69, var_36_0.SubUnitList, var_36_66)
			end

			local var_36_70 = getProxy(PlayerProxy):getRawData()
			local var_36_71 = getProxy(ActivityProxy):getActivityById(self.contextData.actId)
			local var_36_72 = pg.activity_event_worldboss[var_36_71:getConfig("config_id")].use_oil_limit[self.contextData.mainFleetId]
			local var_36_73 = var_36_71:IsOilLimit(self.contextData.stageId)
			local var_36_74 = 0
			local var_36_75 = var_36_2.oil_cost > 0

			local function var_36_76(arg_46_0, arg_46_1)
				if var_36_75 then
					local var_46_0 = arg_46_0:getEndCost().oil

					if arg_46_1 > 0 then
						cost = math.clamp(arg_46_1 - arg_46_0:getStartCost().oil, 0, var_46_0)
					end

					var_36_74 = var_36_74 + var_46_0
				end

				return
			end

			if var_36_1 == SYSTEM_ACT_BOSS_SP then
				local var_36_77 = _.map(getProxy(ActivityProxy):GetActivityBossRuntime(self.contextData.actId).buffIds, function(arg_47_0)
					return ActivityBossBuff.New({
						configId = arg_47_0
					})
				end)

				var_36_0.ExtraBuffList = _.map(_.select(var_36_77, function(arg_48_0)
					return arg_48_0:CastOnEnemy()
				end), function(arg_49_0)
					return arg_49_0:GetBuffID()
				end)
				var_36_0.ChapterBuffIDs = _.map(_.select(var_36_77, function(arg_50_0)
					return not arg_50_0:CastOnEnemy()
				end), function(arg_51_0)
					return arg_51_0:GetBuffID()
				end)
			else
				var_36_76(var_36_62, (var_36_73 or nil) and (var_36_72[1] or 0))
				var_36_76(var_36_68, (var_36_73 or nil) and (var_36_72[2] or 0))
			end

			if var_36_68:isLegalToFight() == true and (var_36_1 == SYSTEM_BOSS_EXPERIMENT or var_36_74 <= var_36_70.oil) then
				var_36_0.SubFlag = 1
				var_36_0.TotalSubAmmo = 1
			end

			var_36_0.SubCommanderList = var_36_68:buildBattleBuffList()

			self.viewComponent:setFleet(var_36_64, var_36_65, var_36_66)
		end
	elseif var_36_1 == SYSTEM_GUILD then
		local var_36_79 = getProxy(GuildProxy):getRawData()
		local var_36_80 = var_36_79:GetActiveEvent():GetBossMission()
		local var_36_81 = var_36_80:GetMainFleet()
		local var_36_82 = _.values(var_36_81.getCommanders(var_36_79))

		var_36_0.CommanderList = var_36_81:BuildBattleBuffList()
		self.mainShips = {}

		local var_36_83 = {}
		local var_36_84 = {}
		local var_36_85 = {}

		local function var_36_86(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
			table.insert(self.mainShips, arg_52_0)
			table.insert(arg_52_3, arg_52_0)
			table.insert(arg_52_2, (var_0_1(var_36_1, arg_52_0, arg_52_1)))

			return
		end

		local var_36_87 = {}
		local var_36_88 = {}

		for iter_36_36, iter_36_37 in pairs((var_36_81:GetShips())) do
			if iter_36_37.ship:getTeamType() == TeamType.Main then
				table.insert(var_36_87, iter_36_37.ship)
			elseif iter_36_37.ship:getTeamType() == TeamType.Vanguard then
				table.insert(var_36_88, iter_36_37.ship)
			end
		end

		for iter_36_38, iter_36_39 in ipairs(var_36_87) do
			var_36_86(iter_36_39, var_36_82, var_36_0.MainUnitList, var_36_83)
		end

		for iter_36_40, iter_36_41 in ipairs(var_36_88) do
			var_36_86(iter_36_41, var_36_82, var_36_0.VanguardUnitList, var_36_84)
		end

		local var_36_89 = var_36_80:GetSubFleet()
		local var_36_90 = _.values(var_36_89:getCommanders())
		local var_36_91 = {}

		for iter_36_42, iter_36_43 in pairs((var_36_89:GetShips())) do
			if iter_36_43.ship:getTeamType() == TeamType.Submarine then
				table.insert(var_36_91, iter_36_43.ship)
			end
		end

		for iter_36_44, iter_36_45 in ipairs(var_36_91) do
			var_36_86(iter_36_45, var_36_90, var_36_0.SubUnitList, var_36_85)
		end

		if #var_36_85 > 0 then
			var_36_0.SubFlag = 1
			var_36_0.TotalSubAmmo = 1
		end

		var_36_0.SubCommanderList = var_36_89:BuildBattleBuffList()

		self.viewComponent:setFleet(var_36_83, var_36_84, var_36_85)
	elseif var_36_1 == SYSTEM_BOSS_RUSH or var_36_1 == SYSTEM_BOSS_RUSH_EX or var_36_1 == SYSTEM_BOSS_RUSH_COLLABRATE then
		local var_36_92 = getProxy(ActivityProxy):getActivityById(self.contextData.actId):GetSeriesData()

		assert(var_36_92)

		local var_36_93, var_36_94 = var_36_92:GetStageFleets(var_36_92:GetMode(), var_36_92:GetStaegLevel() + 1)
		local var_36_95 = getProxy(FleetProxy):getActivityFleets()[self.contextData.actId]

		self.mainShips = {}

		local var_36_96 = {}
		local var_36_97 = {}
		local var_36_98 = {}

		local function var_36_99(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
			if table.contains(var_36_4, arg_53_0) then
				BattleVertify.cloneShipVertiry = true
			end

			var_36_4[#var_36_4 + 1] = arg_53_0

			local var_53_0 = var_36_3:getShipById(arg_53_0)

			table.insert(self.mainShips, var_53_0)
			table.insert(arg_53_3, var_53_0)
			table.insert(arg_53_2, (var_0_1(var_36_1, var_53_0, arg_53_1)))

			return
		end

		local var_36_100 = var_36_95[var_36_93]
		local var_36_101 = _.values(var_36_95[var_36_93]:getCommanders())

		var_36_0.CommanderList = var_36_95[var_36_93]:buildBattleBuffList()

		for iter_36_46, iter_36_47 in ipairs((var_36_100:getTeamByName(TeamType.Main))) do
			var_36_99(iter_36_47, var_36_101, var_36_0.MainUnitList, var_36_96)
		end

		for iter_36_48, iter_36_49 in ipairs((var_36_100:getTeamByName(TeamType.Vanguard))) do
			var_36_99(iter_36_49, var_36_101, var_36_0.VanguardUnitList, var_36_97)
		end

		local var_36_102 = var_36_95[var_36_94]
		local var_36_103 = _.values(var_36_95[var_36_94]:getCommanders())

		var_36_0.SubCommanderList = var_36_95[var_36_94]:buildBattleBuffList()

		for iter_36_50, iter_36_51 in ipairs((var_36_102:getTeamByName(TeamType.Submarine))) do
			var_36_99(iter_36_51, var_36_103, var_36_0.SubUnitList, var_36_98)
		end

		local var_36_104 = getProxy(PlayerProxy):getRawData()
		local var_36_105 = 0
		local var_36_106 = var_36_92:GetOilLimit()
		local var_36_107 = var_36_2.oil_cost > 0

		local function var_36_108(arg_54_0, arg_54_1)
			local var_54_0 = 0

			if var_36_107 then
				local var_54_1 = arg_54_0:getEndCost().oil

				var_54_0 = var_54_1

				if arg_54_1 > 0 then
					var_54_0 = math.clamp(arg_54_1 - arg_54_0:getStartCost().oil, 0, var_54_1)
				end
			end

			return var_54_0
		end

		if var_36_102:isLegalToFight() == true and var_36_105 + var_36_108(var_36_100, var_36_106[1]) + var_36_108(var_36_102, var_36_106[2]) <= var_36_104.oil then
			var_36_0.SubFlag = 1
			var_36_0.TotalSubAmmo = 1
		end

		self.viewComponent:setFleet(var_36_96, var_36_97, var_36_98)

		if var_36_1 == SYSTEM_BOSS_RUSH_COLLABRATE then
			var_36_0.ChapterBuffIDs = {}
			var_36_0.DALAidBuffIDs = {}

			local var_36_109 = var_36_92:getConfig("aid_buff")

			if var_36_92:GetBossHpRate() <= var_36_109[1] then
				table.insert(var_36_0.DALAidBuffIDs, var_36_109[2])
			end
		end
	elseif var_36_1 == SYSTEM_LIMIT_CHALLENGE then
		var_36_0.ExtraBuffList = AcessWithinNull(pg.expedition_constellation_challenge_template[LimitChallengeConst.GetChallengeIDByStageID(self.contextData.stageId)], "buff_id")

		local var_36_110 = getProxy(FleetProxy)
		local var_36_111 = var_36_110:getFleetById(FleetProxy.CHALLENGE_FLEET_ID)
		local var_36_112 = var_36_110:getFleetById(FleetProxy.CHALLENGE_SUB_FLEET_ID)

		self.mainShips = {}

		local var_36_113 = {}
		local var_36_114 = {}
		local var_36_115 = {}

		local function var_36_116(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
			if table.contains(var_36_4, arg_55_0) then
				BattleVertify.cloneShipVertiry = true
			end

			var_36_4[#var_36_4 + 1] = arg_55_0

			local var_55_0 = var_36_3:getShipById(arg_55_0)

			table.insert(self.mainShips, var_55_0)
			table.insert(arg_55_3, var_55_0)
			table.insert(arg_55_2, (var_0_1(var_36_1, var_55_0, arg_55_1)))

			return
		end

		local var_36_117 = _.values(var_36_111:getCommanders())

		var_36_0.CommanderList = var_36_111:buildBattleBuffList()

		for iter_36_52, iter_36_53 in ipairs((var_36_111:getTeamByName(TeamType.Main))) do
			var_36_116(iter_36_53, var_36_117, var_36_0.MainUnitList, var_36_113)
		end

		for iter_36_54, iter_36_55 in ipairs((var_36_111:getTeamByName(TeamType.Vanguard))) do
			var_36_116(iter_36_55, var_36_117, var_36_0.VanguardUnitList, var_36_114)
		end

		local var_36_118 = _.values(var_36_112:getCommanders())

		var_36_0.SubCommanderList = var_36_112:buildBattleBuffList()

		for iter_36_56, iter_36_57 in ipairs((var_36_112:getTeamByName(TeamType.Submarine))) do
			var_36_116(iter_36_57, var_36_118, var_36_0.SubUnitList, var_36_115)
		end

		local var_36_119 = var_36_2.oil_cost > 0

		local function var_36_120(arg_56_0, arg_56_1)
			local var_56_0 = 0

			if var_36_119 then
				local var_56_1 = arg_56_0:getEndCost().oil

				var_56_0 = var_56_1

				if arg_56_1 > 0 then
					var_56_0 = math.clamp(arg_56_1 - arg_56_0:getStartCost().oil, 0, var_56_1)
				end
			end

			return var_56_0
		end

		if var_36_112:isLegalToFight() == true and 0 + var_36_120(var_36_111, 0) + var_36_120(var_36_112, 0) <= getProxy(PlayerProxy):getRawData().oil then
			var_36_0.SubFlag = 1
			var_36_0.TotalSubAmmo = 1
		end

		self.viewComponent:setFleet(var_36_113, var_36_114, var_36_115)
	elseif var_36_1 == SYSTEM_CARDPUZZLE then
		local var_36_121 = {}
		local var_36_122 = {}

		for iter_36_58, iter_36_59 in ipairs(self.contextData.cardPuzzleFleet) do
			local var_36_123 = var_0_2(iter_36_59, self.contextData.relics)

			if var_36_123.fleetIndex == 1 then
				table.insert(var_36_122, var_36_123)
				table.insert(var_36_0.VanguardUnitList, var_36_123)
			elseif var_36_123.fleetIndex == 2 then
				table.insert(var_36_121, var_36_123)
				table.insert(var_36_0.MainUnitList, var_36_123)
			end
		end

		var_36_0.CardPuzzleCardIDList = self.contextData.cards
		var_36_0.CardPuzzleCommonHPValue = self.contextData.hp
		var_36_0.CardPuzzleRelicList = self.contextData.relics
		var_36_0.CardPuzzleCombatID = self.contextData.puzzleCombatID
	elseif var_36_1 == SYSTEM_BOSS_SINGLE or var_36_1 == SYSTEM_BOSS_SINGLE_VARIABLE then
		if self.contextData.mainFleetId then
			local var_36_124 = getProxy(FleetProxy):getActivityFleets()[self.contextData.actId]
			local var_36_125 = var_36_124[self.contextData.mainFleetId]
			local var_36_126 = _.values(var_36_124[self.contextData.mainFleetId]:getCommanders())

			var_36_0.CommanderList = var_36_124[self.contextData.mainFleetId]:buildBattleBuffList()
			self.mainShips = {}

			local var_36_127 = {}
			local var_36_128 = {}
			local var_36_129 = {}

			local function var_36_130(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
				if table.contains(var_36_4, arg_57_0) then
					BattleVertify.cloneShipVertiry = true
				end

				var_36_4[#var_36_4 + 1] = arg_57_0

				local var_57_0 = var_36_3:getShipById(arg_57_0)

				table.insert(self.mainShips, var_57_0)
				table.insert(arg_57_3, var_57_0)
				table.insert(arg_57_2, (var_0_1(var_36_1, var_57_0, arg_57_1)))

				return
			end

			for iter_36_60, iter_36_61 in ipairs((var_36_125:getTeamByName(TeamType.Main))) do
				var_36_130(iter_36_61, var_36_126, var_36_0.MainUnitList, var_36_127)
			end

			for iter_36_62, iter_36_63 in ipairs((var_36_125:getTeamByName(TeamType.Vanguard))) do
				var_36_130(iter_36_63, var_36_126, var_36_0.VanguardUnitList, var_36_128)
			end

			local var_36_131 = var_36_124[self.contextData.mainFleetId + (var_36_1 == SYSTEM_BOSS_SINGLE_VARIABLE and 100 or 10)]

			if var_36_124[self.contextData.mainFleetId + (var_36_1 == SYSTEM_BOSS_SINGLE_VARIABLE and 100 or 10)] then
				local var_36_132 = _.values(var_36_131:getCommanders())

				for iter_36_64, iter_36_65 in ipairs((var_36_131:getTeamByName(TeamType.Submarine))) do
					var_36_130(iter_36_65, var_36_132, var_36_0.SubUnitList, var_36_129)
				end
			end

			local var_36_133 = getProxy(PlayerProxy):getRawData()
			local var_36_134 = getProxy(ActivityProxy):getActivityById(self.contextData.actId)

			var_36_0.ChapterBuffIDs = var_36_134:GetBuffIdsByStageId(self.contextData.stageId)

			if self.contextData.variableBuffList then
				for iter_36_66, iter_36_67 in ipairs(self.contextData.variableBuffList) do
					table.insert(var_36_0.ChapterBuffIDs, pg.strategy_data_template[iter_36_67].buff_id)
				end
			end

			local var_36_135 = var_36_134:GetEnemyDataByStageId(self.contextData.stageId):GetOilLimit()
			local var_36_136 = 0
			local var_36_137 = var_36_2.oil_cost > 0

			local function var_36_138(arg_58_0, arg_58_1)
				if var_36_137 then
					local var_58_0 = arg_58_0:getEndCost().oil

					if arg_58_1 > 0 then
						cost = math.clamp(arg_58_1 - arg_58_0:getStartCost().oil, 0, var_58_0)
					end

					var_36_136 = var_36_136 + var_58_0
				end

				return
			end

			var_36_138(var_36_125, var_36_135[1] or 0)

			if var_36_131 then
				var_36_138(var_36_131, var_36_135[2] or 0)

				if var_36_131:isLegalToFight() == true and var_36_136 <= var_36_133.oil then
					var_36_0.SubFlag = 1
					var_36_0.TotalSubAmmo = 1
				end

				var_36_0.SubCommanderList = var_36_131:buildBattleBuffList()
			end

			self.viewComponent:setFleet(var_36_127, var_36_128, var_36_129)
		end
	elseif var_36_1 == SYSTEM_SCENARIO_SUB_STRIKE then
		local var_36_140 = {}

		self.mainShips = {}

		local var_36_141 = getProxy(ChapterProxy):getActiveChapter()

		self.viewComponent:setChapter(var_36_141)
		self.viewComponent:setFleet(nil, nil, var_36_140)
		;(function(arg_59_0, arg_59_1, arg_59_2)
			for iter_59_0, iter_59_1 in ipairs(arg_59_0) do
				if table.contains(var_36_4, iter_59_1) then
					BattleVertify.cloneShipVertiry = true
				end

				var_36_4[#var_36_4 + 1] = iter_59_1

				local var_59_0 = var_36_3:getShipById(iter_59_1)
				local var_59_1 = var_0_1(var_36_1, var_59_0, nil)

				table.insert(arg_59_1, var_59_0)
				table.insert(self.mainShips, var_59_0)
				table.insert(arg_59_2, var_59_1)
			end

			return
		end)(var_36_141:getChapterSupportFleet():getTeamByName(TeamType.Submarine), var_36_140, var_36_0.SubUnitList)
	elseif self.contextData.mainFleetId then
		local var_36_142 = var_36_1 == SYSTEM_DUEL
		local var_36_143 = getProxy(FleetProxy)
		local var_36_146 = var_36_143:getFleetById(self.contextData.mainFleetId)

		self.mainShips = var_36_3:getShipsByFleet(nil)

		local var_36_147 = {}
		local var_36_148 = {}
		local var_36_149 = {}

		local function var_36_150(arg_60_0, arg_60_1, arg_60_2)
			for iter_60_0, iter_60_1 in ipairs(arg_60_0) do
				if table.contains(var_36_4, iter_60_1) then
					BattleVertify.cloneShipVertiry = true
				end

				var_36_4[#var_36_4 + 1] = iter_60_1

				local var_60_0 = var_36_3:getShipById(iter_60_1)
				local var_60_1 = var_0_1(var_36_1, var_60_0, nil, var_36_142)

				table.insert(arg_60_1, var_60_0)
				table.insert(arg_60_2, var_60_1)
			end

			return
		end

		var_36_150(var_36_146:getTeamByName(TeamType.Main), var_36_147, var_36_0.MainUnitList)
		var_36_150(var_36_146:getTeamByName(TeamType.Vanguard), var_36_148, var_36_0.VanguardUnitList)
		var_36_150(var_36_146:getTeamByName(TeamType.Submarine), var_36_149, var_36_0.SubUnitList)
		self.viewComponent:setFleet(var_36_147, var_36_148, var_36_149)

		if BATTLE_DEBUG and BATTLE_FREE_SUBMARINE then
			local var_36_151 = var_36_143:getFleetById(11)
			local var_36_152 = var_36_151:getTeamByName(TeamType.Submarine)

			if #var_36_152 > 0 then
				var_36_0.SubFlag = 1
				var_36_0.TotalSubAmmo = 1

				local var_36_153 = _.values(var_36_151:getCommanders())

				var_36_0.SubCommanderList = var_36_151:buildBattleBuffList()

				for iter_36_68, iter_36_69 in ipairs(var_36_152) do
					local var_36_154 = var_36_3:getShipById(iter_36_69)
					local var_36_155 = var_0_1(var_36_1, var_36_154, var_36_153, var_36_142)

					table.insert(var_36_149, var_36_154)
					table.insert(var_36_0.SubUnitList, var_36_155)
				end
			end
		end
	end

	if var_36_1 == SYSTEM_WORLD then
		local var_36_156 = nowWorld()
		local var_36_157 = var_36_156:GetActiveMap()
		local var_36_158 = var_36_157:GetFleet()
		local var_36_159 = var_36_157:GetCell(var_36_158.row, var_36_158.column):GetStageEnemy()
		local var_36_160 = var_36_156:GetWorldMapDifficultyBuffLevel()

		var_36_0.EnemyMapRewards = {
			var_36_160[1] * (1 + pg.world_expedition_data[self.contextData.stageId].expedition_sairenvalueA / 16),
			var_36_160[2] * (1 + pg.world_expedition_data[self.contextData.stageId].expedition_sairenvalueB / 16),
			var_36_160[3] * (1 + pg.world_expedition_data[self.contextData.stageId].expedition_sairenvalueC / 16)
		}
		var_36_0.FleetMapRewards = var_36_156:GetWorldMapBuffLevel()
	end

	var_36_0.RivalMainUnitList, var_36_0.RivalVanguardUnitList = {}, {}

	local var_36_161

	if var_36_1 == SYSTEM_DUEL and self.contextData.rivalId then
		local var_36_162 = getProxy(MilitaryExerciseProxy)

		var_36_161 = var_36_162:getRivalById(self.contextData.rivalId)
		self.oldRank = var_36_162:getSeasonInfo()
	end

	if var_36_161 then
		var_36_0.RivalVO = var_36_161

		local var_36_163 = 0

		for iter_36_70, iter_36_71 in ipairs(var_36_161.mainShips) do
			var_36_163 = var_36_163 + iter_36_71.level
		end

		for iter_36_72, iter_36_73 in ipairs(var_36_161.vanguardShips) do
			var_36_163 = var_36_163 + iter_36_73.level
		end

		BattleVertify = BattleVertify or {}
		BattleVertify.rivalLevel = var_36_163

		for iter_36_74, iter_36_75 in ipairs(var_36_161.mainShips) do
			if not iter_36_75.hpRant or iter_36_75.hpRant > 0 then
				local var_36_164 = var_0_1(var_36_1, iter_36_75, nil, true)

				if iter_36_75.hpRant then
					var_36_164.initHPRate = iter_36_75.hpRant * 0.0001
				end

				table.insert(var_36_0.RivalMainUnitList, var_36_164)
			end
		end

		for iter_36_76, iter_36_77 in ipairs(var_36_161.vanguardShips) do
			if not iter_36_77.hpRant or iter_36_77.hpRant > 0 then
				local var_36_165 = var_0_1(var_36_1, iter_36_77, nil, true)

				if iter_36_77.hpRant then
					var_36_165.initHPRate = iter_36_77.hpRant * 0.0001
				end

				table.insert(var_36_0.RivalVanguardUnitList, var_36_165)
			end
		end
	end

	if self.contextData.prefabFleet.main_unitList then
		for iter_36_78, iter_36_79 in ipairs(self.contextData.prefabFleet.main_unitList) do
			local var_36_166 = {}

			for iter_36_80, iter_36_81 in ipairs(iter_36_79.equipment) do
				var_36_166[#var_36_166 + 1] = {
					skin = 0,
					id = iter_36_81
				}
			end

			table.insert(var_36_0.MainUnitList, {
				id = iter_36_79.id,
				tmpID = iter_36_79.configId,
				skinId = iter_36_79.skinId,
				level = iter_36_79.level,
				equipment = var_36_166,
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

	if self.contextData.prefabFleet.vanguard_unitList then
		for iter_36_82, iter_36_83 in ipairs(self.contextData.prefabFleet.vanguard_unitList) do
			local var_36_167 = {}

			for iter_36_84, iter_36_85 in ipairs(iter_36_83.equipment) do
				var_36_167[#var_36_167 + 1] = {
					skin = 0,
					id = iter_36_85
				}
			end

			table.insert(var_36_0.VanguardUnitList, {
				id = iter_36_83.id,
				tmpID = iter_36_83.configId,
				skinId = iter_36_83.skinId,
				level = iter_36_83.level,
				equipment = var_36_167,
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

	if self.contextData.prefabFleet.submarine_unitList then
		for iter_36_86, iter_36_87 in ipairs(self.contextData.prefabFleet.submarine_unitList) do
			local var_36_168 = {}

			for iter_36_88, iter_36_89 in ipairs(iter_36_87.equipment) do
				var_36_168[#var_36_168 + 1] = {
					skin = 0,
					id = iter_36_89
				}
			end

			table.insert(var_36_0.SubUnitList, {
				id = iter_36_87.id,
				tmpID = iter_36_87.configId,
				skinId = iter_36_87.skinId,
				level = iter_36_87.level,
				equipment = var_36_168,
				properties = iter_36_87.properties,
				baseProperties = iter_36_87.properties,
				proficiency = {
					1,
					1,
					1
				},
				skills = iter_36_87.skills
			})

			if var_36_1 == SYSTEM_SIMULATION and #var_36_0.SubUnitList > 0 then
				var_36_0.SubFlag = 1
				var_36_0.TotalSubAmmo = 1
			end
		end
	end

	return
end

function BattleMediator:listNotificationInterests()
	return {
		GAME.FINISH_STAGE_DONE,
		GAME.FINISH_STAGE_ERROR,
		GAME.STORY_BEGIN,
		GAME.STORY_END,
		GAME.END_GUIDE,
		GAME.START_GUIDE,
		GAME.PAUSE_BATTLE,
		GAME.RESUME_BATTLE,
		BattleMediator.CLOSE_CHAT,
		GAME.QUIT_BATTLE,
		BattleMediator.HIDE_ALL_BUTTONS,
		BattleMediator.UPDATE_AUTO_COUNT
	}
end

function BattleMediator:handleNotification(arg_62_1)
	local var_62_0 = arg_62_1:getName()
	local var_62_1 = arg_62_1:getBody()
	local var_62_2 = ys.Battle.BattleState.GetInstance()

	if var_62_0 == GAME.FINISH_STAGE_DONE then
		pg.MsgboxMgr.GetInstance():hide()

		if var_62_1.system == SYSTEM_PROLOGUE then
			ys.Battle.BattleState.GetInstance():Deactive()
			self:sendNotification(GAME.CHANGE_SCENE, SCENE.CREATE_PLAYER)
		elseif var_62_1.system == SYSTEM_PERFORM or var_62_1.system == SYSTEM_SIMULATION then
			ys.Battle.BattleState.GetInstance():Deactive()
			self.viewComponent:exitBattle()

			if var_62_1.exitCallback then
				var_62_1.exitCallback()
			end
		else
			local var_62_3 = BattleResultMediator.GetResultView(var_62_1.system)
			local var_62_4 = {}

			if var_62_1.system == SYSTEM_SCENARIO then
				var_62_4 = getProxy(ChapterProxy):getActiveChapter().operationBuffList
			end

			local var_62_5 = {
				mediator = NewBattleResultMediator,
				viewComponent = NewBattleResultScene
			}
			local var_62_6 = {
				system = var_62_1.system,
				rivalId = self.contextData.rivalId,
				mainFleetId = self.contextData.mainFleetId,
				stageId = self.contextData.stageId
			}

			var_62_6.oldMainShips = self.mainShips or {}
			var_62_6.oldPlayer = self.player
			var_62_6.oldRank = self.oldRank
			var_62_6.statistics = var_62_1.statistics
			var_62_6.score = var_62_1.score
			var_62_6.drops = var_62_1.drops
			var_62_6.bossId = var_62_1.bossId
			var_62_6.name = var_62_1.name
			var_62_6.prefabFleet = var_62_1.prefabFleet
			var_62_6.commanderExps = var_62_1.commanderExps
			var_62_6.actId = self.contextData.actId
			var_62_6.result = var_62_1.result
			var_62_6.extraDrops = var_62_1.extraDrops
			var_62_6.extraBuffList = var_62_4
			var_62_6.isLastBonus = var_62_1.isLastBonus
			var_62_6.continuousBattleTimes = self.contextData.continuousBattleTimes
			var_62_6.totalBattleTimes = self.contextData.totalBattleTimes
			var_62_6.mode = self.contextData.mode
			var_62_6.cmdArgs = self.contextData.cmdArgs
			var_62_6.variableBuffList = self.contextData.variableBuffList
			var_62_6.useVariableTicket = self.contextData.useVariableTicket
			var_62_5.data = var_62_6

			self:addSubLayers(Context.New(var_62_5))
		end
	elseif var_62_0 == GAME.STORY_BEGIN then
		var_62_2:Pause()
	elseif var_62_0 == GAME.STORY_END then
		var_62_2:Resume()
	elseif var_62_0 == GAME.START_GUIDE then
		var_62_2:Pause()
	elseif var_62_0 == GAME.END_GUIDE then
		var_62_2:Resume()
	elseif var_62_0 == GAME.PAUSE_BATTLE then
		if not var_62_2:IsPause() then
			self:onPauseBtn()
		end
	elseif var_62_0 == GAME.RESUME_BATTLE then
		var_62_2:Resume()
	elseif var_62_0 == GAME.FINISH_STAGE_ERROR then
		gcAll(true)

		local var_62_7 = getProxy(ContextProxy)
		local var_62_8 = var_62_7:getContextByMediator(DailyLevelMediator)
		local var_62_9 = var_62_7:getContextByMediator(LevelMediator2)
		local var_62_10 = var_62_7:getContextByMediator(ChallengeMainMediator)
		local var_62_11 = var_62_7:getContextByMediator(ActivityBossMediatorTemplate)

		if var_62_8 then
			var_62_8:removeChild((var_62_8:getContextByMediator(PreCombatMediator)))
		elseif var_62_10 then
			var_62_10:removeChild((var_62_10:getContextByMediator(ChallengePreCombatMediator)))
		elseif var_62_9 then
			if self.contextData.system == SYSTEM_DUEL then
				-- block empty
			elseif self.contextData.system == SYSTEM_SCENARIO then
				var_62_9:removeChild((var_62_9:getContextByMediator(ChapterPreCombatMediator)))
			elseif self.contextData.system ~= SYSTEM_PERFORM and self.contextData.system ~= SYSTEM_SIMULATION then
				local var_62_12 = var_62_9:getContextByMediator(PreCombatMediator)

				if var_62_12 then
					var_62_9:removeChild(var_62_12)
				end
			end
		elseif var_62_11 then
			local var_62_13 = var_62_11:getContextByMediator(PreCombatMediator)

			if var_62_13 then
				var_62_11:removeChild(var_62_13)
			end
		end

		self:sendNotification(GAME.GO_BACK)
	elseif var_62_0 == BattleMediator.CLOSE_CHAT then
		self.viewComponent:OnCloseChat()
	elseif var_62_0 == BattleMediator.HIDE_ALL_BUTTONS then
		ys.Battle.BattleState.GetInstance():GetProxyByName(ys.Battle.BattleDataProxy.__name):DispatchEvent(ys.Event.New(ys.Battle.BattleEvent.HIDE_INTERACTABLE_BUTTONS, {
			isActive = var_62_1
		}))
	elseif var_62_0 == GAME.QUIT_BATTLE then
		var_62_2:Stop()
	elseif var_62_0 == BattleMediator.UPDATE_AUTO_COUNT then
		self:updateAutoCount(var_62_1)
	end

	return
end

function BattleMediator:remove()
	pg.BrightnessMgr.GetInstance():SetScreenNeverSleep(false)

	return
end

return BattleMediator
