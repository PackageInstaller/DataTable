local var_0_0 = g.core.const.ConstMgr.BlazingArenaConst
local var_0_1 = g.core.model.User.mulFormationData
local UniteTokenStructData = require("app.view.module.uniteToken.model.UniteTokenStructData")
local PetStruct = require("app.view.module.pet.model.PetStruct")
local var_0_4 = g.core.config.blazing_arena_info
local BlazingArenaTaskData = require("app.view.module.blazingArena.model.BlazingArenaTaskData")
local BlazingArenaData = class("BlazingArenaData")

function BlazingArenaData:ctor()
	self:initData()
end

function BlazingArenaData:initData()
	self._isAvtivityExist = false
	self._serverRedPointHint = false
	self._activityOpenTime = 0
	self._activityShowTime = 0
	self._activityEndTime = 0
	self._activitySubId = 1
	self._activityType = 1
	self._rankAwardId = 0
	self._taskGroupId = 0
	self._lastRank = 0
	self._lastMaxRank = 0
	self._curRank = 0
	self._hisMaxRank = 0
	self._isGuideFinish = false
	self._matchPlayerList = {}
	self._gameServerList = {}
	self._rankList = {}
	self._rankAwardList = {}
	self._todayChallengeNum = 0
	self._breakAwards = {}
	self._enterBattle = false
	self._isSkipFormation = false
	self._sendBattleTime = 0
	self._taskData = BlazingArenaTaskData.new()
	self._borrowDic = {}
	self._helpShortList = {}
	self._waitHelpMembers = {}
	self._waitHelpOtherDic = {}
	self._helpMemberTab = {}
	self._helpMemberIndexDic = {}
	self._robotInfoDic = {}
	self._lineUpHelpTempDic = {}
	self._otherFormationDic = {}
	self._otherKnightsDict = nil
	self._otherSkillList = {}
	self._sweepAwards = {}
end

function BlazingArenaData:resetHelperDic()
	self._helpShortList = {}
	self._waitHelpMembers = {}
	self._waitHelpOtherDic = {}
end

function BlazingArenaData:setOtherFormationData(arg_4_1)
	if arg_4_1 and arg_4_1.formations then
		local var_4_0 = {}
		local var_4_1 = {}

		for iter_4_0, iter_4_1 in ipairs(arg_4_1.knights) do
			var_4_1[iter_4_1.id] = iter_4_1.base_id
		end

		for iter_4_2, iter_4_3 in ipairs(arg_4_1.formations) do
			local var_4_2 = iter_4_3.seq or 0

			if not iter_4_3.knight_id then
				break
			end

			var_4_0[var_4_2] = {}
			var_4_0[var_4_2].knights = {}

			for iter_4_4, iter_4_5 in ipairs(iter_4_3.position or {}) do
				if iter_4_3.knight_id[iter_4_4] ~= 0 then
					var_4_0[var_4_2].knights[iter_4_5] = var_4_1[iter_4_3.knight_id[iter_4_4]] or 0
				end
			end

			var_4_0[var_4_2].fight_value = iter_4_3.fight_value or 0
		end

		self._otherFormationDic[arg_4_1.target_id] = var_4_0
	end
end

function BlazingArenaData:setEnemyFormations(arg_5_1)
	self._tempFormations = arg_5_1
end

