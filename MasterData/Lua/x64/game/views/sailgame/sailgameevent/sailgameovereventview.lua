local SailGameOverEventView = class("SailGameOverEventView", (import("game.views.sailGame.sailGameEvent.SailGameEventBaseView")))

function SailGameOverEventView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyageTreasureChestUI"
end

function SailGameOverEventView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.rewardItemList_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, CommonItem)
end

function SailGameOverEventView:AddUIListener()
	self:AddBtnListener(self.openBoxBtn_, nil, function()
		if not self.isOpend_ then
			self.isOpend_ = true

			SailGameAction.EventOperate(self.activityID_, self.stageIndex_)
		end
	end)
	self:AddBtnListener(self.overBtn_, nil, function()
		self:RefreshSettlement()
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		SailGameTools.ShutDown()
		JumpTools.OpenPageByJump("/sailMain", {
			activityID = self.activityID_
		})
	end)
end

function SailGameOverEventView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.stageIndex_ = SailGameData:GetCurGameData(self.activityID_).curStageIndex
	self.isOpend_ = false

	self:RefreshUI()
	manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_pop2", "")
end

function SailGameOverEventView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	SailGameOverEventView.super.OnExit(self)
end

function SailGameOverEventView:Dispose()
	self.rewardItemList_:Dispose()

	self.rewardItemList_ = nil

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	SailGameOverEventView.super.Dispose(self)
end

function SailGameOverEventView:RefreshUI()
	self.statusController_:SetSelectedState("start")
	self:RefreshReward()
end

function SailGameOverEventView:RefreshReward()
	self.rewardCfgList_ = {}
	self.rewardCfgList_[1] = GameSetting.activity_skadi_sea_be_out_end_reward.value

	self.rewardItemList_:StartScroll(#self.rewardCfgList_)
end

function SailGameOverEventView:OnEventOperateSuccess()
	self:PlayBoxAnim(0, function()
		self.statusController_:SetSelectedState("end")
	end)
end

function SailGameOverEventView:RefreshSettlement()
	self.rewardCfgList_ = {}

	for iter_14_0, iter_14_1 in pairs(SailGameData:GetTempSettlementData(self.activityID_).getDic) do
		self.rewardCfgList_[#self.rewardCfgList_ + 1] = {
			iter_14_0,
			iter_14_1
		}
	end

	self.rewardItemList_:StartScroll(#self.rewardCfgList_)
	self.statusController_:SetSelectedState("settlement")
end

function SailGameOverEventView:IndexItem(arg_15_1, arg_15_2)
	arg_15_2:RefreshData(formatReward(self.rewardCfgList_[arg_15_1]))
	arg_15_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, self.rewardCfgList_[arg_15_1])
	end)
	arg_15_2.starController_:SetSelectedState(0)
end

function SailGameOverEventView:PlayBoxAnim(arg_17_1, arg_17_2)
	local var_17_0 = "XH3rdVoyageTreasureChestUI_icon"

	self.animator_:Play("XH3rdVoyageTreasureChestUI_icon", -1, arg_17_1)
	self.animator_:Update(0)

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.timer_ = Timer.New(function()
		local var_18_0 = self.animator_:GetCurrentAnimatorStateInfo(0)

		if var_18_0:IsName(var_17_0) and var_18_0.normalizedTime >= 1 then
			if self.timer_ ~= nil then
				self.timer_:Stop()

				self.timer_ = nil
			end

			if arg_17_2 then
				arg_17_2()
			end
		end
	end, 0.033, -1)

	self.timer_:Start()
	manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_award", "")
end

return SailGameOverEventView
