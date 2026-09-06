-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anlongselfselect/controller/AnlongselfselectController.lua

module("logic.extensions.anlongselfselect.controller.AnlongselfselectController", package.seeall)

local AnlongselfselectController = class("AnlongselfselectController", BaseController)

AnlongselfselectController.PM_NotifySelfSelectBuySucRes = "AnlongselfselectController.PM_NotifySelfSelectBuySucRes"
AnlongselfselectController.PM_SelfSelectGainDailyPrizeRes = "AnlongselfselectController.PM_SelfSelectGainDailyPrizeRes"
AnlongselfselectController.PM_SelfSelectInfoRes = "AnlongselfselectController.PM_SelfSelectInfoRes"

function AnlongselfselectController:ctor()
	return
end

function AnlongselfselectController:onInit()
	GlobalDispatcher:addListener(SelfSelectAgent.PM_NotifySelfSelectBuySucRes, self._PM_NotifySelfSelectBuySucRes, self)
	GlobalDispatcher:addListener(SelfSelectAgent.PM_SelfSelectGainDailyPrizeRes, self._PM_SelfSelectGainDailyPrizeRes, self)
	GlobalDispatcher:addListener(SelfSelectAgent.PM_SelfSelectInfoRes, self._PM_SelfSelectInfoRes, self)
	self:onReset()
end

function AnlongselfselectController:onReset()
	return
end

function AnlongselfselectController:_PM_NotifySelfSelectBuySucRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(AnlongselfselectController.PM_NotifySelfSelectBuySucRes, status, msg)
end

function AnlongselfselectController:_PM_SelfSelectGainDailyPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(AnlongselfselectController.PM_SelfSelectGainDailyPrizeRes, status, msg)
end

function AnlongselfselectController:_PM_SelfSelectInfoRes(status, msg)
	if status == 0 then
		AnlongselfselectModel.instance:setInfo(msg)
	end

	GlobalDispatcher:dispatch(AnlongselfselectController.PM_SelfSelectInfoRes, status, msg)
end

function AnlongselfselectController:openView()
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.AnlongSelfSelect)

	if cfgs then
		local activityId = false

		for k, v in pairs(cfgs) do
			if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.AnlongSelfSelect, v.activityId) then
				activityId = v.activityId

				break
			end
		end

		if activityId then
			UIStateManager.instance:push(ViewName.AnlongselfselectmainView, GameEnum.ActivityType.AnlongSelfSelect, activityId)
		else
			FloatWordMgr.instance:show("不在活动开放时间内")
		end
	end
end

function AnlongselfselectController:openView(activityType, activityId)
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(activityType)

	if cfgs then
		if activityId then
			local isInTime = ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)

			if not isInTime then
				FloatWordMgr.instance:show("不在活动开放时间内")

				return
			end
		else
			for k, v in pairs(cfgs) do
				if ActivityDefineController.instance:isInActivityTimeById(activityType, v.activityId) then
					activityId = v.activityId

					break
				end
			end
		end

		if activityId then
			UIStateManager.instance:push(ViewName.AnlongselfselectmainView, activityType, activityId)
		else
			FloatWordMgr.instance:show("不在活动开放时间内")
		end
	end
end

AnlongselfselectController.instance = AnlongselfselectController.New()

return AnlongselfselectController
