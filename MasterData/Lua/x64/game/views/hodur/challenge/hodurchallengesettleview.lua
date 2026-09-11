local HodurChallengeSettleView = class("HodurChallengeSettleView", ReduxView)

function HodurChallengeSettleView:UIName()
	return "Widget/System/Activity_Hodur/Activity_Hodur_Settle"
end

function HodurChallengeSettleView:UIParent()
	return manager.ui.uiMain.transform
end

function HodurChallengeSettleView:Init()
	self:InitUI()
	self:AddUIListener()

	self.affixController_ = self.mainControllerEx_:GetController("Mechanism")
	self.bossList_ = {}

	for iter_3_0 = 1, 4 do
		local var_3_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_3_0, self["bossItem_" .. iter_3_0])

		var_3_0.gameObject_ = self["affixItem_" .. iter_3_0]
		var_3_0.index = iter_3_0
		var_3_0.selectController_ = var_3_0.mainControllerEx_:GetController("select")
		var_3_0.lockController_ = var_3_0.mainControllerEx_:GetController("lock")
		var_3_0.numController_ = var_3_0.mainControllerEx_:GetController("num")

		var_3_0.selectController_:SetSelectedState("off")
		var_3_0.numController_:SetSelectedState("on")

		self.bossList_[iter_3_0] = var_3_0
	end

	self.heroItemList_ = {}

	for iter_3_1 = 1, 3 do
		self.heroItemList_[iter_3_1] = HodurChallengeHeroItem.New(self["heroGo_" .. iter_3_1])
	end

	self.itemList_ = {}
	self.rollingScore_ = self.rollingTextGo_:GetComponent("RollingNumberText")
end

function HodurChallengeSettleView:InitUI()
	self:BindCfgUI()
end

function HodurChallengeSettleView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		HodurSystemData:CacheAffixList((HodurTools.GetChallengeAffix()))
		JumpTools.OpenPageByJump("/hodurChallengeView", {
			chapter_id = 4,
			activity_id = ActivityConst.ACTIVITY_HODUR_MAIN
		})
	end)
end

function HodurChallengeSettleView:OnEnter()
	self.chapterID_ = self.params_.chapterID

	self:RefreshUI()
	self:ShowTips(false)
end

function HodurChallengeSettleView:OnTop()
	manager.windowBar:HideBar()
end

function HodurChallengeSettleView:OnBehind()
	manager.windowBar:HideBar()
end

function HodurChallengeSettleView:OnExit()
	HodurSystemData:ClearCacheChallengeData()
end

function HodurChallengeSettleView:RefreshUI()
	self:RefreshHero()
	self:RefreshAffixInfo()
	self:RefreshChapterState()
	self:RefreshBossItem()
end

function HodurChallengeSettleView:RefreshHero()
	self.heroList_ = HodurTools.GetChallengeHero()

	for iter_12_0, iter_12_1 in ipairs(self.heroItemList_) do
		local var_12_0
		local var_12_1

		if self.heroList_[iter_12_0] then
			var_12_0, var_12_1 = HodurTools.GetChallengeHeroHP(self.heroList_[iter_12_0])
		end

		iter_12_1:SetData(self.heroList_[iter_12_0], var_12_0, var_12_1)
	end
end

function HodurChallengeSettleView:RefreshAffixInfo()
	local var_13_0 = HodurTools.GetChallengeAffix()

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = self.itemList_[iter_13_0]

		if not self.itemList_[iter_13_0] then
			var_13_1 = HodurChallengeSelectAffixItem.New(Object.Instantiate(self.affixGo_, self.affixContentTrs_))
			self.itemList_[iter_13_0] = var_13_1
		end

		var_13_1:SetData(iter_13_1)
		var_13_1:SetActive(true)
		var_13_1:SetClickHandler(function(arg_14_0)
			self:OnClickAffixItem(arg_14_0, var_13_1)
		end)
	end

	for iter_13_2 = #var_13_0 + 1, #self.itemList_ do
		self.itemList_[iter_13_2]:SetActive(false)
	end

	local var_13_2 = HodurTools.GetChallengeAffix()
	local var_13_3 = #var_13_2

	if #var_13_2 == nil then
		var_13_3 = 0
	end

	local var_13_4 = 100

	for iter_13_3, iter_13_4 in ipairs(var_13_2) do
		if PublicBuffCfg[iter_13_4] then
			var_13_4 = var_13_4 + ActivityAffixPoolCfg[PublicBuffCfg[iter_13_4].buff_class_id].point
		end
	end

	self.efficiencyText_.text = string.format("%d%%", var_13_4)

	if var_13_3 == 0 then
		self.affixController_:SetSelectedState("off")
	else
		self.affixController_:SetSelectedState("on")
	end
end

function HodurChallengeSettleView:RefreshChapterState()
	self.rollingScore_:Change(0, (HodurTools.GetChallengeCurScore()))
end

function HodurChallengeSettleView:RefreshBossItem()
	for iter_16_0, iter_16_1 in ipairs(self.bossList_) do
		if HodurTools.GetChallengeStageFinish(iter_16_1.index) then
			iter_16_1.lockController_:SetSelectedState("unlock")

			iter_16_1.scoreText_.text = tostring((HodurTools.GetChallengeStageCurScore(iter_16_1.index)))

			iter_16_1.numController_:SetSelectedState("on")
		else
			iter_16_1.lockController_:SetSelectedState("lock")
			iter_16_1.numController_:SetSelectedState("off")
		end
	end
end

function HodurChallengeSettleView:OnClickAffixItem(arg_17_1, arg_17_2)
	if arg_17_2.selected_ then
		arg_17_2:SetSelected(false)
		self:ShowTips(false)

		self.selectAffix_ = nil
	else
		arg_17_2:SetSelected(true)
		self:ShowTips(true, arg_17_1)

		self.selectAffix_ = arg_17_1

		for iter_17_0, iter_17_1 in ipairs(self.itemList_) do
			if iter_17_1 ~= arg_17_2 and iter_17_1.selected_ then
				iter_17_1:SetSelected(false)
			end
		end
	end
end

function HodurChallengeSettleView:ShowTips(arg_18_1, arg_18_2)
	self.showTips_ = arg_18_1

	SetActive(self.tipsGo_, arg_18_1)

	if arg_18_1 then
		self.affixNameText_.text = AffixTypeCfg[arg_18_2].name
		self.affixDescText_.text = DescriptionCfg[AffixTypeCfg[arg_18_2].description[1]].description
	end
end

function HodurChallengeSettleView:Dispose()
	for iter_19_0, iter_19_1 in ipairs(self.itemList_) do
		iter_19_1:Dispose()
	end

	for iter_19_2, iter_19_3 in ipairs(self.heroItemList_) do
		iter_19_3:Dispose()
	end

	HodurChallengeSettleView.super.Dispose(self)
	self:RemoveAllListeners()
end

return HodurChallengeSettleView
