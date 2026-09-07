local CommissionInfoMediator = class("CommissionInfoMediator", import("...base.ContextMediator"))

CommissionInfoMediator.FINISH_EVENT = "CommissionInfoMediator.FINISH_EVENT"
CommissionInfoMediator.FINISH_CLASS = "CommissionInfoMediator.FINISH_CLASS"
CommissionInfoMediator.GET_OIL_RES = "CommissionInfoMediator.GET_OIL_RES"
CommissionInfoMediator.GET_GOLD_RES = "CommissionInfoMediator.GET_GOLD_RES"
CommissionInfoMediator.ON_ACTIVE_EVENT = "CommissionInfoMediator.ON_ACTIVE_EVENT"
CommissionInfoMediator.ON_ACTIVE_CLASS = "CommissionInfoMediator.ON_ACTIVE_CLASS"
CommissionInfoMediator.ON_ACTIVE_TECH = "CommissionInfoMediator.ON_ACTIVE_TECH"
CommissionInfoMediator.ON_TECH_FINISHED = "CommissionInfoMediator.ON_TECH_FINISHED"
CommissionInfoMediator.ON_TECH_QUEUE_FINISH = "CommissionInfoMediator.ON_TECH_QUEUE_FINISH"
CommissionInfoMediator.ON_INS = "CommissionInfoMediator.ON_INS"
CommissionInfoMediator.ON_UR_ACTIVITY = "CommissionInfoMediator:ON_UR_ACTIVITY"
CommissionInfoMediator.ON_CRUSING = "CommissionInfoMediator.ON_CRUSING"
CommissionInfoMediator.GET_CLASS_RES = "CommissionInfoMediator:GET_CLASS_RES"
CommissionInfoMediator.FINISH_CLASS_ALL = "CommissionInfoMediator:FINISH_CLASS_ALL"
CommissionInfoMediator.GO_META_BOSS = "CommissionInfoMediator:GO_META_BOSS"
CommissionInfoMediator.GO_BATTLE = "CommissionInfoMediator.GO_BATTLE"
CommissionInfoMediator.ON_END_CHAPTER_AUTO = "CommissionInfoMediator.ON_END_CHAPTER_AUTO"

function CommissionInfoMediator:register()
	self.viewComponent:setPlayer(getProxy(PlayerProxy):getData())
	self:bind(LevelMediator2.GET_CHAPTER_DROP_SHIP_LIST, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.GET_CHAPTER_DROP_SHIP_LIST, {
			chapterId = arg_2_1,
			callback = arg_2_2
		})

		return
	end)
	self:bind(CommissionInfoMediator.ON_END_CHAPTER_AUTO, function(arg_3_0)
		self:sendNotification(GAME.END_CHAPTER_AUTO, {
			num = getProxy(ChapterAutoProxy):GetFinishedCnt()
		})

		return
	end)
	self:bind(CommissionInfoMediator.GO_BATTLE, function(arg_4_0)
		local var_4_0 = getProxy(ChapterProxy):getActiveChapter()

		self:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
			chapterId = var_4_0 and var_4_0.id,
			mapIdx = var_4_0 and var_4_0:getConfig("map")
		})

		return
	end)
	self:bind(CommissionInfoMediator.GO_META_BOSS, function(arg_5_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.WORLDBOSS)

		return
	end)
	self:bind(CommissionInfoMediator.ON_UR_ACTIVITY, function(arg_6_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.UR_ITEM_ACT_ID
		})

		return
	end)
	self:bind(CommissionInfoMediator.ON_CRUSING, function(arg_7_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.CRUSING)

		return
	end)
	self:bind(CommissionInfoMediator.GET_CLASS_RES, function(arg_8_0)
		self:sendNotification(GAME.HARVEST_CLASS_RES)

		return
	end)
	self:bind(CommissionInfoMediator.ON_TECH_QUEUE_FINISH, function(arg_9_0)
		self:sendNotification(GAME.FINISH_QUEUE_TECHNOLOGY)

		return
	end)
	self:bind(CommissionInfoMediator.ON_TECH_FINISHED, function(arg_10_0, arg_10_1)
		self:sendNotification(GAME.FINISH_TECHNOLOGY, {
			id = arg_10_1.id,
			pool_id = arg_10_1.pool_id
		})

		return
	end)
	self:bind(CommissionInfoMediator.FINISH_EVENT, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		self.contextData.oneStepFinishEventCount = arg_11_2
		self.contextData.inFinished = true

		self:sendNotification(GAME.EVENT_FINISH, {
			id = arg_11_1.id,
			callback = function()
				self.contextData.inFinished = nil

				return
			end,
			onConfirm = function()
				if arg_11_3 then
					arg_11_3()
				end

				if self.contextData.oneStepFinishEventCount then
					self.contextData.oneStepFinishEventCount = self.contextData.oneStepFinishEventCount - 1

					if self.contextData.oneStepFinishEventCount <= 0 then
						MainMetaSkillSequence.New():Execute()
					end
				else
					MainMetaSkillSequence.New():Execute()
				end

				return
			end
		})

		return
	end)
	self:bind(CommissionInfoMediator.FINISH_CLASS, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
		self:sendNotification(GAME.CANCEL_LEARN_TACTICS, {
			shipId = arg_14_1,
			type = arg_14_2,
			onConfirm = arg_14_3
		})

		return
	end)
	self:bind(CommissionInfoMediator.ON_ACTIVE_EVENT, function(arg_15_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.EVENT)

		return
	end)
	self:bind(CommissionInfoMediator.ON_ACTIVE_CLASS, function(arg_16_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.NAVALTACTICS)

		return
	end)
	self:bind(CommissionInfoMediator.ON_ACTIVE_TECH, function(arg_17_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.TECHNOLOGY)

		return
	end)
	self:bind(CommissionInfoMediator.GET_OIL_RES, function(arg_18_0)
		self:sendNotification(GAME.HARVEST_RES, PlayerConst.ResOil)

		return
	end)
	self:bind(CommissionInfoMediator.GET_GOLD_RES, function(arg_19_0)
		self:sendNotification(GAME.HARVEST_RES, PlayerConst.ResGold)

		return
	end)
	self:bind(CommissionInfoMediator.ON_INS, function(arg_20_0)
		self:sendNotification(GAME.ON_OPEN_INS_LAYER)
		self.viewComponent:emit(BaseUI.ON_CLOSE)

		return
	end)
	self:bind(CommissionInfoMediator.FINISH_CLASS_ALL, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.NAVALTACTICS)

		return
	end)
	self:Notify()

	return
