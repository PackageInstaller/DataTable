local AutoChessSubLabelView = class("AutoChessSubLabelView", ReduxView)

function AutoChessSubLabelView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
	self:SetActive(true)
end

function AutoChessSubLabelView:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListener()
	self:InitContext()
end

function AutoChessSubLabelView:InitUI()
	self.UiGradientCompoment = self:FindCom("UIGradient", nil, self.descTrans_)
	self.iconController_ = self.controller_:GetController("state")
end

function AutoChessSubLabelView:InitContext()
	self.context_ = {
		score = 1,
		data_uid = 1,
		base_praise_num = 666,
		is_praise = false
	}
end

function AutoChessSubLabelView:AddListener()
	self:AddBtnListener(self.praiseBtn_, nil, function()
		if self.isCanVote_ then
			manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_zan", "")

			self.context_.is_praise = not self.context_.is_praise

			self:UpdateView()

			if self.context_.is_praise then
				OperationRecorder.RecordButtonTouch({
					button_name = "activity_autochess_profile_like_touch",
					activity_id = AutoChessData:GetActivityID(),
					polyhedron_id_str = AutoChessData:GetPlayerData().battleUID,
					profile_label = self.context_.data_uid
				})
			end
		end
	end)
end

function AutoChessSubLabelView:SetData(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self.context_.data_uid = arg_7_1
	self.context_.score = arg_7_2
	self.context_.is_praise = false
	self.context_.base_praise_num = math.random(AutoChessTeamTagCfg[arg_7_1].vote_range[arg_7_2][1], AutoChessTeamTagCfg[arg_7_1].vote_range[arg_7_2][2])
	self.isCanVote_ = arg_7_3
	self.parentWidth_ = arg_7_4

	if not self.isCanVote_ then
		self.context_.is_praise = true
	end

	self:UpdateView()
end

function AutoChessSubLabelView:UpdateView()
	self.descText_.text = AutoChessTeamTagCfg[self.context_.data_uid].name
	self.numText_.text = self.context_.is_praise and tostring(self.context_.base_praise_num + 1) or tostring(self.context_.base_praise_num)

	self.iconController_:SetSelectedState("not")

	if self.context_.score == 3 then
		self.UiGradientCompoment.enabled = true

		if self.context_.is_praise then
			self.iconController_:SetSelectedState("toplike")
		end
	elseif self.context_.score == 2 then
		self.UiGradientCompoment.enabled = false

		if self.context_.is_praise then
			self.iconController_:SetSelectedState("like")
		end
	end
end

function AutoChessSubLabelView:SetActive(arg_9_1)
	self.gameObject_:SetActive(arg_9_1)
end

function AutoChessSubLabelView:GetLocalPosX()
	return self.transform_.localPosition.x
end

function AutoChessSubLabelView:SetMaxWidth(arg_11_1)
	self.maxWidth_ = arg_11_1

	self:UpdateLeanTween()
end

function AutoChessSubLabelView:UpdateLeanTween()
	self:StopTimer()

	local var_12_0 = 150
	local var_12_1 = self.parentWidth_ / 2 - self.maxWidth_

	self.frameTimer = FrameTimer.New(function()
		if self.transform_.localPosition.x < var_12_1 then
			self.transform_.localPosition = Vector2.New(self.parentWidth_ / 2 + self.transform_.rect.width / 2 + 100, self.transform_.localPosition.y)
		end

		self.transform_.localPosition = Vector2.New(self.transform_.localPosition.x - Time.deltaTime * var_12_0, self.transform_.localPosition.y)
	end, 1, -1)

	self.frameTimer:Start()
end

function AutoChessSubLabelView:StopTimer()
	if self.frameTimer then
		self.frameTimer:Stop()

		self.frameTimer = nil
	end
end

function AutoChessSubLabelView:OnExit()
	self:StopTimer()
end

function AutoChessSubLabelView:Dispose()
	AutoChessSubLabelView.super.Dispose(self)
end

return AutoChessSubLabelView
