local BuildShipActivityPool = class("BuildShipActivityPool", import(".BuildShipPool"))

function BuildShipActivityPool:Ctor(arg_1_1)
	BuildShipActivityPool.super.Ctor(self, arg_1_1)

	self.activityId = arg_1_1.activityId

	return
end

function BuildShipActivityPool:IsActivity()
	return true
end

function BuildShipActivityPool:GetActivity()
	return getProxy(ActivityProxy):getActivityById(self.activityId)
end

function BuildShipActivityPool:IsEnd()
	local var_4_0 = self:GetActivity()

	return not var_4_0 or var_4_0:isEnd()
end

function BuildShipActivityPool:GetStageId()
	return (self:GetActivity():getConfig("config_client") or {}).stageid
end

function BuildShipActivityPool:GetActivityId()
	return self.activityId
end

function BuildShipActivityPool:IsNewServerBuild()
	if self:IsEnd() then
		return false
	end

	return self:GetActivity():getConfig("type") == ActivityConst.ACTIVITY_TYPE_NEWSERVER_BUILD
end

return BuildShipActivityPool
