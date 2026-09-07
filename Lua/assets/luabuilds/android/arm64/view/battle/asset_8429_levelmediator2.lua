local LevelMediator2 = class("LevelMediator2", import("..base.ContextMediator"))

LevelMediator2.ON_TRACKING = "LevelMediator2:ON_TRACKING"
LevelMediator2.ON_ELITE_TRACKING = "LevelMediator2:ON_ELITE_TRACKING"
LevelMediator2.ON_RETRACKING = "LevelMediator2:ON_RETRACKING"
LevelMediator2.ON_UPDATE_CUSTOM_FLEET = "LevelMediator2:ON_UPDATE_CUSTOM_FLEET"
LevelMediator2.ON_OP = "LevelMediator2:ON_OP"
LevelMediator2.ON_RESUME_SUBSTATE = "LevelMediator2:ON_RESUME_SUBSTATE"
LevelMediator2.ON_STAGE = "LevelMediator2:ON_STAGE"
LevelMediator2.ON_GO_TO_TASK_SCENE = "LevelMediator2:ON_GO_TO_TASK_SCENE"
LevelMediator2.ON_OPEN_EVENT_SCENE = "LevelMediator2:ON_OPEN_EVENT_SCENE"
LevelMediator2.ON_DAILY_LEVEL = "LevelMediator2:ON_DAILY_LEVEL"
LevelMediator2.ON_OPEN_MILITARYEXERCISE = "LevelMediator2:ON_OPEN_MILLITARYEXERCISE"
LevelMediator2.ON_OVERRIDE_CHAPTER = "LevelMediator2:ON_OVERRIDE_CHAPTER"
LevelMediator2.ON_TIME_UP = "LevelMediator2:ON_TIME_UP"
LevelMediator2.UPDATE_EVENT_LIST = "LevelMediator2:UPDATE_EVENT_LIST"
LevelMediator2.ON_START = "ON_START"
LevelMediator2.ON_ENTER_MAINLEVEL = "LevelMediator2:ON_ENTER_MAINLEVEL"
LevelMediator2.ON_DIDENTER = "LevelMediator2:ON_DIDENTER"
LevelMediator2.ON_PERFORM_COMBAT = "LevelMediator2.ON_PERFORM_COMBAT"
LevelMediator2.ON_SUPPORT_SUBMARINE = "LevelMediator2.ON_SUPPORT_SUBMARINE"
LevelMediator2.ON_ELITE_OEPN_DECK = "LevelMediator2:ON_ELITE_OEPN_DECK"
LevelMediator2.ON_ELITE_CLEAR = "LevelMediator2:ON_ELITE_CLEAR"
LevelMediator2.ON_ELITE_RECOMMEND = "LevelMediator2:ON_ELITE_RECOMMEND"
LevelMediator2.ON_ELITE_ADJUSTMENT = "LevelMediator2:ON_ELITE_ADJUSTMENT"
LevelMediator2.ON_SUPPORT_OPEN_DECK = "LevelMediator2:ON_SUPPORT_OPEN_DECK"
LevelMediator2.ON_ACTIVITY_MAP = "LevelMediator2:ON_ACTIVITY_MAP"
LevelMediator2.GO_ACT_SHOP = "LevelMediator2:GO_ACT_SHOP"
LevelMediator2.ON_SWITCH_NORMAL_MAP = "LevelMediator2:ON_SWITCH_NORMAL_MAP"
LevelMediator2.NOTICE_AUTOBOT_ENABLED = "LevelMediator2:NOTICE_AUTOBOT_ENABLED"
LevelMediator2.ON_EXTRA_RANK = "LevelMediator2:ON_EXTRA_RANK"
LevelMediator2.ON_STRATEGYING_CHAPTER = "LevelMediator2:ON_STRATEGYING_CHAPTER"
LevelMediator2.ON_SELECT_COMMANDER = "LevelMediator2:ON_SELECT_COMMANDER"
LevelMediator2.ON_SELECT_ELITE_COMMANDER = "LevelMediator2:ON_SELECT_ELITE_COMMANDER"
LevelMediator2.ON_COMMANDER_SKILL = "LevelMediator2:ON_COMMANDER_SKILL"
LevelMediator2.ON_SHIP_DETAIL = "LevelMediator2:ON_SHIP_DETAIL"
LevelMediator2.ON_CLICK_RECEIVE_REMASTER_TICKETS_BTN = "LevelMediator2:ON_CLICK_RECEIVE_REMASTER_TICKETS_BTN"
LevelMediator2.GET_REMASTER_TICKETS_DONE = "LevelMediator2:GET_REMASTER_TICKETS_DONE"
LevelMediator2.ON_FLEET_SHIPINFO = "LevelMediator2:ON_FLEET_SHIPINFO"
LevelMediator2.ON_STAGE_SHIPINFO = "LevelMediator2:ON_STAGE_SHIPINFO"
LevelMediator2.ON_SUPPORT_SHIPINFO = "LevelMediator2:ON_SUPPORT_SHIPINFO"
LevelMediator2.ON_COMMANDER_OP = "LevelMediator2:ON_COMMANDER_OP"
LevelMediator2.CLICK_CHALLENGE_BTN = "LevelMediator2:CLICK_CHALLENGE_BTN"
LevelMediator2.ON_SUBMIT_TASK = "LevelMediator2:ON_SUBMIT_TASK"
LevelMediator2.ON_VOTE_BOOK = "LevelMediator2:ON_VOTE_BOOK"
LevelMediator2.GET_CHAPTER_DROP_SHIP_LIST = "LevelMediator2:GET_CHAPTER_DROP_SHIP_LIST"
LevelMediator2.ON_CHAPTER_REMASTER_AWARD = "LevelMediator2:ON_CHAPTER_REMASTER_AWARD"
LevelMediator2.ON_BOSSRUSH_REMASTER_ACTIVITY = "LevelMediator2:ON_BOSSRUSH_REMASTER_ACTIVITY"
LevelMediator2.ENTER_WORLD = "LevelMediator2:ENTER_WORLD"
LevelMediator2.ON_OPEN_ACT_BOSS_BATTLE = "LevelMediator2:ON_OPEN_ACT_BOSS_BATTLE"
LevelMediator2.ON_BOSSRUSH_MAP = "LevelMediator2:ON_BOSSRUSH_MAP"
LevelMediator2.SHOW_ATELIER_BUFF = "LevelMediator2:SHOW_ATELIER_BUFF"
LevelMediator2.ON_SPITEM_CHANGED = "LevelMediator2:ON_SPITEM_CHANGED"
LevelMediator2.ON_BOSSSINGLE_MAP = "LevelMediator2:ON_BOSSSINGLE_MAP"
LevelMediator2.ON_CLUE_MAP = "LevelMediator2:ON_CLUE_MAP"
LevelMediator2.ON_COLLAB_BOSSRUSH_MAP = "LevelMediator2:ON_COLLAB_BOSSRUSH_MAP"
LevelMediator2.ON_UPDATE_LOWPRIORITY_TASK = "LevelMediator2:ON_UPDATE_LOWPRIORITY_TASK"

