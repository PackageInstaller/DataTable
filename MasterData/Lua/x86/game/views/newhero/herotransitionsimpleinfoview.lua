local HeroTransitionSimpleInfoView = class("HeroTransitionSimpleInfoView", ReduxView)

function HeroTransitionSimpleInfoView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroTransitionSimpleInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroTransitionSimpleInfoView:InitUI()
	self:BindCfgUI()

	self.emptyController_ = self.controller_:GetController("empty")
	self.transitionItemList_ = {}
end

function HeroTransitionSimpleInfoView:AddUIListener()
	return
end

function HeroTransitionSimpleInfoView:SetHeroInfo(arg_5_1)
	self.heroInfo_ = arg_5_1
	self.heroID_ = arg_5_1.id
end

function HeroTransitionSimpleInfoView:UpdateView()
	self.transitionList_ = self:RebuildTransitionSkills()

	self.emptyController_:SetSelectedState(#self.transitionList_ == 0 and "true" or "false")

	for iter_6_0, iter_6_1 in ipairs(self.transitionItemList_) do
		SetActive(iter_6_1.gameObject_, false)
	end

	local var_6_0 = 1

	for iter_6_2, iter_6_3 in ipairs(self.transitionList_) do
		if not self.transitionItemList_[var_6_0] then
			local var_6_1 = HeroTransitionItem.New((Object.Instantiate(self.jumpItemGo_, self.jumpItemListTrs_, false)))

			var_6_1:SetData(iter_6_3)
			table.insert(self.transitionItemList_, var_6_1)
		else
			self.transitionItemList_[var_6_0]:SetData(iter_6_3)
		end

		SetActive(self.transitionItemList_[var_6_0].gameObject_, true)

		var_6_0 = var_6_0 + 1
	end
end

function HeroTransitionSimpleInfoView:OnEnter(arg_7_1)
	self.heroViewProxy_ = arg_7_1

	self:RegistEventListener(HERO_TRANSITION_CHANGE, handler(self, self.OnHeroModify))
end

function HeroTransitionSimpleInfoView:OnExit()
	self:RemoveAllEventListener()
end

function HeroTransitionSimpleInfoView:OnHeroModify(arg_9_1)
	if arg_9_1 == self.heroID_ then
		self.heroInfo_ = self.heroViewProxy_:GetHeroData(self.heroID_)

		self:UpdateView()
	end
end

function HeroTransitionSimpleInfoView:Dispose()
	self:RemoveAllListeners()

	for iter_10_0, iter_10_1 in ipairs(self.transitionItemList_) do
		if iter_10_1 then
			iter_10_1:Dispose()
		end
	end

	HeroTransitionSimpleInfoView.super.Dispose(self)
end

function HeroTransitionSimpleInfoView:RebuildTransitionSkills()
	local var_11_0 = HeroTools.GetHeroEquipTransitionAddLevel((self.heroViewProxy_:GetHeroData(self.heroID_)))
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs((self.heroViewProxy_:GetHeroTransitionInfoList(self.heroID_))) do
		if not self:GetSlotLockStatus(iter_11_1.slot_id) then
			for iter_11_2, iter_11_3 in ipairs(iter_11_1.skill_list) do
				var_11_1[iter_11_3.skill_id] = (var_11_1[iter_11_3.skill_id] or 0) + iter_11_3.skill_level
			end
		end
	end

	local var_11_3 = {}

	for iter_11_4, iter_11_5 in pairs(var_11_1) do
		table.insert(var_11_3, {
			skillId = iter_11_4,
			level = iter_11_5 + var_11_0
		})
	end

	table.sort(var_11_3, function(arg_12_0, arg_12_1)
		if arg_12_0.skillId == arg_12_1.skillId then
			return false
		end

		return arg_12_0.skillId < arg_12_1.skillId
	end)

	return var_11_3
end

function HeroTransitionSimpleInfoView:GetSlotLockStatus(arg_13_1)
	local var_13_0 = self.heroViewProxy_:GetEquipDataList(self.heroID_)

	return ((var_13_0[arg_13_1] and var_13_0[arg_13_1].prefab_id and var_13_0[arg_13_1].prefab_id ~= 0 or nil) and var_13_0[arg_13_1]:GetLevel()) < GameSetting.exclusive_open_need.value[1]
end

return HeroTransitionSimpleInfoView
