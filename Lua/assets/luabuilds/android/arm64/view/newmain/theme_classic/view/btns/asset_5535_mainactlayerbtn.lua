local MainActLayerBtn = class("MainActLayerBtn", import(".MainBaseActivityBtn"))

function MainActLayerBtn:GetEventName()
	return "event_layer"
end

function MainActLayerBtn:OnInit()
	setActive(self.tipTr.gameObject, (Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById((self:GetActivityID()))))))

	return
end

function MainActLayerBtn:GetActivityID()
	local var_3_0 = checkExist(self.config, {
		"time"
	})

	if not var_3_0 then
		return nil
	end

	return (var_3_0[1] == "default" or nil) and (var_3_0[2] or nil)
end

return MainActLayerBtn
