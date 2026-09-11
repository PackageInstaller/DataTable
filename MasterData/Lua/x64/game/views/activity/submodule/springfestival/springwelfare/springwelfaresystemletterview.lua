local SpringWelfareSystemLetterView = class("SpringWelfareSystemLetterView", ReduxView)

function SpringWelfareSystemLetterView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeLetterPopUI"
end

function SpringWelfareSystemLetterView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringWelfareSystemLetterView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.rewardUiList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, SpringWelfareLetterRewardItem)
	self.shareController_ = ControllerUtil.GetController(self.transform_, "share")
	self.arrowController_ = ControllerUtil.GetController(self.transform_, "arrow")
end

function SpringWelfareSystemLetterView:OnEnter()
	self.letterServerId_ = self.params_.letterServerId

	local var_4_0 = SpringWelfareData:GetLetterData(self.letterServerId_)

	self.firstView_ = self.params_.firstView

	if self.params_.gotReward == false then
		self.gotReward_ = false
		self.params_.gotReward = nil
	end

	self.rewardList_ = SpringWelfareData:GetLetterData(self.letterServerId_).rewardList

	self:RefreshArrowUI()
	self:RefreshUI()
end

function SpringWelfareSystemLetterView:OnTop()
	self:OnEnter()
end

function SpringWelfareSystemLetterView:OnExit()
	AnimatorTools.Stop()
end

function SpringWelfareSystemLetterView:OnTop()
	SetActive(self.gameObject_, true)
end

function SpringWelfareSystemLetterView:OnBehind()
	SetActive(self.gameObject_, false)
end

function SpringWelfareSystemLetterView:Dispose()
	self.rewardUiList_:Dispose()
	SpringWelfareSystemLetterView.super.Dispose(self)
end

function SpringWelfareSystemLetterView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:OnClickClose()
	end)
	self:AddBtnListener(self.shareBtn_, nil, function()
		manager.share:Share(function()
			self.shareController_:SetSelectedState("false")
		end, function()
			self.shareController_:SetSelectedState("true")
		end, function()
			return
		end)
	end)
	self:AddBtnListener(self.leftArrowBtn_, nil, function()
		self:JumpNextLetter(-1)
	end)
	self:AddBtnListener(self.rightArrowBtn_, nil, function()
		self:JumpNextLetter(1)
	end)
end

function SpringWelfareSystemLetterView:IndexItem(arg_18_1, arg_18_2)
	local var_18_0 = self.rewardList_[arg_18_1][1]
	local var_18_1 = self.rewardList_[arg_18_1][2]

	arg_18_2:SetClickHandler(function(arg_19_0)
		ShowPopItem(POP_ITEM, {
			var_18_0
		})
	end)
	arg_18_2:SetData(var_18_0, var_18_1, not self.firstView_ or self.gotReward_)
end

function SpringWelfareSystemLetterView:RefreshUI()
	self:RefreshLetterUI()
	self:RefreshHeroUI()
	self:RefreshRewardList()
	self.shareController_:SetSelectedState(self.firstView_ and "false" or "true")
end

function SpringWelfareSystemLetterView:RefreshLetterUI()
	local var_21_0 = SpringWelfareData:GetLetterData(self.letterServerId_).letterId

	self.titleText_.text = GetTips(SpringPreheatData:GetLetterTitle(var_21_0))
	self.contentText_.text = GetTips(SpringPreheatData:GetLetterFixedText(var_21_0, 1, 1))
end

function SpringWelfareSystemLetterView:RefreshHeroUI()
	local var_22_0 = self:GetHeroId()
	local var_22_1 = HeroData:GetHeroData(var_22_0)

	self.heroImg_.sprite = HeroTools.GetHeadSprite(var_22_0)
	self.heroNameText_.text = HeroTools.GetHeroFullName(var_22_0)
end

function SpringWelfareSystemLetterView:RefreshRewardList()
	self.rewardUiList_:StartScrollWithoutAnimator(#self.rewardList_)
	self.rewardUiList_:Refresh()
end

function SpringWelfareSystemLetterView:RefreshArrowUI()
	if self.firstView_ then
		self.arrowController_:SetSelectedState("none")

		return
	end

	local var_24_0 = self:GetLetterIdList()
	local var_24_1 = table.indexof(var_24_0, self.letterServerId_)
	local var_24_2 = var_24_1 > 1
	local var_24_3 = var_24_1 < #var_24_0

	if var_24_1 > 1 and var_24_3 then
		self.arrowController_:SetSelectedState("both")
	elseif var_24_2 then
		self.arrowController_:SetSelectedState("left")
	elseif var_24_3 then
		self.arrowController_:SetSelectedState("right")
	else
		self.arrowController_:SetSelectedState("none")
	end
end

function SpringWelfareSystemLetterView:JumpNextLetter(arg_25_1)
	local var_25_0 = self:GetLetterIdList()
	local var_25_1 = table.indexof(var_25_0, self.letterServerId_) + arg_25_1

	if var_25_1 < 1 or #var_25_0 < var_25_1 then
		return
	end

	self:Back()
	JumpTools.OpenPageByJump("springWelfareSystemLetter", {
		letterServerId = var_25_0[var_25_1]
	})
end

function SpringWelfareSystemLetterView:GetLetterIdList()
	return SpringWelfareData:GetSystemLetterIdList()
end

function SpringWelfareSystemLetterView:OnClickClose()
	if not self.firstView_ then
		self:Back()

		return
	end

	if self.gotReward_ then
		self:Back()

		local var_27_0 = SpringWelfareData:GetNextNewPlayerLetterId()

		if var_27_0 then
			JumpTools.OpenPageByJump("springWelfarePlayerLetter", {
				firstView = true,
				letterServerId = var_27_0
			})
		end
	else
		SpringWelfareAction:AcquireLetterReward(SpringWelfareData:GetLetterData(self.letterServerId_).day, function()
			self.gotReward_ = true

			self.rewardUiList_:Refresh()
			SpringWelfareAction:UpdateRedPoint(SpringWelfareData:GetActivityId())
		end)
	end
end

function SpringWelfareSystemLetterView:GetHeroId()
	return SpringWelfareData:GetLetterData(self.letterServerId_).heroId
end

return SpringWelfareSystemLetterView
