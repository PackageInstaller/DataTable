local var_0_0 = class("AstrolabeInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "name")
	arg_3_0.spBgController_ = arg_3_0.messageControllerexcollection_:GetController("spShow")
end

function var_0_0.AddUIListener(arg_4_0)
	TerminologyTools.AddTerminologyHandler(arg_4_0, arg_4_0.text3Text_, nil, nil)
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1)
	if arg_5_1 then
		local var_5_0 = HeroAstrolabeCfg[arg_5_1.id]

		arg_5_0.text2Text_.text = string.format("%s·%s", GetI18NText(var_5_0.suit_name), GetI18NText(var_5_0.name))
		arg_5_0.text3Text_.text = GetI18NText(arg_5_0.heroViewProxy_:GetAstrolabeDesc(arg_5_1.id, arg_5_1.heroId))

		local var_5_1 = AstrolabeTools.GetAstrolabeItemPos(arg_5_1.id, arg_5_1.heroId)
		local var_5_2 = AstrolabeConst.NodeColorCfg

		arg_5_0.stateController_:SetSelectedState(var_5_2[var_5_1] or var_5_2[1])

		if HeroTools.IsSpHero(arg_5_1.heroId) then
			SetActive(arg_5_0.spDes_, false)
			arg_5_0.spBgController_:SetSelectedState(var_5_0.astrolabe_type == 2 and "sp" or "notSp")
		else
			arg_5_0.nodeDes_.text = GetI18NText(GetTips("ASTROLABE_NODE_DESC_" .. var_5_0.pos))

			SetActive(arg_5_0.spDes_, true)
			arg_5_0.spBgController_:SetSelectedState("notSp")
		end
	end
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.SetProxy(arg_8_0, arg_8_1)
	arg_8_0.heroViewProxy_ = arg_8_1
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
