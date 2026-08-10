local var_0_0 = class("AutoChessOpenCardPopRecordItem", ReduxView)

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

function var_0_0.SetItemColor(arg_3_0, arg_3_1)
	arg_3_0.colorCon_:SetSelectedState(tostring(arg_3_1))
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = AutoChessCardData:GetOpenCardRecordByIndex(arg_4_1)
	local var_4_1 = var_4_0.cardId
	local var_4_2 = var_4_0.openTime
	local var_4_3 = AutoChessCardCfg[var_4_1].type
	local var_4_4 = manager.time:STimeDescS(var_4_2, "!%Y/%m/%d %H:%M")
	local var_4_5 = AutoChessCardTools.GetCardName(var_4_1)
	local var_4_6 = GetTips(AutoChessCardConst.CARD_TYPE_TIPS[var_4_3])

	arg_4_0.num_label.text = var_4_4
	arg_4_0.name_label.text = GetI18NText(var_4_5)
	arg_4_0.type_label.text = var_4_6

	arg_4_0:SetItemColor(var_4_3 + 2)
	arg_4_0.bgController_:SetSelectedState(arg_4_2 % 2 == 1 and "bg" or "not_bg")
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
