local var_0_0 = g.core.config.knight_base_info
local var_0_1 = g.core.config.knight_tissue_info
local var_0_2 = g.core.config.knight_info
local var_0_3 = g.core.const.ConstMgr.KNIGHT_CONST
local EquipmentStruct = require("app.view.module.equipAndTreasure.model.EquipmentStruct")
local PlayerInfoData = class("PlayerInfoData")

function PlayerInfoData:ctor()
	self:initData()
end

function PlayerInfoData:initData()
	self._playerUid = 0
	self._playerSnapShot = {}
	self._signStr = ""
	self._totalPraiseNum = 0
	self._praiseRank = 0
	self._hasPraiseAward = false
	self._dungeonStageProgress = 0
	self._knightNum = 0
	self._knightTissueList = {}
	self._knightShowList = {}
	self._titleShowList = {}
	self._canPraise = {}
	self._furnitureRoomComfort = 0
	self._furnitureNum = 0
	self._furniturePraise = 0
	self._furnitureCharm = 0
	self._wushMaxFloor = 0
	self._arenaTopRank = 0
	self._knightSoulHonorNum = 0
	self._succubaTotalCharm = 0
	self._bioMaxCampaign = 0
	self._equipmentPosMap = {}
	self._equipmentSidMap = {}
	self._equipSuitPosMap = {}
	self._treasurePosMap = {}
	self._treasureSidMap = {}
	self._lineupKnightSids = {}
	self._userPraiseNum = {}
	self._userPraiseAwardIdList = {}
	self._tissueList = {}

	self:_initCfg()
end

function PlayerInfoData:_initCfg()
	for iter_3_0 = 1, var_0_1.getLength() do
		table.insert(self._tissueList, (var_0_1.indexOf(iter_3_0)))
	end
end

function PlayerInfoData:onS2CGetInfo(arg_4_1)
	self._playerUid = arg_4_1.uid or 0

	local var_4_0 = arg_4_1.grow or {}
	local var_4_1 = arg_4_1.player or {}

	self._playerSnapShot = var_4_1.user or {}

	self:_updateLineupKnightSid(var_4_1.formation.knight_id)
	self:_updateEquipmentData(var_4_1.equipments or {})
	self:_updateEquipSuitData(var_4_1.formation.equipment_id or {})
	self:_updateTreasureData(var_4_1.treasures or {})

	self._dungeonStageProgress = var_4_0.dungeon_stage or 0
	self._knightNum = var_4_0.knight_num or 0
	self._knightTissueList = {}

	for iter_4_0, iter_4_1 in pairs(var_4_0.knight_tissue or {}) do
		self._knightTissueList[iter_4_1.id] = iter_4_1.lv
	end

	self._titleShowList = var_4_0.title_ids or {}
	self._furnitureRoomComfort = var_4_0.furniture_room_comfort or 0
	self._furnitureNum = var_4_0.furniture_num or 0
	self._furniturePraise = var_4_0.furniture_praise or 0
	self._furnitureCharm = var_4_0.furniture_charm or 0
	self._wushMaxFloor = var_4_0.dead_battle_max_floor or 0
	self._arenaTopRank = var_4_0.arena_rank or 0
	self._knightSoulHonorNum = var_4_0.ksoul_honor or 0
	self._succubaTotalCharm = var_4_0.succuba_total_charm or 0
	self._bioMaxCampaign = var_4_0.biography_max_campaign or 0
end

function PlayerInfoData:onS2CPraiseExecute(arg_5_1)
	if self._playerUid ~= (arg_5_1.uid or 0) then
		return
	end
end

function PlayerInfoData:onS2CPlayerSign(arg_6_1)
	self._signStr = arg_6_1.content or ""
end

function PlayerInfoData:onS2CPlayerSetShow(arg_7_1)
	if type(arg_7_1.knight_show) == "table" then
		for iter_7_0, iter_7_1 in pairs(arg_7_1.knight_show) do
			self._knightShowList[iter_7_1.pos] = iter_7_1
		end
	else
		self._knightShowList = {}
	end
end

function PlayerInfoData:onS2CPraiseGetInfo(arg_8_1)
	self._userPraiseNum = arg_8_1.total_num or 0

	for iter_8_0, iter_8_1 in pairs(arg_8_1.has_awarded_ids or {}) do
		self._userPraiseAwardIdList[iter_8_1] = true
	end
end

function PlayerInfoData:onS2CPraiseGetAward(arg_9_1)
	local var_9_0 = arg_9_1.praise_id or 0

	if var_9_0 > 0 then
		self._userPraiseAwardIdList[var_9_0] = true
	end
end

function PlayerInfoData:_updateLineupKnightSid(arg_10_1)
	self._lineupKnightSids = {}

	for iter_10_0 = 1, 6 do
		if arg_10_1[iter_10_0] > 0 then
			self._lineupKnightSids[iter_10_0] = arg_10_1[iter_10_0]
		else
			break
		end
	end