function LevelMediator2:register()
	self:bind(LevelMediator2.GET_CHAPTER_DROP_SHIP_LIST, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.GET_CHAPTER_DROP_SHIP_LIST, {
			chapterId = arg_2_1,
			callback = arg_2_2
		})

		return
	end)
	self:bind(LevelMediator2.ON_VOTE_BOOK, function(arg_3_0, arg_3_1)
		return
	end)
	self:bind(LevelMediator2.ON_COMMANDER_OP, function(arg_4_0, arg_4_1, arg_4_2)
		self.contextData.commanderOPChapter = arg_4_2

		self:sendNotification(GAME.COMMANDER_FORMATION_OP, {
			data = arg_4_1
		})

		return
	end)
	self:bind(LevelMediator2.ON_SELECT_COMMANDER, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		FormationMediator.onSelectCommander(arg_5_1, arg_5_2)

		self.contextData.selectedChapterVO = arg_5_3

		return
	end)
	self:bind(LevelMediator2.ON_SELECT_ELITE_COMMANDER, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		local var_6_0 = getProxy(ChapterProxy)
		local var_6_1 = arg_6_3.id

		self.contextData.editEliteChapter = arg_6_3.id

		local var_6_2 = arg_6_3:getEliteFleetCommanders()[arg_6_1] or {}

		self:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
			maxCount = 1,
			mode = CommanderCatScene.MODE_SELECT,
			activeCommander = (var_6_2[arg_6_2] or nil) and getProxy(CommanderProxy):getCommanderById(var_6_2[arg_6_2]),
			ignoredIds = {},
			fleetType = CommanderCatScene.FLEET_TYPE_HARD_CHAPTER,
			chapterId = arg_6_3.id,
			onCommander = function(arg_7_0)
				return true
			end,
			onSelected = function(self, arg_8_1)
				self:sendNotification(GAME.SELECT_ELIT_CHAPTER_COMMANDER, {
					chapterId = var_6_1,
					index = arg_6_1,
					pos = arg_6_2,
					commanderId = self[1],
					callback = function()
						arg_8_1()

						return
					end
				})

				return
			end,
			onQuit = function(arg_10_0)
				self:sendNotification(GAME.SELECT_ELIT_CHAPTER_COMMANDER, {
					commanderId = 0,
					chapterId = var_6_1,
					index = arg_6_1,
					pos = arg_6_2,
					callback = function()
						arg_10_0()

						return
					end
				})

				return
			end
		})

		return
	end)
	self:RegisterTrackEvent()
	self:bind(LevelMediator2.ON_UPDATE_CUSTOM_FLEET, function(arg_12_0, arg_12_1)
		self:sendNotification(GAME.UPDATE_CUSTOM_FLEET, {
			chapterId = arg_12_1.id
		})

		return
	end)
	self:bind(LevelMediator2.ON_OP, function(arg_13_0, arg_13_1)
		self:sendNotification(GAME.CHAPTER_OP, arg_13_1)

		return
	end)
	self:bind(LevelMediator2.ON_SWITCH_NORMAL_MAP, function(arg_14_0)
		local var_14_0 = getProxy(ChapterProxy):GetLastNormalMap()

		if var_14_0 then
			self.viewComponent:setMap(var_14_0)
		end

		return
	end)
	self:bind(LevelMediator2.ON_RESUME_SUBSTATE, function(arg_15_0, arg_15_1)
		self:loadSubState(arg_15_1)

		return
	end)
	self:bind(LevelMediator2.ON_STAGE, function(arg_16_0)
		self:addSubLayers(Context.New({
			mediator = ChapterPreCombatMediator,
			viewComponent = ChapterPreCombatLayer
		}), false)

		return
	end)
	self:bind(LevelMediator2.ON_OPEN_MILITARYEXERCISE, function()
		if getProxy(ActivityProxy):getMilitaryExerciseActivity() then
			self:sendNotification(GAME.GO_SCENE, SCENE.MILITARYEXERCISE)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_notStartOrEnd"))
		end

		return
	end)
	self:bind(LevelMediator2.CLICK_CHALLENGE_BTN, function(arg_18_0)
		if LOCK_LIMIT_CHALLENGE then
			self:sendNotification(GAME.GO_SCENE, SCENE.CHALLENGE_MAIN_SCENE)
		else
			self:sendNotification(GAME.GO_SCENE, SCENE.LIMIT_CHALLENGE)
		end

		return
	end)
	self:bind(LevelMediator2.ON_DAILY_LEVEL, function(arg_19_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.DAILYLEVEL)

		return
	end)
	self:bind(LevelMediator2.ON_GO_TO_TASK_SCENE, function(arg_20_0, arg_20_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.TASK, arg_20_1)

		return
	end)
	self:bind(LevelMediator2.ON_OPEN_EVENT_SCENE, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.EVENT)

		return
	end)
	self:bind(LevelMediator2.ON_OVERRIDE_CHAPTER, function()
		getProxy(ChapterProxy):updateChapter(self.contextData.chapterVO)

		return
	end)
	self:bind(LevelMediator2.ON_TIME_UP, function()
		self:onTimeUp()

		return
	end)
	self:bind(LevelMediator2.UPDATE_EVENT_LIST, function()
		self.viewComponent:addbubbleMsgBox(function(arg_25_0)
			self:OnEventUpdate(arg_25_0)

			return
		end)

		local var_24_0 = getProxy(ChapterProxy):getActiveChapter(true)

		if var_24_0 and var_24_0:IsAutoFight() then
			local var_24_1 = pg.GuildMsgBoxMgr.GetInstance()

			if var_24_1:GetShouldShowBattleTip() then
				local var_24_2 = getProxy(GuildProxy):getRawData()
				local var_24_3 = var_24_2 and var_24_2:getWeeklyTask()

				if var_24_3 and var_24_3.id ~= 0 then
					getProxy(ChapterProxy):AddExtendChapterDataTable(var_24_0.id, "ListGuildEventNotify", var_24_3:GetPresonTaskId(), var_24_3:GetPrivateTaskName())
					pg.GuildMsgBoxMgr.GetInstance():CancelShouldShowBattleTip()
				end

				var_24_1:SubmitTask(function(arg_26_0, arg_26_1, arg_26_2)
					if arg_26_0 then
						getProxy(ChapterProxy):AddExtendChapterDataTable(var_24_0.id, "ListGuildEventAutoReceiveNotify", arg_26_2, pg.task_data_template[arg_26_2].desc)
					end

					return
				end)
			end
		else
			self.viewComponent:addbubbleMsgBox(function(arg_27_0)
				pg.GuildMsgBoxMgr.GetInstance():NotificationForBattle(arg_27_0)

				return
			end)
		end

		return
	end)
	self:bind(LevelMediator2.ON_ELITE_CLEAR, function(arg_28_0, arg_28_1)
		arg_28_1.chapterVO:clearEliterFleetByIndex(arg_28_1.index)

		local var_28_0 = getProxy(ChapterProxy)

		var_28_0:updateChapter(arg_28_1.chapterVO)
		var_28_0:duplicateEliteFleet(arg_28_1.chapterVO)
		self.viewComponent:RefreshFleetSelectView(arg_28_1.chapterVO)

		return
	end)
	self:bind(LevelMediator2.NOTICE_AUTOBOT_ENABLED, function(arg_29_0, arg_29_1)
		self:sendNotification(GAME.COMMON_FLAG, {
			flagID = BATTLE_AUTO_ENABLED
		})

		return
	end)
	self:bind(LevelMediator2.ON_ELITE_RECOMMEND, function(arg_30_0, arg_30_1)
		local var_30_0 = getProxy(ChapterProxy)

		var_30_0:eliteFleetRecommend(arg_30_1.chapterVO, arg_30_1.index)
		var_30_0:updateChapter(arg_30_1.chapterVO)
		var_30_0:duplicateEliteFleet(arg_30_1.chapterVO)
		self.viewComponent:RefreshFleetSelectView(arg_30_1.chapterVO)

		return
	end)
	self:bind(LevelMediator2.ON_ELITE_ADJUSTMENT, function(arg_31_0, arg_31_1)
		local var_31_0 = getProxy(ChapterProxy)

		var_31_0:updateChapter(arg_31_1)
		var_31_0:duplicateEliteFleet(arg_31_1)

		return
	end)
	self:bind(LevelMediator2.ON_ELITE_OEPN_DECK, function(arg_32_0, arg_32_1)
		local var_32_0 = arg_32_1.shipVO
		local var_32_1 = arg_32_1.chapter
		local var_32_2 = arg_32_1.teamType
		local var_32_3 = {}

		for iter_32_0, iter_32_1 in pairs((getProxy(BayProxy):getRawData())) do
			if not ShipType.ContainInLimitBundle(arg_32_1.shipType, iter_32_1:getShipType()) then
				table.insert(var_32_3, iter_32_0)
			end
		end

		self.contextData.editEliteChapter = var_32_1.id

		local var_32_4 = {}

		for iter_32_2, iter_32_3 in pairs(arg_32_1.fleet) do
			table.insert(var_32_4, iter_32_2.id)
		end

		local var_32_5, var_32_6, var_32_7 = self:getDockCallbackFuncs(arg_32_1.fleet, var_32_0, var_32_1, arg_32_1.fleetIndex)

		self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = true,
			ignoredIds = var_32_3,
			leastLimitMsg = i18n("ship_formationMediator_leastLimit"),
			quitTeam = var_32_0 ~= nil,
			teamFilter = var_32_2,
			leftTopInfo = i18n("word_formation"),
			onShip = var_32_5,
			confirmSelect = var_32_6,
			onSelected = var_32_7,
			hideTagFlags = setmetatable({
				inElite = var_32_1:getConfig("formation")
			}, {
				__index = ShipStatus.TAG_HIDE_LEVEL
			}),
			otherSelectedIds = var_32_4
		})

		return
	end)
	self:bind(LevelMediator2.ON_SUPPORT_OPEN_DECK, function(arg_33_0, arg_33_1)
		local var_33_0 = arg_33_1.shipVO
		local var_33_1 = arg_33_1.chapter
		local var_33_2 = arg_33_1.teamType
		local var_33_3 = {}

		for iter_33_0, iter_33_1 in pairs((getProxy(BayProxy):getRawData())) do
			if not ShipType.ContainInLimitBundle(arg_33_1.shipType, iter_33_1:getShipType()) then
				table.insert(var_33_3, iter_33_0)
			end
		end

		local var_33_4 = {}

		for iter_33_2, iter_33_3 in pairs(arg_33_1.fleet) do
			table.insert(var_33_4, iter_33_2.id)
		end

		local var_33_5, var_33_6, var_33_7 = self:getSupportDockCallbackFuncs(arg_33_1.fleet, var_33_0, var_33_1)

		self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = true,
			ignoredIds = var_33_3,
			leastLimitMsg = i18n("ship_formationMediator_leastLimit"),
			quitTeam = var_33_0 ~= nil,
			teamFilter = var_33_2,
			leftTopInfo = i18n("word_formation"),
			onShip = var_33_5,
			confirmSelect = var_33_6,
			onSelected = var_33_7,
			hideTagFlags = setmetatable({
				inSupport = var_33_1:getConfig("formation")
			}, {
				__index = ShipStatus.TAG_HIDE_SUPPORT
			}),
			otherSelectedIds = var_33_4
		})

		self.contextData.selectedChapterVO = var_33_1

		return
	end)
	self:bind(LevelMediator2.ON_ACTIVITY_MAP, function(arg_34_0, arg_34_1)
		local var_34_0 = getProxy(ChapterProxy)
		local var_34_1, var_34_2 = var_34_0:getLastMapForActivity(arg_34_1)

		if var_34_1 then
			if not var_34_0:getMapById(var_34_1):isUnlock() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end
		end

		self.viewComponent:ShowSelectedMap(var_34_1, function()
			if var_34_2 then
				self.viewComponent:switchToChapter((var_34_0:getChapterById(var_34_2)))
			end

			return
		end)

		return
	end)
	self:bind(LevelMediator2.ON_BOSSRUSH_MAP, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.BOSSRUSH_MAIN)

		return
	end)
	self:bind(LevelMediator2.ON_BOSSSINGLE_MAP, function(arg_37_0, arg_37_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.OTHERWORLD_MAP, arg_37_1)

		return
	end)
	self:bind(LevelMediator2.ON_CLUE_MAP, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.CLUE_MAP)

		return
	end)
	self:bind(LevelMediator2.ON_COLLAB_BOSSRUSH_MAP, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.BOSSRUSH_DAL_COLLAB)

		return
	end)
	self:bind(LevelMediator2.GO_ACT_SHOP, function()
		local var_40_0 = self.contextData.map and self.contextData.map:getConfig("on_activity") or nil
		local var_40_1 = var_40_0 and var_40_0 ~= 0 and getProxy(ActivityProxy):getActivityById(var_40_0)
		local var_40_2 = var_40_1 and not var_40_1:isEnd() and var_40_1:GetConfigClientSetting("PTID")
		local var_40_3 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOTTERY)

		if var_40_3 and var_40_3:getConfig("config_client").resId == var_40_2 and not var_40_3:isEnd() then
			self:addSubLayers(Context.New({
				mediator = LotteryMediator,
				viewComponent = LotteryLayer,
				data = {
					activityId = var_40_3.id
				}
			}), false)
		else
			local var_40_4 = _.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_41_0)
				return arg_41_0:getConfig("config_client").pt_id == var_40_2
			end)

			self:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
				warp = NewShopsScene.TYPE_ACTIVITY,
				actId = var_40_4 and var_40_4.id
			})
		end

		return
	end)
	self:bind(LevelMediator2.SHOW_ATELIER_BUFF, function(arg_42_0, arg_42_1)
		if arg_42_1 then
			self:addSubLayers(Context.New({
				mediator = AterialYumiaCoreBuffMediator,
				viewComponent = AterialYumiaCoreBuffLayer
			}))
		else
			self:addSubLayers(Context.New({
				mediator = AtelierBuffMediator,
				viewComponent = AtelierBuffLayer
			}))
		end

		return
	end)
	self:bind(LevelMediator2.ON_SHIP_DETAIL, function(arg_43_0, arg_43_1)
		self.contextData.selectedChapterVO = arg_43_1.chapter

		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_43_1.id
		})

		return
	end)
	self:bind(LevelMediator2.ON_FLEET_SHIPINFO, function(arg_44_0, arg_44_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_44_1.shipId,
			shipVOs = arg_44_1.shipVOs
		})

		self.contextData.editEliteChapter = arg_44_1.chapter.id

		return
	end)
	self:bind(LevelMediator2.ON_SUPPORT_SHIPINFO, function(arg_45_0, arg_45_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_45_1.shipId,
			shipVOs = arg_45_1.shipVOs
		})

		self.contextData.selectedChapterVO = arg_45_1.chapter

		return
	end)
	self:bind(LevelMediator2.ON_STAGE_SHIPINFO, function(arg_46_0, arg_46_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_46_1.shipId,
			shipVOs = arg_46_1.shipVOs
		})

		return
	end)
	self:bind(LevelMediator2.ON_EXTRA_RANK, function(arg_47_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.BILLBOARD, {
			page = PowerRank.TYPE_EXTRA_CHAPTER
		})

		return
	end)
	self:bind(LevelMediator2.ON_STRATEGYING_CHAPTER, function(arg_48_0)
		local var_48_0 = getProxy(ChapterProxy)
		local var_48_1 = var_48_0:getActiveChapter()

		assert(var_48_1)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			yesText = "text_forward",
			content = i18n("levelScene_chapter_is_activation", string.split(var_48_0:getMapById(var_48_1:getConfig("map")):getConfig("name"), "|")[1] .. ":" .. var_48_1:getConfig("chapter_name")),
			onYes = function()
				self.viewComponent:switchToChapter(var_48_1)

				return
			end,
			onNo = function()
				self.contextData.chapterVO = var_48_1

				self.viewComponent:emit(LevelMediator2.ON_OP, {
					type = ChapterConst.OpRetreat,
					exittype = ChapterConst.ExitFromMap
				})

				return
			end,
			onClose = function()
				return
			end,
			noBtnType = pg.MsgboxMgr.BUTTON_RETREAT
		})

		return
	end)
	self:bind(LevelMediator2.ON_COMMANDER_SKILL, function(arg_52_0, arg_52_1)
		self:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				skill = arg_52_1
			}
		}))

		return
	end)
	self:bind(LevelMediator2.ON_PERFORM_COMBAT, function(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
		self:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_PERFORM,
			stageId = arg_53_1,
			exitCallback = arg_53_2,
			memory = arg_53_3
		})

		return
	end)
	self:bind(LevelMediator2.ON_SUPPORT_SUBMARINE, function(arg_54_0)
		self:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_SCENARIO_SUB_STRIKE
		})

		return
	end)
	self:bind(LevelMediator2.ON_CLICK_RECEIVE_REMASTER_TICKETS_BTN, function(arg_55_0)
		self:sendNotification(GAME.GET_REMASTER_TICKETS)

		return
	end)
	self:bind(LevelMediator2.ON_BOSSRUSH_REMASTER_ACTIVITY, function(arg_56_0, arg_56_1)
		self.bossRushRemasterActivityId = arg_56_1

		self:sendNotification(GAME.ACTIVITY_PERMANENT_START, {
			activity_id = arg_56_1
		})

		return
	end)
	self:bind(LevelMediator2.ON_SUBMIT_TASK, function(arg_57_0, arg_57_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_57_1)

		return
	end)
	self:bind(LevelMediator2.ON_START, function(arg_58_0)
		local var_58_0 = getProxy(ChapterProxy):getActiveChapter()

		assert(var_58_0)

		local var_58_1 = var_58_0.fleet
		local var_58_2 = var_58_0:getStageId(var_58_0.fleet.line.row, var_58_0.fleet.line.column)

		seriesAsync({
			function(arg_59_0)
				local var_59_0 = {}

				for iter_59_0, iter_59_1 in pairs(var_58_1.ships) do
					table.insert(var_59_0, iter_59_1)
				end

				Fleet.EnergyCheck(var_59_0, var_58_1.name, function(arg_60_0)
					if arg_60_0 then
						arg_59_0()
					end

					return
				end, function(arg_61_0)
					if not arg_61_0 then
						getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.SHIP_ENERGY_LOW)
					end

					return
				end)

				return
			end,
			function(arg_62_0)
				if getProxy(PlayerProxy):getRawData():GoldMax(1) then
					getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.GOLD_MAX)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("gold_max_tip_title") .. i18n("resource_max_tip_battle"),
						onYes = arg_62_0
					})
				else
					arg_62_0()
				end

				return
			end,
			function(arg_63_0)
				self:sendNotification(GAME.BEGIN_STAGE, {
					system = SYSTEM_SCENARIO,
					stageId = var_58_2
				})

				return
			end
		})

		return
	end)
	self:bind(self.ON_ENTER_MAINLEVEL, function(arg_64_0, arg_64_1)
		self:DidEnterLevelMainUI(arg_64_1)

		return
	end)
	self:bind(self.ON_DIDENTER, function(arg_65_0)
		self.viewComponent:emit(LevelMediator2.UPDATE_EVENT_LIST)

		return
	end)
	self:bind(LevelMediator2.ENTER_WORLD, function(arg_66_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.WORLD)

		return
	end)
	self:bind(LevelMediator2.ON_CHAPTER_REMASTER_AWARD, function(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
		self:sendNotification(GAME.CHAPTER_REMASTER_AWARD_RECEIVE, {
			chapterId = arg_67_1,
			pos = arg_67_2,
			actId = arg_67_3
		})

		return
	end)
	self:bind(LevelMediator2.ON_OPEN_ACT_BOSS_BATTLE, function(arg_68_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.ACT_BOSS_BATTLE, {
			showAni = true
		})

		return
	end)
	self:bind(LevelUIConst.OPEN_NORMAL_CONTINUOUS_WINDOW, function(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4)
		self:DisplayContinuousWindow(arg_69_1, _.map(arg_69_2, function(arg_70_0)
			local var_70_0 = getProxy(FleetProxy):getFleetById(arg_70_0)

			if not var_70_0 or var_70_0:getFleetType() == FleetType.Submarine then
				return
			end

			return var_70_0
		end), arg_69_3, arg_69_4)

		return
	end)
	self:bind(LevelUIConst.OPEN_ELITE_CONTINUOUS_WINDOW, function(arg_71_0, arg_71_1, arg_71_2, arg_71_3)
		local var_71_0 = getProxy(BayProxy):getRawData()

		self:DisplayContinuousWindow(arg_71_1, _.map(arg_71_1:getEliteFleetList(), function(arg_72_0)
			if #arg_72_0 == 0 or _.any(arg_72_0, function(arg_73_0)
				return var_71_0[arg_73_0] and var_71_0[arg_73_0]:getTeamType() == TeamType.Submarine
			end) then
				return
			end

			return TypedFleet.New({
				fleetType = FleetType.Normal,
				ship_list = arg_72_0
			})
		end), arg_71_2, arg_71_3)

		return
	end)
	self:bind(LevelMediator2.ON_UPDATE_LOWPRIORITY_TASK, function(arg_74_0, arg_74_1, arg_74_2)
		self:sendNotification(GAME.UPDATE_LOW_PRIORITY_TASK_PROGRESS, {
			taskId = arg_74_1
		})

		return
	end)

	self.player = getProxy(PlayerProxy):getData()

	self.viewComponent:updateRes(self.player)
	self.viewComponent:updateEvent((getProxy(EventProxy)))
	self.viewComponent:updateFleet((getProxy(FleetProxy):GetRegularFleets()))
	self.viewComponent:setShips(getProxy(BayProxy):getRawData())

	local var_1_0 = getProxy(ActivityProxy)

	self.viewComponent:updateVoteBookBtn()
	self.viewComponent:setCommanderPrefabs((getProxy(CommanderProxy):getPrefabFleet()))
	self.viewComponent:setEliteQuota(getProxy(DailyLevelProxy).eliteCount, pg.gameset.elite_quota.key_value)
	getProxy(ChapterProxy):updateActiveChapterShips()
	self.viewComponent:setSpecialOperationTickets((getProxy(BagProxy):getItemsByType(Item.SPECIAL_OPERATION_TICKET)))

	return
