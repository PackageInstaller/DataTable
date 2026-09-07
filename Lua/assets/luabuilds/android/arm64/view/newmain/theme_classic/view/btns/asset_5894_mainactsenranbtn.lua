local MainActSenranBtn = class("MainActSenranBtn", import(".MainBaseActivityBtn"))

function MainActSenranBtn:GetEventName()
	return "event_senran"
end

function MainActSenranBtn:GetActivityID()
	local var_2_0 = checkExist(self.config, {
		"time"
	})

	if not var_2_0 then
		return nil
	end

	return (var_2_0[1] == "default" or nil) and (var_2_0[2] or nil)
end

function MainActSenranBtn:OnInit()
	setActive(self.tipTr.gameObject, (Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById((self:GetActivityID()))))))

	return
end

return MainActSenranBtn
