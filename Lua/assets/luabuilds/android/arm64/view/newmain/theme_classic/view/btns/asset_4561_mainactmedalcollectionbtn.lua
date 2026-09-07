local MainActMedalCollectionBtn = class("MainActMedalCollectionBtn", import(".MainBaseActivityBtn"))

function MainActMedalCollectionBtn:GetEventName()
	return "event_medal"
end

function MainActMedalCollectionBtn:GetActivityID()
	local var_2_0 = checkExist(self.config, {
		"time"
	})

	if not var_2_0 then
		return nil
	end

	return (var_2_0[1] == "default" or nil) and (var_2_0[2] or nil)
end

function MainActMedalCollectionBtn:OnInit()
	setActive(self.tipTr.gameObject, (Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById((self:GetActivityID()))))))

	return
end

function MainActMedalCollectionBtn:CustomOnClick()
	errorMsg("Set activity_link_button param using View's name")

	return
end

return MainActMedalCollectionBtn
