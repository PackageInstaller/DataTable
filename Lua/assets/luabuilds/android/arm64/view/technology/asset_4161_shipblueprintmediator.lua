local ShipBluePrintMediator = class("ShipBluePrintMediator", import("..base.ContextMediator"))

ShipBluePrintMediator.ON_CLICK_SPEEDUP_BTN = "ShipBluePrintMediator:ON_CLICK_SPEEDUP_BTN"
ShipBluePrintMediator.ON_START = "ShipBluePrintMediator:ON_START"
ShipBluePrintMediator.ON_FINISHED = "ShipBluePrintMediator:ON_FINISHED"
ShipBluePrintMediator.ON_ITEM_UNLOCK = "ShipBluePrintMediator:ON_ITEM_UNLOCK"
ShipBluePrintMediator.ON_FINISH_TASK = "ShipBluePrintMediator:ON_FINISH_TASK"
ShipBluePrintMediator.ON_MOD = "ShipBluePrintMediator:ON_MOD"
ShipBluePrintMediator.ON_PURSUING = "ShipBluePrintMediator:ON_PURSUING"
ShipBluePrintMediator.ON_TASK_OPEN = "ShipBluePrintMediator:ON_TASK_OPEN"
ShipBluePrintMediator.ON_CHECK_TAKES = "ShipBluePrintMediator:ON_CHECK_TAKES"
ShipBluePrintMediator.SHOW_SKILL_INFO = "ShipBluePrintMediator:SHOW_SKILL_INFO"
ShipBluePrintMediator.SET_TECHNOLOGY_VERSION = "ShipBluePrintMediator:SET_TECHNOLOGY_VERSION"
ShipBluePrintMediator.SIMULATION_BATTLE = "ShipBluePrintMediator:SIMULATION_BATTLE"
ShipBluePrintMediator.QUICK_EXCHAGE_BLUEPRINT = "ShipBluePrintMediator:QUICK_EXCHAGE_BLUEPRINT"
ShipBluePrintMediator.FINISH_PHANTOM_QUEST = "ShipBluePrintMediator.FINISH_PHANTOM_QUEST"
ShipBluePrintMediator.OPEN_PHANTOM_LAYER = "ShipBluePrintMediator.OPEN_PHANTOM_LAYER"

