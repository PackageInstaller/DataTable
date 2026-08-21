local var_0_0 = class("CoreActivityMainMediator", import("view.activity.ActivityMediator"))

var_0_0.OPEN_CHUANWU = "CoreActivityMainMediator:Open chuanwu"

function var_0_0.getDisplayActivity(arg_1_0)
	return getProxy(ActivityProxy):getCorePanelActivities(arg_1_0.contextData.coreName)
end

function var_0_0.register(arg_2_0)
	var_0_0.super.register(arg_2_0)
	arg_2_0:bind(var_0_0.OPEN_CHUANWU, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		arg_2_0:OnSelShips(arg_3_1, arg_3_2, arg_3_3, arg_3_4)

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_4_0)
	var_0_0.super.initNotificationHandleDic(arg_4_0)

	arg_4_0.handleDic[ActivityProxy.ACTIVITY_SHOW_RED_PACKET_AWARDS] = function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_1:getBody()

		arg_5_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_0.awards, var_5_0.callback)

		return
	end
	arg_4_0.handleDic[GAME.ACT_NEW_PT_DONE] = function(arg_6_0, arg_6_1)
		if getProxy(ContextProxy):getContextByMediator(ActivityBossMediatorTemplate) then
			arg_6_0.viewComponent:updateTaskLayers()

			return
		end

		arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_6_1:getBody().awards, function()
			arg_6_0.viewComponent:updateTaskLayers()
			existCall(var_0.callback)

			return
		end)

		return
	end

	return
end

function var_0_0.tryColoringAchieve(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs((getProxy(ColoringProxy):getColorGroups())) do
		if iter_8_1:getState() == ColorGroup.StateFinish and iter_8_1:getHasAward() then
			arg_8_0:sendNotification(GAME.COLORING_ACHIEVE, {
				activityId = arg_8_0.viewComponent.activity.id,
				id = iter_8_1.id
			})

			break
		end
	end

	return
end

function var_0_0.OnSelShips(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = getProxy(ActivityProxy):getActivityById(arg_9_1)
	local var_9_1 = arg_9_0:GetSelectedShipIds(arg_9_1, arg_9_3)
	local var_9_2 = {
		callbackQuit = true,
		selectedMax = arg_9_4,
		quitTeam = arg_9_3 ~= nil
	}

	var_9_2.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
		isActivityNpc = true
	})
	var_9_2.selectedIds = Clone(var_9_1)
	var_9_2.preView = arg_9_0.viewComponent.__cname
	var_9_2.hideTagFlags = ShipStatus.TAG_HIDE_BACKYARD
	var_9_2.blockTagFlags = ShipStatus.TAG_BLOCK_BACKYARD

	function var_9_2.onShip(arg_10_0, arg_10_1, arg_10_2)
		return arg_9_0:OnShip(arg_10_0, arg_10_1, arg_10_2)
	end

	function var_9_2.onSelected(arg_11_0, arg_11_1)
		arg_9_0:OnSelected(arg_9_1, arg_9_2, arg_11_0, arg_11_1)

		return
	end

	var_9_2.priorEquipUpShipIDList = _.filter(var_9_0:GetShipIds(), function(arg_12_0)
		return arg_12_0 > 0
	end)
	var_9_2.leftTopWithFrameInfo = i18n("backyard_longpress_ship_tip")
	var_9_2.isLayer = true
	var_9_2.energyDisplay = true

	arg_9_0:addSubLayers(Context.New({
		viewComponent = DockyardScene,
		mediator = DockyardMediator,
		data = var_9_2
	}))

	return
end

function var_0_0.GetSelectedShipIds(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 then
		local var_13_0 = arg_13_2.id or -1
		local var_13_1 = getProxy(ActivityProxy):getActivityById(arg_13_1)
		local var_13_2 = {}

		for iter_13_0, iter_13_1 in ipairs(var_13_1:GetShipIds()) do
			local var_13_3 = iter_13_1 > 0 and getProxy(BayProxy):RawGetShipById(iter_13_1)

			if var_13_3 and var_13_3.id ~= var_13_0 then
				table.insert(var_13_2, var_13_3.id)
			end
		end

		return var_13_2
	end
end

function var_0_0.OnShip(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0, var_14_1 = ShipStatus.ShipStatusCheck("inBackyard", arg_14_1, function(arg_15_0)
		arg_14_2()

		return
	end)

	return var_14_0, var_14_1
end

function var_0_0.OnSelected(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = getProxy(ActivityProxy):getActivityById(arg_16_1)
	local var_16_1 = Clone(var_16_0:GetShipIds())

	_.each(_.range(var_16_0:GetSlotCount()), function(arg_17_0)
		var_16_1[arg_17_0] = var_16_1[arg_17_0] or 0

		return
	end)

	if arg_16_3 == nil or #arg_16_3 == 0 then
		if var_16_1[arg_16_2] > 0 then
			arg_16_0:sendNotification(GAME.ACTIVITY_OPERATION, {
				activity_id = var_16_0.id,
				cmd = Spring2Activity.OPERATION_SETSHIP,
				kvargs1 = {
					{
						value = 0,
						key = arg_16_2
					}
				}
			})
		end

		existCall(arg_16_4)

		return
	end

	local var_16_2 = _.filter(arg_16_3, function(arg_18_0)
		return not table.contains(var_16_1, arg_18_0)
	end)

	table.Foreach(var_16_1, function(arg_19_0, arg_19_1)
		if arg_19_1 == 0 or table.contains(arg_16_3, arg_19_1) then
			return
		end

		var_16_1[arg_19_0] = 0

		return
	end)

	if #var_16_2 == 1 and var_16_1[arg_16_2] == 0 then
		var_16_1[arg_16_2] = var_16_2[1]
	else
		local var_16_3 = 0

		_.each(var_16_2, function(arg_20_0)
			while var_16_3 <= #var_16_1 do
				var_16_3 = var_16_3 + 1

				if var_16_1[var_16_3] == 0 then
					break
				end
			end

			var_16_1[var_16_3] = arg_20_0

			return
		end)
	end

	local var_16_4 = {}
	local var_16_5 = var_16_0:GetShipIds()

	table.Foreach(var_16_1, function(arg_21_0, arg_21_1)
		local var_21_0 = var_16_5[arg_21_0] or 0

		if var_21_0 ~= arg_21_1 then
			table.insert(var_16_4, {
				key = arg_21_0,
				value = arg_21_1
			})
		end

		return
	end)

	if #var_16_4 > 0 then
		arg_16_0:sendNotification(GAME.ACTIVITY_OPERATION, {
			activity_id = var_16_0.id,
			cmd = Spring2Activity.OPERATION_SETSHIP,
			kvargs1 = var_16_4
		})
	end

	arg_16_4()

	return
end

return var_0_0
