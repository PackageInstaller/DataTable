local GMActivityItem = class("GMActivityItem", ReduxView)

function GMActivityItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
	self:Show(true)
end

function GMActivityItem:SetData(arg_2_1)
	if self.activityID_ ~= arg_2_1 then
		self.toggle_.isOn = false
	end

	self.activityID_ = arg_2_1

	local var_2_0 = ActivityData:GetActivityData(arg_2_1)
	local var_2_2 = var_2_0.startTime == 0 and "" or string.format("(<color=%s>%s</color>)", var_2_0.stopTime < manager.time:GetServerTime() and "#000000" or var_2_0.startTime < manager.time:GetServerTime() and "blue" or "red", (string.format("<size=25>%s-%s</size>", manager.time:STimeDescS(var_2_0.startTime, "!%m/%d %H:%M"), manager.time:STimeDescS(var_2_0.stopTime, "!%m/%d %H:%M"))))

	self.text_.text = #ActivityCfg[arg_2_1].sub_activity_list <= 0 and string.format("<b>Φ</b>%s-%s%s", arg_2_1, GetI18NText(ActivityCfg[arg_2_1].remark), var_2_2) or string.format("%s-%s%s", arg_2_1, GetI18NText(ActivityCfg[arg_2_1].remark), var_2_2)
end

function GMActivityItem:Dispose()
	GMActivityItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function GMActivityItem:AddListeners()
	self:AddToggleListener(self.toggle_, function(arg_5_0)
		GMData:EnabledActivity(self.activityID_, arg_5_0)
	end)
end

function GMActivityItem:Show(arg_6_1)
	self.gameObject_:SetActive(arg_6_1)
end

function GMActivityItem:SelectItem(arg_7_1)
	self.toggle_.isOn = arg_7_1
end

return GMActivityItem
