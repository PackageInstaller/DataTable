local WorldProxy = class("WorldProxy", import(".NetProxy"))

function WorldProxy:register()
	WPool = BaseEntityPool.New()
	WBank = BaseEntityBank.New()

	self:BuildTestFunc()
	self:on(33114, function(arg_2_0)
		self.isProtoLock = arg_2_0.is_world_open == 0

		self:BuildWorld(World.TypeBase)

		self.world.baseShipIds = underscore.rest(arg_2_0.ship_id_list, 1)
		self.world.baseCmdIds = underscore.rest(arg_2_0.cmd_id_list, 1)

		self.world:UpdateProgress(arg_2_0.progress)
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inWorld")
		self:sendNotification(GAME.WORLD_GET_BOSS)

		return
	end)
	self:on(33105, function(arg_3_0)
		local var_3_0 = self.world:GetActiveMap()

		assert(var_3_0, "active map not exist.")
		self:UpdateMapAttachmentCells(var_3_0.id, (self:NetBuildMapAttachmentCells(arg_3_0.pos_list)))

		local var_3_1 = self:NetBuildFleetAttachUpdate(arg_3_0.pos_list)

		self:ApplyFleetAttachUpdate(var_3_0.id, var_3_1)
		WPool:ReturnArray(var_3_1)

		return
	end)
	self:on(33203, function(arg_4_0)
		local var_4_0 = self.world:GetTaskProxy()

		for iter_4_0, iter_4_1 in ipairs(arg_4_0.update_list) do
			local var_4_1 = WorldTask.New(iter_4_1)

			if var_4_0:getTaskById(var_4_1.id) then
				var_4_0:updateTask(var_4_1)
			else
				var_4_0:addTask(var_4_1)
				self:sendNotification(GAME.WORLD_TRIGGER_TASK_DONE, {
					task = var_4_1
				})
			end
		end

		return
	end)
	self:on(33204, function(arg_5_0)
		local var_5_0 = self.world:GetTaskProxy()

		for iter_5_0, iter_5_1 in ipairs(arg_5_0.delete_list) do
			var_5_0:deleteTask(iter_5_1)
		end

		return
	end)
	self:on(33601, function(arg_6_0)
		self:NetUpdateAchievements(arg_6_0.target_list)

		return
	end)
	self:on(34507, function(arg_7_0)
		if self.world then
			local var_7_0 = self.world:GetBossProxy()
			local var_7_1 = WorldBoss.New()

			var_7_1:Setup(arg_7_0.boss_info, Player.New(arg_7_0.user_info))
			var_7_1:UpdateBossType(arg_7_0.type)
			var_7_1:SetJoinTime(pg.TimeMgr.GetInstance():GetServerTime())

			if var_7_0.isSetup then
				var_7_0:ClearRank(var_7_1.id)
				var_7_0:UpdateCacheBoss(var_7_1)
			end

			if not var_7_0:IsSelfBoss(var_7_1) and self.world:IsSystemOpen(WorldConst.SystemWorldBoss) then
				pg.WorldBossTipMgr.GetInstance():Show(var_7_1)
			end
		end

		return
	end)
	self:on(34508, function(arg_8_0)
		local var_8_0 = self.world:GetBossProxy()

		if var_8_0.isSetup then
			self:sendNotification(GAME.WORLD_GET_BOSS_RANK, {
				bossId = arg_8_0.boss_id,
				callback = function()
					var_8_0:updateBossHp(arg_8_0.boss_id, arg_8_0.hp)

					return
				end
			})
		end

		return
	end)

	return
end

function WorldProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_11_0)
			local var_11_0 = nowWorld()

			if pg.TimeMgr.GetInstance():GetServerWeek() == 1 then
				var_11_0.staminaMgr.staminaExchangeTimes = 0
			end

			if var_11_0 then
				local var_11_1 = var_11_0:GetBossProxy()

				var_11_1:increasePt()
				var_11_1:ClearSummonPtDailyAcc()
				var_11_1:ClearSummonPtOldAcc()
			end

			return
		end
	}
end

function WorldProxy:remove()
	if self.world then
		self.world:GetBossProxy():Dispose()
	end

	removeWorld()
	WPool:Dispose()

	WPool = nil

	WBank:Dispose()

	WBank = nil

	return
end

