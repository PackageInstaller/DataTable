local var_0_0 = class("ChessBoardShopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_shopPopUI"
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

	arg_4_0.propList = ChessBoardPropList.New(arg_4_0.propListGo_, true)
	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiList_, ChessBoardShopItem)
	arg_4_0.shopItemClickHandle_ = handler(arg_4_0, arg_4_0.OnShopItemClick)
	arg_4_0.controller_ = arg_4_0.controllerEx_:GetController("status")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.summer2024_cornerbtnBtn_, nil, function()
		arg_5_0:OnBuyProp()
	end)
	arg_5_0:AddBtnListener(arg_5_0.summer2024_cancelbtnBtn_, nil, function()
		arg_5_0:OnCancelBtn()
	end)
end

function var_0_0.OnCancelBtn(arg_8_0)
	if #arg_8_0.chanceChooseList > 0 then
		ChessBoardAction.FinishChance(arg_8_0.chanceInfo_.chanceID, 1, 0, function()
			gameContext:Go("/chessBoardHomeView")
		end)
	else
		ChessBoardAction.FinishChance(arg_8_0.chanceInfo_.chanceID, 1, 0, function()
			gameContext:Go("/chessBoardHomeView")
		end)
	end
end

function var_0_0.OnBuyProp(arg_11_0)
	if not arg_11_0.selectShopID then
		return
	end

	if ChessBoardPropCfg[arg_11_0.selectShopID].cost > manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD") then
		ShowTips("CHESSBOARD_NEED_GOLD")

		return
	end

	local var_11_0 = #manager.ChessBoardManager:GetHeroProp()
	local var_11_1 = arg_11_0.selectShopID

	if var_11_0 >= ChessBoardConst.CHESSBOARD_MAX_PROP_NUMS then
		JumpTools.OpenPageByJump("/ChessBoardPropView", {
			propID = var_11_1,
			viewType = ChessBoardConst.VIEW_TYPE.CHANGE_PROP,
			changePropCallback = function(arg_12_0)
				JumpTools.Back()
				arg_11_0:SendBuyProp(var_11_1, arg_12_0)
			end,
			giveUpPropCallback = function()
				JumpTools.Back()
			end
		})
	else
		arg_11_0:SendBuyProp(var_11_1)
	end
end

function var_0_0.SendBuyProp(arg_14_0, arg_14_1, arg_14_2)
	ChessBoardAction.BuyShopProp(arg_14_1, arg_14_0.chanceInfo_.chanceID, function()
		local var_15_0 = ChessBoardPropCfg[arg_14_1]

		manager.ChessBoardManager:SubHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD", -var_15_0.cost)
		manager.ChessBoardManager:AddTmpHeroProp(arg_14_1, arg_14_2)
		arg_14_0.propList:CheckGetEffect()
		table.insert(arg_14_0.chanceChooseList, arg_14_1)
		arg_14_0:RefreshUI()
		manager.ChessBoardManager:SendTmpPropToServer()

		if #arg_14_0.chancePropList <= 0 then
			arg_14_0:OnCancelBtn()
		end
	end)
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0:InitData()
	arg_16_0:RefreshUI()
end

function var_0_0.OnShopItemClick(arg_17_0, arg_17_1)
	arg_17_0.selectShopID = arg_17_1

	arg_17_0:RefreshShopUIShow()

	local var_17_0 = arg_17_0.list_:GetItemList()

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		iter_17_1:RefreshSelect(arg_17_0.selectShopID)
	end
end

function var_0_0.RefreshShopUIShow(arg_18_0)
	if arg_18_0.selectShopID then
		local var_18_0 = ChessBoardPropCfg[arg_18_0.selectShopID]

		arg_18_0.descText_.text = var_18_0.use_description
		arg_18_0.titleText_.text = var_18_0.name
		arg_18_0.tipsText_.text = var_18_0.prop_description

		if var_18_0.cost > manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD") then
			arg_18_0.controller_:SetSelectedState("noGold")
		else
			arg_18_0.controller_:SetSelectedState("canBuy")
		end
	end
end

function var_0_0.IndexItem(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2:Refresh(arg_19_0.chancePropList[arg_19_1])
	arg_19_2:RefreshSelect(arg_19_0.selectShopID)
	arg_19_2:SetClickHandle(arg_19_0.shopItemClickHandle_)
end

function var_0_0.InitData(arg_20_0)
	arg_20_0.chanceInfo_ = manager.ChessBoardManager:GetCurChanceInfo()
	arg_20_0.chanceChooseList = arg_20_0.chanceInfo_.chanceChooseList
end

function var_0_0.RefreshUI(arg_21_0)
	arg_21_0.goldText_.text = manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD")
	arg_21_0.chancePropList = {}

	for iter_21_0, iter_21_1 in pairs(arg_21_0.chanceInfo_.chancePropList) do
		local var_21_0 = false

		for iter_21_2, iter_21_3 in pairs(arg_21_0.chanceChooseList) do
			if iter_21_1 == iter_21_3 then
				var_21_0 = true
			end
		end

		if not var_21_0 then
			table.insert(arg_21_0.chancePropList, iter_21_1)
		end
	end

	if arg_21_0.chanceInfo_ == nil or arg_21_0.chanceInfo_.chanceID <= 0 then
		error("当前没有触发的机遇！！")
	else
		arg_21_0.list_:StartScroll(#arg_21_0.chancePropList)
	end

	arg_21_0.selectShopID = arg_21_0.chancePropList[1]

	arg_21_0:RefreshShopUIShow()
	arg_21_0:OnChessBoardPropUpdate()
end

function var_0_0.OnChessBoardPropUpdate(arg_22_0)
	arg_22_0.propList:RefreshList()
end

function var_0_0.Dispose(arg_23_0)
	if arg_23_0.propList then
		arg_23_0.propList:Dispose()

		arg_23_0.propList = nil
	end

	if arg_23_0.list_ then
		arg_23_0.list_:Dispose()

		arg_23_0.list_ = nil
	end

	arg_23_0.super.Dispose(arg_23_0)
end

return var_0_0
