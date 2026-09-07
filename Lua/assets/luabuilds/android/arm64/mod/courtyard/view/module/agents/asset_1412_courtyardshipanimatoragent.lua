local CourtYardShipAnimatorAgent = class("CourtYardShipAnimatorAgent", import(".CourtYardAgent"))

function CourtYardShipAnimatorAgent:Ctor(arg_1_1)
	CourtYardShipAnimatorAgent.super.Ctor(self, arg_1_1)

	self.name = nil

	return
end

function CourtYardShipAnimatorAgent:State2AnimationName(arg_2_1)
	if arg_2_1 == CourtYardShip.STATE_IDLE or arg_2_1 == CourtYardShip.STATE_STOP then
		return "stand2"
	elseif arg_2_1 == CourtYardShip.STATE_MOVE then
		return "walk"
	elseif arg_2_1 == CourtYardShip.STATE_DRAG then
		return "tuozhuai2"
	elseif arg_2_1 == CourtYardShip.STATE_TOUCH then
		return "touch"
	elseif arg_2_1 == CourtYardShip.STATE_GETAWARD then
		return "motou"
	elseif arg_2_1 == CourtYardShip.STATE_INTERACT then
		-- block empty
	end

	return
end

function CourtYardShipAnimatorAgent:SetState(arg_3_1)
	self:RemoveAnimFinishTimer()

	local var_3_0 = self:State2AnimationName(arg_3_1)

	if not var_3_0 or self.name == var_3_0 then
		return
	end

	self:PlayAction(var_3_0, function()
		self:OnAnimtionFinish(arg_3_1)

		return
	end)

	return
end

function CourtYardShipAnimatorAgent:PlayInteractioAnim(arg_5_1)
	self:PlayAction(arg_5_1, function()
		self:OnAnimtionFinish(CourtYardShip.STATE_INTERACT)

		return
	end)
	self:CheckMissTagAction(arg_5_1)

	return
end

function CourtYardShipAnimatorAgent:PlayAction(arg_7_1, arg_7_2)
	self:RemoveAnimFinishTimer()
	self.spineAnimUI:SetActionCallBack(nil)
	self.spineAnimUI:SetActionCallBack(function(arg_8_0)
		if arg_8_0 == "finish" then
			self.spineAnimUI:SetActionCallBack(nil)
			arg_7_2()
		end

		return
	end)
	self._role:SetAction(arg_7_1)

	self.name = arg_7_1

	return
end

function CourtYardShipAnimatorAgent:CheckMissTagAction(arg_9_1)
	local var_9_0 = pg.furniture_specail_action[self.data:GetInterActionData():GetOwner().configId]

	if var_9_0 then
		local var_9_1 = _.detect(var_9_0.actions, function(arg_10_0)
			return arg_10_0[1] == arg_9_1
		end)

		if var_9_1 then
			self:AddAnimFinishTimer(var_9_1[2])
		end
	end

	return
end

function CourtYardShipAnimatorAgent:AddAnimFinishTimer(arg_11_1)
	self.animFinishTimer = Timer.New(function()
		self.animFinishTimer:Stop()

		self.animFinishTimer = nil

		self:OnAnimtionFinish(CourtYardShip.STATE_INTERACT)

		return
	end, arg_11_1, 1)

	self.animFinishTimer:Start()

	return
end

function CourtYardShipAnimatorAgent:RemoveAnimFinishTimer()
	if self.animFinishTimer then
		self.animFinishTimer:Stop()

		self.animFinishTimer = nil
	end

	return
end

function CourtYardShipAnimatorAgent:Dispose()
	self:RemoveAnimFinishTimer()
	CourtYardShipAnimatorAgent.super.Dispose(self)
	self.spineAnimUI:SetActionCallBack(nil)

	return
end

return CourtYardShipAnimatorAgent
