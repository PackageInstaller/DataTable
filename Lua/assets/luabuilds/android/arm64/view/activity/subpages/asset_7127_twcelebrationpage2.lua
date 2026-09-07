local TWCelebrationPage2 = class("TWCelebrationPage2", import("...base.BaseActivityPage"))

function TWCelebrationPage2:OnInit()
	self.bg = self._tf:Find("AD")
	self.getBtn = self._tf:Find("AD/get_btn")
	self.gotBtn = self._tf:Find("AD/got_btn")
	self.goBtn = self._tf:Find("AD/battle_btn")
	self.mark = self._tf:Find("AD/mark")

	return
end

function TWCelebrationPage2:OnFirstFlush()
	return
end

function TWCelebrationPage2:OnUpdateFlush()
	local var_3_0 = self.activity:getConfig("config_data")[1]
	local var_3_1 = getProxy(TaskProxy)
	local var_3_2 = var_3_1:getTaskById(var_3_0) or var_3_1:getFinishTaskById(var_3_0) or Task.New({
		id = var_3_0
	})
	local var_3_3 = var_3_2:isFinish()
	local var_3_4 = var_3_2:isReceive()

	setActive(self.getBtn, var_3_2 and var_3_3 and not var_3_4)
	setActive(self.gotBtn, var_3_2 and var_3_4)
	setActive(self.mark, var_3_2 and var_3_4)
	setActive(self.goBtn, var_3_2 and not var_3_3)
	onButton(self, self.goBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		if var_3_2 and var_3_3 and not var_3_4 then
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_3_2)
		end

		return
	end, SFX_PANEL)

	return
end

return TWCelebrationPage2
