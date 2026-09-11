local HeroTransitionDetailInfoView = class("HeroTransitionDetailInfoView", ReduxView)

function HeroTransitionDetailInfoView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

HeroTransitionDetailInfoView.asciiMap = {
	"Ⅰ",
	"Ⅱ",
	"Ⅲ",
	"Ⅳ",
	"Ⅴ",
	"Ⅵ"
}

function HeroTransitionDetailInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroTransitionDetailInfoView:InitUI()
	self:BindCfgUI()

	self.jumpNumController_ = self.barController_:GetController("num")
	self.jumpPosController_ = self.posController_:GetController("pos")
	self.lockController_ = self.contentController_:GetController("lock")
	self.emptyController_ = self.contentController_:GetController("empty")
	self.isSelfController_ = self.contentController_:GetController("isSelf")
	self.transitionItemList_ = {}
end

function HeroTransitionDetailInfoView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/transitionSkill", {
			index = self.info_.slotIdx,
			heroID = self.heroID_,
			type_ = self.heroViewProxy_:GetViewDataType()
		})
	end)
end

function HeroTransitionDetailInfoView:SetSlotInfo(arg_6_1)
	self.info_ = arg_6_1

	self:UpdateView()
end

function HeroTransitionDetailInfoView:SetHeroInfo(arg_7_1)
	self.heroInfo_ = arg_7_1
	self.heroID_ = arg_7_1.id
end

function HeroTransitionDetailInfoView:UpdateView()
	if not self.info_ then
		return
	end

	self.jumpPosController_:SetSelectedState(self.info_.slotIdx)
	self.lockController_:SetSelectedState(self.info_.isLock and "true" or "false")
	self.emptyController_:SetSelectedState(#self.info_.skills == 0 and "true" or "false")
	self.isSelfController_:SetSelectedState(self.heroViewProxy_.isSelf and "true" or "false")
	SetActive(self.lockRootObj_, self.heroViewProxy_.isSelf)

	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(self.info_.skills) do
		var_8_0 = var_8_0 + iter_8_1.level
	end

	self.jumpNumController_:SetSelectedState(var_8_0)

	self.numText_.text = table.concat({
		var_8_0,
		"/",
		self.info_.totalPoint
	})
	self.nameText_.text = string.format(GetTips("EXCLUSIVE_CORE"), self.asciiMap[self.info_.slotIdx])

	for iter_8_2, iter_8_3 in ipairs(self.transitionItemList_) do
		SetActive(iter_8_3.gameObject_, false)
	end

	local var_8_1 = 1

	for iter_8_4, iter_8_5 in ipairs(self.info_.skills) do
		if not self.transitionItemList_[var_8_1] then
			local var_8_2 = HeroTransitionItem.New((Object.Instantiate(self.jumpItemGo_, self.jumpItemListTrs_, false)))

			var_8_2:SetData(iter_8_5)
			table.insert(self.transitionItemList_, var_8_2)
		else
			self.transitionItemList_[var_8_1]:SetData(iter_8_5)
		end

		SetActive(self.transitionItemList_[var_8_1].gameObject_, true)

		var_8_1 = var_8_1 + 1
	end
end

function HeroTransitionDetailInfoView:OnEnter(arg_9_1)
	self.heroViewProxy_ = arg_9_1

	self:RegistEventListener(HERO_TRANSITION_CHANGE, handler(self, self.OnHeroModify))
end

function HeroTransitionDetailInfoView:OnExit()
	self:RemoveAllEventListener()
end

function HeroTransitionDetailInfoView:OnHeroModify(arg_11_1)
	if arg_11_1 == self.heroInfo_.id then
		self:UpdateView()
	end
end

function HeroTransitionDetailInfoView:Dispose()
	self:RemoveAllListeners()

	for iter_12_0, iter_12_1 in ipairs(self.transitionItemList_) do
		if iter_12_1 then
			iter_12_1:Dispose()
		end
	end

	HeroTransitionDetailInfoView.super.Dispose(self)
end

return HeroTransitionDetailInfoView
