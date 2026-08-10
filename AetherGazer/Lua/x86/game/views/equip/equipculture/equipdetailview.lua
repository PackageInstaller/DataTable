local var_0_0 = class("EquipDetailView", EquipBaseView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.params_ = arg_1_3

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	var_0_0.super.Init(arg_2_0)

	arg_2_0.equipInfoView = EquipInfoView.New(arg_2_0.equipInfoGo_)

	arg_2_0.equipInfoView:RegisterSkillClick(handler(arg_2_0, arg_2_0.SkillClick))
	arg_2_0.equipInfoView:RegisterChange(handler(arg_2_0, arg_2_0.HidePop))
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btnSource_, nil, function()
		ShowPopItemSource(arg_4_0.equip_.prefab_id)
	end)
end

function var_0_0.RegistHeroButton(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.changeFunc_ = arg_6_1
	arg_6_0.cultureFunc_ = arg_6_2
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.heroViewProxy_ = arg_7_0.params_.proxy or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)

	arg_7_0.equipInfoView:OnEnter(arg_7_0.heroViewProxy_)
	arg_7_0:OnEquipChange(arg_7_0.params_.equipId)
end

function var_0_0.OnEquipChange(arg_8_0, arg_8_1)
	SetActive(arg_8_0.equipInfoGo_, false)

	arg_8_0.equipId = arg_8_1
	arg_8_0.equip_ = EquipData:GetEquipData(arg_8_0.equipId) or EquipStruct.New(0, arg_8_0.params_.prefabId)

	arg_8_0.equipInfoView:RefreshData(arg_8_0, arg_8_0.equip_, nil, arg_8_0.params_.heroId, arg_8_1)
	SetActive(arg_8_0.equipInfoGo_, true)
end

function var_0_0.SkillClick(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.handler_.RefreshSkillInfo then
		arg_9_0.handler_:RefreshSkillInfo(arg_9_1, arg_9_2)
	end
end

function var_0_0.HidePop(arg_10_0)
	if arg_10_0.handler_.HidePop then
		arg_10_0.handler_:HidePop()
	end
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.equipInfoView:Dispose()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
