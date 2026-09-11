local CoreVerificationChallengeSelectHeroAdditionalView = class("CoreVerificationChallengeSelectHeroAdditionalView", SectionStageInfoView)

function CoreVerificationChallengeSelectHeroAdditionalView:Init()
	CoreVerificationChallengeSelectHeroAdditionalView.super.Init(self)

	self.recommonHeroItemList_ = {}

	for iter_1_0 = 1, self.recommonHeroItemContent_.childCount do
		table.insert(self.recommonHeroItemList_, (CoreVerificationChallengeHeroHeadItem.New(self.recommonHeroItemContent_:GetChild(iter_1_0 - 1).gameObject, iter_1_0)))
	end
end

function CoreVerificationChallengeSelectHeroAdditionalView:Refresh()
	CoreVerificationChallengeSelectHeroAdditionalView.super.Refresh(self)

	self.recommonTeam_ = CoreVerificationChallengeTools.GetModeCfg()[self.sectionProxy_.stageID].recommend_team

	for iter_2_0 = 1, 3 do
		local var_2_0 = self[string.format("recommonHeroIcon_%d", iter_2_0)]

		if self.recommonTeam_[iter_2_0] and self.recommonTeam_[iter_2_0] ~= 0 then
			self.recommonHeroItemList_[iter_2_0]:SetActive(true)
			self.recommonHeroItemList_[iter_2_0]:RefreshUI(self.recommonTeam_[iter_2_0])
		else
			self.recommonHeroItemList_[iter_2_0]:SetActive(false)
		end
	end
end

function CoreVerificationChallengeSelectHeroAdditionalView:Dispose()
	for iter_3_0, iter_3_1 in ipairs(self.recommonHeroItemList_) do
		iter_3_1:Dispose()
	end

	CoreVerificationChallengeSelectHeroAdditionalView.super.Dispose(self)
end

return CoreVerificationChallengeSelectHeroAdditionalView
