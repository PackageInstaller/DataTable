local var_0_0 = class("StrongholdSkillInfoItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController = ControllerUtil.GetController(arg_3_0.transform_, "select")
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.selectController:SetSelectedIndex(arg_4_2)

	for iter_4_0 = 1, 3 do
		local var_4_0 = StrongholdData:GetSkillAffix(arg_4_1, iter_4_0)

		if iter_4_0 == 1 then
			arg_4_0.m_name.text = getAffixName(var_4_0)
		end

		arg_4_0["m_skillText" .. iter_4_0].text = getAffixDesc(var_4_0)
	end

	arg_4_0.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdSkill/" .. arg_4_1)
end

return var_0_0
