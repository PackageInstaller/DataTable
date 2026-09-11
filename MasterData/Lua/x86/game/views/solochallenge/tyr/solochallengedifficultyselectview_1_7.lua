local SoloChallengeDifficultySelectView_1_7 = class("SoloChallengeDifficultySelectView_1_7", (import("game.views.soloChallenge.SoloChallengeDifficultySelectView")))

function SoloChallengeDifficultySelectView_1_7:UIName()
	return "UI/VersionUI/DarkFlameUI/DFSoloChallengeUI/DFSoloChallengeDifficultyUI"
end

function SoloChallengeDifficultySelectView_1_7:Init()
	SoloChallengeDifficultySelectView_1_7.super.Init(self)

	self.selectController_ = ControllerUtil.GetController(self.transform_, "selectDifficulty")
end

function SoloChallengeDifficultySelectView_1_7:OnSelectItem(arg_3_1)
	self.difficultyIndex_ = arg_3_1

	SoloChallengeData:SetSelectedDifficultyIndex(self.activityID_, self.difficultyIndex_)
	self.selectController_:SetSelectedState(tostring(self.difficultyIndex_))
end

function SoloChallengeDifficultySelectView_1_7:RefreshUI()
	for iter_4_0, iter_4_1 in ipairs(self.difficultyItemList_) do
		iter_4_1:SetData(self.activityID_, iter_4_0)
	end

	self.selectController_:SetSelectedState(tostring(self.difficultyIndex_))
end

function SoloChallengeDifficultySelectView_1_7:OnStart()
	SoloChallengeData:SetSelectedDifficultyIndex(self.activityID_, self.difficultyIndex_)
	self:Go("/soloChallengeSelectView_1_7", {
		activityID = self.activityID_,
		difficultyIndex = self.difficultyIndex_
	})
end

return SoloChallengeDifficultySelectView_1_7
