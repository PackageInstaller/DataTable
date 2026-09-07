local CommanderFormationOPCommand = class("CommanderFormationOPCommand", pm.SimpleCommand)

function CommanderFormationOPCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().data
	local var_1_1 = getProxy(CommanderProxy)
	local var_1_2 = getProxy(ChapterProxy)
	local var_1_3 = getProxy(FleetProxy)

	if var_1_0.data.type == LevelUIConst.COMMANDER_OP_RENAME then
		self:sendNotification(GAME.SET_COMMANDER_PREFAB_NAME, {
			id = var_1_0.data.id,
			name = var_1_0.data.str,
			onFailed = var_1_0.data.onFailed
		})

		return
	end

	if var_1_0.FleetType == LevelUIConst.FLEET_TYPE_SELECT then
		local var_1_4 = var_1_0.fleetId

		if var_1_0.data.type == LevelUIConst.COMMANDER_OP_RECORD_PREFAB then
			self:sendNotification(GAME.SET_COMMANDER_PREFAB, {
				id = var_1_0.data.id,
				commanders = var_1_3:getFleetById(var_1_0.fleetId):getCommanders()
			})
		elseif var_1_0.data.type == LevelUIConst.COMMANDER_OP_USE_PREFAB then
			self:sendNotification(GAME.USE_COMMANDER_PREFBA, {
				pid = var_1_0.data.id,
				fleetId = var_1_0.fleetId
			})
		elseif var_1_0.data.type == LevelUIConst.COMMANDER_OP_REST_ALL then
			seriesAsync({
				function(arg_2_0)
					self:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET, {
						commanderId = 0,
						pos = 1,
						fleetId = var_1_4,
						callback = arg_2_0
					})

					return
				end,
				function(arg_3_0)
					self:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET, {
						commanderId = 0,
						pos = 2,
						fleetId = var_1_4,
						callback = arg_3_0
					})

					return
				end
			})
		end
	elseif var_1_0.FleetType == LevelUIConst.FLEET_TYPE_EDIT then
		local var_1_6 = var_1_1:getPrefabFleetById(var_1_0.data.id)

		if var_1_0.data.type == LevelUIConst.COMMANDER_OP_RECORD_PREFAB then
			local var_1_7 = var_1_2:getChapterById(var_1_0.chapterId)
			local var_1_8 = var_1_7:getEliteFleetCommanders()[var_1_0.index]

			if table.getCount(var_1_8) == 0 then
				return
			end

			local var_1_9 = {}

			for iter_1_0 = 1, 2 do
				local var_1_10 = var_1_1:getCommanderById(var_1_8[iter_1_0])

				if var_1_10 then
					var_1_9[iter_1_0] = var_1_10
				end
			end

			self:sendNotification(GAME.SET_COMMANDER_PREFAB, {
				id = var_1_0.data.id,
				commanders = var_1_9
			})
			var_1_2:updateChapter(var_1_7)
			self:sendNotification(GAME.COMMANDER_ELIT_FORMATION_OP_DONE, {
				chapterId = var_1_7.id,
				index = var_1_0.index
			})
		elseif var_1_0.data.type == LevelUIConst.COMMANDER_OP_USE_PREFAB then
			for iter_1_1 = 1, 2 do
				local var_1_12 = var_1_6:getCommanderByPos(iter_1_1)

				if var_1_12 then
					local var_1_13, var_1_14 = Commander.canEquipToEliteChapter(var_1_0.chapterId, var_1_0.index, iter_1_1, var_1_12.id)

					if not var_1_13 then
						pg.TipsMgr.GetInstance():ShowTips(var_1_14)

						return
					end
				end
			end

			local var_1_15 = var_1_2:getChapterById(var_1_0.chapterId)

			if var_1_6:isSameId(var_1_15:getEliteFleetCommanders()[var_1_0.index]) then
				return
			end

			for iter_1_2 = 1, 2 do
				local var_1_16 = var_1_6:getCommanderByPos(iter_1_2)

				if var_1_16 then
					self:sendNotification(GAME.SELECT_ELIT_CHAPTER_COMMANDER, {
						chapterId = var_1_0.chapterId,
						index = var_1_0.index,
						pos = iter_1_2,
						commanderId = var_1_16.id
					})
				else
					self:sendNotification(GAME.SELECT_ELIT_CHAPTER_COMMANDER, {
						commanderId = 0,
						chapterId = var_1_0.chapterId,
						index = var_1_0.index,
						pos = iter_1_2
					})
				end
			end

			self:sendNotification(GAME.COMMANDER_ELIT_FORMATION_OP_DONE, {
				chapterId = var_1_15.id,
				index = var_1_0.index
			})
		elseif var_1_0.data.type == LevelUIConst.COMMANDER_OP_REST_ALL then
			for iter_1_3 = 1, 2 do
				self:sendNotification(GAME.SELECT_ELIT_CHAPTER_COMMANDER, {
					commanderId = 0,
					chapterId = var_1_0.chapterId,
					index = var_1_0.index,
					pos = iter_1_3
				})
			end

			self:sendNotification(GAME.COMMANDER_ELIT_FORMATION_OP_DONE, {
				chapterId = var_1_2:getChapterById(var_1_0.chapterId).id,
				index = var_1_0.index
			})
		end
	elseif var_1_0.FleetType == LevelUIConst.FLEET_TYPE_ACTIVITY then
		local var_1_17 = var_1_1:getPrefabFleetById(var_1_0.data.id)
		local var_1_18 = var_1_0.fleetId
		local var_1_19 = var_1_0.actId

		if var_1_0.data.type == LevelUIConst.COMMANDER_OP_RECORD_PREFAB then
			self:sendNotification(GAME.SET_COMMANDER_PREFAB, {
				id = var_1_0.data.id,
				commanders = var_1_3:getActivityFleets()[var_1_0.actId][var_1_0.fleetId]:getCommanders()
			})
		elseif var_1_0.data.type == LevelUIConst.COMMANDER_OP_USE_PREFAB then
			local var_1_20 = {}
			local var_1_21 = var_1_3:getActivityFleets()[var_1_0.actId]

			if pg.activity_template[var_1_0.actId] then
				local var_1_22 = pg.activity_template[var_1_0.actId].type or 0
			end

			local function var_1_23(arg_4_0)
				for iter_4_0, iter_4_1 in pairs(var_1_21) do
					if (var_1_22 == ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 or var_1_22 == ActivityConst.ACTIVITY_TYPE_BOSSSINGLE or var_1_22 == ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE or nil) and iter_4_0 == ActivityBossMediatorTemplate.GetPairedFleetIndex(var_1_18) then
						for iter_4_2, iter_4_3 in pairs((iter_4_1:getCommanders())) do
							if arg_4_0 == iter_4_3.id then
								return iter_4_0, iter_4_2
							end
						end
					end
				end

				return nil
			end

			for iter_1_4 = 1, 2 do
				local var_1_24 = var_1_17:getCommanderByPos(iter_1_4)

				if var_1_24 then
					local var_1_25, var_1_26 = var_1_23(var_1_24.id)

					if var_1_25 and var_1_26 then
						table.insert(var_1_20, function(arg_5_0)
							local var_5_0 = var_1_26 == 1 and i18n("commander_main_pos") or i18n("commander_assistant_pos")

							pg.MsgboxMgr.GetInstance():ShowMsgBox({
								content = i18n("comander_repalce_tip", Fleet.DEFAULT_NAME[var_1_25], var_5_0),
								onYes = function()
									var_1_21[var_1_25]:updateCommanderByPos(var_1_26, nil)
									var_1_3:updateActivityFleet(var_1_19, var_1_25, var_1_21[var_1_25])
									var_1_21[var_1_18]:updateCommanderByPos(iter_1_4, var_1_24)
									var_1_3:updateActivityFleet(var_1_19, var_1_18, var_1_21[var_1_18])
									arg_5_0()

									return
								end,
								onNo = arg_5_0
							})

							return
						end)
					else
						table.insert(var_1_20, function(arg_7_0)
							var_1_21[var_1_18]:updateCommanderByPos(iter_1_4, var_1_24)
							var_1_3:updateActivityFleet(var_1_19, var_1_18, var_1_21[var_1_18])
							arg_7_0()

							return
						end)
					end
				else
					table.insert(var_1_20, function(arg_8_0)
						var_1_21[var_1_18]:updateCommanderByPos(iter_1_4, nil)
						var_1_3:updateActivityFleet(var_1_19, var_1_18, var_1_21[var_1_18])
						arg_8_0()

						return
					end)
				end
			end

			seriesAsync(var_1_20, function()
				self:sendNotification(GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE, {
					actId = var_1_19,
					fleetId = var_1_18
				})

				return
			end)
		elseif var_1_0.data.type == LevelUIConst.COMMANDER_OP_REST_ALL then
			local var_1_27 = var_1_3:getActivityFleets()[var_1_0.actId][var_1_0.fleetId]

			for iter_1_5 = 1, 2 do
				var_1_27:updateCommanderByPos(iter_1_5, nil)
			end

			var_1_3:updateActivityFleet(var_1_0.actId, var_1_0.fleetId, var_1_27)
			self:sendNotification(GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE, {
				actId = var_1_0.actId,
				fleetId = var_1_0.fleetId
			})
		end
	elseif var_1_0.FleetType == LevelUIConst.FLEET_TYPE_WORLD then
		local var_1_28 = var_1_1:getPrefabFleetById(var_1_0.data.id)
		local var_1_29 = var_1_0.fleets
		local var_1_30 = var_1_0.fleets[var_1_0.fleetType][var_1_0.fleetIndex]
		local var_1_31 = Fleet.New({
			ship_list = {},
			commanders = var_1_0.fleets[var_1_0.fleetType][var_1_0.fleetIndex].commanders
		})

		if var_1_0.data.type == LevelUIConst.COMMANDER_OP_RECORD_PREFAB then
			self:sendNotification(GAME.SET_COMMANDER_PREFAB, {
				id = var_1_0.data.id,
				commanders = var_1_31:getCommanders()
			})
		elseif var_1_0.data.type == LevelUIConst.COMMANDER_OP_USE_PREFAB then
			local var_1_32 = {}

			local function var_1_33(arg_10_0)
				for iter_10_0, iter_10_1 in pairs(var_1_29) do
					for iter_10_2, iter_10_3 in pairs(iter_10_1) do
						if var_1_30 ~= iter_10_3 then
							for iter_10_4, iter_10_5 in ipairs(iter_10_3.commanders) do
								if iter_10_5.id == arg_10_0 then
									return iter_10_0, iter_10_2, iter_10_5.pos
								end
							end
						end
					end
				end

				return nil
			end

			for iter_1_6 = 1, 2 do
				local var_1_34 = var_1_28:getCommanderByPos(iter_1_6)

				if var_1_34 then
					local var_1_35, var_1_36, var_1_37 = var_1_33(var_1_34.id)

					if var_1_35 and var_1_36 and var_1_37 then
						table.insert(var_1_32, function(arg_11_0)
							local var_11_0 = var_1_37 == 1 and i18n("commander_main_pos") or i18n("commander_assistant_pos")

							pg.MsgboxMgr.GetInstance():ShowMsgBox({
								content = i18n("comander_repalce_tip", Fleet.DEFAULT_NAME[var_1_36 + (var_1_35 == FleetType.Submarine and 10 or 0)], var_11_0),
								onYes = function()
									local var_12_0 = Fleet.New({
										ship_list = {},
										commanders = var_1_29[var_1_35][var_1_36].commanders
									})

									var_12_0:updateCommanderByPos(iter_1_6, nil)

									var_1_29[var_1_35][var_1_36].commanders = var_12_0:outputCommanders()

									var_1_31:updateCommanderByPos(iter_1_6, var_1_34)

									var_1_30.commanders = var_1_31:outputCommanders()

									arg_11_0()

									return
								end,
								onNo = arg_11_0
							})

							return
						end)
					else
						table.insert(var_1_32, function(arg_13_0)
							var_1_31:updateCommanderByPos(iter_1_6, var_1_34)

							var_1_30.commanders = var_1_31:outputCommanders()

							arg_13_0()

							return
						end)
					end
				else
					table.insert(var_1_32, function(arg_14_0)
						var_1_31:updateCommanderByPos(iter_1_6, nil)

						var_1_30.commanders = var_1_31:outputCommanders()

						arg_14_0()

						return
					end)
				end
			end

			seriesAsync(var_1_32, function()
				self:sendNotification(GAME.COMMANDER_WORLD_FORMATION_OP_DONE, {
					fleet = var_1_31
				})

				return
			end)
		elseif var_1_0.data.type == LevelUIConst.COMMANDER_OP_REST_ALL then
			for iter_1_7 = 1, 2 do
				var_1_31:updateCommanderByPos(iter_1_7, nil)
			end

			var_1_0.fleets[var_1_0.fleetType][var_1_0.fleetIndex].commanders = var_1_31:outputCommanders()

			self:sendNotification(GAME.COMMANDER_WORLD_FORMATION_OP_DONE, {
				fleet = var_1_31
			})
		end
	elseif var_1_0.FleetType == LevelUIConst.FLEET_TYPE_BOSSRUSH then
		local var_1_38 = var_1_1:getPrefabFleetById(var_1_0.data.id)
		local var_1_39 = var_1_0.fleetId
		local var_1_40 = var_1_0.actId

		if var_1_0.data.type == LevelUIConst.COMMANDER_OP_RECORD_PREFAB then
			self:sendNotification(GAME.SET_COMMANDER_PREFAB, {
				id = var_1_0.data.id,
				commanders = var_1_3:getActivityFleets()[var_1_0.actId][var_1_0.fleetId]:getCommanders()
			})
		elseif var_1_0.data.type == LevelUIConst.COMMANDER_OP_USE_PREFAB then
			local var_1_41 = {}
			local var_1_42 = {}

			_.each(var_1_0.fleets, function(arg_16_0)
				var_1_42[arg_16_0.id] = arg_16_0

				return
			end)

			local function var_1_43(arg_17_0)
				for iter_17_0, iter_17_1 in pairs(var_1_42) do
					if var_1_39 ~= iter_17_0 then
						for iter_17_2, iter_17_3 in pairs((iter_17_1:getCommanders())) do
							if arg_17_0 == iter_17_3.id then
								return iter_17_0, iter_17_2
							end
						end
					end
				end

				return nil
			end

			for iter_1_8 = 1, 2 do
				local var_1_44 = var_1_38:getCommanderByPos(iter_1_8)

				if var_1_44 then
					local var_1_45, var_1_46 = var_1_43(var_1_44.id)

					if var_1_45 and var_1_46 then
						table.insert(var_1_41, function(arg_18_0)
							local var_18_0 = var_1_46 == 1 and i18n("commander_main_pos") or i18n("commander_assistant_pos")

							pg.MsgboxMgr.GetInstance():ShowMsgBox({
								content = i18n("comander_repalce_tip", Fleet.DEFAULT_NAME[table.indexof(var_1_0.fleets, var_1_42[var_1_45])], var_18_0),
								onYes = function()
									var_1_42[var_1_45]:updateCommanderByPos(var_1_46, nil)
									var_1_3:updateActivityFleet(var_1_40, var_1_45, var_1_42[var_1_45])
									var_1_42[var_1_39]:updateCommanderByPos(iter_1_8, var_1_44)
									var_1_3:updateActivityFleet(var_1_40, var_1_39, var_1_42[var_1_39])
									arg_18_0()

									return
								end,
								onNo = arg_18_0
							})

							return
						end)
					else
						table.insert(var_1_41, function(arg_20_0)
							var_1_42[var_1_39]:updateCommanderByPos(iter_1_8, var_1_44)
							var_1_3:updateActivityFleet(var_1_40, var_1_39, var_1_42[var_1_39])
							arg_20_0()

							return
						end)
					end
				else
					table.insert(var_1_41, function(arg_21_0)
						var_1_42[var_1_39]:updateCommanderByPos(iter_1_8, nil)
						var_1_3:updateActivityFleet(var_1_40, var_1_39, var_1_42[var_1_39])
						arg_21_0()

						return
					end)
				end
			end

			seriesAsync(var_1_41, function()
				self:sendNotification(GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE, {
					actId = var_1_40,
					fleetId = var_1_39
				})

				return
			end)
		elseif var_1_0.data.type == LevelUIConst.COMMANDER_OP_REST_ALL then
			local var_1_47 = var_1_3:getActivityFleets()[var_1_0.actId][var_1_0.fleetId]

			for iter_1_9 = 1, 2 do
				var_1_47:updateCommanderByPos(iter_1_9, nil)
			end

			var_1_3:updateActivityFleet(var_1_0.actId, var_1_0.fleetId, var_1_47)
			self:sendNotification(GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE, {
				actId = var_1_0.actId,
				fleetId = var_1_0.fleetId
			})
		end
	end

	return
end

return CommanderFormationOPCommand
