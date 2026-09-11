local BilliardBattleVehicleOverView = class("BilliardBattleVehicleOverView", ReduxView)

function BilliardBattleVehicleOverView:UIName()
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_BallxPit/Activity_WuLuo_BallxPit_ResultPopUI"
end

function BilliardBattleVehicleOverView:UIParent()
	return manager.ui.uiPop.transform
end

function BilliardBattleVehicleOverView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BilliardBattleVehicleOverView:InitUI()
	self:BindCfgUI()

	self.viewStatusController_ = self.transCon_:GetController("viewStatus")
	self.processController_ = self.transCon_:GetController("process")
	self.completeController_ = self.transCon_:GetController("complete")
	self.tipsController_ = self.transCon_:GetController("tips")
	self.tipsPosController_ = self.transCon_:GetController("tipsPos")
	self.skillLockController_ = self.skillCon_:GetController("lock")
	self.ballLockController_ = self.ballCon_:GetController("lock")
	self.processAnimList_ = {}

	for iter_4_0 = 1, 3 do
		table.insert(self.processAnimList_, self["processAnim_" .. iter_4_0])
	end
end

function BilliardBattleVehicleOverView:AddUIListener()
	self:AddBtnListener(self.confirmBtn_1, nil, function()
		OnExitVehiclBilliardBattle(self.victory_)
	end)
	self:AddBtnListener(self.confirmBtn_2, nil, function()
		OnExitVehiclBilliardBattle(self.victory_)
	end)
	self:AddBtnListener(self.exitBtn_, nil, function()
		OnExitVehiclBilliardBattle(self.victory_)
	end)
	self:AddBtnListener(self.restartBtn_, nil, function()
		manager.ui:SetCanvasAlpha(0)
		BilliardGameMgr:Restart()
	end)
	self:AddBtnListener(self.skillBtn_, nil, function()
		self.descText_.text = self.skillCfg_.desc

		self.tipsController_:SetSelectedState("show")
		self.tipsPosController_:SetSelectedState("skill")
	end)
	self:AddBtnListener(self.ballBtn_, nil, function()
		self.descText_.text = self.ballCfg_.desc

		self.tipsController_:SetSelectedState("show")
		self.tipsPosController_:SetSelectedState("vehicle")
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self.tipsController_:SetSelectedState("hide")
	end)
end

function BilliardBattleVehicleOverView:OnEnter()
	self.stageId_ = self.params_.stageId
	self.victory_ = self.params_.victory
	self.passedStageList_ = self.params_.passedStageList

	self:RefreshView()
	self:ShowEnterAnim()
end

function BilliardBattleVehicleOverView:RefreshView()
	if self.victory_ then
		local var_14_0 = MergeBallStageCfg[self.stageId_]

		if MergeBallStageCfg[self.stageId_] and var_14_0.ult_progress ~= 0 then
			local var_14_1 = var_14_0.unlock_skill == 0

			self.skillLockController_:SetSelectedState(tostring(var_14_0.unlock_skill == 0))

			if not var_14_1 then
				self.skillCfg_ = MergeBallVehicleCfg[var_14_0.unlock_skill]

				if self.skillCfg_ then
					self.skillIcon_.sprite = pureGetSpriteWithoutAtlas(self.skillCfg_.icon)
				end
			end

			local var_14_2 = var_14_0.unlock_vehicle == 0

			self.ballLockController_:SetSelectedState(tostring(var_14_0.unlock_vehicle == 0))

			if not var_14_2 then
				self.ballCfg_ = MergeBallVehicleCfg[var_14_0.unlock_vehicle]

				if self.ballCfg_ then
					self.ballIcon_.sprite = pureGetSpriteWithoutAtlas(self.ballCfg_.icon)
				end
			end

			if table.indexof(self.passedStageList_, self.stageId_) then
				self.viewStatusController_:SetSelectedState("success")
			else
				self.viewStatusController_:SetSelectedState("firstPass")
			end
		else
			self.viewStatusController_:SetSelectedState("success")
		end
	else
		self.viewStatusController_:SetSelectedState("failure")
	end
end

function BilliardBattleVehicleOverView:ShowEnterAnim()
	local var_15_0 = MergeBallStageCfg[self.stageId_].ult_progress

	self.processController_:SetSelectedState(MergeBallStageCfg[self.stageId_].ult_progress)

	self.processAnimTimer_ = Timer.New(function()
		self:ShowProcessAnim(var_15_0)
	end, 0.8, 1)

	self.processAnimTimer_:Start()
end

function BilliardBattleVehicleOverView:ShowProcessAnim(arg_17_1)
	for iter_17_0 = 1, arg_17_1 do
		if iter_17_0 ~= arg_17_1 then
			self.processAnimList_[iter_17_0]:Play("normal")
		elseif arg_17_1 == BilliardGameConst.StageCount - 1 then
			AnimatorTools.PlayAnimationWithCallback(self.processAnimList_[iter_17_0], "process_unlock", function()
				self.completeController_:SetSelectedState("true")
				self.completeAnim_:Play("base_Complete")
			end)
		else
			self.processAnimList_[iter_17_0]:Play("process_unlock")
		end
	end
end

function BilliardBattleVehicleOverView:OnTop()
	manager.windowBar:SwitchBar({})
end

function BilliardBattleVehicleOverView:OnExit()
	AnimatorTools.Stop()

	if self.processAnimTimer_ then
		self.processAnimTimer_:Stop()

		self.processAnimTimer_ = nil
	end
end

function BilliardBattleVehicleOverView:Dispose()
	BilliardBattleVehicleOverView.super.Dispose(self)
end

return BilliardBattleVehicleOverView
