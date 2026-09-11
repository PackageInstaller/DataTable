local RedEnvelopePopView = class("RedEnvelopePopView", ReduxView)

function RedEnvelopePopView:UIName()
	return "Widget/Version/CORGUI_3_10/RedEnvelope_3_10/RedEnvelopePopUI"
end

function RedEnvelopePopView:UIParent()
	return manager.ui.uiPop.transform
end

function RedEnvelopePopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function RedEnvelopePopView:InitUI()
	self:BindCfgUI()

	self.cardCon_ = self.item_:GetComponent("ControllerExCollection"):GetController("card")
	self.flipCon_ = self.item_:GetComponent("ControllerExCollection"):GetController("flip")
end

function RedEnvelopePopView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		if not self.params_.isGetReward then
			RedEnvelopeData:SetIsFlipCardAnim(true)
		end

		RedEnvelopeData:SetIsResetNormalSelect(false)
		self:Back()
	end)
end

function RedEnvelopePopView:OnEnter()
	self.id = self.params_.id
	self.hero_id = ActivitySpringRedEnvelopeCfg[self.id].letter_people
	self.reward_list = self.params_.reward_list
	self.bgBtn_.enabled = false

	if self.params_.isGetReward then
		self.isGetReward = self.params_.isGetReward
		self.bgBtn_.enabled = true
	end

	self.cardCon_:SetSelectedIndex(1)
	self.flipCon_:SetSelectedIndex(1)
	self:RefreshView()
end

function RedEnvelopePopView:RefreshView()
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/BackHouseUI/Portrait/" .. self.hero_id)
	self.num_.text = self.reward_list.num
	self.talkTxt_.text = ActivitySpringRedEnvelopeCfg[self.id].letter_content

	if self.isGetReward then
		self.cardCon_:SetSelectedIndex(0)
		self.flipCon_:SetSelectedIndex(0)
		SetActive(self.characterGo_, true)
	else
		self:AddTimer()
	end
end

function RedEnvelopePopView:AddTimer()
	self:StopTimer()

	self.timer_ = Timer.New(function()
		self.flipCon_:SetSelectedIndex(0)
		self.flipAnim_:Play("UI_card_cx")
		self.flipAnim_:Update(0)
		self:AnimTimer()
		self:StopTimer()
	end, 1.5, -1)

	self.timer_:Start()
end

function RedEnvelopePopView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function RedEnvelopePopView:AnimTimer()
	self:StopAnimTimer()

	self.animtimer_ = Timer.New(function()
		getReward(formatRewardCfgList({
			self.reward_list
		}), nil, function()
			self.cardCon_:SetSelectedIndex(0)
			SetActive(self.characterGo_, true)
		end)
		self:StopAnimTimer()
	end, 1.5, -1)

	self.animtimer_:Start()
end

function RedEnvelopePopView:StopAnimTimer()
	if self.animtimer_ then
		self.bgBtn_.enabled = true

		self.animtimer_:Stop()

		self.animtimer_ = nil
	end
end

function RedEnvelopePopView:OnExit()
	self:StopTimer()
	self:StopAnimTimer()
end

function RedEnvelopePopView:Dispose()
	self:RemoveAllListeners()
	RedEnvelopePopView.super.Dispose(self)
end

return RedEnvelopePopView
