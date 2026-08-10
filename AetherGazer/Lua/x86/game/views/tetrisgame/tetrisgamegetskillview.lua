local var_0_0 = class("TetrisGameGetSkillView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_TetrisGameUI/TetrisGameexplainPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateController = arg_4_0.controller:GetController("state")
	arg_4_0.grayController = arg_4_0.panelController:GetController("btn_gray")
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.activityID = TetrisGameData:GetCurActivityID()

	arg_5_0:EnterSelect()
end

function var_0_0.EnterSelect(arg_6_0)
	arg_6_0.stageID = arg_6_0.params_.stageID
	arg_6_0.skillList = {}

	if arg_6_0.stageID and arg_6_0.stageID > 0 then
		if ActivityTetrisGameStageCfg[arg_6_0.stageID].type == TetrisGameConst.stageType.endLess then
			arg_6_0.skillList = TetrisGameData:GetEndlessSkillList()
		else
			arg_6_0.skillList = ActivityTetrisGameStageCfg[arg_6_0.stageID].skill_list
		end
	else
		arg_6_0.skillList = arg_6_0.params_.skillList
	end

	if #arg_6_0.skillList <= 1 then
		arg_6_0.stateController:SetSelectedState("single")
	else
		arg_6_0.stateController:SetSelectedState("full")
	end

	arg_6_0.index = 1

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.skillList or {}) do
		if arg_6_0.params_.skillID == iter_6_1 then
			arg_6_0.index = iter_6_0
		end
	end

	arg_6_0:RefreshView()
end

function var_0_0.OnTop(arg_7_0)
	return
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn, nil, function()
		arg_8_0:Back()

		if arg_8_0.params_.closeCallBack then
			arg_8_0.params_.closeCallBack()

			arg_8_0.params_.closeCallBack = nil
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.btnleftBtn_, nil, function()
		if arg_8_0.index > 1 then
			arg_8_0.index = arg_8_0.index - 1

			arg_8_0:RefreshView()
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.btnrightBtn_, nil, function()
		if arg_8_0.index < #arg_8_0.skillList then
			arg_8_0.index = arg_8_0.index + 1

			arg_8_0:RefreshView()
		end
	end)
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.RefreshView(arg_14_0)
	arg_14_0.index = arg_14_0.index or 1
	arg_14_0.skillID = arg_14_0.skillList[arg_14_0.index]

	local var_14_0 = ActivityTetrisGameSkillCfg[arg_14_0.skillID]

	if var_14_0 then
		arg_14_0.skillName.text = var_14_0.name
		arg_14_0.skillDesc.text = var_14_0.desc
		arg_14_0.skillImage.sprite = TetrisGameTools:GetSkillIcon(arg_14_0.skillID)
	end

	if arg_14_0.index == 1 then
		arg_14_0.grayController:SetSelectedState("left_gray")
	elseif arg_14_0.index == #arg_14_0.skillList then
		arg_14_0.grayController:SetSelectedState("right_gray")
	else
		arg_14_0.grayController:SetSelectedState("normal")
	end
end

return var_0_0
