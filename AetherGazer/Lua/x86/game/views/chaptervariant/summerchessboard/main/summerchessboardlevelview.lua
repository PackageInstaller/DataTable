local var_0_0 = class("SummerChessBoardLevelView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/Summer2024_chessSelectPopUI"
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

	arg_4_0.leftController_ = arg_4_0.leftControllerEx_:GetController("able")
	arg_4_0.rightController_ = arg_4_0.rightControllerEx_:GetController("able")
	arg_4_0.stateController_ = arg_4_0.ControllerEx_:GetController("showState")
	arg_4_0.tipsController_ = arg_4_0.tipsControllerexcollection_:GetController("state")
	arg_4_0.taskList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexTaskItem), arg_4_0.uiList_, SummerChessBoardLevelTaskItem)
end

function var_0_0.IndexTaskItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.taskDataList[arg_5_1])
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.leftBtn_, nil, function()
		if arg_6_0.curIndex_ <= 1 then
			return
		else
			arg_6_0.curIndex_ = arg_6_0.curIndex_ - 1

			arg_6_0:RefreshUI()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.rightBtn_, nil, function()
		if arg_6_0.curIndex_ >= #arg_6_0.levelCfgList_ then
			return
		else
			arg_6_0.curIndex_ = arg_6_0.curIndex_ + 1

			arg_6_0:RefreshUI()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.startBtn_, nil, function()
		local var_9_0 = ChessBoardData:GetCurrentPlayingChessBoardLevelID()

		if var_9_0 == 0 or var_9_0 == arg_6_0.levelCfgList_[arg_6_0.curIndex_] then
			arg_6_0.params_.selectLevelID = arg_6_0.levelCfgList_[arg_6_0.curIndex_]

			ChessBoardTools.EnterChessMap(arg_6_0.levelCfgList_[arg_6_0.curIndex_])
		else
			ChessBoardTools.ChessBoardMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("CHESSBOARD_ENTER_NEW_MAP"), GetI18NText(ChessBoardLevelCfg[var_9_0].name_level)),
				OkCallback = function()
					arg_6_0.params_.selectLevelID = arg_6_0.levelCfgList_[arg_6_0.curIndex_]

					ChessBoardTools.EnterChessMap(arg_6_0.levelCfgList_[arg_6_0.curIndex_])
				end
			})
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.fullscreenBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.activityID_ = arg_12_0.params_.activityID
	arg_12_0.activityName_.text = ActivityCfg[arg_12_0.activityID_].remark
	arg_12_0.levelCfgList_ = ChessBoardLevelCfg.get_id_list_by_activity[arg_12_0.activityID_]

	arg_12_0:DefaultSelect()
	arg_12_0:RefreshUI()
end

function var_0_0.DefaultSelect(arg_13_0)
	local var_13_0 = arg_13_0.params_.selectLevelID or 0

	if var_13_0 ~= 0 then
		local var_13_1 = table.indexof(arg_13_0.levelCfgList_, var_13_0)

		if var_13_1 then
			arg_13_0.curIndex_ = var_13_1

			return
		end
	end

	arg_13_0.curIndex_ = #arg_13_0.levelCfgList_

	local var_13_2 = false

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.levelCfgList_ or {}) do
		if iter_13_1 == ChessBoardData:GetCurrentPlayingChessBoardLevelID() then
			arg_13_0.curIndex_ = iter_13_0
			var_13_2 = true

			break
		end
	end

	if not var_13_2 then
		for iter_13_2, iter_13_3 in ipairs(arg_13_0.levelCfgList_ or {}) do
			if not arg_13_0:CheckIsFinishLevel(iter_13_3) then
				arg_13_0.curIndex_ = iter_13_2

				break
			end
		end
	end

	if arg_13_0.curIndex_ == nil then
		arg_13_0.curIndex_ = 1
	end
end

function var_0_0.OnTop(arg_14_0)
	JumpTools.RefreshGaussianBg()
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExitInput(arg_16_0)
	JumpTools.Back()

	return true
end

function var_0_0.RefreshUI(arg_17_0)
	local var_17_0 = arg_17_0.levelCfgList_[arg_17_0.curIndex_]
	local var_17_1 = ChessBoardLevelCfg[var_17_0]

	arg_17_0.levelName_.text = var_17_1.name_level
	arg_17_0.levelImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_ChessBoard/" .. var_17_1.background_level)

	if arg_17_0.curIndex_ <= 1 then
		arg_17_0.leftController_:SetSelectedState("false")
		arg_17_0.rightController_:SetSelectedState("true")
	elseif arg_17_0.curIndex_ >= #arg_17_0.levelCfgList_ then
		arg_17_0.leftController_:SetSelectedState("true")
		arg_17_0.rightController_:SetSelectedState("false")
	else
		arg_17_0.leftController_:SetSelectedState("true")
		arg_17_0.rightController_:SetSelectedState("true")
	end

	arg_17_0:RefreshTaskUI()
