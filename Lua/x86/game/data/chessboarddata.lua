local var_0_0 = singletonClass("ChessBoardData")

function var_0_0.Init(arg_1_0)
	arg_1_0.currentMapInfo_ = {}
	arg_1_0.extendMap_ = {}
	arg_1_0.extendThingMap_ = {}
	arg_1_0.jsonMap_ = nil
	arg_1_0.playerattribute_ = {}
	arg_1_0.temporaryData_ = {}
	arg_1_0.serverSendEventPool_ = {}
	arg_1_0.mapWidth_ = 0
	arg_1_0.mapHeight_ = 0
	arg_1_0.curBattlingLevelID_ = 0
	arg_1_0.isFastModule_ = false
end

function var_0_0.GetIsFastModule(arg_2_0)
	return arg_2_0.isFastModule_
end

function var_0_0.ChangeFastModule(arg_3_0)
	if arg_3_0.isFastModule_ then
		arg_3_0.isFastModule_ = false
	else
		arg_3_0.isFastModule_ = true
	end

	return arg_3_0.isFastModule_
end

function var_0_0.SetChessBoardData(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = ChessBoardLevelCfg[arg_4_1]

	arg_4_0.currentMapInfo_.mapId = var_4_0.id_level
	arg_4_0.curBattlingLevelID_ = arg_4_1
	arg_4_0.currentMapInfo_.turn = arg_4_2.turn

	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_2.floor) do
		var_4_1[ChessBoardTools.TwoDToOneD(iter_4_1.pos.x, iter_4_1.pos.z)] = {
			tag = iter_4_1.tag,
			pos = {
				x = iter_4_1.pos.x,
				z = iter_4_1.pos.z
			},
			status = iter_4_1.state or 0,
			rotationY = (iter_4_1.rotation or 0) / 60
		}
	end

	arg_4_0.currentMapInfo_.mapChangeInfo = var_4_1

	local var_4_2 = {}

	for iter_4_2, iter_4_3 in ipairs(arg_4_2.object) do
		var_4_2[ChessBoardTools.TwoDToOneD(iter_4_3.pos.x, iter_4_3.pos.z)] = {
			thingtag = iter_4_3.tag,
			pos = {
				x = iter_4_3.pos.x,
				z = iter_4_3.pos.z
			},
			thingRotationY = (iter_4_3.rotation or 0) / 60
		}
	end

	arg_4_0.currentMapInfo_.thingChangeInfo = var_4_2

	local var_4_3 = {}

	for iter_4_4, iter_4_5 in ipairs(arg_4_2.ban_dir) do
		local var_4_4 = {}

		for iter_4_6, iter_4_7 in ipairs(iter_4_5.ban_dir) do
			table.insert(var_4_4, {
				dir = iter_4_7.direction,
				isHide = iter_4_7.is_hide
			})
		end

		var_4_3[ChessBoardTools.TwoDToOneD(iter_4_5.pos.x, iter_4_5.pos.z)] = {
			pos = {
				x = iter_4_5.pos.x,
				z = iter_4_5.pos.z
			},
			banDirList = var_4_4
		}
	end

	arg_4_0.currentMapInfo_.banDirChangeInfo = var_4_3
	arg_4_0.currentMapInfo_.NPCInfoList = {}

	for iter_4_8, iter_4_9 in ipairs(arg_4_2.hero) do
		if iter_4_9.id == 0 then
			local var_4_5 = {
				id = iter_4_9.id,
				typeID = iter_4_9.type,
				pos = {
					x = iter_4_9.pos.x,
					z = iter_4_9.pos.z
				},
				dir = iter_4_9.direction,
				attribute = {}
			}

			for iter_4_10, iter_4_11 in ipairs(iter_4_9.attribute) do
				var_4_5.attribute[iter_4_11.id] = iter_4_11.value
			end

			var_4_5.itemList = cleanProtoTable(iter_4_9.item)
			var_4_5.tmp_item = cleanProtoTable(iter_4_9.tmp_item)
			var_4_5.buffList = {}

			for iter_4_12, iter_4_13 in ipairs(iter_4_9.buff) do
				local var_4_6 = {
					id = iter_4_13.id,
					duration = iter_4_13.duration,
					effectInfoList = {}
				}

				for iter_4_14, iter_4_15 in ipairs(iter_4_13.buff_effect) do
					table.insert(var_4_6.effectInfoList, {
						effectID = iter_4_15.id,
						triggerNum = iter_4_15.num
					})
				end

				table.insert(var_4_5.buffList, var_4_6)
			end

			var_4_5.curUsedItem = iter_4_9.use_item
			var_4_5.chanceInfo = {}

			if iter_4_9.chance.chance_id > 0 then
				var_4_5.chanceInfo.chanceID = iter_4_9.chance.chance_id
				var_4_5.chanceInfo.isUnLock = iter_4_9.chance.is_unlock
				var_4_5.chanceInfo.chancePropList = cleanProtoTable(iter_4_9.chance.item_list)
				var_4_5.chanceInfo.chanceChooseList = cleanProtoTable(iter_4_9.chance.choose_list)
			else
				var_4_5.chanceInfo.chanceID = 0
				var_4_5.chanceInfo.isUnLock = 0
				var_4_5.chanceInfo.chancePropList = {}
				var_4_5.chanceInfo.chanceChooseList = {}
			end

			arg_4_0.currentMapInfo_.heroInfos = var_4_5
		else
			local var_4_7 = {
				id = iter_4_9.id,
				typeID = iter_4_9.type,
				pos = {
					x = iter_4_9.pos.x,
					z = iter_4_9.pos.z
				},
				dir = iter_4_9.direction,
				attribute = {}
			}

			for iter_4_16, iter_4_17 in ipairs(iter_4_9.attribute) do
				var_4_7.attribute[iter_4_17.id] = iter_4_17.value
			end

			var_4_7.itemList = {}
			var_4_7.buffList = {}

			for iter_4_18, iter_4_19 in ipairs(iter_4_9.buff) do
				local var_4_8 = {
					id = iter_4_19.id,
					duration = iter_4_19.duration,
					effectInfoList = {}
				}

				for iter_4_20, iter_4_21 in ipairs(iter_4_19.buff_effect) do
					table.insert(var_4_8.effectInfoList, {
						effectID = iter_4_21.id,
						triggerNum = iter_4_21.num
					})
				end

				table.insert(var_4_7.buffList, var_4_8)
			end

			arg_4_0.currentMapInfo_.NPCInfoList[var_4_7.id] = var_4_7
		end
	end

	local var_4_9 = {}

	for iter_4_22, iter_4_23 in ipairs(arg_4_2.task) do
		table.insert(var_4_9, {
			taskID = iter_4_23.id,
			progress = iter_4_23.progress
		})
	end

	arg_4_0.currentMapInfo_.taskList = var_4_9
