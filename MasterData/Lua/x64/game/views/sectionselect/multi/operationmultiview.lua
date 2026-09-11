local OperationMultiView = class("OperationMultiView", ReduxView)

function OperationMultiView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function OperationMultiView:Init()
	self:InitUI()
	self:AddUIListener()
end

function OperationMultiView:InitUI()
	self:BindCfgUI()

	self.firstMultiItem = OperationMultiItem.New(self.doubleoneGo_)
	self.secondMultiItem = OperationMultiItem.New(self.doubletwoGo_)
	self.showStateController_ = self.controller_:GetController("state")
	self.countController_ = self.controller_:GetController("count")
	self.onMultUpdate_ = handler(self, self.OnMultTimeUpdate)
end

function OperationMultiView:OnMultTimeUpdate()
	self:RefreshShow()
end

function OperationMultiView:AddUIListener()
	self:AddBtnListener(self.retractBtn_, nil, function()
		if self.showMultiCount >= 2 then
			self.showStateController_:SetSelectedState("expand")
		end
	end)
	self:AddBtnListener(self.expandBtn_, nil, function()
		self.showStateController_:SetSelectedState("retract")
	end)
end

function OperationMultiView:RefreshUI(arg_8_1, arg_8_2, arg_8_3)
	manager.notify:RegistListener(MULT_TIMES_UPDATE, self.onMultUpdate_)

	self.chapterID_ = arg_8_1
	self.curToggle_ = arg_8_2
	self.isStage = arg_8_3

	self.ani_:Play("UI_OperationDoubleUI", 0, 0)
	self.showStateController_:SetSelectedState("retract")
	self:RefreshShow()
end

function OperationMultiView:RefreshShow()
	self.showMultiCount = 0

	local var_9_0, var_9_1 = ActivityMultiRewardData:GetMultiRatioByChapterOrToggle(self.curToggle_, self.chapterID_)
	local var_9_2 = false

	if var_9_0 and var_9_0 > 0 then
		if ActivityMultiRewardData:GetCountByActivityID(var_9_1) > 0 then
			self:GetMultiItem():RefreshActMulti(var_9_0, var_9_1)

			self.showMultiCount = self.showMultiCount + 1
		else
			var_9_2 = true
		end
	end

	local var_9_3 = true

	if self.isStage then
		var_9_3 = not not (self.curToggle_ and (self.curToggle_ == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP or self.curToggle_ == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY))
	elseif self.curToggle_ and self.curToggle_ ~= BattleConst.TOGGLE.RESOURCE and self.curToggle_ ~= BattleConst.TOGGLE.EQUIP then
		var_9_3 = false
	end

	if RegressionDataNew:IsRegressionOpen() and var_9_3 and RegressionDataNew:GetMultipleValue() > 0 then
		local var_9_4 = self:GetMultiItem()

		if var_9_4 then
			var_9_4:RefreshRegressionMulti()

			self.showMultiCount = self.showMultiCount + 1
		end
	end

	if var_9_2 then
		local var_9_5 = self:GetMultiItem()

		if var_9_5 then
			var_9_5:RefreshActMulti(var_9_0, var_9_1)

			self.showMultiCount = self.showMultiCount + 1
		end
	end

	if self.showMultiCount == 0 then
		self.countController_:SetSelectedState("none")
	elseif self.showMultiCount == 1 then
		self.countController_:SetSelectedState("one")
	elseif self.showMultiCount == 2 then
		self.countController_:SetSelectedState("two")
	end
end

function OperationMultiView:OnExit()
	manager.notify:RemoveListener(MULT_TIMES_UPDATE, self.onMultUpdate_)

	if self.firstMultiItem then
		self.firstMultiItem:OnExit()
	end

	if self.secondMultiItem then
		self.secondMultiItem:OnExit()
	end
end

function OperationMultiView:GetMultiItem()
	if self.showMultiCount == 0 then
		return self.firstMultiItem
	else
		return self.secondMultiItem
	end
end

function OperationMultiView:Dispose()
	if self.firstMultiItem then
		self.firstMultiItem:Dispose()

		self.firstMultiItem = nil
	end

	if self.secondMultiItem then
		self.secondMultiItem:Dispose()

		self.secondMultiItem = nil
	end

	OperationMultiView.super.Dispose(self)
end

return OperationMultiView
