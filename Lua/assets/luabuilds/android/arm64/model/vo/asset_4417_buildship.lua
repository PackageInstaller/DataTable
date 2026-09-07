local BuildShip = class("BuildShip", import(".BaseVO"))

BuildShip.INACTIVE = 1
BuildShip.ACTIVE = 2
BuildShip.FINISH = 3

function BuildShip:Ctor(arg_1_1)
	self.type = arg_1_1.build_id
	self.time = arg_1_1.time
	self.finishTime = arg_1_1.finish_time
	self.state = self.INACTIVE

	return
end

function BuildShip:setId(arg_2_1)
	self.id = arg_2_1

	return
end

function BuildShip:setState(arg_3_1)
	self.state = arg_3_1

	return
end

function BuildShip:isFinish()
	return pg.TimeMgr.GetInstance():GetServerTime() >= self.finishTime
end

function BuildShip:finish()
	self.time = 0
	self.finishTime = pg.TimeMgr.GetInstance():GetServerTime()
	self.state = self.FINISH

	return
end

function BuildShip:active()
	self.finishTime = pg.TimeMgr.GetInstance():GetServerTime() + self.time
	self.state = self.ACTIVE

	return
end

function BuildShip:setIsStart(arg_7_1)
	self.isStart = arg_7_1

	return
end

function BuildShip:getLeftTime()
	return self.finishTime - pg.TimeMgr.GetInstance():GetServerTime()
end

function BuildShip:getBuildConsume(arg_9_1, arg_9_2)
	local var_9_0

	if arg_9_1 == 1 then
		arg_9_2 = math.min(arg_9_2 + 1, #pg.draw_data_template[self].use_gem_1)
		var_9_0 = pg.draw_data_template[self].use_gem_1[arg_9_2]
	else
		arg_9_2 = math.min(arg_9_2 + 1, #pg.draw_data_template[self].use_gem_10)
		var_9_0 = pg.draw_data_template[self].use_gem_10[arg_9_2]
	end

	return var_9_0
end

function BuildShip:canBuildShipByBuildId(arg_10_1, arg_10_2)
	arg_10_1 = arg_10_1 or 1

	local var_10_0 = pg.ship_data_create_material[self]

	if not pg.ship_data_create_material[self] then
		local var_10_2 = i18n("ship_buildShip_error_noTemplate", self)

		return
	end

	if table.getCount((getProxy(BuildShipProxy):getData())) + arg_10_1 > MAX_BUILD_WORK_COUNT then
		local var_10_4 = i18n("ship_buildShip_not_position")

		return
	end

	if arg_10_2 then
		local var_10_5 = getProxy(ActivityProxy)
		local var_10_6 = var_10_5:getBuildFreeActivityByBuildId(self)
		local var_10_7 = Drop.New({
			type = DROP_TYPE_VITEM,
			id = var_10_6:getConfig("config_client")[1]
		}).getName(var_10_5)

		if not var_10_6 or var_10_6:isEnd() then
			local var_10_9 = i18n("tip_build_ticket_expired", var_10_7)

			return
		elseif arg_10_1 > var_10_6.data1 then
			local var_10_11 = i18n("tip_build_ticket_not_enough", var_10_7)

			return
		end
	else
		local var_10_12 = {}
		local var_10_13 = getProxy(PlayerProxy):getData()

		if var_10_13.gold < var_10_0.use_gold * arg_10_1 then
			table.insert(var_10_12, {
				59001,
				var_10_0.use_gold * arg_10_1 - var_10_13.gold,
				var_10_0.use_gold * arg_10_1
			})
		end

		local var_10_14 = getProxy(BagProxy):getData()

		if not var_10_14[var_10_0.use_item] or var_10_14[var_10_0.use_item].count < var_10_0.number_1 * arg_10_1 then
			table.insert(var_10_12, {
				var_10_0.use_item,
				(var_10_14[var_10_0.use_item] or nil) and var_10_0.number_1 * arg_10_1 - var_10_14[var_10_0.use_item].count,
				var_10_0.number_1 * arg_10_1
			})
		end

		if #var_10_12 > 0 then
			return false, i18n("ship_buildShip_error_notEnoughItem"), var_10_12
		end
	end

	return true
end

function BuildShip:canQuickBuildShip()
	local var_11_0 = getProxy(BuildShipProxy):getBuildShip(self)

	if not var_11_0 then
		local var_11_2 = i18n("ship_buildShipImmediately_error_noSHip")

		return
	end

	if var_11_0:isFinish() then
		local var_11_4 = i18n("ship_buildShipImmediately_error_finished")

		return
	end

	local var_11_5 = getProxy(BagProxy):getItemById(ITEM_ID_EQUIP_QUICK_FINISH) or {
		count = 0
	}

	if var_11_5.count <= 0 then
		return false, i18n("ship_buildShip_error_notEnoughItem"), {
			{
				ITEM_ID_EQUIP_QUICK_FINISH,
				1 - var_11_5.count,
				1
			}
		}
	end

	return true
end

function BuildShip:getPageFromPoolType()
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
		if table.contains(iter_12_1, self) then
			return iter_12_0
		end
	end

	return
end

return BuildShip
