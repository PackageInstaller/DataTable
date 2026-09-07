local OutPostPtRePage = class("OutPostPtRePage", import(".TemplatePage.NewFrameTemplatePage"))
local var_0_1 = {
	16851,
	16852,
	16853,
	16854
}

function OutPostPtRePage:OnInit()
	OutPostPtRePage.super.OnInit(self)

	self.bg = self._tf:Find("AD")
	self.switchBtn = self._tf:Find("AD/switcher/switch_btn")
	self.bar = self._tf:Find("AD/switcher/phase2/Image/bar")
	self.displayBtn = self._tf:Find("AD/display_btn")
	self.gotTag = self._tf:Find("AD/switcher/phase2/Image/got")

	local var_1_0, var_1_1 = self:GetActTask()
	local var_1_2 = var_1_0 and var_1_0:isReceive() and var_1_1

	setActive(self.displayBtn:Find("Image1"), not var_1_2)
	setActive(self.displayBtn:Find("Image2"), var_1_2)

	local var_1_3

	onButton(self, self.displayBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity",
			targetId = var_1_3
		})

		return
	end)

	return
end

function OutPostPtRePage:GetActTask()
	local var_3_0 = getProxy(TaskProxy)
	local var_3_1
	local var_3_2 = false

	for iter_3_0 = #var_0_1, 1, -1 do
		local var_3_3 = var_3_0:getTaskById(var_0_1[iter_3_0]) or var_3_0:getFinishTaskById(var_0_1[iter_3_0])

		if var_3_3 then
			var_3_1 = var_3_3

			if iter_3_0 == #var_0_1 then
				var_3_2 = true
			end

			break
		end
	end

	return var_3_1, var_3_2
end

return OutPostPtRePage
