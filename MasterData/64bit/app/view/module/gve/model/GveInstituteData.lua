local var_0_0 = g.core.config.gve_research_info
local var_0_1 = g.core.config.gve_study_knight_info
local var_0_2 = g.core.const.ConstMgr.GveConst
local GveInstituteStruct = require("app.view.module.gve.model.struct.GveInstituteStruct")
local GveInstituteData = class("GveInstituteData")

function GveInstituteData:ctor()
	self._researchList = {}
	self._knightResearch = {}

	self:initData()
	self:initCfg()
end

function GveInstituteData:initData()
	return
end

function GveInstituteData:initCfg()
	for iter_3_0 = 1, var_0_0.getLength() do
		table.insert(self._researchList, (GveInstituteStruct.new(var_0_0.indexOf(iter_3_0))))
	end

	for iter_3_1 = 1, var_0_1.getLength() do
		local var_3_0 = var_0_1.indexOf(iter_3_1)

		self._knightResearch[var_3_0.advance_id .. "_" .. var_3_0.star] = var_3_0
	end
end

function GveInstituteData:getInstituteStruct()
	return self._researchList
end

function GveInstituteData:getKnightResearchSpeed(arg_5_1, arg_5_2)
	if not arg_5_1 or not arg_5_2 then
		return 0
	end

	local var_5_0 = self._knightResearch[arg_5_1 .. "_" .. arg_5_2]

	if not self._knightResearch[arg_5_1 .. "_" .. arg_5_2] then
		return 0
	end

	return math.floor(3600 / var_5_0.time * var_5_0.points)
end

function GveInstituteData:getCanRewardTime(arg_6_1, arg_6_2)
	if not arg_6_1 or not arg_6_2 then
		return 0
	end

	local var_6_0 = self._knightResearch[arg_6_1 .. "_" .. arg_6_2]

	if not self._knightResearch[arg_6_1 .. "_" .. arg_6_2] then
		return 0
	end

	return var_6_0.time
end

function GveInstituteData:getInstituteByType(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(self._researchList) do
		if iter_7_1:getEventCfg().type == arg_7_1 then
			return iter_7_1
		end
	end
end

function GveInstituteData:getRandBossAward()
	local var_8_0 = self:getInstituteByType(var_0_2.GVE_INSTITUTE_TYPE.RAND_BOSS)

	if not var_8_0 then
		return {}
	end

	local var_8_1 = {}

	for iter_8_0 = 4, 7 do
		table.insert(var_8_1, var_8_0:getEventValue(iter_8_0))
	end

	local var_8_2 = {}
	local var_8_3 = {}

	for iter_8_1, iter_8_2 in ipairs(var_8_1) do
		for iter_8_3, iter_8_4 in ipairs((g.core.common.Drops:getGoodsArray(iter_8_2))) do
			if not var_8_3[iter_8_4.type .. "_" .. iter_8_4.value] then
				var_8_3[iter_8_4.type .. "_" .. iter_8_4.value] = true

				table.insert(var_8_2, iter_8_4)
			end
		end
	end

	return var_8_2
end

function GveInstituteData:onGetResearchData(arg_9_1)
	local var_9_0 = self:getInstituteByType(var_0_2.GVE_INSTITUTE_TYPE.RAND_BOSS)

	if var_9_0 then
		var_9_0:setProgressValue(arg_9_1.boss_research or 0)
	end

	local var_9_2 = self:getInstituteByType(var_0_2.GVE_INSTITUTE_TYPE.RESEARCH)

	if var_9_2 then
		var_9_2:setProgressValue(arg_9_1.mission_research or 0)
		var_9_2:setServerData(arg_9_1)
	end
end

function GveInstituteData:updateWithRedPoint(arg_10_1)
	local var_10_0 = self:getInstituteByType(var_0_2.GVE_INSTITUTE_TYPE.RESEARCH)

	if var_10_0 then
		var_10_0:setServerDataByName("mission_knight_id", arg_10_1.mission_knight_id)
		var_10_0:setServerDataByName("mission_knights", arg_10_1.mission_knights)
	end
end

function GveInstituteData:onResearchMission(arg_11_1)
	local var_11_0 = self:getInstituteByType(var_0_2.GVE_INSTITUTE_TYPE.RESEARCH)

	if var_11_0 then
		var_11_0:setServerDataByName("mission_knight_id", arg_11_1.knight_id)
		var_11_0:setServerDataByName("mission_start_time", arg_11_1.start_time)
	end
end

function GveInstituteData:onResearchAward(arg_12_1)
	local var_12_0 = self:getInstituteByType(var_0_2.GVE_INSTITUTE_TYPE.RESEARCH)

	if var_12_0 then
		var_12_0:setProgressValue(arg_12_1.team_research or 0)
		var_12_0:setServerDataByName("mission_start_time", arg_12_1.start_time)
		var_12_0:setServerDataByName("mission_research", arg_12_1.team_research)
		var_12_0:setServerDataByName("mission_gain_research", arg_12_1.gain_research)
	end
end

function GveInstituteData:isHasCanResearchKnight()
	local var_13_0 = self:getInstituteByType(var_0_2.GVE_INSTITUTE_TYPE.RESEARCH)

	if var_13_0 then
		local var_13_1 = var_13_0:getServerDataByName("mission_knight_id")

		if var_13_1 and var_13_1 ~= 0 then
			return false
		end

		local var_13_2 = var_13_0:getServerDataByName("mission_knights")

		if not var_13_2 then
			return false
		end

		local var_13_3 = g.core.model.User.knightsData

		for iter_13_0, iter_13_1 in ipairs(var_13_2) do
			if var_13_3:getKnightByAdvanceId(iter_13_1):isOwn() then
				return true
			end
		end
	end

	return false
end

return GveInstituteData
