local function var_0_0(arg_1_0)
	if arg_1_0 >= 5 then
		return "#FF9300"
	elseif arg_1_0 >= 4 then
		return "#B200FF"
	else
		return "#000000"
	end
end

local var_0_1 = class("DrawRecordItem", ReduxView)

function var_0_1.OnCtor(arg_2_0, arg_2_1)
	arg_2_0.gameObject_ = arg_2_1
	arg_2_0.transform_ = arg_2_1.transform

	arg_2_0:Init()
end

function var_0_1.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.colorCon_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "conName")
end

function var_0_1.SetItemColor(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == ItemConst.ITEM_TYPE.HERO then
		arg_4_0.colorCon_:SetSelectedState(tostring(arg_4_2))
	elseif arg_4_1 == ItemConst.ITEM_TYPE.WEAPON_SERVANT and arg_4_2 >= 4 then
		arg_4_0.colorCon_:SetSelectedState(tostring(arg_4_2))
	else
		arg_4_0.colorCon_:SetSelectedState("white")
	end
end

function var_0_1.RefreshUI(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1.item
	local var_5_1 = arg_5_1.draw_timestamp
	local var_5_2 = var_5_0.id
	local var_5_3 = ItemCfg[var_5_2]
	local var_5_4 = var_5_3.display_rare
	local var_5_5 = manager.time:STimeDescS(var_5_1, "!%Y/%m/%d %H:%M")
	local var_5_6 = ItemTools.getItemName(var_5_0.id)
	local var_5_7 = string.format("[%s]", GetTips(ItemConst.ITEM_TYPE_NAME[var_5_3.type]))

	arg_5_0.num_label.text = var_5_5
	arg_5_0.name_label.text = GetI18NText(var_5_6)
	arg_5_0.type_label.text = var_5_7

	arg_5_0:SetItemColor(var_5_3.type, var_5_4)
end

local var_0_2 = class("TreasureRecordView", ReduxView)

function var_0_2.UIName(arg_6_0)
	return "Widget/System/Pool/PoolRecordPopUI"
end

function var_0_2.UIParent(arg_7_0)
	return manager.ui.uiPop.transform
end

function var_0_2.Init(arg_8_0)
	arg_8_0:InitUI()
	arg_8_0:AddListeners()

	arg_8_0.pageNum_ = 1
end

function var_0_2.InitUI(arg_9_0)
	arg_9_0:BindCfgUI()

	arg_9_0.scrollHelper_ = LuaList.New(handler(arg_9_0, arg_9_0.indexItem), arg_9_0.scrollviewGo_, var_0_1)
end

function var_0_2.AddListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.bgmask_, nil, function()
		arg_10_0:Back()
	end)
	arg_10_0:AddBtnListener(arg_10_0.buttonClose_, nil, function()
		arg_10_0:Back()
	end)
	arg_10_0:AddBtnListener(arg_10_0.rightBtn_, nil, function()
		if arg_10_0.pageNum_ * 10 + 1 <= #arg_10_0.record_list then
			arg_10_0.pageNum_ = arg_10_0.pageNum_ + 1
			arg_10_0.pagenumText_.text = arg_10_0.pageNum_

			arg_10_0:UpdateData(arg_10_0.pageNum_)
			arg_10_0.scrollHelper_:StartScroll(#arg_10_0.itemList_)
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.leftBtn_, nil, function()
		if arg_10_0.pageNum_ > 1 then
			arg_10_0.pageNum_ = arg_10_0.pageNum_ - 1
			arg_10_0.pagenumText_.text = arg_10_0.pageNum_

			arg_10_0:UpdateData(arg_10_0.pageNum_)
			arg_10_0.scrollHelper_:StartScroll(#arg_10_0.itemList_)
		end
	end)
end

function var_0_2.OnEnter(arg_15_0)
	local var_15_0 = arg_15_0.params_.poolId
	local var_15_1 = DrawData:GetDrawRecord(var_15_0)

	arg_15_0.pageNum_ = 1

	if var_15_1 then
		arg_15_0.times = var_15_1.ssr_draw_times
		arg_15_0.record_list = var_15_1.draw_record_list

		arg_15_0:RefreshUI()
	else
		DrawAction.RequestRecord(var_15_0)
	end
end

function var_0_2.OnRequestRecord(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = DrawData:GetDrawRecord(arg_16_2.id)

	if var_16_0 then
		arg_16_0.times = var_16_0.ssr_draw_times
		arg_16_0.record_list = var_16_0.draw_record_list or {}

		arg_16_0:RefreshUI()
	end
end

function var_0_2.RefreshUI(arg_17_0)
	arg_17_0.pagenumText_.text = arg_17_0.pageNum_

	arg_17_0:UpdateData(arg_17_0.pageNum_)
	arg_17_0.scrollHelper_:StartScroll(#arg_17_0.itemList_)
end

function var_0_2.UpdateData(arg_18_0, arg_18_1)
	arg_18_0.itemList_ = {}

	local var_18_0 = math.min(arg_18_1 * 10, #arg_18_0.record_list)

	for iter_18_0 = (arg_18_1 - 1) * 10 + 1, var_18_0 do
		table.insert(arg_18_0.itemList_, arg_18_0.record_list[iter_18_0])
	end
end

function var_0_2.indexItem(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2:RefreshUI(arg_19_0.itemList_[arg_19_1], arg_19_0.params_.poolId)
end

function var_0_2.Dispose(arg_20_0)
	arg_20_0.scrollHelper_:Dispose()
	var_0_2.super.Dispose(arg_20_0)
end

return var_0_2
