-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\StepTowerMixin.lua

local ResTower = require("ClientData/ResTower")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResTowerLayerAward = require("ClientData/ResTowerLayerAward")
local StepTowerMixin = {}

function StepTowerMixin:initStepTowerMixin(baseData, syncData)
	self:initStepTowerData(baseData.necessary.tower)
end

function StepTowerMixin:initStepTowerData(towerData)
	self.stepTowerData = {}
	self.stepTowerData.curPos = {}

	self:refreshCurPos(towerData.last_record)

	self.stepTowerLayerData = utils.deepcopy(towerData.data) or {}

	for i, v in ipairs(self.stepTowerLayerData) do
		self.stepTowerLayerData[i].award_get = self:getStepTowerAwardGet(self.stepTowerLayerData[i].award_bit)
		self.stepTowerLayerData[i].stage = {}

		for _, baseData in ipairs(self.stepTowerLayerData[i].base or {}) do
			self.stepTowerLayerData[i].stage[baseData.id] = baseData
			self.stepTowerLayerData[i].stage[baseData.id].num = 0
		end
	end

	for i, v in ipairs(towerData.play) do
		local layer, stage = self:getLayerStageById(v.id)

		self.stepTowerLayerData[layer].stage[stage].num = v.num
	end

	for i, v in ipairs(ResTower) do
		if not self.stepTowerLayerData[i] then
			self.stepTowerLayerData[i] = {}
			self.stepTowerLayerData[i].star_count = 0
			self.stepTowerLayerData[i].award_get = self:getStepTowerAwardGet(0)
			self.stepTowerLayerData[i].stage = {}
		end
	end
end

function StepTowerMixin:onTowerSweepResp(sweepData)
	for _, data in ipairs(sweepData) do
		local layer = data.layer
		local level = data.level
		local times = data.times

		self.stepTowerLayerData[layer].stage[level].num = self.stepTowerLayerData[layer].stage[level].num + times

		local stepTowerDlg = UIManager.getUI("stepTowerDlg", nil, false)

		if stepTowerDlg then
			stepTowerDlg:refreshForSweep(self.stepTowerLayerData[layer].stage[level].num)
		end
	end
end

function StepTowerMixin:onTowerStarAwardGetResp(layer, award)
	self.stepTowerLayerData[layer].award_get[award] = true

	self:refreshStepTowerPanel(layer)
end

function StepTowerMixin:checkAllStepTowerCanBattle()
	local layer = self.stepTowerData.curPos.layer
	local level = self.stepTowerData.curPos.stage

	RedDotManager.setKeyState(UIConst.RD_HINT_STEPTOWER, not self:isTotalTop(layer, level) and self:getPriestsAverageLv() >= ResTower[layer][level].unlock_level)
end

function StepTowerMixin:isTotalTop(layer, level)
	if layer == #ResTower and level == #ResTower[layer] and self.stepTowerLayerData[layer] and self.stepTowerLayerData[layer].stage and self.stepTowerLayerData[layer].stage[level] and self.stepTowerLayerData[layer].stage[level].star then
		return self.stepTowerLayerData[layer].stage[level].star > 0
	end
end

function StepTowerMixin:checkStepTowerUnlock(layer, level)
	local curLayer = CurAvatar.stepTowerData.curPos.layer
	local curLevel = CurAvatar.stepTowerData.curPos.stage

	if curLayer == layer and curLevel == level then
		return true
	end

	if layer < curLayer then
		return true
	elseif layer == curLayer and level < curLevel then
		return true
	end

	return self:checkStepTowerCanSweep(layer, level)
end

function StepTowerMixin:refreshStepTowerPanel(layer)
	local stepTowerDlg = UIManager.getUI("stepTowerDlg", nil, false)

	if stepTowerDlg then
		stepTowerDlg:selectLayer(layer, stepTowerDlg.layerList[layer].selectLevelBtn.resData.level)
	end
end

function StepTowerMixin:getStepTowerLayerData(layer)
	local layerData = {}

	layerData.resData = ResTower[layer]

	local myLayer = layerData.resData[1].layer
	local maxStar = 0

	for i, v in ipairs(ResTower[myLayer]) do
		if v.need_record == 1 then
			maxStar = maxStar + 3
		end
	end

	layerData.svrData = self.stepTowerLayerData[myLayer]
	layerData.svrData.maxStar = maxStar

	return layerData
end

function StepTowerMixin:getStepTowerAwardGet(award_bit)
	local award_get = {}

	for i = 1, 3 do
		award_get[i] = false
	end

	if award_bit ~= 0 then
		local awardGetList = ClientUtils.getBitsListFromByteString(award_bit)

		for i, pos in ipairs(awardGetList) do
			award_get[pos] = true
		end
	end

	return award_get
end

function StepTowerMixin:getLayerStageById(id)
	if id == 0 then
		return 1, 0
	end

	local layer = bit.rshift(id, 16)
	local stage = bit.band(id, 4095)

	return layer, stage
end

