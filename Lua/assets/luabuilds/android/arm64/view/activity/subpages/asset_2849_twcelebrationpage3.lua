local TWCelebrationPage3 = class("TWCelebrationPage3", import("...base.BaseActivityPage"))

function TWCelebrationPage3:OnInit()
	self.bg = self._tf:Find("AD")
	self.getBtn = self._tf:Find("AD/get")
	self.gotBtn = self._tf:Find("AD/got")
	self.share = self._tf:Find("AD/share")
	self.mask = self._tf:Find("AD/mask")
	self.finished = self._tf:Find("AD/finished")
	self.unfinished = self._tf:Find("AD/unfinished")

	return
end

function TWCelebrationPage3:OnFirstFlush()
	return
end

function TWCelebrationPage3:OnUpdateFlush()
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
	setActive(self.share, var_3_2 and not var_3_3)
	setActive(self.finished, var_3_2 and var_3_3)
	setActive(self.unfinished, var_3_2 and not var_3_3)
	onButton(self, self.share, function()
		self:share()

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

function TWCelebrationPage3:share()
	self:initShare()

	return
end

function TWCelebrationPage3:initShare()
	PoolMgr.GetInstance():GetUI("TWCelebrationShare", false, function(arg_8_0)
		SetParent(arg_8_0, GameObject.Find("UICamera"):GetComponent(typeof(Camera)).transform:GetChild(0), false)

		return
	end)

	return
end

return TWCelebrationPage3
