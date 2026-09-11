local WaterPipeStageItem = class("WaterPipeStageItem", ReduxView)

function WaterPipeStageItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.stageID = arg_1_2
	self.stageCfg = ActivityWaterPipeStageCfg[arg_1_2]

	self:InitUI()
end

function WaterPipeStageItem:InitUI()
	self:BindCfgUI()

	self.stateController = self.controllerexcollection_:GetController("state")
	self.pipePolaroid = WaterPipePolaroid.New(self.polaroidGo_)

	self:AddBtnListener(self.pipestageitemBtn, nil, function()
		if ActivityData:GetActivityData(self.stageCfg.activity_id).stopTime < manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		if WaterPipeData:CheckStageIsUnLock(self.stageID) and not self.timer_ then
			JumpTools.OpenPageByJump("waterPipeLetterPopView", {
				isSettle = false,
				stageID = self.stageID
			})
		elseif not WaterPipeData:IsOpenPreStage(self.stageID) then
			ShowTips("ACTIVITY_WATER_PIPE_PRE_STAGE_LOCK")
		else
			ShowTips("ACTIVITY_WATER_PIPE_TIME_LOCK")
		end
	end)
end

function WaterPipeStageItem:RefreshUI()
	if not WaterPipeData:CheckStageIsUnLock(self.stageID) then
		self.stateController:SetSelectedState("lock")
	elseif WaterPipeData:GetStageInfoByStageID(self.stageID) then
		self:RefreshAniShow()
		self.stateController:SetSelectedState("complete")
	else
		self:RefreshAniShow()
		self.stateController:SetSelectedState("unlock")
	end

	self.pipePolaroid:RefreshUI(self.stageID)

	self.textlockText_.text = WaterPipeData:GetStageOpenTimeTxt(self.stageID)

	if not WaterPipeData:IsTimeOpenStage(self.stageID) then
		self:AddTimer()
	end
end

function WaterPipeStageItem:AddTimer()
	self:StopTimer()
	self:RefreshTimeShow()

	self.timer_ = Timer.New(function()
		self:RefreshTimeShow()
	end, 1, -1)

	self.timer_:Start()
end

function WaterPipeStageItem:RefreshTimeShow()
	self.textlockText_.text = WaterPipeData:GetStageOpenTimeTxt(self.stageID)

	if WaterPipeData:IsTimeOpenStage(self.stageID) then
		self:RefreshUI()
		self:StopTimer()
	else
		self.textlockText_.text = WaterPipeData:GetStageOpenTimeTxt(self.stageID)
	end
end

function WaterPipeStageItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function WaterPipeStageItem:RefreshAniShow()
	self.starAni_:Play("UI_fangkuai_loop", 0, 0)
	self.sugarAni_:Play("UI_sugar_cx", 0, 0)
end

function WaterPipeStageItem:ShowStageAni(arg_10_1)
	self.completeAni_.enabled = arg_10_1
	self.heroAni_.enabled = arg_10_1
end

function WaterPipeStageItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.ACTIVITY_WATER_PIPE_STAGE, self.stageID))
end

function WaterPipeStageItem:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.ACTIVITY_WATER_PIPE_STAGE, self.stageID))
end

function WaterPipeStageItem:Dispose()
	self:StopTimer()
	self.pipePolaroid:Dispose()
	WaterPipeStageItem.super.Dispose(self)
end

return WaterPipeStageItem
