local var_0_0 = g.core.const.ConstMgr.GveConst
local var_0_1 = g.core.config.gve_season_event_info
local var_0_2 = g.core.config.gve_research_result_info
local GveInstituteStruct = class("GveInstituteStruct")

function GveInstituteStruct:ctor(arg_1_1)
	self._cfg = arg_1_1
	self._eventCfg = var_0_1.get(arg_1_1.event_id)
	self._researchPathList = {}
	self._level = 0
	self._value = 0

	self:initResearchResult()
end

function GveInstituteStruct:initResearchResult()
	for iter_2_0 = 1, var_0_2.getLength() do
		local var_2_0 = var_0_2.indexOf(iter_2_0)

		if var_2_0.advance_id == self._cfg.result_advance_id then
			self._researchPathList[var_2_0.level] = var_2_0
		end
	end
end

function GveInstituteStruct:getCurLvResearchCfg()
	if self._level == 0 then
		return nil
	end

	return self._researchPathList[self._level]
end

function GveInstituteStruct:getLevel()
	return self._level
end

function GveInstituteStruct:getResearchName()
	return self._researchPathList[1].name
end

function GveInstituteStruct:getHelpId()
	if self._cfg then
		return self._cfg.help_id
	end

	return 0
end

function GveInstituteStruct:getProgressValue()
	if self._level == 0 then
		return self._value
	end

	if self._researchPathList[self._level].next_level == 0 then
		return self._researchPathList[self._level].points_require
	end

	return self._value
end

function GveInstituteStruct:getUpLvValue()
	if self._level == 0 then
		return self._researchPathList[1].points_require
	end

	if self._researchPathList[self._level].next_level == 0 then
		return self._researchPathList[self._level].points_require
	end

	return self._researchPathList[self._level + 1].points_require
end

function GveInstituteStruct:getResearchPath()
	return self._researchPathList
end

function GveInstituteStruct:setProgressValue(arg_10_1)
	self._value = arg_10_1

	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(self._researchPathList) do
		if arg_10_1 >= iter_10_1.points_require then
			var_10_0 = iter_10_1.level
		else
			break
		end
	end

	self._level = var_10_0
end

function GveInstituteStruct:getCompName()
	if self._eventCfg then
		return var_0_0.GVE_INSTITUTE_COMP[self._eventCfg.type]
	end
end

function GveInstituteStruct:getRedPointId()
	if self._eventCfg then
		return var_0_0.GVE_RED_POINT_ID[self._eventCfg.type]
	end
end

function GveInstituteStruct:getName()
	if self._cfg then
		return self._cfg.name
	end
end

function GveInstituteStruct:getCfg()
	return self._cfg
end

function GveInstituteStruct:getEventCfg()
	return self._eventCfg
end

function GveInstituteStruct:getEventValue(arg_16_1)
	if arg_16_1 < 1 or arg_16_1 > 8 then
		return
	end

	return self._eventCfg["value_" .. arg_16_1]
end

function GveInstituteStruct:setServerData(arg_17_1)
	self._svrData = arg_17_1
end

function GveInstituteStruct:getServerDataByName(arg_18_1)
	if not self._svrData then
		return nil
	end

	return self._svrData[arg_18_1]
end

function GveInstituteStruct:setServerDataByName(arg_19_1, arg_19_2)
	self._svrData = self._svrData or {}
	self._svrData[arg_19_1] = arg_19_2
end

function GveInstituteStruct:getServerData()
	return self._svrData
end

function GveInstituteStruct:isNeedCheckLock()
	if self._cfg then
		if self._cfg.unlock == 0 then
			return false
		end

		return true
	end
end

function GveInstituteStruct:getGainResearchPoint()
	if not self._svrData then
		return 0
	end

	self._svrData.mission_gain_research = 0

	return self._svrData.mission_gain_research or 0
end

return GveInstituteStruct
