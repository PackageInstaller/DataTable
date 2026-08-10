local var_0_0 = class("MatrixAffixMiniView", ReduxView)

function var_0_0.UIBackCount(arg_1_0)
	return 3
end

function var_0_0.UIName(arg_2_0)
	return "UI/Matrix/Prepare/MatrixAffixMiniUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.stateController_ = ControllerUtil.GetController(arg_5_0.transform_, "state")
	arg_5_0.customItems = {}
	arg_5_0.regularItems = {}
end

function var_0_0.OnTop(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = MatrixConst.MATRIX_GAME_HELP_PAGES
		}
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.regularData = MatrixData:GetDifficultyData():GetRegularAffix()
	arg_7_0.customData = MatrixData:GetCustomAffix()

	arg_7_0:Refresh()
end

function var_0_0.OnTop(arg_8_0)
	arg_8_0:Refresh()
end

function var_0_0.Refresh(arg_9_0)
	arg_9_0:RefreshRegularItems(arg_9_0.regularData)

	local var_9_0 = #arg_9_0.customData

	arg_9_0.stateController_:SetSelectedIndex(var_9_0 == 0 and 1 or 0)
	arg_9_0:RefreshCustomItems(arg_9_0.customData)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.m_contentRect)

	local var_9_1 = 0
	local var_9_2 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.regularData) do
		local var_9_3 = ActivityAffixPoolCfg[iter_9_1]

		var_9_1 = var_9_1 + var_9_3.point
		var_9_2 = var_9_2 + var_9_3.multiple
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_0.customData) do
		local var_9_4 = ActivityAffixPoolCfg[iter_9_3]

		var_9_1 = var_9_1 + var_9_4.point
		var_9_2 = var_9_2 + var_9_4.multiple
	end

	local var_9_5 = var_9_2 / 10

	arg_9_0.m_scoreLab.text = "" .. var_9_1
	arg_9_0.m_retaLab.text = string.format(GetTips("MATRIX_AFFIX_RATE"), var_9_5 .. "%")
end

function var_0_0.RefreshCustomItems(arg_10_0, arg_10_1)
	local var_10_0 = #arg_10_1

	for iter_10_0 = 1, var_10_0 do
		if not arg_10_0.customItems[iter_10_0] then
			local var_10_1 = Object.Instantiate(arg_10_0.m_Item, arg_10_0.m_customContent)

			arg_10_0.customItems[iter_10_0] = MatrixAffixItem.New(var_10_1)
		end

		local var_10_2 = arg_10_1[iter_10_0]
		local var_10_3 = ActivityAffixPoolCfg[var_10_2].affix

		arg_10_0.customItems[iter_10_0]:Refresh(var_10_3, 2)
		arg_10_0.customItems[iter_10_0]:SetActive(true)
	end

	for iter_10_1 = var_10_0 + 1, #arg_10_0.customItems do
		arg_10_0.customItems[iter_10_1]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.m_customContent)
end

function var_0_0.RefreshRegularItems(arg_11_0, arg_11_1)
	local var_11_0 = #arg_11_1

	for iter_11_0 = 1, var_11_0 do
		if not arg_11_0.regularItems[iter_11_0] then
			local var_11_1 = Object.Instantiate(arg_11_0.m_Item, arg_11_0.m_regularContent)

			arg_11_0.regularItems[iter_11_0] = MatrixAffixItem.New(var_11_1)
		end

		local var_11_2 = arg_11_1[iter_11_0]
		local var_11_3 = ActivityAffixPoolCfg[var_11_2].affix

		arg_11_0.regularItems[iter_11_0]:Refresh(var_11_3, 2)
		arg_11_0.regularItems[iter_11_0]:SetActive(true)
	end

	for iter_11_1 = var_11_0 + 1, #arg_11_0.regularItems do
		arg_11_0.regularItems[iter_11_1]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.m_regularContent)
end

function var_0_0.IndexAffixWeekItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.regularData[arg_12_1]
	local var_12_1 = ActivityAffixPoolCfg[var_12_0].affix

	arg_12_2:Refresh(var_12_1, 2)
end

function var_0_0.IndexAffixOptionalItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.customData[arg_13_1]
	local var_13_1 = ActivityAffixPoolCfg[var_13_0].affix

	arg_13_2:Refresh(var_13_1, 2)
end

function var_0_0.Dispose(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.customItems) do
		iter_14_1:Dispose()
	end

	arg_14_0.customItems = {}

	for iter_14_2, iter_14_3 in ipairs(arg_14_0.regularItems) do
		iter_14_3:Dispose()
	end

	arg_14_0.regularItems = {}

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
