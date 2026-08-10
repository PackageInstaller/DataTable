local var_0_0 = class("NewWarChessHeroView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/NewWarChess/NewWarChessTeamUIPop"
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

	arg_4_0.List_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.listGo_, NewWarChessHeroItem)
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.heroInfoList_[arg_5_1])
	arg_5_2:EnableSkillItemClick()
	arg_5_2:BindSkillRedPoint()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.backbtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.heroInfoList_ = NewWarChessData:GetHeroInfoList()

	arg_9_0.List_:StartScroll(#arg_9_0.heroInfoList_)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)

	if arg_10_0.List_ then
		arg_10_0.List_:Dispose()

		arg_10_0.List_ = nil
	end
end

return var_0_0
