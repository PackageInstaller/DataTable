local var_0_0 = class("TetrisGameSkillView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_TetrisGameUI/TetrisGamechapterUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.skillScroll = LuaList.New(handler(arg_4_0, arg_4_0.indexskillItem), arg_4_0.skillListGo_, TetrisGameSkillItem)
	arg_4_0.skillCountShowController = arg_4_0.controller_:GetController("skillCountShow")
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_6_0)
	if arg_6_0.params_.isORD then
		arg_6_0.isORD = arg_6_0.params_.isORD
		arg_6_0.params_.isORD = nil
	end

	arg_6_0.activityID = TetrisGameData:GetCurActivityID()

	TetrisGameAction:SaveNewSkill()
	arg_6_0:RefreshBar()
	arg_6_0:RefreshSkillList()
	arg_6_0:RefreshViewInfo()

	arg_6_0.texttittleText_.text = ActivityTetrisGameChapterCfg[1].name

	RankAction.QueryActivityRank(TetrisGameData:GetCurRankActivityID(), nil, function()
		arg_6_0:RefreshViewInfo()
	end)
	arg_6_0:BindRedPoint()
end

function var_0_0.BindRedPoint(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(ActivityTetrisGameChapterCfg.all) do
		if ActivityTetrisGameChapterCfg[iter_8_1].type == TetrisGameConst.stageType.normal then
			manager.redPoint:bindUIandKey(arg_8_0.goBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, iter_8_1))
		end
	end
end

function var_0_0.UnbindRedPoint(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(ActivityTetrisGameChapterCfg.all) do
		if ActivityTetrisGameChapterCfg[iter_9_1].type == TetrisGameConst.stageType.normal then
			manager.redPoint:unbindUIandKey(arg_9_0.goBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, iter_9_1))
		end
	end
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0:RefreshBar()
end

function var_0_0.RefreshBar(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	local var_11_0 = GameSetting.tetris_game_describe1 and GameSetting.tetris_game_describe1.value or {}

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_11_0
		})
	end)
	manager.windowBar:RegistBackCallBack(function()
		if arg_11_0.isORD then
			JumpTools.OpenPageByJump("/tetrisGameMainView")
		else
			arg_11_0:Back()
		end
	end)
end

function var_0_0.OnExit(arg_14_0)
	TetrisGameAction:UpdataNewSkill()
	manager.windowBar:HideBar()
	arg_14_0:RemoveAllEventListener()
	arg_14_0:UnbindRedPoint()
end

function var_0_0.GetCanUseSkillCount(arg_15_0)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.skillList) do
		if TetrisGameTools:CheckSkillIsUnlock(iter_15_1) then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

function var_0_0.CheckIsNumLimit(arg_16_0)
	local var_16_0 = true
	local var_16_1 = arg_16_0:GetCanUseSkillCount()
	local var_16_2 = #TetrisGameData:GetSkillList()
	local var_16_3 = GameSetting.tetris_game_skill_max.value[1]

	if var_16_3 <= var_16_1 and var_16_2 < var_16_3 then
		ShowTips("TETRIS_GAME_SKILL_NUM_TIPS")

		var_16_0 = false
	end

	return var_16_0
end

function var_0_0.AddUIListener(arg_17_0)
	arg_17_0:AddBtnListener(arg_17_0.startBtn_, nil, function()
		if not arg_17_0:CheckIsNumLimit() then
			return
		end

		local var_18_0 = TetrisGameTools:GetEndLessStageIDByActivityID(arg_17_0.activityID)

		if var_18_0 then
			TetrisGameTools:EnterStage(var_18_0)
		end
	end)
	arg_17_0:AddBtnListener(arg_17_0.btnrankBtn_, nil, function()
		JumpTools.OpenPageByJump("/tetrisGameRankView", {
			rankActivityID = TetrisGameData:GetCurRankActivityID()
		})
	end)
	arg_17_0:AddBtnListener(arg_17_0.goBtn_, nil, function()
		local var_20_0 = TetrisGameData:GetStageInfoList()

		for iter_20_0, iter_20_1 in pairs(var_20_0) do
			local var_20_1 = TetrisGameTools:GetStageState(iter_20_0)

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_STAGE, iter_20_0), 0)
		end

		local var_20_2 = ActivityTetrisGameChapterCfg.get_id_list_by_activityID[arg_17_0.activityID][1] + 2
		local var_20_3 = ActivityTetrisGameChapterCfg[var_20_2].chapterID

		JumpTools.OpenPageByJump("/tetrisGameChooseStageView", {
			isORD = true,
			chapterID = var_20_3
		})
	end)
