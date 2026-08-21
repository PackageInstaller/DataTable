-- chunkname: @IQIGame\\Module\\Story\\FSM\\StoryTimeLineState.lua

StoryTimeLineState = class(nil, FSMState)
StoryTimeLineState.Name = "StoryTimeLineState"

function StoryTimeLineState:OnEnter()
	local storyCharacter = self.FSM.storyCharacter
end

function StoryTimeLineState:OnUpdate(deltaTime)
	return
end

function StoryTimeLineState:OnFixedUpdate(fixedDeltaTime)
	return
end

function StoryTimeLineState:OnExit()
	return
end

return StoryTimeLineState
