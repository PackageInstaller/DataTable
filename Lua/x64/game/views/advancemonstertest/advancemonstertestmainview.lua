local var_0_0 = class("AdvanceMonsterTestMainView", ReduxView)
local var_0_1 = {
	LOOKBACK = 0,
	CURRENT = 1
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/BossTestUI/BossTestMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stageList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, AdvanceMonsterTestMainViewItem)
	arg_4_0.lookBackStageList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.lookbacklistGo_, AdvanceMonsterTestMainViewItem)
	arg_4_0.btnController_ = arg_4_0.btnControllerEx_:GetController("btnStatus")
	arg_4_0.curType_ = 1
	arg_4_0.lastType_ = nil
	arg_4_0.lastScrollPos_ = nil
	arg_4_0.lastLookBackScrollPos_ = nil
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.stageIDList_[arg_5_1])
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.curBtn_, nil, function()
		if arg_6_0.curType_ == 1 then
			return
		else
			arg_6_0.curType_ = 1

			arg_6_0:RefreshUI()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.beforeBtn_, nil, function()
		if arg_6_0.curType_ == 0 then
			return
		else
			arg_6_0.curType_ = 0

			arg_6_0:RefreshUI()
		end
	end)
end

function var_0_0.OnEnter(arg_9_0)
	local var_9_0 = AdvanceMonsterTestData:GetCurStageID()

	if var_9_0 > 0 then
		arg_9_0.curType_ = ActivityAdvanceMonsterTestCfg[var_9_0].type
	end

	AdvanceMonsterTestData:SetCurStageID(-1)
	arg_9_0:RefreshUI()

	if arg_9_0.curType_ == arg_9_0.lastType_ then
		if arg_9_0.curType_ == var_0_1.CURRENT then
			arg_9_0.stageList_:SetScrolledPosition(arg_9_0.lastScrollPos_)
		else
			arg_9_0.lookBackStageList_:SetScrolledPosition(arg_9_0.lastLookBackScrollPos_)
		end
	else
		arg_9_0.lastType_ = nil
		arg_9_0.lastScrollPos_ = nil
		arg_9_0.lastLookBackScrollPos_ = nil
	end

	if getData("monsterTest", "monsterTest") ~= "1" and #arg_9_0.page > 0 then
		saveData("monsterTest", "monsterTest", "1")
		TimeTools.StartAfterSeconds(0.1, function()
			JumpTools.OpenPageByJump("gameHelpPro", {
				isPrefab = true,
				pages = arg_9_0.page
			})
		end, {})
	end
end

function var_0_0.GetSortStageIDList(arg_11_0)
	local var_11_0 = ActivityAdvanceMonsterTestCfg.get_id_list_by_type[arg_11_0.curType_]

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		local var_12_0 = ActivityAdvanceMonsterTestCfg[arg_12_0]
		local var_12_1 = ActivityAdvanceMonsterTestCfg[arg_12_1]

		if var_12_0.order ~= var_12_1.order then
			return var_12_0.order < var_12_1.order
		end

		return arg_12_0 < arg_12_1
	end)

	return var_11_0
end

function var_0_0.RefreshUI(arg_13_0)
	if arg_13_0.curType_ == var_0_1.CURRENT then
		arg_13_0.btnController_:SetSelectedState("cur")
	elseif arg_13_0.curType_ == var_0_1.LOOKBACK then
		arg_13_0.btnController_:SetSelectedState("history")
	end

	arg_13_0.stageIDList_ = arg_13_0:GetSortStageIDList()

	if arg_13_0.curType_ == var_0_1.CURRENT then
		if arg_13_0.stageIDList_ then
			arg_13_0.stageList_:StartScroll(#arg_13_0.stageIDList_)
		else
			arg_13_0.stageList_:StartScroll(0)
		end
	elseif arg_13_0.stageIDList_ then
		arg_13_0.lookBackStageList_:StartScroll(#arg_13_0.stageIDList_)
	else
		arg_13_0.lookBackStageList_:StartScroll(0)
	end

	arg_13_0.page = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.stageIDList_) do
		local var_13_0 = ActivityAdvanceMonsterTestCfg[iter_13_1]

		if var_13_0.level_describe ~= "" then
			table.insert(arg_13_0.page, var_13_0.level_describe[1])
		end
	end

	arg_13_0:OnTop()
end

function var_0_0.OnTop(arg_14_0)
	if #arg_14_0.page > 0 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = arg_14_0.page
		})
	end)
end

function var_0_0.OnExit(arg_16_0)
	manager.windowBar:HideBar()

	arg_16_0.lastType_ = arg_16_0.curType_
	arg_16_0.lastScrollPos_ = arg_16_0.stageList_:GetScrolledPosition()
	arg_16_0.lastLookBackScrollPos_ = arg_16_0.lookBackStageList_:GetScrolledPosition()
end

function var_0_0.Dispose(arg_17_0)
	var_0_0.super.Dispose(arg_17_0)

	if arg_17_0.stageList_ then
		arg_17_0.stageList_:Dispose()

		arg_17_0.stageList_ = nil
	end

	if arg_17_0.lookBackStageList_ then
		arg_17_0.lookBackStageList_:Dispose()

		arg_17_0.lookBackStageList_ = nil
	end
end

return var_0_0
