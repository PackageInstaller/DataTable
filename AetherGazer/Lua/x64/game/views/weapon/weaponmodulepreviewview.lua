local var_0_0 = class("WeaponModulePreviewView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_module/HeroModulePreviewPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.attributeItems_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.heroID_ = arg_7_0.params_.heroID

	local var_7_0 = WeaponModuleCfg[arg_7_0.params_.heroID]

	arg_7_0.nameText_.text = GetI18NText(var_7_0.name)
	arg_7_0.levelText_.text = HeroData:GetModuleMaxLevel(arg_7_0.heroID_)

	arg_7_0:RefreshDes()
end

function var_0_0.RefreshDes(arg_8_0)
	local var_8_0 = HeroData:GetAllModulePowersByHeroID(arg_8_0.heroID_)
	local var_8_1, var_8_2, var_8_3, var_8_4 = HeroTools.GetModuleAllDes(var_8_0, arg_8_0.heroID_, true)

	if var_8_1 == nil then
		SetActive(arg_8_0.attrGo_, false)
	else
		SetActive(arg_8_0.attrGo_, true)
		arg_8_0:RefreshAttriItems(var_8_1)
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.attrGo_.transform)
	end

	if var_8_2 == nil then
		SetActive(arg_8_0.skillGo_, false)
	else
		SetActive(arg_8_0.skillGo_, true)

		arg_8_0.skillText_.text = var_8_2

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.skillGo_.transform)
	end

	if var_8_3 == nil then
		SetActive(arg_8_0.astrolabeGo_, false)
	else
		SetActive(arg_8_0.astrolabeGo_, true)

		arg_8_0.astrolabeText_.text = var_8_3

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.astrolabeGo_.transform)
	end

	if var_8_4 == nil then
		SetActive(arg_8_0.servantGo_, false)
	else
		SetActive(arg_8_0.servantGo_, true)

		arg_8_0.servantText_.text = var_8_4

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.servantGo_.transform)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.contentTrans_)

	arg_8_0.contentTrans_.localPosition = Vector3.New(0, 0, 0)
end

function var_0_0.RefreshAttriItems(arg_9_0, arg_9_1)
	local var_9_0 = HeroTools.MergeModuleAttribute(arg_9_1)
	local var_9_1 = 1

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if arg_9_0.attributeItems_[var_9_1] == nil then
			local var_9_2 = GameObject.Instantiate(arg_9_0.attriItemGo_, arg_9_0.attriItemTrans_)

			arg_9_0.attributeItems_[var_9_1] = WeaponModuleAttributeItem.New(var_9_2)
		end

		arg_9_0.attributeItems_[var_9_1]:SetData(iter_9_0, iter_9_1)

		var_9_1 = var_9_1 + 1
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0.attributeItems_) do
		if iter_9_2 < var_9_1 then
			arg_9_0.attributeItems_[iter_9_2]:SetIsShow(true)
		else
			arg_9_0.attributeItems_[iter_9_2]:SetIsShow(false)
		end
	end
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.attributeItems_) do
		iter_10_1:Dispose()
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