function WorldProxy:BuildTestFunc()
	world_skip_battle = PlayerPrefs.GetInt("world_skip_battle") or 0

	function switch_world_skip_battle()
		if getProxy(PlayerProxy):getRawData():CheckIdentityFlag() then
			world_skip_battle = 1 - world_skip_battle

			PlayerPrefs.SetInt("world_skip_battle", world_skip_battle)
			PlayerPrefs.Save()
			pg.TipsMgr.GetInstance():ShowTips(world_skip_battle == 1 and "已开启大世界战斗跳略" or "已关闭大世界战斗跳略")
		end

		return
	end

	if IsUnityEditor then
		function display_world_debug_panel()
			local var_15_0 = pg.m02:retrieveMediator(WorldMediator.__cname)

			if var_15_0 then
				var_15_0.viewComponent:ShowSubView("DebugPanel")
			end

			return
		end

		pg.UIMgr.GetInstance():AddWorldTestButton("WorldDebug", function()
			WorldConst.Debug = true

			return
		end)
	end

	return
end

function WorldProxy:BuildWorld(arg_17_1, arg_17_2)
	self.world = World.New(arg_17_1, self.world and self.world:Dispose(tobool(arg_17_2)))

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inWorld")

	return
end

function WorldProxy:NetFullUpdate(arg_18_1)
	self.isProtoLock = arg_18_1.is_world_open == 0

	self:NetUpdateWorld(arg_18_1.world, arg_18_1.global_flag_list, arg_18_1.camp)
	self:NetUpdateWorldDefaultFleets(arg_18_1.fleet_list)
	self:NetUpdateWorldAchievements(arg_18_1.target_list, arg_18_1.target_fetch_list)
	self:NetUpdateWorldCountInfo(arg_18_1.count_info)
	self:NetUpdateWorldMapPressing(arg_18_1.clean_chapter)
	self:NetUpdateWorldPressingAward(arg_18_1.chapter_award)
	self:NetUpdateWorldShopGoods(arg_18_1.out_shop_buy_list)
	self:NetUpdateWorldPortShopMark(arg_18_1.port_list, arg_18_1.new_flag_port_list)

	return
end

