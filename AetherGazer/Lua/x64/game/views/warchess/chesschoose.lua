local var_0_0 = class("WarChessChoose", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/WarChess_Battle/WarChessChoosePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.selectItem_ = 1
	arg_3_0.itemList_ = {}

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_tickBtn_, nil, function()
		local var_6_0 = manager.ChessManager:GetExecutingChess()

		WarChessAction.GetTreasure({
			x = var_6_0.x,
			z = var_6_0.z
		}, arg_5_0.state[arg_5_0.selectItem_])
		OperationRecorder.Record("chess", "check_select_artifact")
	end)
end

function var_0_0.OnGetTreasure(arg_7_0, arg_7_1, arg_7_2)
	if isSuccess(arg_7_1.result) then
		local var_7_0 = arg_7_2.param

		WarChessData:ModifyArtifactData(var_7_0, 1)
		arg_7_0:Back()
		manager.ChessManager:DoNextEvent()
	else
		manager.ChessManager:EventsEnd()
		ShowTips(arg_7_1.result)
	end
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.state = arg_8_0.params_.state

	SetActive(arg_8_0.btn_tickBtn_.gameObject, false)
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.selectItem_ = 1

	for iter_9_0 = 1, 3 do
		if not arg_9_0.itemList_[iter_9_0] then
			arg_9_0.itemList_[iter_9_0] = ChessChooseItem.New(arg_9_0.battleflagitemGo_)
		end

		arg_9_0.itemList_[iter_9_0]:RefreshUI(iter_9_0, arg_9_0.state[iter_9_0])
		arg_9_0.itemList_[iter_9_0]:RegisterListener(function(arg_10_0, arg_10_1)
			SetActive(arg_9_0.btn_tickBtn_.gameObject, true)

			if arg_10_0 then
				arg_9_0.selectItem_ = arg_10_1

				for iter_10_0 = 1, 3 do
					arg_9_0.itemList_[iter_10_0]:SetSelectState(arg_9_0.selectItem_ == iter_10_0)
				end
			end
		end)
		arg_9_0.itemList_[iter_9_0].controller_:SetSelectedState(0)
	end
end

function var_0_0.OnExit(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.itemList_) do
		iter_11_1:ResetToggle()
	end
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0 = 1, 3 do
		arg_12_0.itemList_[iter_12_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
