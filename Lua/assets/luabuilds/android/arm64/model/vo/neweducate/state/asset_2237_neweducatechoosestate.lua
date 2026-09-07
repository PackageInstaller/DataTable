local NewEducateChooseState = class("NewEducateChooseState", import(".NewEducateStateBase"))

NewEducateChooseState.TYPE = {
	ENTRY = 2,
	TAROT = 1
}

function NewEducateChooseState:Ctor(arg_1_1)
	self:UpdataData(arg_1_1)

	self.finishFlag = false

	return
end

function NewEducateChooseState:IsPriorityType()
	return true
end

function NewEducateChooseState:GetSystemNo()
	return NewEducatePriorityFSM.SYSTEM.CHOOSE
end

function NewEducateChooseState:UpdataData(arg_4_1)
	self.choices = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.selects or {}) do
		table.insert(self.choices, iter_4_1.id)
	end

	self.refreshCnts = arg_4_1.reroll_count or {}
	self.isFromShop = arg_4_1.is_from_shop == 1

	return
end

function NewEducateChooseState:GetChoices()
	return self.choices
end

function NewEducateChooseState:GetUsedCnts()
	return self.refreshCnts
end

function NewEducateChooseState:IsFromShop()
	return self.isFromShop
end

function NewEducateChooseState:MarkFinish()
	self.finishFlag = true

	return
end

function NewEducateChooseState:IsFinish()
	return self.finishFlag
end

function NewEducateChooseState:Reset()
	self.choices = {}
	self.refreshCnts = {}
	self.finishFlag = false

	return
end

return NewEducateChooseState