end

function LevelMediator2:DidEnterLevelMainUI(arg_75_1)
	self.viewComponent:setMap(arg_75_1)

	if self.contextData.openChapterId then
		self.viewComponent.mapBuilder:ActionInvoke("TryOpenChapter", self.contextData.openChapterId)

		self.contextData.openChapterId = nil
	end

	local var_75_0 = self.contextData.chapterVO

	if self.contextData.chapterVO and var_75_0.active then
		self.viewComponent:switchToChapter(var_75_0)
	elseif self.contextData.map:isSkirmish() then
		self.viewComponent:ShowCurtains(true)
		self.viewComponent:doPlayAnim("TV01", function(arg_76_0)
			go(arg_76_0):SetActive(false)
			self.viewComponent:ShowCurtains(false)

			return
		end)
	end

	if self.contextData.preparedTaskList and #self.contextData.preparedTaskList > 0 then
		for iter_75_0, iter_75_1 in ipairs(self.contextData.preparedTaskList) do
			self:sendNotification(GAME.SUBMIT_TASK, iter_75_1)
		end

		table.clean(self.contextData.preparedTaskList)
	end

	if self.contextData.StopAutoFightFlag then
		local var_75_1 = getProxy(ChapterProxy)
		local var_75_2 = var_75_1:getActiveChapter()

		if var_75_2 then
			var_75_1:SetChapterAutoFlag(var_75_2.id, false)
			self.viewComponent:updateChapterVO(var_75_2, (bit.bor(ChapterConst.DirtyAttachment, ChapterConst.DirtyStrategy)))
		end

		self.contextData.StopAutoFightFlag = nil
	end

	self:TryEnterPendingChapter()

	return
