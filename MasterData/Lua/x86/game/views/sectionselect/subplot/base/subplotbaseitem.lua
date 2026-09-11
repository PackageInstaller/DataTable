local SubPlotBaseItem = class("SubPlotBaseItem", ReduxView)

function SubPlotBaseItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.clearController_ = ControllerUtil.GetController(self.transform_, "clear")
	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
end

function SubPlotBaseItem:SetData(arg_2_1, arg_2_2)
	self.stageID_ = arg_2_1
	self.chapterID_ = arg_2_2

	local var_2_0 = BattleStageData:GetStageData()[arg_2_1]

	self.isClear_ = not not (var_2_0 and var_2_0.clear_times > 0)

	self:RefreshUI()
end

function SubPlotBaseItem:Dispose()
	SubPlotBaseItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function SubPlotBaseItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		self:OnClick()
	end)
end

function SubPlotBaseItem:OnClick()
	BattleFieldData:SetCacheStage(self.chapterID_, self.stageID_)
	self:Go("subPlotSectionInfo", {
		section = self.stageID_,
		chapterID = self.chapterID_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
	})
end

function SubPlotBaseItem:IsOpenSectionInfo()
	return self:IsOpenRoute("subPlotSectionInfo")
end

function SubPlotBaseItem:RefreshUI()
	local var_8_0 = self:GetPosition()

	self.transform_.localPosition = Vector3(var_8_0[1], var_8_0[2], 0)

	self:Show(true)
	self:RefreshCustomUI()
	self:RefreshClear()
end

function SubPlotBaseItem:RefreshCustomUI()
	return
end

function SubPlotBaseItem:SelectorItem(arg_10_1)
	if self.stageID_ == arg_10_1 and self:IsOpenSectionInfo() then
		self.selectController_:SetSelectedState("on")
	else
		self.selectController_:SetSelectedState("off")
	end
end

function SubPlotBaseItem:RefreshClear()
	if self.isClear_ then
		self.clearController_:SetSelectedState("on")
	else
		self.clearController_:SetSelectedState("off")
	end
end

function SubPlotBaseItem:GetPosition()
	return (BattleActivityStoryStageCfg[self.stageID_] or nil) and (BattleActivityStoryStageCfg[self.stageID_].position or {
		0,
		0
	})
end

function SubPlotBaseItem:GetLocalPosition()
	return self.transform_.localPosition
end

function SubPlotBaseItem:Show(arg_14_1)
	SetActive(self.gameObject_, arg_14_1)
end

return SubPlotBaseItem
