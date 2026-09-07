local MainSubActBtn = class("MainSubActBtn", import(".MainBaseActivityBtn"))

function MainSubActBtn:GetEventName()
	return "event_sub_act"
end

function MainSubActBtn:GetActivity()
	if self.config and self.config.time and self.config.time[1] == "default" then
		local var_2_0 = getProxy(ActivityProxy):getActivityById(self.config.time[2])

		if var_2_0 and not var_2_0:isEnd() then
			return var_2_0
		end
	end

	return nil
end

function MainSubActBtn:GetActivityID()
	local var_3_0 = self:GetActivity()

	return var_3_0 and var_3_0.id
end

function MainSubActBtn:OnInit()
	setActive(self.tipTr, self:IsShowTip())

	return
end

function MainSubActBtn:IsShowTip()
	local var_5_0 = self:GetActivity()

	return switch(var_5_0:getConfig("type"), {
		[ActivityConst.ACTIVITY_TYPE_TOWN2] = function()
			return LiquorFloorMapScene.ShouldShowTaskTip()
		end
	}, function()
		return var_5_0:readyToAchieve()
	end)
end

return MainSubActBtn
