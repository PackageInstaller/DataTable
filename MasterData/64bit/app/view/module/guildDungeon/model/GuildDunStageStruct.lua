local GuildDunStageStruct = class("GuildDunStageStruct")
local var_0_2 = g.core.config.monster_team_info
local var_0_3 = g.core.config.monster_info

function GuildDunStageStruct:ctor(arg_1_1)
	self._stageId = arg_1_1
	self._numAward = 0
	self._rebirth = 1
	self._stageAward = {}
	self._cfg = {}
	self._isMvpRec = false
	self._damageHpArr = {}
	self._memberIdList = {}
	self._memberDamage = {}
	self._memberRecord = {}
	self._mvpMember = nil
	self._maxDamage = 0
	self._stageRecAward = {}
	self._stageTreasure = {}
	self._awardNumData = {}
	self._mvpId = 0
	self._isReceive = false
	self._dynamicDamage = 0
end

function GuildDunStageStruct:getCfg()
	return self._cfg
end

function GuildDunStageStruct:setCfg(arg_3_1, arg_3_2, arg_3_3)
	self._cfg = arg_3_1

	self:updateStageFinalAward(arg_3_2, arg_3_3)
end

function GuildDunStageStruct:setRebirth(arg_4_1)
	self._rebirth = arg_4_1
end

function GuildDunStageStruct:getStageId()
	return self._cfg.id
end

function GuildDunStageStruct:updateStageFinalAward(arg_6_1, arg_6_2)
	self._stageAward = {}
	self._numAward = 0
	self._stageAward = arg_6_1[self._cfg.final_award] or {}
	self._numAward = arg_6_2[self._cfg.final_award] or 0

	for iter_6_0 = 1, self._numAward do
		self._stageTreasure[iter_6_0] = {}
	end
end

function GuildDunStageStruct:updateStageAwardNum()
	self._awardNumData = {}

	for iter_7_0 = 1, #self._stageAward do
		self._awardNumData[self._stageAward[iter_7_0].id] = 0
	end

	for iter_7_1, iter_7_2 in pairs(self._stageTreasure) do
		if iter_7_2.awardId then
			self._awardNumData[iter_7_2.awardId] = self._awardNumData[iter_7_2.awardId] and self._awardNumData[iter_7_2.awardId] + 1 or 0
		end
	end
end

function GuildDunStageStruct:getStageTotalHp()
	local var_8_0 = 0
	local var_8_1 = var_0_2.get(self._cfg.monster_group, 1)

	for iter_8_0 = 1, g.core.const.ConstMgr.GuildDungeonConst.MONSTER_NUM do
		if var_8_1["monster_" .. iter_8_0] > 0 then
			var_8_0 = math.uint64_add(var_8_0, var_0_3.get(var_8_1["monster_" .. iter_8_0]).initial_hp)
		end
	end

	return var_8_0
end

function GuildDunStageStruct:setServerData(arg_9_1)
	self._dynamicDamage = 0
	self._memberRecord = {}
	self._isMvpRec = arg_9_1.mvp_awarded or false
	self._damageHpArr = arg_9_1.monster_hp or {}
	self._memberIdList = arg_9_1.member_id
	self._memberDamage = arg_9_1.member_damage

	if self._memberIdList and next(self._memberIdList) then
		for iter_9_0 = 1, #self._memberIdList do
			table.insert(self._memberRecord, {
				id = self._memberIdList[iter_9_0],
				damage = self._memberDamage[iter_9_0]
			})
		end

		table.sort(self._memberRecord, function(arg_10_0, arg_10_1)
			if not math.uint64_equal(arg_10_0.damage, arg_10_1.damage) then
				return not math.uint64_lt(arg_10_0.damage, arg_10_1.damage, true)
			end
		end)
	end

	self:_updateStageMvpId()

	if arg_9_1.acquired_pos and next(arg_9_1.acquired_pos) then
		for iter_9_1 = 1, #arg_9_1.acquired_pos do
			self._stageTreasure[arg_9_1.acquired_pos[iter_9_1]].pos = arg_9_1.acquired_pos[iter_9_1]
			self._stageTreasure[arg_9_1.acquired_pos[iter_9_1]].playerId = arg_9_1.acquired_uid[iter_9_1]
			self._stageTreasure[arg_9_1.acquired_pos[iter_9_1]].awardId = arg_9_1.acquired_box[iter_9_1]
		end
	end

	self:updateStageAwardNum()
end

function GuildDunStageStruct:updateMvpAwardState()
	self._isMvpRec = true
end

function GuildDunStageStruct:updateStageTreasure(arg_12_1)
	self._stageTreasure[arg_12_1.position].pos = arg_12_1.position
	self._stageTreasure[arg_12_1.position].playerId = g.core.model.User:getId()
	self._stageTreasure[arg_12_1.position].award = arg_12_1.awards[1]
	self._stageTreasure[arg_12_1.position].awardId = arg_12_1.award_id[1]

	self:updateStageAwardNum()
end

function GuildDunStageStruct:setReceiveState(arg_13_1)
	self._isReceive = arg_13_1
end

function GuildDunStageStruct:isRecTreasure()
	if self._isReceive then
		return true
	end

	for iter_14_0, iter_14_1 in pairs(self._stageTreasure) do
		if iter_14_1.playerId == g.core.model.User:getId() then
			return true
		end
	end

	return false
end

function GuildDunStageStruct:_updateStageMvpId()
	if not self:isStageFinish() then
		return
	end

	if self._memberDamage and next(self._memberDamage) then
		for iter_15_0 = 1, #self._memberDamage do
			if math.uint64_lt(self._maxDamage, self._memberDamage[iter_15_0]) then
				self._maxDamage = self._memberDamage[iter_15_0]
				self._mvpId = self._memberIdList[iter_15_0]
			end
		end

		self._mvpMember = g.core.model.User.guildData:getGuildMemberByPlayerId(self._mvpId)

		if not self._mvpMember then
			self._mvpId = 0
		end
	end
end

function GuildDunStageStruct:getStageCurHp()
	local var_16_0 = self:getStageTotalHp()

	for iter_16_0 = 1, #self._damageHpArr do
		var_16_0 = math.uint64_sub(var_16_0, self._damageHpArr[iter_16_0])
	end

	var_16_0 = var_16_0 > 0 and var_16_0 or 0

	return var_16_0
end

function GuildDunStageStruct:isStageFinish()
	return math.uint64_equal(self:getStageCurHp(), 0)
end

function GuildDunStageStruct:updateDamage(arg_18_1)
	self._dynamicDamage = self._dynamicDamage + arg_18_1

	table.insert(self._damageHpArr, arg_18_1)
end

function GuildDunStageStruct:getMonsterDamageHpArr()
	return self._damageHpArr
end

function GuildDunStageStruct:getStageFinalAward()
	return self._stageAward
end

function GuildDunStageStruct:getMemberRecord()
	return self._memberRecord
end

function GuildDunStageStruct:getMvpData()
	return self._mvpMember
end

function GuildDunStageStruct:getMvpId()
	return self._mvpId
end

function GuildDunStageStruct:getAwardNum()
	return self._numAward
end

function GuildDunStageStruct:getStageTreasure()
	return self._stageTreasure
end

function GuildDunStageStruct:isRecMvpAward()
	return self._isMvpRec
end

function GuildDunStageStruct:getStageAwardNum()
	return self._awardNumData
end

return GuildDunStageStruct
