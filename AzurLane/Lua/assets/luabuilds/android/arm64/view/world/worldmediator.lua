local var_0_0 = class("WorldMediator", import("..base.ContextMediator"))

var_0_0.OnMapOp = "WorldMediator.OnMapOp"
var_0_0.OnMapReq = "WorldMediator.OnMapReq"
var_0_0.OnOpenLayer = "WorldMediator.OnOpenLayer"
var_0_0.OnOpenScene = "WorldMediator.OnOpenScene"
var_0_0.OnChangeScene = "WorldMediator.OnChangeScene"
var_0_0.OnOpenMarkMap = "WorldMediator.OnOpenMarkMap"
var_0_0.OnTriggerTaskGo = "WorldMediator.OnTriggerTaskGo"
var_0_0.OnAutoSubmitTask = "WorldMediator.OnAutoSubmitTask"
var_0_0.OnNotificationOpenLayer = "WorldMediator.OnNotificationOpenLayer"
var_0_0.OnStart = "WorldMediator.OnStart"
var_0_0.OnStartPerform = "WorldMediator.OnStartPerform"
var_0_0.OnStartAutoSwitch = "WorldMediator.OnStartAutoSwitch"
var_0_0.OnMoveAndOpenLayer = "WorldMediator.OnMoveAndOpenLayer"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OnMapOp, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.WORLD_MAP_OP, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.OnMapReq, function(arg_3_0, arg_3_1, arg_3_2)
		assert(arg_1_0.fetchCallback == nil)

		arg_1_0.fetchCallback = arg_3_2

		arg_1_0:sendNotification(GAME.WORLD_MAP_REQ, {
			mapId = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OnOpenLayer, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:addSubLayers(arg_4_1, false, arg_4_2)

		return
	end)
	arg_1_0:bind(var_0_0.OnOpenScene, function(arg_5_0, arg_5_1, ...)
		if arg_1_0.viewComponent:GetInMap() then
			table.insert({}, function(arg_6_0)
				arg_1_0.viewComponent:EaseOutMapUI(arg_6_0)

				return
			end)
		else
			table.insert({}, function(arg_7_0)
				arg_1_0.viewComponent:EaseOutAtlasUI(arg_7_0)

				return
			end)
		end

		local var_5_0 = packEx(...)

		pg.UIMgr.GetInstance():LoadingOn()
		seriesAsync({}, function()
			pg.UIMgr.GetInstance():LoadingOff()
			arg_1_0:sendNotification(GAME.GO_SCENE, arg_5_1, unpack(var_5_0, 1, var_5_0.len))

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.OnChangeScene, function(arg_9_0, arg_9_1, ...)
		if arg_1_0.viewComponent:GetInMap() then
			table.insert({}, function(arg_10_0)
				arg_1_0.viewComponent:EaseOutMapUI(arg_10_0)

				return
			end)
		else
			table.insert({}, function(arg_11_0)
				arg_1_0.viewComponent:EaseOutAtlasUI(arg_11_0)

				return
			end)
		end

		local var_9_0 = packEx(...)

		pg.UIMgr.GetInstance():LoadingOn()
		seriesAsync({}, function()
			pg.UIMgr.GetInstance():LoadingOff()
			arg_1_0:sendNotification(GAME.CHANGE_SCENE, arg_9_1, unpack(var_9_0, 1, var_9_0.len))

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.OnStart, function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		local var_13_0

		if arg_13_2.damageLevel > arg_13_3:GetLimitDamageLevel() then
			nowWorld():TriggerAutoFight(false)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideYes = true,
				content = i18n("world_low_morale")
			})

			goto label_13_0

			var_13_0 = arg_1_0
		end

		do
			local var_13_2 = GAME.BEGIN_STAGE
			local var_13_3 = {
				system = SYSTEM_WORLD,
				stageId = arg_13_1
			}

			var_13_3.hpRate = arg_13_3:GetHP() and arg_13_3:GetHP() / arg_13_3:GetMaxHP() or nil

			var_13_1(var_13_0, var_13_2, var_13_3)
		end

		::label_13_0::

		return
	end)
	arg_1_0:bind(var_0_0.OnStartPerform, function(arg_14_0, arg_14_1, arg_14_2)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_PERFORM,
			stageId = arg_14_1,
			exitCallback = arg_14_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.OnAutoSubmitTask, function(arg_15_0, arg_15_1)
		arg_1_0:sendNotification(GAME.WORLD_AUTO_SUMBMIT_TASK, {
			taskId = arg_15_1.id
		})

		return
	end)
	arg_1_0.viewComponent:SetPlayer(getProxy(PlayerProxy):getRawData())

	return
end

function var_0_0.listNotificationInterests(arg_16_0)
	local var_16_0 = {
		PlayerProxy.UPDATED,
		GAME.WORLD_MAP_OP_DONE,
		GAME.BEGIN_STAGE_DONE,
		GAME.WORLD_STAMINA_EXCHANGE_DONE,
		WorldInventoryMediator.OnMap,
		WorldCollectionMediator.ON_MAP,
		var_0_0.OnOpenMarkMap,
		GAME.WORLD_TRIGGER_TASK_DONE,
		GAME.WORLD_SUMBMIT_TASK_DONE,
		GAME.WORLD_AUTO_SUMBMIT_TASK_DONE,
		GAME.WORLD_ITEM_USE_DONE,
		GAME.WORLD_RETREAT_FLEET,
		var_0_0.OnTriggerTaskGo,
		GAME.WORLD_MAP_REQ_DONE,
		var_0_0.OnNotificationOpenLayer,
		GAME.WORLD_TRIGGER_AUTO_FIGHT,
		GAME.WORLD_TRIGGER_AUTO_SWITCH,
		var_0_0.OnStartAutoSwitch,
		var_0_0.OnMoveAndOpenLayer
	}

	_.each(WorldGuider.GetInstance():GetWorldGuiderNotifies(), function(arg_17_0)
		var_16_0[#var_16_0 + 1] = arg_17_0

		return
	end)

	return {
		PlayerProxy.UPDATED,
		GAME.WORLD_MAP_OP_DONE,
		GAME.BEGIN_STAGE_DONE,
		GAME.WORLD_STAMINA_EXCHANGE_DONE,
		WorldInventoryMediator.OnMap,
		WorldCollectionMediator.ON_MAP,
		var_0_0.OnOpenMarkMap,
		GAME.WORLD_TRIGGER_TASK_DONE,
		GAME.WORLD_SUMBMIT_TASK_DONE,
		GAME.WORLD_AUTO_SUMBMIT_TASK_DONE,
		GAME.WORLD_ITEM_USE_DONE,
		GAME.WORLD_RETREAT_FLEET,
		var_0_0.OnTriggerTaskGo,
		GAME.WORLD_MAP_REQ_DONE,
		var_0_0.OnNotificationOpenLayer,
		GAME.WORLD_TRIGGER_AUTO_FIGHT,
		GAME.WORLD_TRIGGER_AUTO_SWITCH,
		var_0_0.OnStartAutoSwitch,
		var_0_0.OnMoveAndOpenLayer
	}
end

function var_0_0.handleNotification(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:getName()

	WorldGuider.GetInstance():WorldGuiderNotifyHandler(var_18_0, arg_18_1:getBody(), arg_18_0.viewComponent)

	local var_18_1 = nowWorld()

	switch(var_18_0, {
		[GAME.WORLD_MAP_OP_DONE] = function()
			local var_19_0 = var_0.mapOp
			local var_19_1 = arg_18_0.viewComponent:GetCommand(var_0.mapOp.depth)

			if var_0.result ~= 0 then
				arg_18_0.viewComponent:GetCommand(var_0.mapOp.depth):OpDone()

				if var_0.result == 2 then
					var_18_1.staminaMgr:Show()
				end

				return
			end

			local var_19_2 = {}
			local var_19_3

			arg_18_0.viewComponent:RegistMapOp(var_0.mapOp)

			if #var_0.mapOp.drops > 0 then
				if var_0.mapOp.op == WorldConst.OpReqCatSalvage then
					local var_19_4 = var_18_1:GetFleet(var_0.mapOp.id):GetSalvageScoreRarity()

					if var_18_1.isAutoFight then
						var_18_1:AddAutoInfo("salvage", {
							drops = var_0.mapOp.drops,
							rarity = var_18_1:GetFleet(var_0.mapOp.id):GetSalvageScoreRarity()
						})
					else
						table.insert(var_19_2, function(arg_20_0)
							arg_18_0.viewComponent:DisplayAwards(var_19_0.drops, {
								title = "commander",
								titleExtra = tostring(var_19_4)
							}, arg_20_0)

							return
						end)
					end
				elseif var_18_1.isAutoFight then
					var_18_1:AddAutoInfo("drops", var_0.mapOp.drops)
				else
					table.insert(var_19_2, function(arg_21_0)
						arg_18_0.viewComponent:DisplayAwards(var_19_0.drops, {}, arg_21_0)

						return
					end)
				end
			end

			if var_0.mapOp.routine then
				function var_19_3()
					var_19_0:routine()

					return
				end
			else
				local var_19_5 = var_0.mapOp.op

				var_18_0 = WorldConst.ReqName[var_0.mapOp.op]

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
			arg_18_0.viewComponent:SetPlayer(getProxy(PlayerProxy):getRawData())

			return
		end,
		[GAME.BEGIN_STAGE_DONE] = function()
			arg_18_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_0)

			return
		end,
		[GAME.WORLD_STAMINA_EXCHANGE_DONE] = function()
			if not arg_18_0.viewComponent:GetInMap() then
				if arg_18_0.viewComponent.svFloatPanel:isShowing() then
					arg_18_0.viewComponent.svFloatPanel:UpdateCost()
				end
			end

			return
		end,
		[WorldInventoryMediator.OnMap] = function()
			arg_18_0.viewComponent:Op("OpFocusTargetEntrance", var_0)

			return
		end,
		[WorldCollectionMediator.ON_MAP] = function()
			arg_18_0.viewComponent:Op("OpFocusTargetEntrance", var_0)

			return
		end,
		[var_0_0.OnOpenMarkMap] = function()
			arg_18_0.viewComponent:Op("OpShowMarkOverview", var_0)

			return
		end,
		[GAME.WORLD_TRIGGER_TASK_DONE] = function()
			pg.WorldToastMgr.GetInstance():ShowToast(var_0.task, false)

			return
		end,
		[GAME.WORLD_SUMBMIT_TASK_DONE] = function()
			if #var_0.task.config.task_ed > 0 then
				table.insert({}, function(arg_33_0)
					pg.NewStoryMgr.GetInstance():Play(var_0.config.task_ed, arg_33_0, true)

					return
				end)
			end

			if var_0.drops and #var_0.drops > 0 then
				if var_18_1.isAutoFight then
					var_18_1:AddAutoInfo("drops", var_0.drops)
				else
					table.insert({}, function(arg_34_0)
						arg_18_0.viewComponent:DisplayAwards(var_0.drops, {}, arg_34_0)

						return
					end)
				end
			end

			for iter_32_0, iter_32_1 in ipairs(var_0.expfleets) do
				table.insert({}, function(arg_35_0)
					arg_18_0.viewComponent:emit(BaseUI.ON_SHIP_EXP, {
						title = "without word",
						oldShips = iter_32_1.oldships,
						newShips = iter_32_1.newships
					}, arg_35_0)

					return
				end)
			end

			seriesAsync({}, function()
				pg.WorldToastMgr.GetInstance():ShowToast(var_0, true)

				return
			end)

			return
		end,
		[GAME.WORLD_AUTO_SUMBMIT_TASK_DONE] = function()
			if #var_0.task.config.task_ed > 0 then
				table.insert({}, function(arg_38_0)
					pg.NewStoryMgr.GetInstance():Play(var_0.config.task_ed, arg_38_0, true)

					return
				end)
			end

			if var_0.drops and #var_0.drops > 0 then
				if var_18_1.isAutoFight then
					var_18_1:AddAutoInfo("drops", var_0.drops)
				else
					table.insert({}, function(arg_39_0)
						arg_18_0.viewComponent:DisplayAwards(var_0.drops, {}, arg_39_0)

						return
					end)
				end
			end

			for iter_37_0, iter_37_1 in ipairs(var_0.expfleets) do
				table.insert({}, function(arg_40_0)
					arg_18_0.viewComponent:emit(BaseUI.ON_SHIP_EXP, {
						title = "without word",
						oldShips = iter_37_1.oldships,
						newShips = iter_37_1.newships
					}, arg_40_0)

					return
				end)
			end

			seriesAsync({}, function()
				pg.WorldToastMgr.GetInstance():ShowToast(var_0, true)
				arg_18_0.viewComponent:GetCommand():OpDone("OpAutoSubmitTaskDone", var_0)

				return
			end)

			return
		end,
		[GAME.WORLD_ITEM_USE_DONE] = function()
			local var_42_0 = var_0.drops
			local var_42_1 = {}

			switch(var_0.item:getWorldItemType(), {
				[WorldItem.UsageWorldClean] = function()
					table.insert(var_42_1, function(arg_44_0)
						pg.NewStoryMgr.GetInstance():Play(pg.gameset.world_story_recycle_item.description[1], arg_44_0, true)

						return
					end)
					table.insert(var_42_1, function(arg_45_0)
						arg_18_0.viewComponent:GetAllPessingAward(arg_45_0)

						return
					end)

					return
				end,
				[WorldItem.UsageWorldFlag] = function()
					table.insert(var_42_1, function(arg_47_0)
						pg.NewStoryMgr.GetInstance():Play(pg.gameset.world_story_treasure_item.description[1], arg_47_0, true)

						return
					end)

					return
				end,
				[WorldItem.UsageWorldBuff] = function()
					local var_48_0, var_48_1 = var_0:getItemWorldBuff()
					local var_48_2 = var_48_1 * var_0.count

					table.insert(var_42_1, function(arg_49_0)
						({
							id = var_48_0,
							floor = var_48_2
						}).before = var_18_1:GetGlobalBuff(var_48_0):GetFloor()

						arg_18_0.viewComponent:ShowSubView("GlobalBuff", {
							{
								id = var_48_0,
								floor = var_48_2
							},
							arg_49_0
						})

						return
					end)
					table.insert(var_42_1, function(arg_50_0)
						var_18_1:AddGlobalBuff(var_48_0, var_48_2)
						arg_50_0()

						return
					end)

					return
				end,
				[WorldItem.UsageWorldFlag] = function()
					switch(var_0:getItemFlagKey(), {
						function()
							table.insert(var_42_1, function(arg_53_0)
								local var_53_0 = var_18_1:GetActiveMap()

								if not var_53_0.visionFlag and var_18_1:IsMapVisioned(var_53_0.id) then
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

			if #var_0.drops > 0 then
				if var_18_1.isAutoFight then
					var_18_1:AddAutoInfo("drops", var_0.drops)
				else
					table.insert({}, function(arg_54_0)
						arg_18_0.viewComponent:DisplayAwards(var_42_0, {}, arg_54_0)

						return
					end)
				end
			end

			seriesAsync({}, function()
				return
			end)

			return
		end,
		[GAME.WORLD_RETREAT_FLEET] = function()
			arg_18_0.viewComponent:Op("OpReqRetreat", (var_18_1:GetFleet()))

			return
		end,
		[var_0_0.OnTriggerTaskGo] = function()
			arg_18_0.viewComponent:Op("OpTaskGoto", var_0.taskId)

			return
		end,
		[GAME.WORLD_MAP_REQ_DONE] = function()
			assert(arg_18_0.fetchCallback)
			existCall(arg_18_0.fetchCallback)

			arg_18_0.fetchCallback = nil

			return
		end,
		[var_0_0.OnNotificationOpenLayer] = function()
			arg_18_0:addSubLayers(var_0.context)

			return
		end,
		[GAME.WORLD_TRIGGER_AUTO_FIGHT] = function()
			arg_18_0.viewComponent:UpdateAutoFightDisplay()

			return
		end,
		[GAME.WORLD_TRIGGER_AUTO_SWITCH] = function()
			arg_18_0.viewComponent:UpdateAutoSwitchDisplay()

			return
		end,
		[var_0_0.OnStartAutoSwitch] = function()
			arg_18_0.viewComponent:StartAutoSwitch()

			return
		end,
		[var_0_0.OnMoveAndOpenLayer] = function()
			arg_18_0.viewComponent:MoveAndOpenLayer(var_0)

			return
		end
	})

	return
end

return var_0_0
