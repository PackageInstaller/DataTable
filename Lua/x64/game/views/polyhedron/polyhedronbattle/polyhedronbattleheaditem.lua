local var_0_0 = class("polyhedronBattleHeadItem", ReduxView)

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

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 == 0 then
		arg_4_0.stateController:SetSelectedIndex(4)
	else
		local var_4_0 = arg_4_1:GetLeaderHeroId()

		if arg_4_1:GetHeroPolyData(arg_4_2):IsDead() then
			arg_4_0.stateController:SetSelectedIndex(2)
		elseif var_4_0 == arg_4_2 then
			arg_4_0.stateController:SetSelectedIndex(1)
		else
			arg_4_0.stateController:SetSelectedIndex(0)
		end

		local var_4_1 = HeroData:GetHeroBattleUsingSkinInfo(arg_4_2).id

		arg_4_0.m_icon.sprite = getSpriteViaConfig("HeroLittleIcon", var_4_1)
	end
end

return var_0_0
