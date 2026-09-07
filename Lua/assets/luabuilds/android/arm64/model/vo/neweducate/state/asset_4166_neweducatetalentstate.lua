local NewEducateTalentState = class("NewEducateTalentState", import(".NewEducateStateBase"))

function NewEducateTalentState:Ctor(arg_1_1)
	self.talents = arg_1_1.talents or {}
	self.reTalents = arg_1_1.retalents or {}
	self.finishFlag = arg_1_1.finished == 1

	return
end

function NewEducateTalentState:SetTalents(arg_2_1)
	self.talents = arg_2_1

	return
end

function NewEducateTalentState:GetTalents()
	return self.talents
end

function NewEducateTalentState:OnRefreshTalent(arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(self.talents) do
		if iter_4_1 == arg_4_1 then
			self.talents[iter_4_0] = arg_4_2

			table.insert(self.reTalents, self.talents[iter_4_0])
		end
	end

	return
end

function NewEducateTalentState:GetReTalents()
	return self.reTalents
end

function NewEducateTalentState:MarkFinish()
	self.finishFlag = true

	return
end

function NewEducateTalentState:IsFinish()
	return self.finishFlag
end

function NewEducateTalentState:Reset()
	self.talents = {}
	self.reTalents = {}
	self.finishFlag = false

	return
end

return NewEducateTalentState
