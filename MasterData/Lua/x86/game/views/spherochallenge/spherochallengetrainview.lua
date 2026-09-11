local SPHeroChallengeTrainView = class("SPHeroChallengeTrainView", import(".SPHeroChallengeBattleStageBaseView"))

function SPHeroChallengeTrainView:UIName()
	return "Widget/System/SPHeroChallenge/SPHeroChallengeTrainUI"
end

function SPHeroChallengeTrainView:UIParent()
	return manager.ui.uiMain.transform
end

function SPHeroChallengeTrainView:OnCtor()
	return
end

function SPHeroChallengeTrainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SPHeroChallengeTrainView:InitUI()
	self:BindCfgUI()

	self.lockController = self.controller:GetController("open")
	self.challengeTimeController_ = self.controller:GetController("times")
end

function SPHeroChallengeTrainView:OnEnter()
	self:RefreshBar()

	if not self.params_.showFlag then
		self.lockController:SetSelectedState("no")

		if self.params_.reason then
			self.lockdescText_.text = GetTips(self.params_.reason)
		end
	else
		self.lockController:SetSelectedState("open")
	end

	self:RefreshPlayTime()
	self:RegistEventListener(SP_HERO_CHALLENGE_UPDATE_CHALLENGE, function()
		self:RefreshPlayTime()
	end)
end

function SPHeroChallengeTrainView:RefreshPlayTime()
	self.totalNum, self.curNum = SPHeroChallengeData:GetCurActivityInfo():GetChallengeTimes()
	self.challengeTime.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_REMAIN_TIME"), self.totalNum - self.curNum <= 0 and string.format("<color='#FF000B'>%d</color>", tostring(self.totalNum - self.curNum)) or tostring(self.totalNum - self.curNum), tonumber(1))
end

function SPHeroChallengeTrainView:RefreshBar()
	return
end

function SPHeroChallengeTrainView:OnExit()
	self:RemoveAllEventListener()
end

function SPHeroChallengeTrainView:AddUIListener()
	for iter_11_0 = SpHeroChallengeConst.BattleSubType.train1, SpHeroChallengeConst.BattleSubType.train3 do
		self:AddBtnListener(self["trainitem" .. iter_11_0 .. "Btn_"], nil, function()
			JumpTools.OpenPageByJump("/spHeroChallengeTrainStageView", {
				playAnimation = true,
				trainType = iter_11_0
			})
		end)
	end

	self:AddBtnListener(self.timeInfoBtn, nil, function()
		if self.challengeTimeController_:GetSelectedState() == "show" then
			self.challengeTimeController_:SetSelectedState("showTip")

			self.infoTipText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_BATTLE_TIME_DESC")
		else
			self.challengeTimeController_:SetSelectedState("show")
		end
	end)
end

function SPHeroChallengeTrainView:Dispose()
	SPHeroChallengeTrainView.super.Dispose(self)
end

return SPHeroChallengeTrainView
