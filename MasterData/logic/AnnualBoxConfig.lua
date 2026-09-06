-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualbox/config/AnnualBoxConfig.lua

module("logic.extensions.annualbox.config.AnnualBoxConfig", package.seeall)

local AnnualBoxConfig = class("AnnualBoxConfig", BaseConfig)

function AnnualBoxConfig:getNames()
	return {
		"assemble_order",
		"assemble_order_invite_prize",
		"assemble_order_help_prize"
	}
end

function AnnualBoxConfig:handleConfig(name, content)
	if name == "assemble_order" then
		self._activityCfgs = content
	elseif name == "assemble_order_invite_prize" then
		self._invitePrizeCfgs = content
	elseif name == "assemble_order_help_prize" then
		self._helpPrizeCfgs = content
	end
end

function AnnualBoxConfig:getAnnualActivityCfg(actId)
	if self._activityCfgs == nil or self._activityCfgs[actId] == nil then
		return
	end

	return self._activityCfgs[actId]
end

function AnnualBoxConfig:getAnnualInvitePrizeCfgs(actId)
	if self._invitePrizeCfgs == nil or self._invitePrizeCfgs[actId] == nil then
		return
	end

	return self._invitePrizeCfgs[actId]
end

function AnnualBoxConfig:getAnnualHelpPrizeCfgs(actId)
	if self._helpPrizeCfgs == nil or self._helpPrizeCfgs[actId] == nil then
		return
	end

	return self._helpPrizeCfgs[actId]
end

function AnnualBoxConfig:getOpenActivityId()
	if self._activityCfgs == nil then
		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.AnnualBox)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item.activityId
		end
	end

	return -3
end

AnnualBoxConfig.instance = AnnualBoxConfig.New()

return AnnualBoxConfig
