local var_0_0 = g.core.const.ConstMgr.FogNightmareConst
local FogNightmareTowerStageStruct = require("app.view.module.fogNightmare.model.struct.FogNightmareTowerStageStruct")
local FogNightmareTowerFloorStruct = class("FogNightmareTowerFloorStruct")

function FogNightmareTowerFloorStruct:ctor(arg_1_1)
	self._id = arg_1_1
	self._cfg = nil
	self._state = var_0_0.FLOOR_STATE.NONE
	self._lockInfo = {}
	self._firstAwards = {}
	self._phaseAwards = {}
	self._phaseAwardInfo = {}
	self._stages = {}
	self._selectedStages = {}

	self:_initStructByTabConfig()
end

function FogNightmareTowerFloorStruct:_initStructByTabConfig()
	self._cfg = g.core.config.fog_floor_info.get(self._id)

	if self._cfg.first_bonus > 0 then
		self._firstAwards = g.core.common.Drops:getGoodsArray(self._cfg.first_bonus)
	end

	if self._cfg.phase_bonus > 0 then
		self._phaseAwards = g.core.common.Drops:getGoodsArray(self._cfg.phase_bonus)
	end

	self._firstAwardsReceive = false
	self._phaseAwardsReceive = false

	local var_2_0 = 1

	while g.core.config.fog_floor_info.hasKey("stage_" .. 1) do
		if self._cfg["stage_" .. 1] ~= 0 then
			self._stages[var_2_0] = FogNightmareTowerStageStruct.new(self._cfg["stage_" .. 1], self._cfg["stage_story_" .. var_2_0], self._id .. "_" .. self._cfg["stage_" .. 1])
		end

		var_2_0 = var_2_0 + 1
	end
end

function FogNightmareTowerFloorStruct:reset()
	self._phaseAwardInfo = {}
end

function FogNightmareTowerFloorStruct:clearInfo()
	for iter_4_0, iter_4_1 in ipairs(self._stages) do
		iter_4_1:reset()
	end

	self._selectedStages = {}
	self._state = var_0_0.STAGE_STATE.NONE
end

function FogNightmareTowerFloorStruct:getFloorId()
	return self._id
end

function FogNightmareTowerFloorStruct:getCfg()
	return self._cfg
end

function FogNightmareTowerFloorStruct:getFloorBgRes()
	return self._cfg.bg
end

function FogNightmareTowerFloorStruct:checkAndFixFloorState()
	self._lockInfo = {}

	if self._state >= var_0_0.FLOOR_STATE.WAIT_SELECT then
		return true
	end

	local var_8_0 = true

	self._state = var_0_0.FLOOR_STATE.WAIT_SELECT

	local var_8_1, var_8_2 = g.core.model.User.fogNightmareData:getSeasonOpenDays()

	if var_8_1 < self._cfg.open_days then
		self._lockInfo.time = (self._cfg.open_days - var_8_2 - 1) * 86400
		self._state = var_0_0.FLOOR_STATE.LOCK
		var_8_0 = false
	elseif g.core.model.User.fogNightmareData:getFogLevel() < self._cfg.open_level then
		self._state = var_0_0.FLOOR_STATE.LOCK
		self._lockInfo.level = self._cfg.open_level
		var_8_0 = false
	end

	return var_8_0
end

function FogNightmareTowerFloorStruct:getFirstAwards()
	return self._firstAwards
end

function FogNightmareTowerFloorStruct:setReceivedFirstAwards()
	self._firstAwardsReceive = true
end

function FogNightmareTowerFloorStruct:isReceivedFirstAwards()
	return self._firstAwardsReceive
end

function FogNightmareTowerFloorStruct:getPhaseAwards()
	return self._phaseAwards
end

function FogNightmareTowerFloorStruct:_updatePhaseAwardInfo()
	self._phaseAwardInfo.received = self._phaseAwardsReceive
	self._phaseAwardInfo.floor = self._id
	self._phaseAwardInfo.awards = self._phaseAwards
	self._phaseAwardInfo.showInfo = self._cfg.show_type > 0 and {
		type = self._cfg.show_type,
		value = self._cfg.show_value
	} or nil
end

function FogNightmareTowerFloorStruct:getPhaseAwardInfo()
	self:_updatePhaseAwardInfo()

	return self._phaseAwardInfo
end

function FogNightmareTowerFloorStruct:setReceivedPhaseAwards()
	self._phaseAwardsReceive = true

	self:_updatePhaseAwardInfo()
end

function FogNightmareTowerFloorStruct:isReceivedPhaseAwards()
	return self._phaseAwardsReceive
end

function FogNightmareTowerFloorStruct:getLockInfo()
	return self._lockInfo
end

function FogNightmareTowerFloorStruct:getKeepsakeLevel(arg_18_1)
	if arg_18_1 then
		return self._cfg.fast_seal_level
	else
		return self._cfg.seal_level
	end
end

function FogNightmareTowerFloorStruct:getStoryId()
	return self._cfg.story_id
end

function FogNightmareTowerFloorStruct:isStoryShowOver()
	return g.core.model.User.fogNightmareData:getTowerData():isStoryFinish(tostring(self._id))
end

function FogNightmareTowerFloorStruct:setStoryIsOver()
	self._storyShowOver = true
end

function FogNightmareTowerFloorStruct:getStages()
	return self._stages
end

function FogNightmareTowerFloorStruct:getStage(arg_23_1)
	local var_23_0

	for iter_23_0, iter_23_1 in pairs(self._stages) do
		if arg_23_1 == iter_23_1:getStageId() then
			var_23_0 = iter_23_1

			break
		end
	end

	return var_23_0
end

function FogNightmareTowerFloorStruct:selectStage(arg_24_1)
	local var_24_0

	for iter_24_0, iter_24_1 in pairs(self._stages) do
		if iter_24_1:getStageId() == arg_24_1 then
			var_24_0 = iter_24_1

			break
		end
	end

	self._selectedStages[#self._selectedStages + 1] = var_24_0
end

function FogNightmareTowerFloorStruct:getSelectedStage()
	return self._selectedStages
end

function FogNightmareTowerFloorStruct:updateByNetInfo(arg_26_1)
	return
end

return FogNightmareTowerFloorStruct
