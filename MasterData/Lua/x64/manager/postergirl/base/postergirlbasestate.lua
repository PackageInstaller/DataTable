local PosterGirlBaseState = class("PosterGirlBaseState")

function PosterGirlBaseState:Ctor(arg_1_1)
	self.actor = arg_1_1
	self.state_key = nil
end

function PosterGirlBaseState:GetHeroTimelineMgr()
	return self.actor:GetHeroTimelineMgr()
end

function PosterGirlBaseState:Enter()
	return
end

function PosterGirlBaseState:Update()
	return
end

function PosterGirlBaseState:Exit(arg_5_1)
	return
end

function PosterGirlBaseState:Dispose()
	self:Exit(true)
end

function PosterGirlBaseState:SetStateKey(arg_7_1)
	self.state_key = arg_7_1
end

function PosterGirlBaseState:GetStateKey()
	return self.state_key
end

function PosterGirlBaseState:CanPlayNextAni()
	return false
end

function PosterGirlBaseState:AcceptTouch()
	return false
end

function PosterGirlBaseState:PlaySpecialTalk(arg_11_1, arg_11_2)
	return
end

return PosterGirlBaseState
