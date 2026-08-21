local var_0_0 = class("TowerStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Tower/TowerStageUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.m_list, TowerStageItem)
end

function var_0_0.OnTop(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.chapterClientID_ = 401
	arg_6_0.data = ChapterClientCfg.get_id_list_by_toggle[arg_6_0.chapterClientID_]

	if TowerData:GetTowerStageViewScrollPos() then
		arg_6_0.list:StartScrollByPosition(#arg_6_0.data, TowerData:GetTowerStageViewScrollPos())
	else
		arg_6_0.list:StartScroll(#arg_6_0.data)
	end

	TowerAction.CancelTowerRedPoint()
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()
end

function var_0_0.indexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.data[arg_8_1]

	arg_8_2:SetData(var_8_0, arg_8_1)
	arg_8_2:RegistCallBack(handler(arg_8_0, arg_8_0.OnItemClick))
end

function var_0_0.OnItemClick(arg_9_0)
	TowerData:CacheTowerStageViewScrollPos(arg_9_0.list:GetScrolledPosition())
end

function var_0_0.Dispose(arg_10_0)
	TowerData:CacheTowerStageViewScrollPos(nil)
	arg_10_0.list:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