function ShipBluePrintMediator:register()
	PlayerPrefs.SetString("technology_day_mark", pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d", true))

	local var_1_0 = getProxy(TechnologyProxy)

	if self.contextData.shipId then
		self.contextData.shipBluePrintVO = var_1_0:getBluePrintById(getProxy(BayProxy):getShipById(self.contextData.shipId).groupId)
	elseif self.contextData.shipGroupId then
		self.contextData.shipBluePrintVO = var_1_0:getBluePrintById(self.contextData.shipGroupId)
	end

	self:bind(ShipBluePrintMediator.ON_CLICK_SPEEDUP_BTN, function()
		self:addSubLayers(Context.New({
			viewComponent = TecSpeedUpLayer,
			mediator = TecSpeedUpMediator
		}))

		return
	end)
	self:bind(ShipBluePrintMediator.ON_START, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.BUILD_SHIP_BLUEPRINT, {
			id = arg_3_1
		})

		return
	end)
	self:bind(ShipBluePrintMediator.ON_FINISHED, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.FINISH_SHIP_BLUEPRINT, {
			id = arg_4_1
		})

		return
	end)
	self:bind(ShipBluePrintMediator.ON_ITEM_UNLOCK, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.ITEM_LOCK_SHIP_BLUPRINT, {
			id = arg_5_1,
			itemId = arg_5_2
		})

		return
	end)
	self:bind(ShipBluePrintMediator.ON_FINISH_TASK, function(arg_6_0, arg_6_1)
		local var_6_0 = Task.New({
			id = arg_6_1
		})

		if var_6_0:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_ITEM then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("blueprint_commit_tip", (getDropInfo({
					{
						DROP_TYPE_ITEM,
						tonumber(var_6_0:getConfig("target_id")),
						var_6_0:getConfig("target_num")
					}
				}))),
				onYes = function()
					self:sendNotification(GAME.SUBMIT_TASK, arg_6_1)

					return
				end
			})
		elseif var_6_0:getConfig("sub_type") == TASK_SUB_TYPE_PLAYER_RES then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("blueprint_commit_tip", (getDropInfo({
					{
						DROP_TYPE_RESOURCE,
						tonumber(var_6_0:getConfig("target_id")),
						var_6_0:getConfig("target_num")
					}
				}))),
				onYes = function()
					self:sendNotification(GAME.SUBMIT_TASK, arg_6_1)

					return
				end
			})
		else
			self:sendNotification(GAME.SUBMIT_TASK, arg_6_1)
		end

		return
	end)
	self:bind(ShipBluePrintMediator.ON_MOD, function(arg_9_0, arg_9_1, arg_9_2)
		self:sendNotification(GAME.MOD_BLUEPRINT, {
			id = arg_9_1,
			count = arg_9_2
		})

		return
	end)
	self:bind(ShipBluePrintMediator.ON_PURSUING, function(arg_10_0, arg_10_1, arg_10_2)
		self:sendNotification(GAME.PURSUING_BLUEPRINT, {
			id = arg_10_1,
			count = arg_10_2
		})

		return
	end)
	self:bind(ShipBluePrintMediator.ON_TASK_OPEN, function(arg_11_0, arg_11_1)
		if not getProxy(TaskProxy):isFinishPrevTasks(arg_11_1) then
			return
		end

		self:sendNotification(GAME.TRIGGER_TASK, arg_11_1)

		return
	end)
	self:bind(ShipBluePrintMediator.ON_CHECK_TAKES, function(arg_12_0, arg_12_1)
		local var_12_0 = getProxy(TechnologyProxy)
		local var_12_1 = var_12_0:getBluePrintById(arg_12_1)

		if var_12_1:isFinishedAllTasks() then
			var_12_1:finish()
			var_12_0:updateBluePrint(var_12_1)
		end

		return
	end)
	self:bind(ShipBluePrintMediator.SHOW_SKILL_INFO, function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		self:addSubLayers(Context.New({
			mediator = SkillInfoMediator,
			viewComponent = SkillInfoLayer,
			data = {
				skillOnShip = arg_13_2,
				skillId = arg_13_1,
				onExit = arg_13_3
			}
		}))

		return
	end)
	self:bind(ShipBluePrintMediator.SET_TECHNOLOGY_VERSION, function(arg_14_0, arg_14_1)
		var_1_0:setVersion(arg_14_1)

		return
	end)
	self:bind(ShipBluePrintMediator.SIMULATION_BATTLE, function(arg_15_0, arg_15_1)
		self:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_SIMULATION,
			stageId = arg_15_1
		})

		return
	end)
	self:bind(ShipBluePrintMediator.QUICK_EXCHAGE_BLUEPRINT, function(arg_16_0, arg_16_1)
		self:sendNotification(GAME.QUICK_EXCHANGE_BLUEPRINT, arg_16_1)

		return
	end)
	self:bind(ShipBluePrintMediator.FINISH_PHANTOM_QUEST, function(arg_17_0, arg_17_1, arg_17_2)
		self:sendNotification(GAME.FINISH_PHANTOM_QUEST, {
			bluePrintId = arg_17_1,
			questId = arg_17_2
		})

		return
	end)
	self:bind(ShipBluePrintMediator.OPEN_PHANTOM_LAYER, function(arg_18_0, arg_18_1)
		self:addSubLayers(Context.New({
			mediator = DockyardMediator,
			viewComponent = DockyardScene,
			data = {
				mode = DockyardScene.MODE_SHIP_PHANTOM,
				techVersion = arg_18_1
			},
			onRemoved = function()
				self.viewComponent:changeEffectVisible(true)
				self.viewComponent:updateMod()

				return
			end
		}))
		self.viewComponent:changeEffectVisible(false)

		return
	end)
	self.viewComponent:setShipBluePrints((var_1_0:getBluePrints()))
	self.viewComponent:setShipVOs(getProxy(BayProxy):getRawData())
	self.viewComponent:setVersion(var_1_0:getVersion())
	self.viewComponent:setTaskVOs(getProxy(TaskProxy):getTasksForBluePrint())

	return
end

function ShipBluePrintMediator:listNotificationInterests()
	return {
		GAME.BUILD_SHIP_BLUEPRINT_DONE,
		TechnologyProxy.BLUEPRINT_UPDATED,
		TaskProxy.TASK_ADDED,
		TaskProxy.TASK_UPDATED,
		TaskProxy.TASK_REMOVED,
		TaskProxy.TASK_DELETE,
		GAME.SUBMIT_TASK_DONE,
		GAME.FINISH_SHIP_BLUEPRINT_DONE,
		GAME.ITEM_LOCK_SHIP_BLUPRINT_DONE,
		GAME.STOP_BLUEPRINT_DONE,
		GAME.MOD_BLUEPRINT_DONE,
		BayProxy.SHIP_ADDED,
		BayProxy.SHIP_UPDATED,
		GAME.BEGIN_STAGE_DONE,
		GAME.MOD_BLUEPRINT_ANIM_LOCK,
		GAME.PURSUING_RESET_DONE,
		GAME.QUICK_EXCHANGE_BLUEPRINT_DONE,
		GAME.FINISH_PHANTOM_QUEST_DONE
	}
