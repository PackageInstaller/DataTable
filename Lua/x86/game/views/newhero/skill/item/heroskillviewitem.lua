local var_0_0 = class("HeroSkillViewItem", ReduxView)
local var_0_1 = {
	selectState = {
		select = "true",
		name = "selectState",
		normal = "false"
	},
	upState = {
		up = "true",
		name = "upState",
		normal = "false"
	},
	nameAddState = {
		name = "nameAdd",
		add = "true",
		normal = "false"
	}
}

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:InitUI()
	arg_1_0:Init()
	arg_1_0:InitController()
end

function var_0_0.Init(arg_2_0)
	return
end

function var_0_0.InitController(arg_3_0)
	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController(var_0_1.selectState.name)
	arg_3_0.upController_ = arg_3_0.controllerEx_:GetController(var_0_1.upState.name)
	arg_3_0.addController_ = arg_3_0.controllerEx_:GetController(var_0_1.nameAddState.name)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddBtnListener(nil, nil, "OnClick")
end

function var_0_0.RefreshData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.info = arg_5_1

	if arg_5_0.upController_ then
		if not arg_5_0.heroViewDataProxy:CheckIsSelf() then
			arg_5_0.upController_:SetSelectedState(var_0_1.upState.normal)
		else
			local var_5_0 = arg_5_1.isCanStarUp or arg_5_1.isCanAttrUp

			if arg_5_2 and arg_5_2 == 1 then
				var_5_0 = arg_5_1.isCanStarUp
			elseif arg_5_2 and arg_5_2 == 2 then
				var_5_0 = arg_5_1.isCanAttrUp
			end

			arg_5_0.upController_:SetSelectedState(var_5_0 and var_0_1.upState.up or var_0_1.upState.normal)
		end
	end

	if arg_5_0.selectController_ then
		arg_5_0:UpdateSelectState(arg_5_0.handler_.selectSkillId == arg_5_1.id)
	end

	arg_5_0:RefreshUI(arg_5_1)
end

function var_0_0.UpdateSelectState(arg_6_0, arg_6_1)
	if arg_6_0.selectController_ then
		arg_6_0.selectController_:SetSelectedState(arg_6_1 and var_0_1.selectState.select or var_0_1.selectState.normal)
	end
end

function var_0_0.SetProxy(arg_7_0, arg_7_1)
	arg_7_0.heroViewDataProxy = arg_7_1
end

function var_0_0.RefreshUI(arg_8_0, arg_8_1)
	if arg_8_1 then
		local var_8_0 = arg_8_0.heroViewDataProxy:GetRealSkillId(arg_8_1.heroId, arg_8_1.id)
		local var_8_1 = HeroCfg[arg_8_1.heroId]
		local var_8_2 = table.indexof(var_8_1.skills, arg_8_1.id)
		local var_8_3 = HeroSkillCfg[var_8_0]

		arg_8_0.skilliconImg_.sprite = getSprite("Atlas/" .. arg_8_1.heroId, var_8_0)
		arg_8_0.nameText_.text = var_8_1.skill_subhead[var_8_2]

		arg_8_0:RefreshLv(arg_8_1)

		if arg_8_0.sliderSlr_ then
			local var_8_4 = arg_8_0.heroViewDataProxy:GetSkillAtrrProgressValue(arg_8_1.heroId, var_8_2)

			arg_8_0.sliderSlr_.value = var_8_4
		end
	end
end

function var_0_0.SetShowAdd(arg_9_0, arg_9_1)
	arg_9_0.showAdd_ = arg_9_1
end

function var_0_0.RefreshLv(arg_10_0, arg_10_1)
	if arg_10_0.lvText_ then
		local var_10_0 = arg_10_1.heroId
		local var_10_1 = arg_10_1.id
		local var_10_2 = arg_10_0.heroViewDataProxy:GetSkillLv(var_10_0, var_10_1) + (arg_10_1.tempAddLevel or 0)
		local var_10_3 = arg_10_1.addEquipSkillLv or 0

		if arg_10_0.showAdd_ then
			if var_10_3 > 0 or arg_10_1.addSkillLv > 0 then
				arg_10_0.lvText_.text = string.format("%d<color=#E78300>+%d</color>", var_10_2, arg_10_1.addSkillLv + var_10_3)
			else
				arg_10_0.lvText_.text = string.format("%d", var_10_2)
			end
		elseif var_10_3 > 0 or arg_10_1.addSkillLv > 0 then
			arg_10_0.lvText_.text = string.format("<color=#E78300>%d</color>", var_10_2 + arg_10_1.addSkillLv + var_10_3)
		else
			arg_10_0.lvText_.text = string.format("%d", var_10_2 + arg_10_1.addSkillLv + var_10_3)
		end

		arg_10_0.addController_:SetSelectedState(var_10_3 > 0 and var_0_1.nameAddState.add or var_0_1.nameAddState.normal)
	end
end

function var_0_0.RegistCallBack(arg_11_0, arg_11_1)
	arg_11_0.clickFunc = arg_11_1
end

function var_0_0.OnClick(arg_12_0)
	if arg_12_0.clickFunc then
		arg_12_0.clickFunc(arg_12_0.info)
	end
end

function var_0_0.SetAniState(arg_13_0, arg_13_1)
	if arg_13_0.animator_ then
		arg_13_0.animator_.enabled = arg_13_1
	end
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
