local SoloChallengeBossInfoView = class("SoloChallengeBossInfoView", ReduxView)

function SoloChallengeBossInfoView:UIName()
	if ActivityTools.GetActivityTheme(self.params_.activityID) == ActivityConst.THEME.TYR then
		return "UI/VersionUI/DarkFlameUI/DFSoloChallengeUI/DFSoloChallengeBossInfoUI"
	else
		return "UI/MardukUI/SoloChallenge/MardukSoloChallengeBoss"
	end
end

function SoloChallengeBossInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function SoloChallengeBossInfoView:Init()
	self:InitUI()
	self:AddUIListener()

	self.itemList_ = {}
	self.skillList_ = {}
end

function SoloChallengeBossInfoView:InitUI()
	self:BindCfgUI()
end

function SoloChallengeBossInfoView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		JumpTools.Back()
	end)
end

function SoloChallengeBossInfoView:RefreshUI()
	self.nameText_.text = GetMonsterName({
		self.id_
	})
	self.raceText_.text = GetTips("RACE_TYPE_" .. MonsterCfg[self.id_].race)
	self.icon_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/MardukUI/boss/solo582x648/%s", self.id_))
	self.riskText_.text = NumberTools.IntToRomam(MonsterCfg[self.id_].type + 1)

	self:UpdateData()
	self:RefreshSkill()
end

function SoloChallengeBossInfoView:RefreshSkill()
	for iter_8_0 = 1, 6 do
		self:UpdateItem(iter_8_0, self.skillList_[iter_8_0])
	end

	for iter_8_1 = 1, 6 do
		if string.len(self.skillList_[iter_8_1].name) == 0 then
			self.itemList_[iter_8_1]:Hide()
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
end

function SoloChallengeBossInfoView:UpdateItem(arg_9_1, arg_9_2)
	self.itemList_[arg_9_1] = self.itemList_[arg_9_1] or SoloChallengeBossInfoItem.New((Object.Instantiate(self.itemGo_, self.contentTrs_)))

	self.itemList_[arg_9_1]:RefreshUI(arg_9_2)
end

function SoloChallengeBossInfoView:OnEnter()
	manager.windowBar:HideBar()

	self.id_ = self.params_.bossID

	self:RefreshUI()
end

function SoloChallengeBossInfoView:UpdateData()
	self.skillList_ = {}

	for iter_11_0 = 1, 6 do
		self.skillList_[iter_11_0] = {
			isLock = false,
			name = MonsterCfg[self.id_]["skill" .. iter_11_0],
			info = MonsterCfg[self.id_]["skill_desc" .. iter_11_0]
		}
	end
end

function SoloChallengeBossInfoView:Dispose()
	for iter_12_0, iter_12_1 in ipairs(self.itemList_) do
		iter_12_1:Dispose()
	end

	SoloChallengeBossInfoView.super.Dispose(self)
end

return SoloChallengeBossInfoView
