local ChallengeRogueTeamMapTimelineView = class("ChallengeRogueTeamMapTimelineView", ReduxView)

function ChallengeRogueTeamMapTimelineView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.parent_ = arg_1_1
	self.gameObject_ = Object.Instantiate(Asset.Load(arg_1_2), arg_1_3.transform)
	self.transform_ = self.gameObject_.transform
	self.playableDirector_ = self.gameObject_:GetComponent(typeof(PlayableDirector))
end

function ChallengeRogueTeamMapTimelineView:OnEnter()
	self:AddMoveFollowTimer()
	SetActive(self.gameObject_, true)
end

function ChallengeRogueTeamMapTimelineView:OnExit()
	self:StopMoveFollowTimer()
	SetActive(self.gameObject_, false)
end

function ChallengeRogueTeamMapTimelineView:Dispose()
	ChallengeRogueTeamMapTimelineView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamMapTimelineView:AddMoveFollowTimer()
	self:Play()

	self.moveFollowTimer_ = FrameTimer.New(function()
		self:Play()
	end, 1, -1)

	self.moveFollowTimer_:Start()
end

function ChallengeRogueTeamMapTimelineView:Play()
	local var_7_0 = -1 * self.parent_.contentRect_.localPosition.x / self.parent_.contentRect_.rect.width

	if -1 * self.parent_.contentRect_.localPosition.x / self.parent_.contentRect_.rect.width < 0 then
		var_7_0 = 0
	elseif var_7_0 > 1 then
		var_7_0 = 1
	end

	self.playableDirector_.time = self.playableDirector_.duration * var_7_0

	self.playableDirector_:Evaluate()
end

function ChallengeRogueTeamMapTimelineView:StopMoveFollowTimer()
	if self.moveFollowTimer_ then
		self.moveFollowTimer_:Stop()

		self.moveFollowTimer_ = nil
	end
end

return ChallengeRogueTeamMapTimelineView