end

function var_0_0.RefreshTaskUI(arg_18_0)
	local var_18_0 = arg_18_0.levelCfgList_[arg_18_0.curIndex_]
	local var_18_1 = ChessBoardLevelCfg[var_18_0]
	local var_18_2 = SummerChessBoardTools.GetTaskIDByChessBoardID(arg_18_0.activityID_)

	arg_18_0.taskDataList = SummerChessBoardData:CallFun("GetTaskIDListInLevelID", arg_18_0.activityID_, var_18_2, var_18_0)

	arg_18_0.taskList_:StartScroll(#arg_18_0.taskDataList)

	local var_18_3 = var_18_1.unlock_condition
	local var_18_4 = HistoryData:GetHistoryData(tonumber(var_18_3))
	local var_18_5 = 0

	if var_18_1.eventpool_id > 0 and ChessBoardEventPoolCfg[var_18_1.eventpool_id] ~= nil then
		for iter_18_0, iter_18_1 in pairs(ChessBoardEventPoolCfg[var_18_1.eventpool_id].player_params) do
			if iter_18_1[1] == 10001 then
				var_18_5 = iter_18_1[2]
			end
		end
	end

	if var_18_5 > 0 then
		if PlayerData:GetStoryList()[var_18_5] == true then
			arg_18_0.stateController_:SetSelectedState("normal")

			if var_18_0 == ChessBoardData:GetCurrentPlayingChessBoardLevelID() then
				arg_18_0.tipsController_:SetSelectedState("playing")
			elseif arg_18_0:CheckIsFinishLevel(var_18_0) then
				arg_18_0.tipsController_:SetSelectedState("finish")
			else
				arg_18_0.tipsController_:SetSelectedState("empty")
			end
		elseif var_18_3 == 0 or var_18_4 then
			arg_18_0.stateController_:SetSelectedState("normal")

			if var_18_0 == ChessBoardData:GetCurrentPlayingChessBoardLevelID() then
				arg_18_0.tipsController_:SetSelectedState("playing")
			elseif arg_18_0:CheckIsFinishLevel(var_18_0) then
				arg_18_0.tipsController_:SetSelectedState("finish")
			else
				arg_18_0.tipsController_:SetSelectedState("empty")
			end
		else
			arg_18_0.stateController_:SetSelectedState("lock")
			arg_18_0.tipsController_:SetSelectedState("lock")

			arg_18_0.lockdescText_.text = ConditionCfg[tonumber(var_18_3)].desc

			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_0.unlockContentTrans_)
		end
	elseif var_18_3 == 0 or var_18_4 then
		arg_18_0.stateController_:SetSelectedState("normal")

		if var_18_0 == ChessBoardData:GetCurrentPlayingChessBoardLevelID() then
			arg_18_0.tipsController_:SetSelectedState("playing")
		elseif arg_18_0:CheckIsFinishLevel(var_18_0) then
			arg_18_0.tipsController_:SetSelectedState("finish")
		else
			arg_18_0.tipsController_:SetSelectedState("empty")
		end
	else
		arg_18_0.stateController_:SetSelectedState("lock")
		arg_18_0.tipsController_:SetSelectedState("lock")

		arg_18_0.lockdescText_.text = ConditionCfg[tonumber(var_18_3)].desc

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_0.unlockContentTrans_)
	end
end

function var_0_0.CheckIsFinishLevel(arg_19_0, arg_19_1)
	local var_19_0 = SummerChessBoardTools.GetTaskIDByChessBoardID(arg_19_0.activityID_)
	local var_19_1 = SummerChessBoardData:CallFun("GetTaskIDListInLevelID", arg_19_0.activityID_, var_19_0, arg_19_1)

	for iter_19_0, iter_19_1 in pairs(var_19_1) do
		local var_19_2 = AssignmentCfg[iter_19_1]
		local var_19_3 = TaskData2:GetTask(iter_19_1)

		if var_19_2.need > var_19_3.progress then
			return false
		end
	end

	return true
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.taskList_ then
		arg_20_0.taskList_:Dispose()

		arg_20_0.taskList_ = nil
	end

	arg_20_0.super.Dispose(arg_20_0)
end

return var_0_0