end

function LevelMediator2:TryEnterPendingChapter()
	if not self.contextData.pendingEnterChapterId then
		return
	end

	if not self.contextData.map or not self.viewComponent.mapBuilder then
		return
	end

	if self.contextData.chapterVO and self.contextData.chapterVO.id == self.contextData.pendingEnterChapterId then
		self.contextData.pendingEnterChapterId = nil

		return
	end

	local var_77_0 = getProxy(ChapterProxy):getChapterById(self.contextData.pendingEnterChapterId)

	if not var_77_0 or not var_77_0.active then
		return
	end

	self.contextData.pendingEnterChapterId = nil
	self.waitingTracking = nil

	self.viewComponent:resetLevelGrid()

	self.viewComponent.FirstEnterChapter = var_77_0.id

	self.viewComponent:switchToChapter(var_77_0)

	return
end

function LevelMediator2:RegisterTrackEvent()
	self:bind(LevelMediator2.ON_TRACKING, function(arg_79_0, arg_79_1, arg_79_2, arg_79_3, arg_79_4, arg_79_5)
		local var_79_0 = getProxy(ChapterProxy):getChapterById(arg_79_1, true)

		self:sendNotification(GAME.TRACKING, {
			chapterId = arg_79_1,
			fleetIds = getProxy(ChapterProxy):GetLastFleetIndex(),
			loopFlag = arg_79_2,
			operationItem = arg_79_3,
			duties = arg_79_4,
			autoFightFlag = arg_79_5
		})

		return
	end)
	self:bind(LevelMediator2.ON_ELITE_TRACKING, function(arg_80_0, arg_80_1, arg_80_2, arg_80_3, arg_80_4, arg_80_5)
		self:sendNotification(GAME.TRACKING, {
			chapterId = arg_80_1,
			loopFlag = arg_80_2,
			operationItem = arg_80_3,
			duties = arg_80_4,
			autoFightFlag = arg_80_5
		})

		return
	end)
	self:bind(LevelMediator2.ON_RETRACKING, function(arg_81_0, arg_81_1, arg_81_2)
		local var_81_0 = arg_81_1:GetActiveSPItemID()

		if arg_81_1:getConfig("type") == Chapter.CustomFleet then
			self.viewComponent:emit(LevelMediator2.ON_ELITE_TRACKING, arg_81_1.id, arg_81_1.loopFlag, var_81_0, arg_81_1.duties, arg_81_2)
		else
			self.viewComponent:emit(LevelMediator2.ON_TRACKING, arg_81_1.id, arg_81_1.loopFlag, var_81_0, arg_81_1.duties, arg_81_2)
		end

		return
	end)

	return
end

function LevelMediator2:NoticeVoteBook(arg_82_1)
	arg_82_1()

	return
end

function LevelMediator2:TryPlaySubGuide()
	self.viewComponent:tryPlaySubGuide()

	return
end

function LevelMediator2:listNotificationInterests()
	return {
		GAME.ZERO_HOUR_OP_DONE,
		ChapterProxy.CHAPTER_UPDATED,
		ChapterProxy.CHAPTER_TIMESUP,
		PlayerProxy.UPDATED,
		DailyLevelProxy.ELITE_QUOTA_UPDATE,
		LevelMediator2.ON_TRACKING,
		LevelMediator2.ON_ELITE_TRACKING,
		LevelMediator2.ON_RETRACKING,
		GAME.TRACKING_DONE,
		GAME.TRACKING_ERROR,
		GAME.CHAPTER_OP_DONE,
		GAME.EVENT_LIST_UPDATE,
		GAME.BEGIN_STAGE_DONE,
		ActivityProxy.ACTIVITY_OPERATION_DONE,
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUB_CHAPTER_REFRESH_DONE,
		GAME.SUB_CHAPTER_FETCH_DONE,
		CommanderProxy.PREFAB_FLEET_UPDATE,
		GAME.COOMMANDER_EQUIP_TO_FLEET_DONE,
		GAME.COMMANDER_ELIT_FORMATION_OP_DONE,
		GAME.SUBMIT_TASK_DONE,
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		LevelUIConst.CONTINUOUS_OPERATION,
		LevelMediator2.ON_SPITEM_CHANGED,
		GAME.GET_REMASTER_TICKETS_DONE,
		GAME.ACTIVITY_PERMANENT_START_DONE,
		VoteProxy.VOTE_ORDER_BOOK_DELETE,
		VoteProxy.VOTE_ORDER_BOOK_UPDATE,
		GAME.VOTE_BOOK_BE_UPDATED_DONE,
		BagProxy.ITEM_UPDATED,
		ChapterProxy.CHAPTER_AUTO_FIGHT_FLAG_UPDATED,
		ChapterProxy.CHAPTER_SKIP_PRECOMBAT_UPDATED,
		ChapterProxy.CHAPTER_REMASTER_INFO_UPDATED,
		GAME.CHAPTER_REMASTER_INFO_REQUEST_DONE,
		GAME.CHAPTER_REMASTER_AWARD_RECEIVE_DONE,
		GAME.STORY_UPDATE_DONE,
		GAME.STORY_END,
		GAME.START_CHAPTER_AUTO_DONE,
		GAME.END_CHAPTER_AUTO_DONE,
		GAME.ADD_CHAPTER_AUTO_TIME_DONE,
		ChapterAutoProxy.FINISH_UPDATE
	}
end

