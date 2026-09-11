local StoryCallback = class("StoryCallback")

function StoryCallback:Ctor()
	return
end

StoryCallback.OnBeforeStart = nil
StoryCallback.OnAfterStop = nil
StoryCallback.OnBeforeStop = nil
StoryCallback.OnStop = nil

return StoryCallback
