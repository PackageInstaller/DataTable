class = var_0_10000

local var_0_0 = "BackYardShipCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BackYardBaseCard"))

function var_0_1.OnInit(arg_1_0)
	BackYardFormationCard = var_1_10001
	arg_1_0.info = var_1_10001.New(arg_1_0._go)
	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0._content

	local function var_1_2()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		NewBackYardShipInfoMediator = var_2_10003

		var_2_1(var_2_0, var_2_10003.OPEN_CHUANWU, arg_1_0.type, arg_1_0.ship)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_0, var_1_1, var_1_2, var_1_10006)

	GetOrAddComponent = var_1

	local var_1_3 = arg_1_0._content

	typeof = var_1_1
	UILongPressTrigger = var_1_10006
	arg_1_0.press = var_1(var_1_3, var_1_1(var_1_10006))

	local var_1_4 = arg_1_0.press.onLongPressed

	var_1.RemoveAllListeners(var_1_4)

	local var_1_5 = arg_1_0.press.onLongPressed

	var_1.AddListener(var_1_5, function()
		if not arg_1_0.ship then
			return
		end

		local var_3_0 = arg_1_0
		local var_3_1 = var_0.emit

		NewBackYardShipInfoMediator = var_2_10003

		var_3_1(var_3_0, var_2_10003.LOOG_PRESS_SHIP, arg_1_0.type, arg_1_0.ship)

		return
	end)

	return
end

function var_0_1.OnFlush(arg_4_0)
	local var_4_0 = arg_4_0.ship
	local var_4_1 = arg_4_0.info

	if not arg_4_0.targteShipId or arg_4_0.targteShipId ~= var_4_0.id then
		var_4_1:update(var_4_0)

		arg_4_0.targteShipId = var_4_0.id
	end

	local var_4_2 = var_4_0:getLevelExpConfig()
	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.CalcShipAddExpSpeed(var_4_3)
	local var_4_5 = {}

	getProxy = var_4_3
	ActivityProxy = var_1_10008

	local var_4_6 = var_4_3(var_1_10008)
	local var_4_7 = var_6.getActivitiesByType

	ActivityConst = var_1_10009

	local var_4_8 = var_4_7(var_4_6, var_1_10009.ACTIVITY_TYPE_HOTSPRING)

	table = var_1_10007

	var_1_10007.Foreach(var_4_8, function(arg_5_0, arg_5_1)
		if arg_5_1 and not arg_5_1:isEnd() then
			local var_5_0 = arg_5_1:getConfig("config_data")[1][4]

			_ = var_2_10003

			var_2_10003.each(arg_5_1:getData1List(), function(arg_6_0)
				local var_6_0 = var_4_5
				local var_6_1

				if not var_4_5[arg_6_0] then
					var_6_1 = 0
				end

				var_6_0[arg_6_0] = var_6_1 + var_5_0

				return
			end)
		end

		return
	end)

	getProxy = var_7
	ActivityProxy = var_9

	local var_4_9 = var_7(var_9)
	local var_4_10 = var_7.getActivitiesByType

	ActivityConst = var_10

	local var_4_11 = var_4_10(var_4_9, var_10.ACTIVITY_TYPE_HOTSPRING_2)

	table = var_4_6

	var_4_6.Foreach(var_4_11, function(arg_7_0, arg_7_1)
		if arg_7_1 and not arg_7_1:isEnd() then
			local var_7_0 = arg_7_1:getConfig("config_data")[1]

			_ = var_2_10003

			var_2_10003.each(arg_7_1:getData1List(), function(arg_8_0)
				local var_8_0 = var_4_5
				local var_8_1

				if not var_4_5[arg_8_0] then
					var_8_1 = 0
				end

				var_8_0[arg_8_0] = var_8_1 + var_7_0

				return
			end)
		end

		return
	end)

	local var_4_12 = 0
	local var_4_13 = 0

	ipairs = var_10
	BuffHelper = var_1_10012

	for iter_4_0, iter_4_1 in var_10(var_1_10012.GetBackYardEnergyBuffs()) do
		tonumber = var_1_10015
		var_4_13 = var_4_13 + var_1_10015(iter_4_1:getConfig("benefit_effect"))
	end

	local var_4_14 = arg_4_0.type

	DormShip = var_11

	if var_4_14 == var_11.FLOOR_1 then
		var_4_14 = var_4_0:getRecoverEnergyPoint()
		Ship = var_4_15
		var_4_14 = var_4_14 + var_4_15.BACKYARD_1F_ENERGY_ADDITION

		local var_4_15

		if not var_4_5[var_4_0.id] then
			var_4_15 = 0
		end

		local var_4_16 = var_4_14 + var_4_15
		local var_4_17 = var_4_1

		var_4_14 = var_4_1.updateProps

		local var_4_18 = {}

		iter_4_1 = {}
		i18n = var_1_10015
		iter_4_1[1] = var_1_10015("word_lv")
		iter_4_1[2] = var_4_0.level
		var_4_18[1] = iter_4_1
		iter_4_1 = {}
		i18n = var_1_10015
		iter_4_1[1] = var_1_10015("word_next_level")
		math = var_1_10015
		iter_4_1[2] = var_1_10015.max(var_4_2.exp - var_4_0.exp, 0)
		var_4_18[2] = iter_4_1
		iter_4_1 = {}
		i18n = var_1_10015
		var_1_10015 = var_1_10015("word_exp_chinese")
		i18n = var_1_10016
		iter_4_1[1] = var_1_10015 .. var_1_10016("word_get")
		iter_4_1[2] = var_4_4
		var_4_18[3] = iter_4_1
		iter_4_1 = {}
		i18n = var_1_10015
		iter_4_1[1] = var_1_10015("word_nowenergy")
		iter_4_1[2] = var_4_0.energy
		var_4_18[4] = iter_4_1
		iter_4_1 = {}
		i18n = var_1_10015
		iter_4_1[1] = var_1_10015("word_energy_recov_speed")
		var_1_10015 = 10 * var_4_16

		if 0 < var_4_13 then
			setColorStr = var_16

			local var_4_19 = "+" .. 10 * var_4_13

			COLOR_GREEN = var_19

			local var_4_20

			if not var_16(var_4_19, var_19) then
				var_4_20 = ""
			end

			iter_4_1[2] = var_1_10015 .. var_4_20 .. "/h"
			var_4_18[5] = iter_4_1

			var_4_14(var_4_17, var_4_18)

			goto label_4_0

			var_4_14 = arg_4_0.type
			DormShip = var_4_15

			if var_4_14 == var_4_15.FLOOR_2 then
				var_4_14 = var_4_0:getRecoverEnergyPoint()
				Ship = var_11
				var_4_14 = var_4_14 + var_11.BACKYARD_2F_ENERGY_ADDITION

				local var_4_21

				if not var_4_5[var_4_0.id] then
					var_4_21 = 0
				end

				local var_4_22 = var_4_14 + var_4_21
				local var_4_23 = var_4_1

				var_4_14 = var_4_1.updateProps1

				local var_4_24 = {}

				iter_4_1 = {}
				i18n = var_1_10015
				iter_4_1[1] = var_1_10015("word_lv")
				iter_4_1[2] = var_4_0.level
				var_4_24[1] = iter_4_1
				iter_4_1 = {}
				i18n = var_15
				iter_4_1[1] = var_15("word_nowenergy")
				iter_4_1[2] = var_4_0.energy
				var_4_24[2] = iter_4_1
				iter_4_1 = {}
				i18n = var_15
				iter_4_1[1] = var_15("word_energy_recov_speed")

				local var_4_25 = 10 * var_4_22

				if 0 < var_4_13 then
					setColorStr = var_16

					do
						local var_4_26 = "+" .. 10 * var_4_13

						COLOR_GREEN = var_19

						local var_4_27

						if not var_16(var_4_26, var_19) then
							var_4_27 = ""
						end

						iter_4_1[2] = var_4_25 .. var_4_27 .. "/h"
						var_4_24[3] = iter_4_1

						var_4_14(var_4_23, var_4_24)
					end

					::label_4_0::

					setActive = var_4_14

					local var_4_28 = var_4_1.propsTr
					local var_4_29 = arg_4_0.type

					DormShip = iter_4_1

					var_4_14(var_4_28, var_4_29 == iter_4_1.FLOOR_1)

					setActive = var_4_14

					local var_4_30 = var_4_1.propsTr1
					local var_4_31 = arg_4_0.type

					DormShip = var_14

					var_4_14(var_4_30, var_4_31 == var_14.FLOOR_2)

					return
				end
			end
		end
	end
