local ChallengeRogueTeamWindowBarMgr = class("ChallengeRogueTeamWindowBarMgr", ReduxView)

function ChallengeRogueTeamWindowBarMgr:UIName()
	return "Widget/System/Activity_Roulike/RogueTeamWindowBarUI"
end

function ChallengeRogueTeamWindowBarMgr:UIParent()
	return manager.ui.uiPop.transform
end

function ChallengeRogueTeamWindowBarMgr:Init()
	self.gameObject_ = GameObject.Instantiate(Asset.Load(self:UIName()), manager.ui.uiPop.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.itemList_ = {}
	self.onUpdateBarHandler_ = handler(self, self.OnUpdateBar)
	self.createFlag_ = true
end

function ChallengeRogueTeamWindowBarMgr:SwitchBar(arg_4_1)
	if not self.createFlag_ then
		self:Init()
	end

	self:Show(true)

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if self.itemList_[iter_4_0] == nil then
			self.itemList_[iter_4_0] = ChallengeRogueTeamWindowBarItem.New(self.currencyItem_, self.currencyList_)
		end

		self.itemList_[iter_4_0]:SetData(iter_4_1)
	end

	for iter_4_2 = #arg_4_1 + 1, #self.itemList_ do
		self.itemList_[iter_4_2]:Show(false)
	end

	self.transform_:SetAsLastSibling()
end

function ChallengeRogueTeamWindowBarMgr:PlayAnimator(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self.itemList_) do
		iter_5_1:PlayAnimator(arg_5_1)
	end
end

function ChallengeRogueTeamWindowBarMgr:Show(arg_6_1)
	if arg_6_1 ~= true then
		for iter_6_0, iter_6_1 in ipairs(self.itemList_) do
			iter_6_1:Show(false)
		end
	end

	SetActive(self.gameObject_, arg_6_1)
end

function ChallengeRogueTeamWindowBarMgr:HideBar()
	self:Show(false)
end

function ChallengeRogueTeamWindowBarMgr:OnUpdateBar()
	for iter_8_0, iter_8_1 in ipairs(self.itemList_) do
		iter_8_1:RefreshUI()
	end
end

function ChallengeRogueTeamWindowBarMgr:Dispose()
	ChallengeRogueTeamWindowBarMgr.super.Dispose(self)

	if self.createFlag_ then
		self.onUpdateBarHandler_ = nil

		for iter_9_0, iter_9_1 in ipairs(self.itemList_) do
			iter_9_1:Dispose()
		end

		self.itemList_ = nil

		ChallengeRogueTeamWindowBarMgr.super.Dispose(self)
		Object.Destroy(self.gameObject_)

		self.transform_ = nil
		self.gameObject_ = nil
		self.createFlag_ = false
	end
end

return ChallengeRogueTeamWindowBarMgr
