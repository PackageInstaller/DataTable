local var_0_0 = class("BackYardShipCard", import(".BackYardBaseCard"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.info = BackYardFormationCard.New(arg_1_0._go)

	onButton(arg_1_0, arg_1_0._content, function()
		arg_1_0:emit(NewBackYardShipInfoMediator.OPEN_CHUANWU, arg_1_0.type, arg_1_0.ship)

		return
	end, SFX_PANEL)

	arg_1_0.press = GetOrAddComponent(arg_1_0._content, typeof(UILongPressTrigger))

	arg_1_0.press.onLongPressed:RemoveAllListeners()
	arg_1_0.press.onLongPressed:AddListener(function()
		if not arg_1_0.ship then
			return
		end

		arg_1_0:emit(NewBackYardShipInfoMediator.LOOG_PRESS_SHIP, arg_1_0.type, arg_1_0.ship)

		return
	end)

	return
end

function var_0_0.OnFlush(arg_4_0)
	local var_4_0 = arg_4_0.info

	if not arg_4_0.targteShipId or arg_4_0.targteShipId ~= arg_4_0.ship.id then
		var_4_0:update(arg_4_0.ship)

		arg_4_0.targteShipId = arg_4_0.ship.id
	end

	local var_4_1 = arg_4_0.ship:getLevelExpConfig()
	local var_4_2 = {}

	table.Foreach(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING), function(arg_5_0, arg_5_1)
		if arg_5_1 and not arg_5_1:isEnd() then
			local var_5_0 = arg_5_1:getConfig("config_data")[1][4]

			_.each(arg_5_1:getData1List(), function(arg_6_0)
				local var_6_0 = var_4_2[arg_6_0] or 0

				var_4_2[arg_6_0] = var_6_0 + var_5_0

				return
			end)
		end

		return
	end)
	table.Foreach(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2), function(arg_7_0, arg_7_1)
		if arg_7_1 and not arg_7_1:isEnd() then
			local var_7_0 = arg_7_1:getConfig("config_data")[1]

			_.each(arg_7_1:getData1List(), function(arg_8_0)
				local var_8_0 = var_4_2[arg_8_0] or 0

				var_4_2[arg_8_0] = var_8_0 + var_7_0

				return
			end)
		end

		return
	end)

	local var_4_4 = 0

	for iter_4_0, iter_4_1 in ipairs(BuffHelper.GetBackYardEnergyBuffs()) do
		var_4_4 = var_4_4 + tonumber(iter_4_1:getConfig("benefit_effect"))
	end

	if arg_4_0.type == DormShip.FLOOR_1 then
		local var_4_5 = arg_4_0.ship:getRecoverEnergyPoint() + Ship.BACKYARD_1F_ENERGY_ADDITION
		local var_4_6 = ({})[arg_4_0.ship.id]
		local var_4_7, var_4_8, var_4_9, var_4_10, var_4_11

		if not ({})[arg_4_0.ship.id] then
			var_4_6 = 0
			var_4_7 = var_4_0
			var_4_8 = var_4_0.updateProps
			var_4_9 = {
				{
					i18n("word_lv"),
					arg_4_0.ship.level
				},
				{
					i18n("word_next_level"),
					math.max(var_4_1.exp - arg_4_0.ship.exp, 0)
				},
				{
					i18n("word_exp_chinese") .. i18n("word_get"),
					(arg_4_0:CalcShipAddExpSpeed())
				},
				{
					i18n("word_nowenergy"),
					arg_4_0.ship.energy
				}
			}
			var_4_10 = {
				(i18n("word_energy_recov_speed"))
			}
			var_4_11 = var_4_4 > 0 and setColorStr("+" .. 10 * var_4_4, COLOR_GREEN) or ""
		end

		var_4_10[2] = 10 * (var_4_5 + var_4_6) .. var_4_11 .. "/h"
		var_4_9[5] = var_4_10

		var_4_8(var_4_7, var_4_9)
	elseif arg_4_0.type == DormShip.FLOOR_2 then
		local var_4_12 = arg_4_0.ship:getRecoverEnergyPoint() + Ship.BACKYARD_2F_ENERGY_ADDITION
		local var_4_13 = ({})[arg_4_0.ship.id]
		local var_4_14, var_4_15, var_4_16, var_4_17, var_4_18

		if not ({})[arg_4_0.ship.id] then
			var_4_13 = 0
			var_4_14 = var_4_0
			var_4_15 = var_4_0.updateProps1
			var_4_16 = {
				{
					i18n("word_lv"),
					arg_4_0.ship.level
				},
				{
					i18n("word_nowenergy"),
					arg_4_0.ship.energy
				}
			}
			var_4_17 = {
				(i18n("word_energy_recov_speed"))
			}
			var_4_18 = var_4_4 > 0 and setColorStr("+" .. 10 * var_4_4, COLOR_GREEN) or ""
		end

		var_4_17[2] = 10 * (var_4_12 + var_4_13) .. var_4_18 .. "/h"
		var_4_16[3] = var_4_17

		var_4_15(var_4_14, var_4_16)
	end

	setActive(var_4_0.propsTr, arg_4_0.type == DormShip.FLOOR_1)
	setActive(var_4_0.propsTr1, arg_4_0.type == DormShip.FLOOR_2)

	return
end

function var_0_0.CalcShipAddExpSpeed(arg_9_0)
	local var_9_1 = getProxy(DormProxy):getRawData()

	return (math.floor(arg_9_0:GetBaseExp(var_9_1) * 16 / pg.dorm_data_template[var_9_1.id].time))
end

function var_0_0.GetBaseExp(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:GetFloorShipCnt(DormShip.FLOOR_1)

	if var_10_0 <= 0 then
		return 0
	end

	local var_10_1 = pg.dorm_data_template[arg_10_1.id]
	local var_10_2 = 1

	for iter_10_0, iter_10_1 in pairs((BuffHelper.GetBackYardExpBuffs())) do
		if iter_10_1:isActivate() then
			var_10_2 = tonumber((iter_10_1:getConfig("benefit_effect"))) / 100 + var_10_2
		end
	end

	local var_10_3 = arg_10_1:getComfortable()

	return pg.gameset["dorm_exp_ratio_by_" .. var_10_0].key_value / 100 * (pg.gameset.dorm_exp_base.key_value + var_10_1.exp * (var_10_3 / (var_10_3 + pg.gameset.dorm_exp_ratio_comfort_degree.key_value))) * var_10_2 * (1 + 0.05 * getProxy(PlayerProxy):getRawData().level)
end

function var_0_0.OnDispose(arg_11_0)
	arg_11_0.press.onLongPressed:RemoveAllListeners()
	arg_11_0.press.onLongPressed:AddListener(nil)

	if arg_11_0.info then
		arg_11_0.info:clear()
	end

	return
end

return var_0_0
