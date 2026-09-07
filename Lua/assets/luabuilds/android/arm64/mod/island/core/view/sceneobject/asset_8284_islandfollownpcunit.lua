local IslandFollowNpcUnit = class("IslandFollowNpcUnit", import(".IslandDressupNpcUnit"))

function IslandFollowNpcUnit:Ctor(arg_1_1, arg_1_2)
	IslandFollowNpcUnit.super.Ctor(self, arg_1_1, arg_1_2)

	self.randomizer = arg_1_2.randomizer

	return
end

function IslandFollowNpcUnit:OnInit(arg_2_1, arg_2_2)
	IslandFollowNpcUnit.super.OnInit(self, arg_2_1, arg_2_2)
	self:WarpAgent()

	return
end

function IslandFollowNpcUnit:ResetPosition()
	self._go.transform.eulerAngles = self.rotation
	self._go.transform.position = self:GetNavPosition()

	return
end

function IslandFollowNpcUnit:GetNavPosition()
	for iter_4_0 = 1, 100 do
		local var_4_0 = IslandCalcUtil.GetRandomPointInSector(self.position, -self._go.transform.forward, 3, 270)
		local var_4_1 = IslandHelper.IsPointInWalkableArea(var_4_0, 0.2)

		if var_4_1 then
			return var_4_0
		end

		local var_4_2 = IslandHelper.SampleWalkablPosition(var_4_0, 2)

		if var_4_1 and var_4_2 ~= var_4_0 then
			return var_4_2
		end
	end

	return IslandHelper.SampleWalkablPosition(self.position, self.position.y * 1.1)
end

function IslandFollowNpcUnit:OnAttach(arg_5_1)
	IslandFollowNpcUnit.super.OnAttach(self, arg_5_1)
	self:UpdateBtRandomizer()
	self.behaviourTreeOwner.graph.blackboard:SetVariableValue("following", true)

	return
end

function IslandFollowNpcUnit:UpdateBtRandomizer()
	self.behaviourTreeOwner.graph.blackboard:SetVariableValue("randomizer", self.randomizer)

	return
end

function IslandFollowNpcUnit:SetBtRandomizer()
	self:StopBt()

	self.randomizer = true

	self:UpdateBtRandomizer()
	self:RestartBt()

	return
end

function IslandFollowNpcUnit:DoExitHandle()
	self.isExiting = true

	self.behaviourTreeOwner.graph.blackboard:SetVariableValue("following", false)

	return
end

function IslandFollowNpcUnit:IsExitState()
	return self.isExiting
end

return IslandFollowNpcUnit
