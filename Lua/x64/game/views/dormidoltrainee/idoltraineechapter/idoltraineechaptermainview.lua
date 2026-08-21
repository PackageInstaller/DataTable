local var_0_0 = class("IdolTraineeChapterMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleChapterView"
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

	arg_4_0.chapterList_ = IdolTraineeChapterCfg.all
	arg_4_0.chapterUIList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.chapterUIList_, IdolTraineeChapterListItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_7_0.chapterUIList_:StartScroll(#arg_7_0.chapterList_)
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.chapterList_[arg_9_1]

	arg_9_2:SetData(var_9_0)

	local var_9_1 = string.format("%s_%s", RedPointConst.IDOL_TRAINEE_CHAPTER_TASK, var_9_0)
	local var_9_2 = manager.redPoint:getTipBoolean(var_9_1)

	manager.redPoint:SetRedPointIndependent(arg_9_2.transform_, var_9_2)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.chapterUIList_:Dispose()

	arg_10_0.chapterUIList_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
