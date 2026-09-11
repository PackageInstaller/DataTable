local PosterDlcTimelineState = class("PosterDlcTimelineState", PosterCommonTimelineState)

local function var_0_1(arg_1_0, arg_1_1)
	return nullable(HeroInteractActionCfg, (string.format("%d_%s", arg_1_0, arg_1_1))) or {
		action = "default",
		type = 0,
		embed_list = {}
	}
end

function PosterDlcTimelineState:Ctor(arg_2_1)
	PosterDlcTimelineState.super.Ctor(self, arg_2_1)
end

function PosterDlcTimelineState:Enter()
	manager.ui:SetMainCameraCom("CinemachineBrain", true)
	PosterDlcTimelineState.super.Enter(self)
end

function PosterDlcTimelineState:PlayAni(arg_4_1)
	local var_4_0 = var_0_1(self.actor:GetSkinId(), arg_4_1)

	if var_4_0.type == 1 then
		self.playingSeq_ = var_4_0.embed_list

		self:PlaySequence(1)
	else
		local var_4_1 = var_4_0.embed_list[1] or arg_4_1
		local var_4_2 = self:GetHeroTimelineMgr()

		var_4_2:PlayAction(var_4_1, {
			fadeSecond = 0,
			talking = self.talking_,
			isLoop = string.find(arg_4_1, "^action1_") ~= nil and true or nil
		})
		var_4_2:SetCallbackStopped(function(arg_5_0)
			if self.forceExiting_ then
				self.forceExiting_ = nil
				arg_5_0.time = arg_5_0.duration

				arg_5_0:Evaluate()
			end

			self:TimelineStopCallback()
		end)
	end
end

function PosterDlcTimelineState:TimelineStopCallback()
	self:PlayNextAni()
end

function PosterDlcTimelineState:Exit(arg_7_1)
	self.playingSeq_ = nil
	self.playingSeqIdx_ = nil
	self.forceExiting_ = arg_7_1

	PosterDlcTimelineState.super.Exit(self, arg_7_1)
	manager.ui:SetMainCameraCom("CinemachineBrain", false)
end

function PosterDlcTimelineState:PlayNextAni()
	if self.playingSeq_ and #self.playingSeq_ > self.playingSeqIdx_ then
		self:GetHeroTimelineMgr():SetCallbackStopped(nil)
		self:PlaySequence(self.playingSeqIdx_ + 1)

		return
	end

	self.actor:ChangeState(PosterGirlConst.StateKay.init)
end

function PosterDlcTimelineState:CanPlayNextAni()
	if self.playingSeq_ then
		local var_9_0 = var_0_1(self.actor:GetSkinId(), self.playingSeq_[self.playingSeqIdx_])

		if var_9_0.click_to_skip == 1 or var_9_0.click_to_skip == true then
			return true
		end
	end

	return false
end

function PosterDlcTimelineState:PlaySequence(arg_10_1)
	self.playingSeqIdx_ = arg_10_1

	self:PlayAni(self.playingSeq_[arg_10_1])
end

function PosterDlcTimelineState:PlayAniWithParams(arg_11_1)
	local var_11_0 = HomeSceneSettingCfg[self.actor:GetSceneID()]
	local var_11_1 = var_11_0 and var_11_0.action_suffix

	if string.isNullOrEmpty(var_11_0 and var_11_0.action_suffix) then
		self:PlayAni(arg_11_1)
	else
		self:PlayAni(string.format("%s__%s", arg_11_1, var_11_1))
	end
end

return PosterDlcTimelineState
