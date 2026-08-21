local var_0_0 = class("CultureGravureServantItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.btnController_ = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "statebtn")
	arg_2_0.stateController_ = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "statestar")
	arg_2_0.nameController_ = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "name")
	arg_2_0.recommendController_ = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "state")
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.index_ = arg_3_1
	arg_3_0.id_ = arg_3_2
	arg_3_0.heroID_ = arg_3_3
	arg_3_0.cfg_ = WeaponServantCfg[arg_3_0.id_]

	arg_3_0:RefreshUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.roleImg_.immediate = true
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.getBtn_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			arg_5_0.id_,
			"servant"
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.roleBtn_, nil, function()
		arg_5_0:Go("/showServantView", {
			state = "onlydetail",
			id = arg_5_0.id_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.equipBtn_, nil, function()
		CultureGravureAction.EquipByServantID(arg_5_0.heroID_, arg_5_0.id_)
	end)
end

function var_0_0.SetRecommendController(arg_9_0, arg_9_1)
	arg_9_0.recommendController_:SetSelectedState(arg_9_1)
end

function var_0_0.SetCallBack(arg_10_0, arg_10_1)
	arg_10_0.callback = arg_10_1
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.roleImg_.spriteSync = "TextureConfig/WeaponServant/Icon438x238/" .. arg_11_0.id_
	arg_11_0.nameText_.text = ItemTools.getItemName(arg_11_0.id_)

	arg_11_0.stateController_:SetSelectedState(arg_11_0.cfg_.starlevel)
	arg_11_0.nameController_:SetSelectedState(arg_11_0.cfg_.starlevel - 2 >= 1 and arg_11_0.cfg_.starlevel - 2 or 1)

	local var_11_0 = RaceEffectCfg[arg_11_0.cfg_.race]

	arg_11_0.raceImg_.sprite = getSprite("Atlas/SystemGroupAtlas", var_11_0.icon2)
	arg_11_0.raceText_.text = string.format(GetTips("CULTUREGRAVURE_RACE_DESC"), GetI18NText(var_11_0.name))

	arg_11_0:RefreshState()
end

function var_0_0.RefreshState(arg_12_0)
	local var_12_0 = CultureGravureData:GetHasServant(arg_12_0.id_)

	if CultureGravureData:GetServantIsEquipped(arg_12_0.heroID_, arg_12_0.id_) then
		arg_12_0.btnController_:SetSelectedState("equip")
	elseif var_12_0 then
		arg_12_0.btnController_:SetSelectedState("had")
	else
		arg_12_0.btnController_:SetSelectedState("get")
	end
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
