local var_0_0 = class("HeroTrustGiftDisplaceHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.favorabilityController = ControllerUtil.GetController(arg_3_0.transform_, "favorability")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.roleImg_.sprite = getSpriteViaConfig("HeroItemshead", arg_5_1)
	arg_5_0.nameText_.text = HeroCfg[arg_5_1].name

	local var_5_0 = ArchiveData:GetTrustLevel(arg_5_1)

	if var_5_0 > 0 then
		arg_5_0.favorabilityController:SetSelectedIndex(1)

		arg_5_0.favorExText_.text = ArchiveTools.GetTrustLvDes(var_5_0)
	else
		arg_5_0.favorabilityController:SetSelectedIndex(0)

		arg_5_0.favorExText_.text = GetTipsF("HERO_TRUST_DISPLACE_LOVE", ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[arg_5_1][1]).lv)
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
