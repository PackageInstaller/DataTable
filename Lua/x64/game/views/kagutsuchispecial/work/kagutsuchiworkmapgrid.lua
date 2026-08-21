local var_0_0 = class("KagutsuchiWorkMapGrid", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()

	arg_1_0.playGrid = nil
	arg_1_0.playGridDataIndex = -1
	arg_1_0.createPlayGridGoHandler = arg_1_2
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.typeController = nil
	arg_2_0.clearController = nil
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.BindPlayGrid(arg_4_0, arg_4_1)
	local var_4_0 = KagutsuchiWorkData:GetPlayGridData(arg_4_1)
	local var_4_1 = arg_4_0.createPlayGridGoHandler(arg_4_0.transform_, var_4_0)
	local var_4_2 = {
		gameObject_ = var_4_1,
		transform_ = var_4_1.transform
	}

	ComponentBinder.GetInstance():BindCfgUI(var_4_2, var_4_2.gameObject_)

	arg_4_0.playGridDataIndex = arg_4_1
	arg_4_0.playGrid = var_4_2
	arg_4_0.typeController = ControllerUtil.GetController(var_4_2.transform_, "type")
	arg_4_0.clearController = ControllerUtil.GetController(var_4_2.transform_, "clear")
	arg_4_0.selectController = ControllerUtil.GetController(var_4_2.transform_, "select")

	arg_4_0:AddBtnListener(var_4_2.button_, nil, function()
		arg_4_0:OnClickPlayGrid()
	end)
	arg_4_0:RefreshUI()
end

function var_0_0.SetClickHandler(arg_6_0, arg_6_1)
	arg_6_0.clickHandler_ = arg_6_1
end

function var_0_0.OnClickPlayGrid(arg_7_0)
	if not arg_7_0.playGrid then
		return
	end

	local var_7_0 = arg_7_0.playGrid
	local var_7_1 = arg_7_0:GetPlayGridData()

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

	if arg_7_0.clickHandler_ then
		arg_7_0.clickHandler_(arg_7_0, var_7_3)
	end

	arg_7_0:SetSelected(true)
end

function var_0_0.GetPlayGridData(arg_8_0)
	return KagutsuchiWorkData:GetPlayGridData(arg_8_0.playGridDataIndex)
end

function var_0_0.GetPosition(arg_9_0)
	return arg_9_0.transform_.anchoredPosition
end

function var_0_0.SetSelected(arg_10_0, arg_10_1)
	if arg_10_1 then
		local var_10_0 = arg_10_0:GetPlayGridData()

		arg_10_0.selectController:SetSelectedState(var_10_0:IsEntrust() and "entrustslelct" or "battleselect")
	else
		arg_10_0.selectController:SetSelectedState("false")
	end
end

function var_0_0.RefreshUI(arg_11_0)
	if arg_11_0.playGrid then
		local var_11_0 = arg_11_0.playGrid
		local var_11_1 = arg_11_0:GetPlayGridData()

		if var_11_1:IsBoss() then
			arg_11_0.typeController:SetSelectedState("boss")
		elseif var_11_1:IsEntrust() then
			arg_11_0.typeController:SetSelectedState("entrust")
		elseif var_11_1:IsBattle() then
			arg_11_0.typeController:SetSelectedState("normal")
		end

		var_11_0.normalLevelText_.text = "Lv." .. var_11_1:GetLevel()
		var_11_0.bossLevelText_.text = "Lv." .. var_11_1:GetLevel()

		if var_11_1:IsCleared() then
			arg_11_0.clearController:SetSelectedState("cleared")
		else
			arg_11_0.clearController:SetSelectedState("unclear")
		end
	end
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