end

function var_0_0.RegisterEvents(arg_21_0)
	return
end

function var_0_0.OnSkillUpdate(arg_22_0)
	arg_22_0.skillScroll:Refresh()
	arg_22_0:RefreshViewInfo()
end

function var_0_0.Dispose(arg_23_0)
	if arg_23_0.skillScroll then
		arg_23_0.skillScroll:Dispose()

		arg_23_0.skillScroll = nil
	end

	var_0_0.super.Dispose(arg_23_0)
end

function var_0_0.GetTargetMoveIndex(arg_24_0)
	local var_24_0 = -1

	for iter_24_0 = 1, #arg_24_0.skillList do
		local var_24_1 = arg_24_0.skillList[iter_24_0]

		if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_NEW_SKILL, var_24_1)) then
			var_24_0 = iter_24_0

			break
		end
	end

	if var_24_0 < 0 then
		for iter_24_1 = 1, #arg_24_0.skillList do
			local var_24_2 = arg_24_0.skillList[iter_24_1]

			if TetrisGameTools:CheckSkillInList(var_24_2) then
				var_24_0 = iter_24_1

				break
			end
		end
	end

	return var_24_0
end

function var_0_0.RefreshSkillList(arg_25_0)
	local var_25_0 = TetrisGameTools:GetEndLessStageIDByActivityID(arg_25_0.activityID)

	arg_25_0.skillList = ActivityTetrisGameStageCfg[var_25_0].skill_list

	local var_25_1 = arg_25_0:GetTargetMoveIndex()

	if var_25_1 > 0 then
		arg_25_0.skillScroll:StartScroll(#arg_25_0.skillList, var_25_1)
	else
		arg_25_0.skillScroll:StartScroll(#arg_25_0.skillList)
	end

	local var_25_2 = TetrisGameConst.ultimateID
	local var_25_3 = ActivityTetrisGameSkillCfg[var_25_2]

	if var_25_2 and var_25_3 then
		arg_25_0.ultimateNameTxt_.text = var_25_3.name
		arg_25_0.ultimateDescTxt_.text = var_25_3.desc
		arg_25_0.ultimateIcon_.sprite = TetrisGameTools:GetSkillIcon(var_25_2)
	end
end

function var_0_0.indexskillItem(arg_26_0, arg_26_1, arg_26_2)
	arg_26_2:RefreshUI(arg_26_0.skillList[arg_26_1])
end

function var_0_0.RefreshViewInfo(arg_27_0)
	local var_27_0 = arg_27_0:GetCanUseSkillCount()

	if var_27_0 > 0 then
		arg_27_0.skillCountShowController:SetSelectedState("show")
	else
		arg_27_0.skillCountShowController:SetSelectedState("hide")
	end

	local var_27_1 = GameSetting.tetris_game_skill_max.value[1]
	local var_27_2 = math.min(var_27_1, var_27_0)
	local var_27_3 = #TetrisGameData:GetSkillList()

	arg_27_0.skillNum.text = string.format("%s/%s", tostring(var_27_3 or 0), var_27_2)

	local var_27_4 = RankData:GetActivityRank(TetrisGameData:GetCurRankActivityID())
	local var_27_5
	local var_27_6

	if var_27_4 then
		local var_27_7

		var_27_7, var_27_6 = var_27_4:GetCurRankDes()
	else
		var_27_6 = GetTips("MATRIX_RANK_NO_INFO")
	end

	arg_27_0.rankScore.text = var_27_6
end

return var_0_0
