local var_0_0 = class("MatrixProcessShopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/MatrixlUI/MatrixProcessShopUI"
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

	arg_4_0.matrixShopList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.m_list, MatrixProcessShopItem)
	arg_4_0.emptyController = ControllerUtil.GetController(arg_4_0.transform_, "empty")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_sellerBtn, nil, function()
		arg_5_0:RandomDialog(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_refreshBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = {
				GetTips("WHETHER_TO_CONSUME"),
				{
					CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
					arg_5_0.refreshCost
				},
				(GetTips("MATRIX_SHOP_REFRESH"))
			},
			OkCallback = function()
				MatrixAction.QueryRefreshShopItem()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_0.indexItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:Refresh(arg_10_0.shops[arg_10_1])
end

function var_0_0.UpdateView(arg_11_0, arg_11_1)
	arg_11_0.refreshCount, arg_11_0.shops = arg_11_0:GetMatrixPhaseData():GetData()

	arg_11_0.matrixShopList_:StartScroll(#arg_11_0.shops)

	if arg_11_1 then
		arg_11_0.matrixShopList_:StartScrollByPosition(#arg_11_0.shops, arg_11_1)
	else
		arg_11_0.matrixShopList_:StartScroll(#arg_11_0.shops)
	end

	if #arg_11_0.shops == 0 then
		arg_11_0.emptyController:SetSelectedIndex(1)
	else
		arg_11_0.emptyController:SetSelectedIndex(0)
	end

	local var_11_0 = arg_11_0:GetShoRefreshTimes()
	local var_11_1 = arg_11_0:GetShopFressRefreshTimes()

	if var_11_0 > arg_11_0.refreshCount then
		SetActive(arg_11_0.m_refreshContent, true)

		arg_11_0.refreshCost = 0
		arg_11_0.m_refreshTimes.text = string.format("%d/%d", arg_11_0.refreshCount, var_11_0)

		local var_11_2 = GameSetting.matrix_shop_refresh_cost_item_list.value

		if var_11_1 <= arg_11_0.refreshCount then
			local var_11_3 = arg_11_0.refreshCount - var_11_1
			local var_11_4 = var_11_2[math.min(var_11_3 + 1, #var_11_2)]

			arg_11_0.refreshCost = var_11_4[2]
			arg_11_0.m_refreshIcon.sprite = ItemTools.getItemLittleSprite(arg_11_0:GetSwitchItemIcon(var_11_4[1]))
		else
			local var_11_5 = var_11_2[1]

			arg_11_0.m_refreshIcon.sprite = ItemTools.getItemLittleSprite(arg_11_0:GetSwitchItemIcon(var_11_5[1]))
			arg_11_0.refreshCost = 0
		end

		arg_11_0.m_refreshCost.text = "x" .. arg_11_0.refreshCost
	else
		SetActive(arg_11_0.m_refreshContent, false)
	end
end

function var_0_0.RandomDialog(arg_12_0, arg_12_1)
	local var_12_0 = MatrixShopDialogCfg.get_id_list_by_type[arg_12_1]

	if not var_12_0 then
		return
	end

	SetActive(arg_12_0.m_bubbleGo, true)

	local var_12_1 = #var_12_0

	if #var_12_0 == 1 then
		arg_12_0.curRandomIndex_ = 1
	else
		local var_12_2 = math.random(2, var_12_1)

		arg_12_0.curRandomIndex_ = var_12_2 == arg_12_0.curRandomIndex_ and 1 or var_12_2
	end

	local var_12_3 = var_12_0[arg_12_0.curRandomIndex_]
	local var_12_4 = MatrixShopDialogCfg[var_12_3]

	arg_12_0.m_dialogText.text = GetI18NText(var_12_4.content)

	local var_12_5 = var_12_4.voice_sheet
	local var_12_6 = var_12_4.voice_name

	if var_12_5 ~= nil and var_12_5 ~= "" and var_12_6 ~= nil and var_12_6 ~= "" then
		manager.audio:PlayVoice(var_12_5, var_12_6, "")
	end

	if arg_12_0.timer_ == nil then
		arg_12_0.timer_ = Timer.New(function()
			arg_12_0:RemoveDialog()
		end, 3, 1)

		arg_12_0.timer_:Start()
	else
		arg_12_0.timer_:Reset()
	end
end

function var_0_0.RemoveDialog(arg_14_0)
	SetActive(arg_14_0.m_bubbleGo, false)

	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()

		arg_14_0.timer_ = nil
	end
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0:UpdateView()
	arg_15_0:RandomDialog(2)
end

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, false)
	manager.windowBar:SetGameHelpKey("MATRIX_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("MATRIX_SURE_GET_OUT_SHOP"),
			OkCallback = function()
				if arg_16_0:GetGameState() == MatrixConst.STATE_TYPE.STARTED then
					MatrixAction.QueryNextProgress()
				end

				JumpTools.OpenPageByJump("/matrixBlank/matrixOrigin")
			end
		})
	end)
end

function var_0_0.OnExit(arg_19_0)
	arg_19_0:RemoveDialog()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.matrixShopList_ then
		arg_20_0.matrixShopList_:Dispose()

		arg_20_0.matrixShopList_ = nil
	end

	var_0_0.super.Dispose(arg_20_0)
end

function var_0_0.OnMatrixUserUpdate(arg_21_0)
	local var_21_0 = arg_21_0:GetGameState()

	if MatrixConst.STATE_TYPE.STARTED == var_21_0 then
		arg_21_0:UpdateView()
	elseif MatrixConst.STATE_TYPE.NOTSTARTED == var_21_0 then
		JumpTools.OpenPageByJump("/matrixBlank/matrixPrepare", {
			isTimeOut = true
		})
	end
end

function var_0_0.OnMatrixShopBuySuccess(arg_22_0)
	arg_22_0:RandomDialog(3)
end

function var_0_0.OnMatrixSystemUpdate(arg_23_0)
	local var_23_0 = arg_23_0.matrixShopList_:GetScrolledPosition()

	arg_23_0:UpdateView(var_23_0)
end

function var_0_0.OnMatrixUserUpdate(arg_24_0)
	local var_24_0 = arg_24_0.matrixShopList_:GetScrolledPosition()

	arg_24_0:UpdateView(var_24_0)
end

function var_0_0.GetGameState(arg_25_0)
	return MatrixData:GetGameState()
end

function var_0_0.GetMatrixPhaseData(arg_26_0)
	return MatrixData:GetMatrixPhaseData()
end

function var_0_0.GetShoRefreshTimes(arg_27_0)
	return MatrixData:GetShoRefreshTimes()
end

function var_0_0.GetShopFressRefreshTimes(arg_28_0)
	return MatrixData:GetShopFressRefreshTimes()
end

function var_0_0.GetSwitchItemIcon(arg_29_0, arg_29_1)
	return arg_29_1
end

return var_0_0
