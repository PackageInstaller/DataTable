local var_0_0 = class("OathEquityPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_Oath/OathDetailsView/HeroOathEquityPopUI"
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

	arg_4_0.lvStateController_ = arg_4_0.controller_:GetController("lvState")
	arg_4_0.lockStateController_ = arg_4_0.controller_:GetController("lock")

	arg_4_0:InitStageList()

	arg_4_0.equityList = LuaList.New(handler(arg_4_0, arg_4_0.IndexEquityItem), arg_4_0.uiListGo_, OathEquityItem)
	arg_4_0.lockText_.text = GetTips("WEDDING_RIGHT_UNLOCK_TIPS")
end

function var_0_0.IndexEquityItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.equityDataList[arg_5_1]

	arg_5_2:SetData(var_5_0)
end

function var_0_0.RefreshEquityList(arg_6_0)
	local var_6_0 = OathTools.GetOathEquityList(arg_6_0.heroID, arg_6_0.selectLevel, OathConst.OATH_EQUITY_SHOW_TYPE.ONLY_EQUITY_VIEW)

	arg_6_0.equityDataList = var_6_0

	arg_6_0.equityList:StartScroll(#var_6_0)

	if arg_6_0.stageBtnList[arg_6_0.selectLevel]:GetLock() then
		arg_6_0.lockStateController_:SetSelectedState("on")
	else
		arg_6_0.lockStateController_:SetSelectedState("off")
	end
end

function var_0_0.InitStageList(arg_7_0)
	arg_7_0.stageBtnList = {}
	arg_7_0.stageBeginIndex = 1

	for iter_7_0 = 0, arg_7_0.stageContent_.childCount - 1 do
		local var_7_0 = iter_7_0 + arg_7_0.stageBeginIndex
		local var_7_1 = arg_7_0.stageContent_:GetChild(iter_7_0).gameObject
		local var_7_2 = OathEquityStageItem.New(var_7_1, var_7_0)

		var_7_2:SetClickCallback(function()
			arg_7_0:OnClickStageItem(var_7_0)
		end)

		arg_7_0.stageBtnList[var_7_0] = var_7_2
	end
end

function var_0_0.OnClickStageItem(arg_9_0, arg_9_1)
	if arg_9_0.selectLevel == arg_9_1 then
		return
	end

	if arg_9_0.selectLevel then
		arg_9_0.stageBtnList[arg_9_0.selectLevel]:ChangeSelectState(false)
	end

	arg_9_0.selectLevel = arg_9_1

	arg_9_0.stageBtnList[arg_9_0.selectLevel]:ChangeSelectState(true)
	arg_9_0:RefreshEquityList()
	arg_9_0:RefreshLvUI()
end

function var_0_0.GetDefaultStageIndex(arg_10_0)
	if arg_10_0.selectLevel then
		return arg_10_0.selectLevel
	end

	return 1
end

function var_0_0.UpdateStageList(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.stageBtnList or {}) do
		iter_11_1:SetData(arg_11_0.heroID)
	end

	local var_11_0 = arg_11_0:GetDefaultStageIndex()

	arg_11_0:OnClickStageItem(var_11_0)
end

function var_0_0.AddUIListener(arg_12_0)
	arg_12_0:AddBtnListener(arg_12_0.closeBtn_, nil, function()
		arg_12_0:Back()
	end)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.heroID = arg_14_0.params_.heroID

	arg_14_0:UpdateStageList()
end

function var_0_0.RefreshLvUI(arg_15_0)
	if arg_15_0.selectLevel == OathConst.OATH_MAX_LV then
		arg_15_0.lvStateController_:SetSelectedState("max")
	else
		arg_15_0.lvStateController_:SetSelectedState("lvl")
	end

	arg_15_0.lvText_.text = arg_15_0.selectLevel
end

function var_0_0.OnExit(arg_16_0)
	if arg_16_0.selectLevel then
		arg_16_0.stageBtnList[arg_16_0.selectLevel]:ChangeSelectState(false)
	end

	arg_16_0.selectLevel = nil

	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_17_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.stageBtnList or {}) do
		iter_18_1:Dispose()
	end

	arg_18_0.stageBtnList = nil

	arg_18_0.equityList:Dispose()
	arg_18_0.super.Dispose(arg_18_0)
end

return var_0_0
