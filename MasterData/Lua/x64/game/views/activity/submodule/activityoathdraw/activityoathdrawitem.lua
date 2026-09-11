local ActivityOathDrawItem = class("ActivityOathDrawItem", ReduxView)
local var_0_1 = {
	best = 3,
	good = 2,
	normal = 1
}
local var_0_2 = {
	[var_0_1.normal] = "UI_cookie_bg_normal",
	[var_0_1.good] = "UI_cookie_bg_good",
	[var_0_1.best] = "UI_cookie_bg_best"
}

function ActivityOathDrawItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.index = arg_1_2
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function ActivityOathDrawItem:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = self.controller_:GetController("state")
end

function ActivityOathDrawItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if not self.isOpen and self.drawCallBack then
			self.drawCallBack(self.index)
		end
	end)
end

function ActivityOathDrawItem:Show(arg_5_1)
	self.isShow = arg_5_1

	self.gameObject_:SetActive(arg_5_1)
end

function ActivityOathDrawItem:SetDrawCallBack(arg_6_1)
	self.drawCallBack = arg_6_1
end

function ActivityOathDrawItem:SetData(arg_7_1)
	self.drawData = arg_7_1

	self:InitData()
	self:RefreshUI()
end

function ActivityOathDrawItem:InitData()
	self.dropID = self.drawData.dropID
	self.isOpen = self.drawData.isOpen
	self.poolID = self.drawData.poolID

	self:GetQualityType(self.dropID)
end

function ActivityOathDrawItem:GetIsBestReward()
	return self.qualityType == var_0_1.best
end

function ActivityOathDrawItem:GetQualityType(arg_10_1)
	if arg_10_1 == 0 or arg_10_1 == nil then
		return
	end

	self.qualityType = ActivityLimitedDrawPoolCfg[arg_10_1].minimum_guarantee == 1 and var_0_1.normal or ActivityLimitedDrawPoolListCfg[self.poolID].main_icon_info[1][1] == arg_10_1 and var_0_1.best or var_0_1.good
end

function ActivityOathDrawItem:CheckRefreshAniState()
	if not self.bgAni_:GetCurrentAnimatorStateInfo(0):IsName(var_0_2[self.qualityType]) then
		self.bgAni_:Play(var_0_2[self.qualityType], 0, 1)
	end
end

function ActivityOathDrawItem:RefreshUI()
	if not self.isOpen then
		self.stateController_:SetSelectedState("cookie")
		self.bgAni_:Play("UI_bg_cookie_chongzhi")
	else
		if self.qualityType == var_0_1.normal then
			self.stateController_:SetSelectedState("normal")
		elseif self.qualityType == var_0_1.good then
			self.stateController_:SetSelectedState("good")
		elseif self.qualityType == var_0_1.best then
			self.stateController_:SetSelectedState("best")
		end

		self:CheckRefreshAniState()
		self:RefreshReawrdShow(self.dropID)
	end
end

function ActivityOathDrawItem:PlayOpenAni(arg_13_1)
	self:RefreshReawrdShow(arg_13_1.dropID)
	self:GetQualityType(arg_13_1.dropID)
	self.bgAni_:Play(var_0_2[self.qualityType], 0, 0)
	self:AddOpenAniTimer(arg_13_1)
end

function ActivityOathDrawItem:DelOpenAniTimer()
	if self.openAniTimer_ then
		self.openAniTimer_:Stop()

		self.openAniTimer_ = nil
	end
end

function ActivityOathDrawItem:AddOpenAniTimer(arg_15_1)
	self:DelOpenAniTimer()

	self.openAniTimer_ = Timer.New(function()
		local var_16_0 = self.bgAni_:GetCurrentAnimatorStateInfo(0)

		if var_16_0:IsName(var_0_2[self.qualityType]) and var_16_0.normalizedTime >= 0.8 then
			self:DelOpenAniTimer()
			self:SetData(arg_15_1)
		end
	end, 0.1, -1)

	self.openAniTimer_:Start()
end

function ActivityOathDrawItem:IsFinishOpenAni()
	local var_17_0 = self.bgAni_:GetCurrentAnimatorStateInfo(0)

	return var_17_0:IsName(var_0_2[self.qualityType]) and var_17_0.normalizedTime >= 1.2
end

function ActivityOathDrawItem:IsCanOpenNext()
	local var_18_0 = self.bgAni_:GetCurrentAnimatorStateInfo(0)

	return var_18_0:IsName(var_0_2[self.qualityType]) and var_18_0.normalizedTime >= 0.35
end

function ActivityOathDrawItem:PlayCloseAni()
	self.stateController_:SetSelectedState("cookie")
	self.bgAni_:Play("UI_bg_cookie_fanpai_01", 0, 0)
end

function ActivityOathDrawItem:IsFinishCloseAni()
	local var_20_0 = self.bgAni_:GetCurrentAnimatorStateInfo(0)

	return var_20_0:IsName("UI_bg_cookie_chongzhi") or var_20_0:IsName("UI_bg_cookie_fanpai_01") and var_20_0.normalizedTime >= 1
end

function ActivityOathDrawItem:RefreshReawrdShow(arg_21_1)
	if self.rewardItem_ == nil then
		self.rewardItem_ = CommonItemView.New(self.itemGo_, true)
	end

	local var_21_0 = clone(ItemTemplateData)

	var_21_0.animatorType = ItemConst.ITEM_ANIMATOR_TYPE.NULL
	var_21_0.id = ActivityLimitedDrawPoolCfg[arg_21_1].reward[1][1]
	var_21_0.number = ActivityLimitedDrawPoolCfg[arg_21_1].reward[1][2]

	function var_21_0.clickFun()
		ShowPopItem(POP_ITEM, {
			var_21_0.id
		})
	end

	self.rewardItem_:SetData(var_21_0)
	self.rewardItem_:Show(true)
end

function ActivityOathDrawItem:Dispose()
	self:DelOpenAniTimer()

	if self.rewardItem_ then
		self.rewardItem_:Dispose()

		self.rewardItem_ = nil
	end

	ActivityOathDrawItem.super.Dispose(self)
end

return ActivityOathDrawItem
