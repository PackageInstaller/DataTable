local SimBusinessSpecialStageView = class("SimBusinessSpecialStageView", ReduxView)

function SimBusinessSpecialStageView:UIName()
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_SimBusinessSpecialSalePopUI"
end

function SimBusinessSpecialStageView:UIParent()
	return manager.ui.uiPop.transform
end

function SimBusinessSpecialStageView:OnCtor()
	return
end

function SimBusinessSpecialStageView:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.stageList = SimBusinessStageCfg.get_id_list_by_type[1]
	self.stageItemList = {}

	for iter_4_0, iter_4_1 in ipairs(self.stageList) do
		self.stageItemList[iter_4_1] = SimBusinessSpecialStageItem.New(self["item" .. iter_4_0 .. "Go_"])

		self.stageItemList[iter_4_1]:RegisterClickFunc(handler(self, self.clickStage))
	end
end

function SimBusinessSpecialStageView:OnEnter()
	return
end

function SimBusinessSpecialStageView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
end

function SimBusinessSpecialStageView:OnTop()
	self:RefreshView()
end

function SimBusinessSpecialStageView:OnExit()
	return
end

function SimBusinessSpecialStageView:RefreshView()
	self:RefreshStageState()
end

function SimBusinessSpecialStageView:clickStage(arg_11_1)
	SimBusinessBridge.EnterLevel(arg_11_1)
	JumpTools.Back()
end

function SimBusinessSpecialStageView:RefreshStageState()
	for iter_12_0, iter_12_1 in ipairs(self.stageList) do
		self.stageItemList[iter_12_1]:RefreshView(iter_12_1)
	end
end

function SimBusinessSpecialStageView:Dispose()
	for iter_13_0, iter_13_1 in pairs(self.stageItemList) do
		iter_13_1:Dispose()
	end

	SimBusinessSpecialStageView.super.Dispose(self)
end

return SimBusinessSpecialStageView
