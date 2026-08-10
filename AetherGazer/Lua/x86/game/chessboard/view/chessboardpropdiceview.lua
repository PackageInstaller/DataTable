local var_0_0 = class("ChessBoardPropDiceView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_SelectstepsPopUI"
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

	arg_4_0.viewController_ = arg_4_0.controllerexcollection_:GetController("viewState")
	arg_4_0.btnController_ = arg_4_0.controllerexcollection_:GetController("btnState")
	arg_4_0.diceItemClickHandle_ = handler(arg_4_0, arg_4_0.OnDiceItemClick)
	arg_4_0.diceList = {}

	for iter_4_0 = 1, 6 do
		local var_4_0 = arg_4_0[string.format("sifter0%sGo_", iter_4_0)]

		arg_4_0.diceList[iter_4_0] = ChessBoardSelectDiceItem.New(var_4_0, iter_4_0)

		arg_4_0.diceList[iter_4_0]:SetClickHandle(arg_4_0.diceItemClickHandle_)
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.summer2024_cancelbtnBtn_, nil, function()
		arg_5_0.viewController_:SetSelectedState("showMap")
	end)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0.viewController_:SetSelectedState("normal")
	end)
	arg_5_0:AddBtnListener(arg_5_0.summer2024_cornerbtnBtn_, nil, function()
		if not arg_5_0.selectIndex then
			ShowTips("CHESSBOARD_CHOOSE_DICE_NUM")

			return
		end

		ChessBoardAction.UseProp(arg_5_0.propID, {
			arg_5_0.selectIndex
		}, function()
			gameContext:Go("/chessBoardHomeView")
			manager.ChessBoardManager:PropEffect(arg_5_0.propID, {
				arg_5_0.selectIndex
			})
		end)
	end)
end

function var_0_0.OnDiceItemClick(arg_10_0, arg_10_1)
	if arg_10_1 == arg_10_0.selectIndex then
		return
	end

	if arg_10_0.selectIndex and arg_10_0.diceList[arg_10_0.selectIndex] then
		arg_10_0.diceList[arg_10_0.selectIndex]:RefreshSelect(arg_10_1)
	end

	arg_10_0.selectIndex = arg_10_1

	if arg_10_0.selectIndex and arg_10_0.diceList[arg_10_0.selectIndex] then
		arg_10_0.diceList[arg_10_0.selectIndex]:RefreshSelect(arg_10_1)
	end

	arg_10_0.btnController_:SetSelectedState("Select")
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.selectIndex = nil
	arg_11_0.propID = arg_11_0.params_.propID

	for iter_11_0, iter_11_1 in pairs(arg_11_0.diceList or {}) do
		iter_11_1:RefreshUi()
	end

	arg_11_0.btnController_:SetSelectedState("noSelect")
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.diceList) do
		iter_12_1:Dispose()

		iter_12_1 = nil
	end

	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
