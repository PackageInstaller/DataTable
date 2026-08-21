local var_0_0 = class("TetrisGameGetSkillViewNew", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_TetrisGameUI/TetrisGameeSkillDetailsPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.bgmaskBtn_, nil, function()
		arg_4_0:Back()

		if arg_4_0.params_.closeCallBack then
			arg_4_0.params_.closeCallBack()

			arg_4_0.params_.closeCallBack = nil
		end
	end)
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.skillScroll = LuaList.New(handler(arg_6_0, arg_6_0.IndexItem), arg_6_0.uiListGo_, TetrisGameSkillItem)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.inGame then
		arg_7_2:RefreshUIInGame(arg_7_0.skillList[arg_7_1])
	else
		arg_7_2:RefreshUIInCheckView(arg_7_0.skillList[arg_7_1])
	end
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID = TetrisGameData:GetCurActivityID()

	arg_8_0:EnterSelect()
end

function var_0_0.EnterSelect(arg_9_0)
	arg_9_0.inGame = arg_9_0.params_.inGame
	arg_9_0.stageID = arg_9_0.params_.stageID
	arg_9_0.skillList = {}

	if arg_9_0.stageID and arg_9_0.stageID > 0 then
		if ActivityTetrisGameStageCfg[arg_9_0.stageID].type == TetrisGameConst.stageType.endLess then
			arg_9_0.skillList = TetrisGameData:GetEndlessSkillList()
		else
			arg_9_0.skillList = ActivityTetrisGameStageCfg[arg_9_0.stageID].skill_list
		end
	else
		arg_9_0.skillList = arg_9_0.params_.skillList
	end

	arg_9_0.skillScroll:StartScroll(#arg_9_0.skillList)
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.skillScroll then
		arg_12_0.skillScroll:Dispose()

		arg_12_0.skillScroll = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
