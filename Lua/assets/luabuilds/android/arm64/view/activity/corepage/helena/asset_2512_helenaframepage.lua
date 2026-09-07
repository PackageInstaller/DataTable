local HelenaFramePage = class("HelenaFramePage", import("view.activity.CorePage.CoreNewFrameTemplatePage"))

function HelenaFramePage:OnInit()
	self.super.OnInit(self)

	self.battleBtn = self.bg:Find("switcher/phase2/task_bg_2/battle_btn")
	self.getBtn = self.bg:Find("switcher/phase2/task_bg_2/get_btn")
	self.gotBtn = self.bg:Find("switcher/phase2/task_bg_2/got_btn")
	self.switchBtn = self._tf:Find("AD/switcher/switch_btn")
	self.gotTag = self._tf:Find("AD/switcher/phase2/task_bg_2/Image/got")
	self.bar = self._tf:Find("AD/switcher/phase2/task_bg_2/Image/barContent/bar")
	self.cur = self._tf:Find("AD/switcher/phase2/task_bg_2/Image/step")
	self.target = self._tf:Find("AD/switcher/phase2/task_bg_2/Image/progress")

	setText(self._tf:Find("AD/switcher/phase2/task_bg_2/battle_btn/Text"), i18n("other_world_task_go"))
	setText(self._tf:Find("AD/switcher/phase2/task_bg_2/get_btn/Text"), i18n("other_world_task_get"))
	setText(self._tf:Find("AD/switcher/phase2/task_bg_2/got_btn/Text"), i18n("other_world_task_got"))

	return
end

function HelenaFramePage:OnFirstFlush()
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK)

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return
	end, SFX_PANEL)
	onToggle(self, self.switchBtn, function(arg_5_0)
		if self.isSwitching then
			return
		end

		self:Switch(arg_5_0)

		return
	end, SFX_PANEL)

	self.inPhase2 = self.timeStamp and pg.TimeMgr.GetInstance():GetServerTime() - self.timeStamp > 0

	triggerToggle(self.switchBtn, self.inPhase2)

	return
end

function HelenaFramePage:OnUpdateFlush()
	HelenaFramePage.super.OnUpdateFlush(self)

	local var_6_0 = self.avatarConfig.target
	local var_6_2
	local var_6_1

	if self.avatarConfig.target < self.activity.data1 and not var_6_0 then
		var_6_1 = setText
		var_6_2 = self.cur
	end

	var_6_1(var_6_2, (self.activity.data1 / var_6_0 >= 1 and setColorStr(self.activity.data1, "#FCE87A") or setColorStr(self.activity.data1, "#FCE87A")) .. setColorStr("/" .. var_6_0, "#FFFFFF"))
	setActive(self.target, false)

	return
end

function HelenaFramePage:Switch(arg_7_1)
	self.isSwitching = true

	setToggleEnabled(self.switchBtn, false)

	if arg_7_1 then
		quickPlayAnimation(self.bg:Find("switcher"), "anim_HelenaFramePage_switcher")
	else
		quickPlayAnimation(self.bg:Find("switcher"), "anim_HelenaFramePage_switcher2")
	end

	self.isSwitching = nil

	setToggleEnabled(self.switchBtn, true)

	return
end

return HelenaFramePage
