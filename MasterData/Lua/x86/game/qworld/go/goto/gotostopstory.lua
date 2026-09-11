local GotoStopStory = class("GotoStopStory", BaseGoto)

function GotoStopStory:Go(arg_1_1, ...)
	QWorldMgr:GetQWorldStoryMgr():StopStory()
end

return GotoStopStory
