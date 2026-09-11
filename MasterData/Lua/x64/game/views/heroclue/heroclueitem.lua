local HeroClueItem = class("HeroClueItem", ReduxView)

function HeroClueItem:OnCtor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.clueID_ = arg_1_2
	self.activityID_ = arg_1_3
	self.index_ = arg_1_4

	SetActive(self.gameObject_, true)
	self:Init()
end

function HeroClueItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroClueItem:InitUI()
	self:BindCfgUI()
	self:InitController()
end

function HeroClueItem:InitController()
	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
end

function HeroClueItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(self.activityID_) then
			return
		end

		if not self.curData_ then
			ShowTips("ACTIVITY_HERO_CLUE_NULL")

			return
		end

		if #HeroClueCfg[self.clueID_].level > self.curData_.level then
			ShowTips("ACTIVITY_HERO_CLUE_NOT_ENOUGH")

			return
		end

		HeroClueData:SetSelectedClue(self.activityID_, self.clueID_)
		HeroClueTools.GoToClueDetailView(self.activityID_, self.clueID_)
	end)
end

function HeroClueItem:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function HeroClueItem:RefreshUI()
	self.curData_ = HeroClueData:GetUnlockClueDataDic()[self.clueID_]

	if self.curData_ == nil then
		self.nameText_.text = GetTips("ACTIVITY_HERO_CLUE_NICK_TITLE")

		self.statusController_:SetSelectedState("lock")
	else
		local var_8_0 = HeroClueCfg[self.clueID_]

		self.clueIcon_.sprite = pureGetSpriteWithoutAtlas(HeroClueCfg[self.clueID_].icon_path)
		self.nameText_.text = self.curData_.level < 2 and GetTips("ACTIVITY_HERO_CLUE_NICK_TITLE") or var_8_0.name
		self.progressText_.text = string.format("%d/%d", self.curData_.level, #var_8_0.level)

		self.statusController_:SetSelectedIndex(self.curData_.level)
	end

	self.indexText_.text = self.index_ < 10 and "0" .. self.index_ or self.index_
end

function HeroClueItem:GetClueID()
	return self.clueID_
end

function HeroClueItem:GetPosition()
	return self.transform_:GetPosition()
end

return HeroClueItem
