local DormIlluHeroDetailInfoView = class("DormIlluHeroDetailInfoView", ReduxView)

function DormIlluHeroDetailInfoView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormIlluHeroDetailInfoView:OnEnter(arg_2_1, arg_2_2)
	self:UpdateView(arg_2_1)

	self.callBackFunc_ = arg_2_2

	self:ChangeContent(1)
end

function DormIlluHeroDetailInfoView:OnExit()
	self.heroID_ = 0
end

function DormIlluHeroDetailInfoView:Dispose()
	if self.actionScroll_ then
		self.actionScroll_:Dispose()
	end

	for iter_4_0, iter_4_1 in pairs(self.skillItemList_) do
		iter_4_1:Dispose()
	end

	for iter_4_2, iter_4_3 in pairs(self.canteenSkillItemList_) do
		iter_4_3:Dispose()
	end

	DormIlluHeroDetailInfoView.super.Dispose(self)
end

function DormIlluHeroDetailInfoView:InitUI()
	self:BindCfgUI()
	self:BindController()
	self:AddUIListener()

	self.skillItemList_ = {}

	for iter_5_0 = 1, 3 do
		self.skillItemList_[iter_5_0] = TrainInfoSkillItem.New(self["skill" .. iter_5_0 .. "Go_"])
	end

	self.canteenSkillItemList_ = {}
	self.actionScroll_ = LuaList.New(handler(self, self.HeroActionItem), self.actionList_, IlluHeroActionItem)
	self.heroID_ = 0
	self.contentIndex_ = 0
end

function DormIlluHeroDetailInfoView:BindController()
	self.contentController_ = self.mainControllerEx_:GetController("content")
	self.lockController_ = self.mainControllerEx_:GetController("lock")
	self.isIdolController_ = self.mainControllerEx_:GetController("isIdol")
end

function DormIlluHeroDetailInfoView:AddUIListener()
	self:AddBtnListener(self.actionBtn_, nil, function()
		self:ChangeContent(1)
	end)
	self:AddBtnListener(self.skillBtn_, nil, function()
		self.callBackFunc_(-1)
		self:SetPlay(-1)
		self:ChangeContent(2)
	end)
end

function DormIlluHeroDetailInfoView:HeroActionItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, BackHomeHeroCfg[self.heroID_].illu_interaction[arg_10_1], function(arg_11_0)
		self.callBackFunc_(arg_11_0)
		self:SetPlay(arg_10_1)
	end)
end

function DormIlluHeroDetailInfoView:SetPlay(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs((self.actionScroll_:GetItemList())) do
		if iter_12_0 == arg_12_1 then
			iter_12_1:SetPlay(true)
		else
			iter_12_1:SetPlay(false)
		end
	end
end

function DormIlluHeroDetailInfoView:ChangeContent(arg_13_1)
	if arg_13_1 == self.contentIndex_ then
		return
	end

	self.contentIndex_ = arg_13_1

	if arg_13_1 == 1 then
		self:UpdateActionView()
	elseif arg_13_1 == 2 then
		self:UpdateCanteenView()
		self:UpdateSkillView()
	end

	self:ForceUpdate()
	self.contentController_:SetSelectedIndex(self.contentIndex_ - 1)
	self:ForceUpdate()
	self:ForceUpdate()
end

function DormIlluHeroDetailInfoView:UpdateView(arg_14_1, arg_14_2)
	if self.heroID_ == arg_14_1 then
		return
	end

	self.heroID_ = arg_14_1
	self.nameText_.text = GetI18NText(HeroCfg[self.heroID_].name)
	self.suffixText_.text = HeroTools.GetHeroName(self.heroID_)
	self.attacktypeImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(HeroCfg[self.heroID_].id)
	self.groupImg_.sprite = HeroTools.GetRaceIcon(HeroCfg[self.heroID_].race)

	self.lockController_:SetSelectedState(HeroTools.GetHeroIsUnlock(self.heroID_) and "unlock" or "lock")
	self:UpdateActionView()
	self:UpdateCanteenView()
	self:UpdateSkillView()
	self:SetPlay(-1)
	self:ForceUpdate()
	self:ForceUpdate()
end

function DormIlluHeroDetailInfoView:UpdateActionView()
	self.actionList_ = {}
	self.actionList_ = BackHomeHeroCfg[self.heroID_].illu_interaction

	self.actionScroll_:StartScroll(#self.actionList_)
end

function DormIlluHeroDetailInfoView:UpdateCanteenView()
	self.canteenSkillIDList_ = BackHomeHeroCfg[self.heroID_].skill_list

	local var_16_0 = 1

	for iter_16_0, iter_16_1 in pairs(self.canteenSkillIDList_) do
		self.canteenSkillItemList_[var_16_0] = self.canteenSkillItemList_[var_16_0] or CanteenSkillItem.New((Object.Instantiate(self.canteenSkillItemGo_, self.canteenContent_)))

		SetActive(self.canteenSkillItemList_[var_16_0].gameObject_, true)
		self.canteenSkillItemList_[var_16_0]:RefreshUI(self.canteenSkillIDList_[var_16_0], nil, var_16_0)

		var_16_0 = var_16_0 + 1
	end

	for iter_16_2, iter_16_3 in pairs(self.canteenSkillItemList_) do
		if var_16_0 <= iter_16_2 then
			SetActive(self.canteenSkillItemList_[var_16_0].gameObject_, false)
		end
	end
end

function DormIlluHeroDetailInfoView:UpdateSkillView()
	if BackHomeHeroCfg[self.heroID_].idol_usable == 0 then
		for iter_17_0 = 1, 3 do
			if self.skillItemList_[iter_17_0] then
				SetActive(self.skillItemList_[iter_17_0].gameObject_, false)
			end
		end

		self.isIdolController_:SetSelectedIndex(1)

		return
	end

	self.isIdolController_:SetSelectedIndex(0)

	local var_17_0 = IdolTraineeTools:GetHeroBattleInfoTemplate(self.heroID_)

	for iter_17_1 = 1, #var_17_0.skill do
		local var_17_1 = 0

		for iter_17_2, iter_17_3 in ipairs(var_17_0.propertyData) do
			var_17_1 = var_17_1 + iter_17_3
		end

		self.skillItemList_[iter_17_1]:SetData(var_17_0.skill[iter_17_1], var_17_1)
		SetActive(self.skillItemList_[iter_17_1].gameObject_, true)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.skillItemList_[iter_17_1].transform_)
	end

	for iter_17_4 = #var_17_0.skill + 1, #self.skillItemList_ do
		SetActive(self.skillItemList_[iter_17_4].gameObject_, false)
	end
end

function DormIlluHeroDetailInfoView:ForceUpdate()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.canteenContent_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.danceContent_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.skillRootTrs_)
end

return DormIlluHeroDetailInfoView
