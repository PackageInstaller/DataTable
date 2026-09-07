local CatteryOpAnimPage = class("CatteryOpAnimPage", import("....base.BaseSubView"))

function CatteryOpAnimPage:getUIName()
	return "CatteryOPAnimUI"
end

function CatteryOpAnimPage:OnLoaded()
	self.homeExpAnim = CatteryAddHomeExpAnim.New(self._tf:Find("bg/single"))
	self.homeAndCommanderAnim = CattertAddHomeExpAndCommanderExpAnim.New(self._tf:Find("bg/both"))

	return
end

function CatteryOpAnimPage:OnInit()
	return
end

function CatteryOpAnimPage:AddPlan(arg_4_1)
	self:RemoveTimer()
	self:Show()

	local var_4_0, var_4_1, var_4_2, var_4_3 = self:ParseData(arg_4_1)
	local var_4_4 = #var_4_0 > 0 and self.homeAndCommanderAnim or self.homeExpAnim

	if self.player then
		self.player:Clear()

		if self.player ~= var_4_4 then
			self.player:Hide()
		end
	end

	self.doAnim = true

	var_4_4:Action(var_4_0, var_4_1, var_4_2, var_4_3, function()
		self.doAnim = false

		if self.exited then
			return
		end

		self.timer = Timer.New(function()
			var_4_4:Hide()
			self:Hide()

			return
		end, 0.5, 1)

		self.timer:Start()

		return
	end)

	self.player = var_4_4

	return
end

function CatteryOpAnimPage:ParseData(arg_7_1)
	local var_7_0 = false
	local var_7_1 = false

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.awards) do
		if iter_7_1.id == Item.COMMANDER_QUICKLY_TOOL_ID then
			var_7_0 = true
		end

		if iter_7_1.id == PlayerConst.ResDormMoney then
			var_7_1 = true
		end
	end

	return arg_7_1.commanderExps, arg_7_1.homeExp, var_7_0, var_7_1
end

function CatteryOpAnimPage:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CatteryOpAnimPage:OnDestroy()
	self:RemoveTimer()

	self.doAnim = nil

	self.homeExpAnim:Dispose()
	self.homeAndCommanderAnim:Dispose()

	self.exited = true

	return
end

return CatteryOpAnimPage
