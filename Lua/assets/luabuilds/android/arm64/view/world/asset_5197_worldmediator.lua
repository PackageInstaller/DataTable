local WorldMediator = class("WorldMediator", import("..base.ContextMediator"))

WorldMediator.OnMapOp = "WorldMediator.OnMapOp"
WorldMediator.OnMapReq = "WorldMediator.OnMapReq"
WorldMediator.OnOpenLayer = "WorldMediator.OnOpenLayer"
WorldMediator.OnOpenScene = "WorldMediator.OnOpenScene"
WorldMediator.OnChangeScene = "WorldMediator.OnChangeScene"
WorldMediator.OnOpenMarkMap = "WorldMediator.OnOpenMarkMap"
WorldMediator.OnTriggerTaskGo = "WorldMediator.OnTriggerTaskGo"
WorldMediator.OnAutoSubmitTask = "WorldMediator.OnAutoSubmitTask"
WorldMediator.OnNotificationOpenLayer = "WorldMediator.OnNotificationOpenLayer"
WorldMediator.OnStart = "WorldMediator.OnStart"
WorldMediator.OnStartPerform = "WorldMediator.OnStartPerform"
WorldMediator.OnStartAutoSwitch = "WorldMediator.OnStartAutoSwitch"
WorldMediator.OnMoveAndOpenLayer = "WorldMediator.OnMoveAndOpenLayer"

function WorldMediator:register()
	self:bind(WorldMediator.OnMapOp, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.WORLD_MAP_OP, arg_2_1)

		return
	end)
	self:bind(WorldMediator.OnMapReq, function(arg_3_0, arg_3_1, arg_3_2)
		assert(self.fetchCallback == nil)

		self.fetchCallback = arg_3_2

		self:sendNotification(GAME.WORLD_MAP_REQ, {
			mapId = arg_3_1
		})

		return
	end)
	self:bind(WorldMediator.OnOpenLayer, function(arg_4_0, arg_4_1, arg_4_2)
		self:addSubLayers(arg_4_1, false, arg_4_2)

		return
	end)
	self:bind(WorldMediator.OnOpenScene, function(arg_5_0, arg_5_1, ...)
		local var_5_0 = {}

		if self.viewComponent:GetInMap() then
			table.insert(var_5_0, function(arg_6_0)
				self.viewComponent:EaseOutMapUI(arg_6_0)

				return
			end)
		else
			table.insert(var_5_0, function(arg_7_0)
				self.viewComponent:EaseOutAtlasUI(arg_7_0)

				return
			end)
		end

		local var_5_1 = packEx(...)

		pg.UIMgr.GetInstance():LoadingOn()
		seriesAsync(var_5_0, function()
			pg.UIMgr.GetInstance():LoadingOff()
			self:sendNotification(GAME.GO_SCENE, arg_5_1, unpack(var_5_1, 1, var_5_1.len))

			return
		end)

		return
	end)
	self:bind(WorldMediator.OnChangeScene, function(arg_9_0, arg_9_1, ...)
		local var_9_0 = {}

		if self.viewComponent:GetInMap() then
			table.insert(var_9_0, function(arg_10_0)
				self.viewComponent:EaseOutMapUI(arg_10_0)

				return
			end)
		else
			table.insert(var_9_0, function(arg_11_0)
				self.viewComponent:EaseOutAtlasUI(arg_11_0)

				return
			end)
		end

		local var_9_1 = packEx(...)

		pg.UIMgr.GetInstance():LoadingOn()
		seriesAsync(var_9_0, function()
			pg.UIMgr.GetInstance():LoadingOff()
			self:sendNotification(GAME.CHANGE_SCENE, arg_9_1, unpack(var_9_1, 1, var_9_1.len))

			return
		end)

		return
	end)
	self:bind(WorldMediator.OnStart, function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		if arg_13_2.damageLevel > arg_13_3:GetLimitDamageLevel() then
			nowWorld():TriggerAutoFight(false)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideYes = true,
				content = i18n("world_low_morale")
			})
		else
			local var_13_0 = GAME.BEGIN_STAGE
			local var_13_1 = {
				system = SYSTEM_WORLD,
				stageId = arg_13_1
			}

			var_13_1.hpRate = arg_13_3:GetHP() and arg_13_3:GetHP() / arg_13_3:GetMaxHP() or nil

			self:sendNotification(var_13_0, var_13_1)
		end

		return
	end)
	self:bind(WorldMediator.OnStartPerform, function(arg_14_0, arg_14_1, arg_14_2)
		self:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_PERFORM,
			stageId = arg_14_1,
			exitCallback = arg_14_2
		})

		return
	end)
	self:bind(WorldMediator.OnAutoSubmitTask, function(arg_15_0, arg_15_1)
		self:sendNotification(GAME.WORLD_AUTO_SUMBMIT_TASK, {
			taskId = arg_15_1.id
		})

		return
	end)
	self.viewComponent:SetPlayer(getProxy(PlayerProxy):getRawData())

	return
