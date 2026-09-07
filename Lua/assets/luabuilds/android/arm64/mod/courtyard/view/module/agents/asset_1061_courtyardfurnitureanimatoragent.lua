local CourtYardFurnitureAnimatorAgent = class("CourtYardFurnitureAnimatorAgent", import(".CourtYardAgent"))

function CourtYardFurnitureAnimatorAgent:Ctor(arg_1_1)
	CourtYardFurnitureAnimatorAgent.super.Ctor(self, arg_1_1)

	self.maskSpineAnimUIs = {}

	for iter_1_0, iter_1_1 in pairs(self.masks) do
		table.insert(self.maskSpineAnimUIs, (GetOrAddComponent(iter_1_1:Find("spine"), typeof(SpineAnimUI))))
	end

	self.spineTF = self._tf:Find("spine_icon")
	self.spineAnimUI = GetOrAddComponent(self.spineTF:Find("spine"), typeof(SpineAnimUI))

	self:SetState(CourtYardFurniture.STATE_IDLE)

	return
end

function CourtYardFurnitureAnimatorAgent:State2Action(arg_2_1)
	if arg_2_1 == CourtYardFurniture.STATE_IDLE then
		return self.data:GetFirstSlot():GetSpineDefaultAction(), true
	elseif arg_2_1 == CourtYardFurniture.STATE_TOUCH then
		return self.data:GetTouchAction()
	elseif arg_2_1 == CourtYardFurniture.STATE_TOUCH_PREPARE then
		return self.data:GetTouchPrepareAction()
	elseif arg_2_1 == CourtYardFurniture.STATE_PLAY_MUSIC then
		return self.data:GetMusicData().action, true
	end

	return
end

function CourtYardFurnitureAnimatorAgent:SetState(arg_3_1)
	local var_3_0, var_3_1 = self:State2Action(arg_3_1)

	if not var_3_0 or var_3_0 == "" then
		return
	end

	self:_PlayAction(var_3_0, var_3_1, function()
		self:OnAnimtionFinish(arg_3_1)

		return
	end)

	if arg_3_1 == CourtYardFurniture.STATE_IDLE then
		for iter_3_0, iter_3_1 in ipairs(self.maskSpineAnimUIs) do
			iter_3_1:SetAction(var_3_0, 0)
		end
	end

	return
end

function CourtYardFurnitureAnimatorAgent:GetNormalAnimationName()
	return self:State2Action(CourtYardFurniture.STATE_IDLE)
end

function CourtYardFurnitureAnimatorAgent:RestartAnimation(arg_6_1)
	self.spineAnimUI:SetAction(arg_6_1, 0)

	return
end

function CourtYardFurnitureAnimatorAgent:_PlayAction(arg_7_1, arg_7_2, arg_7_3)
	self.spineAnimUI:SetActionCallBack(not arg_7_2 and function(arg_8_0)
		if arg_8_0 == "finish" then
			self.spineAnimUI:SetActionCallBack(nil)
			arg_7_3()
		end

		return
	end or nil)
	self.spineAnimUI:SetAction(arg_7_1, 0)

	return
end

function CourtYardFurnitureAnimatorAgent:PlayInteractioAnim(arg_9_1)
	parallelAsync({
		function(arg_10_0)
			self:PlayMaskAction(arg_9_1, arg_10_0)

			return
		end,
		function(arg_11_0)
			self:_PlayAction(arg_9_1, false, arg_11_0)

			return
		end
	}, function()
		self:OnAnimtionFinish(CourtYardFurniture.STATE_INTERACT)

		return
	end)

	return
end

function CourtYardFurnitureAnimatorAgent:PlayMaskAction(arg_13_1, arg_13_2)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(self.maskSpineAnimUIs) do
		table.insert(var_13_0, function(arg_14_0)
			iter_13_1:SetActionCallBack(function(arg_15_0)
				if arg_15_0 == "finish" then
					iter_13_1:SetActionCallBack(nil)
					arg_14_0()
				end

				return
			end)
			iter_13_1:SetAction(arg_13_1, 0)

			return
		end)
	end

	parallelAsync(var_13_0, arg_13_2)

	return
end

function CourtYardFurnitureAnimatorAgent:Dispose()
	self.spineAnimUI:SetActionCallBack(nil)
	Object.Destroy(self.spineAnimUI)

	self.spineAnimUI = nil

	Object.Destroy(self.spineTF.gameObject)

	self.spineTF = nil

	for iter_16_0, iter_16_1 in ipairs(self.maskSpineAnimUIs) do
		iter_16_1:SetActionCallBack(nil)
		Object.Destroy(iter_16_1)
	end

	self.maskSpineAnimUIs = nil

	CourtYardFurnitureAnimatorAgent.super.Dispose()

	return
end

return CourtYardFurnitureAnimatorAgent