end

function ShipBluePrintMediator:handleNotification(arg_21_1)
	local var_21_0 = arg_21_1:getName()
	local var_21_1 = arg_21_1:getBody()

	if var_21_0 == TechnologyProxy.BLUEPRINT_UPDATED then
		self.viewComponent:updateShipBluePrintVO(var_21_1)
	elseif var_21_0 == GAME.EXCHANG_BLUEPRINT_DONE then
		self.viewComponent:clearSelected()
		self.viewComponent:updateExchangeItems()
		self.viewComponent:updateBuildInfo()
	elseif var_21_0 ~= TaskProxy.TASK_ADDED and TaskProxy.TASK_UPDATED ~= var_21_0 and TaskProxy.TASK_REMOVED ~= var_21_0 then
		if TaskProxy.TASK_DELETE == var_21_0 then
			self.viewComponent:setTaskVOs(getProxy(TaskProxy):getTasksForBluePrint())
			self.viewComponent:updateTaskList()
			self.viewComponent:updateTasksProgress()
		elseif var_21_0 == GAME.SUBMIT_TASK_DONE then
			if self.contextData.shipBluePrintVO and self.contextData.shipBluePrintVO:isDeving() and self.contextData.shipBluePrintVO:isFinishedAllTasks() then
				local var_21_2 = getProxy(TechnologyProxy)
				local var_21_3 = var_21_2:getBluePrintById(self.contextData.shipBluePrintVO.id)

				var_21_3:finish()
				var_21_2:updateBluePrint(var_21_3)
			end
		elseif var_21_0 == GAME.FINISH_SHIP_BLUEPRINT_DONE or var_21_0 == GAME.ITEM_LOCK_SHIP_BLUPRINT_DONE then
			self:addSubLayers(Context.New({
				mediator = NewShipMediator,
				viewComponent = NewShipLayer,
				data = {
					ship = var_21_1.ship,
					canSkipBatch = var_21_1.canSkipBatch
				},
				onRemoved = function()
					pg.NewStoryMgr.GetInstance():Play("FANGAN2", function()
						if not pg.NewStoryMgr.GetInstance():IsPlayed("PHANTOM_HELP") then
							pg.NewGuideMgr.GetInstance():Play("PHANTOM_HELP")
							pg.m02:sendNotification(GAME.STORY_UPDATE, {
								storyId = "PHANTOM_HELP"
							})
						end

						return
					end)

					return
				end
			}))
		elseif GAME.STOP_BLUEPRINT_DONE == var_21_0 then
			self.viewComponent:clearTimers(var_21_1.id)
		elseif GAME.MOD_BLUEPRINT_DONE == var_21_0 then
			self.viewComponent:doModAnim(var_21_1.oldBluePrint, var_21_1.newBluePrint)
			self.viewComponent:updateAllPursuingCostTip()
		elseif var_21_0 == BayProxy.SHIP_ADDED or BayProxy.SHIP_UPDATED == var_21_0 then
			self.viewComponent:setShipVOs(getProxy(BayProxy):getRawData())
		elseif GAME.BUILD_SHIP_BLUEPRINT_DONE == var_21_0 then
			self.viewComponent:buildStartAni("researchStartWindow")
		elseif var_21_0 == GAME.BEGIN_STAGE_DONE then
			self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_21_1)
		elseif var_21_0 == GAME.MOD_BLUEPRINT_ANIM_LOCK then
			self.viewComponent.noUpdateMod = true
		elseif var_21_0 == GAME.PURSUING_RESET_DONE then
			-- block empty
		elseif var_21_0 == GAME.QUICK_EXCHANGE_BLUEPRINT_DONE then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_21_1, function()
				self.viewComponent:updateShipBluePrintVO()

				return
			end)
		elseif var_21_0 == GAME.FINISH_PHANTOM_QUEST_DONE then
			self.viewComponent:updatePhantomQuest()
		end
	end

	return
end

return ShipBluePrintMediator
