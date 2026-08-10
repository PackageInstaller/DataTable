local var_0_0 = class("HeroSkillItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.data_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.info_ = arg_1_3

	arg_1_0:InitUI()
	arg_1_0:Init()
end

function var_0_0.RefreshData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.data_ = arg_2_1
	arg_2_0.info_ = arg_2_2
	arg_2_0.heroViewProxy_ = arg_2_3

	arg_2_0:Render()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddBtnListener(nil, nil, "OnClick")
end

function var_0_0.Init(arg_4_0)
	return
end

function var_0_0.Render(arg_5_0)
	arg_5_0:RefreshUI(arg_5_0.info_)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	if arg_6_1 then
		local var_6_0 = arg_6_0:GetRealSkillId(arg_6_1)
		local var_6_1 = HeroSkillCfg[var_6_0]

		arg_6_0.iconImg_.sprite = getSprite("Atlas/" .. arg_6_1.heroId, var_6_0)
		arg_6_0.nameText_.text = GetI18NText(var_6_1.name)

		SetActive(arg_6_0.upGo_, arg_6_1.isCanUp)
		arg_6_0:RefreshLv(arg_6_1)

		local var_6_2 = HeroCfg[arg_6_1.heroId]
		local var_6_3 = table.indexof(var_6_2.skills, arg_6_1.id)

		arg_6_0.subnameText_.text = GetI18NText(var_6_2.skill_subhead[var_6_3])
	end
end

function var_0_0.RefreshLv(arg_7_0, arg_7_1)
	local var_7_0 = 0
	local var_7_1 = arg_7_0.heroViewProxy_:GetTransitionAddLevel(arg_7_1.heroId)

	if var_7_1 <= 0 then
		arg_7_0.lvText_.text = string.format("%d", arg_7_1.lv + arg_7_1.addSkillLv)
	else
		arg_7_0.lvText_.text = string.format("<color=#F3DC5A>%d</color>", arg_7_1.lv + arg_7_1.addSkillLv + var_7_1)
	end
end

function var_0_0.GetRealSkillId(arg_8_0, arg_8_1)
	return arg_8_0.heroViewProxy_:GetRealSkillId(arg_8_1.heroId, arg_8_1.id)
end

function var_0_0.OnClick(arg_9_0)
	if arg_9_0.clickFunc then
		arg_9_0.clickFunc(arg_9_0.info_)
	end
end

function var_0_0.RegistCallBack(arg_10_0, arg_10_1)
	arg_10_0.clickFunc = arg_10_1
end

function var_0_0.GetItemInfo(arg_11_0)
	return arg_11_0.info_
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
