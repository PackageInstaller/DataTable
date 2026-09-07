local SkirmishVO = class("SkirmishVO", import(".BaseVO"))

SkirmishVO.TypeStoryOrExpedition = 1
SkirmishVO.TypeChapter = 2
SkirmishVO.StateInactive = 0
SkirmishVO.StateActive = 1
SkirmishVO.StateWorking = 2
SkirmishVO.StateClear = 3

function SkirmishVO:bindConfigTable()
	return pg.activity_skirmish_event
end

function SkirmishVO:Ctor(arg_2_1)
	self.id = arg_2_1
	self.configId = arg_2_1
	self.state = SkirmishVO.StateInactive
	self.flagNew = nil

	return
end

function SkirmishVO:SetState(arg_3_1)
	arg_3_1 = arg_3_1 or 0

	if arg_3_1 == self.state then
		return
	end

	if self.state ~= nil and arg_3_1 == SkirmishVO.StateWorking then
		self.flagNew = true
	end

	self.state = arg_3_1

	return
end

function SkirmishVO:GetState()
	return self.state
end

function SkirmishVO:GetType()
	return self:getConfig("type")
end

function SkirmishVO:GetEvent()
	return self:getConfig("event")
end

return SkirmishVO
