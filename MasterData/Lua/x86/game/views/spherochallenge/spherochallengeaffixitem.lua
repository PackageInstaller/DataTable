local SPHeroChallengeAffixItem = class("SPHeroChallengeAffixItem", ReduxView)

function SPHeroChallengeAffixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SPHeroChallengeAffixItem:Init()
	self:InitUI()
end

function SPHeroChallengeAffixItem:InitUI()
	self:BindCfgUI()

	self.stateController = self.controller:GetController("state")
	self.showTipsController = self.controller:GetController("showTips")

	self:AddUIListener()
end

function SPHeroChallengeAffixItem:AddUIListener()
	self:AddBtnListener(self.infoBtn_, nil, function()
		if self.clickCallback then
			self.clickCallback()
		end

		self:OpenCloseTimer()
	end)
end

function SPHeroChallengeAffixItem:SetClickListener(arg_6_1)
	self.clickCallback = arg_6_1
end

function SPHeroChallengeAffixItem:OpenCloseTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.showTipsController:SetSelectedState("show")
	self:RefreshDesc()

	self.timer = Timer.New(function()
		self:CloseAffix()
	end, 3, 1)

	self.timer:Start()
end

function SPHeroChallengeAffixItem:CloseAffix()
	self.showTipsController:SetSelectedState("close")

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function SPHeroChallengeAffixItem:RefreshUI(arg_10_1, arg_10_2)
	self.activityID = SPHeroChallengeData:GetActivityID()

	self.showTipsController:SetSelectedState("close")

	if ActivityHeroChallengeCfg[self.activityID] then
		self.affixID = ActivityHeroChallengeCfg[self.activityID]["affix_group_" .. SpHeroChallengeConst.trainIndex[arg_10_1]][arg_10_2][2]
		self.nameText.text = GetTips("TIP_CLEARTIMES") .. ActivityHeroChallengeCfg[self.activityID]["affix_group_" .. SpHeroChallengeConst.trainIndex[arg_10_1]][arg_10_2][1]
		self.skillText.text = ActivityAffixPoolCfg[ActivityHeroChallengeCfg[self.activityID]["affix_group_" .. SpHeroChallengeConst.trainIndex[arg_10_1]][arg_10_2][2]].name
		self.skillIcon.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. PublicBuffCfg[ActivityHeroChallengeCfg[self.activityID]["affix_group_" .. SpHeroChallengeConst.trainIndex[arg_10_1]][arg_10_2][2]].icon)

		if SPHeroChallengeData:GetCurActivityInfo():GetTrainNumByType(arg_10_1) < ActivityHeroChallengeCfg[self.activityID]["affix_group_" .. SpHeroChallengeConst.trainIndex[arg_10_1]][arg_10_2][1] then
			self.stateController:SetSelectedState("lock")
		else
			self.stateController:SetSelectedState("unlock")
		end
	end
end

function SPHeroChallengeAffixItem:RefreshDesc()
	self.name.text = ActivityAffixPoolCfg[self.affixID].name
	self.desc.text = GetCfgDescription(AffixTypeCfg[self.affixID].description[1])
end

function SPHeroChallengeAffixItem:Dispose()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.gameObject_ = nil
	self.transform_ = nil

	SPHeroChallengeAffixItem.super.Dispose(self)
end

return SPHeroChallengeAffixItem
