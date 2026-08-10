local var_0_0 = class("PopEquipSourceView", import("game.views.pop.PopItemView"))

function var_0_0.OnEnter(arg_1_0)
	arg_1_0.equipInfo_ = arg_1_0.params_.equip_info or {}

	var_0_0.super.OnEnter(arg_1_0)

	arg_1_0.itemList_ = {}

	arg_1_0:RefreshItem()

	if arg_1_0.params_.suitID then
		arg_1_0:CustomizeForSuit(arg_1_0.params_.suitID)
	end
end

function var_0_0.OnExit(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.itemList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.itemList_ = nil

	var_0_0.super.OnExit(arg_2_0)
end

function var_0_0.CustomInitUI(arg_3_0)
	var_0_0.super.CustomInitUI(arg_3_0)
	arg_3_0.btnShowControllerController:SetSelectedState("hide")
	arg_3_0.tabControllerController:SetSelectedState("source")
end

function var_0_0.CustomizeForSuit(arg_4_0, arg_4_1)
	local var_4_0 = EquipSuitCfg[arg_4_1].name

	arg_4_0.nameText_.text = GetI18NText(var_4_0)
end

function var_0_0.indexSoureceItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.sourceList[arg_5_1].equipId = arg_5_0:GetItemID()

	arg_5_2:RefreshUI(arg_5_0:GetItemID(), arg_5_0.sourceList[arg_5_1])

	if arg_5_0.OnJumpCallback then
		arg_5_2:SetJumpCallback(handler(arg_5_0, arg_5_0.OnJumpCallback))
	end
end

function var_0_0.RefreshItem(arg_6_0)
	local var_6_0 = arg_6_0:GetItemID()

	arg_6_0.sourceList = ItemTools.GetItemSourceList(var_6_0)

	arg_6_0.sourceScroll_:StartScroll(#arg_6_0.sourceList)
end

function var_0_0.OnTop(arg_7_0)
	local var_7_0 = arg_7_0:GetItemID()
	local var_7_1 = ItemTools.GetItemSourceList(var_7_0)

	arg_7_0.sourceList = var_7_1

	if #var_7_1 > 0 then
		arg_7_0.sourceScroll_:Refresh()
	end
end

function var_0_0.OnJumpCallback(arg_8_0)
	OperationRecorder.Record(arg_8_0.lastRecord_, "jump")
end

return var_0_0
