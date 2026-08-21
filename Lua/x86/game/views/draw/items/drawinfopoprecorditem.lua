local var_0_0 = class("DrawInfoPopRecordItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.colorCon_ = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "conName")
	arg_2_0.bgController_ = arg_2_0.controllerEx_:GetController("bg_or_not")
end

function var_0_0.SetItemColor(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == ItemConst.ITEM_TYPE.HERO then
		arg_3_0.colorCon_:SetSelectedState(tostring(arg_3_2))
	elseif arg_3_1 == ItemConst.ITEM_TYPE.WEAPON_SERVANT and arg_3_2 >= 4 then
		arg_3_0.colorCon_:SetSelectedState(tostring(arg_3_2))
	else
		arg_3_0.colorCon_:SetSelectedState("white")
	end
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_1.item
	local var_4_1 = arg_4_1.draw_timestamp
	local var_4_2 = var_4_0.id
	local var_4_3 = ItemCfg[var_4_2]
	local var_4_4 = var_4_3.display_rare
	local var_4_5 = manager.time:STimeDescS(var_4_1, "!%Y/%m/%d %H:%M")
	local var_4_6 = ItemTools.getItemName(var_4_0.id)
	local var_4_7 = string.format("[%s]", GetTips(ItemConst.ITEM_TYPE_NAME[var_4_3.type]))

	arg_4_0.num_label.text = var_4_5
	arg_4_0.name_label.text = GetI18NText(var_4_6)
	arg_4_0.type_label.text = var_4_7

	arg_4_0:SetItemColor(var_4_3.type, var_4_4)
	arg_4_0.bgController_:SetSelectedState(arg_4_3 % 2 == 1 and "bg" or "not_bg")
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