end

function var_0_1.CalcShipAddExpSpeed(arg_9_0)
	local var_9_0 = 0

	getProxy = var_1_10002
	DormProxy = var_1_10004

	local var_9_1 = var_1_10002(var_1_10004)
	local var_9_2 = var_2.getRawData(var_9_1)
	local var_9_3 = arg_9_0:GetBaseExp(var_9_2)

	math = var_9_1

	local var_9_4 = var_9_1.floor
	local var_9_5 = var_9_3 * 16

	pg = var_1_10007

	return (var_9_4(var_9_5 / var_1_10007.dorm_data_template[var_9_2.id].time))
end

function var_0_1.GetBaseExp(arg_10_0, arg_10_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_10_0 = var_1_10002(var_1_10004)
	local var_10_1 = var_2.getRawData(var_10_0)
	local var_10_2 = arg_10_1
	local var_10_3 = arg_10_1.GetFloorShipCnt

	DormShip = var_1_10006

	if var_10_3(var_10_2, var_1_10006.FLOOR_1) <= 0 then
		return 0
	end

	pg = var_4

	local var_10_4 = var_4.dorm_data_template[arg_10_1.id]

	BuffHelper = var_5

	local var_10_5 = var_5.GetBackYardExpBuffs()
	local var_10_6 = 1

	pairs = var_1_10007

	for iter_10_0, iter_10_1 in var_1_10007(var_10_5) do
		if iter_10_1:isActivate() then
			local var_10_7 = iter_10_1:getConfig("benefit_effect")

			tonumber = var_1_10013
			var_10_6 = var_1_10013(var_10_7) / 100 + var_10_6
		end
	end

	pg = var_7

	local var_10_8 = var_7.gameset.dorm_exp_base.key_value

	pg = var_8

	local var_10_9 = var_8.gameset.dorm_exp_ratio_comfort_degree.key_value

	pg = var_9

	local var_10_10 = var_9.gameset["dorm_exp_ratio_by_" .. var_3].key_value / 100
	local var_10_11 = arg_10_1:getComfortable()

	return var_10_10 * (var_10_8 + var_10_4.exp * (var_10_11 / (var_10_11 + var_10_9))) * var_10_6 * (1 + 0.05 * var_10_1.level)
end

function var_0_1.OnDispose(arg_11_0)
	local var_11_0 = arg_11_0.press.onLongPressed

	var_1.RemoveAllListeners(var_11_0)

	local var_11_1 = arg_11_0.press.onLongPressed

	var_1.AddListener(var_11_1, nil)

	if arg_11_0.info then
		local var_11_2 = arg_11_0.info

		var_1.clear(var_11_2)
	end

	return
end

return var_0_1
