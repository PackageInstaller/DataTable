local var_0_0 = class("TetrisGameMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_TetrisGameUI/TetrisGameMainUI"
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
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.lockController = arg_5_0.chapterController:GetController("lock")
	arg_5_0.endlessLockController = arg_5_0.endlessController_:GetController("lock")
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.activityID = TetrisGameData:GetCurActivityID()

	manager.redPoint:bindUIandKey(arg_6_0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, TetrisGameData:GetCurTaskActivityID()))
	manager.redPoint:bindUIandKey(arg_6_0.specialBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, TetrisGameTools:GetEndLessStageIDByActivityID(TetrisGameData:GetCurActivityID())))
	arg_6_0:RefreshBar()
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0:RefreshBar()
	arg_7_0:RefreshChapterState()
end

function var_0_0.RefreshBar(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	local var_8_0 = GameSetting.tetris_game_describe1 and GameSetting.tetris_game_describe1.value or {}

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_8_0
		})
	end)
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_10_0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, TetrisGameData:GetCurTaskActivityID()))
	manager.redPoint:unbindUIandKey(arg_10_0.specialBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, TetrisGameTools:GetEndLessStageIDByActivityID(TetrisGameData:GetCurActivityID())))
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.AddUIListener(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.rankBtn_, nil, function()
		if arg_11_0.activityID then
			JumpTools.OpenPageByJump("/tetrisGameRankView", {
				rankActivityID = TetrisGameData:GetCurRankActivityID()
			})
		end
	end)
	arg_11_0:AddBtnListener(arg_11_0.taskBtn_, nil, function()
		if arg_11_0.activityID then
			local var_13_0 = TetrisGameData:GetCurTaskActivityID()

			JumpTools.OpenPageByJump("tetrisGameTaskView", {
				activityID = var_13_0
			})
		end
	end)
	arg_11_0:AddBtnListener(arg_11_0.specialBtn_, nil, function()
		local var_14_0 = TetrisGameTools:GetEndLessStageIDByActivityID(arg_11_0.activityID)
		local var_14_1, var_14_2 = TetrisGameTools:CheckChapterIsOpen(var_14_0)

		if not var_14_1 then
			ShowTips(GetI18NText(var_14_2))

			return
		end

		JumpTools.OpenPageByJump("/tetrisGameSkillView", {
			isORD = false
		})
	end)
	arg_11_0:AddBtnListener(arg_11_0.chapter1Btn_, nil, function()
		local var_15_0 = TetrisGameTools:GetSimpleChapterIDListByActivityID(arg_11_0.activityID)[1]
		local var_15_1, var_15_2 = TetrisGameTools:CheckChapterIsOpen(var_15_0)

		if not var_15_1 then
			ShowTips(GetI18NText(var_15_2))

			return
		end

		JumpTools.OpenPageByJump("/tetrisGameChooseStageView", {
			chapterID = var_15_0
		})
	end)
	arg_11_0:AddBtnListener(arg_11_0.chapter2Btn_, nil, function()
		local var_16_0 = TetrisGameTools:GetSimpleChapterIDListByActivityID(arg_11_0.activityID)[2]
		local var_16_1, var_16_2 = TetrisGameTools:CheckChapterIsOpen(var_16_0)

		if not var_16_1 then
			ShowTips(GetI18NText(var_16_2))

			return
		end

		JumpTools.OpenPageByJump("/tetrisGameChooseStageView", {
			chapterID = var_16_0
		})
	end)
end

function var_0_0.Dispose(arg_17_0)
	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.RefreshChapterState(arg_18_0)
	if arg_18_0.activityID then
		local var_18_0 = TetrisGameData:GetSpecialStageInfo()

		if var_18_0 then
			local var_18_1 = var_18_0.topScore

			if var_18_1 > 0 then
				arg_18_0.specialScore.text = var_18_1
			else
				arg_18_0.specialScore.text = GetTips("NO_RECORD")
			end
		end

		local var_18_2 = TetrisGameTools:GetSimpleChapterIDListByActivityID(arg_18_0.activityID)
		local var_18_3 = TetrisGameTools:GetEndLessStageIDByActivityID(arg_18_0.activityID)

		if #var_18_2 > 0 then
			arg_18_0.chapter1Name_.text = ActivityTetrisGameChapterCfg[var_18_2[1]].name
			arg_18_0.chapter2Name_.text = ActivityTetrisGameChapterCfg[var_18_2[2]].name

			local var_18_4, var_18_5 = TetrisGameTools:CheckChapterIsOpen(var_18_2[2])

			if not var_18_4 then
				arg_18_0.lockController:SetSelectedState("state1")

				arg_18_0.lockDesc.text = GetI18NText(var_18_5)
			else
				arg_18_0.lockController:SetSelectedState("state0")
			end

			local var_18_6, var_18_7 = TetrisGameTools:CheckChapterIsOpen(var_18_3)

			arg_18_0.chapter3Name_.text = ActivityTetrisGameChapterCfg[var_18_3].name

			if not var_18_6 then
				arg_18_0.endlessLockController:SetSelectedState("state1")

				arg_18_0.endlessLockDesc_.text = GetI18NText(var_18_7)
			else
				arg_18_0.endlessLockController:SetSelectedState("state0")
			end
		end

		arg_18_0:UpdataRedPoint()
	end
end

function var_0_0.UpdataRedPoint(arg_19_0)
	local var_19_0 = TetrisGameTools:GetSimpleChapterIDListByActivityID(arg_19_0.activityID)

	if #var_19_0 > 0 then
		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, iter_19_1)) then
				manager.redPoint:SetRedPointIndependent(arg_19_0["chapter" .. iter_19_0 .. "Btn_"].transform, true)
			else
				manager.redPoint:SetRedPointIndependent(arg_19_0["chapter" .. iter_19_0 .. "Btn_"].transform, false)
			end
		end
	end
end

return var_0_0
