local CoreVerificationChallengeTeamInfoItemMode4 = class("CoreVerificationChallengeTeamInfoItemMode4", BaseView)

function CoreVerificationChallengeTeamInfoItemMode4:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CoreVerificationChallengeTeamInfoItemMode4:Init()
	self:BindCfgUI()

	self.challengeHeadItems = {}

	for iter_2_0 = 1, 3 do
		self.challengeHeadItems[iter_2_0] = CoreVerificationChallengeHeroHeadItem.New(self["heroRightGo_" .. iter_2_0], iter_2_0)
	end
end

function CoreVerificationChallengeTeamInfoItemMode4:Dispose()
	for iter_3_0, iter_3_1 in pairs(self.challengeHeadItems) do
		iter_3_1:Dispose()
	end

	self.challengeHeadItems = nil

	CoreVerificationChallengeTeamInfoItemMode4.super.Dispose(self)
end

function CoreVerificationChallengeTeamInfoItemMode4:SetData(arg_4_1)
	self.scoreText_.text = arg_4_1.score
	self.pushTimeText_.text = manager.time:DescCdTime2(arg_4_1.time, "00:00+")

	for iter_4_0, iter_4_1 in ipairs(self.challengeHeadItems) do
		iter_4_1:RefreshUI(nullable(arg_4_1, "heroList", iter_4_0, "hero_id") or 0)
	end
end

return CoreVerificationChallengeTeamInfoItemMode4
