local var_0_0 = class("WarChessReviveView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/WarChess_Battle/WarChessReviveUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.selectItem_ = 1

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.panelitemGo_, ChessReviveItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.okbtnBtn_, nil, function()
		if arg_5_0.selectItem_ ~= 0 then
			WarChessAction.ReviveHero(arg_5_0.pos_, arg_5_0.itemList_[arg_5_0.selectItem_])
		end
	end)
end

function var_0_0.UpdateData(arg_7_0)
	arg_7_0.itemList_ = {}

	local var_7_0 = WarChessData:GetHeroList()

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if iter_7_1 <= 0 then
			table.insert(arg_7_0.itemList_, iter_7_0)
		end
	end
end

function var_0_0.indexItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:RefreshUI(arg_8_0.itemList_[arg_8_1], arg_8_1)
	arg_8_2:ShowSelect(arg_8_1 == arg_8_0.selectItem_)
	arg_8_2:RegisterListener(function(arg_9_0)
		local var_9_0 = arg_8_0.scrollHelper_:GetItemList()

		for iter_9_0, iter_9_1 in pairs(var_9_0) do
			iter_9_1:ShowSelect(arg_9_0 == iter_9_0)

			arg_8_0.selectItem_ = arg_9_0
		end
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.selectItem_ = 1
	arg_10_0.pos_ = {
		x = arg_10_0.params_.x,
		z = arg_10_0.params_.z
	}
	arg_10_0.callback_ = arg_10_0.params_.callback

	arg_10_0:UpdateData()
	arg_10_0.scrollHelper_:StartScroll(#arg_10_0.itemList_)
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.OnReviveHero(arg_12_0, arg_12_1, arg_12_2)
	if isSuccess(arg_12_1.result) then
		WarChessData:ModifyHp(arg_12_2.param, 10000)
		arg_12_0:Back()
		arg_12_0.callback_()
	else
		manager.ChessManager:EventsEnd()
		ShowTips(arg_12_1.result)
	end
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
