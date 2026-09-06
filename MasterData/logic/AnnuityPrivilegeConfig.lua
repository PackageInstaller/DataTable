-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annuityprivilege/config/AnnuityPrivilegeConfig.lua

module("logic.extensions.annuityprivilege.config.AnnuityPrivilegeConfig", package.seeall)

local AnnuityPrivilegeConfig = class("AnnuityPrivilegeConfig", BaseConfig)

function AnnuityPrivilegeConfig:onInit()
	AnnuityPrivilegeConfig.super.onInit(self)
end

function AnnuityPrivilegeConfig:getNames()
	return {
		"annuity_privilege",
		"annuity_privilege_sweep_act"
	}
end

function AnnuityPrivilegeConfig:handleConfig(name, content)
	if name == "annuity_privilege" then
		self._annuity_privilege = content
		self._activityTimes = {}

		for idx, data in ipairs(content.dataList) do
			self._activityTimes[data.annuityActivityId] = {
				GameUtil.string2time(data.privilegeStartTime),
				GameUtil.string2time(data.privilegeEndTime)
			}
		end
	elseif name == "annuity_privilege_sweep_act" then
		self._annuity_privilege_sweep_act = content
	end
end

function AnnuityPrivilegeConfig:getActDataList()
	return self._annuity_privilege.dataList
end

function AnnuityPrivilegeConfig:getActData(annuityActivityId)
	return self._annuity_privilege[annuityActivityId]
end

function AnnuityPrivilegeConfig:getAnnuityActivityIdsByTime()
	return self._activityTimes
end

function AnnuityPrivilegeConfig:getSweepCfg(annuityActivityId)
	local data = self:getActData(annuityActivityId)

	if data then
		if not data.sweepPlanId then
			local sweepPlanId = 0

			return self._annuity_privilege_sweep_act[sweepPlanId]
		end
	end
end

function AnnuityPrivilegeConfig:getSweepData(annuityActivityId, canSweepActivityType)
	local cfg = self:getSweepCfg(annuityActivityId)

	if cfg then
		return cfg[canSweepActivityType]
	end
end

AnnuityPrivilegeConfig.instance = AnnuityPrivilegeConfig.New()

return AnnuityPrivilegeConfig