end

function PlayerInfoData:_updateEquipmentData(arg_11_1)
	self._equipmentPosMap = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		local var_11_0 = EquipmentStruct.new(iter_11_1.id)

		var_11_0:setCfg((g.core.config.equipment_info.get(iter_11_1.base_id)))
		var_11_0:setServerData(iter_11_1)

		self._equipmentPosMap[iter_11_1.position] = var_11_0
		self._equipmentSidMap[iter_11_1.id] = var_11_0
	end
end

function PlayerInfoData:_updateEquipSuitData(arg_12_1)
	self._equipSuitPosMap = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_0 = math.ceil(iter_12_0 / 4)

		self._equipSuitPosMap[var_12_0] = self._equipSuitPosMap[var_12_0] or {}

		if iter_12_1 > 0 then
			table.insert(self._equipSuitPosMap[var_12_0], self._equipmentSidMap[iter_12_1])
		else
			table.insert(self._equipSuitPosMap[var_12_0], 0)
		end
	end
end

function PlayerInfoData:_updateTreasureData(arg_13_1)
	self._treasurePosMap = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_1) do
		self._treasurePosMap[iter_13_1.position] = iter_13_1
		self._treasureSidMap[iter_13_1.id] = iter_13_1
	end
end

function PlayerInfoData:getLineUpKnightSids()
	return self._lineupKnightSids
end

function PlayerInfoData:getEquipmentByPos(arg_15_1)
	return self._equipmentPosMap[arg_15_1]
end

function PlayerInfoData:getEquipmentBySid(arg_16_1)
	return self._equipmentSidMap[arg_16_1]
end

function PlayerInfoData:isEquipWearedSuitByBaseId(arg_17_1, arg_17_2)
	for iter_17_0 = 1, #self._equipSuitPosMap[arg_17_2] do
		if type(self._equipSuitPosMap[arg_17_2][iter_17_0]) ~= "number" and self._equipSuitPosMap[arg_17_2][iter_17_0].getCfg and math.uint64_equal(self._equipSuitPosMap[arg_17_2][iter_17_0]:getCfg().id, arg_17_1) then
			return true
		end
	end

	return false
end

function PlayerInfoData:getEquipSuitByKnightPos(arg_18_1)
	local var_18_0 = {}
	local var_18_1 = {}

	for iter_18_0 = 1, #self._equipSuitPosMap[arg_18_1] do
		if type(self._equipSuitPosMap[arg_18_1][iter_18_0]) ~= "number" and self._equipSuitPosMap[arg_18_1][iter_18_0].getCfg then
			table.insert(var_18_0, self._equipSuitPosMap[arg_18_1][iter_18_0]:getCfg().suit_id)
		end
	end

	for iter_18_1 = 1, #var_18_0 do
		var_18_1[var_18_0[iter_18_1]] = var_18_1[var_18_0[iter_18_1]] and var_18_1[var_18_0[iter_18_1]] + 1 or 1
	end

	return var_18_1
end

