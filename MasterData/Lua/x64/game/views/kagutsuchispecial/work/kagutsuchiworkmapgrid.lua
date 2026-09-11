local KagutsuchiWorkMapGrid = class("KagutsuchiWorkMapGrid", ReduxView)

function KagutsuchiWorkMapGrid:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()

	self.playGrid = nil
	self.playGridDataIndex = -1
	self.createPlayGridGoHandler = arg_1_2
end

function KagutsuchiWorkMapGrid:InitUI()
	self:BindCfgUI()

	self.typeController = nil
	self.clearController = nil
end

function KagutsuchiWorkMapGrid:AddUIListener()
	return
end

function KagutsuchiWorkMapGrid:BindPlayGrid(arg_4_1)
	local var_4_0 = self.createPlayGridGoHandler(self.transform_, (KagutsuchiWorkData:GetPlayGridData(arg_4_1)))
	local var_4_1 = {
		gameObject_ = var_4_0,
		transform_ = var_4_0.transform
	}

	ComponentBinder.GetInstance():BindCfgUI(var_4_1, var_4_1.gameObject_)

	self.playGridDataIndex = arg_4_1
	self.playGrid = var_4_1
	self.typeController = ControllerUtil.GetController(var_4_1.transform_, "type")
	self.clearController = ControllerUtil.GetController(var_4_1.transform_, "clear")
	self.selectController = ControllerUtil.GetController(var_4_1.transform_, "select")

	self:AddBtnListener(var_4_1.button_, nil, function()
		self:OnClickPlayGrid()
	end)
	self:RefreshUI()
end

function KagutsuchiWorkMapGrid:SetClickHandler(arg_6_1)
	self.clickHandler_ = arg_6_1
end

function KagutsuchiWorkMapGrid:OnClickPlayGrid()
	if not self.playGrid then
		return
	end

	local var_7_1 = self:GetPlayGridData()

	if var_7_1:IsCleared() and var_7_1:IsEntrust() then
		-- block empty
	end

	local var_7_2 = var_7_1:GetReward()
	local var_7_3 = {
		activityId = ActivityConst.KAGUTSUCHI_ACTIVITY,
		reward = var_7_2,
		gridId = var_7_1:GetId()
	}

	if var_7_1:IsBattle() then
		var_7_3.isBattle = true
		var_7_3.isEntrust = false
		var_7_3.stageId = var_7_1:GetBattleStageId()
		var_7_3.activityId = ActivityConst.KAGUTSUCHI_ACTIVITY
		var_7_3.battleName = var_7_1:GetName()
		var_7_3.battleSummary = var_7_1:GetSummary()
		var_7_3.battleLevel = var_7_1:GetLevel()
		var_7_3.battleCost = var_7_1:GetCost()
		var_7_3.battleReward = var_7_2
	end

	if var_7_1:IsEntrust() then
		var_7_3.isBattle = false
		var_7_3.isEntrust = true
		var_7_3.entrustName = var_7_1:GetName()
		var_7_3.entrustSummary = var_7_1:GetSummary()
		var_7_3.entrustCompleteText = var_7_1:GetCompleteText()
		var_7_3.entrustReward = var_7_2
	end

	if self.clickHandler_ then
		self:clickHandler_(var_7_3)
	end

	self:SetSelected(true)
end

function KagutsuchiWorkMapGrid:GetPlayGridData()
	return KagutsuchiWorkData:GetPlayGridData(self.playGridDataIndex)
end

function KagutsuchiWorkMapGrid:GetPosition()
	return self.transform_.anchoredPosition
end

function KagutsuchiWorkMapGrid:SetSelected(arg_10_1)
	if arg_10_1 then
		self.selectController:SetSelectedState(self:GetPlayGridData():IsEntrust() and "entrustslelct" or "battleselect")
	else
		self.selectController:SetSelectedState("false")
	end
end

function KagutsuchiWorkMapGrid:RefreshUI()
	if self.playGrid then
		local var_11_0 = self.playGrid
		local var_11_1 = self:GetPlayGridData()

		if var_11_1:IsBoss() then
			self.typeController:SetSelectedState("boss")
		elseif var_11_1:IsEntrust() then
			self.typeController:SetSelectedState("entrust")
		elseif var_11_1:IsBattle() then
			self.typeController:SetSelectedState("normal")
		end

		var_11_0.normalLevelText_.text = "Lv." .. var_11_1:GetLevel()
		var_11_0.bossLevelText_.text = "Lv." .. var_11_1:GetLevel()

		if var_11_1:IsCleared() then
			self.clearController:SetSelectedState("cleared")
		else
			self.clearController:SetSelectedState("unclear")
		end
	end
end

function KagutsuchiWorkMapGrid:Dispose()
	KagutsuchiWorkMapGrid.super.Dispose(self)
end

return KagutsuchiWorkMapGrid
