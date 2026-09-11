local ClickButtonNoMaskStep = class("ClickButtonNoMaskStep", ComponentStep)

function ClickButtonNoMaskStep:Init()
	ClickButtonNoMaskStep.super.Init(self)

	self.disableBtnEvent = GuideStepCfg[self._stepId].params[1]
end

function ClickButtonNoMaskStep:GetShowMask()
	return false
end

function ClickButtonNoMaskStep:Play()
	local var_3_0 = self:Component()

	if self.disableBtnEvent then
		self.eventTriggerListener = var_3_0.gameObject:AddComponent(typeof(EventTriggerListener))

		self.eventTriggerListener:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function(arg_4_0, arg_4_1)
			self:OnStepEnd()
		end))

		var_3_0.enabled = false
	else
		function self.btnCallBack()
			self:OnStepEnd()
		end

		var_3_0.onClick:AddListener(self.btnCallBack)
	end
end

function ClickButtonNoMaskStep:OnStepEnd()
	if self.eventTriggerListener then
		self.eventTriggerListener:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerClick)
		Object.Destroy(self.eventTriggerListener)

		self.eventTriggerListener = nil
	end

	local var_6_0 = self:Component()

	if self.btnCallBack then
		var_6_0.onClick:RemoveListener(self.btnCallBack)

		self.btnCallBack = nil
	end

	if self._guideComponentCfg and self._guideComponentCfg[2] == "settlement" then
		-- block empty
	else
		var_6_0.enabled = true
	end

	ClickButtonNoMaskStep.super.OnStepEnd(self)
end

return ClickButtonNoMaskStep
