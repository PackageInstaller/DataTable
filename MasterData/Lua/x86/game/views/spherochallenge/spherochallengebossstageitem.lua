local SPHeroChallengeBossStageItem = class("SPHeroChallengeBossStageItem", ReduxView)

function SPHeroChallengeBossStageItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SPHeroChallengeBossStageItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SPHeroChallengeBossStageItem:InitUI()
	self:BindCfgUI()

	self.stateController = self.controller:GetController("state")
end

function SPHeroChallengeBossStageItem:RefreshUI(arg_4_1, arg_4_2)
	self.stageID = arg_4_1

	self.stateController:SetSelectedState("unlock")

	if arg_4_2 == self.stageID then
		self.stateController:SetSelectedState("selected")
	end

	if BattleVerthandiExclusiveCfg[arg_4_1] then
		local var_4_0, var_4_1 = SPHeroChallengeTools:CheckStageIsOpen(arg_4_1)

		self.bossnameText_.text = BattleVerthandiExclusiveCfg[arg_4_1].name

		if var_4_0 then
			self.stateController:SetSelectedState("lock")

			self.conditiontextText_.text = var_4_1 or ""
		else
			local var_4_2 = SPHeroChallengeData:GetCurActivityInfo():GetBossScoreInfo(arg_4_1)

			self.recordText_.text = var_4_2 > 0 and string.format(GetTips("ACTIVITY_HERO_CHALLENGE_RECORD"), var_4_2) or GetTips("NO_RECORD")
		end
	end
end

function SPHeroChallengeBossStageItem:AddUIListener()
	self:AddBtnListener(self.bossitemBtn_, nil, function()
		if self.stateController:GetSelectedState() == "lock" then
			return
		end

		if self.clickFunc then
			self.clickFunc(self.stageID)
		end
	end)
end

function SPHeroChallengeBossStageItem:RegisterClickCallBack(arg_7_1)
	if arg_7_1 then
		self.clickFunc = arg_7_1
	end
end

function SPHeroChallengeBossStageItem:Dispose()
	self.gameObject_ = nil
	self.transform_ = nil

	SPHeroChallengeBossStageItem.super.Dispose(self)
end

return SPHeroChallengeBossStageItem
