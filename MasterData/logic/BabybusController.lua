-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/babybus/controller/BabybusController.lua

module("logic.extensions.babybus.controller.BabybusController", package.seeall)

local BabybusController = class("BabybusController", BaseController)

function BabybusController:ctor()
	return
end

function BabybusController:onInit()
	self:onReset()
end

function BabybusController:onReset()
	return
end

function BabybusController:sendPM_BabyBusGainPrizeReq(activityId, prizeId)
	self._gainInfo = {
		activityId = activityId,
		prizeId = prizeId
	}

	BabyBusAgent.instance:sendPM_BabyBusGainPrizeReq(activityId, prizeId)
end

function BabybusController:babyBusGainPrize(code)
	if self._gainInfo then
		local actId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.BabyBus)

		if actId == self._gainInfo.activityId then
			if not string.nilorempty(code) then
				UIStateManager.instance:push(ViewName.BabybuscodetipView, code)
			end

			BabybusModel.instance:gainPrize(self._gainInfo.prizeId, code)
		end

		self._gainInfo = nil
	end
end

BabybusController.instance = BabybusController.New()

return BabybusController
