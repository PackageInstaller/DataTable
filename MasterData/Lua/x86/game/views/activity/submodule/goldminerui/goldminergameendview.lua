local GoldMinerGameEndView = class("GoldMinerGameEndView", ReduxView)

function GoldMinerGameEndView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/V4_2_GodEaterUI_GoldenMiner_ResultUI"
end

function GoldMinerGameEndView:UIParent()
	return manager.ui.uiPop.transform
end

function GoldMinerGameEndView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GoldMinerGameEndView:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.controllerEx_:GetController("state")
	self.starController1_ = self.starControllerEx1_:GetController("complet")
	self.starController2_ = self.starControllerEx2_:GetController("complet")
	self.starController3_ = self.starControllerEx3_:GetController("complet")
end

function GoldMinerGameEndView:AddUIListener()
	self:AddBtnListener(self.resetBtn_, nil, function()
		JumpTools.OpenPageByJump("/goldMinerGameView", {
			subActivityID = self.stageID_,
			heroID = GodEaterData:GetCurHeroID()
		})
	end)
	self:AddBtnListener(self.continueBtn_, nil, function()
		JumpTools.OpenPageByJump("/goldMinerSelectLevelView", {
			activityID = ActivityConst.ACTIVITY_GOLDMINER
		})
	end)
end

function GoldMinerGameEndView:OnEnter()
	self.stageID_ = self.params_.stageID
	self.star_ = self.params_.star
	self.cfg_ = ActivityGodEaterGoldminerStageCfg[self.stageID_]

	for iter_8_0 = 1, 3 do
		self["text" .. iter_8_0 .. "_"].text = string.format(GetTips("GOLDMINER_STAGE_POINT_NEED"), self.cfg_.score[iter_8_0])

		if iter_8_0 <= self.star_ then
			self["starController" .. iter_8_0 .. "_"]:SetSelectedState("true")
		else
			self["starController" .. iter_8_0 .. "_"]:SetSelectedState("false")
		end
	end

	if self.star_ <= 0 then
		manager.audio:PlayEffect("minigame_activity_3_9", "minigame_activity_3_9_xinmo_lose", "")
		self.stateController_:SetSelectedState("lose")
	else
		manager.audio:PlayEffect("minigame_activity_3_9", "minigame_activity_3_9_xinmo_win", "")
		self.stateController_:SetSelectedState("win")
	end

	if self.params_.reward_list[1] then
		getReward(mergeReward(self.params_.reward_list))
	end
end

function GoldMinerGameEndView:Dispose()
	self.super.Dispose(self)
end

return GoldMinerGameEndView
