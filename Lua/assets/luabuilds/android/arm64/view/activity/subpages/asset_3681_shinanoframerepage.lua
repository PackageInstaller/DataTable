local ShinanoframeRePage = class("ShinanoframeRePage", import("...base.BaseActivityPage"))

function ShinanoframeRePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.goBtn = self.bg:Find("GoBtn")
	self.getBtn = self.bg:Find("GetBtn")
	self.gotBtn = self.bg:Find("GotBtn")
	self.gotTag = self.bg:Find("got")
	self.cur = self.bg:Find("cur")
	self.max = self.bg:Find("max")
	self.progressBar = self.bg:Find("progress")

	setActive(self.goBtn, false)
	setActive(self.getBtn, false)
	setActive(self.gotBtn, false)
	setActive(self.gotTag, false)

	return
end

function ShinanoframeRePage:OnDataSetting()
	return
end

function ShinanoframeRePage:OnFirstFlush()
	onButton(self, self.goBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {})

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return
	end, SFX_PANEL)
	setParent(LoadAndInstantiateSync("IconFrame", pg.activity_event_avatarframe[self.activity:getConfig("config_id")].icon_frame), findTF(self.bg, "icon"), false)

	return
end

function ShinanoframeRePage:OnUpdateFlush()
	local var_6_0 = self.activity.data1
	local var_6_1 = pg.activity_event_avatarframe[self.activity:getConfig("config_id")].target

	if var_6_1 < self.activity.data1 then
		var_6_0 = var_6_1
	end

	local var_6_2 = var_6_0 / var_6_1

	setText(self.cur, var_6_0)
	setText(self.max, "/" .. var_6_1)
	setSlider(self.progressBar, 0, 1, var_6_2)
	setActive(self.progressBar, true)

	local var_6_3 = var_6_1 <= var_6_0
	local var_6_4 = self.activity.data2 >= 1

	setActive(self.goBtn, not (var_6_1 <= var_6_0))
	setActive(self.getBtn, not var_6_4 and var_6_3)
	setActive(self.gotBtn, var_6_4)
	setActive(self.gotTag, var_6_4)

	return
end

function ShinanoframeRePage:OnDestroy()
	return
end

return ShinanoframeRePage
