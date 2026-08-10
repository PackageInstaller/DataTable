local var_0_0 = class("WeaponModuleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_module/HeroModuleMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.moduleImage_.immediate = true
	arg_4_0.statusController_ = ControllerUtil.GetController(arg_4_0.viewTrans_, "status")
	arg_4_0.attributeItems_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.storyBtn_, nil, function()
		JumpTools.OpenPageByJump("/weaponModuleStoryView", {
			heroID = arg_5_0.heroID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("weaponModulePreviewView", {
			heroID = arg_5_0.heroID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.levelupBtn_, nil, function()
		JumpTools.OpenPageByJump("/weaponModuleLevelUpView", {
			heroID = arg_5_0.heroID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.getBtn_, nil, function()
		JumpTools.OpenPageByJump("/weaponModuleUnlockView", {
			heroID = arg_5_0.heroID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.astrolabeinfoBtn_, nil, function()
		local var_10_0
		local var_10_1 = arg_5_0:GetModuleLevel()

		if var_10_1 > 0 then
			var_10_0 = HeroData:GetCurModuleEffectListByType(arg_5_0.heroID_, 3, var_10_1)
		else
			var_10_0 = HeroData:GetLockModuleEffectListByType(arg_5_0.heroID_, 3)
		end

		JumpTools.OpenPageByJump("weaponModuleGodInfoView", {
			effectList = var_10_0,
			heroID = arg_5_0.heroID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.servantinfoBtn_, nil, function()
		local var_11_0
		local var_11_1 = arg_5_0:GetModuleLevel()

		if var_11_1 > 0 then
			var_11_0 = HeroData:GetCurModuleEffectListByType(arg_5_0.heroID_, 4, var_11_1)
		else
			var_11_0 = HeroData:GetLockModuleEffectListByType(arg_5_0.heroID_, 4)
		end

		JumpTools.OpenPageByJump("weaponModuleServantInfoView", {
			effectList = var_11_0,
			heroID = arg_5_0.heroID_
		})
	end)
end

function var_0_0.OnEnter(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("WEAPON_MODULE_DESCRIPE")

	arg_12_0.heroID_ = arg_12_0.params_.heroID

	arg_12_0:RefreshUI()
	arg_12_0:AddRedPoint()
end

function var_0_0.OnTop(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("WEAPON_MODULE_DESCRIPE")
end

function var_0_0.AddRedPoint(arg_14_0)
	local var_14_0 = RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. arg_14_0.heroID_

	manager.redPoint:bindUIandKey(arg_14_0.levelupBtn_.transform, var_14_0)
	manager.redPoint:bindUIandKey(arg_14_0.getBtn_.transform, var_14_0)
end

function var_0_0.GetModuleLevel(arg_15_0)
	return HeroData:GetCurModuleLevel(arg_15_0.heroID_)
end

function var_0_0.GetModuleMaxLevel(arg_16_0)
	return HeroData:GetModuleMaxLevel(arg_16_0.heroID_)
end

function var_0_0.GetEffectList(arg_17_0)
	return HeroTools:GetModulePowersByHeroIDAndLevel(arg_17_0.heroID_, arg_17_0:GetModuleLevel())
end

function var_0_0.RefreshUI(arg_18_0)
	arg_18_0.nameText_.text = GetI18NText(WeaponModuleCfg[arg_18_0.heroID_].name)

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_0.titleTrans_)

	arg_18_0.moduleImage_.spriteSync = "TextureConfig/WeaponModule/" .. arg_18_0.heroID_

	local var_18_0 = arg_18_0:GetModuleLevel()

	if var_18_0 == 0 then
		arg_18_0.statusController_:SetSelectedState("lock")

		arg_18_0.stateTips_.text = GetTips("WEAPON_MODULE_LOCK")
	else
		arg_18_0.stateTips_.text = GetTips("WEAPON_MODULE_UNLOCK")
		arg_18_0.levelText_.text = var_18_0

		if var_18_0 >= arg_18_0:GetModuleMaxLevel() then
			arg_18_0.statusController_:SetSelectedState("max")
		else
			arg_18_0.statusController_:SetSelectedState("unlock")
		end
	end

	arg_18_0:RefreshDes()
end

function var_0_0.RefreshDes(arg_19_0)
	local var_19_0 = arg_19_0:GetModuleLevel()
	local var_19_1

	if var_19_0 == 0 then
		var_19_1 = WeaponModuleCfg[arg_19_0.heroID_].skill[1]
	else
		var_19_1 = arg_19_0:GetEffectList()
	end

	local var_19_2, var_19_3, var_19_4, var_19_5 = HeroTools.GetModuleAllDes(var_19_1, arg_19_0.heroID_, true)

	if var_19_2 == nil then
		SetActive(arg_19_0.attrGo_, false)
	else
		SetActive(arg_19_0.attrGo_, true)
		arg_19_0:RefreshAttriItems(var_19_2)
		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.attrGo_.transform)
	end

	if var_19_3 == nil then
		SetActive(arg_19_0.skillGo_, false)
	else
		SetActive(arg_19_0.skillGo_, true)

		arg_19_0.skillText_.text = var_19_3

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.skillGo_.transform)
	end

	if var_19_4 == nil then
		SetActive(arg_19_0.astrolabeGo_, false)
	else
		SetActive(arg_19_0.astrolabeGo_, true)

		arg_19_0.astrolabeText_.text = var_19_4

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.astrolabeGo_.transform)
	end

	if var_19_5 == nil then
		SetActive(arg_19_0.servantGo_, false)
	else
		SetActive(arg_19_0.servantGo_, true)

		arg_19_0.servantText_.text = var_19_5

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.servantGo_.transform)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.contentTrans_)

	arg_19_0.contentTrans_.localPosition = Vector3.New(0, 0, 0)
end

function var_0_0.RefreshAttriItems(arg_20_0, arg_20_1)
	local var_20_0 = HeroTools.MergeModuleAttribute(arg_20_1)
	local var_20_1 = 1

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		if arg_20_0.attributeItems_[var_20_1] == nil then
			local var_20_2 = GameObject.Instantiate(arg_20_0.attriItemGo_, arg_20_0.attriItemTrans_)

			arg_20_0.attributeItems_[var_20_1] = WeaponModuleAttributeItem.New(var_20_2)
		end

		arg_20_0.attributeItems_[var_20_1]:SetData(iter_20_0, iter_20_1)

		var_20_1 = var_20_1 + 1
	end

	for iter_20_2, iter_20_3 in pairs(arg_20_0.attributeItems_) do
		if iter_20_2 < var_20_1 then
			arg_20_0.attributeItems_[iter_20_2]:SetIsShow(true)
		else
			arg_20_0.attributeItems_[iter_20_2]:SetIsShow(false)
		end
	end
end

function var_0_0.OnExit(arg_21_0)
	manager.windowBar:HideBar()
	arg_21_0:RemoveRedPoint()
end

function var_0_0.RemoveRedPoint(arg_22_0)
	local var_22_0 = RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. arg_22_0.heroID_

	manager.redPoint:unbindUIandKey(arg_22_0.levelupBtn_.transform, var_22_0)
	manager.redPoint:unbindUIandKey(arg_22_0.getBtn_.transform, var_22_0)
end

function var_0_0.Dispose(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.attributeItems_) do
		iter_23_1:Dispose()
	end

	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