end

function var_0_0.GetCurrentChessBoardMapData(arg_5_0)
	return arg_5_0.currentMapInfo_
end

function var_0_0.GetCurrentChessBoardMapID(arg_6_0)
	if arg_6_0.currentMapInfo_.mapId then
		return arg_6_0.currentMapInfo_.mapId
	else
		return arg_6_0:GetTemporaryData("CurEnterMapID")
	end
end

function var_0_0.SetJsonMap(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.jsonMap_ = arg_7_1
	arg_7_0.extendMap_ = arg_7_2
	arg_7_0.extendThingMap_ = arg_7_3
end

function var_0_0.SetMapWidthAndHeight(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.mapWidth_ = arg_8_1
	arg_8_0.mapHeight_ = arg_8_2
end

function var_0_0.GetMapWidthAndHeight(arg_9_0)
	return arg_9_0.mapWidth_, arg_9_0.mapHeight_
end

function var_0_0.ChangeGridLua(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0.currentMapInfo_.mapChangeInfo[ChessBoardTools.TwoDToOneD(arg_10_1, arg_10_2)]
	local var_10_1

	if var_10_0 then
		if arg_10_3 ~= 0 then
			var_10_1 = ChessBoardTools.CreateChessBoardLuaGridData(arg_10_1, arg_10_2, arg_10_0.extendMap_, arg_10_3)
		else
			var_10_1 = ChessBoardTools.CreateChessBoardLuaGridData(arg_10_1, arg_10_2, arg_10_0.jsonMap_, ChessBoardTools.TwoDToOneD(arg_10_1, arg_10_2))
		end

		var_10_0.direction = var_10_1.direction
		var_10_0.status = var_10_1.status
		var_10_0.attribute = var_10_1.attribute
	elseif arg_10_3 ~= 0 then
		local var_10_2 = ChessBoardTools.CreateChessBoardLuaGridData(arg_10_1, arg_10_2, arg_10_0.extendMap_, arg_10_3)

		var_10_0 = ChessBoardTools.CreateChessBoardLuaGridData(arg_10_1, arg_10_2, arg_10_0.jsonMap_, ChessBoardTools.TwoDToOneD(arg_10_1, arg_10_2))
		var_10_0.direction = var_10_2.direction
		var_10_0.status = var_10_2.status
		var_10_0.attribute = var_10_2.attribute
	else
		var_10_0 = ChessBoardTools.CreateChessBoardLuaGridData(arg_10_1, arg_10_2, arg_10_0.jsonMap_, ChessBoardTools.TwoDToOneD(arg_10_1, arg_10_2))
	end

	var_10_0.tag = arg_10_3
	arg_10_0.currentMapInfo_.mapChangeInfo[ChessBoardTools.TwoDToOneD(arg_10_1, arg_10_2)] = var_10_0
end

function var_0_0.ChangeGridLuaInheritDir(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0.currentMapInfo_.mapChangeInfo[ChessBoardTools.TwoDToOneD(arg_11_1, arg_11_2)]
	local var_11_1

	if var_11_0 then
		if arg_11_3 ~= 0 then
			var_11_1 = ChessBoardTools.CreateChessBoardLuaGridData(arg_11_1, arg_11_2, arg_11_0.extendMap_, arg_11_3)
		else
			var_11_1 = ChessBoardTools.CreateChessBoardLuaGridData(arg_11_1, arg_11_2, arg_11_0.jsonMap_, ChessBoardTools.TwoDToOneD(arg_11_1, arg_11_2))
		end

		var_11_0.direction = var_11_0.direction
		var_11_0.status = var_11_1.status
		var_11_0.attribute = var_11_1.attribute
	elseif arg_11_3 ~= 0 then
		local var_11_2 = ChessBoardTools.CreateChessBoardLuaGridData(arg_11_1, arg_11_2, arg_11_0.extendMap_, arg_11_3)

		var_11_0 = ChessBoardTools.CreateChessBoardLuaGridData(arg_11_1, arg_11_2, arg_11_0.jsonMap_, ChessBoardTools.TwoDToOneD(arg_11_1, arg_11_2))
		var_11_0.direction = var_11_0.direction
		var_11_0.status = var_11_2.status
		var_11_0.attribute = var_11_2.attribute
	else
		var_11_0 = ChessBoardTools.CreateChessBoardLuaGridData(arg_11_1, arg_11_2, arg_11_0.jsonMap_, ChessBoardTools.TwoDToOneD(arg_11_1, arg_11_2))
	end

	var_11_0.tag = arg_11_3
	arg_11_0.currentMapInfo_.mapChangeInfo[ChessBoardTools.TwoDToOneD(arg_11_1, arg_11_2)] = var_11_0
end

function var_0_0.ChangeThingLua(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0.currentMapInfo_.thingChangeInfo[ChessBoardTools.TwoDToOneD(arg_12_1, arg_12_2)]
	local var_12_1

	if var_12_0 then
		if arg_12_3 ~= 0 then
			var_12_1 = ChessBoardTools.CreateChessBoardLuaGridData(arg_12_1, arg_12_2, arg_12_0.extendThingMap_, arg_12_3)
		else
			var_12_1 = ChessBoardTools.CreateChessBoardLuaGridData(arg_12_1, arg_12_2, arg_12_0.jsonMap_, ChessBoardTools.TwoDToOneD(arg_12_1, arg_12_2))
		end

		var_12_0.thingRotationY = var_12_1.thingRotationY
	elseif arg_12_3 ~= 0 then
		local var_12_2 = ChessBoardTools.CreateChessBoardLuaGridData(arg_12_1, arg_12_2, arg_12_0.extendThingMap_, arg_12_3)

		var_12_0 = ChessBoardTools.CreateChessBoardLuaGridData(arg_12_1, arg_12_2, arg_12_0.jsonMap_, ChessBoardTools.TwoDToOneD(arg_12_1, arg_12_2))
		var_12_0.thingRotationY = var_12_2.thingRotationY
	else
		var_12_0 = ChessBoardTools.CreateChessBoardLuaGridData(arg_12_1, arg_12_2, arg_12_0.jsonMap_, ChessBoardTools.TwoDToOneD(arg_12_1, arg_12_2))
	end

	var_12_0.thingtag = arg_12_3
	arg_12_0.currentMapInfo_.thingChangeInfo[ChessBoardTools.TwoDToOneD(arg_12_1, arg_12_2)] = var_12_0
end

function var_0_0.DeleteThingLua(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.currentMapInfo_.thingChangeInfo[ChessBoardTools.TwoDToOneD(arg_13_1, arg_13_2)]

	if var_13_0 then
		-- block empty
	else
		var_13_0 = ChessBoardTools.CreateChessBoardLuaGridData(arg_13_1, arg_13_2, arg_13_0.jsonMap_, ChessBoardTools.TwoDToOneD(arg_13_1, arg_13_2))
	end

	var_13_0.thingtag = -1
	var_13_0.thingRotationY = 0
	arg_13_0.currentMapInfo_.thingChangeInfo[ChessBoardTools.TwoDToOneD(arg_13_1, arg_13_2)] = var_13_0
end

function var_0_0.GetExtendGridJsonData(arg_14_0, arg_14_1)
	return arg_14_0.extendMap_[arg_14_1]
end

function var_0_0.GetExtendThingJsonData(arg_15_0, arg_15_1)
	return arg_15_0.extendThingMap_[arg_15_1]
end

function var_0_0.FixHeroPosAndDir(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.currentMapInfo_.heroInfos.pos = arg_16_1
	arg_16_0.currentMapInfo_.heroInfos.dir = arg_16_2
end

function var_0_0.FixHeroAttribute(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.currentMapInfo_.heroInfos.attribute[arg_17_1] = arg_17_2
end

function var_0_0.FixHeroPropAddProp(arg_18_0, arg_18_1)
	table.insert(arg_18_0.currentMapInfo_.heroInfos.itemList, arg_18_1)
end

function var_0_0.FixHeroTmpAddProp(arg_19_0, arg_19_1)
	table.insert(arg_19_0.currentMapInfo_.heroInfos.tmp_item, arg_19_1)
end

function var_0_0.FixClearTmpProp(arg_20_0)
	arg_20_0.currentMapInfo_.heroInfos.tmp_item = {}
end

function var_0_0.AddTmpProp(arg_21_0, arg_21_1)
	table.insert(arg_21_0.currentMapInfo_.heroInfos.tmp_item, arg_21_1)
end

function var_0_0.FixHeroPropDelProp(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.currentMapInfo_.heroInfos.itemList) do
		if iter_22_1 == arg_22_1 then
			table.remove(arg_22_0.currentMapInfo_.heroInfos.itemList, iter_22_0)

			break
		end
	end
end

function var_0_0.FixHeroChanceData(arg_23_0, arg_23_1)
	arg_23_0.currentMapInfo_.heroInfos.chanceInfo = {}
	arg_23_0.currentMapInfo_.heroInfos.chanceInfo.chanceID = arg_23_1.chanceID
	arg_23_0.currentMapInfo_.heroInfos.chanceInfo.isUnLock = arg_23_1.isUnLock
	arg_23_0.currentMapInfo_.heroInfos.chanceInfo.chancePropList = deepClone(arg_23_1.chancePropList)
	arg_23_0.currentMapInfo_.heroInfos.chanceInfo.chanceChooseList = deepClone(arg_23_1.chanceChooseList)
end

function var_0_0.FixNPCPosAndDir(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_0.currentMapInfo_.NPCInfoList[arg_24_1] == nil then
		return
	else
		arg_24_0.currentMapInfo_.NPCInfoList[arg_24_1].pos = arg_24_2
		arg_24_0.currentMapInfo_.NPCInfoList[arg_24_1].dir = arg_24_3
	end
end

function var_0_0.FixNPCAttribute(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_0.currentMapInfo_.NPCInfoList[arg_25_1] == nil then
		return
	else
		arg_25_0.currentMapInfo_.NPCInfoList[arg_25_1].attribute[arg_25_2] = arg_25_3
	end
end

function var_0_0.FixNPCDataAddNPC(arg_26_0, arg_26_1)
	arg_26_0.currentMapInfo_.NPCInfoList[arg_26_1.id] = arg_26_1
end

function var_0_0.FixNPCDataDeleteNPC(arg_27_0, arg_27_1)
	arg_27_0.currentMapInfo_.NPCInfoList[arg_27_1] = nil
end

function var_0_0.AddServerEvent(arg_28_0, arg_28_1)
	table.insert(arg_28_0.serverSendEventPool_, arg_28_1)
end

function var_0_0.GetServerEvent(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	local var_29_0 = 0

	for iter_29_0, iter_29_1 in pairs(arg_29_0.serverSendEventPool_) do
		if arg_29_1 == iter_29_1.timing then
			if arg_29_3 ~= -1 and arg_29_4 == -1 then
				if arg_29_1 == ChessBoardConst.TIMING.FIRST_ENTER_MAP then
					var_29_0 = iter_29_0

					break
				end

				if (arg_29_1 == ChessBoardConst.TIMING.BUFF_STEP and arg_29_3 == iter_29_1.playerA or arg_29_1 == ChessBoardConst.TIMING.BUFF_DELETE and arg_29_3 == iter_29_1.playerA or arg_29_1 == ChessBoardConst.TIMING.BUFF_ADD and arg_29_3 == iter_29_1.playerA or arg_29_1 == ChessBoardConst.TIMING.BUFF_TURN and arg_29_3 == iter_29_1.playerA or arg_29_1 == ChessBoardConst.TIMING.TASK_FINISH or arg_29_1 == ChessBoardConst.TIMING.MAP_EVENT or arg_29_1 == ChessBoardConst.TIMING.CHANCE_FINISH or arg_29_1 == ChessBoardConst.TIMING.NPC_TURN_START and arg_29_3 == iter_29_1.playerA or arg_29_1 == ChessBoardConst.TIMING.NPC_TURN_END and arg_29_3 == iter_29_1.playerA) and arg_29_2[1] == iter_29_1.timingParams[1] then
					var_29_0 = iter_29_0

					break
				end

				if (arg_29_1 == ChessBoardConst.TIMING.ENTER_FLOOR and arg_29_3 == iter_29_1.playerA or arg_29_1 == ChessBoardConst.TIMING.EXIT_FLOOR and arg_29_3 == iter_29_1.playerA or arg_29_1 == ChessBoardConst.TIMING.START_MOVE_FLOOR and arg_29_3 == iter_29_1.playerA or arg_29_1 == ChessBoardConst.TIMING.END_MOVE_FLOOR and arg_29_3 == iter_29_1.playerA or arg_29_1 == ChessBoardConst.TIMING.ENTER_THING and arg_29_3 == iter_29_1.playerA or arg_29_1 == ChessBoardConst.TIMING.EXIT_THING and arg_29_3 == iter_29_1.playerA or arg_29_1 == ChessBoardConst.TIMING.START_MOVE_THING and arg_29_3 == iter_29_1.playerA or arg_29_1 == ChessBoardConst.TIMING.END_MOVE_THING and arg_29_3 == iter_29_1.playerA) and arg_29_2[1] == iter_29_1.timingParams[1] and arg_29_2[2] == iter_29_1.timingParams[2] then
					var_29_0 = iter_29_0

					break
				end
			end

			if arg_29_3 >= 0 and arg_29_4 >= 0 and (arg_29_1 == ChessBoardConst.TIMING.HERO_CROSS_NPC and arg_29_3 == iter_29_1.playerA and arg_29_4 == iter_29_1.playerB or arg_29_1 == ChessBoardConst.TIMING.NPC_CROSS_HERO and arg_29_3 == iter_29_1.playerA and arg_29_4 == iter_29_1.playerB or arg_29_1 == ChessBoardConst.TIMING.NPC_STAY_NPC and arg_29_3 == iter_29_1.playerA and arg_29_4 == iter_29_1.playerB or arg_29_1 == ChessBoardConst.TIMING.NPC_STAY_HERO and arg_29_3 == iter_29_1.playerA and arg_29_4 == iter_29_1.playerB or arg_29_1 == ChessBoardConst.TIMING.HERO_STAY_NPC and arg_29_3 == iter_29_1.playerA and arg_29_4 == iter_29_1.playerB or arg_29_1 == ChessBoardConst.TIMING.BUFF_NPC_STAY_HERO and arg_29_3 == iter_29_1.playerA and arg_29_4 == iter_29_1.playerB or arg_29_1 == ChessBoardConst.TIMING.BUFF_NPC_CROSS_HERO and arg_29_3 == iter_29_1.playerA and arg_29_4 == iter_29_1.playerB or arg_29_1 == ChessBoardConst.TIMING.BUFF_HERO_STAY_NPC and arg_29_3 == iter_29_1.playerA and arg_29_4 == iter_29_1.playerB or arg_29_1 == ChessBoardConst.TIMING.BUFF_HERO_CROSS_NPC and arg_29_3 == iter_29_1.playerA and arg_29_4 == iter_29_1.playerB) and arg_29_2[1] == iter_29_1.timingParams[1] then
				var_29_0 = iter_29_0

				break
			end
		end
	end

	if var_29_0 ~= 0 then
		local var_29_1 = arg_29_0.serverSendEventPool_[var_29_0].eventList

		arg_29_0.serverSendEventPool_[var_29_0] = nil

		return var_29_1
	end

	trace("timingParams %o", arg_29_2)
	print("timingType", arg_29_1, arg_29_3, arg_29_4)
	error("lrq 触发了服务端没下发的事件！！timing:", arg_29_1, " playerA:", arg_29_3, " playerB:", arg_29_4)

	return nil
end

function var_0_0.SetTemporaryData(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0.temporaryData_[arg_30_1] = arg_30_2
end

function var_0_0.GetTemporaryData(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0.temporaryData_[arg_31_1]

	arg_31_0.temporaryData_[arg_31_1] = nil

	return var_31_0
end

function var_0_0.SetSystemServerData(arg_32_0, arg_32_1)
	arg_32_0.curBattlingLevelID_ = arg_32_1.chapter_id
end

function var_0_0.GetCurrentPlayingChessBoardLevelID(arg_33_0)
	return arg_33_0.curBattlingLevelID_
end

function var_0_0.ClearCurrentPlayingChessBoardLevelID(arg_34_0)
	arg_34_0.curBattlingLevelID_ = 0
end

return var_0_0
