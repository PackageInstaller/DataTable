local PursuingBluePrintCommand = class("PursuingBluePrintCommand", pm.SimpleCommand)

function PursuingBluePrintCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.count
	local var_1_2 = var_1_0.id

	if var_1_0.count == 0 then
		return
	end

	local var_1_3 = getProxy(TechnologyProxy)
	local var_1_4 = var_1_3:getBluePrintById(var_1_0.id)

	if not var_1_4 then
		return
	end

	if not var_1_4:isUnlock() then
		return
	end

	local var_1_5 = getProxy(PlayerProxy):getRawData()
	local var_1_6 = var_1_3:calcPursuingCost(var_1_4, var_1_0.count)

	if var_1_5:getResource(PlayerConst.ResGold) < var_1_6 then
		return
	end

	local var_1_7

	if var_1_4:isMaxLevel() and var_1_4:isMaxFateLevel() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("blueprint_max_level_tip"))

		do return end

		var_1_7 = Clone(var_1_4)
	end

	var_1_7:addExp(var_1_0.count * var_1_4:getItemExp())

	local var_1_8 = var_1_7:getStrengthenConfig(math.max(var_1_7.level, 1))
	local var_1_9 = getProxy(BayProxy)

	if var_1_9:getShipById(var_1_4.shipId).level < var_1_8.need_lv then
		pg.TipsMgr.GetInstance():ShowTips(i18n("buleprint_need_level_tip", var_1_8.need_lv))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(63212, {
		ship_id = var_1_4.shipId,
		count = var_1_0.count
	}, 63213, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(PlayerProxy)
			local var_2_1 = var_2_0:getData()

			var_2_1:consume({
				gold = var_1_6
			})
			var_2_0:updatePlayer(var_2_1)
			var_1_3:addPursuingTimes(var_1_1, var_1_4:isRarityUR())

			local var_2_2 = Clone(var_1_4)

			var_1_4:addExp(var_1_4:getItemExp() * var_1_1)

			if var_1_4.level > var_2_2.level then
				for iter_2_0 = var_2_2.level + 1, var_1_4.level do
					local var_2_3 = var_1_4:getStrengthenConfig(iter_2_0)

					if var_2_3.special == 1 and type(var_2_3.special_effect) == "table" then
						for iter_2_1, iter_2_2 in ipairs(var_2_3.special_effect) do
							if iter_2_2[1] == ShipBluePrint.STRENGTHEN_TYPE_SKILL then
								local var_2_4 = getProxy(BayProxy)
								local var_2_5 = var_2_4:getShipById(var_1_4.shipId)

								for iter_2_3, iter_2_4 in ipairs(iter_2_2[2]) do
									var_2_5.skills[var_1_2] = {
										exp = 0,
										level = 1,
										id = iter_2_4
									}

									pg.TipsMgr.GetInstance():ShowTips(iter_2_2[3])
								end

								var_2_4:updateShip(var_2_5)
							elseif iter_2_2[1] == ShipBluePrint.STRENGTHEN_TYPE_SKIN then
								getProxy(ShipSkinProxy):addSkin(ShipSkin.New({
									id = iter_2_2[2]
								}))
								pg.TipsMgr.GetInstance():ShowTips(iter_2_2[3])
							elseif iter_2_2[1] == ShipBluePrint.STRENGTHEN_TYPE_BREAKOUT then
								self:upgradeStar((getProxy(BayProxy):getShipById(var_1_4.shipId)))
							end
						end
					end
				end
			elseif var_1_4.fateLevel > var_2_2.fateLevel then
				for iter_2_5 = var_2_2.fateLevel + 1, var_1_4.fateLevel do
					local var_2_7 = var_1_4:getFateStrengthenConfig(iter_2_5)

					if var_2_7.special == 1 and type(var_2_7.special_effect) == "table" then
						for iter_2_6, iter_2_7 in ipairs(var_2_7.special_effect) do
							if iter_2_7[1] == ShipBluePrint.STRENGTHEN_TYPE_CHANGE_SKILL then
								local var_2_8 = getProxy(BayProxy)
								local var_2_9 = var_2_8:getShipById(var_1_4.shipId)
								local var_2_10 = Clone(var_2_9.skills[iter_2_7[2][1]])

								assert(var_2_10, "shipVO without this skill" .. iter_2_7[2][1])

								var_2_10.id = iter_2_7[2][2]
								var_2_9.skills[iter_2_7[2][1]] = nil
								var_2_9.skills[iter_2_7[2][2]] = var_2_10

								pg.TipsMgr.GetInstance():ShowTips(iter_2_7[3])
								var_2_8:updateShip(var_2_9)

								local var_2_11 = getProxy(NavalAcademyProxy)
								local var_2_12 = var_2_11:getStudentByShipId(var_2_9.id)

								if var_2_12 and var_2_12.skillId == iter_2_7[2][1] then
									var_2_12.skillId = iter_2_7[2][2]

									var_2_11:updateStudent(var_2_12)
								end
							end
						end
					end
				end
			end

			local var_2_13 = var_1_9:getShipById(var_1_4.shipId)

			var_2_13.strengthList = {}

			table.insert(var_2_13.strengthList, {
				level = var_1_4.level + math.max(var_1_4.fateLevel, 0),
				exp = var_1_4.exp
			})
			var_1_9:updateShip(var_2_13)
			self:sendNotification(GAME.MOD_BLUEPRINT_ANIM_LOCK)
			var_1_3:updateBluePrint(var_1_4)
			self:sendNotification(GAME.MOD_BLUEPRINT_DONE, {
				oldBluePrint = var_2_2,
				newBluePrint = var_1_4
			})
			pg.TipsMgr.GetInstance():ShowTips(i18n("blueprint_mod_success"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("blueprint_mod_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

function PursuingBluePrintCommand:upgradeStar(arg_3_1)
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

return PursuingBluePrintCommand