function LevelMediator2:handleNotification(arg_85_1)
	local var_85_0 = arg_85_1:getName()
	local var_85_1 = arg_85_1:getBody()

	if var_85_0 == GAME.ZERO_HOUR_OP_DONE then
		self.viewComponent:onZeroHourRefresh()
	elseif var_85_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_85_1)
	elseif var_85_0 == VoteProxy.VOTE_ORDER_BOOK_DELETE or VoteProxy.VOTE_ORDER_BOOK_UPDATE == var_85_0 then
		self.viewComponent:updateVoteBookBtn()
	elseif var_85_0 == PlayerProxy.UPDATED then
		self.viewComponent:updateRes(var_85_1)
	elseif var_85_0 == LevelMediator2.ON_TRACKING or var_85_0 == LevelMediator2.ON_ELITE_TRACKING or var_85_0 == LevelMediator2.ON_RETRACKING then
		self.viewComponent:emit(var_85_0, unpackEx(var_85_1))
	elseif var_85_0 == GAME.TRACKING_DONE then
		self.waitingTracking = nil

		if self.contextData.pendingEnterChapterId == var_85_1.id then
			self.contextData.pendingEnterChapterId = nil
		end

		self.viewComponent:resetLevelGrid()

		self.viewComponent.FirstEnterChapter = var_85_1.id

		self.viewComponent:switchToChapter(var_85_1)
	elseif var_85_0 == ChapterProxy.CHAPTER_UPDATED then
		self.viewComponent:updateChapterVO(var_85_1.chapter, var_85_1.dirty)
	elseif var_85_0 == GAME.COMMANDER_ELIT_FORMATION_OP_DONE then
		if self.contextData.commanderOPChapter then
			for iter_85_0, iter_85_1 in pairs(getProxy(ChapterProxy):getChapterById(var_85_1.chapterId):getEliteFleetCommanders()) do
				self.contextData.commanderOPChapter:setEliteFleetByIndex(iter_85_0, {
					{
						TeamType.FormCommander,
						{
							pos = 1,
							id = iter_85_1[1]
						}
					},
					{
						TeamType.FormCommander,
						{
							pos = 2,
							id = iter_85_1[2]
						}
					}
				})
			end

			self.viewComponent:RefreshFleetSelectView(self.contextData.commanderOPChapter)
		end
	elseif var_85_0 == GAME.CHAPTER_OP_DONE then
		local var_85_2

		local function var_85_3()
			if var_85_2 and coroutine.status(var_85_2) == "suspended" then
				local var_86_0, var_86_1 = coroutine.resume(var_85_2)

				assert(var_86_0, debug.traceback(var_85_2, var_86_1))
			end

			return
		end

		var_85_2 = coroutine.create(function()
			local var_87_0 = var_85_1.type
			local var_87_1 = self.contextData.chapterVO
			local var_87_2 = self.contextData.chapterVO:IsAutoFight()

			if var_85_1.type == ChapterConst.OpRetreat and not var_85_1.id then
				var_87_1 = var_85_1.finalChapterLevelData

				if var_85_1.exittype and var_85_1.exittype == ChapterConst.ExitFromMap then
					self.viewComponent:setChapter(nil)
					self.viewComponent.mapBuilder:UpdateChapterTF(var_87_1.id)
					self:OnExitChapter(var_87_1, var_85_1.win, var_85_1.extendData)

					return
				end

				if var_87_1:existOni() then
					local var_87_3 = var_87_1:checkOniState()

					if var_87_3 then
						self.viewComponent:displaySpResult(var_87_3, var_85_3)
						coroutine.yield()
					end
				end

				if var_87_1:isPlayingWithBombEnemy() then
					self.viewComponent:displayBombResult(var_85_3)
					coroutine.yield()
				end
			end

			local var_87_4 = var_85_1.items
			local var_87_5

			if var_85_1.items and #var_87_4 > 0 then
				if var_85_1.type == ChapterConst.OpBox and pg.box_data_template[var_87_1:getChapterCell(var_87_1.fleet.line.row, var_87_1.fleet.line.column).attachmentId].type == ChapterConst.BoxDrop and ChapterConst.IsAtelierMap(self.contextData.map) then
					local var_87_6 = _.filter(var_87_4, function(arg_88_0)
						return arg_88_0.type == DROP_TYPE_RYZA_DROP
					end)

					if #var_87_6 > 0 then
						var_87_5 = AwardInfoLayer.TITLE.RYZA

						local var_87_7 = AtelierMaterial.New({
							configId = var_87_6[math.random(#var_87_6)].id
						}):GetVoices()

						if var_87_7 and #var_87_7 > 0 then
							local var_87_8 = var_87_7[math.random(#var_87_7)]
							local var_87_9, var_87_10, var_87_11 = ShipWordHelper.GetWordAndCV(var_87_8[1], var_87_8[2], nil, PLATFORM_CODE ~= PLATFORM_US)

							self.viewComponent:emit(LevelUIConst.ADD_TOAST_QUEUE, {
								iconScale = 0.75,
								Class = LevelStageAtelierMaterialToast,
								title = i18n("ryza_tip_toast_item_got"),
								desc = var_87_11,
								voice = var_87_10,
								icon = var_87_8[3]
							})
						end
					end
				end

				seriesAsync({
					function(arg_89_0)
						getProxy(ChapterProxy):AddExtendChapterDataArray(var_87_1.id, "TotalDrops", _.filter(var_87_4, function(arg_90_0)
							return arg_90_0.type ~= DROP_TYPE_STRATEGY
						end))
						self.viewComponent:emit(BaseUI.ON_WORLD_ACHIEVE, {
							items = var_87_4,
							title = var_87_5,
							closeOnCompleted = var_87_2,
							removeFunc = arg_89_0
						})

						return
					end,
					function(arg_91_0)
						if var_87_0 == ChapterConst.OpBox and _.any(var_87_4, function(arg_92_0)
							if arg_92_0.type ~= DROP_TYPE_VITEM then
								return false
							end

							return arg_92_0:getConfig("virtual_type") == 1
						end) then
							(function()
								local var_93_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)

								if not var_93_0 then
									return
								end

								local var_93_1 = pg.activity_event_picturepuzzle[var_93_0.id]

								if not pg.activity_event_picturepuzzle[var_93_0.id] then
									return
								end

								if #table.mergeArray(var_93_0.data1_list, var_93_0.data2_list, true) < #var_93_1.pickup_picturepuzzle + #var_93_1.drop_picturepuzzle then
									return
								end

								pg.NewStoryMgr.GetInstance():Play(var_93_0:getConfig("config_client").comStory, arg_91_0)

								return
							end)()
						end

						if _.any(var_87_4, function(arg_94_0)
							if arg_94_0.type ~= DROP_TYPE_STRATEGY then
								return false
							end

							return pg.strategy_data_template[arg_94_0.id].type == ChapterConst.StgTypeConsume
						end) then
							self.viewComponent.levelStageView:popStageStrategy()
						end

						arg_91_0()

						return
					end
				}, var_85_3)
				coroutine.yield()
			end

			assert(var_87_1)

			if var_85_1.type == ChapterConst.OpSkipBattle or var_85_1.type == ChapterConst.OpPreClear then
				self.viewComponent.levelStageView:tryAutoAction(function()
					if not self.viewComponent.levelStageView then
						return
					end

					self.viewComponent.levelStageView:tryAutoTrigger()

					return
				end)
			elseif var_85_1.type == ChapterConst.OpRetreat then
				local var_87_12 = getProxy(ContextProxy):getContextByMediator(LevelMediator2)

				if var_87_12 then
					local var_87_13 = {}
					local var_87_14 = var_87_12:getContextByMediator(ChapterPreCombatMediator)

					if var_87_14 then
						table.insert(var_87_13, var_87_14)
					end

					_.each(var_87_13, function(arg_96_0)
						self:sendNotification(GAME.REMOVE_LAYERS, {
							context = arg_96_0
						})

						return
					end)
				end

				if var_85_1.id then
					return
				end

				local var_87_15 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PROGRESSLOGIN)

				if var_87_15 and not var_87_15.autoActionForbidden and not var_87_15.achieved and var_87_15.data1 == 7 and var_87_1.id == 204 and var_87_1:isClear() then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						modal = true,
						hideNo = true,
						content = "有新的签到奖励可以领取，点击确定前往",
						onYes = function()
							self:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY)

							return
						end,
						onNo = function()
							self:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY)

							return
						end
					})

					return
				end

				self:OnExitChapter(var_87_1, var_85_1.win, var_85_1.extendData)
			elseif var_85_1.type == ChapterConst.OpMove then
				seriesAsync({
					function(arg_99_0)
						var_87_1 = self.contextData.chapterVO

						var_87_1.fleet:SetLine(var_85_1.fullpath[#var_85_1.fullpath])
						getProxy(ChapterProxy):updateChapter(var_87_1)
						self.viewComponent.grid:moveFleet(var_85_1.path, var_85_1.fullpath, var_85_1.oldLine, arg_99_0)

						return
					end,
					function(arg_100_0)
						if not var_85_1.teleportPaths then
							arg_100_0()

							return
						end

						local var_100_0 = var_85_1.teleportPaths[1]

						if not var_85_1.teleportPaths[1] or not var_85_1.teleportPaths[2] then
							arg_100_0()

							return
						end

						var_87_1 = self.contextData.chapterVO

						local var_100_1 = var_87_1:getFleet(FleetType.Normal, var_100_0.row, var_100_0.column)

						if not var_100_1 then
							arg_100_0()

							return
						end

						var_100_1.line = Clone(var_85_1.teleportPaths[2])

						getProxy(ChapterProxy):updateChapter(var_87_1)
						self:getViewComponent().grid:TeleportCellByPortalWithCameraMove(var_100_1, self:getViewComponent().grid:GetCellFleet(var_100_1.id), var_85_1.teleportPaths, arg_100_0)

						return
					end,
					function(arg_101_0)
						self:playAIActions(var_85_1.aiActs, var_85_1.extraFlag, arg_101_0)

						return
					end
				}, function()
					var_87_1 = self.contextData.chapterVO

					if _.any(var_87_1.fleet:getStrategies(), function(arg_103_0)
						return arg_103_0.id == ChapterConst.StrategyExchange and arg_103_0.count > 0
					end) then
						self.viewComponent.levelStageView:popStageStrategy()
					end

					self.viewComponent.grid:updateQuadCells(ChapterConst.QuadStateNormal)
					self.viewComponent.levelStageView:updateAmbushRate(var_87_1.fleet.line, true)
					self.viewComponent.levelStageView:updateStageStrategy()
					self.viewComponent.levelStageView:updateFleetBuff()
					self.viewComponent.levelStageView:updateBombPanel()
					self.viewComponent.levelStageView:tryAutoTrigger()

					return
				end)
			elseif var_85_1.type == ChapterConst.OpAmbush then
				self.viewComponent.levelStageView:tryAutoTrigger()
			elseif var_85_1.type == ChapterConst.OpBox then
				self:playAIActions(var_85_1.aiActs, var_85_1.extraFlag, function()
					if not self.viewComponent.levelStageView then
						return
					end

					self.viewComponent.levelStageView:tryAutoTrigger()

					return
				end)
			elseif var_85_1.type == ChapterConst.OpStory then
				self.viewComponent.levelStageView:tryAutoTrigger()
			elseif var_85_1.type == ChapterConst.OpSwitch then
				self.viewComponent.grid:adjustCameraFocus()
			elseif var_85_1.type == ChapterConst.OpEnemyRound then
				self:playAIActions(var_85_1.aiActs, var_85_1.extraFlag, function()
					self.viewComponent.levelStageView:updateBombPanel(true)

					if _.any(var_87_1.fleet:getStrategies(), function(arg_106_0)
						return arg_106_0.id == ChapterConst.StrategyExchange and arg_106_0.count > 0
					end) then
						self.viewComponent.levelStageView:updateStageStrategy()
						self.viewComponent.levelStageView:popStageStrategy()
					end

					self.viewComponent.levelStageView:tryAutoTrigger()
					self.viewComponent:updatePoisonAreaTip()

					return
				end)
			elseif var_85_1.type == ChapterConst.OpSubState then
				self:saveSubState(var_87_1.subAutoAttack)
				self.viewComponent.grid:OnChangeSubAutoAttack()
			elseif var_85_1.type == ChapterConst.OpStrategy then
				if var_85_1.arg1 == ChapterConst.StrategyExchange then
					for iter_87_0, iter_87_1 in ipairs((var_87_1.fleet:findSkills(FleetSkill.TypeStrategy))) do
						if iter_87_1:GetType() == FleetSkill.TypeStrategy and iter_87_1:GetArgs()[1] == ChapterConst.StrategyExchange then
							self.viewComponent:doPlayCommander((var_87_1.fleet:findCommanderBySkillId(iter_87_1.id)))

							break
						end
					end
				end

				self:playAIActions(var_85_1.aiActs, var_85_1.extraFlag, function()
					self.viewComponent.grid:updateQuadCells(ChapterConst.QuadStateNormal)

					return
				end)
			elseif var_85_1.type == ChapterConst.OpSupply then
				self.viewComponent.levelStageView:tryAutoTrigger()
			elseif var_85_1.type == ChapterConst.OpBarrier then
				self.viewComponent.levelStageView:tryAutoTrigger()
			elseif var_85_1.type == ChapterConst.OpSubTeleport then
				seriesAsync({
					function(arg_108_0)
						local var_108_0 = _.detect(var_87_1.fleets, function(arg_109_0)
							return arg_109_0.id == var_85_1.id
						end)

						var_108_0.line = {
							row = var_85_1.arg1,
							column = var_85_1.arg2
						}
						var_108_0.startPos = {
							row = var_85_1.arg1,
							column = var_85_1.arg2
						}

						local var_108_1 = getProxy(PlayerProxy)
						local var_108_2 = var_108_1:getData()

						var_108_2:consume({
							oil = math.ceil(pg.strategy_data_template[ChapterConst.StrategySubTeleport].arg[2] * #var_108_0:getShips(false) * var_87_1:findPath(nil, var_85_1.fullpath[1], var_85_1.fullpath[#var_85_1.fullpath]) - 1e-05)
						})
						self.viewComponent:updateRes(var_108_2)
						var_108_1:updatePlayer(var_108_2)
						self.viewComponent.grid:moveSub(table.indexof(var_87_1.fleets, var_108_0), var_85_1.fullpath, nil, function()
							getProxy(ChapterProxy):updateChapter(var_87_1, (bit.bor(ChapterConst.DirtyFleet, ChapterConst.DirtyAttachment, ChapterConst.DirtyChampionPosition)))

							var_87_1 = self.contextData.chapterVO

							arg_108_0()

							return
						end)

						return
					end,
					function(arg_111_0)
						if not var_85_1.teleportPaths then
							arg_111_0()

							return
						end

						if not var_85_1.teleportPaths[1] or not var_85_1.teleportPaths[2] then
							arg_111_0()

							return
						end

						local var_111_0 = _.detect(var_87_1.fleets, function(arg_112_0)
							return arg_112_0.id == var_85_1.id
						end)

						var_111_0.startPos = Clone(var_85_1.teleportPaths[2])
						var_111_0.line = Clone(var_85_1.teleportPaths[2])

						self:getViewComponent().grid:TeleportFleetByPortal(self:getViewComponent().grid:GetCellFleet(var_111_0.id), var_85_1.teleportPaths, function()
							getProxy(ChapterProxy):updateChapter(var_87_1, (bit.bor(ChapterConst.DirtyFleet, ChapterConst.DirtyAttachment, ChapterConst.DirtyChampionPosition)))

							var_87_1 = self.contextData.chapterVO

							arg_111_0()

							return
						end)

						return
					end,
					function(arg_114_0)
						self.viewComponent.levelStageView:SwitchBottomStagePanel(false)
						self.viewComponent.grid:TurnOffSubTeleport()
						self.viewComponent.grid:updateQuadCells(ChapterConst.QuadStateNormal)

						return
					end
				})
			end

			return
		end)

		var_85_3()
	elseif var_85_0 == ChapterProxy.CHAPTER_TIMESUP then
		self:onTimeUp()
	elseif var_85_0 == GAME.EVENT_LIST_UPDATE then
		self.viewComponent:addbubbleMsgBox(function(arg_115_0)
			self:OnEventUpdate(arg_115_0)

			return
		end)
	elseif var_85_0 == GAME.VOTE_BOOK_BE_UPDATED_DONE then
		self.viewComponent:addbubbleMsgBox(function(arg_116_0)
			self:NoticeVoteBook(arg_116_0)

			return
		end)
	elseif var_85_0 == DailyLevelProxy.ELITE_QUOTA_UPDATE then
		self.viewComponent:setEliteQuota(getProxy(DailyLevelProxy).eliteCount, pg.gameset.elite_quota.key_value)
	elseif var_85_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		self.viewComponent.mapBuilder:UpdateMapItems()
	elseif var_85_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_85_1 and self.viewComponent.ptActivity and var_85_1.id == self.viewComponent.ptActivity.id then
			self.viewComponent:updatePtActivity(var_85_1)
		end
	elseif var_85_0 == GAME.GET_REMASTER_TICKETS_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_85_1, function()
			self.viewComponent:updateRemasterTicket()

			return
		end)
	elseif var_85_0 == GAME.ACTIVITY_PERMANENT_START_DONE then
		local var_85_4 = var_85_1 and var_85_1.id

		if (var_85_1 and var_85_1.id) ~= self.bossRushRemasterActivityId then
			return
		end

		if not getProxy(ActivityPermanentProxy):IsActivityIdByType(var_85_4, ActivityPermanentProxy.TYPE_REMASTER_ACTIVITY) then
			return
		end

		self.bossRushRemasterActivityId = nil

		self:sendNotification(GAME.GO_SCENE, SCENE.BOSSRUSH_REMASTER, {
			id = var_85_4
		})
	elseif var_85_0 == CommanderProxy.PREFAB_FLEET_UPDATE then
		self.viewComponent:setCommanderPrefabs((getProxy(CommanderProxy):getPrefabFleet()))
		self.viewComponent:updateCommanderPrefab()
	elseif var_85_0 == GAME.COOMMANDER_EQUIP_TO_FLEET_DONE then
		self.viewComponent:updateFleet((getProxy(FleetProxy):GetRegularFleets()))
		self.viewComponent:RefreshFleetSelectView()
	elseif var_85_0 == GAME.SUBMIT_TASK_DONE then
		if self.contextData.map and self.contextData.map:isSkirmish() then
			self.viewComponent.mapBuilder:UpdateMapItems()
		end

		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_85_1, function()
			if self.contextData.map and self.contextData.map:isSkirmish() and self.contextData.TaskToSubmit then
				self.contextData.TaskToSubmit = nil

				self:sendNotification(GAME.SUBMIT_TASK, self.contextData.TaskToSubmit)
			end

			self.viewComponent.mapBuilder:OnSubmitTaskDone()

			return
		end)
	elseif var_85_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_85_1.awards, function()
			self.viewComponent.mapBuilder:OnSubmitTaskDone()

			return
		end)
	elseif var_85_0 == BagProxy.ITEM_UPDATED then
		self.viewComponent:setSpecialOperationTickets((getProxy(BagProxy):getItemsByType(Item.SPECIAL_OPERATION_TICKET)))
	elseif var_85_0 == ChapterProxy.CHAPTER_AUTO_FIGHT_FLAG_UPDATED then
		if not self:getViewComponent().levelStageView then
			return
		end

		self:getViewComponent().levelStageView:ActionInvoke("UpdateAutoFightMark")
	elseif var_85_0 == ChapterProxy.CHAPTER_SKIP_PRECOMBAT_UPDATED then
		if not self:getViewComponent().levelStageView then
			return
		end

		self:getViewComponent().levelStageView:ActionInvoke("UpdateSkipPreCombatMark")
	elseif var_85_0 == ChapterProxy.CHAPTER_REMASTER_INFO_UPDATED or var_85_0 == GAME.CHAPTER_REMASTER_INFO_REQUEST_DONE then
		self.viewComponent:updateRemasterInfo()
		self.viewComponent:updateRemasterBtnTip()
	elseif var_85_0 == GAME.CHAPTER_REMASTER_AWARD_RECEIVE_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_85_1)
	elseif var_85_0 == GAME.STORY_UPDATE_DONE then
		self.cachedStoryAwards = var_85_1
	elseif var_85_0 == GAME.STORY_END then
		if self.cachedStoryAwards then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, self.cachedStoryAwards.awards)

			self.cachedStoryAwards = nil
		end
	elseif var_85_0 == LevelUIConst.CONTINUOUS_OPERATION then
		self.viewComponent:emit(LevelUIConst.CONTINUOUS_OPERATION, var_85_1)
	elseif var_85_0 == GAME.TRACKING_ERROR then
		if self.waitingTracking then
			self:DisplayContinuousOperationResult(var_85_1.chapter, getProxy(ChapterProxy):PopContinuousData(SYSTEM_SCENARIO))
		end

		self.waitingTracking = nil
	elseif var_85_0 == LevelMediator2.ON_SPITEM_CHANGED then
		self.viewComponent:emit(LevelMediator2.ON_SPITEM_CHANGED, var_85_1)
	elseif var_85_0 == GAME.START_CHAPTER_AUTO_DONE then
		self.viewComponent:OnStartChapterAuto(var_85_1)
		self.viewComponent.mapBuilder:UpdateChapterTF(var_85_1.id)

		if var_85_1.isRemaster then
			self.viewComponent:updateRemasterTicket()
		end
	elseif var_85_0 == GAME.END_CHAPTER_AUTO_DONE then
		self.viewComponent:OnEndChapterAuto(var_85_1)
		self.viewComponent:HideChapterAutoDetailPanel(var_85_1)
		self.viewComponent.mapBuilder:UpdateChapterTF(var_85_1.id)

		if var_85_1.isRemaster then
			self.viewComponent:updateRemasterTicket()
		end

		self:addSubLayers(Context.New({
			viewComponent = ChapterAutoTotalRewardLayer,
			mediator = ChapterAutoTotalRewardMediator,
			data = {
				rewards = var_85_1.awards,
				totalTimes = var_85_1.allCnt,
				finishTimes = var_85_1.finishCnt,
				proficiency = var_85_1.proficiency
			}
		}), true)
	elseif var_85_0 == GAME.ADD_CHAPTER_AUTO_TIME_DONE then
		self.viewComponent:OnAddChapterAutoTimeDone(var_85_1)
	elseif var_85_0 == ChapterAutoProxy.FINISH_UPDATE then
		self.viewComponent.mapBuilder:UpdateMapItems()
	end

	return
