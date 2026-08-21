local var_0_0 = class("ModBluePrintCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.count
	local var_1_2 = getProxy(TechnologyProxy)
	local var_1_3 = getProxy(TechnologyProxy):getBluePrintById(var_1_0.id)

	if not var_1_3 then
		return
	end

	if not var_1_3:isUnlock() then
		return
	end

	if var_1_1 > getProxy(BagProxy):getItemCountById((var_1_3:getConfig("strengthen_item"))) then
		return
	end

	if var_1_1 == 0 then
		return
	end

	local var_1_4

	if var_1_3:isMaxLevel() and var_1_3:isMaxFateLevel() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("blueprint_max_level_tip"))

		do return end

		var_1_4 = Clone(var_1_3)
	end

	var_1_4:addExp(var_1_1 * var_1_3:getItemExp())

	local var_1_5 = getProxy(BayProxy)
	local var_1_6 = var_1_4.fateLevel > 0 and var_1_4:getFateStrengthenConfig(var_1_4.fateLevel) or var_1_4:getStrengthenConfig(math.max(var_1_4.level, 1))

	if var_1_5:getShipById(var_1_3.shipId).level < var_1_6.need_lv then
		pg.TipsMgr.GetInstance():ShowTips(i18n("buleprint_need_level_tip", var_1_6.need_lv))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(63204, {
		ship_id = var_1_3.shipId,
		count = var_1_1
	}, 63205, function(arg_2_0)
		if arg_2_0.result == 0 then
			arg_1_0:sendNotification(GAME.CONSUME_ITEM, Drop.New({
				type = DROP_TYPE_ITEM,
				count = var_1_1,
				id = var_0
			}))

			local var_2_0 = Clone(var_1_3)

			var_1_3:addExp(var_1_3:getItemExp() * var_1_1)

			if var_1_3.level > var_2_0.level then
				for iter_2_0 = var_2_0.level + 1, var_1_3.level do
					local var_2_1 = var_1_3:getStrengthenConfig(iter_2_0)

					if var_2_1.special == 1 and type(var_2_1.special_effect) == "table" then
						for iter_2_1, iter_2_2 in ipairs(var_2_1.special_effect) do
							if iter_2_2[1] == ShipBluePrint.STRENGTHEN_TYPE_SKILL then
								local var_2_2 = getProxy(BayProxy)
								local var_2_3 = var_2_2:getShipById(var_1_3.shipId)

								for iter_2_3, iter_2_4 in ipairs(iter_2_2[2]) do
									var_2_3.skills[var_0] = {
										exp = 0,
										level = 1,
										id = iter_2_4
									}

									pg.TipsMgr.GetInstance():ShowTips(iter_2_2[3])
								end

								var_2_2:updateShip(var_2_3)
							elseif iter_2_2[1] == ShipBluePrint.STRENGTHEN_TYPE_SKIN then
								getProxy(ShipSkinProxy):addSkin(ShipSkin.New({
									id = iter_2_2[2]
								}))
								pg.TipsMgr.GetInstance():ShowTips(iter_2_2[3])
							elseif iter_2_2[1] == ShipBluePrint.STRENGTHEN_TYPE_BREAKOUT then
								local var_2_5 = getProxy(BayProxy)

								arg_1_0:upgradeStar((var_2_5:getShipById(var_1_3.shipId)))
							end
						end
					end
				end
			elseif var_1_3.fateLevel > var_2_0.fateLevel then
				for iter_2_5 = var_2_0.fateLevel + 1, var_1_3.fateLevel do
					local var_2_6 = var_1_3:getFateStrengthenConfig(iter_2_5)

					if var_2_6.special == 1 and type(var_2_6.special_effect) == "table" then
						for iter_2_6, iter_2_7 in ipairs(var_2_6.special_effect) do
							if iter_2_7[1] == ShipBluePrint.STRENGTHEN_TYPE_CHANGE_SKILL then
								local var_2_7 = getProxy(BayProxy)
								local var_2_8 = var_2_7:getShipById(var_1_3.shipId)
								local var_2_9 = Clone(var_2_8.skills[iter_2_7[2][1]])

								assert(var_2_9, "shipVO without this skill" .. iter_2_7[2][1])

								var_2_9.id = iter_2_7[2][2]
								var_2_8.skills[iter_2_7[2][1]] = nil
								var_2_8.skills[iter_2_7[2][2]] = var_2_9

								pg.TipsMgr.GetInstance():ShowTips(iter_2_7[3])
								var_2_7:updateShip(var_2_8)

								local var_2_10 = getProxy(NavalAcademyProxy)
								local var_2_11 = var_2_10:getStudentByShipId(var_2_8.id)

								if var_2_11 and var_2_11.skillId == iter_2_7[2][1] then
									var_2_11.skillId = iter_2_7[2][2]

									var_2_10:updateStudent(var_2_11)
								end
							end
						end
					end
				end
			end

			local var_2_12 = var_1_5:getShipById(var_1_3.shipId)

			var_2_12.strengthList = {}

			table.insert(var_2_12.strengthList, {
				level = var_1_3.level + math.max(var_1_3.fateLevel, 0),
				exp = var_1_3.exp
			})
			var_1_5:updateShip(var_2_12)
			arg_1_0:sendNotification(GAME.MOD_BLUEPRINT_ANIM_LOCK)
			var_1_2:updateBluePrint(var_1_3)
			arg_1_0:sendNotification(GAME.MOD_BLUEPRINT_DONE, {
				oldBluePrint = var_2_0,
				newBluePrint = var_1_3
			})
			pg.TipsMgr.GetInstance():ShowTips(i18n("blueprint_mod_success"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("blueprint_mod_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

function var_0_0.upgradeStar(arg_3_0, arg_3_1)
	local var_3_0 = Clone(arg_3_1)
	local var_3_1 = getProxy(CollectionProxy):getShipGroup(var_3_0.groupId)

	if pg.ship_data_breakout[arg_3_1.configId].breakout_id ~= 0 then
		arg_3_1.configId = pg.ship_data_breakout[arg_3_1.configId].breakout_id

		for iter_3_0, iter_3_1 in ipairs(pg.ship_data_template[arg_3_1.configId].buff_list) do
			arg_3_1.skills[iter_3_1] = arg_3_1.skills[iter_3_1] or {
				exp = 0,
				level = 1,
				id = iter_3_1
			}
		end

		arg_3_1:updateMaxLevel(pg.ship_data_template[arg_3_1.configId].max_level)

		for iter_3_2, iter_3_3 in ipairs(pg.ship_data_template[var_3_0.configId].buff_list) do
			if not table.contains(pg.ship_data_template[arg_3_1.configId].buff_list, iter_3_3) then
				arg_3_1.skills[iter_3_3] = nil
			end
		end

		getProxy(BayProxy):updateShip(arg_3_1)
	end

	return
end

return var_0_0
