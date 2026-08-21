local var_0_0 = class("AstrolabeSuitDesItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "name")
	arg_3_0.spBgController_ = arg_3_0.messageControllerexcollection_:GetController("spShow")

	TerminologyTools.AddTerminologyHandler(arg_3_0, arg_3_0.text3Text_, nil, nil)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = HeroAstrolabeCfg[arg_4_1]

	arg_4_0.text2Text_.text = string.format("%s·%s", GetI18NText(var_4_0.suit_name), GetI18NText(var_4_0.name))

	local var_4_1 = GetI18NText(arg_4_0.heroViewProxy_:GetAstrolabeDesc(arg_4_1, arg_4_2.id))

	arg_4_0.text3Text_.text = var_4_1

	local var_4_2 = AstrolabeTools.GetAstrolabeItemPos(arg_4_1, arg_4_2.id)
	local var_4_3 = AstrolabeConst.NodeColorCfg

	arg_4_0.stateController_:SetSelectedState(var_4_3[var_4_2] or var_4_3[1])

	if HeroTools.IsSpHero(arg_4_2.id) then
		SetActive(arg_4_0.spDes_.gameObject, false)
		arg_4_0.spBgController_:SetSelectedState(var_4_0.astrolabe_type == 2 and "sp" or "notSp")
	else
		arg_4_0.nodeDes_.text = GetI18NText(GetTips("ASTROLABE_NODE_DESC_" .. var_4_0.pos))

		SetActive(arg_4_0.spDes_.gameObject, true)
		arg_4_0.spBgController_:SetSelectedState("notSp")
	end
end

function var_0_0.SetActive(arg_5_0, arg_5_1)
	if arg_5_0.gameObject_ then
		SetActive(arg_5_0.gameObject_, arg_5_1)
	end
end

function var_0_0.SetProxy(arg_6_0, arg_6_1)
	arg_6_0.heroViewProxy_ = arg_6_1
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