function StepTowerMixin:onTowerDataNotify(tower, record, layer_star_count)
	for k, v in pairs(tower) do
		-- block empty
	end

	if not self.stepTowerLayerData[tower.layer].stage[tower.level] then
		self.stepTowerLayerData[tower.layer].stage[tower.level] = {}
		self.stepTowerLayerData[tower.layer].stage[tower.level].id = tower.level
	end

	local curStar = self.stepTowerLayerData[tower.layer].stage[tower.level].star

	if not curStar or curStar < tower.star then
		self.stepTowerLayerData[tower.layer].stage[tower.level].star = tower.star
	end

	if not self.stepTowerLayerData[tower.layer].stage[tower.level].num then
		self.stepTowerLayerData[tower.layer].stage[tower.level].num = 0
	end

	self.stepTowerLayerData[tower.layer].star_count = layer_star_count

	self:refreshCurPos(record, true)
	self:checkAllStepTowerCanBattle()
	self:checkCanSweepStepInTeamHeros()
end

function StepTowerMixin:refreshCurPos(record, isRefresh)
	local lastLayer, lastStage = self:getLayerStageById(self.stepTowerRecord or 0)

	self.stepTowerRecord = record

	local layer, stage = self:getLayerStageById(record)

	self.stepTowerData.curPos.layer = stage == #ResTower[layer] and layer + 1 or layer
	self.stepTowerData.curPos.stage = stage == #ResTower[layer] and 1 or stage + 1

	if self.stepTowerData.curPos.layer > #ResTower then
		self.stepTowerData.curPos.layer = #ResTower
		self.stepTowerData.curPos.stage = #ResTower[#ResTower]
	end

	if isRefresh and (layer < lastLayer or layer == lastLayer and stage < lastStage) then
		for l = self.stepTowerData.curPos.layer, #self.stepTowerLayerData do
			if l == self.stepTowerData.curPos.layer then
				for k, v in pairs(self.stepTowerLayerData[l].stage) do
					-- block empty
				end

				for s = self.stepTowerData.curPos.stage, #self.stepTowerLayerData[l].stage do
					self.stepTowerLayerData[l].stage[s].star = 0
					self.stepTowerLayerData[l].stage[s].num = 0
				end
			else
				for st, _ in ipairs(self.stepTowerLayerData[l].stage) do
					self.stepTowerLayerData[l].stage[st].star = 0
					self.stepTowerLayerData[l].stage[st].num = 0
				end
			end
		end
	end
end

function StepTowerMixin:getIdByLayerStage(layer, stage)
	local stageId = bit.bor(bit.lshift(layer, 16), stage)

	return stageId
end

function StepTowerMixin:checkStepTowerCanSweep(layer, stage)
	if self.stepTowerLayerData[layer] and self.stepTowerLayerData[layer].stage and self.stepTowerLayerData[layer].stage[stage] and self.stepTowerLayerData[layer].stage[stage].star then
		return self.stepTowerLayerData[layer].stage[stage].star > 0
	end

	return false
end

function StepTowerMixin:getStepTowerStar(layer, level)
	local star = 0

	if self.stepTowerLayerData[layer] and self.stepTowerLayerData[layer].stage and self.stepTowerLayerData[layer].stage[level] and self.stepTowerLayerData[layer].stage[level].star then
		star = self.stepTowerLayerData[layer].stage[level].star
	end

	return star
end

function StepTowerMixin:checkStepTowerIsNowPass(layer, stage)
	local recordLayer, recordStage = self:getLayerStageById(self.stepTowerRecord)

	return recordLayer == layer and recordStage == stage
end

function StepTowerMixin:getSweepBonusDataStruct(attrs, items)
	local tower = {}

	tower.add_xp = 0
	tower.add_gold = 0

	for i, v in ipairs(attrs) do
		if v.type == Const.MONEY_TYPE_EXP then
			tower.add_xp = v.value
		end

		if v.type == Const.MONEY_TYPE_GOLD then
			tower.add_gold = v.value
		end
	end

	tower.add_item = {}

	for i, v in ipairs(items) do
		local add_item = {}

		add_item.item = v

		table.insert(tower.add_item, add_item)
	end

	return tower
end

function StepTowerMixin:onTowerPlayClearNotify(time)
	for _, layer in pairs(self.stepTowerLayerData) do
		for _, stageData in pairs(layer.stage) do
			stageData.num = 0
		end
	end
end

function StepTowerMixin:stepTowerRecoveryMainState(result, layer, level)
	local stepTowerDlg = UIManager.getUI("stepTowerDlg", true)
	local isTopLayerStage = layer == #ResTower and level == #ResTower[#ResTower]

	if result == BattleConst.BATTLE_RESULT_WIN and not isTopLayerStage then
		local curLayer = self.stepTowerData.curPos.layer
		local curLevel = self.stepTowerData.curPos.stage

		if self.isAtkCurStepLevel and curLevel ~= 1 then
			stepTowerDlg:selectLayer(curLayer, curLevel)
			stepTowerDlg:setContentAlign(layer, level)
		elseif self.isAtkCurStepLevel then
			stepTowerDlg:playUnLockEffect(curLayer)
			stepTowerDlg:jumpToCurStage()
			stepTowerDlg:setContentAlign(math.max(1, layer), 1)
		else
			stepTowerDlg:selectLayer(layer, level)
			stepTowerDlg:setContentAlign(layer, level)
		end
	else
		stepTowerDlg:selectLayer(layer, level)
		stepTowerDlg:setContentAlign(layer, level)
	end
end

return StepTowerMixin
