local var_0_0 = class("NewWarChessHeroPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/NewWarChess/NewWarChessGet"
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

	arg_4_0.heroItem_ = NewWarChessHeroItem.New(arg_4_0.heroGo_)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backbtn_, nil, function()
		JumpTools.Back()

		if arg_5_0.params_.callBack then
			arg_5_0.params_.callBack()
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.heroItem_:SetData(NewWarChessData:GetHeroInfo(arg_7_0.params_.newChessHeroID))
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)

	if arg_8_0.heroItem_ then
		arg_8_0.heroItem_:Dispose()

		arg_8_0.heroItem_ = nil
	end
end

return var_0_0
