local WaterPipeLetterPopView = class("WaterPipeLetterPopView", ReduxView)

function WaterPipeLetterPopView:UIName()
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipeUI/WaterPipeLetterPopUI"
end

function WaterPipeLetterPopView:UIParent()
	return manager.ui.uiPop.transform
end

function WaterPipeLetterPopView:Init()
	self:InitUI()

	self.pipePolaroid = WaterPipePolaroid.New(self.polaroidGo_)

	self:AddUIListener()
end

function WaterPipeLetterPopView:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.itemData = {
		clone(ItemTemplateData),
		clone(ItemTemplateData),
		clone(ItemTemplateData)
	}
	self.viewController_ = self.controller_:GetController("viewState")
	self.categoryController_ = self.controller_:GetController("showCategoryIcon")
end

function WaterPipeLetterPopView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/waterPipeGameStageView", {
			stageID = self.stageID
		})
	end)
	self:AddBtnListener(self.getBtn_, nil, function()
		self:OnGetBtn()
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()

		if self.params_.closeCallback then
			self.params_.closeCallback()
		end
	end)
end

function WaterPipeLetterPopView:OnGetBtn()
	local var_9_0 = WaterPipeData:GetStageInfoByStageID(self.stageID)

	if var_9_0 and var_9_0.letter_reward then
		return
	end

	WaterPipeAction:FinishWaterPipeLetter(self.stageID, WaterPipeData:GetMainActivityID(), function()
		self:RefreshUI()
	end)
end

function WaterPipeLetterPopView:OnEnter()
	self.stageID = self.params_.stageID
	self.stageCfg = ActivityWaterPipeStageCfg[self.stageID]

	self:RefreshUI()
	self:ShowAni()
end

function WaterPipeLetterPopView:ShowAni()
	self.lockAni1_.enabled = false
	self.lockAni2_.enabled = false

	if self.params_.isSettle or false then
		self.panelAni_:Play("UI_WaterPipePicturePopUI_cx", 0, 0)
	else
		self.panelAni_:Play("UI_WaterPipePicturePopUI_cx 0", 0, 0)
	end
end

function WaterPipeLetterPopView:AddAutoGetTimer()
	self:StopAutoGetTimer()

	self.autoGetTimer = Timer.New(function()
		if self.panelAni_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 0.8 then
			self:OnGetBtn()
			self:StopAutoGetTimer()
		end
	end, 0.1, -1)

	self.autoGetTimer:Start()
end

function WaterPipeLetterPopView:StopAutoGetTimer()
	if self.autoGetTimer then
		self.autoGetTimer:Stop()

		self.autoGetTimer = nil
	end
end

function WaterPipeLetterPopView:RefreshUI()
	local var_16_0 = WaterPipeData:GetStageInfoByStageID(self.stageID)

	if var_16_0 then
		if var_16_0.letter_reward then
			self.viewController_:SetSelectedState("receivedGet")
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_WATER_PIPE_STAGE, self.stageID), 1)
			self.viewController_:SetSelectedState("canGet")
		end
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_WATER_PIPE_STAGE, self.stageID), 0)
		self.viewController_:SetSelectedState("unFinish")
	end

	local var_16_1 = DropCfg[self.stageCfg.stage_reward] and DropCfg[self.stageCfg.stage_reward].base_drop

	for iter_16_0, iter_16_1 in ipairs(var_16_1 or {}) do
		local var_16_2 = rewardToItemTemplate(formatReward(iter_16_1), self.itemData[iter_16_0])

		if self.rewardItems_[iter_16_0] == nil then
			self.rewardItems_[iter_16_0] = CommonItemView.New(self[string.format("commonitemGo_%s", iter_16_0)])
		end

		function var_16_2:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end

		self.rewardItems_[iter_16_0]:SetData(var_16_2)
	end

	for iter_16_2 = #var_16_1 + 1, #self.rewardItems_ do
		if self.rewardItems_[iter_16_2] then
			self.rewardItems_[iter_16_2]:SetData(nil)
		end
	end

	self.pipePolaroid:RefreshUI(self.stageID)

	self.normalText_.text = self.stageCfg.date_desc
	self.finishText_.text = self.stageCfg.preheat_desc

	local var_16_3 = WaterPipeData:GetCategoryImg(self.stageID)

	if var_16_3 then
		self.categoryiconImg_.sprite = var_16_3

		self.categoryController_:SetSelectedState("show")
	else
		self.categoryController_:SetSelectedState("hide")
	end
end

function WaterPipeLetterPopView:OnTop()
	return
end

function WaterPipeLetterPopView:OnExit()
	self:StopAutoGetTimer()
end

function WaterPipeLetterPopView:Dispose()
	for iter_20_0, iter_20_1 in pairs(self.rewardItems_) do
		if iter_20_1 then
			iter_20_1:Dispose()
		end
	end

	self.pipePolaroid:Dispose()

	self.rewardItems_ = nil

	WaterPipeLetterPopView.super.Dispose(self)
end

return WaterPipeLetterPopView
