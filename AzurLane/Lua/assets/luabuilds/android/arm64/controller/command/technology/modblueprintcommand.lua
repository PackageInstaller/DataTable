class = var_0_10000

local var_0_0 = "ModBluePrintCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().count
	local var_1_1 = var_2.id

	getProxy = var_1_10005
	TechnologyProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	if not var_5.getBluePrintById(var_1_2, var_1_1) then
		return
	end

	if not var_6:isUnlock() then
		return
	end

	local var_1_3 = var_6:getConfig("strengthen_item")

	getProxy = var_1_2
	BagProxy = var_10

	local var_1_4 = var_1_2(var_10)

	if var_1_0 > var_8.getItemCountById(var_1_4, var_1_3) then
		return
	end

	if var_1_0 == 0 then
		return
	end

	if var_6:isMaxLevel() and var_6:isMaxFateLevel() then
		pg = var_9

		local var_1_5 = var_9.TipsMgr.GetInstance()
		local var_1_6 = var_9.ShowTips

		i18n = var_1_10012

		var_1_6(var_1_5, var_1_10012("blueprint_max_level_tip"))

		return
	end

	local var_1_7 = var_6
	local var_1_8 = var_1_0 * var_6.getItemExp(var_1_7)

	Clone = var_1_7

	local var_1_9 = var_1_7(var_6)

	var_11.addExp(var_1_9, var_1_8)

	getProxy = var_12
	BayProxy = var_1_9

	local var_1_10 = var_12(var_1_9)
	local var_1_11 = var_12.getShipById(var_1_10, var_6.shipId)
	local var_1_13

	if not (var_11.fateLevel > 0) or not var_11:getFateStrengthenConfig(var_11.fateLevel) then
		local var_1_12 = var_11

		var_1_13 = var_11.getStrengthenConfig
		math = var_1_10017
		var_1_13 = var_1_13(var_1_12, var_1_10017.max(var_11.level, 1))
	end

	local var_1_15

	if var_1_11.level < var_1_13.need_lv then
		pg = var_1_15

		local var_1_14 = var_1_15.TipsMgr.GetInstance()

		var_1_15 = var_1_15.ShowTips
		i18n = var_1_10018

		var_1_15(var_1_14, var_1_10018("buleprint_need_level_tip", var_1_13.need_lv))

		return
	end

	pg = var_1_15

	local var_1_16 = var_1_15.ConnectionMgr.GetInstance()

	var_15.Send(var_1_16, 63204, {
		ship_id = var_6.shipId,
		count = var_1_0
	}, 63205, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = arg_1_0

			var_2_1 = var_2_1.sendNotification
			GAME = var_2_10004
			var_2_10004 = var_2_10004.CONSUME_ITEM
			Drop = var_2_10005

			local var_2_2 = var_2_10005.New
			local var_2_3 = {}

			DROP_TYPE_ITEM = var_2_10008
			var_2_3.type = var_2_10008
			var_2_3.count = var_1_0
			var_2_3.id = var_1_3

			var_2_1(var_2_0, var_2_10004, var_2_2(var_2_3))

			Clone = var_2_1
			var_2_1 = var_2_1(var_0)
			var_2_10004 = var_0

			local var_2_4 = var_2.getItemExp(var_2_10004)
			local var_2_5 = var_0

			var_3.addExp(var_2_5, var_2_4 * var_1_0)

			local var_2_6 = var_0.level

			if var_2_1.level < var_2_6 then
				for iter_2_0 = var_2_1.level + 1, var_0.level do
					var_2_10009 = var_0

					if var_7.getStrengthenConfig(var_2_10009, iter_2_0).special == 1 then
						type = var_8

						if var_8(var_7.special_effect) == "table" then
							local var_2_7 = var_7.special_effect

							ipairs = var_2_10009

							for iter_2_1, iter_2_2 in var_2_10009(var_2_7) do
								local var_2_8 = iter_2_2[1]

								ShipBluePrint = var_2_10015

								if var_2_8 == var_2_10015.STRENGTHEN_TYPE_SKILL then
									var_2_10015 = iter_2_2[2]
									getProxy = var_2_10016
									BayProxy = var_2_10018
									var_2_10019 = var_2_10016(var_2_10018)
									var_2_10017 = var_2_10016.getShipById(var_2_10019, var_0.shipId)
									ipairs = var_2_10018

									for iter_2_3, iter_2_4 in var_2_10018(var_2_10015) do
										local var_2_9 = var_2_10017.skills

										var_2_9[var_1_1] = {
											exp = 0,
											level = 1,
											id = iter_2_4
										}
										pg = var_2_9

										local var_2_10 = var_2_9.TipsMgr.GetInstance()

										var_23.ShowTips(var_2_10, iter_2_2[3])
									end

									var_2_10020 = var_2_10016

									var_2_10016.updateShip(var_2_10020, var_2_10017)
								else
									ShipBluePrint = var_2_10015

									if var_2_8 == var_2_10015.STRENGTHEN_TYPE_SKIN then
										getProxy = var_2_10015
										ShipSkinProxy = var_2_10017
										var_2_10018 = var_2_10015(var_2_10017)
										var_2_10016 = var_2_10015.addSkin
										ShipSkin = var_2_10019

										var_2_10016(var_2_10018, var_2_10019.New({
											id = iter_2_2[2]
										}))

										pg = var_2_10016
										var_2_10016 = var_2_10016.ship_skin_template[iter_2_2[2]].name
										pg = var_2_10017
										var_2_10019 = var_2_10017.TipsMgr.GetInstance()

										var_2_10017.ShowTips(var_2_10019, iter_2_2[3])
									else
										ShipBluePrint = var_2_10015

										if var_2_8 == var_2_10015.STRENGTHEN_TYPE_BREAKOUT then
											getProxy = var_2_10015
											BayProxy = var_2_10017
											var_2_10018 = var_2_10015(var_2_10017)
											var_2_10016 = var_2_10015.getShipById(var_2_10018, var_0.shipId)
											var_2_10019 = arg_1_0

											var_2_10017.upgradeStar(var_2_10019, var_2_10016)
										end
									end
								end
							end
						end
					end
				end
			else
				local var_2_11 = var_0.fateLevel

				if var_2_1.fateLevel < var_2_11 then
					for iter_2_5 = var_2_1.fateLevel + 1, var_0.fateLevel do
						var_2_10009 = var_0

						if var_7.getFateStrengthenConfig(var_2_10009, iter_2_5).special == 1 then
							type = var_8

							if var_8(var_7.special_effect) == "table" then
								local var_2_12 = var_7.special_effect

								ipairs = var_2_10009

								for iter_2_6, iter_2_7 in var_2_10009(var_2_12) do
									local var_2_13 = iter_2_7[1]

									ShipBluePrint = var_2_10015

									if var_2_13 == var_2_10015.STRENGTHEN_TYPE_CHANGE_SKILL then
										getProxy = var_2_10015
										BayProxy = var_2_10017

										local var_2_14 = var_2_10015(var_2_10017)
										local var_2_15 = var_2_10015.getShipById(var_2_14, var_0.shipId)

										var_2_10017 = iter_2_7[2][1]

										local var_2_16 = iter_2_7[2][2]

										Clone = var_19

										local var_2_17 = var_19(var_2_15.skills[var_2_10017])

										assert = var_2_10020

										var_2_10020(var_2_17, "shipVO without this skill" .. var_2_10017)

										var_2_17.id = var_2_16
										var_2_10020 = var_2_15.skills
										var_2_10020[var_2_10017] = nil
										var_2_10020 = var_2_15.skills
										var_2_10020[var_2_16] = var_2_17
										pg = var_2_10020

										local var_2_18 = var_2_10020.TipsMgr.GetInstance()

										var_2_10020.ShowTips(var_2_18, iter_2_7[3])

										local var_2_19 = var_2_10015

										var_2_10015.updateShip(var_2_19, var_2_15)

										getProxy = var_2_10020
										NavalAcademyProxy = var_2_19

										local var_2_20 = var_2_10020(var_2_19)

										if var_2_10020.getStudentByShipId(var_2_20, var_2_15.id) and var_21.skillId == var_2_10017 then
											var_21.skillId = var_2_16

											var_2_10020:updateStudent(var_21)
										end
									end
								end
							end
						end
					end
				end
			end

			local var_2_21 = var_0
			local var_2_22 = var_3.getShipById(var_2_21, var_0.shipId)

			var_2_22.strengthList = {}
			table = var_2_10004
			var_2_10004 = var_2_10004.insert

			local var_2_23 = var_2_22.strengthList
			local var_2_24 = {}
			local var_2_25 = var_0.level

			math = var_2_10009
			var_2_24.level = var_2_25 + var_2_10009.max(var_0.fateLevel, 0)
			var_2_24.exp = var_0.exp

			var_2_10004(var_2_23, var_2_24)

			local var_2_26 = var_0

			var_2_10004.updateShip(var_2_26, var_2_22)

			local var_2_27 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = var_7

			var_2_10004(var_2_27, var_7.MOD_BLUEPRINT_ANIM_LOCK)

			local var_2_28 = var_0

			var_2_10004.updateBluePrint(var_2_28, var_0)

			local var_2_29 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = var_7

			var_2_10004(var_2_29, var_7.MOD_BLUEPRINT_DONE, {
				oldBluePrint = var_2_1,
				newBluePrint = var_0
			})

			pg = var_2_10004

			local var_2_30 = var_2_10004.TipsMgr.GetInstance()

			var_2_10004 = var_2_10004.ShowTips
			i18n = var_7

			var_2_10004(var_2_30, var_7("blueprint_mod_success"))
		else
			pg = var_2_1

			local var_2_31 = var_2_1.TipsMgr.GetInstance()
			local var_2_32 = var_1.ShowTips

			i18n = var_2_10004

			var_2_32(var_2_31, var_2_10004("blueprint_mod_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

function var_0_1.upgradeStar(arg_3_0, arg_3_1)
	Clone = var_1_10002

	local var_3_0 = var_1_10002(arg_3_1)

	getProxy = var_1_10003
	CollectionProxy = var_1_10005

	local var_3_1 = var_1_10003(var_1_10005)
	local var_3_2 = var_3.getShipGroup(var_3_1, var_3_0.groupId)

	pg = var_1_10005

	if var_1_10005.ship_data_breakout[arg_3_1.configId].breakout_id ~= 0 then
		arg_3_1.configId = var_5.breakout_id
		pg = var_6

		local var_3_3 = var_6.ship_data_template[arg_3_1.configId]

		ipairs = var_7

		for iter_3_0, iter_3_1 in var_7(var_3_3.buff_list) do
			if not arg_3_1.skills[iter_3_1] then
				arg_3_1.skills[iter_3_1] = {
					exp = 0,
					level = 1,
					id = iter_3_1
				}
			end
		end

		arg_3_1:updateMaxLevel(var_3_3.max_level)

		pg = var_7

		local var_3_4 = var_7.ship_data_template[var_3_0.configId].buff_list

		ipairs = var_8

		for iter_3_2, iter_3_3 in var_8(var_3_4) do
			table = var_1_10013

			if not var_1_10013.contains(var_3_3.buff_list, iter_3_3) then
				var_1_10013 = arg_3_1.skills
				var_1_10013[iter_3_3] = nil
			end
		end

		getProxy = var_8
		BayProxy = var_10

		local var_3_5 = var_8(var_10)

		var_8.updateShip(var_3_5, arg_3_1)
	end

	return
end

return var_0_1