end

function LevelMediator2:OnExitChapter(arg_120_1, arg_120_2, arg_120_3)
	assert(arg_120_1)
	seriesAsync({
		function(arg_121_0)
			if not self.contextData.chapterVO then
				return arg_121_0()
			end

			self.viewComponent:switchToMap(arg_121_0)

			return
		end,
		function(arg_122_0)
			self.viewComponent:addbubbleMsgBox(function()
				self.viewComponent:CleanBubbleMsgbox()
				arg_122_0()

				return
			end)

			return
		end,
		function(arg_124_0)
			if not arg_120_2 then
				return arg_124_0()
			end

			if arg_120_1.id == 103 and not getProxy(PlayerProxy):getData():GetCommonFlag(BATTLE_AUTO_ENABLED) then
				self.viewComponent:HandleShowMsgBox({
					modal = true,
					hideNo = true,
					content = i18n("battle_autobot_unlock"),
					onYes = arg_124_0,
					onNo = arg_124_0
				})
				self.viewComponent:emit(LevelMediator2.NOTICE_AUTOBOT_ENABLED, {})

				return
			end

			arg_124_0()

			return
		end,
		function(arg_125_0)
			if not arg_120_2 then
				return arg_125_0()
			end

			if getProxy(ChapterProxy):getMapById(arg_120_1:getConfig("map")):isSkirmish() then
				local var_125_0 = arg_120_1.id
				local var_125_1 = getProxy(SkirmishProxy):getRawData()
				local var_125_2 = _.detect(var_125_1, function(arg_126_0)
					return tonumber(arg_126_0:getConfig("event")) == var_125_0
				end)

				if not var_125_2 then
					arg_125_0()

					return
				end

				local var_125_3 = getProxy(TaskProxy)
				local var_125_4 = var_125_2:getConfig("task_id")
				local var_125_5 = var_125_3:getTaskVO(var_125_4)

				if var_125_5 and var_125_5:getTaskStatus() == 1 then
					self:sendNotification(GAME.SUBMIT_TASK, var_125_4)

					if var_125_2 == var_125_1[#var_125_1] then
						local var_125_6 = getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_ID_US_SKIRMISH_RE)

						assert(var_125_6, "Missing Skirmish Activity " .. (ActivityConst.ACTIVITY_ID_US_SKIRMISH_RE or "NIL"))

						local var_125_7 = var_125_6:getConfig("config_data")
						local var_125_8 = var_125_3:getTaskVO(var_125_7[#var_125_7][2])

						if var_125_8 and var_125_8:getTaskStatus() < 2 then
							self.contextData.TaskToSubmit = var_125_7[#var_125_7][2]
						end
					end
				end
			end

			arg_125_0()

			return
		end,
		function(arg_127_0)
			if not arg_120_2 then
				return arg_127_0()
			end

			local var_127_0 = getProxy(ChapterProxy):getMapById(arg_120_1:getConfig("map"))

			if var_127_0:isRemaster() then
				local var_127_1 = var_127_0:getRemaster()
				local var_127_2 = Map.GetRearChaptersOfRemaster(var_127_1)

				assert(var_127_2)

				if _.any(var_127_2, function(arg_128_0)
					return arg_128_0 == arg_120_1.id
				end) and BossRushChapterRemasterHelper.UnlockMemoryGroupStoriesAndShowMsgBox(pg.re_map_template[var_127_1].memory_group, arg_127_0) then
					return
				end
			end

			arg_127_0()

			return
		end,
		function(arg_129_0)
			if self.contextData.map and not self.contextData.map:isUnlock() then
				self.viewComponent:emit(LevelMediator2.ON_SWITCH_NORMAL_MAP)

				return
			end

			if not arg_120_3 then
				return arg_129_0()
			end

			local var_129_0 = arg_120_3 and arg_120_3.AutoFightFlag
			local var_129_1 = {}

			if arg_120_3 and arg_120_3.ResultDrops then
				for iter_129_0, iter_129_1 in ipairs(arg_120_3.ResultDrops) do
					var_129_1 = table.mergeArray(var_129_1, iter_129_1)
				end
			end

			local var_129_2 = {}

			if arg_120_3 and arg_120_3.TotalDrops then
				for iter_129_2, iter_129_3 in ipairs(arg_120_3.TotalDrops) do
					var_129_2 = table.mergeArray(var_129_2, iter_129_3)
				end
			end

			DropResultIntegration(var_129_2)

			local var_129_3 = getProxy(ChapterProxy):GetContinuousData(SYSTEM_SCENARIO)

			if var_129_3 then
				var_129_3:MergeDrops(var_129_2, var_129_1)
				var_129_3:MergeEvents(arg_120_3.ListEventNotify, arg_120_3.ListGuildEventNotify, arg_120_3.ListGuildEventAutoReceiveNotify)

				if arg_120_2 then
					var_129_3:ConsumeBattleTime()
				end

				if var_129_3:IsActive() and var_129_3:GetRestBattleTime() > 0 then
					self.waitingTracking = true

					self.viewComponent:emit(LevelMediator2.ON_RETRACKING, arg_120_1, var_129_0)

					return
				end

				getProxy(ChapterProxy):PopContinuousData(SYSTEM_SCENARIO)
				self:DisplayContinuousOperationResult(arg_120_1, var_129_3)
				arg_129_0()

				return
			end

			local var_129_4 = var_129_0 ~= nil

			if var_129_0 == nil and not arg_120_3.ResultDrops then
				return arg_129_0()
			end

			local var_129_5
			local var_129_6

			if var_129_4 then
				var_129_5 = i18n("autofight_rewards")
				var_129_6 = i18n("total_rewards_subtitle")
			else
				var_129_5 = i18n("settle_rewards_title")
				var_129_6 = i18n("settle_rewards_subtitle")
			end

			self:addSubLayers(Context.New({
				viewComponent = LevelStageTotalRewardPanel,
				mediator = LevelStageTotalRewardPanelMediator,
				data = {
					title = var_129_5,
					subTitle = var_129_6,
					chapter = arg_120_1,
					onClose = arg_129_0,
					rewards = var_129_2,
					resultRewards = var_129_1,
					events = arg_120_3.ListEventNotify,
					guildTasks = arg_120_3.ListGuildEventNotify,
					guildAutoReceives = arg_120_3.ListGuildEventAutoReceiveNotify,
					isAutoFight = var_129_0
				}
			}), true)

			return
		end,
		function(arg_130_0)
			if Map.autoNextPage then
				Map.autoNextPage = nil

				triggerButton(self.viewComponent.btnNext)
			end

			if arg_120_2 then
				self.viewComponent:RefreshMapBG()
			end

			self:TryPlaySubGuide()

			return
		end
	})

	return
end

function LevelMediator2:DisplayContinuousWindow(arg_131_1, arg_131_2, arg_131_3, arg_131_4)
	local var_131_0 = arg_131_1:getConfig("oil")

	if arg_131_1:IsSupportSubmarineStage() and #arg_131_1:getSupportFleet() > 0 then
		var_131_0 = var_131_0 + getGameset("submarine_support_oil_consume")[1]

		local var_131_1 = 0
		local var_131_2 = 0
	end

	if arg_131_1:getPlayType() == ChapterConst.TypeMultiStageBoss then
		var_131_1 = _.reduce(pg.chapter_model_multistageboss[arg_131_1.id].boss_refresh, 0, function(arg_132_0, arg_132_1)
			return arg_132_0 + arg_132_1
		end)
		var_131_2 = #pg.chapter_model_multistageboss[arg_131_1.id].boss_refresh
	else
		var_131_2 = 1
		var_131_1 = arg_131_1:getConfig("boss_refresh")
	end

	local var_131_3 = arg_131_1:getConfig("use_oil_limit")

	table.Foreach(arg_131_2, function(arg_133_0, arg_133_1)
		if arg_131_4[arg_133_0] == ChapterFleet.DUTY_IDLE then
			return
		end

		local var_133_0 = arg_133_1:GetCostSum().oil

		if arg_131_4[arg_133_0] == ChapterFleet.DUTY_KILLALL then
			local var_133_1 = var_131_3[1] or 0
			local var_133_2 = var_133_0

			if var_133_1 > 0 then
				var_133_2 = math.min(var_133_2, var_133_1)
			end

			local var_133_3 = var_131_3[2] or 0
			local var_133_4 = var_133_0

			if var_133_3 > 0 then
				var_133_4 = math.min(var_133_4, var_133_3)
			end

			var_131_0 = var_131_0 + var_133_2 * var_131_1 + var_133_4 * var_131_2
		elseif arg_131_4[arg_133_0] == ChapterFleet.DUTY_CLEANPATH then
			local var_133_5 = var_131_3[1] or 0
			local var_133_6 = var_133_0

			if var_133_5 > 0 then
				var_133_6 = math.min(var_133_6, var_133_5)
			end

			var_131_0 = var_131_0 + var_133_6 * var_131_1
		elseif arg_131_4[arg_133_0] == ChapterFleet.DUTY_KILLBOSS then
			local var_133_7 = var_131_3[2] or 0
			local var_133_8 = var_133_0

			if var_133_7 > 0 then
				var_133_8 = math.min(var_133_8, var_133_7)
			end

			var_131_0 = var_131_0 + var_133_8 * var_131_2
		end

		return
	end)

	local var_131_4 = arg_131_1:GetMaxBattleCount()
	local var_131_5 = arg_131_3 and arg_131_3 > 0
	local var_131_6 = arg_131_1:GetSpItems()

	if var_131_6[1] then
		local var_131_7 = var_131_6[1].count or 0

		if var_131_6[1] then
			local var_131_8 = var_131_6[1].id
			local var_131_9
			local var_131_10
			local var_131_11

			if not var_131_6[1].id then
				var_131_8 = 0
				var_131_9 = {
					mediator = LevelContinuousOperationWindowMediator,
					viewComponent = LevelContinuousOperationWindow
				}
				var_131_10 = {
					maxCount = var_131_4,
					oilCost = var_131_0,
					chapter = arg_131_1
				}
				var_131_11 = {
					rate = 2,
					enabled = var_131_5,
					extraCount = var_131_7,
					spItemId = var_131_8
				}
			end
		end
	end

	var_131_11.freeBonus = arg_131_1:GetRestDailyBonus()
	var_131_10.extraRate = var_131_11
	var_131_9.data = var_131_10

	self:addSubLayers(Context.New(var_131_9))

	return
end

function LevelMediator2:DisplayContinuousOperationResult(arg_134_1, arg_134_2)
	self:addSubLayers(Context.New({
		viewComponent = LevelContinuousOperationTotalRewardPanel,
		mediator = LevelStageTotalRewardPanelMediator,
		data = {
			title = i18n("autofight_rewards"),
			subTitle = i18n("total_rewards_subtitle"),
			chapter = arg_134_1,
			rewards = arg_134_2:GetDrops(),
			resultRewards = arg_134_2:GetSettlementDrops(),
			continuousData = arg_134_2,
			events = arg_134_2:GetEvents(1),
			guildTasks = arg_134_2:GetEvents(2),
			guildAutoReceives = arg_134_2:GetEvents(3)
		}
	}), true)

	return
end

function LevelMediator2:OnEventUpdate(arg_135_1)
	local var_135_0 = getProxy(EventProxy)

	self.viewComponent:updateEvent(var_135_0)

	if pg.SystemOpenMgr.GetInstance():isOpenSystem(self.player.level, "EventMediator") and var_135_0.eventForMsg then
		local var_135_1 = var_135_0.eventForMsg.id or 0
		local var_135_2 = getProxy(ChapterProxy):getActiveChapter(true)

		if var_135_2 and var_135_2:IsAutoFight() then
			getProxy(ChapterProxy):AddExtendChapterDataArray(var_135_2.id, "ListEventNotify", var_135_1)
			existCall(arg_135_1)
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				modal = false,
				hideNo = true,
				content = i18n("event_special_update", (pg.collection_template[var_135_1] or nil) and (pg.collection_template[var_135_1].title or "")),
				onYes = arg_135_1,
				onNo = arg_135_1
			})
		end

		var_135_0.eventForMsg = nil
	else
		existCall(arg_135_1)
	end

	return
end

function LevelMediator2:onTimeUp()
	local var_136_0 = getProxy(ChapterProxy):getActiveChapter()

	if var_136_0 and not var_136_0:inWartime() then
		local function var_136_1()
			self:sendNotification(GAME.CHAPTER_OP, {
				type = ChapterConst.OpRetreat
			})

			return
		end

		if self.contextData.chapterVO then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				modal = true,
				hideNo = true,
				content = i18n("battle_preCombatMediator_timeout"),
				onYes = var_136_1,
				onNo = var_136_1
			})
		else
			var_136_1()
			pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_chapter_timeout"))
		end
	end

	return
