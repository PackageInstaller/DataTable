local var_0_0 = class("SummerPubPartnerTokenItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.index = arg_1_2
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.id = SummerPubHeroCfg.get_id_list_by_possession_path[arg_1_2][1]
	arg_1_0.cfg = SummerPubHeroCfg[arg_1_0.id]

	arg_1_0:AddListeners()
	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.tipsObject_ = SummerPubPartberTokenTipsItem.New(arg_2_0.tipsGo_, arg_2_0.id)
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.tipsObject_:Dispose()
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.Play(arg_4_0)
	if (getData("summer_pub_main", "partner_" .. arg_4_0.index, 1) or 0) == 0 and arg_4_0.cfg.type == SummerPubConst.PARTNER_TYPE.NORMAL then
		saveData("summer_pub_main", "partner_" .. arg_4_0.index, 1)
		arg_4_0.anim_:Play("UI_sunny_cx", -1, 0)
	end
end

function var_0_0.AddListeners(arg_5_0)
	return
end

function var_0_0.updateState(arg_6_0)
	if SummerPubData:isFindPartner(arg_6_0.id) then
		arg_6_0.gameObject_:SetActive(true)
		arg_6_0:Play()
	else
		arg_6_0.gameObject_:SetActive(false)
	end
end

return var_0_0
