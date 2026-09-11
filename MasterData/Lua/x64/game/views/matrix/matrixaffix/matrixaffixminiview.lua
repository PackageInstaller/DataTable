local MatrixAffixMiniView = class("MatrixAffixMiniView", ReduxView)

function MatrixAffixMiniView:UIBackCount()
	return 3
end

function MatrixAffixMiniView:UIName()
	return "UI/Matrix/Prepare/MatrixAffixMiniUI"
end

function MatrixAffixMiniView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixAffixMiniView:Init()
	self:InitUI()
end

function MatrixAffixMiniView:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
	self.customItems = {}
	self.regularItems = {}
end

function MatrixAffixMiniView:OnTop()
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

function MatrixAffixMiniView:OnEnter()
	self.regularData = MatrixData:GetDifficultyData():GetRegularAffix()
	self.customData = MatrixData:GetCustomAffix()

	self:Refresh()
end

function MatrixAffixMiniView:OnTop()
	self:Refresh()
end

function MatrixAffixMiniView:Refresh()
	self:RefreshRegularItems(self.regularData)
	self.stateController_:SetSelectedIndex(#self.customData == 0 and 1 or 0)
	self:RefreshCustomItems(self.customData)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_contentRect)

	local var_9_0 = 0
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in ipairs(self.regularData) do
		var_9_0 = var_9_0 + ActivityAffixPoolCfg[iter_9_1].point
		var_9_1 = var_9_1 + ActivityAffixPoolCfg[iter_9_1].multiple
	end

	for iter_9_2, iter_9_3 in ipairs(self.customData) do
		var_9_0 = var_9_0 + ActivityAffixPoolCfg[iter_9_3].point
		var_9_1 = var_9_1 + ActivityAffixPoolCfg[iter_9_3].multiple
	end

	self.m_scoreLab.text = "" .. var_9_0
	self.m_retaLab.text = string.format(GetTips("MATRIX_AFFIX_RATE"), var_9_1 / 10 .. "%")
end

function MatrixAffixMiniView:RefreshCustomItems(arg_10_1)
	for iter_10_0 = 1, #arg_10_1 do
		self.customItems[iter_10_0] = self.customItems[iter_10_0] or MatrixAffixItem.New((Object.Instantiate(self.m_Item, self.m_customContent)))

		self.customItems[iter_10_0]:Refresh(ActivityAffixPoolCfg[arg_10_1[iter_10_0]].affix, 2)
		self.customItems[iter_10_0]:SetActive(true)
	end

	for iter_10_1 = #arg_10_1 + 1, #self.customItems do
		self.customItems[iter_10_1]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_customContent)
end

function MatrixAffixMiniView:RefreshRegularItems(arg_11_1)
	for iter_11_0 = 1, #arg_11_1 do
		self.regularItems[iter_11_0] = self.regularItems[iter_11_0] or MatrixAffixItem.New((Object.Instantiate(self.m_Item, self.m_regularContent)))

		self.regularItems[iter_11_0]:Refresh(ActivityAffixPoolCfg[arg_11_1[iter_11_0]].affix, 2)
		self.regularItems[iter_11_0]:SetActive(true)
	end

	for iter_11_1 = #arg_11_1 + 1, #self.regularItems do
		self.regularItems[iter_11_1]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_regularContent)
end

function MatrixAffixMiniView:IndexAffixWeekItem(arg_12_1, arg_12_2)
	arg_12_2:Refresh(ActivityAffixPoolCfg[self.regularData[arg_12_1]].affix, 2)
end

function MatrixAffixMiniView:IndexAffixOptionalItem(arg_13_1, arg_13_2)
	arg_13_2:Refresh(ActivityAffixPoolCfg[self.customData[arg_13_1]].affix, 2)
end

function MatrixAffixMiniView:Dispose()
	for iter_14_0, iter_14_1 in ipairs(self.customItems) do
		iter_14_1:Dispose()
	end

	self.customItems = {}

	for iter_14_2, iter_14_3 in ipairs(self.regularItems) do
		iter_14_3:Dispose()
	end

	self.regularItems = {}

	MatrixAffixMiniView.super.Dispose(self)
end

return MatrixAffixMiniView
