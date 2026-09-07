local MainActDreamlandBtn = class("MainActDreamlandBtn", import(".MainBaseActivityBtn"))

function MainActDreamlandBtn:InShowTime()
	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2)

	return MainActDreamlandBtn.super.InShowTime(self) and var_1_0 and not var_1_0:isEnd()
end

function MainActDreamlandBtn:GetEventName()
	return "event_dreamland"
end

function MainActDreamlandBtn:OnInit()
	local var_3_0 = getProxy(ActivityProxy)

	setActive(self.tipTr.gameObject, (DreamlandData.New(var_3_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_DREAMLAND), (getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2))).ExistAnyMapOrExploreAward(var_3_0)))

	return
end

return MainActDreamlandBtn
