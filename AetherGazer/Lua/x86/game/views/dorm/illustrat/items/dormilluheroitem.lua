local var_0_0 = class("DormIlluHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.unLockController_ = arg_2_0.mainControllerEx_:GetController("have")

	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.mainBtn_, nil, function()
		arg_3_0.clickFunc_(arg_3_0.heroID_, arg_3_0.index_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.index_ = arg_5_1
	arg_5_0.heroID_ = arg_5_2
	arg_5_0.archiveID_ = HeroRecordCfg.get_id_list_by_hero_id[arg_5_0.heroID_][1]
	arg_5_0.isUnlock_ = HeroTools.GetHeroIsUnlock(arg_5_0.heroID_)

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0.unLockController_:SetSelectedIndex(arg_6_0.isUnlock_ and 1 or 0)

	arg_6_0.headImage_.sprite = DormHeroTools.GetBackHomeHeroSkinIcon(arg_6_0.heroID_)
	arg_6_0.nameText_.text = HeroCfg[arg_6_0.heroID_].name
end

function var_0_0.SetUnlock(arg_7_0, arg_7_1)
	arg_7_0.unLockController_:SetSelectedIndex(arg_7_1 and 1 or 0)
end

function var_0_0.RegistCallBack(arg_8_0, arg_8_1)
	arg_8_0.clickFunc_ = arg_8_1
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
