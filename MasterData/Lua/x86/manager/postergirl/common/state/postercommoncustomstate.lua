local PosterCommonCustomState = class("PosterCommonCustomState", PosterCommonTimelineState)

function PosterCommonCustomState:Enter()
	PosterCommonCustomState.super.Enter(self)
end

function PosterCommonCustomState:Exit()
	self.onPlayComplete = nil

	PosterCommonCustomState.super.Exit(self)
end

function PosterCommonCustomState:TimelineStopCallback()
	if self.onPlayComplete then
		self.onPlayComplete()
	end
end

function PosterCommonCustomState:SetCompleteCallback(arg_4_1)
	self.onPlayComplete = arg_4_1
end

return PosterCommonCustomState
