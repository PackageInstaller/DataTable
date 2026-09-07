local MainActBoatAdBtn = class("MainActBoatAdBtn", import(".MainBaseActivityBtn"))

function MainActBoatAdBtn:GetEventName()
	return "event_boat_ad_game"
end

function MainActBoatAdBtn:OnInit()
	setActive(self.tipTr.gameObject, (self:IsShowTip()))

	return
end

function MainActBoatAdBtn:GetActivityID()
	return self:GetLinkConfig().time[2]
end

function MainActBoatAdBtn:IsShowTip()
	local var_4_0 = getProxy(MiniGameProxy):GetHubByHubId(pg.mini_game[self.config.param[1]].hub_id)

	if var_4_0 and var_4_0.count > 0 then
		return true
	end

	return false
end

return MainActBoatAdBtn