end

function LevelMediator2:getDockCallbackFuncs(arg_138_1, arg_138_2, arg_138_3, arg_138_4)
	local var_138_0 = getProxy(ChapterProxy)

	return function(arg_139_0, arg_139_1)
		local var_139_0, var_139_1 = ShipStatus.ShipStatusCheck("inElite", arg_139_0, arg_139_1, {
			inElite = arg_138_3:getConfig("formation")
		})

		if not var_139_0 then
			return var_139_0, var_139_1
		end

		for iter_139_0, iter_139_1 in pairs(arg_138_1) do
			if arg_139_0:isSameKind(iter_139_0) then
				local var_139_3 = i18n("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end, function(arg_140_0, arg_140_1, arg_140_2)
		arg_140_1()

		return
	end, function(arg_141_0)
		local var_141_0 = arg_138_3:getEliteFleetList()[arg_138_4]

		if arg_138_2 then
			local var_141_1 = table.indexof(var_141_0, arg_138_2.id)

			assert(var_141_1)

			if arg_141_0[1] then
				var_141_0[var_141_1] = arg_141_0[1]
			else
				table.remove(var_141_0, var_141_1)
			end
		else
			table.insert(var_141_0, arg_141_0[1])
		end

		arg_138_3:setEliteFleetByIndex(arg_138_4, {
			{
				TeamType.FormShips,
				var_141_0
			}
		})
		var_138_0:updateChapter(arg_138_3)
		var_138_0:duplicateEliteFleet(arg_138_3)

		return
	end
end

function LevelMediator2:getSupportDockCallbackFuncs(arg_142_1, arg_142_2, arg_142_3)
	local var_142_0 = getProxy(ChapterProxy)

	return function(arg_143_0, arg_143_1)
		local var_143_0, var_143_1 = ShipStatus.ShipStatusCheck("inSupport", arg_143_0, arg_143_1)

		if not var_143_0 then
			return var_143_0, var_143_1
		end

		for iter_143_0, iter_143_1 in pairs(arg_142_1) do
			if arg_143_0:isSameKind(iter_143_0) then
				local var_143_3 = i18n("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end, function(arg_144_0, arg_144_1, arg_144_2)
		arg_144_1()

		return
	end, function(arg_145_0)
		local var_145_0 = arg_142_3:getSupportFleet()

		if arg_142_2 then
			local var_145_1 = table.indexof(var_145_0, arg_142_2.id)

			assert(var_145_1)

			if arg_145_0[1] then
				var_145_0[var_145_1] = arg_145_0[1]
			else
				table.remove(var_145_0, var_145_1)
			end
		else
			table.insert(var_145_0, arg_145_0[1])
		end

		arg_142_3:setEliteFleetByIndex(4, {
			{
				TeamType.FormShips,
				var_145_0
			}
		})
		var_142_0:updateChapter(arg_142_3)
		var_142_0:duplicateEliteFleet(arg_142_3)

		return
	end
end

function LevelMediator2:playAIActions(arg_146_1, arg_146_2, arg_146_3)
	if not self.viewComponent.grid then
		arg_146_3()

		return
	end

	local var_146_0 = getProxy(ChapterProxy)
	local var_146_1

	local function var_146_2()
		if var_146_1 and coroutine.status(var_146_1) == "suspended" then
			local var_147_0, var_147_1 = coroutine.resume(var_146_1)

			assert(var_147_0, debug.traceback(var_146_1, var_147_1))

			if not var_147_0 then
				self.viewComponent:unfrozen(-1)
				self:sendNotification(GAME.CHAPTER_OP, {
					type = ChapterConst.OpRequest
				})
			end
		end

		return
	end

	var_146_1 = coroutine.create(function()
		self.viewComponent:frozen()

		local var_148_0 = {}
		local var_148_1 = arg_146_2 or 0

		for iter_148_0, iter_148_1 in ipairs(arg_146_1) do
			local var_148_2 = self.contextData.chapterVO
			local var_148_3, var_148_4 = iter_148_1:applyTo(self.contextData.chapterVO, true)

			assert(var_148_3, var_148_4)
			iter_148_1:PlayAIAction(self.contextData.chapterVO, self, function()
				local var_149_0, var_149_1, var_149_2 = iter_148_1:applyTo(var_148_2, false)

				if var_149_0 then
					var_146_0:updateChapter(var_148_2, var_149_1)

					var_148_1 = bit.bor(var_148_1, var_149_2 or 0)
				end

				onNextTick(var_146_2)

				return
			end)
			coroutine.yield()

			if isa(iter_148_1, FleetAIAction) and iter_148_1.actType == ChapterConst.ActType_Poison and self.contextData.chapterVO:existFleet(FleetType.Normal, iter_148_1.line.row, iter_148_1.line.column) then
				table.insert(var_148_0, (self.contextData.chapterVO:getFleetIndex(FleetType.Normal, iter_148_1.line.row, iter_148_1.line.column)))
			end
		end

		local var_148_5 = bit.band(var_148_1, ChapterConst.DirtyAutoAction)

		var_148_1 = bit.band(var_148_1, bit.bnot(ChapterConst.DirtyAutoAction))

		if var_148_1 ~= 0 then
			var_146_0:updateChapter(self.contextData.chapterVO, var_148_1)
		end

		seriesAsync({
			function(arg_150_0)
				if var_148_5 ~= 0 then
					self.viewComponent.levelStageView:tryAutoAction(arg_150_0)
				else
					arg_150_0()
				end

				return
			end,
			function(arg_151_0)
				table.ParallelIpairsAsync(var_148_0, function(arg_152_0, arg_152_1, arg_152_2)
					self.viewComponent.grid:showFleetPoisonDamage(arg_152_1, arg_152_2)

					return
				end, arg_151_0)

				return
			end,
			function(arg_153_0)
				arg_146_3()
				self.viewComponent:unfrozen()

				return
			end
		})

		return
	end)

	var_146_2()

	return
end

function LevelMediator2:saveSubState(arg_154_1)
	PlayerPrefs.SetInt("chapter_submarine_ai_type_" .. getProxy(PlayerProxy):getRawData().id, arg_154_1 + 1)
	PlayerPrefs.Save()

	return
end

function LevelMediator2:loadSubState(arg_155_1)
	local var_155_0 = math.clamp(PlayerPrefs.GetInt("chapter_submarine_ai_type_" .. getProxy(PlayerProxy):getRawData().id, 1) - 1, 0, 1)

	if var_155_0 ~= arg_155_1 then
		self.viewComponent:emit(LevelMediator2.ON_OP, {
			type = ChapterConst.OpSubState,
			arg1 = var_155_0
		})
	end

	return
end

function LevelMediator2:remove()
	self:removeSubLayers(LevelContinuousOperationWindowMediator)
	LevelMediator2.super.remove(self)

	return
end

return LevelMediator2
