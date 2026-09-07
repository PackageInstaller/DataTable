local NewEducateRound = class("NewEducateRound", import("model.vo.BaseVO"))

NewEducateRound.TYPE = {
	NORMAL = 1,
	ENDLESS = 2
}

function NewEducateRound:bindConfigTable()
	return pg.child2_round
end

function NewEducateRound:Ctor(arg_2_1)
	self.difficulty = arg_2_1.difficulty

	self:InitConfig(arg_2_1.id)
	self:InitEndlessConfig(arg_2_1.id)

	local var_2_0 = arg_2_1.round

	self.round = arg_2_1.round.round
	self.isTemp = var_2_0.in_temp == 1
	self.tempCnt = var_2_0.temp_round

	self:InitRoundId()

	self.isEndlessFail = arg_2_1.eval_fail == 1

	return
end

function NewEducateRound:InitConfig(arg_3_1)
	self.round2Id = {}
	self.assessRoundIds = {}
	self.talentRoundIds = {}

	for iter_3_0, iter_3_1 in ipairs(pg.child2_round.get_id_list_by_character[arg_3_1]) do
		if pg.child2_round[iter_3_1].round_type == NewEducateRound.TYPE.NORMAL and self.difficulty == pg.child2_round[iter_3_1].is_hard_mode then
			self.round2Id[pg.child2_round[iter_3_1].round] = iter_3_1

			if pg.child2_round[iter_3_1].target_id ~= 0 then
				table.insert(self.assessRoundIds, pg.child2_round[iter_3_1].round)
			end

			if pg.child2_round[iter_3_1].benefit_select ~= "" and #pg.child2_round[iter_3_1].benefit_select ~= 0 then
				table.insert(self.talentRoundIds, pg.child2_round[iter_3_1].round)
			end
		end
	end

	table.sort(self.assessRoundIds)
	table.sort(self.talentRoundIds)

	self.gameRoundCnt = #underscore.keys(self.round2Id)

	return
end

function NewEducateRound:InitRoundId()
	if self:IsEndless() then
		self:InitEndlessRoundId()
	else
		self.id = self.round2Id[self.round]
		self.configId = self.id
	end

	return
end

function NewEducateRound:GetTalentRoundIds()
	return self.talentRoundIds
end

function NewEducateRound:IsTalentRound()
	return not self:IsTemp() and table.contains(self.talentRoundIds, self.round)
end

function NewEducateRound:IsShowAssessTip()
	if self.round == 1 then
		return true
	end

	for iter_7_0, iter_7_1 in ipairs(self.assessRoundIds) do
		if self.round == iter_7_1 + 1 then
			return true
		end
	end

	return false
end

function NewEducateRound:GetProgressInfo()
	local var_8_0 = underscore.detect(self.assessRoundIds, function(arg_9_0)
		return arg_9_0 >= self.round
	end)

	return self.round, var_8_0 - self.round, pg.child2_target[pg.child2_round[self.round2Id[var_8_0]].target_id].attr_sum
end

function NewEducateRound:GetGameRoundCnt()
	return self.gameRoundCnt
end

function NewEducateRound:IsEndRound()
	return not self.round2Id[self.round + 1]
end

function NewEducateRound:OnNextRound()
	if self.tempCnt > 0 then
		self.tempCnt = self.tempCnt - 1
		self.isTemp = true
	else
		self.isTemp = false
		self.round = self.round + 1
	end

	self:InitRoundId()

	return
end

function NewEducateRound:IsTemp()
	return self.isTemp
end

function NewEducateRound:NextIsTemp()
	return self.tempCnt > 0
end

function NewEducateRound:AddTempCnt(arg_15_1)
	self.tempCnt = self.tempCnt + arg_15_1

	return
end

function NewEducateRound:ExistEndless()
	return #self.cycleIds > 0
end

function NewEducateRound:InitEndlessConfig(arg_17_1)
	self.cycleIds = {}

	for iter_17_0, iter_17_1 in ipairs(pg.child2_round.get_id_list_by_character[arg_17_1]) do
		if pg.child2_round[iter_17_1].round_type == NewEducateRound.TYPE.ENDLESS and self.difficulty == pg.child2_round[iter_17_1].is_hard_mode then
			table.insert(self.cycleIds, iter_17_1)
		end
	end

	table.sort(self.cycleIds)

	self.endlessRoundCnt = #self.cycleIds

	return
end

function NewEducateRound:InitEndlessRoundId()
	self.cycleCnt = 1 + math.floor((self.round - self.gameRoundCnt) / self.endlessRoundCnt)
	self.cycleIdx = (self.round - self.gameRoundCnt) % self.endlessRoundCnt

	if self.cycleIdx == 0 then
		self.cycleIdx = #self.cycleIds
	end

	self.id = self.cycleIds[self.cycleIdx]
	self.configId = self.id

	return
end

function NewEducateRound:IsEndless()
	return self.round > self.gameRoundCnt
end

function NewEducateRound:GetWave()
	return self.round - self.gameRoundCnt
end

function NewEducateRound:IsEndlessFail()
	return self:IsEndless() and self.isEndlessFail
end

function NewEducateRound:SetEndlessFail()
	self.isEndlessFail = true

	return
end

function NewEducateRound:GetHeighestWave()
	return getProxy(NewEducateProxy):GetCurChar():GetPermanentData():GetMaxRound() - self.gameRoundCnt
end

function NewEducateRound:GetExtraFactor()
	if not self:IsEndless() then
		return 1
	end

	local var_24_0 = self:getConfig("endless_factor")

	for iter_24_0, iter_24_1 in ipairs(pg.gameset[self.difficulty == NewEducateChar.DIFFICULTY.EASY and "child2_endless_loop_extra_factor" or "child2_endless_loop_extra_factor_hard"].description) do
		if self.round >= iter_24_1[1] and self.round <= iter_24_1[2] then
			return iter_24_1[3] * (tonumber(var_24_0) or 1)
		end
	end

	return pg.gameset[self.difficulty == NewEducateChar.DIFFICULTY.EASY and "child2_endless_loop_extra_factor" or "child2_endless_loop_extra_factor_hard"].description[#pg.gameset[self.difficulty == NewEducateChar.DIFFICULTY.EASY and "child2_endless_loop_extra_factor" or "child2_endless_loop_extra_factor_hard"].description][3] * (tonumber(var_24_0) or 1)
end

function NewEducateRound:GetEndlessProgressInfos()
	local var_25_0 = self:GetWave()

	return var_25_0, var_25_0 > self:GetHeighestWave(), pg.child2_target[self:getConfig("target_id")].attr_sum * self:GetExtraFactor()
end

return NewEducateRound
