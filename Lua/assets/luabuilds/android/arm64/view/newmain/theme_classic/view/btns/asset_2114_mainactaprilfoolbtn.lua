local MainActAprilFoolBtn = class("MainActAprilFoolBtn", import(".MainBaseActivityBtn"))

function MainActAprilFoolBtn:GetEventName()
	return "event_aprilFool"
end

function MainActAprilFoolBtn:OnInit()
	setActive(self.tipTr.gameObject, (self:IsShowTip()))

	return
end

function MainActAprilFoolBtn:GetActivityID()
	return self:GetLinkConfig().time[2]
end

function MainActAprilFoolBtn:IsShowTip()
	local var_4_0 = self:GetActivityID()
	local var_4_1 = var_4_0 and getProxy(ActivityProxy):getActivityById(var_4_0)

	return var_4_1 and var_4_1:readyToAchieve()
end

function MainActAprilFoolBtn:CustomOnClick()
	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
		id = self:GetActivityID()
	})

	return
end

return MainActAprilFoolBtn
