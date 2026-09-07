local MainCommonActDelegationBtn = class("MainCommonActDelegationBtn", import(".MainBaseSpcailActBtn"))

function MainCommonActDelegationBtn:GetEventName()
	return "event_old_act"
end

function MainCommonActDelegationBtn:GetContainer()
	return self.root.parent:Find("eventPanel")
end

function MainCommonActDelegationBtn:GetLinkConfig()
	local var_3_0 = pg.activity_link_button
	local var_3_1 = _.select(pg.activity_link_button.get_id_list_by_name[self:GetEventName()] or {}, function(arg_4_0)
		if type(var_3_0[arg_4_0].time) == "table" and var_3_0[arg_4_0].time[1] and var_3_0[arg_4_0].time[1] == "default" then
			return self:InActTime(var_3_0[arg_4_0].time[2])
		else
			return pg.TimeMgr.GetInstance():inTime(var_3_0[arg_4_0].time)
		end

		return
	end)

	if #var_3_1 > 0 then
		table.sort(var_3_1, CompareFuncs({
			function(arg_5_0)
				return var_3_0[arg_5_0].order
			end
		}))

		return pg.activity_link_button[var_3_1[1]]
	end

	return
end

function MainCommonActDelegationBtn:InActTime(arg_6_1)
	local var_6_0 = arg_6_1 or self:GetActivityID()

	if var_6_0 then
		local var_6_1 = getProxy(ActivityProxy):getActivityById(var_6_0)

		return var_6_1 and not var_6_1:isEnd()
	end

	return false
end

function MainCommonActDelegationBtn:InShowTime()
	local var_7_0 = self:GetLinkConfig()

	if var_7_0 ~= nil then
		self.config = var_7_0

		return true
	else
		return false
	end

	return
end

function MainCommonActDelegationBtn:GetUIName()
	return "MainCommonActDelegationBtn"
end

function MainCommonActDelegationBtn:OnClick()
	MainBaseActivityBtn.Skip(self, self.config)

	return
end

function MainCommonActDelegationBtn:OnInit()
	self.tipTr = self._tf:Find("tip")

	setActive(self.tipTr, self:IsShowTip())

	return
end

function MainCommonActDelegationBtn:GetActivity()
	if self.config and self.config.time and self.config.time[1] == "default" then
		local var_11_0 = getProxy(ActivityProxy):getActivityById(self.config.time[2])

		if var_11_0 and not var_11_0:isEnd() then
			return var_11_0
		end
	end

	return nil
end

function MainCommonActDelegationBtn:IsShowTip()
	local var_12_0 = self:GetActivity()

	return switch(var_12_0:getConfig("type"), {
		[ActivityConst.ACTIVITY_TYPE_TOWN2] = function()
			return LiquorFloorMapScene.ShouldShowTaskTip()
		end
	}, function()
		return var_12_0:readyToAchieve()
	end)
end

function MainCommonActDelegationBtn:emit(...)
	self.event:emit(...)

	return
end

function MainCommonActDelegationBtn:OnRegister()
	return
end

function MainCommonActDelegationBtn:OnClear()
	return
end

return MainCommonActDelegationBtn
