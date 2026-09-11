local SPHeroChallengeBattleStageBaseView = class("SPHeroChallengeBattleStageBaseView", ReduxView)

function SPHeroChallengeBattleStageBaseView:Ctor(arg_1_1, arg_1_2)
	self.activityID_ = arg_1_2
	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName()), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SPHeroChallengeBattleStageBaseView:GetUIName()
	return
end

function SPHeroChallengeBattleStageBaseView:Init()
	self:BindCfgUI()
end

function SPHeroChallengeBattleStageBaseView:Show(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function SPHeroChallengeBattleStageBaseView:Dispose()
	SPHeroChallengeBattleStageBaseView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return SPHeroChallengeBattleStageBaseView