end

function CommissionInfoMediator:Notify()
	self.viewComponent:NotifyIns()
	self.viewComponent:UpdateLinkPanel()

	return
end

function CommissionInfoMediator:continueClass(arg_23_1, arg_23_2, arg_23_3)
	if table.getCount(getProxy(BagProxy):getItemsByType(Item.LESSON_TYPE) or {}) <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_no_lesson"))

		return
	end

	self:sendNotification(GAME.GO_SCENE, SCENE.NAVALTACTICS, {
		shipToLesson = {
			shipId = arg_23_1,
			skillIndex = getProxy(BayProxy):getShipById(arg_23_1):getSkillIndex(arg_23_2),
			index = arg_23_3
		}
	})

	return
end

function CommissionInfoMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		GAME.HARVEST_RES_DONE,
		GAME.EVENT_LIST_UPDATE,
		GAME.EVENT_FINISH_UPDATE,
		GAME.EVENT_SHOW_AWARDS,
		GAME.CANCEL_LEARN_TACTICS_DONE,
		GAME.FINISH_TECHNOLOGY_DONE,
		GAME.FINISH_QUEUE_TECHNOLOGY_DONE,
		GAME.START_CHAPTER_AUTO_DONE,
		GAME.END_CHAPTER_AUTO_DONE,
		GAME.ZERO_HOUR_OP_DONE
	}
end

