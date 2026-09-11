local RedEnvelopeItemView = class("RedEnvelopeItemView", ReduxView)

function RedEnvelopeItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.index = arg_1_2

	self:Init()
end

function RedEnvelopeItemView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function RedEnvelopeItemView:InitUI()
	self:BindCfgUI()

	self.headCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("head")
	self.starCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("star")
	self.getCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("get")
	self.flipCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("flip")
	self.blingCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("showBling")
	self.selectCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("select")
end

function RedEnvelopeItemView:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.isGet then
			-- block empty
		elseif self.receiveFunc_ then
			self.selectCon_:SetSelectedIndex(1)
			self.receiveFunc_(self.index)
		end
	end)
end

function RedEnvelopeItemView:SetStarCtl(arg_6_1)
	self.starCon_:SetSelectedIndex(arg_6_1)
end

function RedEnvelopeItemView:SetHeadCtl(arg_7_1)
	self.headCon_:SetSelectedIndex(arg_7_1)

	if arg_7_1 == 1 then
		self.blingCon_:SetSelectedIndex(math.random(0, 1))
		self:BlingTimer()

		return
	end

	self.blingCon_:SetSelectedIndex(arg_7_1)
end

function RedEnvelopeItemView:SetGetCtl(arg_8_1)
	self.getCon_:SetSelectedIndex(arg_8_1)
end

function RedEnvelopeItemView:SetData(arg_9_1, arg_9_2)
	self.isGet = arg_9_1
	self.curSelectDay = RedEnvelopeData:GetCurSelectDay()

	self:StopTimer()
	self:StopTimerHideMeme()
	SetActive(self.memeGo_, false)

	for iter_9_0, iter_9_1 in ipairs(arg_9_2) do
		if self.curSelectDay == iter_9_1.id - 1000 then
			for iter_9_2, iter_9_3 in ipairs(iter_9_1.hero_reward) do
				if iter_9_3.location == self.index then
					self.reward_list = iter_9_3.reward_list
					self.hero_id = iter_9_3.hero_id

					break
				end
			end
		end
	end

	if arg_9_1 then
		self.itemAnim_:Play("empty")
		self.flipAnim_:Play("empty")

		if self.reward_list and self.reward_list[1] and self.numTxt_ then
			self.numTxt_.text = self.reward_list[1].num
		end

		if self.hero_id and self.hero_id == 1 then
			self.hero_id = ActivitySpringRedEnvelopeCfg[RedEnvelopeData:GetCurSelectDay() + 1000].letter_people
		end

		self.headIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_3_10/SandPlay_3_10/SandPlay_3_10_RedEnvelope/RedEnvelope_head_" .. self.hero_id)
	end
end

function RedEnvelopeItemView:RefreshView(arg_10_1, arg_10_2)
	self.isGet = arg_10_1
	self.curSelectDay = RedEnvelopeData:GetCurSelectDay()

	self:StopTimer()
	self:StopTimerHideMeme()
	SetActive(self.memeGo_, false)

	for iter_10_0, iter_10_1 in ipairs(arg_10_2) do
		if self.curSelectDay == iter_10_1.id - 1000 then
			for iter_10_2, iter_10_3 in ipairs(iter_10_1.hero_reward) do
				if iter_10_3.location == self.index then
					self.reward_list = iter_10_3.reward_list
					self.hero_id = iter_10_3.hero_id

					break
				end
			end
		end
	end

	if arg_10_1 then
		self.flipCon_:SetSelectedIndex(0)
		self.itemAnim_:Play("empty")

		if self.reward_list and self.reward_list[1] and self.numTxt_ then
			self.numTxt_.text = self.reward_list[1].num
		end

		if self.hero_id and self.hero_id == 1 then
			self.hero_id = ActivitySpringRedEnvelopeCfg[RedEnvelopeData:GetCurSelectDay() + 1000].letter_people

			self.starCon_:SetSelectedIndex(1)
			self.headCon_:SetSelectedIndex(0)
			self.blingCon_:SetSelectedIndex(0)
			self.getCon_:SetSelectedIndex(1)
		else
			self.starCon_:SetSelectedIndex(0)
			self.headCon_:SetSelectedIndex(1)
			self.blingCon_:SetSelectedIndex(0)
			self.getCon_:SetSelectedIndex(0)
			self:RefreshMemeIcon()
		end

		self.headIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_3_10/SandPlay_3_10/SandPlay_3_10_RedEnvelope/RedEnvelope_head_" .. self.hero_id)
	else
		self.flipCon_:SetSelectedIndex(1)
		self.starCon_:SetSelectedIndex(0)
		self.headCon_:SetSelectedIndex(0)
		self.blingCon_:SetSelectedIndex(0)
		self.getCon_:SetSelectedIndex(0)
		self.itemAnim_:Play("UI_talk_cx")
		self.itemAnim_:Update(0)
	end
end

function RedEnvelopeItemView:StopBlingTimer()
	if self.blingTimer_ then
		self.blingTimer_:Stop()

		self.blingTimer_ = nil
	end
end

function RedEnvelopeItemView:BlingTimer()
	self:StopBlingTimer()

	self.blingTimer_ = Timer.New(function()
		self.blingCon_:SetSelectedIndex(0)
	end, 2, -1)

	self.blingTimer_:Start()
end

function RedEnvelopeItemView:RefreshMemeIcon(arg_14_1)
	if self.index == arg_14_1 then
		SetActive(self.memeGo_, false)

		return
	end

	self.meme_list = {}

	for iter_14_0, iter_14_1 in ipairs(ActivitySpringRedEnvelopeCfg[self.curSelectDay + 1000].hero_meme_list) do
		if iter_14_1[1] == self.hero_id then
			self.meme_list = iter_14_1[2]
			self.delayTime = iter_14_1[3]

			break
		end
	end

	if self.meme_list and #self.meme_list > 0 then
		self:AddTimer()
	end
end

function RedEnvelopeItemView:AddTimer()
	self:StopTimer()

	self.timer_ = Timer.New(function()
		SetActive(self.memeGo_, true)

		self.memeImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Chat/ChatSticker/" .. self.meme_list[math.random(1, #self.meme_list)])

		self:StopTimer()
		self:HideMeme()
	end, self.delayTime, -1)

	self.timer_:Start()
end

function RedEnvelopeItemView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function RedEnvelopeItemView:HideMeme()
	self:StopTimerHideMeme()

	self.timer_hidememe = Timer.New(function()
		SetActive(self.memeGo_, false)
		self:StopTimerHideMeme()
	end, GameSetting.chatsticker_show_time.value[1], -1)

	self.timer_hidememe:Start()
end

function RedEnvelopeItemView:StopTimerHideMeme()
	if self.timer_hidememe then
		self.timer_hidememe:Stop()

		self.timer_hidememe = nil
	end
end

function RedEnvelopeItemView:RegisterClickFunc(arg_21_1)
	self.receiveFunc_ = arg_21_1
end

function RedEnvelopeItemView:RefreshAnim()
	self.selectCon_:SetSelectedIndex(0)
	self.flipCon_:SetSelectedIndex(0)
	self.flipAnim_:Play("UI_card_cx")
	self.flipAnim_:Update(0)
end

function RedEnvelopeItemView:OnExit()
	self:StopTimer()
	self:StopTimerHideMeme()
	self:StopBlingTimer()
end

function RedEnvelopeItemView:Dispose()
	self:RemoveAllListeners()
	RedEnvelopeItemView.super.Dispose(self)
end

return RedEnvelopeItemView
