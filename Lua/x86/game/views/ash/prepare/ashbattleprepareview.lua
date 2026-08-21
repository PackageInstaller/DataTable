local var_0_0 = class("AshBattlePrepareView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_EkChuah/EkChuah_MainUI/Activity_EkChuah_StandbyUI"
end

function var_0_0.GetCustomScene(arg_2_0)
	return HeroRaiseTrackConst.CustomScene.Cowboy_Prepare
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.weaponList = {
		AshILLWeaponModule.New(nil, arg_4_0.wapon1Obj_, "PREPARE"),
		AshILLWeaponModule.New(nil, arg_4_0.wapon2Obj_, "PREPARE"),
		(AshILLWeaponModule.New(nil, arg_4_0.wapon3Obj_, "PREPARE"))
	}
	arg_4_0.propList = {
		AshILLPropModule.New(nil, arg_4_0.prop1Obj_, "PREPARE"),
		AshILLPropModule.New(nil, arg_4_0.prop2Obj_, "PREPARE"),
		AshILLPropModule.New(nil, arg_4_0.prop3Obj_, "PREPARE"),
		(AshILLPropModule.New(nil, arg_4_0.prop4Obj_, "PREPARE"))
	}
	arg_4_0.tabController = arg_4_0.controller_:GetController("tabSwitch")
	arg_4_0.skill1SelectController = arg_4_0.skill1Controller_:GetController("select")
	arg_4_0.skill2SelectController = arg_4_0.skill2Controller_:GetController("select")
	arg_4_0.skill1RecommendController = arg_4_0.skill1Controller_:GetController("recommend")
	arg_4_0.skill2RecommendController = arg_4_0.skill2Controller_:GetController("recommend")
	arg_4_0.skill1UnlockController = arg_4_0.skill1Controller_:GetController("lock")
	arg_4_0.skill2UnlockController = arg_4_0.skill2Controller_:GetController("lock")
	arg_4_0.skillTipController = arg_4_0.maincontroller_:GetController("tips_skill")
	arg_4_0.curSelectSkill = -1
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.startBtn_, nil, function()
		local var_7_0 = AshSystemData:GetSkillList()
		local var_7_1 = {}

		if arg_6_0.curSelectSkill ~= 0 then
			table.insert(var_7_1, var_7_0[arg_6_0.curSelectSkill].id)
		end

		local var_7_2 = {}
		local var_7_3 = {}
		local var_7_4 = AshSystemData:GetPropList()

		for iter_7_0, iter_7_1 in ipairs(var_7_4) do
			if iter_7_1.unlockRate <= AshSystemData:GetHomologyRate() then
				table.insert(var_7_2, iter_7_1)
			end
		end

		local var_7_5 = AshSystemData:GetWeaponList()

		for iter_7_2, iter_7_3 in ipairs(var_7_5) do
			if iter_7_3.unlockRate <= AshSystemData:GetHomologyRate() then
				table.insert(var_7_3, iter_7_3)
			end
		end

		saveData("ash", "selectSkill", arg_6_0.curSelectSkill)
		AshSystemAction:LaunchBattle(arg_6_0.levelId, var_7_1, var_7_2, var_7_3, false)
	end)
	arg_6_0:AddBtnListener(arg_6_0.weaponBtn_, nil, function()
		arg_6_0:SwitchToWeapon()
	end)
	arg_6_0:AddBtnListener(arg_6_0.propBtn_, nil, function()
		arg_6_0:SwitchToProp()
	end)
	arg_6_0:AddBtnListener(arg_6_0.skill1Btn_, nil, function()
		arg_6_0:ClickSkill(1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.skill2Btn_, nil, function()
		arg_6_0:ClickSkill(2)
	end)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:HideWeaponTip()
		arg_6_0:HideSkillTip()
	end)
end