function CommissionInfoMediator:handleNotification(arg_25_1)
	local var_25_0 = arg_25_1:getName()
	local var_25_1 = arg_25_1:getBody()

	if var_25_0 == PlayerProxy.UPDATED then
		self.viewComponent:OnPlayerUpdate(var_25_1)
	elseif var_25_0 == GAME.HARVEST_RES_DONE then
		local var_25_2

		if var_25_1.type == 2 then
			var_25_2 = i18n("word_oil")
		elseif var_25_1.type == 1 then
			var_25_2 = i18n("word_gold")
		end

		pg.TipsMgr.GetInstance():ShowTips(i18n("commission_get_award", var_25_2, var_25_1.outPut))
	elseif var_25_0 == GAME.EVENT_LIST_UPDATE or var_25_0 == GAME.EVENT_FINISH_UPDATE then
		local var_25_3 = getProxy(EventProxy)

		self.viewComponent:OnUpdateEventInfo()
	elseif var_25_0 == GAME.EVENT_SHOW_AWARDS then
		local var_25_4

		var_25_4 = coroutine.wrap(function()
			if #var_25_1.oldShips > 0 then
				self.viewComponent:emit(BaseUI.ON_SHIP_EXP, {
					title = pg.collection_template[var_25_1.eventId].title,
					oldShips = var_25_1.oldShips,
					newShips = var_25_1.newShips,
					isCri = var_25_1.isCri
				}, var_25_4)
				coroutine.yield()
			end

			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_25_1.awards, function()
				if var_25_1.onConfirm then
					var_25_1.onConfirm()
				end

				return
			end)

			return
		end)

		;(nil)()
	elseif var_25_0 == GAME.CANCEL_LEARN_TACTICS_DONE then
		self.viewComponent:OnUpdateClass()

		local var_25_5 = var_25_1.totalExp
		local var_25_6 = var_25_1.newSkill
		local var_25_7 = getProxy(BayProxy):getShipById(var_25_1.shipId)
		local var_25_8 = var_25_1.newSkill.id
		local var_25_9 = var_25_1.newSkill.level > var_25_1.oldSkill.level and i18n("tactics_end_to_learn", var_25_7:getName(), getSkillName(var_25_8), var_25_5) .. i18n("tactics_skill_level_up", var_25_1.oldSkill.level, var_25_6.level) or i18n("tactics_end_to_learn", var_25_7:getName(), getSkillName(var_25_8), var_25_5)

		if pg.skill_data_template[var_25_8].max_level <= var_25_6.level then
			self:HandleClassMaxLevel(var_25_7, var_25_1, var_25_8, var_25_5)
		else
			local var_25_10 = {
				modal = true,
				hideNo = false,
				hideClose = true
			}

			var_25_10.content = var_25_9 .. i18n("tactics_continue_to_learn")

			function var_25_10.onYes()
				self.openMsgBox = false

				self:continueClass(var_25_1.shipId, var_25_8, var_25_1.id)

				return
			end

			function var_25_10.onNo()
				self.openMsgBox = false

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox(var_25_10)
		end
	elseif var_25_0 == GAME.FINISH_TECHNOLOGY_DONE then
		self.viewComponent:OnUpdateTechnology()

		if #var_25_1.items > 0 then
			self.viewComponent:emit(BaseUI.ON_AWARD, {
				animation = true,
				items = var_25_1.items
			})
		end
	elseif var_25_0 == GAME.FINISH_QUEUE_TECHNOLOGY_DONE then
		self.viewComponent:OnUpdateTechnology()

		local var_25_11 = {}

		for iter_25_0, iter_25_1 in ipairs(var_25_1.dropInfos) do
			if #iter_25_1 > 0 then
				table.insert(var_25_11, function(arg_30_0)
					self.viewComponent:emit(BaseUI.ON_AWARD, {
						animation = true,
						items = iter_25_1,
						removeFunc = arg_30_0
					})

					return
				end)
			end
		end

		seriesAsync(var_25_11, function()
			local var_31_0 = getProxy(TechnologyProxy):getActivateTechnology()

			if var_31_0 and var_31_0:isCompleted() then
				self:sendNotification(GAME.FINISH_TECHNOLOGY, {
					id = var_31_0.id,
					pool_id = var_31_0.poolId
				})
			end

			return
		end)
	elseif var_25_0 == GAME.END_CHAPTER_AUTO_DONE then
		self:addSubLayers(Context.New({
			viewComponent = ChapterAutoTotalRewardLayer,
			mediator = ChapterAutoTotalRewardMediator,
			data = {
				rewards = var_25_1.awards,
				totalTimes = var_25_1.allCnt,
				finishTimes = var_25_1.finishCnt,
				proficiency = var_25_1.proficiency,
				onClose = function()
					self.viewComponent:OnUpdateChapterAuto()

					return
				end
			}
		}), true)
	elseif var_25_0 == START_CHAPTER_AUTO_DONE then
		self.viewComponent:OnUpdateChapterAuto()
	elseif var_25_0 == GAME.ZERO_HOUR_OP_DONE then
		self.viewComponent:OnUpdateChapterAuto()
	end

	return
end

function CommissionInfoMediator:HandleClassMaxLevel(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = i18n("tactics_end_to_learn", arg_33_1:getName(), getSkillName(arg_33_3), arg_33_4)

	if _.all(arg_33_1:getSkillList(), function(arg_34_0)
		return ShipSkill.New(arg_33_1.skills[arg_34_0]):IsMaxLevel()
	end) then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			hideClose = true,
			content = var_33_0 .. i18n("tactics_continue_to_learn_other_ship_skill"),
			onYes = function()
				self:sendNotification(GAME.GO_SCENE, SCENE.NAVALTACTICS)

				return
			end
		})
	else
		local var_33_1 = {
			modal = true,
			hideClose = true
		}

		var_33_1.content = var_33_0 .. i18n("tactics_continue_to_learn_other_skill")

		function var_33_1.onYes()
			self:sendNotification(GAME.GO_SCENE, SCENE.NAVALTACTICS, {
				shipToLesson = {
					shipId = arg_33_2.shipId,
					index = arg_33_2.id
				}
			})

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox(var_33_1)
	end

	return
end

return CommissionInfoMediator
