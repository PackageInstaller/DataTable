local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_2 = string
local ProtoHandler = import(".ProtoHandler")

return {
	on_G2C_Login = function(arg_1_0, arg_1_1, arg_1_2)
		if arg_1_2.ret == g.core.network.proto.RET_USER_NOT_EXIST then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_CREATE_ROLE, false, arg_1_1, arg_1_2)
		elseif arg_1_2.ret == g.core.network.proto.RET_LOGIN_REPEAT then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_LOGIN_REPEAT, false, arg_1_1, arg_1_2)
		elseif ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_G2C_LOGIN, false, arg_1_1, arg_1_2)
			g.core.platform.ServerListProxy:saveLastServer((g.core.platform.ServerListProxy:getCurServer()))
		end
	end,
	on_G2C_Activate = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_G2C_ACTIVATE, false, arg_2_1, arg_2_2)
		end
	end,
	on_G2C_Create = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_G2C_CREATE, false, arg_3_1, arg_3_2)
			g.core.common.Setting:loadQualityConfig()
		end
	end,
	on_S2C_IconClick = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			-- block empty
		end
	end,
	on_G2C_KeepAlive = function(arg_5_0, arg_5_1, arg_5_2)
		return
	end,
	on_S2C_SyncTime = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SYNC_TIME, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_SyncProto = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SYNC_PROTO, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_TestPVEBattleBegin = function(arg_8_0, arg_8_1, arg_8_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEST_PV_EBATTLE_BEGIN, false, arg_8_1, arg_8_2)
	end,
	on_S2C_TestPVEBattleFinish = function(arg_9_0, arg_9_1, arg_9_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEST_PV_EBATTLE_FINISH, false, arg_9_1, arg_9_2)
	end,
	on_S2C_ReplyBattleReport = function(arg_10_0, arg_10_1, arg_10_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_REPLY_BATTLE_REPORT, false, arg_10_1, arg_10_2)
	end,
	on_S2C_CheckBattleResult = function(arg_11_0, arg_11_1, arg_11_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CHECK_BATTLE_RESULT, false, arg_11_1, arg_11_2)
	end,
	on_S2C_ClientTestBattle = function(arg_12_0, arg_12_1, arg_12_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CLIENT_TEST_BATTLE, false, arg_12_1, arg_12_2)
	end,
	_getOpObjectDic = function(arg_13_0, arg_13_1)
		local var_13_0 = {}
		local var_13_1 = {}

		for iter_13_0, iter_13_1 in pairs(arg_13_1) do
			for iter_13_2, iter_13_3 in ipairs(iter_13_1) do
				if var_0_1.KNIGHT_SOURCE_TYPE[iter_13_3.source] == var_0_1.KNIGHT_SOURCE_BLAZING_ARENA then
					var_13_1[iter_13_0] = var_13_1[iter_13_0] or {}

					table.insert(var_13_1[iter_13_0], iter_13_3)
				elseif var_0_1.KNIGHT_SOURCE_TYPE[iter_13_3.source] == var_0_1.KNIGHT_SOURCE_MAIN then
					var_13_0[iter_13_0] = var_13_0[iter_13_0] or {}

					table.insert(var_13_0[iter_13_0], iter_13_3)
				end
			end
		end

		return var_13_0, var_13_1
	end,
	on_S2C_OpObject = function(self, arg_14_1, arg_14_2)
		if arg_14_2.dress then
			g.core.model.User.dressData:isActiveHandBook(arg_14_2)
		end

		if arg_14_2.unite_token then
			local var_14_0, var_14_1 = self:_getOpObjectDic(arg_14_2.unite_token)

			if var_14_0.del then
				local var_14_2 = {}

				for iter_14_0, iter_14_1 in ipairs(var_14_0.del) do
					var_14_2[#var_14_2 + 1] = iter_14_1.id
				end

				var_14_0.del = var_14_2
			end

			self:_uniteTokenDataChange(arg_14_1, var_14_0)
			g.core.model.User.blazingArenaData:dealHelpMembers(g.core.common.Goods.TYPE_UNITETOKEN, var_14_1)

			if var_14_0.insert then
				g.core.model.User.activityCollectData:updateCollectProgress({
					type = g.core.common.Goods.TYPE_UNITETOKEN,
					sData = var_14_0.insert
				})
			end

			arg_14_2.unite_token = var_14_0
		end

		if arg_14_2.pet then
			local var_14_3, var_14_4 = self:_getOpObjectDic(arg_14_2.pet)

			if var_14_3.del then
				local var_14_5 = {}

				for iter_14_2, iter_14_3 in ipairs(var_14_3.del) do
					var_14_5[#var_14_5 + 1] = iter_14_3.id
				end
			end

			arg_14_2.pet = var_14_3

			g.core.model.User.blazingArenaData:dealHelpMembers(g.core.common.Goods.TYPE_PET, var_14_4)
		end

		if arg_14_2.red_packet then
			self:_redPacketDataChange(arg_14_1, arg_14_2.red_packet)
		end

		if arg_14_2.knight then
			arg_14_2.knight = self:_checkKnightOpObject(arg_14_2.knight)
		end

		local var_14_6 = false

		for iter_14_4, iter_14_5 in pairs(arg_14_2) do
			if type(iter_14_5) == "table" then
				local var_14_7 = var_0_0.BAG_TYPE[var_0_2.upper(iter_14_4)]

				if var_14_7 then
					var_14_6 = iter_14_5.insert and checkbool(#iter_14_5.insert > 0) or false

					if var_14_7 == var_0_0.BAG_TYPE.ITEM then
						g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NEWITEM_GET_NTF, false, iter_14_5.insert)
					end

					g.core.model.User.bagData:addList(var_14_7, iter_14_5.insert)
					g.core.model.User.bagData:updateList(var_14_7, iter_14_5.update)
					g.core.model.User.bagData:removeList(var_14_7, iter_14_5.del)

					if var_14_7 == var_0_0.BAG_TYPE.SKIN then
						g.core.model.User.userAvatarFrameData:onS2COpObjectSkin(iter_14_5.insert)
					end
				end
			end
		end

		if var_14_6 then
			g.core.model.User.bagData:checkNewData()
		end

		if arg_14_2.knight then
			g.core.model.User.recruitData:addNewKnightId(arg_14_2)
			g.core.model.User.rebornData:updateKnightRed()

			if arg_14_2.knight.insert then
				g.core.model.User.activityCollectData:updateCollectProgress({
					type = g.core.common.Goods.TYPE_KNIGHT,
					sData = arg_14_2.knight.insert
				})
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK_PREDESTINATION_TICKED)
				g.core.model.User.userAvatarFrameData:onS2COpObjectKnight(arg_14_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHANGE_KNIGHT, false, arg_14_1, arg_14_2.knight)
		end

		if arg_14_2.unite_token then
			g.core.model.User.recruitData:addNewUniteToken(arg_14_2)
		end

		if arg_14_2.equipment then
			g.core.model.User.equipmentData:updateEquipInfo()
			g.core.model.User.rebornData:updateDecomposeEquipRed()

			if arg_14_2.equipment.del then
				g.core.model.User.equipmentData:removeEquipment(arg_14_2.equipment.del)
			end
		end

		if arg_14_2.resource then
			g.core.model.User.resourceData:updateData((g.core.model.User.bagData:getList(var_0_0.BAG_TYPE.RESOURCE)))
			g.core.model.User.kingdomDataNew:checkMainActive()
			g.core.model.User.kingdomDataNew:checkBioActive()
		end

		if arg_14_2.treasure then
			g.core.model.User.treasureData:setTreasureRedState(arg_14_2.treasure)
			g.core.model.User.treasureData:updateTreasureFormation()
			g.core.model.User.treasureData:updateAddTreasure(arg_14_2.treasure)
		end

		if arg_14_2.user then
			g.core.model.User:updateData(arg_14_2.user)
			g.core.model.User.spiritHelpData:updateBattleSpeed()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RECV_ROLE_INFO, false, arg_14_1, arg_14_2)
			g.core.model.User:updateWithLevelChange()
		end

		if arg_14_2.artifact then
			if arg_14_2.artifact.del then
				g.core.model.User.artifactData:removeArtifact(arg_14_2.artifact.del)
			end

			g.core.model.User.artifactData:updateArtifactData()
			g.core.model.User.recruitData:addNewArtifact(arg_14_2)
		end

		if arg_14_2.pet then
			local var_14_8, var_14_9 = self:_getOpObjectDic(arg_14_2.pet)

			if var_14_8.del then
				local var_14_10 = {}

				for iter_14_6, iter_14_7 in ipairs(var_14_8.del) do
					var_14_10[#var_14_10 + 1] = iter_14_7.id
				end

				g.core.model.User.petsData:onS2CDelPet(var_14_10)
			end

			g.core.model.User.petsData:onS2CUpdatePets()
			g.core.model.User.recruitData:addNewPet(var_14_8)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHANGE_PET, false, arg_14_1, var_14_8)
		end

		if arg_14_2.card then
			if arg_14_2.card.insert then
				g.core.model.User.bagData:addList(var_0_0.BAG_TYPE.INCARNATIIN, arg_14_2.card.insert or {})
			end

			if arg_14_2.card.update then
				g.core.model.User.bagData:updateList(var_0_0.BAG_TYPE.INCARNATIIN, arg_14_2.card.update or {})
			end
		end

		if arg_14_2.cardcompose then
			if arg_14_2.cardcompose.insert then
				g.core.model.User.incarnationData:addCardComposition(arg_14_2.cardcompose.insert)
			end

			if arg_14_2.cardcompose.update then
				-- block empty
			end
		end

		if arg_14_2.wing then
			if arg_14_2.wing.update then
				g.core.model.User.bagData:updateWingData(arg_14_2.wing.update[1])
				g.core.model.User.wingData:updateWing(arg_14_2.wing.update[1])
			end
		end

		if arg_14_2.refines then
			if arg_14_2.refines.update then
				g.core.model.User.wingData:udpateRefineList(arg_14_2.refines.update)
			end
		end

		if arg_14_2.pet_equipment then
			g.core.model.User.petEquipData:updateAllPetEquip()

			if arg_14_2.pet_equipment.del then
				g.core.model.User.petEquipData:removePetEquips(arg_14_2.pet_equipment.del or {})
			end

			if arg_14_2.pet_equipment.insert then
				g.core.model.User.petEquipData:setPetEquipsInAwards(arg_14_2.pet_equipment.insert)
			end
		end

		if arg_14_2.halidom_bag then
			g.core.model.User.gveDataMgr:getGveBagData():updateHalidomItems(arg_14_2.halidom_bag)
		end

		if arg_14_2.kSoul then
			g.core.model.User.knightSoulData:updateWishCompleteMapByOpData(arg_14_2.kSoul)
			g.core.model.User.recruitData:addNewKnightSoul(arg_14_2)
		end

		if arg_14_2.precious then
			g.core.model.User.preciousData:updateOpPrecious(arg_14_2.precious)
			g.core.model.User.recruitData:addNewPrecious(arg_14_2)
		end

		if arg_14_2.skin_part then
			g.core.model.User.roleSkinData:onS2CRoleSkinOpObject(arg_14_2.skin_part)
		end

		if arg_14_2.succuba then
			g.core.model.User.succubaData:onS2CSuccubaOpObject(arg_14_2.succuba)
		end

		if arg_14_2.outpost_item then
			g.core.model.User.outpostData:onS2COpObject(arg_14_2.outpost_item)
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, false, arg_14_1, arg_14_2)
	end,
	_checkKnightOpObject = function(self, arg_15_1)
		local var_15_0 = {}

		for iter_15_0, iter_15_1 in pairs(arg_15_1) do
			local var_15_1 = {}
			local var_15_2 = {}

			var_15_0[iter_15_0] = var_15_0[iter_15_0] or {}

			for iter_15_2, iter_15_3 in ipairs(iter_15_1) do
				if type(iter_15_3) ~= "table" then
					table.insert(var_15_0[iter_15_0], iter_15_3)
					table.insert(var_15_2, iter_15_3)
				else
					local var_15_3 = iter_15_3.source_type

					if iter_15_3.source_type == 0 then
						table.insert(var_15_0[iter_15_0], iter_15_3)
					else
						local var_15_4 = var_0_1.KNIGHT_SOURCE_TYPE[var_15_3]

						if var_0_1.KNIGHT_SOURCE_TYPE[var_15_3] then
							var_15_1[var_15_4] = var_15_1[var_15_4] or {}

							table.insert(var_15_1[var_15_4], iter_15_3)
						end
					end
				end
			end

			if next(var_15_2) then
				self:_updateKnightPool(var_0_1.KNIGHT_SOURCE_GVE, var_15_2, iter_15_0)
				self:_updateKnightPool(var_0_1.KNIGHT_SOURCE_EXPLORATION, var_15_2, iter_15_0)
				self:_updateKnightPool(var_0_1.KNIGHT_SOURCE_TEAM_BATTLE, var_15_2, iter_15_0)
			end

			for iter_15_4, iter_15_5 in pairs(var_15_1) do
				self:_updateKnightPool(iter_15_4, iter_15_5, iter_15_0)
			end
		end

		return var_15_0
	end,
	_updateKnightPool = function(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
		if arg_16_1 == var_0_1.KNIGHT_SOURCE_FOG then
			g.core.model.User.fogNightmareData:getFormationData():addPoolMember(arg_16_2, arg_16_3)
		elseif arg_16_1 == var_0_1.KNIGHT_SOURCE_GVE then
			g.core.model.User.gveDataMgr:getGveFormationData():addPoolMember(arg_16_2, arg_16_3)
		elseif arg_16_1 == var_0_1.KNIGHT_SOURCE_EXPLORATION then
			g.core.model.User.explorationData:getFormationData():addPoolMemberKnight(arg_16_2, arg_16_3)
		elseif arg_16_1 == var_0_1.KNIGHT_SOURCE_TEAM_BATTLE then
			g.core.model.User.teamBattleData:getFormationData():addPoolMemberKnight(arg_16_2, arg_16_3)
		end
	end,
	_uniteTokenDataChange = function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_2.insert ~= nil then
			g.core.model.User.uniteTokenData:addToUniteTokenList(arg_17_2.insert)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_UNITE_TOKEN, false, arg_17_1, arg_17_2)
		end

		if arg_17_2.update ~= nil then
			g.core.model.User.uniteTokenData:opUpdateUniteToken(arg_17_2.update)
		end
	end,
	_redPacketDataChange = function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_2.insert ~= nil then
			g.core.model.User.redPacketData:insertUseList(arg_18_2.insert)
		end

		if arg_18_2.update ~= nil then
			g.core.model.User.redPacketData:updateUseList(arg_18_2.update)
		end

		if arg_18_2.del ~= nil then
			g.core.model.User.redPacketData:delUseList(arg_18_2.del)
		end
	end,
	on_S2C_Test = function(arg_19_0, arg_19_1, arg_19_2)
		if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEST, false, arg_19_1, arg_19_2)
		end
	end,
	on_S2C_FlushUser = function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_2.user then
			g.core.model.User:updateData(arg_20_2.user)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RECV_ROLE_INFO, false, arg_20_1, arg_20_2)
		end
	end,
	on_S2C_OpRetrieveRes = function(arg_21_0, arg_21_1, arg_21_2)
		return
	end,
	on_S2C_GetUserDetailInfo = function(arg_22_0, arg_22_1, arg_22_2)
		if ProtoHandler:onMsgProcess(arg_22_1, arg_22_2) then
			g.core.model.User.friendData:onUserDetailInfoBack(arg_22_2)
			g.core.model.User.playerInfoData:onS2CGetInfo(arg_22_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_USER_DETAIL_INFO, false, arg_22_1, arg_22_2)
		end
	end,
	on_S2C_Flush = function(arg_23_0, arg_23_1, arg_23_2)
		local var_23_0 = false
		local var_23_1 = false

		for iter_23_0, iter_23_1 in pairs(arg_23_2) do
			if type(iter_23_1) == "table" then
				var_23_1 = true

				local var_23_2 = var_0_2.upper(var_0_2.sub(iter_23_0, 1, -2))
				local var_23_3 = var_0_2.upper(var_0_2.sub(iter_23_0, 1, -3))

				print("on_S2C_Flush", var_23_2)

				if var_0_0.BAG_TYPE[var_23_2] then
					var_23_0 = true

					g.core.model.User.bagData:initList(var_0_0.BAG_TYPE[var_23_2], iter_23_1)
				elseif var_0_0.BAG_TYPE[var_23_3] then
					g.core.model.User.bagData:initList(var_0_0.BAG_TYPE[var_23_3], iter_23_1)
				end
			end
		end

		if not var_23_1 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FLUSH, false, arg_23_1, arg_23_2)

			return
		end

		if var_23_0 then
			g.core.model.User.bagData:checkNewList()
			g.core.model.User.bagData:checkNewData()
		end

		if arg_23_2.random_players then
			g.core.model.User.playerData:updatePlayerInfo(arg_23_2.random_players)
		end

		if arg_23_2.formations then
			g.core.model.User.formationData:updateFormation(arg_23_2.formations)
		end

		g.core.model.User.resourceData:updateData((g.core.model.User.bagData:getList(var_0_0.BAG_TYPE.RESOURCE)))
		g.core.model.User.uniteTokenData:updateTokenData()
		g.core.model.User.equipmentData:updateEquipInfo()
		g.core.model.User.treasureData:updateTreasureFormation()
		g.core.model.User.knightsData:updateKnightInfo()
		g.core.model.User.formationData:initActiveData(arg_23_2.formations)

		if arg_23_2.red_packets then
			g.core.model.User.redPacketData:initUseList(arg_23_2.red_packets)
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FLUSH, false, arg_23_1, arg_23_2)
	end,
	on_S2C_FlushKnight = function(arg_24_0, arg_24_1, arg_24_2)
		local var_24_0 = {}
		local var_24_1 = {}
		local var_24_2 = {}
		local var_24_3 = {}
		local var_24_4 = {}

		for iter_24_0, iter_24_1 in ipairs(arg_24_2.knights) do
			if var_0_1.KNIGHT_SOURCE_TYPE[iter_24_1.source_type] == var_0_1.KNIGHT_SOURCE_MAIN then
				table.insert(var_24_0, iter_24_1)

				local var_24_5 = g.core.config.knight_info.fetch(iter_24_1.base_id)

				if var_24_5 then
					g.core.model.User.weddingData:checkRelatedWeddingAdvance(var_24_5.advance_id)
				end
			elseif var_0_1.KNIGHT_SOURCE_TYPE[iter_24_1.source_type] == var_0_1.KNIGHT_SOURCE_FOG then
				table.insert(var_24_1, iter_24_1)
			elseif var_0_1.KNIGHT_SOURCE_TYPE[iter_24_1.source_type] == var_0_1.KNIGHT_SOURCE_GVE then
				table.insert(var_24_2, iter_24_1)
			elseif var_0_1.KNIGHT_SOURCE_TYPE[iter_24_1.source_type] == var_0_1.KNIGHT_SOURCE_EXPLORATION then
				table.insert(var_24_3, iter_24_1)
			elseif var_0_1.KNIGHT_SOURCE_TYPE[iter_24_1.source_type] == var_0_1.KNIGHT_SOURCE_TEAM_BATTLE then
				table.insert(var_24_4, iter_24_1)
			end
		end

		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.KNIGHT, var_24_0)
		g.core.model.User.bagData:checkNewList()
		g.core.model.User.bagData:checkNewData()
		g.core.model.User.knightsData:updateKnightInfo()
		g.core.model.User.rebornData:updateKnightRed()
		g.core.model.User.fogNightmareData:getFormationData():addPoolMember(var_24_1, "insert")
		g.core.model.User.gveDataMgr:getGveFormationData():addPoolMember(var_24_2, "insert")
		g.core.model.User.explorationData:getFormationData():addPoolMemberKnight(var_24_3, "insert")
		g.core.model.User.teamBattleData:getFormationData():addPoolMemberKnight(var_24_4, "insert")
	end,
	on_S2C_FlushEquipment = function(arg_25_0, arg_25_1, arg_25_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.EQUIPMENT, arg_25_2.equipments)
		g.core.model.User.equipmentData:updateEquipInfo()
		g.core.model.User.rebornData:updateDecomposeEquipRed()
	end,
	on_S2C_FlushTreasure = function(arg_26_0, arg_26_1, arg_26_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.TREASURE, arg_26_2.treasures)
	end,
	on_S2C_FlushFragment = function(arg_27_0, arg_27_1, arg_27_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.FRAGMENT, arg_27_2.fragments)
	end,
	on_S2C_FlushResource = function(arg_28_0, arg_28_1, arg_28_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.RESOURCE, arg_28_2.resources)
		g.core.model.User.resourceData:updateData((g.core.model.User.bagData:getList(var_0_0.BAG_TYPE.RESOURCE)))
		g.core.model.User.kingdomDataNew:checkMainActive()
		g.core.model.User.kingdomDataNew:checkBioActive()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FLUSH_RESOURCE, false, arg_28_1, arg_28_2)
	end,
	on_S2C_FlushFormation = function(arg_29_0, arg_29_1, arg_29_2)
		if arg_29_2.formations then
			g.core.model.User.formationData:updateFormation(arg_29_2.formations)
			g.core.model.User.treasureData:updateTreasureFormation()
			g.core.model.User.formationData:initActiveData(arg_29_2.formations)
			g.core.model.User.rebornData:updateKnightRed()
			g.core.model.User.rebornData:updateDecomposeEquipRed()
		end
	end,
	on_S2C_FlushItem = function(arg_30_0, arg_30_1, arg_30_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.ITEM, arg_30_2.items)
		g.core.model.User.bagData:loadNewObtain()
	end,
	on_S2C_FlushExpirableItem = function(arg_31_0, arg_31_1, arg_31_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.EXPIRABLE_ITEM, arg_31_2.items)
		g.core.model.User.bagData:loadNewObtain()
	end,
	on_S2C_FlushAdvanceEquipment = function(arg_32_0, arg_32_1, arg_32_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.ADVANCE_EQUIPMENT, arg_32_2.advance_equipments)
	end,
	on_S2C_FlushUniteToken = function(arg_33_0, arg_33_1, arg_33_2)
		local var_33_0 = {}
		local var_33_1 = {}

		for iter_33_0, iter_33_1 in ipairs(arg_33_2.unite_tokens) do
			if var_0_1.KNIGHT_SOURCE_TYPE[iter_33_1.source] == var_0_1.KNIGHT_SOURCE_BLAZING_ARENA then
				table.insert(var_33_1, iter_33_1)
			elseif var_0_1.KNIGHT_SOURCE_TYPE[iter_33_1.source] == var_0_1.KNIGHT_SOURCE_MAIN then
				table.insert(var_33_0, iter_33_1)
			end
		end

		if #var_33_0 > 0 then
			g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.UNITE_TOKEN, var_33_0)
			g.core.model.User.bagData:checkNewList()
			g.core.model.User.bagData:checkNewData()
			g.core.model.User.uniteTokenData:updateTokenData()
		end

		if #var_33_1 > 0 then
			g.core.model.User.blazingArenaData:updateHelpMembers(g.core.common.Goods.TYPE_UNITETOKEN, var_33_1)
		end
	end,
	on_S2C_FlushDress = function(arg_34_0, arg_34_1, arg_34_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.DRESS, arg_34_2.dresses)
	end,
	on_S2C_FlushRedPacket = function(arg_35_0, arg_35_1, arg_35_2)
		if arg_35_2.red_packets then
			g.core.model.User.redPacketData:initUseList(arg_35_2.red_packets)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FLUSH, false, arg_35_1, arg_35_2)
		end
	end,
	on_S2C_FlushRandomPlayer = function(arg_36_0, arg_36_1, arg_36_2)
		if arg_36_2.random_players then
			-- block empty
		end
	end,
	on_S2C_FlushBiographyItem = function(arg_37_0, arg_37_1, arg_37_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.BIOGRAPHY_ITEM, arg_37_2.biography_items)
	end,
	on_S2C_FlushThemeBioItem = function(arg_38_0, arg_38_1, arg_38_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.THEME_BIO_ITEM, arg_38_2.items)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FLUSH_THEME_BIO_ITEM, false, arg_38_1, arg_38_2)
	end,
	on_S2C_FlushSkin = function(arg_39_0, arg_39_1, arg_39_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.SKIN, arg_39_2.skins)

		local var_39_0 = {}

		for iter_39_0, iter_39_1 in ipairs((g.core.model.User.skinData:checkRelatedSkinAdvance())) do
			var_39_0[#var_39_0 + 1] = iter_39_1
		end

		if #var_39_0 > 0 then
			g.core.common.Scheduler:newScheduleOnce(function()
				g.core.network.GameNetProxy:send_C2S_Skin_AdvanceCheck({
					advance_ids = var_39_0
				})
			end, 10)
		end
	end,
	on_S2C_FlushArtifact = function(arg_41_0, arg_41_1, arg_41_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.ARTIFACT, arg_41_2.artifacts)
		g.core.model.User.artifactData:updateArtifactData()
	end,
	on_S2C_FlushPet = function(arg_42_0, arg_42_1, arg_42_2)
		local var_42_0 = {}
		local var_42_1 = {}

		for iter_42_0, iter_42_1 in ipairs(arg_42_2.pets) do
			if var_0_1.KNIGHT_SOURCE_TYPE[iter_42_1.source] == var_0_1.KNIGHT_SOURCE_BLAZING_ARENA then
				table.insert(var_42_1, iter_42_1)
			elseif var_0_1.KNIGHT_SOURCE_TYPE[iter_42_1.source] == var_0_1.KNIGHT_SOURCE_MAIN then
				table.insert(var_42_0, iter_42_1)
			end
		end

		if #var_42_0 > 0 then
			g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.PET, var_42_0)
			g.core.model.User.petsData:onS2CUpdatePets()
		end

		if #var_42_1 > 0 then
			g.core.model.User.blazingArenaData:updateHelpMembers(g.core.common.Goods.TYPE_PET, var_42_1)
		end
	end,
	on_S2C_FlushWing = function(arg_43_0, arg_43_1, arg_43_2)
		if arg_43_2.wing then
			g.core.model.User.bagData:updateWingData(arg_43_2.wing[1])
		end

		g.core.model.User.wingData:flushWing(arg_43_2)
	end,
	on_S2C_FlushKSoul = function(arg_44_0, arg_44_1, arg_44_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.KSOUL, arg_44_2.kSouls)
	end,
	on_S2C_FlushFavorabilityItem = function(arg_45_0, arg_45_1, arg_45_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.FAVORABILITY_ITEM, arg_45_2.favorability_item)
	end,
	on_S2C_FlushFurnishing = function(arg_46_0, arg_46_1, arg_46_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.FURNISHING, arg_46_2.furnishings)
	end,
	on_S2C_FlushSkinPart = function(arg_47_0, arg_47_1, arg_47_2)
		g.core.model.User.roleSkinData:initList(arg_47_2)
	end,
	on_S2C_GetCommonRankList = function(arg_48_0, arg_48_1, arg_48_2)
		if ProtoHandler:onMsgProcess(arg_48_1, arg_48_2) then
			if arg_48_2.id == g.core.network.proto.RECRUIT_KNIGHT or arg_48_2.id == g.core.network.proto.RECRUIT_KNIGHT_GM then
				g.core.model.User.goldRecruitData:updateRankData(arg_48_2)
			elseif arg_48_2.id == g.core.network.proto.ORDER_WORLD_SCORE_LOCAL or arg_48_2.id == g.core.network.proto.ORDER_WORLD_SCORE_CROSS then
				g.core.model.User.commanderWorldData:updateRankInfos(arg_48_2)
			elseif arg_48_2.id == g.core.network.proto.RECRUIT_RICHEST or arg_48_2.id == g.core.network.proto.RECRUIT_RICHEST_GM then
				g.core.model.User.richData:updateRankData(arg_48_2)
			elseif arg_48_2.id == g.core.network.proto.GROUP_BATTLE_HONOR_CROSS then
				g.core.model.User.teamPvpData:onS2CCommonRankList(arg_48_2)
			elseif arg_48_2.id == g.core.network.proto.PEAK_ARENA_SCORE_LOCAL or arg_48_2.id == g.core.network.proto.PEAK_ARENA_SCORE_CROSS or arg_48_2.id == g.core.network.proto.PEAK_ARENA_SCORE_ALL_SERVER then
				g.core.model.User.peakArenaData:onS2CGetCommonRankList(arg_48_2)
			elseif arg_48_2.id == g.core.network.proto.KSOUL_HONOR_LOCAL or arg_48_2.id == g.core.network.proto.KSOUL_HONOR_CROSS then
				g.core.model.User.knightSoulData:onS2CGetCommonRankList(arg_48_2)
			elseif arg_48_2.id == g.core.network.proto.GUILD_BATTLE_SCORE_CROSS then
				g.core.model.User.GuildFightData:resRankList(arg_48_2)
			elseif arg_48_2.id == g.core.network.proto.TOWER_MAIN or arg_48_2.id == g.core.network.proto.TOWER_EMPIRE or arg_48_2.id == g.core.network.proto.TOWER_BIFROST or arg_48_2.id == g.core.network.proto.TOWER_EASTRISE or arg_48_2.id == g.core.network.proto.TOWER_NEBU then
				g.core.model.User.towerData:resRankList(arg_48_2)
			elseif arg_48_2.id == g.core.network.proto.TOWER_MAIN_DIFF or arg_48_2.id == g.core.network.proto.TOWER_EMPIRE_DIFF or arg_48_2.id == g.core.network.proto.TOWER_BIFROST_DIFF or arg_48_2.id == g.core.network.proto.TOWER_EASTRISE_DIFF or arg_48_2.id == g.core.network.proto.TOWER_NEBU_DIFF then
				g.core.model.User.towerHardData:resRankList(arg_48_2)
			elseif arg_48_2.id == g.core.network.proto.GUILD_WAR_PRACTICE_SCORE_CROSS or arg_48_2.id == g.core.network.proto.GUILD_WAR_GUILD_CROSS_KING or arg_48_2.id == g.core.network.proto.GUILD_WAR_GUILD_CROSS_MASTER or arg_48_2.id == g.core.network.proto.GUILD_WAR_GUILD_CROSS_ELITE then
				g.core.model.User.guildWarData:onS2CCommonRankList(arg_48_2)
			elseif arg_48_2.id == g.core.network.proto.FOG_CROSS_AREA then
				g.core.model.User.fogNightmareData:onS2CCommonRankList(arg_48_2)
			elseif arg_48_2.id == g.core.network.proto.DEAD_TOWER_LOCAL then
				g.core.model.User.wushTowerData:onS2CGetCommonRankList(arg_48_2)
			elseif arg_48_2.id == g.core.network.proto.EXPLORATION_PASS_CROSS or arg_48_2.id == g.core.network.proto.EXPLORATION_BOSS_USER_CROSS or arg_48_2.id == g.core.network.proto.EXPLORATION_BOSS_GUILD_CROSS then
				g.core.model.User.explorationData:onS2CGetCommonRankList(arg_48_2)
			elseif arg_48_2.id == g.core.network.proto.CHIBI_ACHIEVEMENT_CROSS or arg_48_2.id == g.core.network.proto.CHIBI_ACHIEVEMENT_ALL_SERVER then
				g.core.model.User.redCliffData:onS2CCommonRankList(arg_48_2)
			elseif arg_48_2.id == g.core.network.proto.PUBG_USER_SCORE_CROSS then
				g.core.model.User.pubgData:onS2CCommonRankList(arg_48_2)
			elseif arg_48_2.id == g.core.network.proto.SPIRE_SCORE_LOCAL or arg_48_2.id == g.core.network.proto.SPIRE_SCORE_CROSS then
				g.core.model.User.spireData:onS2CCommonRankList(arg_48_2)
			elseif arg_48_2.id == g.core.network.proto.ELDER_BOSS_MAX_HONOR_WATER or arg_48_2.id == g.core.network.proto.ELDER_BOSS_MAX_HONOR_FIRE or arg_48_2.id == g.core.network.proto.ELDER_BOSS_MAX_HONOR_WIND or arg_48_2.id == g.core.network.proto.ELDER_BOSS_MAX_HONOR_THUNDER or arg_48_2.id == g.core.network.proto.ELDER_BOSS_MAX_HONOR_EARTH or arg_48_2.id == g.core.network.proto.ELDER_BOSS_TOTAL_HONOR_WATER or arg_48_2.id == g.core.network.proto.ELDER_BOSS_TOTAL_HONOR_FIRE or arg_48_2.id == g.core.network.proto.ELDER_BOSS_TOTAL_HONOR_WIND or arg_48_2.id == g.core.network.proto.ELDER_BOSS_TOTAL_HONOR_THUNDER or arg_48_2.id == g.core.network.proto.ELDER_BOSS_TOTAL_HONOR_EARTH or arg_48_2.id == g.core.network.proto.ELDER_BOSS_GUILD_HONOR then
				g.core.model.User.elderBossData:onS2CCommonRankList(arg_48_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, false, arg_48_1, arg_48_2)
		end
	end,
	on_S2C_GetCommonPlayNum = function(arg_49_0, arg_49_1, arg_49_2)
		if ProtoHandler:onMsgProcess(arg_49_1, arg_49_2) then
			g.core.model.User.shopData:initPlayInfo(arg_49_2.infos)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_PLAY_NUM, false, arg_49_1, arg_49_2)
		end
	end,
	on_S2C_BuyCommonPlayNum = function(arg_50_0, arg_50_1, arg_50_2)
		if ProtoHandler:onMsgProcess(arg_50_1, arg_50_2) then
			g.core.model.User.shopData:updatePlayInfo(arg_50_2.info)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BUY_COMMON_PLAY_NUM, false, arg_50_1, arg_50_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM, false, arg_50_1, arg_50_2)
		end
	end,
	on_S2C_FlushCommonPlayNum = function(arg_51_0, arg_51_1, arg_51_2)
		if ProtoHandler:onMsgProcess(arg_51_1, arg_51_2) then
			g.core.model.User.shopData:updatePlayInfo(arg_51_2.info)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM, false, arg_51_1, arg_51_2)
		end
	end,
	on_S2C_Sell = function(arg_52_0, arg_52_1, arg_52_2)
		if ProtoHandler:onMsgProcess(arg_52_1, arg_52_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SELL, false, arg_52_1, arg_52_2)
		end
	end,
	on_S2C_GetModuleTaskInfo = function(arg_53_0, arg_53_1, arg_53_2)
		if ProtoHandler:onMsgProcess(arg_53_1, arg_53_2) then
			g.core.model.User.taskData:onS2CGetModuleTaskInfo(arg_53_2)

			if var_0_0.TaskConst.MODULE_ID.ARENA == arg_53_2.module_id then
				g.core.model.User.arenaData:initDailyTaskList(arg_53_2)
			elseif var_0_0.TaskConst.MODULE_ID.CROSS_SERVER_ARENA == arg_53_2.module_id then
				g.core.model.User.crossServerArenaData:initDailyTaskList(arg_53_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_INFO, false, arg_53_1, arg_53_2)
		end
	end,
	on_S2C_GetModuleTaskAward = function(arg_54_0, arg_54_1, arg_54_2)
		if ProtoHandler:onMsgProcess(arg_54_1, arg_54_2) then
			g.core.model.User.taskData:onS2CGetModuleTaskAward(arg_54_2.task_id)
			g.core.model.User.arenaData:onS2CGetModuleTaskAward(arg_54_2.task_id)
			g.core.model.User.crossServerArenaData:onS2CGetModuleTaskAward(arg_54_2.task_id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, false, arg_54_1, arg_54_2)
		end
	end,
	on_S2C_GetModuleOneKeyTaskAward = function(arg_55_0, arg_55_1, arg_55_2)
		if ProtoHandler:onMsgProcess(arg_55_1, arg_55_2) then
			g.core.model.User.taskData:onS2CGetModuleOneKeyTaskAward(arg_55_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_ONE_KEY_TASK_AWARD, false, arg_55_1, arg_55_2)
		end
	end,
	on_S2C_ActionStatusFlush = function(arg_56_0, arg_56_1, arg_56_2)
		if ProtoHandler:onMsgProcess(arg_56_1, arg_56_2) then
			if arg_56_2.tp == g.core.network.proto.STATUS_ACHIEVEMENT then
				g.core.model.User.achievementData:onS2CActionStatusFlush(arg_56_2.status)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_SHOP then
				if arg_56_2.status.id == 1009 then
					g.core.model.User.robTreasureData:updateComposeRedTotal(arg_56_2.status.status)
				end

				g.core.model.User.shopData:updateShopTask(arg_56_2.status)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_DAILY_TASK then
				g.core.model.User.dailyTaskData:updateTaskProgress(arg_56_2.status)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_SEVENDAYS then
				g.core.model.User.sevenDaysData:onS2CActionStatusFlush(var_0_0.SevenDaysConst.ACT_VALUE.PHASE_1, arg_56_2)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_FOURTEEN then
				g.core.model.User.sevenDaysData:onS2CActionStatusFlush(var_0_0.SevenDaysConst.ACT_VALUE.PHASE_2, arg_56_2)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_GUIDE_TASK then
				g.core.model.User.guideTaskData:updateTask(arg_56_2.status)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_ORDER then
				g.core.model.User.commanderWorldData:updateTask(arg_56_2.status)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_BACK_REWARD then
				-- block empty
			elseif arg_56_2.tp == g.core.network.proto.STATUS_THEME then
				if not arg_56_2.status then
					return
				end

				local var_56_0 = g.core.config.activity_theme_task_info.fetch(arg_56_2.status.id)

				if not var_56_0 then
					return
				end

				local var_56_1 = g.core.model.User.themeData:getThemeData(var_56_0.activity_id)

				if var_56_1 then
					var_56_1:getTaskData():onNetHandleTaskUpdateInfo(arg_56_2)
				end
			elseif arg_56_2.tp == g.core.network.proto.STATUS_PASSCARD then
				g.core.model.User.passCardData:updateTaskProgress(arg_56_2.status)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_GOLD_SAVING then
				g.core.model.User.goldSavingData:updateProgress(arg_56_2.status)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_RECHARGE_TOTAL then
				g.core.model.User.gmTotalRechargeData:onS2CActionStatusFlush(arg_56_2.status)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_GVE then
				if arg_56_2.status.id == 1396 then
					g.core.model.User.gveDataMgr:getGveData():updateMyAtkNums(arg_56_2.status.status)
				end

				g.core.model.User.gveDataMgr:getGveTaskData():taskActionFlush(arg_56_2.status)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_DEAD_TOWER then
				g.core.model.User.wushTowerData:onS2CActionStatusFlush(arg_56_2)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_COMPETITION then
				g.core.model.User.commonCompetitionDataManager:onS2CTaskData(arg_56_2)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_LOTTERY then
				g.core.model.User.lotteryData:onS2CActionStatusFlush(arg_56_2)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_GROUP_BATTLE then
				g.core.model.User.teamPvpData:updateTaskByStatus(arg_56_2.status)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_EXPLORATION then
				g.core.model.User.explorationData:onS2CActionStatusFlush(arg_56_2)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_PASSCARD_ACTIVITY then
				g.core.model.User.gmPassCardData:onS2CActionStatusFlush(arg_56_2)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_BOUNTY then
				g.core.model.User.bountyData:onS2CActionStatusFlush(arg_56_2)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_RERUN then
				g.core.model.User.activityReturnData:onS2CActionStatusFlush(arg_56_2)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_RICH_MAN then
				g.core.model.User.richmanData:getTaskData():onS2CActionStatusFlush(arg_56_2)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_RETRO then
				g.core.model.User.retroData:getTaskData():onS2CActionStatusFlush(arg_56_2)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_BLAZING_ARENA then
				g.core.model.User.blazingArenaData:getTaskData():onS2CActionStatusFlush(arg_56_2)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_NEW_SLG_TECHNOLOGY then
				g.core.model.User.newSlgSkillTreeData:onS2CActionStatusFlush(arg_56_2)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_RELEASE then
				g.core.model.User.releaseActivityData:getTaskData():onS2CActionStatusFlush(arg_56_2)
			elseif arg_56_2.tp == g.core.network.proto.STATUS_DOMAIN then
				g.core.model.User.domainData:onS2CActionStatusFlush(arg_56_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH, false, arg_56_1, arg_56_2)
		end
	end,
	on_S2C_ModifyUserInfo = function(arg_57_0, arg_57_1, arg_57_2)
		if ProtoHandler:onMsgProcess(arg_57_1, arg_57_2) then
			g.core.model.User:updateFrameOrHead(arg_57_2)

			if arg_57_2.type ~= 2 then
				g.core.model.User.userAvatarFrameData:updateDataByConfig()
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MODIFY_USER_INFO, false, arg_57_1, arg_57_2)
		end
	end,
	on_S2C_GetUserState = function(arg_58_0, arg_58_1, arg_58_2)
		if ProtoHandler:onMsgProcess(arg_58_1, arg_58_2) then
			if arg_58_2.module == g.core.network.proto.BIOGRAPHY then
				g.core.model.User.bioData:updatePresetCondition(arg_58_2.states)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_USER_STATE, false, arg_58_1, arg_58_2)
		end
	end,
	on_S2C_GetStamina_Info = function(arg_59_0, arg_59_1, arg_59_2)
		if ProtoHandler:onMsgProcess(arg_59_1, arg_59_2) then
			g.core.model.User.activityGetStaminaData:onRcvGetStaminaInfo(arg_59_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_STAMINA_INFO, false)
		end
	end,
	on_S2C_FlushRedPoint = function(arg_60_0, arg_60_1, arg_60_2)
		local var_60_0 = arg_60_2.red_point or {}
		local var_60_1 = false

		for iter_60_0, iter_60_1 in pairs(arg_60_2) do
			if iter_60_0 ~= "cross_modules" then
				var_60_1 = true

				break
			end
		end

		local var_60_2 = g.core.service.ServiceManager:getServiceByName("LoopService")

		if var_60_0.theme_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.themeData, function(arg_61_0)
				arg_61_0:onS2CFlushRedPoint(var_60_0)
			end)))
		end

		if var_60_0.dead_battle_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.wushData, function(arg_62_0)
				arg_62_0:updateRedPoint(var_60_0)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.BIO_MAIN) and var_60_0.biography_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.bioData, function(arg_63_0)
				arg_63_0:updateRedInfo(var_60_0)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.KINGDOM_FATE) and var_60_0.scroll_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.warriorsOfFateData, function(arg_64_0)
				arg_64_0:onS2CFlushRedPoint(var_60_0)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.ARENA) and (var_60_0.common_hint or var_60_0.arena_hint) then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.arenaData, function(arg_65_0)
				arg_65_0:onS2CFlushRedPoint(var_60_0)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.REBEL_MAIN) and var_60_0.rebel_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.rebelData, function(arg_66_0)
				arg_66_0:onS2CFlushRedPoint(var_60_0)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.STORM) and var_60_0.storm_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.stormData, function(arg_67_0)
				arg_67_0:onS2CFlushRedPoint(var_60_0)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.STORM) and var_60_0.storm_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.stormCityData, function(arg_68_0)
				arg_68_0:onS2CFlushRedPoint(var_60_0)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.MINE) and var_60_0.mine_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.mineData, function(arg_69_0)
				arg_69_0:updateRedPoint(var_60_0)
			end)))
		end

		if var_60_0.ksoul_hint then
			local var_60_3 = var_60_0.ksoul_hint.ksoul_ids or {}

			var_60_2:addToLoopFuncList((handler(g.core.model.User.knightSoulData, function(arg_70_0)
				arg_70_0:updateWishCompleteMap(var_60_3)
				arg_70_0:updateRedPoint(var_60_0.ksoul_hint)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.GUILD) and var_60_0.guild_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.guildData, function(arg_71_0)
				arg_71_0:updateRedPointData(var_60_0)
			end)))
		end

		if var_60_0.guild_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.redPacketData, function(arg_72_0)
				arg_72_0:onS2CFlushRedPoint(var_60_0)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.GUILD_STATUE) and var_60_0.guild_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.guildStatueData, function(arg_73_0)
				arg_73_0:updateRedPointData(var_60_0)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.GUILD_DUNGEON) and var_60_0.guild_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.guildDungeonData, function(arg_74_0)
				arg_74_0:setStageAwardTreasureRedData(var_60_0)
			end)))
		end

		if var_60_0.module_task_hints then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.taskData, function(arg_75_0)
				arg_75_0:onS2CFlushRedPoint(var_60_0)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.ACHIEVEMENT) and var_60_0.achievement_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.achievementData, function(arg_76_0)
				arg_76_0:onS2CFlushRedPoint(var_60_0)
			end)))
		end

		if var_60_0.shop_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.shopData, function(arg_77_0)
				arg_77_0:updateRedPoint(var_60_0.shop_hint)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.FRIEND) then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.friendData, function(arg_78_0)
				arg_78_0:updateFriendsInfo(var_60_0.friend_hint)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.SEVEN_DAYS_ACTIVITY) and var_60_0.common_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.sevenDaysData, function(arg_79_0)
				arg_79_0:onS2CFlushRedPoint(var_60_0.common_hint)
			end)))
		end

		local var_60_4 = g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.GUILD_WAR)

		if var_60_0.guild_war_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.guildWarData, function(arg_80_0)
				arg_80_0:onS2CFlushRedPoint(var_60_0.guild_war_hint)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.HOME_LAND_KNIGHT_TISSUE) and var_60_0.knight_tissue then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.knightTissueData, function(arg_81_0)
				arg_81_0:updateRedPoint(var_60_0.knight_tissue)
			end)))
		end

		local var_60_5 = g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.ONLINE_GIFT)

		if var_60_0.online_gift_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.onlineGiftData, function(arg_82_0)
				arg_82_0:updateInfo(var_60_0.online_gift_hint)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.AUCTION_COMPANY) and var_60_0.auction_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.AuctionData, function(arg_83_0)
				arg_83_0:updateRedPointActId(var_60_0.auction_hint)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.STORM) and var_60_0.storm_city_lord_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.stormCityData, function(arg_84_0)
				arg_84_0:updateRedPoint(var_60_0.storm_city_lord_hint)
			end)))
		end

		local var_60_6 = g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.WUSH_FUND)

		if var_60_0.fund_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.activityFundData, function(arg_85_0)
				arg_85_0:updateWuShuangMaxLayer(var_60_0.fund_hint.dead_battle)
			end)))
		end

		local var_60_7 = g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.COMMANDER_WORLD)

		if var_60_0.order_world_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.commanderWorldData, function(arg_86_0)
				arg_86_0:updateRedPoint(var_60_0.order_world_hint)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.HOME_LAND_MAIN) and var_60_0.hand_land_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.hlTrainData, function(arg_87_0)
				arg_87_0:onS2CFlushRedPoint(var_60_0)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.HOME_LAND_FURNITURE) and var_60_0.furniture_room_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.furnitureData, function(arg_88_0)
				arg_88_0:onS2CFlushRedPoint(var_60_0)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.GUILD_BOSS) and var_60_0.guild_boss then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.guildBossData, function(arg_89_0)
				arg_89_0:updateRedData(var_60_0.guild_boss)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.TOWER) and var_60_0.tower_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.towerData, function(arg_90_0)
				arg_90_0:updateRedData(var_60_0.tower_hint)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.TOWER_HARD) and var_60_0.difficult_tower_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.towerHardData, function(arg_91_0)
				arg_91_0:updateRedData(var_60_0.difficult_tower_hint)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.INVITE_FRIEND) and var_60_0.friend_recommend_act then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.activityInviteFriendData, function(arg_92_0)
				arg_92_0:onS2CFlushRedPoint(var_60_0.friend_recommend_act)
			end)))
		end

		local var_60_8 = g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.FOG_NIGHTMARE)

		if var_60_0.fog_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.fogNightmareData, function(arg_93_0)
				arg_93_0:onS2CFlushRedPoint(var_60_0.fog_hint)
			end)))
		end

		local var_60_9 = g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.VALENTINES_DAY_VOTE)

		if var_60_9 and var_60_0.support_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.valentinesDayVoteData, function(arg_94_0)
				arg_94_0:onS2CFlushRedPoint(var_60_0.support_hint)

				if var_60_9 and arg_94_0:isProcess() then
					g.core.network.GameNetProxy:send_C2S_Support_GetInfo({})
				end
			end)))
		end

		local var_60_10 = g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.GVE)

		if var_60_0.gve_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.gveDataMgr, function(arg_95_0)
				arg_95_0:onS2CFlushRedPoint(var_60_0.gve_hint)
			end)))
		end

		if var_60_0.exploration_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.explorationData, function(arg_96_0)
				arg_96_0:onS2CFlushRedPoint(var_60_0.exploration_hint)
			end)))
		end

		local var_60_11 = g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.MONTH_GACHA)

		if var_60_0.month_gacha_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.activityMonthGachaData, function(arg_97_0)
				arg_97_0:onUpdateRedPoint(var_60_0.month_gacha_hint)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.HALF_ANNIVERSARY) and var_60_0.welfarefund_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.halfAnniversaryData, function(arg_98_0)
				arg_98_0:onS2CFlushRedPoint(var_60_0.welfarefund_hint)
			end)))
		end

		if var_60_0.user_birthday then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.userFestivalData, function(arg_99_0)
				arg_99_0:onS2CFlushRedPoint(var_60_0.user_birthday)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.WUSH_TOWER) and var_60_0.dead_tower_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.wushTowerData, function(arg_100_0)
				arg_100_0:onS2CFlushRedPoint(var_60_0.dead_tower_hint)
			end)))
		end

		if var_60_0.wishpool_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.activityWishpoolData, function(arg_101_0)
				arg_101_0:onS2CFlushRedPoint(var_60_0.wishpool_hint)
			end)))
		end

		if var_60_0.handbook_competition then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.competitionData, function(arg_102_0)
				arg_102_0:onS2CFlushRedPoint(var_60_0.handbook_competition)
			end)))
		end

		if var_60_0.competition_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.commonCompetitionDataManager, function(arg_103_0)
				arg_103_0:onS2CRedInfo(var_60_0.competition_hint)
			end)))
		end

		if var_60_0.chief_arena_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.crossServerArenaData, function(arg_104_0)
				arg_104_0:updateSeasonInfo(var_60_0.chief_arena_hint)
			end)))
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.GENE) and var_60_0.gene_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.geneData, function(arg_105_0)
				arg_105_0:onS2CFlushRedPoint(var_60_0.gene_hint)
			end)))
		end

		if var_60_0.group_battle_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.teamPvpData, function(arg_106_0)
				arg_106_0:onS2CActivityInfo(var_60_0.group_battle_hint)
			end)))
		end

		if var_60_0.chibi_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.redCliffData, function(arg_107_0)
				arg_107_0:onS2CRedPoint(var_60_0.chibi_hint)
			end)))
		end

		if var_60_0.cultivate_activity_hints then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.cultivateDataMgr, function(arg_108_0)
				arg_108_0:onS2CRedPoint(var_60_0.cultivate_activity_hints)
			end)))
		end

		if var_60_0.passcard_activity_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.gmPassCardData, function(arg_109_0)
				arg_109_0:onS2CRedPoint(var_60_0.passcard_activity_hint)
			end)))
		end

		if var_60_0.common_passcard_hints then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.commonPassCardDataMgr, function(arg_110_0)
				arg_110_0:onS2CFlushRedPoint(var_60_0.common_passcard_hints)
			end)))
		end

		if var_60_0.fund_activity_hints then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.gmFundData, function(arg_111_0)
				arg_111_0:onS2CRedPoint(var_60_0.fund_activity_hints)
			end)))
		end

		if var_60_0.bounty_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.bountyData, function(arg_112_0)
				arg_112_0:onS2CFlushRedPoint(var_60_0.bounty_hint)
			end)))
		end

		if var_60_0.oldplayer_back_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.summonOldPlayerData, function(arg_113_0)
				arg_113_0:onRedPointInfo(var_60_0.oldplayer_back_hint)
			end)))
		end

		if var_60_0.mstboss_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.mysteryBossData, function(arg_114_0)
				arg_114_0:onS2CRedPoint(var_60_0.mstboss_hint)
			end)))
		end

		if var_60_0.rerun_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.activityReturnData, function(arg_115_0)
				arg_115_0:onS2CRedPoint(var_60_0.rerun_hint)
			end)))
		end

		if var_60_0.retro_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.retroData, function(arg_116_0)
				arg_116_0:onS2CRedPoint(var_60_0.retro_hint)
			end)))
		end

		if var_60_0.rich_man_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.richmanData, function(arg_117_0)
				arg_117_0:onS2CRedPoint(var_60_0.rich_man_hint)
			end)))
		end

		if var_60_0.team_battle_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.teamBattleData, function(arg_118_0)
				arg_118_0:onS2CFlushRedPoint(var_60_0.team_battle_hint)
			end)))
		end

		if var_60_0.celebration_login_hints then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.activityCelebrationLoginData, function(arg_119_0)
				arg_119_0:updateRedPoint(var_60_0.celebration_login_hints)
			end)))
		end

		if var_60_0.alliance_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.allianceData, function(arg_120_0)
				arg_120_0:updateRedPoint(var_60_0.alliance_hint)
			end)))
		end

		if var_60_0.new_slg_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.newSlgData, function(arg_121_0)
				arg_121_0:updateRedData(var_60_0.new_slg_hint)
			end)))
		end

		if arg_60_2.cross_peak_arena then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.peakArenaData, function(arg_122_0)
				arg_122_0:onS2CUpdateRedPoint(arg_60_2.cross_peak_arena)
			end)))
		end

		if arg_60_2.cross_ancient then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.ancientsData, function(arg_123_0)
				arg_123_0:updateCrossRedPoint(arg_60_2.cross_ancient)
			end)))
		end

		if var_60_0.alliance_trial_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.allianceTrialData, function(arg_124_0)
				arg_124_0:onS2CRedPoint(var_60_0.alliance_trial_hint)
			end)))
		end

		if var_60_0.recycle_cultivate_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.recycleCultivateData, function(arg_125_0)
				arg_125_0:onS2CRedPoint(var_60_0.recycle_cultivate_hint)
			end)))
		end

		if var_60_0.pubg_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.pubgData, function(arg_126_0)
				arg_126_0:onS2CRedPoint(var_60_0.pubg_hint)
			end)))
		end

		if var_60_0.monopoly_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.monopolyDataMgr, function(arg_127_0)
				arg_127_0:onS2CRedPoint(var_60_0.monopoly_hint)
			end)))
		end

		if var_60_0.new_download_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.waitGameData, function(arg_128_0)
				arg_128_0:onS2CRedPoint(var_60_0.new_download_hint)
			end)))
		end

		if arg_60_2.cross_new_slg then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.newSlgData, function(arg_129_0)
				arg_129_0:updateCrossRedPoint(arg_60_2.cross_new_slg)
			end)))
		end

		if var_60_0.blazing_arena_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.blazingArenaData, function(arg_130_0)
				arg_130_0:onFlushHint(var_60_0.blazing_arena_hint)
			end)))
		end

		if var_60_0.succuba_activity_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.succubaLaunchData, function(arg_131_0)
				arg_131_0:onS2CRedPoint(var_60_0.succuba_activity_hint)
			end)))
		end

		if var_60_0.anniversary_activity_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.anniversaryData, function(arg_132_0)
				arg_132_0:onS2CRedPoint(var_60_0.anniversary_activity_hint)
			end)))
		end

		if var_60_0.spire_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.spireData, function(arg_133_0)
				arg_133_0:onS2CRedPoint(var_60_0.spire_hint)
			end)))
		end

		if var_60_0.split_download_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.splitDownloadData, function(arg_134_0)
				arg_134_0:onS2CFlushRedPoint(var_60_0.split_download_hint)
			end)))
		end

		if var_60_0.elder_boss_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.elderBossData, function(arg_135_0)
				arg_135_0:onS2CRedPoint(var_60_0.elder_boss_hint)
			end)))
		end

		if var_60_0.release_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.releaseActivityData, function(arg_136_0)
				arg_136_0:onS2CRedPoint(var_60_0.release_hint)
			end)))
		end

		if var_60_0.outpost_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.outpostData, function(arg_137_0)
				arg_137_0:onS2CRedPoint(var_60_0.outpost_hint)
			end)))
		end

		if var_60_0.ancient_hint then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.ancientsData, function(arg_138_0)
				arg_138_0:updateRedPointData(var_60_0.ancient_hint)
			end)))
		end

		if not var_60_1 then
			var_60_2:addToLoopFuncList((handler(g.core.model.User.giftData, function(arg_139_0)
				arg_139_0:refreshInTime()
			end)))
		end

		var_60_2:addToLoopFuncList(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT, false, arg_60_1, arg_60_2)
		end)
	end,
	on_S2C_Chat = function(arg_141_0, arg_141_1, arg_141_2)
		if arg_141_2.param1 then
			arg_141_2.param2 = arg_141_2.param1
			arg_141_2.param1 = tonumber(arg_141_2.param1)
		end

		g.core.model.User.chatData:setForbidTime(arg_141_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHAT_FORBID_NTF, false, arg_141_1, arg_141_2)

		if ProtoHandler:onMsgProcess(arg_141_1, arg_141_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CHAT, false, arg_141_1, arg_141_2)
		end
	end,
	on_S2C_ChatBroadcast = function(arg_142_0, arg_142_1, arg_142_2)
		if ProtoHandler:onMsgProcess(arg_142_1, arg_142_2) then
			if arg_142_2.param1 then
				arg_142_2.param2 = arg_142_2.param1
				arg_142_2.param1 = tonumber(arg_142_2.param1)
			end

			if arg_142_2.clear then
				g.core.model.User.chatData:clearSomeoneChatInfo(arg_142_2)
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CLEAR_SOMEONE_CHAT)
			else
				g.core.model.User.chatData:checkShareInfo(arg_142_2)
				g.core.model.User.chatData:setAllChatInfo(arg_142_2)
				g.core.model.User.chatData:setChatFloatInfo(arg_142_2)

				if g.core.model.User.chatData:getChannelType() ~= arg_142_2.channel then
					g.core.model.User.chatData:setChannelFlag(arg_142_2.channel, true)
				end

				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST, false, arg_142_1, arg_142_2)
			end
		end
	end,
	on_S2C_Notice = function(arg_143_0, arg_143_1, arg_143_2)
		if ProtoHandler:onMsgProcess(arg_143_1, arg_143_2) then
			g.core.model.User.chatData:setSysNoticeData(arg_143_2)

			local var_143_0 = g.core.model.User.chatData:getSingleSysNoticeData(arg_143_2)

			if #var_143_0 > 0 then
				g.core.model.User.chatData:setChatFloatInfo(var_143_0[1])
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NOTICE, false, arg_143_1, arg_143_2)
		end
	end,
	on_S2C_GetUserConfig = function(arg_144_0, arg_144_1, arg_144_2)
		if ProtoHandler:onMsgProcess(arg_144_1, arg_144_2) then
			g.core.model.User.chatData:setChatSetInfo(arg_144_2)
			g.core.common.Setting:setViewPlayerStatue(arg_144_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_USER_CONFIG, false, arg_144_1, arg_144_2)

			local var_144_0 = arg_144_2.config and arg_144_2.config.language

			if var_144_0 == nil then
				return
			end

			local MultilingualMgr = require("app.core.lang.MultilingualMgr")
			local var_144_2 = MultilingualMgr:getLangIdByDesc((MultilingualMgr:getUseLang()))

			if var_144_2 == nil or var_144_2 == var_144_0 then
				return
			end

			g.core.network.GameNetProxy:send_C2S_SetUserConfig({
				tp = 2,
				config = {
					chat = {},
					language = var_144_2
				}
			})
		end
	end,
	on_S2C_SetUserConfig = function(arg_145_0, arg_145_1, arg_145_2)
		if ProtoHandler:onMsgProcess(arg_145_1, arg_145_2) then
			g.core.model.User.chatData:setChatSetInfo(arg_145_2)
			g.core.common.Setting:setViewPlayerStatue(arg_145_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SET_USER_CONFIG, false, arg_145_1, arg_145_2)
		end
	end,
	on_S2C_GetBattleVideo = function(arg_146_0, arg_146_1, arg_146_2)
		if ProtoHandler:onMsgProcess(arg_146_1, arg_146_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_BATTLE_VIDEO, false, arg_146_1, arg_146_2)
		end
	end,
	on_S2C_GetUserBattleTeam = function(arg_147_0, arg_147_1, arg_147_2)
		if ProtoHandler:onMsgProcess(arg_147_1, arg_147_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_USER_BATTLE_TEAM, false, arg_147_1, arg_147_2)
		end
	end,
	on_S2C_CmdRet = function(arg_148_0, arg_148_1, arg_148_2)
		g.core.network.GameNetProxy:cancelTaskById(arg_148_2.cmd)
		g.core.module.ModuleManager:showLoading(false)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RET_ERROR, false, arg_148_2.ret)
	end,
	on_S2C_GiftNotify = function(arg_149_0, arg_149_1, arg_149_2)
		if ProtoHandler:onMsgProcess(arg_149_1, arg_149_2) then
			-- block empty
		end
	end,
	on_S2C_GiftCode = function(arg_150_0, arg_150_1, arg_150_2)
		if ProtoHandler:onMsgProcess(arg_150_1, arg_150_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GIFT_CODE, false, arg_150_1, arg_150_2)
		end
	end,
	on_S2C_GetChatShare = function(arg_151_0, arg_151_1, arg_151_2)
		if ProtoHandler:onMsgProcess(arg_151_1, arg_151_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_CHAT_SHARE, false, arg_151_1, arg_151_2)
		end
	end,
	on_S2C_FlushPrivilege = function(arg_152_0, arg_152_1, arg_152_2)
		g.core.model.User.privilegeData:initDataByIds(arg_152_2.ids)
	end,
	on_S2C_GetBattleRecord = function(arg_153_0, arg_153_1, arg_153_2)
		if ProtoHandler:onMsgProcess(arg_153_1, arg_153_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_BATTLE_RECORD, false, arg_153_1, arg_153_2)
		end
	end,
	on_S2C_FrameInfo = function(arg_154_0, arg_154_1, arg_154_2)
		if ProtoHandler:onMsgProcess(arg_154_1, arg_154_2) then
			g.core.model.User:updatePropFrame(arg_154_2)
			g.core.model.User.userAvatarFrameData:updateDataByConfig()
			g.core.model.User.userAvatarFrameData:onS2CFrameInfo(arg_154_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FRAME_INFO, false, arg_154_1, arg_154_2)
		end
	end,
	on_S2C_RfreshResource = function(arg_155_0, arg_155_1, arg_155_2)
		if ProtoHandler:onMsgProcess(arg_155_1, arg_155_2) then
			g.core.model.User.resourceData:updateResourceByRefresh(arg_155_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RFRESH_RESOURCE, false, arg_155_1, arg_155_2)
			g.core.model.User.bagData:addList(var_0_0.BAG_TYPE.RESOURCE, {
				arg_155_2.resources
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FLUSH_RESOURCE, false, arg_155_1, arg_155_2)
		end
	end,
	on_G2C_Offline = function(arg_156_0, arg_156_1, arg_156_2)
		if ProtoHandler:onMsgProcess(arg_156_1, arg_156_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_G2C_OFFLINE, false, arg_156_1, arg_156_2)
		end
	end,
	on_G2C_OfflineNew = function(arg_157_0, arg_157_1, arg_157_2)
		if ProtoHandler:onMsgProcess(arg_157_1, arg_157_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_G2C_OFFLINE_NEW, false, arg_157_1, arg_157_2)
		end
	end,
	on_S2C_AntiAddictionNotify = function(arg_158_0, arg_158_1, arg_158_2)
		if ProtoHandler:onMsgProcess(arg_158_1, arg_158_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANTI_ADDICTION_NOTIFY, false, arg_158_1, arg_158_2)
		end
	end,
	on_S2C_FlushCard = function(arg_159_0, arg_159_1, arg_159_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.INCARNATIIN, arg_159_2.cards or {})
	end,
	on_S2C_FlushCardCompose = function(arg_160_0, arg_160_1, arg_160_2)
		g.core.model.User.incarnationData:initCardCompositions(arg_160_2.card_compose or {})
	end,
	on_S2C_FlushPetEquipment = function(arg_161_0, arg_161_1, arg_161_2)
		g.core.model.User.bagData:initList(var_0_0.BAG_TYPE.PET_EQUIPMENT, arg_161_2.petEquipments or {})
		g.core.model.User.petEquipData:updateAllPetEquip()
	end,
	on_S2C_FlushAccountBind = function(arg_162_0, arg_162_1, arg_162_2)
		if ProtoHandler:onMsgProcess(arg_162_1, arg_162_2) then
			g.core.model.User.UserTitleData:setAccountAwardState(arg_162_2)
		end
	end,
	on_S2C_SkinShopGMInfo = function(arg_163_0, arg_163_1, arg_163_2)
		if ProtoHandler:onMsgProcess(arg_163_1, arg_163_2) then
			g.core.model.User.skinData:updateGMSkinData(arg_163_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SKIN_SHOP_GM_INFO, false, arg_163_1, arg_163_2)
		end
	end,
	on_S2C_ChatRecordGetInfo = function(arg_164_0, arg_164_1, arg_164_2)
		if ProtoHandler:onMsgProcess(arg_164_1, arg_164_2) then
			g.core.model.User.chatData:checkAndFitChatData(arg_164_2)
			g.core.model.User.chatData:setRecordHistoryChatData(arg_164_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CHAT_RECORD_GET_INFO, false, arg_164_1, arg_164_2)
		end
	end,
	on_S2C_BulletScreenSend = function(arg_165_0, arg_165_1, arg_165_2)
		if ProtoHandler:onMsgProcess(arg_165_1, arg_165_2) then
			g.core.model.User.chatData:checkAndFitBulletScreenData(arg_165_2)
			g.core.model.User.chatData:setCrossServerMessage(arg_165_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BULLET_SCREEN_SEND, false, arg_165_1, arg_165_2)
		end
	end,
	on_S2C_BulletScreenNotify = function(arg_166_0, arg_166_1, arg_166_2)
		if ProtoHandler:onMsgProcess(arg_166_1, arg_166_2) then
			if arg_166_2.message.user.id == g.core.model.User:getId() then
				return
			end

			g.core.model.User.chatData:checkAndFitBulletScreenData(arg_166_2)
			g.core.model.User.chatData:setCrossServerMessage(arg_166_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BULLET_SCREEN_NOTIFY, false, arg_166_1, arg_166_2)
		end
	end,
	on_S2C_BulletScreenGetInfo = function(arg_167_0, arg_167_1, arg_167_2)
		if ProtoHandler:onMsgProcess(arg_167_1, arg_167_2) then
			g.core.model.User.chatData:checkAndFitBulletScreenInfoData(arg_167_2)
			g.core.model.User.chatData:setCrossServerMessageAll(arg_167_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_BULLET_SCREEN_GET_INFO, false, arg_167_1, arg_167_2)
		end
	end,
	on_S2C_NotifyUserViewDetail = function(arg_168_0, arg_168_1, arg_168_2)
		if ProtoHandler:onMsgProcess(arg_168_1, arg_168_2) and g.core.model.User.chatData:appendViewPlayerUser(arg_168_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NOTIFY_USER_VIEW_DETAIL, false, arg_168_1, arg_168_2)
		end
	end,
	on_S2C_GetUserSnapShot = function(arg_169_0, arg_169_1, arg_169_2)
		if ProtoHandler:onMsgProcess(arg_169_1, arg_169_2) then
			if g.core.model.User.explorationData:isActivityOpen() then
				g.core.model.User.explorationData:getFormationData():updateHelperSnapshot(arg_169_2)
			end

			g.core.model.User.snapShotCacheData:updateSnapShotCache(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_169_2.snapshots, arg_169_2.user_ids)
			g.core.model.User.mysteryData:addRoomUserSnapList(arg_169_2.snapshots)

			if g.core.model.User.newSlgData:isOpen() then
				g.core.model.User.newSlgData:updateUserAsSvrSnapShot(arg_169_2.snapshots)
			end

			if g.core.model.User.crossServerArenaData:isShowEntrance() then
				g.core.model.User.crossServerArenaData:checkUnitSnapShots(arg_169_2.snapshots)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, false, arg_169_1, arg_169_2)
		end
	end,
	on_S2C_GetGuildSnapShot = function(arg_170_0, arg_170_1, arg_170_2)
		if ProtoHandler:onMsgProcess(arg_170_1, arg_170_2) then
			g.core.model.User.snapShotCacheData:updateSnapShotCache(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, arg_170_2.snapshots, arg_170_2.guild_ids)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, false, arg_170_1, arg_170_2)
		end
	end,
	on_S2C_SplitPacket = function(arg_171_0, arg_171_1, arg_171_2)
		if ProtoHandler:onMsgProcess(arg_171_1, arg_171_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SPLIT_PACKET, false, arg_171_1, arg_171_2)
		end
	end,
	on_S2C_TeamBattleEnter = function(arg_172_0, arg_172_1, arg_172_2)
		if ProtoHandler:onMsgProcess(arg_172_1, arg_172_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleEnter(arg_172_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_ENTER, false, arg_172_1, arg_172_2)
		end
	end,
	on_S2C_TeamBattleChallengeResult = function(arg_173_0, arg_173_1, arg_173_2)
		if ProtoHandler:onMsgProcess(arg_173_1, arg_173_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleChallengeResult(arg_173_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_CHALLENGE_RESULT, false, arg_173_1, arg_173_2)
		end
	end,
	on_S2C_FlushServerConfig = function(arg_174_0, arg_174_1, arg_174_2)
		if ProtoHandler:onMsgProcess(arg_174_1, arg_174_2) then
			g.core.model.User:updateServerConfig(arg_174_2.config)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FLUSH_SERVER_CONFIG, false, arg_174_1, arg_174_2)
		end
	end
}