end

function WorldMediator:listNotificationInterests()
	local var_16_0 = {
		PlayerProxy.UPDATED,
		GAME.WORLD_MAP_OP_DONE,
		GAME.BEGIN_STAGE_DONE,
		GAME.WORLD_STAMINA_EXCHANGE_DONE,
		WorldInventoryMediator.OnMap,
		WorldCollectionMediator.ON_MAP,
		WorldMediator.OnOpenMarkMap,
		GAME.WORLD_TRIGGER_TASK_DONE,
		GAME.WORLD_SUMBMIT_TASK_DONE,
		GAME.WORLD_AUTO_SUMBMIT_TASK_DONE,
		GAME.WORLD_ITEM_USE_DONE,
		GAME.WORLD_RETREAT_FLEET,
		WorldMediator.OnTriggerTaskGo,
		GAME.WORLD_MAP_REQ_DONE,
		WorldMediator.OnNotificationOpenLayer,
		GAME.WORLD_TRIGGER_AUTO_FIGHT,
		GAME.WORLD_TRIGGER_AUTO_SWITCH,
		WorldMediator.OnStartAutoSwitch,
		WorldMediator.OnMoveAndOpenLayer
	}

	_.each(WorldGuider.GetInstance():GetWorldGuiderNotifies(), function(arg_17_0)
		var_16_0[#var_16_0 + 1] = arg_17_0

		return
	end)

	return var_16_0
end

function WorldMediator:handleNotification(arg_18_1)
	local var_18_0 = arg_18_1:getName()
	local var_18_1 = arg_18_1:getBody()

	WorldGuider.GetInstance():WorldGuiderNotifyHandler(var_18_0, var_18_1, self.viewComponent)

	local var_18_2 = nowWorld()

	switch(var_18_0, {
		[GAME.WORLD_MAP_OP_DONE] = function()
			local var_19_0 = var_18_1.mapOp
			local var_19_1 = self.viewComponent:GetCommand(var_18_1.mapOp.depth)

			if var_18_1.result ~= 0 then
				var_19_1:OpDone()

				if var_18_1.result == 2 then
					var_18_2.staminaMgr:Show()
				end

				return
			end

			local var_19_2 = {}
			local var_19_3

			self.viewComponent:RegistMapOp(var_18_1.mapOp)

			if #var_18_1.mapOp.drops > 0 then
				if var_18_1.mapOp.op == WorldConst.OpReqCatSalvage then
					local var_19_4 = var_18_2:GetFleet(var_18_1.mapOp.id):GetSalvageScoreRarity()

					if var_18_2.isAutoFight then
						var_18_2:AddAutoInfo("salvage", {
							drops = var_18_1.mapOp.drops,
							rarity = var_19_4
						})
					else
						table.insert(var_19_2, function(arg_20_0)
							self.viewComponent:DisplayAwards(var_19_0.drops, {
								title = "commander",
								titleExtra = tostring(var_19_4)
							}, arg_20_0)

							return
						end)
					end
				elseif var_18_2.isAutoFight then
					var_18_2:AddAutoInfo("drops", var_18_1.mapOp.drops)
				else
					table.insert(var_19_2, function(arg_21_0)
						self.viewComponent:DisplayAwards(var_19_0.drops, {}, arg_21_0)

						return
					end)
				end
			end

			if var_18_1.mapOp.routine then
				function var_19_3()
					var_19_0:routine()

					return
				end
			else
				local var_19_5 = var_18_1.mapOp.op

				var_18_0 = WorldConst.ReqName[var_18_1.mapOp.op]

				assert(var_18_0, "invalid operation: " .. var_19_5)

				if var_19_5 == WorldConst.OpReqTask then
					-- block empty
				elseif var_19_5 == WorldConst.OpReqPressingMap or var_19_5 == WorldConst.OpReqCatSalvage then
					local var_19_6 = var_19_2

					var_19_2 = {}

					function var_19_3()
						var_19_1:OpDone(var_18_0 .. "Done", var_19_0, var_19_6)

						return
					end
				else
					function var_19_3()
						var_19_1:OpDone(var_18_0 .. "Done", var_19_0)

						return
					end
				end
			end

			seriesAsync(var_19_2, var_19_3)

			return
		end,
		[PlayerProxy.UPDATED] = function()
			self.viewComponent:SetPlayer(getProxy(PlayerProxy):getRawData())

			return
		end,
		[GAME.BEGIN_STAGE_DONE] = function()
			self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_18_1)

			return
		end,
		[GAME.WORLD_STAMINA_EXCHANGE_DONE] = function()
			if not self.viewComponent:GetInMap() then
				if self.viewComponent.svFloatPanel:isShowing() then
					self.viewComponent.svFloatPanel:UpdateCost()
				end
			end

			return
		end,
		[WorldInventoryMediator.OnMap] = function()
			self.viewComponent:Op("OpFocusTargetEntrance", var_18_1)

			return
		end,
		[WorldCollectionMediator.ON_MAP] = function()
			self.viewComponent:Op("OpFocusTargetEntrance", var_18_1)

			return
		end,
		[WorldMediator.OnOpenMarkMap] = function()
			self.viewComponent:Op("OpShowMarkOverview", var_18_1)

			return
		end,
		[GAME.WORLD_TRIGGER_TASK_DONE] = function()
			pg.WorldToastMgr.GetInstance():ShowToast(var_18_1.task, false)

			return
		end,
		[GAME.WORLD_SUMBMIT_TASK_DONE] = function()
			local var_32_0 = {}
			local var_32_1 = var_18_1.task

			if #var_18_1.task.config.task_ed > 0 then
				table.insert(var_32_0, function(arg_33_0)
					pg.NewStoryMgr.GetInstance():Play(var_32_1.config.task_ed, arg_33_0, true)

					return
				end)
			end

			if var_18_1.drops and #var_18_1.drops > 0 then
				if var_18_2.isAutoFight then
					var_18_2:AddAutoInfo("drops", var_18_1.drops)
				else
					table.insert(var_32_0, function(arg_34_0)
						self.viewComponent:DisplayAwards(var_18_1.drops, {}, arg_34_0)

						return
					end)
				end
			end

			for iter_32_0, iter_32_1 in ipairs(var_18_1.expfleets) do
				table.insert(var_32_0, function(arg_35_0)
					self.viewComponent:emit(BaseUI.ON_SHIP_EXP, {
						title = "without word",
						oldShips = iter_32_1.oldships,
						newShips = iter_32_1.newships
					}, arg_35_0)

					return
				end)
			end

			seriesAsync(var_32_0, function()
				pg.WorldToastMgr.GetInstance():ShowToast(var_32_1, true)

				return
			end)

			return
		end,
		[GAME.WORLD_AUTO_SUMBMIT_TASK_DONE] = function()
			local var_37_0 = {}
			local var_37_1 = var_18_1.task

			if #var_18_1.task.config.task_ed > 0 then
				table.insert(var_37_0, function(arg_38_0)
					pg.NewStoryMgr.GetInstance():Play(var_37_1.config.task_ed, arg_38_0, true)

					return
				end)
			end

			if var_18_1.drops and #var_18_1.drops > 0 then
				if var_18_2.isAutoFight then
					var_18_2:AddAutoInfo("drops", var_18_1.drops)
				else
					table.insert(var_37_0, function(arg_39_0)
						self.viewComponent:DisplayAwards(var_18_1.drops, {}, arg_39_0)

						return
					end)
				end
			end

			for iter_37_0, iter_37_1 in ipairs(var_18_1.expfleets) do
				table.insert(var_37_0, function(arg_40_0)
					self.viewComponent:emit(BaseUI.ON_SHIP_EXP, {
						title = "without word",
						oldShips = iter_37_1.oldships,
						newShips = iter_37_1.newships
					}, arg_40_0)

					return
				end)
			end

			seriesAsync(var_37_0, function()
				pg.WorldToastMgr.GetInstance():ShowToast(var_37_1, true)
				self.viewComponent:GetCommand():OpDone("OpAutoSubmitTaskDone", var_37_1)

				return
			end)

			return
		end,
		[GAME.WORLD_ITEM_USE_DONE] = function()
			local var_42_0 = var_18_1.item
			local var_42_1 = var_18_1.drops
			local var_42_2 = {}

			switch(var_18_1.item:getWorldItemType(), {
				[WorldItem.UsageWorldClean] = function()
					table.insert(var_42_2, function(arg_44_0)
						pg.NewStoryMgr.GetInstance():Play(pg.gameset.world_story_recycle_item.description[1], arg_44_0, true)

						return
					end)
					table.insert(var_42_2, function(arg_45_0)
						self.viewComponent:GetAllPessingAward(arg_45_0)

						return
					end)

					return
				end,
				[WorldItem.UsageWorldFlag] = function()
					table.insert(var_42_2, function(arg_47_0)
						pg.NewStoryMgr.GetInstance():Play(pg.gameset.world_story_treasure_item.description[1], arg_47_0, true)

						return
					end)

					return
				end,
				[WorldItem.UsageWorldBuff] = function()
					local var_48_0, var_48_1 = var_42_0:getItemWorldBuff()
					local var_48_2 = var_48_1 * var_42_0.count

					table.insert(var_42_2, function(arg_49_0)
						local var_49_0 = {
							id = var_48_0,
							floor = var_48_2
						}

						var_49_0.before = var_18_2:GetGlobalBuff(var_48_0):GetFloor()

						self.viewComponent:ShowSubView("GlobalBuff", {
							var_49_0,
							arg_49_0
						})

						return
					end)
					table.insert(var_42_2, function(arg_50_0)
						var_18_2:AddGlobalBuff(var_48_0, var_48_2)
						arg_50_0()

						return
					end)

					return
				end,
				[WorldItem.UsageWorldFlag] = function()
					switch(var_42_0:getItemFlagKey(), {
						function()
							table.insert(var_42_2, function(arg_53_0)
								local var_53_0 = var_18_2:GetActiveMap()

								if not var_53_0.visionFlag and var_18_2:IsMapVisioned(var_53_0.id) then
									var_53_0:UpdateVisionFlag(true)
								end

								arg_53_0()

								return
							end)

							return
						end
					})

					return
				end
			})

			if #var_18_1.drops > 0 then
				if var_18_2.isAutoFight then
					var_18_2:AddAutoInfo("drops", var_18_1.drops)
				else
					table.insert(var_42_2, function(arg_54_0)
						self.viewComponent:DisplayAwards(var_42_1, {}, arg_54_0)

						return
					end)
				end
			end

			seriesAsync(var_42_2, function()
				return
			end)

			return
		end,
		[GAME.WORLD_RETREAT_FLEET] = function()
			self.viewComponent:Op("OpReqRetreat", (var_18_2:GetFleet()))

			return
		end,
		[WorldMediator.OnTriggerTaskGo] = function()
			self.viewComponent:Op("OpTaskGoto", var_18_1.taskId)

			return
		end,
		[GAME.WORLD_MAP_REQ_DONE] = function()
			assert(self.fetchCallback)
			existCall(self.fetchCallback)

			self.fetchCallback = nil

			return
		end,
		[WorldMediator.OnNotificationOpenLayer] = function()
			self:addSubLayers(var_18_1.context)

			return
		end,
		[GAME.WORLD_TRIGGER_AUTO_FIGHT] = function()
			self.viewComponent:UpdateAutoFightDisplay()

			return
		end,
		[GAME.WORLD_TRIGGER_AUTO_SWITCH] = function()
			self.viewComponent:UpdateAutoSwitchDisplay()

			return
		end,
		[WorldMediator.OnStartAutoSwitch] = function()
			self.viewComponent:StartAutoSwitch()

			return
		end,
		[WorldMediator.OnMoveAndOpenLayer] = function()
			self.viewComponent:MoveAndOpenLayer(var_18_1)

			return
		end
	})

	return
end

return WorldMediator
