local HalloweenSkinPage = class("HalloweenSkinPage", import("...base.BaseActivityPage"))

function HalloweenSkinPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.stage = self._tf:Find("AD/Text"):GetComponent(typeof(Text))
	self.goBtn = self._tf:Find("AD/go_btn")
	self.gotBtn = self._tf:Find("AD/got_btn")

	return
end

function HalloweenSkinPage:OnFirstFlush()
	self.tasks = _.flatten(self.activity:getConfig("config_data"))

	onButton(self, self.goBtn, function()
		if self:LastTaskBeFinished() then
			return
		end

		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.NAVALACADEMYSCENE)

		return
	end, SFX_PANEL)

	return
end

function HalloweenSkinPage:LastTaskBeFinished()
	local var_4_0 = getProxy(TaskProxy):getTaskVO(self.tasks[#self.tasks])

	if var_4_0 and var_4_0:isReceive() then
		return true
	end

	return false
end

function HalloweenSkinPage:OnUpdateFlush()
	local var_5_1 = 0
	local var_5_2 = getProxy(TaskProxy)

	for iter_5_0 = #self.tasks, 1, -1 do
		local var_5_3 = var_5_2:getTaskVO(self.tasks[iter_5_0])

		if var_5_3 and var_5_3:isReceive() then
			var_5_1 = iter_5_0
		elseif var_5_3 and not var_5_3:isReceive() then
			var_5_1 = iter_5_0 - 1
		end
	end

	self.stage.text = var_5_1 .. "/" .. #self.tasks

	setActive(self.gotBtn, (self:LastTaskBeFinished()))

	return
end

function HalloweenSkinPage:OnDestroy()
	return
end

return HalloweenSkinPage