function BlazingArenaData:_initHelpMembersWithBorrowDic(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = g.core.config.blazing_arena_parameter_info.get(var_0_0.PARAMETER_IDS.HELP_QUALITY_LIMIT_ID).parameter
	local var_6_1 = 0
	local var_6_2 = {}

	for iter_6_0 = 1, arg_6_2.getLength() do
		local var_6_3 = arg_6_2.indexOf(iter_6_0)
		local var_6_4 = arg_6_3[var_6_3.star]

		if var_6_3.put == 1 and arg_6_2.get(var_6_3.advance_id).put == 1 and var_6_0 <= var_6_3.quality and var_6_4 then
			for iter_6_1, iter_6_2 in ipairs(var_6_4) do
				local var_6_5 = table.concat({
					iter_6_2.starDay,
					iter_6_2.endDay
				}, "_")

				var_6_2[var_6_5] = var_6_2[var_6_5] or {
					orderDic = {},
					limitNum = iter_6_2.limitNum
				}

				local var_6_6 = var_6_2[var_6_5].orderDic

				if var_6_1 < var_6_3.order then
					var_6_1 = var_6_3.order
				end

				local var_6_7 = var_6_6[var_6_3.order]

				if not var_6_6[var_6_3.order] then
					var_6_7 = {}
					var_6_6[var_6_3.order] = var_6_7
				end

				var_6_7[#var_6_7 + 1] = {
					cfg = var_6_3,
					level = iter_6_2.level,
					advanceStage = iter_6_2.advanceStage
				}
			end
		end
	end

	for iter_6_3, iter_6_4 in pairs(var_6_2) do
		local var_6_8 = string.split(iter_6_3, "_")
		local var_6_9 = tonumber(var_6_8[1])
		local var_6_10 = tonumber(var_6_8[2])
		local var_6_11 = {}
		local var_6_12 = {
			limitNum = iter_6_4.limitNum,
			list = var_6_11,
			starDay = var_6_9,
			endDay = var_6_10
		}

		for iter_6_5 = var_6_1, 1, -1 do
			for iter_6_6, iter_6_7 in ipairs(iter_6_4.orderDic[iter_6_5] or {}) do
				var_6_11[#var_6_11 + 1] = iter_6_7
			end
		end

		for iter_6_8 = var_6_9, var_6_10 do
			arg_6_1[iter_6_8] = var_6_12
		end
	end
end

function BlazingArenaData:_initHelpMembers(arg_7_1)
	if not next(self._borrowDic) then
		self:_initBorrowLimitDic()
	end

	local var_7_0 = {}

	self._helpShortList[arg_7_1] = var_7_0

	if g.core.common.Goods.TYPE_UNITETOKEN == arg_7_1 then
		self:_initHelpMembersWithBorrowDic(var_7_0, g.core.config.unite_token_info, self._borrowDic[arg_7_1])
	elseif g.core.common.Goods.TYPE_PET == arg_7_1 then
		self:_initHelpMembersWithBorrowDic(var_7_0, g.core.config.pet_info, self._borrowDic[arg_7_1])
	end
end

function BlazingArenaData:_initBorrowLimitDic()
	self._borrowDic = {}

	for iter_8_0 = 1, g.core.config.blazing_arena_borrow_info.getLength() do
		local var_8_0 = g.core.config.blazing_arena_borrow_info.indexOf(iter_8_0)

		self._borrowDic[var_8_0.type] = self._borrowDic[var_8_0.type] or {}
		self._borrowDic[var_8_0.type][var_8_0.star] = self._borrowDic[var_8_0.type][var_8_0.star] or {}
		self._borrowDic[var_8_0.type][var_8_0.star][#self._borrowDic[var_8_0.type][var_8_0.star] + 1] = {
			level = var_8_0.level,
			advanceStage = var_8_0.pet_stage,
			limitNum = var_8_0.num,
			starDay = var_8_0.start_day,
			endDay = var_8_0.end_day
		}
	end
end

function BlazingArenaData:dealHelpMembers(arg_9_1, arg_9_2)
	if arg_9_2.del then
		self:removeHelpMembers(arg_9_1, arg_9_2.del)
	end

	if arg_9_2.insert then
		self:updateHelpMembers(arg_9_1, arg_9_2.insert)
	end

	if arg_9_2.update then
		self:updateHelpMembers(arg_9_1, arg_9_2.update)
	end
end

function BlazingArenaData:removeHelpMembers(arg_10_1, arg_10_2)
	if not self._helpMemberIndexDic[arg_10_1] then
		return
	end

	local var_10_0 = self._helpMemberIndexDic[arg_10_1].sid
	local var_10_1 = self._helpMemberIndexDic[arg_10_1].baseId
	local var_10_2 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_2) do
		if g.core.common.Goods.TYPE_UNITETOKEN == arg_10_1 then
			var_10_0[iter_10_1.id]:setRealServerId(0)
		elseif g.core.common.Goods.TYPE_PET == arg_10_1 then
			var_10_0[iter_10_1.id]:resetServerId()
		end

		var_10_0[iter_10_1.id] = nil
		var_10_1[iter_10_1.base_id] = nil
	end

	for iter_10_2, iter_10_3 in pairs(var_10_0) do
		var_10_2[#var_10_2 + 1] = iter_10_3
	end

	self._helpMemberTab[arg_10_1] = var_10_2

	self:doTakeOffHelpMembers(arg_10_1, arg_10_2)
end

function BlazingArenaData:doTakeOffHelpMembers(arg_11_1, arg_11_2)
	local var_11_0 = var_0_1:getFormationStructDict(g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA)
	local var_11_1
	local var_11_2

	if g.core.common.Goods.TYPE_UNITETOKEN == arg_11_1 then
		var_11_1 = "isUniteTokenLineUp"
		var_11_2 = "takeOffUniteToken"
	elseif g.core.common.Goods.TYPE_PET == arg_11_1 then
		var_11_1 = "isPetLineUp"
		var_11_2 = "takeOffPet"
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
		for iter_11_2, iter_11_3 in ipairs(var_11_0) do
			if iter_11_3[var_11_1](iter_11_3, iter_11_1.id) then
				iter_11_3[var_11_2](iter_11_3, iter_11_1.id)

				break
			end
		end
	end

	if self:isFormationValid() then
		if var_0_1:isModified(g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA) then
			g.core.network.GameNetProxy:send_C2S_Formation_Save({
				tp = g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA,
				formations = var_0_1:getOutBaseFormationArr(g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA)
			})
		else
			self:checkAndRemoveLineOffHelpMembers()
		end
	end
end

function BlazingArenaData:checkAndRemoveLineOffHelpMembers()
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = {}

	if self._helpMemberIndexDic[g.core.common.Goods.TYPE_UNITETOKEN] then
		for iter_12_0, iter_12_1 in pairs(self._helpMemberIndexDic[g.core.common.Goods.TYPE_UNITETOKEN].sid) do
			var_12_2[iter_12_0] = iter_12_1
		end
	end

	local var_12_3 = g.core.common.Goods.TYPE_PET
	local var_12_4 = {}

	if self._helpMemberIndexDic[g.core.common.Goods.TYPE_PET] then
		for iter_12_2, iter_12_3 in pairs(self._helpMemberIndexDic[var_12_3].sid) do
			var_12_4[iter_12_2] = iter_12_3
		end
	end

	local var_12_5 = false

	for iter_12_4, iter_12_5 in ipairs((var_0_1:getFormationStructDict(g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA))) do
		for iter_12_6, iter_12_7 in ipairs((iter_12_5:getValidUniteTokenSidList())) do
			if var_12_2[iter_12_7] then
				var_12_2[iter_12_7] = nil
			elseif not g.core.model.User.uniteTokenData:getTokenByServerId(iter_12_7) then
				iter_12_5:takeOffUniteToken(iter_12_7)

				var_12_5 = true
			end
		end

		for iter_12_8, iter_12_9 in ipairs((iter_12_5:getValidPetSidList())) do
			if var_12_4[iter_12_9] then
				var_12_4[iter_12_9] = nil
			elseif not g.core.model.User.petsData:getPetBySid(iter_12_9) then
				iter_12_5:takeOffPet(iter_12_9)

				var_12_5 = true
			end
		end
	end

	local var_12_6 = {}

	for iter_12_10, iter_12_11 in pairs(var_12_2) do
		if not var_12_0[#var_12_0 + 1] then
			var_12_0[#var_12_0 + 1] = g.core.common.Goods.TYPE_UNITETOKEN
			var_12_1[#var_12_0 + 1] = var_12_6
		end

		var_12_6[#var_12_6 + 1] = iter_12_10
	end

	local var_12_7 = {}

	for iter_12_12, iter_12_13 in pairs(var_12_4) do
		if not var_12_0[#var_12_0 + 1] then
			var_12_0[#var_12_0 + 1] = var_12_3
			var_12_1[#var_12_0 + 1] = var_12_7
		end

		var_12_7[#var_12_7 + 1] = iter_12_12
	end

	if #var_12_0 > 0 then
		self:doReturnHelpMember(var_12_0, var_12_1)
	end

	if var_12_5 then
		g.core.network.GameNetProxy:send_C2S_Formation_Save({
			tp = g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA,
			formations = var_0_1:getOutBaseFormationArr(g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA)
		})
	end
end

function BlazingArenaData:getAllExpiredMember()
	local var_13_0 = g.core.common.ServerTime:getTime()
	local var_13_1 = {
		typeList = {},
		itemList = {}
	}

	for iter_13_0, iter_13_1 in pairs(self._helpMemberTab) do
		local var_13_2

		for iter_13_2, iter_13_3 in ipairs(iter_13_1) do
			if var_13_0 >= iter_13_3:getExpireTime() then
				if not var_13_2 then
					var_13_2 = #var_13_1.typeList + 1
					var_13_1.typeList[#var_13_1.typeList + 1] = iter_13_0
					var_13_1.itemList[var_13_2] = {}
				end

				local var_13_3 = var_13_1.itemList[var_13_2]
				local var_13_4

				if g.core.common.Goods.TYPE_UNITETOKEN == iter_13_0 then
					var_13_4 = iter_13_3:getRealServerId()
				elseif g.core.common.Goods.TYPE_PET == iter_13_0 then
					var_13_4 = iter_13_3:getSid()
				end

				var_13_3[#var_13_3 + 1] = {
					id = var_13_4
				}
			end
		end
	end

	return var_13_1
end

function BlazingArenaData:updateHelpMembers(arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(arg_14_2) do
		self:updateOneHelpMember(arg_14_1, iter_14_1)
	end
end

function BlazingArenaData:updateOneHelpMember(arg_15_1, arg_15_2)
	self._helpMemberTab[arg_15_1] = self._helpMemberTab[arg_15_1] or {}
	self._helpMemberIndexDic[arg_15_1] = self._helpMemberIndexDic[arg_15_1] or {
		baseId = {},
		sid = {}
	}

	local var_15_0 = self._helpMemberTab[arg_15_1]
	local var_15_1 = self._helpMemberIndexDic[arg_15_1].sid
	local var_15_2 = self._helpMemberIndexDic[arg_15_1].baseId
	local var_15_3

	if self._waitHelpOtherDic[arg_15_1] then
		var_15_3 = self._waitHelpOtherDic[arg_15_1].index[arg_15_2.base_id]
	end

	if g.core.common.Goods.TYPE_UNITETOKEN == arg_15_1 then
		var_15_3 = var_15_3 or UniteTokenStructData.new(arg_15_2.base_id)

		var_15_3:updateByNetData(arg_15_2)
	elseif g.core.common.Goods.TYPE_PET == arg_15_1 then
		var_15_3 = var_15_3 or PetStruct.new(arg_15_2.base_id)

		var_15_3:setServerData(arg_15_2)
	end

	var_15_0[#var_15_0 + 1] = var_15_3
	var_15_1[arg_15_2.id] = var_15_3
	var_15_2[arg_15_2.base_id] = var_15_3

	self:_doLineUpHelpMember(arg_15_1, arg_15_2.base_id, var_15_3)
end

function BlazingArenaData:_createRobotShortInfo(arg_16_1)
	local var_16_0 = g.core.config.blazing_arena_robot_info.get(arg_16_1)
	local var_16_1 = {}
	local var_16_2 = {
		isShort = true,
		fightValue = 0,
		isRobot = true,
		id = arg_16_1,
		robot_id = arg_16_1,
		name = var_16_0.name,
		rank = var_16_0.rank,
		userLv = var_16_0.seen_level,
		knightPic = var_16_0.seen_knight,
		quality = var_16_0.quality,
		formations = var_16_1
	}

	for iter_16_0 = 1, g.core.const.ConstMgr.FormationConst.MAX_FORMATION_CNT do
		local var_16_3 = {}
		local var_16_4 = {}
		local var_16_5 = {}
		local var_16_6 = {
			fight_value = var_16_0[table.concat({
				"fight_power_",
				iter_16_0
			})],
			knights = var_16_3,
			uniteTokens = var_16_4,
			pets = var_16_5
		}

		var_16_2.fightValue = var_16_2.fightValue + var_16_6.fight_value

		for iter_16_1 = 1, g.core.const.ConstMgr.LineUpConst.MAX_KNIGHT_NUM do
			local var_16_7 = var_16_0[table.concat({
				"knight_id_",
				(iter_16_0 - 1) * g.core.const.ConstMgr.LineUpConst.MAX_KNIGHT_NUM + iter_16_1
			})]

			if var_16_7 > 0 then
				var_16_3[iter_16_1] = var_16_7
			end
		end

		for iter_16_2 = 1, g.core.const.ConstMgr.LineUpConst.MAX_UNITE_TOKEN_NUM do
			local var_16_8 = var_16_0[table.concat({
				"unite_token_",
				(iter_16_0 - 1) * g.core.const.ConstMgr.LineUpConst.MAX_UNITE_TOKEN_NUM + iter_16_2
			})]

			if var_16_8 > 0 then
				var_16_4[iter_16_2] = var_16_8
			end
		end

		for iter_16_3 = 1, g.core.const.ConstMgr.LineUpConst.MAX_PEN_NUM do
			local var_16_9 = var_16_0[table.concat({
				"pet_",
				(iter_16_0 - 1) * g.core.const.ConstMgr.LineUpConst.MAX_PEN_NUM + iter_16_3
			})]

			if var_16_9 > 0 then
				var_16_5[iter_16_3] = var_16_9
			end
		end

		var_16_1[iter_16_0] = var_16_6
	end

	self._robotInfoDic[arg_16_1] = var_16_2
end

function BlazingArenaData:saveLastRank()
	self._lastRank = self._curRank
	self._lastMaxRank = self._hisMaxRank
	self._sendBattleTime = g.core.common.ServerTime:getTime()
end

function BlazingArenaData:getEnemyFormations()
	return self._tempFormations
end

function BlazingArenaData:_doLineUpHelpMember(arg_19_1, arg_19_2, arg_19_3)
	if not self._lineUpHelpTempDic[arg_19_1] then
		return
	end

	local var_19_0 = self._lineUpHelpTempDic[arg_19_1][arg_19_2]

	if not self._lineUpHelpTempDic[arg_19_1][arg_19_2] then
		return
	end

	local var_19_2 = g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA
	local var_19_3 = var_0_1:getFormationStruct(g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA, var_19_0.formationIdx)

	if arg_19_1 == g.core.common.Goods.TYPE_UNITETOKEN then
		var_19_3:lineupUniteToken(var_19_0.pos, (arg_19_3:getRealServerId()))
	elseif arg_19_1 == g.core.common.Goods.TYPE_PET then
		var_19_3:lineupPet(var_19_0.pos, (arg_19_3:getSid()))
	end

	if self:isFormationValid() then
		g.core.network.GameNetProxy:send_C2S_Formation_Save({
			tp = var_19_2,
			formations = var_0_1:getOutBaseFormationArr(var_19_2)
		})
	end
end

function BlazingArenaData:isFormationValid()
	local var_20_0 = var_0_1:getFormationStructDict(g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA)

	if table.nums(var_20_0) < 3 then
		return false
	end

	local var_20_1 = true

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		if not iter_20_1:isKnightNumValid() then
			var_20_1 = false

			break
		end

		if not iter_20_1:isUniteTokenNumValid() then
			var_20_1 = false

			break
		end

		if not iter_20_1:isPetNumValid() then
			var_20_1 = false

			break
		end
	end

	return var_20_1
end

function BlazingArenaData:getRobotInfo(arg_21_1)
	if not self._robotInfoDic[arg_21_1] then
		self:_createRobotShortInfo(arg_21_1)
	end

	return self._robotInfoDic[arg_21_1]
end

function BlazingArenaData:robotInfoShortToDetail(arg_22_1)
	local KnightStruct = require("app.view.module.knight.model.KnightStruct")
	local UniteTokenStructData = require("app.view.module.uniteToken.model.UniteTokenStructData")
	local PetStruct = require("app.view.module.pet.model.PetStruct")

	for iter_22_0, iter_22_1 in ipairs(arg_22_1.formations) do
		local var_22_3 = {}

		for iter_22_2, iter_22_3 in pairs(iter_22_1.knights) do
			local var_22_4 = g.core.config.knight_info.get(iter_22_3)

			var_22_3[iter_22_2] = KnightStruct.new(var_22_4.advance_id), KnightStruct:addCfgInfo(var_22_4)
		end

		iter_22_1.knights = var_22_3

		local var_22_5 = {}

		for iter_22_4, iter_22_5 in pairs(iter_22_1.uniteTokens) do
			var_22_5[iter_22_4] = UniteTokenStructData.new(iter_22_5)
		end

		iter_22_1.uniteTokens = var_22_5

		local var_22_6 = {}

		for iter_22_6, iter_22_7 in pairs(iter_22_1.pets) do
			var_22_6[iter_22_6] = PetStruct.new(g.core.config.pet_info.get(iter_22_7).advance_id)
		end

		iter_22_1.pets = var_22_6
	end

	arg_22_1.isShort = false
end

function BlazingArenaData:combineAndGetNetRobotInfo(arg_23_1)
	local var_23_0 = clone(self:getRobotInfo(arg_23_1.robot_id))

	for iter_23_0, iter_23_1 in pairs(arg_23_1) do
		if iter_23_1 ~= 0 then
			var_23_0[iter_23_0] = iter_23_1
		end
	end

	return var_23_0
end

function BlazingArenaData:getBorrowNumByDay(arg_24_1)
	local var_24_0 = self:getHelpShortList(g.core.common.Goods.TYPE_UNITETOKEN, arg_24_1)

	return #var_24_0 + #self:getHelpShortList(g.core.common.Goods.TYPE_PET, arg_24_1), (#var_24_0 > 0 or nil) and g.core.config.unite_token_info.get(var_24_0[1].cfg.id).star
end

function BlazingArenaData:getShortInfo(arg_25_1)
	if not self._helpShortList[arg_25_1] then
		self:_initHelpMembers(arg_25_1)
	end

	return self._helpShortList[arg_25_1]
end

function BlazingArenaData:getHelpShortList(arg_26_1, arg_26_2)
	local var_26_1 = self:getShortInfo(arg_26_1)

	arg_26_2 = arg_26_2 or self:getCurDay()

	return (var_26_1[arg_26_2] or nil) and var_26_1[arg_26_2].list
end

function BlazingArenaData:_initWaitHelpMembers(arg_27_1)
	local var_27_0 = {}

	self._waitHelpMembers[arg_27_1] = var_27_0

	local var_27_1 = {
		day = self:getCurDay(),
		index = {}
	}

	self._waitHelpOtherDic[arg_27_1] = var_27_1

	for iter_27_0, iter_27_1 in ipairs((self:getHelpShortList(arg_27_1))) do
		local var_27_2 = self._helpMemberIndexDic[arg_27_1] and self._helpMemberIndexDic[arg_27_1].baseId[iter_27_1.cfg.id]

		if not (self._helpMemberIndexDic[arg_27_1] and self._helpMemberIndexDic[arg_27_1].baseId[iter_27_1.cfg.id]) then
			if g.core.common.Goods.TYPE_UNITETOKEN == arg_27_1 then
				var_27_2 = UniteTokenStructData.new(iter_27_1.cfg.id)

				var_27_2:setServerId(var_27_2:getAdvanceId())
				var_27_2:setStarLevel(iter_27_1.cfg.star)
			elseif g.core.common.Goods.TYPE_PET == arg_27_1 then
				var_27_2 = PetStruct.new(iter_27_1.cfg.id)

				var_27_2:setServerData({
					base_id = iter_27_1.cfg.id,
					level = iter_27_1.level,
					star = iter_27_1.cfg.star
				})
			end
		end

		var_27_1.index[iter_27_1.cfg.id] = var_27_2
		var_27_0[#var_27_0 + 1] = var_27_2
	end
end

function BlazingArenaData:getWaitHelpMembers(arg_28_1, arg_28_2)
	if not self._waitHelpMembers[arg_28_1] or self._waitHelpOtherDic[arg_28_1].day ~= self:getCurDay() then
		self:_initWaitHelpMembers(arg_28_1)
	end

	return self:_filterWaitHelpMembers(arg_28_1, arg_28_2)
end

function BlazingArenaData:_filterWaitHelpMembers(arg_29_1, arg_29_2)
	if not arg_29_2 then
		return self._waitHelpMembers[arg_29_1]
	end

	if arg_29_2.judgeLimitNum and self:_isMaxBorrowNum(arg_29_1) then
		return {}
	end

	local var_29_0 = self._waitHelpMembers[arg_29_1]

	if arg_29_2.offLine then
		var_29_0 = {}

		for iter_29_0, iter_29_1 in ipairs(self._waitHelpMembers[arg_29_1]) do
			if g.core.common.Goods.TYPE_UNITETOKEN == arg_29_1 and (iter_29_1:getRealServerId() == 0 or iter_29_1:getRealServerId() == iter_29_1:getServerId()) then
				var_29_0[#var_29_0 + 1] = iter_29_1
			elseif g.core.common.Goods.TYPE_PET == arg_29_1 and iter_29_1:getSid() == 1 then
				var_29_0[#var_29_0 + 1] = iter_29_1
			end
		end
	end

	return var_29_0
end

function BlazingArenaData:getHelpMembers(arg_30_1)
	return self._helpMemberTab[arg_30_1] or {}
end

function BlazingArenaData:getHelpMemberWithBaseId(arg_31_1, arg_31_2)
	if not self._helpMemberIndexDic[arg_31_1] then
		return
	end

	return self._helpMemberIndexDic[arg_31_1].baseId[arg_31_2]
end

function BlazingArenaData:getHelpMemberWithServerId(arg_32_1, arg_32_2)
	if not self._helpMemberIndexDic[arg_32_1] then
		return
	end

	return self._helpMemberIndexDic[arg_32_1].sid[arg_32_2]
end

function BlazingArenaData:getOtherFormationData(arg_33_1)
	return self._otherFormationDic[arg_33_1]
end

function BlazingArenaData:_isMaxBorrowNum(arg_34_1)
	return self._helpShortList[arg_34_1][self:getCurDay()].limitNum <= #self:getHelpMembers(arg_34_1)
end

function BlazingArenaData:doBorrowHelpMember(arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	self._lineUpHelpTempDic[arg_35_3] = self._lineUpHelpTempDic[arg_35_3] or {}

	if self:_isMaxBorrowNum(arg_35_3) then
		g.core.module.ModuleManager:tip(g.core.lang:get(431415))

		return
	end

	local var_35_0 = self:getHelpMemberWithBaseId(arg_35_3, arg_35_4)
	local var_35_1 = var_35_0 ~= nil

	self._lineUpHelpTempDic[arg_35_3][arg_35_4] = {
		formationIdx = arg_35_1:getFormationIdx(),
		pos = arg_35_2
	}

	if not var_35_1 then
		g.core.network.GameNetProxy:send_C2S_BlazingArena_EmbryoBorrow({
			embryo_type = arg_35_3,
			embryo_base_id = arg_35_4
		})
	else
		self:_doLineUpHelpMember(arg_35_3, arg_35_4, var_35_0)
	end
end

function BlazingArenaData:doReturnHelpMember(arg_36_1, arg_36_2)
	local var_36_0 = {}

	for iter_36_0, iter_36_1 in ipairs(arg_36_1) do
		var_36_0[#var_36_0 + 1] = {
			tp = iter_36_1,
			unique_ids = arg_36_2[iter_36_0]
		}
	end

	self:_sendReturnHelpMember(var_36_0)
end

function BlazingArenaData:_sendReturnHelpMember(arg_37_1)
	g.core.network.GameNetProxy:send_C2S_BlazingArena_EmbryoGiveBack({
		embryo_unique_ids = arg_37_1
	})
end

function BlazingArenaData:getCurRank()
	return self._curRank
end

function BlazingArenaData:getCurTeamFightValue()
	local var_39_0 = 0

	for iter_39_0, iter_39_1 in pairs((var_0_1:getFormationStructDict(g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA))) do
		var_39_0 = var_39_0 + iter_39_1:getFightValue()
	end

	return var_39_0
end

function BlazingArenaData:getMatchPlayerList()
	if not self._guideFinish then
		return self:getGuideRobotList()
	else
		return self._matchPlayerList
	end
end

function BlazingArenaData:getGuideRobotList()
	local var_41_0 = {}
	local var_41_1 = self:getRobotInfo(var_0_0.GUIDE_ROBOT_ID)

	for iter_41_0 = 1, var_0_0.ROBOT_FAKE_NUM do
		var_41_0[iter_41_0] = var_41_1
	end

	return var_41_0
end

function BlazingArenaData:getPlayerPlayerPaintedId(arg_42_1, arg_42_2)
	local var_42_0
	local var_42_1

	if arg_42_1.isRobot then
		var_42_0 = arg_42_1.knightPic
	elseif arg_42_2 then
		var_42_0 = arg_42_2.show_knight_id

		if not arg_42_2.show_knight_id or var_42_0 == 0 then
			var_42_0 = arg_42_2.base_id
		end

		var_42_1 = arg_42_2.show_knight_dress
	end

	return g.core.model.User.knightsData:getKnightResInfo({
		knightId = var_42_0,
		skinId = var_42_1
	}).painted_id
end

function BlazingArenaData:getCurDay()
	return g.core.common.ServerTime:getDeltaDays(self._activityOpenTime, g.core.common.ServerTime:getTime()) + 1
end

function BlazingArenaData:getGameServerList()
	return self._gameServerList
end

function BlazingArenaData:getRankList()
	return self._rankList
end

function BlazingArenaData:getRankRewardList()
	if #self._rankAwardList == 0 then
		self._rankAwardList = require("app.core.common.RankAward"):getRankAwardArray(var_0_0.RANK_REWARD_TYPE, self._rankAwardId)
	end

	return self._rankAwardList
end

function BlazingArenaData:getTaskData()
	return self._taskData
end

function BlazingArenaData:getTodayChallengeNum()
	return self._todayChallengeNum
end

function BlazingArenaData:getActivityOpenTime()
	return self._activityOpenTime
end

function BlazingArenaData:getActivityShowTime()
	return self._activityShowTime
end

function BlazingArenaData:getActivityEndTime()
	return self._activityEndTime
end

function BlazingArenaData:isInShowTime()
	local var_52_0 = g.core.common.ServerTime:getTime()

	return var_52_0 >= self._activityShowTime and var_52_0 <= self._activityEndTime
end

function BlazingArenaData:isInActivityTime()
	local var_53_0 = g.core.common.ServerTime:getTime()

	return var_53_0 >= self._activityOpenTime and var_53_0 <= self._activityEndTime
end

function BlazingArenaData:getCampaignStr()
	if self:isInShowTime() then
		return g.core.lang:get(431403)
	else
		return g.core.lang:get(431402)
	end
end

function BlazingArenaData:getCampaignEntranceCDTime()
	local var_55_0 = g.core.common.ServerTime:getTime()

	if var_55_0 >= self._activityOpenTime and var_55_0 <= self._activityShowTime then
		return self._activityShowTime
	else
		return self._activityEndTime
	end
end

function BlazingArenaData:isShowEntrance()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BLAZING_ARENA) then
		return false
	end

	local var_56_0 = g.core.common.ServerTime:getTime()

	return var_56_0 >= self._activityOpenTime and var_56_0 <= self._activityEndTime
end

function BlazingArenaData:isInActivityPlayTime()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BLAZING_ARENA) then
		return false
	end

	local var_57_0 = g.core.common.ServerTime:getTime()

	return var_57_0 >= self._activityOpenTime and var_57_0 <= self._activityShowTime
end

function BlazingArenaData:getActivityExpireTime()
	return self._activityEndTime
end

function BlazingArenaData:getAttackTimes()
	return (g.core.model.User.shopData:getLeftCount(var_0_0.LEFT_TIME_TYPE))
end

function BlazingArenaData:isLocalServer()
	return self._activityType == var_0_0.ACTIVITY_TYPE.LOCAL_SERVER
end

function BlazingArenaData:getMaxRankNum()
	return self:isLocalServer() and g.core.config.blazing_arena_parameter_info.get(var_0_0.PARAMETER_IDS.LOCAL_MAX_RANK).parameter or g.core.config.blazing_arena_parameter_info.get(var_0_0.PARAMETER_IDS.CORSS_MAX_RANK).parameter
end

function BlazingArenaData:setEnterBattleStatus(arg_62_1)
	self._enterBattle = arg_62_1
end

function BlazingArenaData:getEnterBattleStatus()
	return self._enterBattle
end

function BlazingArenaData:getHistoryRank()
	if self._hisMaxRank > 0 and self._curRank > 0 then
		return math.min(self._hisMaxRank, self._curRank)
	end

	return 99999
end

function BlazingArenaData:getLastRank()
	return self._lastRank
end

function BlazingArenaData:getLastMaxRank()
	return self._lastMaxRank
end

function BlazingArenaData:getBreakAwards()
	return self._breakAwards
end

function BlazingArenaData:getBorrowFreshDay()
	local var_68_0 = 7

	for iter_68_0 = 1, g.core.config.blazing_arena_borrow_info.getLength() do
		local var_68_1 = g.core.config.blazing_arena_borrow_info.indexOf(iter_68_0)

		if var_68_0 > var_68_1.end_day then
			var_68_0 = var_68_1.end_day
		end
	end

	return var_68_0 + 1
end

function BlazingArenaData:getSweepAwards()
	return self._sweepAwards
end

function BlazingArenaData:onFlushHint(arg_70_1)
	if arg_70_1.activity then
		self._isAvtivityExist = true
		self._activityOpenTime = arg_70_1.activity.id
		self._activityEndTime = g.core.common.ServerTime:getNextNDayZeroTime(self._activityOpenTime, 8)
		self._activityShowTime = self._activityEndTime - 7200
		self._activitySubId = arg_70_1.activity.sub_id or 1
		self._activityType = arg_70_1.activity.tp or var_0_0.ACTIVITY_TYPE.LOCAL_SERVER

		local var_70_0 = var_0_4.get(self._activitySubId)

		self._rankAwardId = self._activityType == var_0_0.ACTIVITY_TYPE.LOCAL_SERVER and var_70_0.single_rank_reward or var_70_0.multiple_rank_reward
		self._taskGroupId = var_70_0.task_group
	end

	self._serverRedPointHint = arg_70_1.hint or false
end

function BlazingArenaData:onS2CBlazingArenaGetInfo(arg_71_1)
	self._curRank = arg_71_1.rank or 0
	self._hisMaxRank = arg_71_1.max_rank or 0
	self._guideFinish = arg_71_1.guide_finish or false
	self._todayChallengeNum = arg_71_1.daily_challenge_times or 0

	if arg_71_1.tasks then
		self._serverRedPointHint = false

		self._taskData:updateTaskData(arg_71_1.tasks)
	end

	self:updateMatchPlayerList(arg_71_1.match_units or {})
end

function BlazingArenaData:updateMatchPlayerList(arg_72_1)
	self._matchPlayerList = {}

	for iter_72_0 = 1, #arg_72_1 do
		local var_72_1 = {
			id = arg_72_1[iter_72_0].id,
			rank = arg_72_1[iter_72_0].rank,
			isRobot = arg_72_1[iter_72_0].robot_id ~= 0
		}

		var_72_1.robot_id = arg_72_1[iter_72_0].robot_id or 0
		var_72_1.fightValue = arg_72_1[iter_72_0].fight_value or 0

		table.insert(self._matchPlayerList, var_72_1)
	end

	table.sort(self._matchPlayerList, function(arg_73_0, arg_73_1)
		return arg_73_0.rank > arg_73_1.rank
	end)
end

function BlazingArenaData:onS2CBlazingArenaRankList(arg_74_1)
	self._rankList = {}

	local var_74_0 = arg_74_1.units or {}

	for iter_74_0 = 1, #var_74_0 do
		local var_74_2 = {
			id = var_74_0[iter_74_0].id,
			rank = var_74_0[iter_74_0].rank,
			isRobot = var_74_0[iter_74_0].robot_id ~= 0
		}

		var_74_2.robot_id = var_74_0[iter_74_0].robot_id or 0
		var_74_2.fightValue = var_74_0[iter_74_0].fight_value or 0

		table.insert(self._rankList, var_74_2)
	end

	table.sort(self._rankList, function(arg_75_0, arg_75_1)
		return arg_75_0.rank < arg_75_1.rank
	end)
end

function BlazingArenaData:onS2CBlazingArenaChallengeBegin(arg_76_1)
	return
end

function BlazingArenaData:onS2CBlazingArenaChallengeFinish(arg_77_1)
	self._breakAwards = arg_77_1.break_awards or {}
end

function BlazingArenaData:onS2CBlazingArenaServerInfos(arg_78_1)
	self._gameServerList = arg_78_1.server_infos or {}
end

function BlazingArenaData:onS2CBlazingArenaTaskAward(arg_79_1)
	local var_79_0 = arg_79_1.task_ids or {}

	for iter_79_0 = 1, #var_79_0 do
		self._taskData:onTaskAward(var_79_0[iter_79_0])
	end
end

function BlazingArenaData:onS2CBlazingArenaEmbryoBorrow(arg_80_1)
	return
end

function BlazingArenaData:onS2CBlazingArenaEmbryoGiveBack(arg_81_1)
	return
end

function BlazingArenaData:onS2CBlazingArenaSweep(arg_82_1)
	self._todayChallengeNum = self._todayChallengeNum + 1
	self._sweepAwards = {}

	for iter_82_0 = 1, #(arg_82_1.challenge_awards or {}) do
		table.insert(self._sweepAwards, arg_82_1.challenge_awards[iter_82_0])
	end

	for iter_82_1 = 1, #(arg_82_1.turn_awards or {}) do
		table.insert(self._sweepAwards, arg_82_1.turn_awards[iter_82_1])
	end
end

function BlazingArenaData:isSkipFormation()
	return self._isSkipFormation
end

function BlazingArenaData:setSkipFormation(arg_84_1)
	self._isSkipFormation = arg_84_1
end

function BlazingArenaData:isPlayTimeFull()
	if self:isInActivityPlayTime() then
		return self:getAttackTimes() >= var_0_0.PLAY_TIME_FULL_NUM
	end

	return false
end

function BlazingArenaData:isHaveTaskReward()
	if self:isInActivityPlayTime() then
		if self._serverRedPointHint then
			return true
		end

		return self._taskData:isCanRewardTask()
	end

	return false
end

function BlazingArenaData:isHaveNewBorrowUnit()
	if self:isInActivityPlayTime() then
		local var_87_0 = self:getCurDay()
		local var_87_1 = self:getBorrowNumByDay(var_87_0)
		local var_87_2 = g.core.common.Storage:load("blazing_arena_borrow_num.json") or {}

		if var_87_2.weekDay and var_87_2.borrowNum then
			local var_87_3 = self:getBorrowFreshDay()

			return var_87_2.weekDay ~= (var_87_0 < var_87_3 and 1 or var_87_3) or var_87_1 > var_87_2.borrowNum
		else
			return true
		end
	end

	return false
end

function BlazingArenaData:saveBorrowUnitNumAndDay()
	local var_88_0 = self:getCurDay()
	local var_88_1 = self:getBorrowFreshDay()

	g.core.common.Storage:save("blazing_arena_borrow_num.json", {
		weekDay = var_88_0 < var_88_1 and 1 or var_88_1,
		borrowNum = self:getBorrowNumByDay(var_88_0)
	})
end

function BlazingArenaData:checkCanSendBattle()
	return g.core.common.ServerTime:getTime() - self._sendBattleTime > 1
end

return BlazingArenaData
