class = var_0_10000

local var_0_0 = "PursuingBluePrintCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().count
	local var_1_1 = var_2.id

	if var_1_0 == 0 then
		return
	end

	getProxy = var_1_10005
	TechnologyProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	if not var_5.getBluePrintById(var_1_2, var_1_1) then
		return
	end

	local var_1_3 = var_6

	if not var_6.isUnlock(var_1_3) then
		return
	end

	getProxy = var_7
	PlayerProxy = var_1_3

	local var_1_4 = var_7(var_1_3)
	local var_1_5 = var_7.getRawData(var_1_4)
	local var_1_6 = var_7.getResource

	PlayerConst = var_1_10010

	if var_1_6(var_1_5, var_1_10010.ResGold) < var_5:calcPursuingCost(var_6, var_1_0) then
		return
	end

	if var_6:isMaxLevel() and var_6:isMaxFateLevel() then
		pg = var_9

		local var_1_7 = var_9.TipsMgr.GetInstance()
		local var_1_8 = var_9.ShowTips

		i18n = var_12

		var_1_8(var_1_7, var_12("blueprint_max_level_tip"))

		return
	end

	local var_1_9 = var_6
	local var_1_10 = var_1_0 * var_6.getItemExp(var_1_9)

	Clone = var_1_9

	local var_1_11 = var_1_9(var_6)

	var_11.addExp(var_1_11, var_1_10)

	local var_1_12 = var_11
	local var_1_13 = var_11.getStrengthenConfig

	math = var_15

	local var_1_14 = var_1_13(var_1_12, var_15.max(var_11.level, 1))

	getProxy = var_13
	BayProxy = var_15

	local var_1_15 = var_13(var_15)
	local var_1_17

	if var_13.getShipById(var_1_15, var_6.shipId).level < var_1_14.need_lv then
		pg = var_1_17

		local var_1_16 = var_1_17.TipsMgr.GetInstance()

		var_1_17 = var_1_17.ShowTips
		i18n = var_18

		var_1_17(var_1_16, var_18("buleprint_need_level_tip", var_1_14.need_lv))

		return
	end

	pg = var_1_17

	local var_1_18 = var_1_17.ConnectionMgr.GetInstance()

	var_15.Send(var_1_18, 63212, {
		ship_id = var_6.shipId,
		count = var_1_0
	}, 63213, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			PlayerProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			local var_2_0 = var_1.getData(var_2_10004)

			var_2.consume(var_2_0, {
				gold = var_0
			})
			var_1:updatePlayer(var_2)

			local var_2_1 = var_0
			local var_2_2 = var_3.addPursuingTimes
			local var_2_3 = var_1_0
			local var_2_4 = var_0

			var_2_2(var_2_1, var_2_3, var_7.isRarityUR(var_2_4))

			Clone = var_2_2

			local var_2_5 = var_2_2(var_0)
			local var_2_6 = var_0

			var_2_10004 = var_2_10004.getItemExp(var_2_6)

			local var_2_7 = var_0

			var_5.addExp(var_2_7, var_2_10004 * var_1_0)

			if var_0.level > var_2_5.level then
				for iter_2_0 = var_2_5.level + 1, var_0.level do
					var_2_10011 = var_0

					if var_9.getStrengthenConfig(var_2_10011, iter_2_0).special == 1 then
						type = var_10

						if var_10(var_9.special_effect) == "table" then
							local var_2_8 = var_9.special_effect

							ipairs = var_2_10011

							for iter_2_1, iter_2_2 in var_2_10011(var_2_8) do
								local var_2_9 = iter_2_2[1]

								ShipBluePrint = var_2_10017

								if var_2_9 == var_2_10017.STRENGTHEN_TYPE_SKILL then
									var_2_10017 = iter_2_2[2]
									getProxy = var_2_10018
									BayProxy = var_2_10020
									var_2_10021 = var_2_10018(var_2_10020)
									var_2_10019 = var_2_10018.getShipById(var_2_10021, var_0.shipId)
									ipairs = var_2_10020

									for iter_2_3, iter_2_4 in var_2_10020(var_2_10017) do
										local var_2_10 = var_2_10019.skills

										var_2_10[var_1_1] = {
											exp = 0,
											level = 1,
											id = iter_2_4
										}
										pg = var_2_10

										local var_2_11 = var_2_10.TipsMgr.GetInstance()

										var_25.ShowTips(var_2_11, iter_2_2[3])
									end

									var_2_10022 = var_2_10018

									var_2_10018.updateShip(var_2_10022, var_2_10019)
								else
									ShipBluePrint = var_2_10017

									if var_2_9 == var_2_10017.STRENGTHEN_TYPE_SKIN then
										getProxy = var_2_10017
										ShipSkinProxy = var_2_10019
										var_2_10020 = var_2_10017(var_2_10019)
										var_2_10018 = var_2_10017.addSkin
										ShipSkin = var_2_10021

										var_2_10018(var_2_10020, var_2_10021.New({
											id = iter_2_2[2]
										}))

										pg = var_2_10018
										var_2_10018 = var_2_10018.ship_skin_template[iter_2_2[2]].name
										pg = var_2_10019
										var_2_10021 = var_2_10019.TipsMgr.GetInstance()

										var_2_10019.ShowTips(var_2_10021, iter_2_2[3])
									else
										ShipBluePrint = var_2_10017

										if var_2_9 == var_2_10017.STRENGTHEN_TYPE_BREAKOUT then
											getProxy = var_2_10017
											BayProxy = var_2_10019
											var_2_10020 = var_2_10017(var_2_10019)
											var_2_10018 = var_2_10017.getShipById(var_2_10020, var_0.shipId)
											var_2_10021 = arg_1_0

											var_2_10019.upgradeStar(var_2_10021, var_2_10018)
										end
									end
								end
							end
						end
					end
				end
			elseif var_0.fateLevel > var_2_5.fateLevel then
				for iter_2_5 = var_2_5.fateLevel + 1, var_0.fateLevel do
					var_2_10011 = var_0

					if var_9.getFateStrengthenConfig(var_2_10011, iter_2_5).special == 1 then
						type = var_10

						if var_10(var_9.special_effect) == "table" then
							local var_2_12 = var_9.special_effect

							ipairs = var_2_10011

							for iter_2_6, iter_2_7 in var_2_10011(var_2_12) do
								local var_2_13 = iter_2_7[1]

								ShipBluePrint = var_2_10017

								if var_2_13 == var_2_10017.STRENGTHEN_TYPE_CHANGE_SKILL then
									getProxy = var_2_10017
									BayProxy = var_2_10019

									local var_2_14 = var_2_10017(var_2_10019)
									local var_2_15 = var_2_10017.getShipById(var_2_14, var_0.shipId)

									var_2_10019 = iter_2_7[2][1]

									local var_2_16 = iter_2_7[2][2]

									Clone = var_21

									local var_2_17 = var_21(var_2_15.skills[var_2_10019])

									assert = var_2_10022

									var_2_10022(var_2_17, "shipVO without this skill" .. var_2_10019)

									var_2_17.id = var_2_16
									var_2_10022 = var_2_15.skills
									var_2_10022[var_2_10019] = nil
									var_2_10022 = var_2_15.skills
									var_2_10022[var_2_16] = var_2_17
									pg = var_2_10022

									local var_2_18 = var_2_10022.TipsMgr.GetInstance()

									var_2_10022.ShowTips(var_2_18, iter_2_7[3])

									local var_2_19 = var_2_10017

									var_2_10017.updateShip(var_2_19, var_2_15)

									getProxy = var_2_10022
									NavalAcademyProxy = var_2_19

									local var_2_20 = var_2_10022(var_2_19)

									if var_2_10022.getStudentByShipId(var_2_20, var_2_15.id) and var_23.skillId == var_2_10019 then
										var_23.skillId = var_2_16

										var_2_10022:updateStudent(var_23)
									end
								end
							end
						end
					end
				end
			end

			local var_2_21 = var_0
			local var_2_22 = var_5.getShipById(var_2_21, var_0.shipId)

			var_2_22.strengthList = {}
			table = var_6

			local var_2_23 = var_6.insert
			local var_2_24 = var_2_22.strengthList
			local var_2_25 = {}
			local var_2_26 = var_0.level

			math = var_2_10011
			var_2_25.level = var_2_26 + var_2_10011.max(var_0.fateLevel, 0)
			var_2_25.exp = var_0.exp

			var_2_23(var_2_24, var_2_25)

			local var_2_27 = var_0

			var_6.updateShip(var_2_27, var_2_22)

			local var_2_28 = arg_1_0
			local var_2_29 = var_6.sendNotification

			GAME = var_9

			var_2_29(var_2_28, var_9.MOD_BLUEPRINT_ANIM_LOCK)

			local var_2_30 = var_0

			var_6.updateBluePrint(var_2_30, var_0)

			local var_2_31 = arg_1_0
			local var_2_32 = var_6.sendNotification

			GAME = var_9

			var_2_32(var_2_31, var_9.MOD_BLUEPRINT_DONE, {
				oldBluePrint = var_2_5,
				newBluePrint = var_0
			})

			pg = var_2_32

			local var_2_33 = var_2_32.TipsMgr.GetInstance()
			local var_2_34 = var_6.ShowTips

			i18n = var_9

			var_2_34(var_2_33, var_9("blueprint_mod_success"))
		else
			pg = var_1

			local var_2_35 = var_1.TipsMgr.GetInstance()
			local var_2_36 = var_1.ShowTips

			i18n = var_2_10004

			var_2_36(var_2_35, var_2_10004("blueprint_mod_erro") .. arg_2_0.result)
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