function var_0_0.ClickSkill(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 ~= 0 then
		local var_13_0 = AshSystemData:GetSkillList()[arg_13_1]

		if not AshSystemData:GetSkillIsUnlock(var_13_0.id) then
			local var_13_1 = var_13_0.unlockRate

			if var_13_1 > AshSystemData:GetHomologyRate() then
				ShowTips(string.format(GetTips("ASH_UNLOCK_TIP"), var_13_1))
			end

			return
		end
	end

	arg_13_0.curSelectSkill = arg_13_1

	arg_13_0:RefreshSkillState(arg_13_2)
end

function var_0_0.SwitchToWeapon(arg_14_0)
	arg_14_0.tabController:SetSelectedState("weapon")

	local var_14_0 = AshSystemData:GetWeaponList()
	local var_14_1 = 0

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		arg_14_0.weaponList[iter_14_0]:Render(iter_14_1)
		arg_14_0.weaponList[iter_14_0]:SetCallback(function(arg_15_0)
			arg_14_0:HideWeaponTip(arg_15_0)
			arg_14_0:HideSkillTip()
		end)

		var_14_1 = var_14_1 + 1
	end

	for iter_14_2 = var_14_1 + 1, 3 do
		arg_14_0.weaponList[iter_14_2]:Render(nil)
	end
end

function var_0_0.SwitchToProp(arg_16_0)
	arg_16_0.tabController:SetSelectedState("prop")

	local var_16_0 = AshSystemData:GetPropList()
	local var_16_1 = 0

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		arg_16_0.propList[iter_16_0]:Render(iter_16_1)

		var_16_1 = var_16_1 + 1
	end

	for iter_16_2 = var_16_1 + 1, 4 do
		arg_16_0.propList[iter_16_2]:Render(nil)
	end

	if arg_16_0.propIndex and arg_16_0.propIndex == 4 then
		arg_16_0.scroll_.verticalNormalizedPosition = 0
		arg_16_0.propIndex = nil
	end
end

function var_0_0.OnEnter(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_17_0.skillTipController:SetSelectedIndex(0)

	arg_17_0.stageId = arg_17_0.params_.stageId
	arg_17_0.levelId = arg_17_0.params_.levelId

	local var_17_0 = AshSystemData:GetPropList()
	local var_17_1 = false

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if iter_17_1.unlockRate <= AshSystemData:GetHomologyRate() then
			local var_17_2 = "CowbotPropLock" .. "PREPARE" .. iter_17_1.id

			if not getData("ash", var_17_2) then
				arg_17_0.propIndex = iter_17_0
				var_17_1 = true
			end
		end
	end

	if var_17_1 then
		arg_17_0:SwitchToProp()
	else
		arg_17_0:SwitchToWeapon()
	end

	local var_17_3 = AshShootStageCfg[arg_17_0.levelId].recommend_skill
	local var_17_4 = AshSystemData:GetSkillList()

	arg_17_0.skill1RecommendController:SetSelectedState("state0")
	arg_17_0.skill2RecommendController:SetSelectedState("state0")

	if var_17_4[1] then
		arg_17_0.skill1Icon_.sprite = pureGetSpriteWithoutAtlas(var_17_4[1].cfg.icon)
		arg_17_0.skill1NameTxt_.text = GetI18NText(var_17_4[1].cfg.name)

		if var_17_3 == var_17_4[1] then
			arg_17_0.skill1RecommendController:SetSelectedState("state1")
		end
	end

	if var_17_4[2] then
		arg_17_0.skill2Icon_.sprite = pureGetSpriteWithoutAtlas(var_17_4[2].cfg.icon)
		arg_17_0.skill2NameTxt_.text = GetI18NText(var_17_4[2].cfg.name)

		if var_17_3 == var_17_4[2] then
			arg_17_0.skill2RecommendController:SetSelectedState("state1")
		end
	end

	local var_17_5 = 0

	if AshSystemData:GetSkillIsUnlock(var_17_4[1].id) then
		var_17_5 = 1
	end

	local var_17_6 = getData("ash", "selectSkill")

	if var_17_6 and var_17_6 ~= 0 and AshSystemData:GetSkillIsUnlock(var_17_4[var_17_6].id) then
		var_17_5 = var_17_6
	end

	arg_17_0:ClickSkill(var_17_5, true)
	arg_17_0:RenderSkillUnlock()
end

function var_0_0.RefreshSkillState(arg_18_0, arg_18_1)
	local var_18_0 = AshSystemData:GetSkillList()
	local var_18_1

	if arg_18_0.curSelectSkill ~= 0 then
		var_18_1 = var_18_0[arg_18_0.curSelectSkill]

		if not AshSystemData:GetSkillIsUnlock(var_18_1.id) then
			return
		end
	end

	if arg_18_0.curSelectSkill == 1 then
		arg_18_0.skill1SelectController:SetSelectedState("state1")
	else
		arg_18_0.skill1SelectController:SetSelectedState("state0")
	end

	if arg_18_0.curSelectSkill == 2 then
		arg_18_0.skill2SelectController:SetSelectedState("state1")
	else
		arg_18_0.skill2SelectController:SetSelectedState("state0")
	end

	if arg_18_0.curSelectSkill ~= 0 and var_18_1 ~= nil then
		arg_18_0.selectSkillIcon_.sprite = pureGetSpriteWithoutAtlas(var_18_1.cfg.icon)
		arg_18_0.skillTitleText_.text = GetI18NText(var_18_1.cfg.name)
		arg_18_0.skillDescText_.text = GetI18NText(var_18_1.cfg.desc)
	end

	if arg_18_0.curSelectSkill == 0 or not AshSystemData:GetSkillIsUnlock(var_18_0[1].id) and not AshSystemData:GetSkillIsUnlock(var_18_0[2].id) then
		SetActive(arg_18_0.skillObj_, false)
		SetActive(arg_18_0.skillBgObj_, false)
		arg_18_0.skillTipController:SetSelectedIndex(0)
	else
		SetActive(arg_18_0.skillObj_, true)
		SetActive(arg_18_0.skillBgObj_, true)

		if not arg_18_1 then
			arg_18_0.skillTipController:SetSelectedIndex(1)
		else
			arg_18_0.skillTipController:SetSelectedIndex(0)
		end
	end

	arg_18_0:HideWeaponTip()
end

function var_0_0.RenderSkillUnlock(arg_19_0)
	local var_19_0 = "CowbotSkillLock1"
	local var_19_1 = "CowbotSkillLock2"
	local var_19_2 = AshSystemData:GetSkillList()

	if AshSystemData:GetSkillIsUnlock(var_19_2[1].id) then
		if not getData("ash", var_19_0) then
			saveData("ash", var_19_0, true)
			arg_19_0.skill1Anim_:Play("skill_unlock", 0, 0)
		end

		arg_19_0.skill1UnlockController:SetSelectedState("state0")
	else
		arg_19_0.skill1UnlockController:SetSelectedState("state1")
	end

	if AshSystemData:GetSkillIsUnlock(var_19_2[2].id) then
		if not getData("ash", var_19_1) then
			saveData("ash", var_19_1, true)
			arg_19_0.skill2Anim_:Play("skill_unlock", 0, 0)
		end

		arg_19_0.skill2UnlockController:SetSelectedState("state0")
	else
		arg_19_0.skill2UnlockController:SetSelectedState("state1")
	end
end

function var_0_0.HideWeaponTip(arg_20_0, arg_20_1)
	for iter_20_0 = 1, 3 do
		if arg_20_0.weaponList[iter_20_0]:CheckID(arg_20_1) then
			arg_20_0.weaponList[iter_20_0]:ShowTip(true)
		else
			arg_20_0.weaponList[iter_20_0]:ShowTip(false)
		end
	end
end

function var_0_0.HideSkillTip(arg_21_0)
	arg_21_0.skillTipController:SetSelectedIndex(0)
end

function var_0_0.OnExit(arg_22_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0.propList) do
		iter_23_1:Dispose()
	end

	for iter_23_2, iter_23_3 in ipairs(arg_23_0.weaponList) do
		iter_23_3:Dispose()
	end

	arg_23_0.propList = nil
	arg_23_0.weaponList = nil

	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