function WorldProxy:NetUpdateWorld(arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = self.world

	self.world:SetRealm(arg_19_3)

	self.world.activateTime = arg_19_1.time
	self.world.expiredTime = arg_19_1.last_change_group_timestamp
	self.world.roundIndex = arg_19_1.round
	self.world.submarineSupport = arg_19_1.submarine_state == 1

	self.world.staminaMgr:Setup({
		arg_19_1.action_power,
		arg_19_1.action_power_extra,
		arg_19_1.last_recover_timestamp,
		arg_19_1.action_power_fetch_count
	})

	self.world.gobalFlag = underscore.map(arg_19_2, function(arg_20_0)
		return arg_20_0 > 0
	end)

	local var_19_1 = self.world:GetAtlas()

	var_19_1:SetCostMapList(_.rest(arg_19_1.chapter_list, 1))
	var_19_1:SetSairenEntranceList(_.rest(arg_19_1.sairen_chapter, 1))
	var_19_1:InitWorldNShopGoods(arg_19_1.goods_list)
	self.world:SetFleets(self:NetBuildMapFleetList(arg_19_1.group_list))

	local var_19_2 = arg_19_1.map_id > 0 and _.detect(arg_19_1.chapter_list, function(arg_21_0)
		return arg_21_0.random_id == arg_19_1.map_id
	end)

	assert(arg_19_1.map_id > 0 == tobool(var_19_2), "error active map info:" .. arg_19_1.map_id)

	if var_19_2 then
		local var_19_3 = var_19_2.template_id
		local var_19_4 = self.world:GetEntrance(arg_19_1.enter_map_id)
		local var_19_5 = self.world:GetMap(var_19_2.random_id)

		assert(var_19_4, "entrance not exist: " .. arg_19_1.enter_map_id)
		assert(var_19_5, "map not exist: " .. var_19_2.random_id)
		assert(pg.world_chapter_template[var_19_3], "world_chapter_template not exist: " .. var_19_3)
		assert(#arg_19_1.group_list > 0, "amount of group_list is not enough.")
		var_19_4:UpdateActive(true)
		var_19_5:UpdateGridId(var_19_3)

		var_19_5.findex = table.indexof(self.world.fleets, self.world:GetFleet(arg_19_1.group_list[1].id))

		var_19_5:BindFleets(self.world.fleets)
		var_19_5:UpdateActive(true)
	end

	self.world:GetInventoryProxy():Setup(arg_19_1.item_list)

	local var_19_6 = self.world:GetTaskProxy()

	var_19_6:Setup(arg_19_1.task_list)

	var_19_6.taskFinishCount = arg_19_1.task_finish_count

	_.each(arg_19_1.cd_list, function(arg_22_0)
		var_19_0.cdTimeList[arg_22_0.id] = arg_22_0.time

		return
	end)
	_.each(arg_19_1.buff_list, function(arg_23_0)
		var_19_0.globalBuffDic[arg_23_0.id] = WorldBuff.New()

		var_19_0.globalBuffDic[arg_23_0.id]:Setup({
			id = arg_23_0.id,
			floor = arg_23_0.stack
		})

		return
	end)
	underscore.each(arg_19_1.month_boss, function(arg_24_0)
		var_19_0.lowestHP[arg_24_0.key] = arg_24_0.value

		return
	end)

	return
end

function WorldProxy:NetUpdateWorldDefaultFleets(arg_25_1)
	local var_25_0 = {}

	_.each(arg_25_1, function(arg_26_0)
		local var_26_0 = WorldBaseFleet.New()

		var_26_0:Setup(arg_26_0)
		table.insert(var_25_0, var_26_0)

		return
	end)
	table.sort(var_25_0, function(arg_27_0, arg_27_1)
		return arg_27_0.id < arg_27_1.id
	end)
	self.world:SetDefaultFleets(var_25_0)

	return
end

function WorldProxy:NetUpdateWorldAchievements(arg_28_1, arg_28_2)
	self.world.achievements = {}

	self:NetUpdateAchievements(arg_28_1)

	self.world.achieveEntranceStar = {}

	_.each(arg_28_2, function(arg_29_0)
		for iter_29_0, iter_29_1 in ipairs(arg_29_0.star_list) do
			self.world:SetAchieveSuccess(arg_29_0.id, iter_29_1)
		end

		return
	end)

	return
end

function WorldProxy:NetUpdateWorldCountInfo(arg_30_1)
	self.world.stepCount = arg_30_1.step_count
	self.world.treasureCount = arg_30_1.treasure_count
	self.world.activateCount = arg_30_1.activate_count

	self.world:GetCollectionProxy():Setup(arg_30_1.collection_list)
	self.world:UpdateProgress(arg_30_1.task_progress)

	return
end

function WorldProxy:NetUpdateActiveMap(arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = self.world:GetActiveEntrance()
	local var_31_1 = self.world:GetActiveMap()

	if var_31_1:NeedClear() and var_31_0.becomeSairen and var_31_0:GetSairenMapId() == var_31_1.id then
		self.world:GetAtlas():RemoveSairenEntrance(var_31_0)
	end

	local var_31_2 = self.world:GetEntrance(arg_31_1)

	assert(var_31_2, "entrance not exist: " .. arg_31_1)

	if var_31_0.id ~= var_31_2.id then
		var_31_0:UpdateActive(false)
		var_31_2:UpdateActive(true)
	end

	local var_31_3 = self.world:GetMap(arg_31_2)

	assert(var_31_3, "map not exist: " .. arg_31_2)

	if var_31_1.id ~= var_31_3.id then
		var_31_1:UpdateActive(false)
		var_31_1:RemoveFleetsCarries()
		var_31_1:UnbindFleets()

		var_31_3.findex = var_31_1.findex
		var_31_1.findex = nil

		var_31_3:UpdateGridId(arg_31_3)
		var_31_3:BindFleets(self.world.fleets)
		var_31_3:UpdateActive(true)
	end

	self.world:OnSwitchMap()

	return
end

function WorldProxy:NetUpdateMap(arg_32_1)
	assert(pg.world_chapter_random[arg_32_1.id.random_id], "world_chapter_random not exist: " .. arg_32_1.id.random_id)
	assert(pg.world_chapter_template[arg_32_1.id.template_id], "world_chapter_template not exist: " .. arg_32_1.id.template_id)

	local var_32_0 = {}

	_.each(arg_32_1.state_flag, function(arg_33_0)
		var_32_0[arg_33_0] = true

		return
	end)

	local var_32_1 = self.world:GetMap(arg_32_1.id.random_id)

	var_32_1:UpdateClearFlag(var_32_0[1])
	var_32_1:UpdateVisionFlag(var_32_0[2] or self.world:IsMapVisioned(arg_32_1.id.random_id))
	self:NetUpdateMapDiscoveredCells(var_32_1.id, var_32_0[3], arg_32_1.cell_list)
	self:UpdateMapAttachmentCells(var_32_1.id, (self:NetBuildMapAttachmentCells(arg_32_1.pos_list)))

	local var_32_2 = self:NetBuildFleetAttachUpdate(arg_32_1.pos_list)

	self:ApplyFleetAttachUpdate(var_32_1.id, var_32_2)
	WPool:ReturnArray(var_32_2)

	local var_32_3 = self:NetBulidTerrainUpdate(arg_32_1.land_list)

	self:ApplyTerrainUpdate(var_32_1.id, var_32_3)
	WPool:ReturnArray(var_32_3)
	var_32_1:SetValid(true)

	return
end

function WorldProxy:NetUpdateMapDiscoveredCells(arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = self.world:GetMap(arg_34_1)

	assert(var_34_0, "map not exist: " .. arg_34_1)

	if arg_34_2 then
		for iter_34_0, iter_34_1 in pairs(var_34_0.cells) do
			iter_34_1:UpdateDiscovered(true)
		end
	else
		_.each(arg_34_3, function(arg_35_0)
			local var_35_0 = var_34_0:GetCell(arg_35_0.pos.row, arg_35_0.pos.column)

			assert(var_35_0, "cell not exist: " .. arg_35_0.pos.row .. ", " .. arg_35_0.pos.column)
			var_35_0:UpdateDiscovered(true)

			return
		end)
	end

	return
end

function WorldProxy:NetUpdateMapPort(arg_36_1, arg_36_2)
	local var_36_0 = self.world:GetMap(arg_36_1)

	assert(var_36_0, "map not exist: " .. arg_36_1)

	local var_36_1 = var_36_0:GetPort(arg_36_2.port_id)

	assert(var_36_1, "port not exist: " .. arg_36_2.port_id)
	var_36_1:UpdateTaskIds(_.rest(arg_36_2.task_list, 1))
	var_36_1:UpdateGoods(_.map(arg_36_2.goods_list, function(arg_37_0)
		local var_37_0 = WPool:Get(WorldGoods)

		var_37_0:Setup(arg_37_0)

		return var_37_0
	end))
	var_36_1:UpdateExpiredTime(arg_36_2.next_refresh_time)

	return
end

function WorldProxy:NetUpdateAchievements(arg_38_1)
	_.each(arg_38_1, function(arg_39_0)
		self.world:DispatchEvent(World.EventAchieved, self.world:GetAchievement(arg_39_0.id):NetUpdate(arg_39_0.process_list))

		return
	end)

	return
end

function WorldProxy:NetBuildMapFleetList(arg_40_1)
	local var_40_0 = {}

	if arg_40_1 and #arg_40_1 > 0 then
		_.each(arg_40_1, function(arg_41_0)
			local var_41_0 = WorldMapFleet.New()

			var_41_0:Setup(arg_41_0)
			table.insert(var_40_0, var_41_0)

			return
		end)
		table.sort(var_40_0, function(arg_42_0, arg_42_1)
			return arg_42_0.id < arg_42_1.id
		end)

		local var_40_1 = {
			[FleetType.Normal] = 1,
			[FleetType.Submarine] = 1
		}

		_.each(var_40_0, function(arg_43_0)
			local var_43_0 = arg_43_0:GetFleetType()

			arg_43_0.index = var_40_1[var_43_0]
			var_40_1[var_43_0] = var_40_1[var_43_0] + 1

			return
		end)
	end

	return var_40_0
end

function WorldProxy:NetBuildPortShipList(arg_44_1)
	return _.map(arg_44_1, function(arg_45_0)
		local var_45_0 = WPool:Get(WorldMapShip)

		var_45_0:Setup(arg_45_0)

		return var_45_0
	end)
end

function WorldProxy:NetResetWorld()
	self:sendNotification(GAME.SEND_CMD, {
		cmd = "world",
		arg1 = "reset"
	})
	self:sendNotification(GAME.SEND_CMD, {
		cmd = "kick"
	})

	return
end

function WorldProxy:NetBuildMapAttachmentCells(arg_47_1)
	local var_47_0 = {}

	_.each(arg_47_1, function(arg_48_0)
		var_47_0[WorldMapCell.GetName(arg_48_0.pos.row, arg_48_0.pos.column)] = {
			pos = {
				row = arg_48_0.pos.row,
				column = arg_48_0.pos.column
			},
			attachmentList = arg_48_0.item_list
		}

		return
	end)

	for iter_47_0, iter_47_1 in pairs(var_47_0) do
		local var_47_1 = {}

		_.each(iter_47_1.attachmentList, function(arg_49_0)
			local var_49_0 = WPool:Get(WorldMapAttachment)

			var_49_0:Setup(setmetatable({
				pos = iter_47_1.pos
			}, {
				__index = arg_49_0
			}))
			table.insert(var_47_1, var_49_0)

			return
		end)

		iter_47_1.attachmentList = var_47_1
	end

	return var_47_0
end

function WorldProxy:UpdateMapAttachmentCells(arg_50_1, arg_50_2)
	local var_50_0 = self.world:GetMap(arg_50_1)

	assert(var_50_0, "map not exist: " .. arg_50_1)

	for iter_50_0, iter_50_1 in pairs(arg_50_2) do
		local var_50_1 = var_50_0:GetCell(iter_50_1.pos.row, iter_50_1.pos.column)

		for iter_50_2 = #var_50_1.attachments, 1, -1 do
			local var_50_2 = var_50_1.attachments[iter_50_2]

			if not WorldMapAttachment.IsFakeType(var_50_1.attachments[iter_50_2].type) and not _.any(iter_50_1.attachmentList, function(arg_51_0)
				return var_50_2.type == arg_51_0.type and var_50_2.id == arg_51_0.id
			end) then
				var_50_1:RemoveAttachment(iter_50_2)
			end
		end

		_.each(iter_50_1.attachmentList, function(arg_52_0)
			if arg_52_0.type ~= WorldMapAttachment.TypeFleet then
				local var_52_0 = _.detect(var_50_1.attachments, function(arg_53_0)
					return arg_53_0.type == arg_52_0.type and arg_53_0.id == arg_52_0.id
				end)

				if var_52_0 then
					var_52_0:UpdateFlag(arg_52_0.flag)
					var_52_0:UpdateData(arg_52_0.data, arg_52_0.effects)
					var_50_0:AddPhaseDisplay(var_52_0:UpdateBuffList(arg_52_0.buffList))
				else
					var_50_1:AddAttachment(arg_52_0)
				end
			end

			return
		end)
	end

	return
end

function WorldProxy:NetBuildFleetAttachUpdate(arg_54_1)
	local var_54_0 = {}

	_.each(arg_54_1, function(arg_55_0)
		local var_55_0 = {
			row = arg_55_0.pos.row,
			column = arg_55_0.pos.column
		}

		_.each(arg_55_0.item_list, function(arg_56_0)
			if arg_56_0.item_type == WorldMapAttachment.TypeFleet then
				local var_56_0 = WPool:Get(NetFleetAttachUpdate)

				var_56_0:Setup(setmetatable({
					pos = var_55_0
				}, {
					__index = arg_56_0
				}))
				table.insert(var_54_0, var_56_0)
			end

			return
		end)

		return
	end)

	return var_54_0
end

function WorldProxy:ApplyFleetAttachUpdate(arg_57_1, arg_57_2)
	local var_57_0 = self.world:GetMap(arg_57_1)

	assert(var_57_0, "map not exist: " .. arg_57_1)
	_.each(arg_57_2, function(arg_58_0)
		var_57_0:UpdateFleetLocation(arg_58_0.id, arg_58_0.row, arg_58_0.column)

		return
	end)

	return
end

function WorldProxy:NetBulidTerrainUpdate(arg_59_1)
	return _.map(arg_59_1, function(arg_60_0)
		local var_60_0 = WPool:Get(NetTerrainUpdate)

		var_60_0:Setup(arg_60_0)

		return var_60_0
	end)
end

function WorldProxy:ApplyTerrainUpdate(arg_61_1, arg_61_2)
	local var_61_0 = self.world:GetMap(arg_61_1)

	assert(var_61_0, "map not exist: " .. arg_61_1)
	_.each(arg_61_2, function(arg_62_0)
		local var_62_0 = var_61_0:GetCell(arg_62_0.row, arg_62_0.column)
		local var_62_1 = var_61_0:FindFleet(var_62_0.row, var_62_0.column)

		if var_62_1 then
			var_61_0:CheckFleetUpdateFOV(var_62_1, function()
				var_62_0:UpdateTerrain(arg_62_0:GetTerrain(), arg_62_0.terrainDir, arg_62_0.terrainStrong)

				return
			end)
		else
			var_62_0:UpdateTerrain(arg_62_0:GetTerrain(), arg_62_0.terrainDir, arg_62_0.terrainStrong)
		end

		return
	end)

	return
end

function WorldProxy:NetBuildFleetUpdate(arg_64_1)
	return _.map(arg_64_1, function(arg_65_0)
		local var_65_0 = WPool:Get(NetFleetUpdate)

		var_65_0:Setup(arg_65_0)

		return var_65_0
	end)
end

function WorldProxy:ApplyFleetUpdate(arg_66_1, arg_66_2)
	local var_66_0 = self.world:GetMap(arg_66_1)

	assert(var_66_0, "map not exist: " .. arg_66_1)
	_.each(arg_66_2, function(arg_67_0)
		local var_67_0 = var_66_0:GetFleet(arg_67_0.id)

		assert(var_67_0, "fleet not exist: " .. arg_67_0.id)
		var_66_0:CheckFleetUpdateFOV(var_67_0, function()
			var_67_0:UpdateBuffs(arg_67_0.buffs)

			return
		end)

		return
	end)

	return
end

function WorldProxy:NetBuildShipUpdate(arg_69_1)
	return _.map(arg_69_1, function(arg_70_0)
		local var_70_0 = WPool:Get(NetShipUpdate)

		var_70_0:Setup(arg_70_0)

		return var_70_0
	end)
end

function WorldProxy:ApplyShipUpdate(arg_71_1)
	_.each(arg_71_1, function(arg_72_0)
		local var_72_0 = self.world:GetShip(arg_72_0.id)

		assert(var_72_0, "ship not exist: " .. arg_72_0.id)
		var_72_0:UpdateHpRant(arg_72_0.hpRant)

		return
	end)

	return
end

function WorldProxy:NetUpdateWorldSairenChapter(arg_73_1)
	self.world:GetAtlas():SetSairenEntranceList((_.rest(arg_73_1, 1)))

	return
end

function WorldProxy:NetUpdateWorldMapPressing(arg_74_1)
	self.world:GetAtlas():SetPressingMarkList((_.rest(arg_74_1, 1)))
	self.world:GetAtlas():InitPortMarkNShopList()

	return
end

function WorldProxy:NetUpdateWorldShopGoods(arg_75_1)
	self.world:InitWorldShopGoods()
	self.world:UpdateWorldShopGoods(arg_75_1)

	return
end

function WorldProxy:NetUpdateWorldPressingAward(arg_76_1)
	local var_76_0 = self.world:GetAtlas()

	_.each(arg_76_1, function(arg_77_0)
		local var_77_0 = {
			id = arg_77_0.award,
			flag = arg_77_0.flag == 1
		}

		self.world.pressingAwardDic[arg_77_0.id] = var_77_0

		if not var_77_0.flag then
			var_76_0:MarkMapTransport(arg_77_0.id)
		end

		return
	end)

	return
end

function WorldProxy:NetUpdateWorldPortShopMark(arg_78_1, arg_78_2)
	self.world:GetAtlas():SetPortMarkList(arg_78_1, arg_78_2)

	return
end

function WorldProxy:NetBuildSalvageUpdate(arg_79_1)
	return _.map(arg_79_1, function(arg_80_0)
		local var_80_0 = WPool:Get(NetSalvageUpdate)

		var_80_0:Setup(arg_80_0)

		return var_80_0
	end)
end

function WorldProxy:ApplySalvageUpdate(arg_81_1)
	_.each(arg_81_1, function(arg_82_0)
		local var_82_0 = self.world:GetFleet(arg_82_0.id)

		assert(var_82_0, "fleet not exit: " .. arg_82_0.id)
		var_82_0:UpdateCatSalvage(arg_82_0.step, arg_82_0.list, arg_82_0.mapId)

		return
	end)

	return
end

return WorldProxy
