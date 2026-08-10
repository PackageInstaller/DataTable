local var_0_0 = class("PopItemSourceView", import("game.views.pop.PopItemView"))

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)

	local var_2_0

	if arg_2_0.itemInfo_.number then
		local var_2_1 = arg_2_0.itemInfo_.number
	end

	if ItemCfg[arg_2_0.itemInfo_.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		arg_2_0.tabControllerController:SetSelectedState("source")
	end

	arg_2_0.itemList_ = {}

	arg_2_0:RefreshItem()

	local var_2_2 = ItemCfg[arg_2_0:GetItemID()]

	if var_2_2 and ItemConst.ITEM_SUB_TYPE.FUKUBUKURO == var_2_2.sub_type then
		arg_2_0.probabilityController:SetSelectedState("show")
	else
		arg_2_0.probabilityController:SetSelectedState("notshow")
	end
end

function var_0_0.OnExit(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.itemList_) do
		iter_3_1:Dispose()
	end

	arg_3_0.itemList_ = nil

	var_0_0.super.OnExit(arg_3_0)
end

function var_0_0.CustomInitUI(arg_4_0)
	var_0_0.super.CustomInitUI(arg_4_0)
	arg_4_0.btnShowControllerController:SetSelectedState("show")
	arg_4_0.tabControllerController:SetSelectedState("source")
end

function var_0_0.AddListeners(arg_5_0)
	var_0_0.super.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.sourceBtn_, nil, function()
		arg_5_0.tabControllerController:SetSelectedState("descripe")
		OperationRecorder.Record(arg_5_0.lastRecord_, "popSourceItem_sourceBtn")
	end)
	arg_5_0:AddBtnListener(arg_5_0.infoBtn_, nil, function()
		arg_5_0.tabControllerController:SetSelectedState("source")
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_probabilityBtn, function()
		JumpTools.OpenPageByJump("popFukubukuroProbability", {
			itemId = arg_5_0:GetItemID()
		})
	end)
end

function var_0_0.RefreshItem(arg_9_0)
	local var_9_0 = arg_9_0:GetItemID()
	local var_9_1 = ItemTools.GetItemSourceList(var_9_0)

	arg_9_0.sourceList = var_9_1

	if #var_9_1 > 0 then
		arg_9_0.btnShowControllerController:SetSelectedState("show")
	else
		arg_9_0:ShowInfo()
	end

	arg_9_0.sourceScroll_:StartScroll(#var_9_1)
end

function var_0_0.OnTop(arg_10_0)
	local var_10_0 = arg_10_0:GetItemID()
	local var_10_1 = ItemTools.GetItemSourceList(var_10_0)

	arg_10_0.sourceList = var_10_1

	if #var_10_1 > 0 then
		arg_10_0.btnShowControllerController:SetSelectedState("show")
	else
		arg_10_0:ShowInfo()
	end

	arg_10_0.sourceScroll_:Refresh()
end

function var_0_0.OnJumpCallback(arg_11_0)
	OperationRecorder.Record(arg_11_0.lastRecord_, "jump")
end

return var_0_0
