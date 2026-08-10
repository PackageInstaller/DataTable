local var_0_0 = class("DrawServantSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Pool/TreasurePop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.selectID_ = nil

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uilistGo_, DrawServantSelectItem)
	arg_4_0.btnController = arg_4_0.controller_:GetController("btn")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnrenewalBtn_, nil, function()
		if DrawData:GetPollUpID(arg_5_0.poolID_) == arg_5_0.selectID_ then
			ShowTips("DRAW_NOT_SELECT_WEAPON_TIPS")

			return
		end

		DrawAction.SetPollUpID(arg_5_0.poolID_, arg_5_0.selectID_)
	end)
end

function var_0_0.OnSetPollUpID(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:Back()

	arg_7_0.selectID_ = nil
end

function var_0_0.indexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = DrawPoolCfg[arg_8_0.poolID_]

	arg_8_2:RefreshUI(arg_8_1, arg_8_0.itemList_[arg_8_1], var_8_0.optional_detail[arg_8_1])
	arg_8_2:ShowSelect(arg_8_0.selectID_)
	arg_8_2:RegisterListener(function(arg_9_0)
		local var_9_0 = arg_8_0.scrollHelper:GetItemList()

		for iter_9_0, iter_9_1 in pairs(var_9_0) do
			iter_9_1:ShowSelect(arg_9_0)
		end

		arg_8_0.selectID_ = arg_9_0

		arg_8_0:RefreshTitle(arg_8_0.selectID_)
	end)
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.UpdateData(arg_11_0)
	arg_11_0.itemList_ = {}
	arg_11_0.itemList_ = deepClone(DrawPoolCfg[arg_11_0.poolID_].optional_lists_poolId)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.poolID_ = 10002
	arg_12_0.selectID_ = nil

	if not arg_12_0.selectID_ then
		arg_12_0.selectID_ = DrawData:GetPollUpID(arg_12_0.poolID_)
	end

	arg_12_0:RefreshTitle(arg_12_0.selectID_)

	if arg_12_0.selectID_ ~= 0 then
		arg_12_0.btnController:SetSelectedState("current")
	else
		arg_12_0.titleText_.text = GetTips("DRAW_SELECT_WEAPON_TIPS")

		arg_12_0.btnController:SetSelectedState("false")
	end

	arg_12_0:UpdateData()
	arg_12_0.scrollHelper:StartScroll(#arg_12_0.itemList_)
end

function var_0_0.RefreshTitle(arg_13_0, arg_13_1)
	local var_13_0 = DrawPoolCfg[arg_13_0.poolID_]
	local var_13_1 = table.indexof(var_13_0.optional_lists_poolId, arg_13_1)
	local var_13_2 = DrawData:GetPollUpID(arg_13_0.poolID_)

	arg_13_0.btnController:SetSelectedState(var_13_2 ~= arg_13_0.selectID_ and "true" or "current")

	if var_13_1 and var_13_0.optional_detail[var_13_1] then
		local var_13_3 = var_13_0.optional_detail[var_13_1]
		local var_13_4 = WeaponServantCfg[var_13_3].race
		local var_13_5 = RaceEffectCfg[var_13_4].name

		arg_13_0.titleText_.text = string.format(GetTips("CHOOSE_SERVANT_COMBINATION"), GetI18NText(var_13_5))
	end
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.scrollHelper:Dispose()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
