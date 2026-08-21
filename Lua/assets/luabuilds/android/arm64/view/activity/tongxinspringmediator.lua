local var_0_0 = class("TongXinSpringMediator", import("..base.ContextMediator"))

var_0_0.UNLOCK_SLOT = "TongXinSpringMediator:UNLOCK_SLOT"
var_0_0.OPEN_CHUANWU = "TongXinSpringMediator:Open chuanwu"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.UNLOCK_SLOT, function(arg_2_0, arg_2_1)
		local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING)
		local var_2_1, var_2_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING):GetUpgradeCost()

		MsgboxMediator.ShowMsgBox({
			type = MSGBOX_TYPE_NORMAL,
			content = i18n("202406_wenquan_unlock", var_2_2),
			contextSprites = {
				{
					path = "props/wenquanbi",
					name = "wenquanbi"
				}
			},
			onYes = function()
				if var_2_0:GetCoins() < var_2_2 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("202406_wenquan_unlock_tip2"))

					return
				end

				arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, {
					activity_id = arg_2_1,
					cmd = SpringActivity.OPERATION_UNLOCK
				})

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHUANWU, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:OnSelShips(arg_4_1, arg_4_2)

		return
	end)
	arg_1_0.viewComponent:InitActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING)))

	return
end

function var_0_0.OnSelShips(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING)
	local var_5_1 = arg_5_0:GetSelectedShipIds(arg_5_2)
	local var_5_2 = {
		callbackQuit = true,
		selectedMax = var_5_0:GetSlotCount(),
		quitTeam = arg_5_2 ~= nil
	}

	var_5_2.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
		isActivityNpc = true
	})
	var_5_2.selectedIds = Clone(var_5_1)
	var_5_2.preView = arg_5_0.viewComponent.__cname
	var_5_2.hideTagFlags = ShipStatus.TAG_HIDE_BACKYARD
	var_5_2.blockTagFlags = ShipStatus.TAG_BLOCK_BACKYARD

	function var_5_2.onShip(arg_6_0, arg_6_1, arg_6_2)
		return arg_5_0:OnShip(arg_6_0, arg_6_1, arg_6_2)
	end

	function var_5_2.onSelected(arg_7_0, arg_7_1)
		arg_5_0:OnSelected(arg_5_1, arg_7_0, arg_7_1)

		return
	end

	var_5_2.priorEquipUpShipIDList = _.filter(var_5_0:GetShipIds(), function(arg_8_0)
		return arg_8_0 > 0
	end)
	var_5_2.leftTopWithFrameInfo = i18n("backyard_longpress_ship_tip")
	var_5_2.isLayer = true
	var_5_2.energyDisplay = true

	arg_5_0:addSubLayers(Context.New({
		viewComponent = DockyardScene,
		mediator = DockyardMediator,
		data = var_5_2
	}))

	return
end

function var_0_0.OnSelected(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING)
	local var_9_1 = Clone(var_9_0:GetShipIds())

	_.each(_.range(var_9_0:GetSlotCount()), function(arg_10_0)
		var_9_1[arg_10_0] = var_9_1[arg_10_0] or 0

		return
	end)

	if arg_9_2 == nil or #arg_9_2 == 0 then
		if var_9_1[arg_9_1] > 0 then
			arg_9_0:sendNotification(GAME.ACTIVITY_OPERATION, {
				activity_id = var_9_0.id,
				cmd = SpringActivity.OPERATION_SETSHIP,
				kvargs1 = {
					{
						value = 0,
						key = arg_9_1
					}
				}
			})
		end

		existCall(arg_9_3)

		return
	end

	local var_9_2 = _.filter(arg_9_2, function(arg_11_0)
		return not table.contains(var_9_1, arg_11_0)
	end)

	table.Foreach(var_9_1, function(arg_12_0, arg_12_1)
		if arg_12_1 == 0 or table.contains(arg_9_2, arg_12_1) then
			return
		end

		var_9_1[arg_12_0] = 0

		return
	end)

	if #var_9_2 == 1 and var_9_1[arg_9_1] == 0 then
		var_9_1[arg_9_1] = var_9_2[1]
	else
		local var_9_3 = 0

		_.each(var_9_2, function(arg_13_0)
			while var_9_3 <= #var_9_1 do
				var_9_3 = var_9_3 + 1

				if var_9_1[var_9_3] == 0 then
					break
				end
			end

			var_9_1[var_9_3] = arg_13_0

			return
		end)
	end

	local var_9_4 = {}
	local var_9_5 = var_9_0:GetShipIds()

	table.Foreach(var_9_1, function(arg_14_0, arg_14_1)
		local var_14_0 = var_9_5[arg_14_0] or 0

		if var_14_0 ~= arg_14_1 then
			table.insert(var_9_4, {
				key = arg_14_0,
				value = arg_14_1
			})
		end

		return
	end)

	if #var_9_4 > 0 then
		arg_9_0:sendNotification(GAME.ACTIVITY_OPERATION, {
			activity_id = var_9_0.id,
			cmd = SpringActivity.OPERATION_SETSHIP,
			kvargs1 = var_9_4
		})
	end

	arg_9_3()

	return
end

function var_0_0.GetSelectedShipIds(arg_15_0, arg_15_1)
	if arg_15_1 then
		local var_15_0 = arg_15_1.id or -1
		local var_15_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING)
		local var_15_2 = {}

		for iter_15_0, iter_15_1 in ipairs(var_15_1:GetShipIds()) do
			local var_15_3 = iter_15_1 > 0 and getProxy(BayProxy):RawGetShipById(iter_15_1)

			if var_15_3 and var_15_3.id ~= var_15_0 then
				table.insert(var_15_2, var_15_3.id)
			end
		end

		return var_15_2
	end
end

function var_0_0.OnShip(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0, var_16_1 = ShipStatus.ShipStatusCheck("inBackyard", arg_16_1, function(arg_17_0)
		arg_16_2()

		return
	end)

	return var_16_0, var_16_1
end

function var_0_0.listNotificationInterests(arg_18_0)
	return {
		ActivityProxy.ACTIVITY_OPERATION_DONE,
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityProxy.ACTIVITY_SHOW_AWARDS,
		var_0_0.OPEN_CHUANWU,
		var_0_0.UNLOCK_SLOT
	}
end

function var_0_0.handleNotification(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1:getName()
	local var_19_1 = arg_19_1:getBody()

	if var_19_0 == nil then
		-- block empty
	elseif var_19_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		arg_19_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_19_1.awards, var_19_1.callback)
	elseif var_19_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_19_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_HOTSPRING then
			arg_19_0.viewComponent:UpdateActivity(var_19_1)
		end
	elseif var_19_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		local var_19_2 = getProxy(ActivityProxy):getActivityById(var_19_1)

		if var_19_2:getConfig("type") == ActivityConst.ACTIVITY_TYPE_HOTSPRING then
			arg_19_0.viewComponent:UpdateActivity(var_19_2)
		end
	elseif var_19_0 == var_0_0.OPEN_CHUANWU then
		arg_19_0.viewComponent:emit(var_0_0.OPEN_CHUANWU, unpack(var_19_1))
	elseif var_19_0 == var_0_0.UNLOCK_SLOT then
		arg_19_0.viewComponent:emit(var_0_0.UNLOCK_SLOT, var_19_1)
	end

	return
end

return var_0_0
