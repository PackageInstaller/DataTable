local BackYardShipCard = class("BackYardShipCard", import(".BackYardBaseCard"))

function BackYardShipCard:OnInit()
	self.info = BackYardFormationCard.New(self._go)

	onButton(self, self._content, function()
		self:emit(NewBackYardShipInfoMediator.OPEN_CHUANWU, self.type, self.ship)

		return
	end, SFX_PANEL)

	self.press = GetOrAddComponent(self._content, typeof(UILongPressTrigger))

	self.press.onLongPressed:RemoveAllListeners()
	self.press.onLongPressed:AddListener(function()
		if not self.ship then
			return
		end

		self:emit(NewBackYardShipInfoMediator.LOOG_PRESS_SHIP, self.type, self.ship)

		return
	end)

	return
end

function BackYardShipCard:OnFlush()
	local var_4_0 = self.info

	if not self.targteShipId or self.targteShipId ~= self.ship.id then
		var_4_0:update(self.ship)

		self.targteShipId = self.ship.id
	end

	local var_4_1 = self.ship:getLevelExpConfig()
	local var_4_2 = {}

	table.Foreach(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING), function(arg_5_0, arg_5_1)
		if arg_5_1 and not arg_5_1:isEnd() then
			local var_5_0 = arg_5_1:getConfig("config_data")[1][4]

			_.each(arg_5_1:getData1List(), function(arg_6_0)
				var_4_2[arg_6_0] = (var_4_2[arg_6_0] or 0) + var_5_0

				return
			end)
		end

		return
	end)
	table.Foreach(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2), function(arg_7_0, arg_7_1)
		if arg_7_1 and not arg_7_1:isEnd() then
			local var_7_0 = arg_7_1:getConfig("config_data")[1]

			_.each(arg_7_1:getData1List(), function(arg_8_0)
				var_4_2[arg_8_0] = (var_4_2[arg_8_0] or 0) + var_7_0

				return
			end)
		end

		return
	end)

	local var_4_4 = 0

	for iter_4_0, iter_4_1 in ipairs(BuffHelper.GetBackYardEnergyBuffs()) do
		var_4_4 = var_4_4 + tonumber(iter_4_1:getConfig("benefit_effect"))
	end

	if self.type == DormShip.FLOOR_1 then
		local var_4_5 = self.ship:getRecoverEnergyPoint() + Ship.BACKYARD_1F_ENERGY_ADDITION
		local var_4_6 = var_4_2[self.ship.id]
		local var_4_8
		local var_4_9
		local var_4_7

		if not var_4_2[self.ship.id] then
			var_4_6 = 0
			var_4_7 = {
				{
					i18n("word_lv"),
					self.ship.level
				},
				{
					i18n("word_next_level"),
					math.max(var_4_1.exp - self.ship.exp, 0)
				},
				{
					i18n("word_exp_chinese") .. i18n("word_get"),
					(self:CalcShipAddExpSpeed())
				},
				{
					i18n("word_nowenergy"),
					self.ship.energy
				}
			}
			var_4_8 = {
				(i18n("word_energy_recov_speed"))
			}
			var_4_9 = var_4_4 > 0 and setColorStr("+" .. 10 * var_4_4, COLOR_GREEN) or ""
		end

		var_4_8[2] = 10 * (var_4_5 + var_4_6) .. var_4_9 .. "/h"
		var_4_7[5] = var_4_8

		var_4_0:updateProps(var_4_7)
	elseif self.type == DormShip.FLOOR_2 then
		local var_4_10 = self.ship:getRecoverEnergyPoint() + Ship.BACKYARD_2F_ENERGY_ADDITION
		local var_4_11 = var_4_2[self.ship.id]
		local var_4_13
		local var_4_14
		local var_4_12

		if not var_4_2[self.ship.id] then
			var_4_11 = 0
			var_4_12 = {
				{
					i18n("word_lv"),
					self.ship.level
				},
				{
					i18n("word_nowenergy"),
					self.ship.energy
				}
			}
			var_4_13 = {
				(i18n("word_energy_recov_speed"))
			}
			var_4_14 = var_4_4 > 0 and setColorStr("+" .. 10 * var_4_4, COLOR_GREEN) or ""
		end

		var_4_13[2] = 10 * (var_4_10 + var_4_11) .. var_4_14 .. "/h"
		var_4_12[3] = var_4_13

		var_4_0:updateProps1(var_4_12)
	end

	setActive(var_4_0.propsTr, self.type == DormShip.FLOOR_1)
	setActive(var_4_0.propsTr1, self.type == DormShip.FLOOR_2)

	return
end

function BackYardShipCard:CalcShipAddExpSpeed()
	local var_9_1 = getProxy(DormProxy):getRawData()

	return (math.floor(self:GetBaseExp(var_9_1) * 16 / pg.dorm_data_template[var_9_1.id].time))
end

function BackYardShipCard:GetBaseExp(arg_10_1)
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

function BackYardShipCard:OnDispose()
	self.press.onLongPressed:RemoveAllListeners()
	self.press.onLongPressed:AddListener(nil)

	if self.info then
		self.info:clear()
	end

	return
end

return BackYardShipCard
