local var_0_0 = class("BlisterBattleResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_Bubble/BubbleresultPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.battleControl = arg_5_0.bubbleresultpopuiControllerexcollection_:GetController("battleStatede")
	arg_5_0.btnControl = arg_5_0.bubbleresultpopuiControllerexcollection_:GetController("btnState")
	arg_5_0.panelControllerexcollection_ = arg_5_0.panelControllerexcollection_:GetController("Tittle")
	arg_5_0.nodeList = {}
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.suminibtn02Btn_, nil, function()
		arg_6_0:OnCancel()
	end)
	arg_6_0:AddBtnListener(arg_6_0.suminibtn01Btn_, nil, function()
		arg_6_0:OnOk()
	end)
end

function var_0_0.ChangeBar(arg_9_0)
	return
end

function var_0_0.OnTop(arg_10_0)
	return
end

function var_0_0.OnOk(arg_11_0)
	if manager.ChessBoardManager and manager.ChessBoardManager:IsBattleBack() then
		local var_11_0 = arg_11_0.params_ and arg_11_0.params_.isWin
		local var_11_1 = arg_11_0.params_ and arg_11_0.params_.score or 0

		ChessBoardAction.GoBackFromSmallGame(var_11_0 and 0 or 1, var_11_1)
	else
		BlisterGameTool.ExitGame()
	end
end

function var_0_0.OnCancel(arg_12_0)
	BlisterGameTool.ReStartGame()
	arg_12_0:Back()
end

function var_0_0.OnNextStage(arg_13_0)
	BlisterGameTool.NextStage(arg_13_0.nextId_, arg_13_0.nextCfg_)
	arg_13_0:Back()
end

function var_0_0.Cacheable(arg_14_0)
	return false
end

function var_0_0.OnEnter(arg_15_0)
	var_0_0.super.OnEnter(arg_15_0)

	local var_15_0 = arg_15_0.params_ and arg_15_0.params_.id or 1
	local var_15_1 = arg_15_0.params_ and arg_15_0.params_.score or 0
	local var_15_2 = arg_15_0.params_ and arg_15_0.params_.star or 0
	local var_15_3 = ActivityBubbleCfg[var_15_0]
	local var_15_4 = arg_15_0.params_ and arg_15_0.params_.isWin
	local var_15_5 = nullable(arg_15_0.params_, "forceQuit") or false

	arg_15_0.battleControl:SetSelectedState(var_15_4 and "win" or "fail")

	if manager.ChessBoardManager and manager.ChessBoardManager:IsBattleBack() then
		arg_15_0.btnControl:SetSelectedState("chess")
	else
		arg_15_0.btnControl:SetSelectedState("normal")
	end

	local var_15_6 = false
	local var_15_7 = BlisterGameData:GetPassId()
	local var_15_8 = table.indexof(ActivityBubbleCfg.all, var_15_7)

	if var_15_5 then
		var_15_6 = false
	elseif var_15_8 then
		local var_15_9 = var_15_8 + 1

		arg_15_0.nextId_ = ActivityBubbleCfg.all[var_15_9]
		arg_15_0.nextCfg_ = ActivityBubbleCfg[arg_15_0.nextId_]
		var_15_6 = arg_15_0.nextId_ and arg_15_0.nextCfg_ ~= nil
	end

	if arg_15_0.suminibtn03Btn_ then
		SetActive(arg_15_0.suminibtn03Btn_.gameObject, var_15_4 and var_15_6)
	end

	arg_15_0.panelControllerexcollection_:SetSelectedState(var_15_4 and "win" or "lose")

	if var_15_3 then
		arg_15_0.textcheckpointText_.text = var_15_3.name
		arg_15_0.textpointsText_.text = var_15_1

		for iter_15_0 = 1, 3 do
			if not arg_15_0.nodeList[iter_15_0] then
				arg_15_0.nodeList[iter_15_0] = BlisterGoalItem.New(arg_15_0[string.format("nd0%sGo_", iter_15_0)])
			end

			isGet = iter_15_0 <= var_15_2 or false

			arg_15_0.nodeList[iter_15_0]:SetData(isGet, var_15_3.score_level[iter_15_0] or 0)
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_0.btncontentTrs_)
end

function var_0_0.OnExit(arg_16_0)
	var_0_0.super.OnExit(arg_16_0)
end

function var_0_0.Dispose(arg_17_0)
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