function PlayerInfoData:getSuitMagicalActiveMap(arg_19_1)
	local var_19_0 = {}

	for iter_19_0 = 1, 4 do
		if self._equipmentPosMap[(arg_19_1 - 1) * 4 + iter_19_0] then
			table.insert(var_19_0, self._equipmentPosMap[(arg_19_1 - 1) * 4 + iter_19_0])
		end
	end

	local var_19_1 = {}
	local var_19_2 = {}

	for iter_19_1, iter_19_2 in ipairs(var_19_0) do
		if iter_19_2:hasMagical() then
			local var_19_3 = iter_19_2:getQuality()
			local var_19_4 = iter_19_2:getSuitId()
			local var_19_5 = iter_19_2:getMagicalStage()

			if not var_19_1[var_19_4] then
				var_19_1[var_19_4] = {
					activeNum = 1,
					suitId = var_19_4,
					quality = var_19_3
				}
				var_19_2[var_19_4] = {
					var_19_5
				}
			else
				local var_19_6 = {
					suitId = var_19_4,
					quality = var_19_3
				}

				var_19_6.activeNum = var_19_1[var_19_4].activeNum + 1
				var_19_1[var_19_4] = var_19_6

				table.insert(var_19_2[var_19_4], var_19_5)
			end
		end
	end

	for iter_19_3, iter_19_4 in pairs(var_19_2) do
		table.sort(iter_19_4, function(arg_20_0, arg_20_1)
			return arg_20_0 < arg_20_1
		end)

		if var_19_1[iter_19_3].activeNum >= 4 then
			var_19_1[iter_19_3].minStage = iter_19_4[1] or -1
		end

		if var_19_1[iter_19_3].activeNum >= 2 then
			var_19_1[iter_19_3].maxStage = iter_19_4[#iter_19_4 - 1] or -1
		end

		var_19_1[iter_19_3].stageList = iter_19_4
	end

	return var_19_1
end

function PlayerInfoData:getTreasureByPos(arg_21_1)
	return self._treasurePosMap[arg_21_1]
end

function PlayerInfoData:getTreasureBySid(arg_22_1)
	return self._treasureSidMap[arg_22_1]
end

function PlayerInfoData:getTreasureSpecialAttrsScoreAndList(arg_23_1)
	local var_23_0 = 0
	local var_23_1 = {}

	if not self._treasureSidMap[arg_23_1] then
		return var_23_0, var_23_1
	end

	local var_23_2 = g.core.config.treasure_info.get(self._treasureSidMap[arg_23_1].base_id)

	if var_23_2.quality < 2 then
		return var_23_0, var_23_1
	end

	if #(self._treasureSidMap[arg_23_1].attr_pools or {}) < 1 then
		return var_23_0, var_23_1
	end

	for iter_23_0, iter_23_1 in ipairs(self._treasureSidMap[arg_23_1].attr_pools) do
		local var_23_3 = g.core.config.treasure_attribute_pool_info.fetch(iter_23_1.id)

		if var_23_3 then
			var_23_0 = var_23_0 + math.ceil((var_23_3.score_param or 0) / 1000 * iter_23_1.init_value)

			local var_23_5 = {
				attrPoolInfo = var_23_3.toObject(),
				type = var_23_3.pool_type
			}

			var_23_5.value = iter_23_1.init_value * (1 + (var_23_2.affix_growth or 0) * (self._treasureSidMap[arg_23_1].refining_level or 0) / 1000)

			table.insert(var_23_1, var_23_5)
		end
	end

	return var_23_0, var_23_1
end

function PlayerInfoData:getStrenAttr(arg_24_1, arg_24_2)
	local var_24_0 = g.core.config.treasure_info.get(self._treasureSidMap[arg_24_1].base_id)

	return {
		{
			name = g.core.config.attribute_info.get(var_24_0.basic_type_1).name,
			value = g.core.model.User.treasureData:getAttrValueByType(1, arg_24_2, self._treasureSidMap[arg_24_1].base_id),
			type = var_24_0.basic_type_1
		},
		{
			name = g.core.config.attribute_info.get(var_24_0.basic_type_2).name,
			value = g.core.model.User.treasureData:getAttrValueByType(2, arg_24_2, self._treasureSidMap[arg_24_1].base_id),
			type = var_24_0.basic_type_2
		}
	}
end

function PlayerInfoData:getTreasureGlyphInfo(arg_25_1)
	return (g.core.config.glyph_info.get(g.core.config.treasure_info.get(self._treasureSidMap[arg_25_1].base_id).treasure_glyph, self._treasureSidMap[arg_25_1].glyph_level))
end

function PlayerInfoData:getPurifyCfg(arg_26_1)
	local var_26_0 = {}

	if not self._treasureSidMap[arg_26_1] then
		return var_26_0
	end

	local var_26_1 = g.core.config.treasure_info.get(self._treasureSidMap[arg_26_1].base_id)

	var_26_0[#var_26_0 + 1] = g.core.config.treasure_purify_info.fetch(var_26_1.purify_id)
	var_26_0[#var_26_0 + 1] = g.core.config.treasure_purify_info.fetch(var_26_1.purify_id_2)

	return var_26_0
end

function PlayerInfoData:getTreasureFullPurifyScore(arg_27_1)
	local var_27_0 = self._treasureSidMap[arg_27_1].holes or {}
	local var_27_1 = 0
	local var_27_2 = 0

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		if iter_27_1.cur and iter_27_1.cur.id > 0 then
			var_27_1 = var_27_1 + self:getAttrPurifyCfg(iter_27_1.cur.id, iter_27_1.cur.group).attribute_score_parameter * iter_27_1.cur.init_value
		end
	end

	for iter_27_2, iter_27_3 in ipairs(var_27_0) do
		local var_27_3 = iter_27_3.tmp

		if iter_27_3.lock then
			var_27_3 = iter_27_3.cur
		end

		if var_27_3 and var_27_3.id > 0 then
			var_27_2 = var_27_2 + self:getAttrPurifyCfg(var_27_3.id, var_27_3.group).attribute_score_parameter * var_27_3.init_value
		end
	end

	return math.floor(var_27_1), math.floor(var_27_2)
end

function PlayerInfoData:getAttrPurifyCfg(arg_28_1, arg_28_2)
	arg_28_2 = not arg_28_2 and 1 or math.max(1, arg_28_2)

	for iter_28_0, iter_28_1 in g.core.config.treasure_purify_attribute_info.ipairs() do
		if iter_28_1.group == arg_28_2 and iter_28_1.attribute_type == arg_28_1 then
			return iter_28_1
		end
	end
end

function PlayerInfoData:hasTalent(arg_29_1)
	local var_29_0 = g.core.config.treasure_info.get((self._treasureSidMap[arg_29_1] or nil) and (self._treasureSidMap[arg_29_1].base_id or 0))

	if var_29_0 and var_29_0.talent_skill_1 ~= 0 then
		return true
	else
		return false
	end
end

function PlayerInfoData:getUserTotalPraiseNum()
	return self._userPraiseNum
end

function PlayerInfoData:getUserPraiseIdList()
	return self._userPraiseAwardIdList
end

function PlayerInfoData:getPlayerUid()
	return self._playerUid
end

function PlayerInfoData:getSignStr()
	return self._signStr
end

function PlayerInfoData:getTotalPraiseNum()
	return self._totalPraiseNum
end

function PlayerInfoData:getPraiseRank()
	return self._praiseRank
end

function PlayerInfoData:hasPraiseAward()
	return self._hasPraiseAward
end

function PlayerInfoData:getKnightNum()
	return self._knightNum
end

function PlayerInfoData:getKnightTissueList()
	return self._knightTissueList
end

function PlayerInfoData:getKnightTissueById(arg_39_1)
	return self._knightTissueList[arg_39_1]
end

function PlayerInfoData:getAllTissue()
	return self._tissueList
end

function PlayerInfoData:getKnightShowList()
	return self._knightShowList
end

function PlayerInfoData:getTitleShowList()
	return self._titleShowList
end

function PlayerInfoData:getPlayerSnapShot()
	return self._playerSnapShot
end

function PlayerInfoData:canPraise()
	return self._canPraise
end

function PlayerInfoData:getFurnitureRoomComfort()
	return self._furnitureRoomComfort
end

function PlayerInfoData:getFurnitureRoomCharm()
	return self._furnitureCharm
end

function PlayerInfoData:getFurniturePraise()
	return self._furniturePraise
end

function PlayerInfoData:getFurnitureNum()
	return self._furnitureNum
end

function PlayerInfoData:getDungeonStage()
	return self._dungeonStageProgress
end

function PlayerInfoData:getPassDungeonChapter()
	local var_50_0 = g.core.config.dungeon_stage_info.get(self._dungeonStageProgress)
	local var_50_1 = true

	for iter_50_0, iter_50_1 in ipairs((g.core.config.dungeon_stage_info.match(function(arg_51_0)
		if arg_51_0.chapter_id == var_50_0.chapter_id then
			return true
		end
	end))) do
		if var_50_0.id < iter_50_1.id then
			var_50_1 = false
		end
	end

	return (var_50_1 or nil) and (var_50_0.chapter_id or var_50_0.chapter_id - 1)
end

function PlayerInfoData:getWushMaxFloor()
	return self._wushMaxFloor
end

function PlayerInfoData:getArenaTopRank()
	return self._arenaTopRank
end

function PlayerInfoData:getKnightSoulHonorNum()
	return self._knightSoulHonorNum or 0
end

function PlayerInfoData:getSuccubaTotalCharm()
	return self._succubaTotalCharm
end

function PlayerInfoData:getBioMaxCampaign()
	return self._bioMaxCampaign
end

function PlayerInfoData:isLocalServer()
	return tostring(self._playerSnapShot.sid or 0) == tostring((g.core.platform.ServerListProxy:getCurServer() or {}).id)
end

function PlayerInfoData:isUserSelf()
	return g.core.model.User:getId() == self._playerUid
end

function PlayerInfoData:getAssistantResInfo()
	local var_59_0 = self._playerSnapShot.show_knight_id or 0
	local var_59_1 = self._playerSnapShot.show_knight_dress or 0
	local var_59_2

	if var_59_1 > 0 then
		var_59_2 = var_0_0.get(g.core.config.skin_info.get(var_59_1).res)
	elseif var_59_0 > 0 then
		var_59_2 = var_0_0.get(var_0_2.get(var_59_0).res_id)
	end

	return var_59_2
end

function PlayerInfoData:getKnightStructList()
	local KnightStruct = require("app.view.module.knight.model.KnightStruct")
	local var_60_1 = self._playerSnapShot.knights or {}
	local var_60_2 = {}

	for iter_60_0 = 1, var_0_3.LINEUP_MAX do
		if var_60_1[iter_60_0] and var_60_1[iter_60_0] > 0 then
			local var_60_3 = var_0_2.get(var_60_1[iter_60_0])
			local var_60_4 = KnightStruct.new(var_60_3.advance_id)

			var_60_4:addCfgInfo(var_60_3)

			var_60_2[iter_60_0] = var_60_4
		end
	end

	return var_60_2
end

function PlayerInfoData:getSelfData()
	return {}
end

return PlayerInfoData
