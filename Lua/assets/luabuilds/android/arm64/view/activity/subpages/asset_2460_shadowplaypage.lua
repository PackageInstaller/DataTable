local ShadowPlayPage = class("ShadowPlayPage", import("...base.BaseActivityPage"))

function ShadowPlayPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.getBtn = self._tf:Find("AD/get")
	self.gotBtn = self._tf:Find("AD/got")
	self.urlBtn = self._tf:Find("AD/url")

	return
end

function ShadowPlayPage:OnFirstFlush()
	onButton(self, self.urlBtn, function()
		Application.OpenURL(self.activity:getConfig("config_client"))

		return
	end, SFX_PANEL)

	return
end

function ShadowPlayPage:OnUpdateFlush()
	local var_4_0 = self.activity:getConfig("config_data")[1]
	local var_4_1 = getProxy(TaskProxy)
	local var_4_2 = var_4_1:getTaskById(var_4_0) or var_4_1:getFinishTaskById(var_4_0) or Task.New({
		id = var_4_0
	})
	local var_4_3 = var_4_2:isFinish()
	local var_4_4 = var_4_2:isReceive()

	setActive(self.getBtn, var_4_2 and var_4_3 and not var_4_4)
	setActive(self.gotBtn, var_4_2 and var_4_4)
	onButton(self, self.getBtn, function()
		if var_4_2 and var_4_3 and not var_4_4 then
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_4_2)
		end

		return
	end, SFX_PANEL)

	return
end

function ShadowPlayPage:OnDestroy()
	return
end

return ShadowPlayPage
