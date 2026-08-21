local var_0_0 = class("BuildShip", import(".BaseVO"))

var_0_0.INACTIVE = 1
var_0_0.ACTIVE = 2
var_0_0.FINISH = 3

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.type = arg_1_1.build_id
	arg_1_0.time = arg_1_1.time
	arg_1_0.finishTime = arg_1_1.finish_time
	arg_1_0.state = arg_1_0.INACTIVE

	return
end

function var_0_0.setId(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1

	return
end

function var_0_0.setState(arg_3_0, arg_3_1)
	arg_3_0.state = arg_3_1

	return
end

function var_0_0.isFinish(arg_4_0)
	local var_4_0 = pg.TimeMgr.GetInstance()

	return var_4_0:GetServerTime() >= arg_4_0.finishTime
end

function var_0_0.finish(arg_5_0)
	arg_5_0.time = 0
	arg_5_0.finishTime = pg.TimeMgr.GetInstance():GetServerTime()
	arg_5_0.state = arg_5_0.FINISH

	return
end

function var_0_0.active(arg_6_0)
	arg_6_0.finishTime = pg.TimeMgr.GetInstance():GetServerTime() + arg_6_0.time
	arg_6_0.state = arg_6_0.ACTIVE

	return
end

function var_0_0.setIsStart(arg_7_0, arg_7_1)
	arg_7_0.isStart = arg_7_1

	return
end

function var_0_0.getLeftTime(arg_8_0)
	return arg_8_0.finishTime - pg.TimeMgr.GetInstance():GetServerTime()
end

function var_0_0.getBuildConsume(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0

	if arg_9_1 == 1 then
		arg_9_2 = math.min(arg_9_2 + 1, #pg.draw_data_template[arg_9_0].use_gem_1)
		var_9_0 = pg.draw_data_template[arg_9_0].use_gem_1[arg_9_2]
	else
		arg_9_2 = math.min(arg_9_2 + 1, #pg.draw_data_template[arg_9_0].use_gem_10)
		var_9_0 = pg.draw_data_template[arg_9_0].use_gem_10[arg_9_2]
	end

	return var_9_0
end

function var_0_0.canBuildShipByBuildId(arg_10_0, arg_10_1, arg_10_2)
	local var_10_9000

	arg_10_1 = arg_10_1 or 1

	local var_10_0 = pg.ship_data_create_material[arg_10_0]

	if not pg.ship_data_create_material[arg_10_0] then
		local var_10_2 = i18n("ship_buildShip_error_noTemplate", arg_10_0)

		return
	end

	local var_10_3 = getProxy(BuildShipProxy)

	if table.getCount((var_10_3:getData())) + arg_10_1 > MAX_BUILD_WORK_COUNT then
		local var_10_5 = i18n("ship_buildShip_not_position")

		return
	end

	if arg_10_2 then
		local var_10_6 = getProxy(ActivityProxy)
		local var_10_7 = var_10_6.getBuildFreeActivityByBuildId(var_10_9000, arg_10_0)
		local var_10_8 = Drop.New({
			type = DROP_TYPE_VITEM,
			id = var_10_7:getConfig("config_client")[1]
		}).getName(var_10_6)

		if not var_10_7 or var_10_7:isEnd() then
			local var_10_10 = i18n("tip_build_ticket_expired", var_10_8)

			return
		elseif arg_10_1 > var_10_7.data1 then
			local var_10_12 = i18n("tip_build_ticket_not_enough", var_10_8)

			return
		end
	else
		local var_10_13 = {}
		local var_10_14 = getProxy(PlayerProxy):getData()

		if var_10_14.gold < var_10_0.use_gold * arg_10_1 then
			table.insert(var_10_13, {
				59001,
				var_10_0.use_gold * arg_10_1 - var_10_14.gold,
				var_10_0.use_gold * arg_10_1
			})
		end

		local var_10_15 = getProxy(BagProxy):getData()

		if not var_10_15[var_10_0.use_item] or var_10_15[var_10_0.use_item].count < var_10_0.number_1 * arg_10_1 then
			local var_10_16 = var_10_0.number_1 * arg_10_1

			if var_10_15[var_10_0.use_item] then
				var_10_16 = var_10_0.number_1 * arg_10_1 - var_10_15[var_10_0.use_item].count
			end

			table.insert(var_10_13, {
				var_10_0.use_item,
				var_10_16,
				var_10_0.number_1 * arg_10_1
			})
		end

		if #var_10_13 > 0 then
			return false, i18n("ship_buildShip_error_notEnoughItem"), var_10_13
		end
	end

	return true
end

function var_0_0.canQuickBuildShip(arg_11_0)
	local var_11_0 = getProxy(BuildShipProxy):getBuildShip(arg_11_0)

	if not var_11_0 then
		local var_11_2 = i18n("ship_buildShipImmediately_error_noSHip")

		return
	end

	if var_11_0:isFinish() then
		local var_11_4 = i18n("ship_buildShipImmediately_error_finished")

		return
	end

	local var_11_5 = getProxy(BagProxy)
	local var_11_6 = var_11_5:getItemById(ITEM_ID_EQUIP_QUICK_FINISH) or {
		count = 0
	}

	if var_11_6.count <= 0 then
		return false, i18n("ship_buildShip_error_notEnoughItem"), {
			{
				ITEM_ID_EQUIP_QUICK_FINISH,
				1 - var_11_6.count,
				1
			}
		}
	end

	return true
end

function var_0_0.getPageFromPoolType(arg_12_0)
	for iter_12_0, iter_12_1 in pairs({
		[BuildShipScene.PAGE_BUILD] = {
			1,
			2,
			3,
			4,
			5
		},
		[BuildShipScene.PAGE_PRAY] = {
			6,
			7,
			8
		},
		[BuildShipScene.PAGE_NEWSERVER] = {
			11
		}
	}) do
		if table.contains(iter_12_1, arg_12_0) then
			return iter_12_0
		end
	end

	return
end

return var_0_0
