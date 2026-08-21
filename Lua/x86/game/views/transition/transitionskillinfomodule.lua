local var_0_0 = class("TransitionSkillSlotsModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.lvupBtnTxt_.text = GetTips("TEXT_UPGRADE")

	arg_3_0:BuildContext()
end

function var_0_0.BuildContext(arg_4_0)
	arg_4_0.controller = {
		comps = arg_4_0.controller_,
		btnState = {
			MaxLevel = "maxLevel",
			name = "btnState",
			Equip = "equip",
			Exchange = "exchange",
			comps = arg_4_0.controller_:GetController("btnState")
		}
	}
	arg_4_0.constVar = {}
	arg_4_0.data = {
		level = 0,
		skillID = 0,
		equipped = false,
		heroID = 0
	}
end

function var_0_0.InitContext(arg_5_0)
	arg_5_0.data = {
		level = 0,
		skillID = 0,
		equipped = false,
		heroID = 0
	}
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.equipBtn_, nil, function()
		arg_6_0:OnEquipBtnClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.exchangeBtn_, nil, function()
		arg_6_0:OnExchangeBtnClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.levelUpBtn_, nil, function()
		arg_6_0:OnLevelUpBtnClick()
	end)
	TerminologyTools.AddTerminologyHandler(arg_6_0, arg_6_0.chipEffectTxt_, nil, nil)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.RenderView(arg_11_0, arg_11_1)
	arg_11_0:InitContext()

	arg_11_0.data.heroID = arg_11_1.heroID
	arg_11_0.data.level = arg_11_1.level
	arg_11_0.data.skillID = arg_11_1.skillID
	arg_11_0.data.equipped = arg_11_1.equipped
	arg_11_0.data.pos = arg_11_1.pos

	local var_11_0 = EquipSkillCfg[arg_11_0.data.skillID]
	local var_11_1 = var_11_0.lvmax
	local var_11_2 = 1

	arg_11_0.skillNameTxt_.text = GetI18NText(var_11_0.name)
	arg_11_0.skillIconImg_.sprite = getEquipSkillSprite(arg_11_0.data.skillID)

	local var_11_3 = arg_11_0.controller.btnState

	if arg_11_0.data.equipped then
		var_11_2 = arg_11_0.data.level
		arg_11_0.skillStatusTxt_.text = GetTips("LEVEL") .. arg_11_0.data.level

		if var_11_2 < var_11_1 then
			var_11_3.comps:SetSelectedState(var_11_3.Exchange)
		else
			var_11_3.comps:SetSelectedState(var_11_3.MaxLevel)
		end
	else
		arg_11_0.skillStatusTxt_.text = GetTips("JUMP_EQUIP_NONE_STATUS")

		var_11_3.comps:SetSelectedState(var_11_3.Equip)
	end

	arg_11_0.chipEffectTxt_.text = EquipTools.GetSkillDescWithoutNext(arg_11_0.data.skillID, var_11_2, arg_11_0.data.heroID)

	if var_11_2 < var_11_1 then
		SetActive(arg_11_0.nextEffectObj_, true)

		arg_11_0.nextEffectTxt_.text = EquipTools.GetSkillDescWithoutNext(arg_11_0.data.skillID, var_11_2 + 1, arg_11_0.data.heroID)
	else
		SetActive(arg_11_0.nextEffectObj_, false)
	end
end

function var_0_0.RegisterEquipBtnClickEmitter(arg_12_0, arg_12_1)
	arg_12_0.constVar.onEquipEmitter = arg_12_1
end

function var_0_0.RegisterExchangeBtnClickEmitter(arg_13_0, arg_13_1)
	arg_13_0.constVar.onExchangeEmitter = arg_13_1
end

function var_0_0.RegisterLevelUpBtnClickEmitter(arg_14_0, arg_14_1)
	arg_14_0.constVar.onLevelUpEmitter = arg_14_1
end

function var_0_0.OnEquipBtnClick(arg_15_0)
	local var_15_0 = arg_15_0.constVar.onEquipEmitter

	if var_15_0 then
		var_15_0()
	end
end

function var_0_0.OnExchangeBtnClick(arg_16_0)
	local var_16_0 = arg_16_0.constVar.onExchangeEmitter

	if var_16_0 then
		var_16_0()
	end
end

function var_0_0.OnLevelUpBtnClick(arg_17_0)
	local var_17_0 = arg_17_0.constVar.onLevelUpEmitter

	if var_17_0 then
		var_17_0()
	end
end

return var_0_0
