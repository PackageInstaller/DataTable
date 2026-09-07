local NewEducateTopicState = class("NewEducateTopicState", import(".NewEducateStateBase"))

function NewEducateTopicState:Ctor(arg_1_1)
	self.topics = arg_1_1.chats or {}
	self.finishFlag = arg_1_1.finished == 1

	return
end

function NewEducateTopicState:SetTopics(arg_2_1)
	self.topics = arg_2_1

	return
end

function NewEducateTopicState:GetTopics()
	return self.topics
end

function NewEducateTopicState:MarkFinish()
	self.finishFlag = true

	return
end

function NewEducateTopicState:IsFinish()
	return self.finishFlag
end

function NewEducateTopicState:Reset()
	self.topics = {}
	self.finishFlag = false

	return
end

return NewEducateTopicState
