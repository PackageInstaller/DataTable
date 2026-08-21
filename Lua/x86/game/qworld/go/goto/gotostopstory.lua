local var_0_0 = class("GotoStopStory", BaseGoto)

function var_0_0.Go(arg_1_0, arg_1_1, ...)
	QWorldMgr:GetQWorldStoryMgr():StopStory()
end

return var_0_0
