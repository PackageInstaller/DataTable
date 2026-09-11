local AshBattlePrepareView = class("AshBattlePrepareView", ReduxView)

function AshBattlePrepareView:UIName()
	return "Widget/System/Activity_EkChuah/EkChuah_MainUI/Activity_EkChuah_StandbyUI"
end

function AshBattlePrepareView:GetCustomScene()
	return HeroRaiseTrackConst.CustomScene.Cowboy_Prepare
end

function AshBattlePrepareView:UIParent()
	return manager.ui.uiMain.transform
end

function AshBattlePrepareView:Init()
	self:InitUI()
	self:AddUIListener()

	self.weaponList = {
		AshILLWeaponModule.New(nil, self.wapon1Obj_, "PREPARE"),
		AshILLWeaponModule.New(nil, self.wapon2Obj_, "PREPARE"),
		(AshILLWeaponModule.New(nil, self.wapon3Obj_, "PREPARE"))
	}
	self.propList = {
		AshILLPropModule.New(nil, self.prop1Obj_, "PREPARE"),
		AshILLPropModule.New(nil, self.prop2Obj_, "PREPARE"),
		AshILLPropModule.New(nil, self.prop3Obj_, "PREPARE"),
		(AshILLPropModule.New(nil, self.prop4Obj_, "PREPARE"))
	}
	self.tabController = self.controller_:GetController("tabSwitch")
	self.skill1SelectController = self.skill1Controller_:GetController("select")
	self.skill2SelectController = self.skill2Controller_:GetController("select")
	self.skill1RecommendController = self.skill1Controller_:GetController("recommend")
	self.skill2RecommendController = self.skill2Controller_:GetController("recommend")
	self.skill1UnlockController = self.skill1Controller_:GetController("lock")
	self.skill2UnlockController = self.skill2Controller_:GetController("lock")
	self.skillTipController = self.maincontroller_:GetController("tips_skill")
	self.curSelectSkill = -1
end

function AshBattlePrepareView:InitUI()
	self:BindCfgUI()
end

function AshBattlePrepareView:AddUIListener()
	self:AddBtnListener(self.startBtn_, nil, function()
		local var_7_0 = {}

		if self.curSelectSkill ~= 0 then
			table.insert(var_7_0, AshSystemData:GetSkillList()[self.curSelectSkill].id)
		end

		local var_7_1 = {}
		local var_7_2 = {}

		for iter_7_0, iter_7_1 in ipairs((AshSystemData:GetPropList())) do
			if iter_7_1.unlockRate <= AshSystemData:GetHomologyRate() then
				table.insert(var_7_1, iter_7_1)
			end
		end

		for iter_7_2, iter_7_3 in ipairs((AshSystemData:GetWeaponList())) do
			if iter_7_3.unlockRate <= AshSystemData:GetHomologyRate() then
				table.insert(var_7_2, iter_7_3)
			end
		end

		saveData("ash", "selectSkill", self.curSelectSkill)
		AshSystemAction:LaunchBattle(self.levelId, var_7_0, var_7_1, var_7_2, false)
	end)
	self:AddBtnListener(self.weaponBtn_, nil, function()
		self:SwitchToWeapon()
	end)
	self:AddBtnListener(self.propBtn_, nil, function()
		self:SwitchToProp()
	end)
	self:AddBtnListener(self.skill1Btn_, nil, function()
		self:ClickSkill(1)
	end)
	self:AddBtnListener(self.skill2Btn_, nil, function()
		self:ClickSkill(2)
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:HideWeaponTip()
		self:HideSkillTip()
	end)
end

function AshBattlePrepareView:ClickSkill(arg_13_1, arg_13_2)
	if arg_13_1 ~= 0 then
		local var_13_0 = AshSystemData:GetSkillList()[arg_13_1]

		if not AshSystemData:GetSkillIsUnlock(var_13_0.id) then
			if var_13_0.unlockRate > AshSystemData:GetHomologyRate() then
				ShowTips(string.format(GetTips("ASH_UNLOCK_TIP"), var_13_0.unlockRate))
			end

			return
		end
	end

	self.curSelectSkill = arg_13_1

	self:RefreshSkillState(arg_13_2)
end

function AshBattlePrepareView:SwitchToWeapon()
	self.tabController:SetSelectedState("weapon")

	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs((AshSystemData:GetWeaponList())) do
		self.weaponList[iter_14_0]:Render(iter_14_1)
		self.weaponList[iter_14_0]:SetCallback(function(arg_15_0)
			self:HideWeaponTip(arg_15_0)
			self:HideSkillTip()
		end)

		var_14_0 = var_14_0 + 1
	end

	for iter_14_2 = var_14_0 + 1, 3 do
		self.weaponList[iter_14_2]:Render(nil)
	end
end

function AshBattlePrepareView:SwitchToProp()
	self.tabController:SetSelectedState("prop")

	local var_16_0 = 0

	for iter_16_0, iter_16_1 in ipairs((AshSystemData:GetPropList())) do
		self.propList[iter_16_0]:Render(iter_16_1)

		var_16_0 = var_16_0 + 1
	end

	for iter_16_2 = var_16_0 + 1, 4 do
		self.propList[iter_16_2]:Render(nil)
	end

	if self.propIndex and self.propIndex == 4 then
		self.scroll_.verticalNormalizedPosition = 0
		self.propIndex = nil
	end
end

function AshBattlePrepareView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self.skillTipController:SetSelectedIndex(0)

	self.stageId = self.params_.stageId
	self.levelId = self.params_.levelId

	local var_17_0 = false

	for iter_17_0, iter_17_1 in ipairs((AshSystemData:GetPropList())) do
		if iter_17_1.unlockRate <= AshSystemData:GetHomologyRate() and not getData("ash", "CowbotPropLock" .. "PREPARE" .. iter_17_1.id) then
			self.propIndex = iter_17_0
			var_17_0 = true
		end
	end

	if var_17_0 then
		self:SwitchToProp()
	else
		self:SwitchToWeapon()
	end

	local var_17_1 = AshShootStageCfg[self.levelId].recommend_skill
	local var_17_2 = AshSystemData:GetSkillList()

	self.skill1RecommendController:SetSelectedState("state0")
	self.skill2RecommendController:SetSelectedState("state0")

	if var_17_2[1] then
		self.skill1Icon_.sprite = pureGetSpriteWithoutAtlas(var_17_2[1].cfg.icon)
		self.skill1NameTxt_.text = GetI18NText(var_17_2[1].cfg.name)

		if var_17_1 == var_17_2[1] then
			self.skill1RecommendController:SetSelectedState("state1")
		end
	end

	if var_17_2[2] then
		self.skill2Icon_.sprite = pureGetSpriteWithoutAtlas(var_17_2[2].cfg.icon)
		self.skill2NameTxt_.text = GetI18NText(var_17_2[2].cfg.name)

		if var_17_1 == var_17_2[2] then
			self.skill2RecommendController:SetSelectedState("state1")
		end
	end

	local var_17_3 = 0

	if AshSystemData:GetSkillIsUnlock(var_17_2[1].id) then
		var_17_3 = 1
	end

	local var_17_4 = getData("ash", "selectSkill")

	self:ClickSkill((var_17_4 and var_17_4 ~= 0 and AshSystemData:GetSkillIsUnlock(var_17_2[var_17_4].id) or nil) and var_17_4, true)
	self:RenderSkillUnlock()
end

function AshBattlePrepareView:RefreshSkillState(arg_18_1)
	local var_18_0 = AshSystemData:GetSkillList()
	local var_18_1

	if self.curSelectSkill ~= 0 then
		var_18_1 = var_18_0[self.curSelectSkill]

		if not AshSystemData:GetSkillIsUnlock(var_18_0[self.curSelectSkill].id) then
			return
		end
	end

	if self.curSelectSkill == 1 then
		self.skill1SelectController:SetSelectedState("state1")
	else
		self.skill1SelectController:SetSelectedState("state0")
	end

	if self.curSelectSkill == 2 then
		self.skill2SelectController:SetSelectedState("state1")
	else
		self.skill2SelectController:SetSelectedState("state0")
	end

	if self.curSelectSkill ~= 0 and var_18_1 ~= nil then
		self.selectSkillIcon_.sprite = pureGetSpriteWithoutAtlas(var_18_1.cfg.icon)
		self.skillTitleText_.text = GetI18NText(var_18_1.cfg.name)
		self.skillDescText_.text = GetI18NText(var_18_1.cfg.desc)
	end

	if self.curSelectSkill == 0 or not AshSystemData:GetSkillIsUnlock(var_18_0[1].id) and not AshSystemData:GetSkillIsUnlock(var_18_0[2].id) then
		SetActive(self.skillObj_, false)
		SetActive(self.skillBgObj_, false)
		self.skillTipController:SetSelectedIndex(0)
	else
		SetActive(self.skillObj_, true)
		SetActive(self.skillBgObj_, true)

		if not arg_18_1 then
			self.skillTipController:SetSelectedIndex(1)
		else
			self.skillTipController:SetSelectedIndex(0)
		end
	end

	self:HideWeaponTip()
end

function AshBattlePrepareView:RenderSkillUnlock()
	local var_19_0 = "CowbotSkillLock2"
	local var_19_1 = AshSystemData:GetSkillList()

	if AshSystemData:GetSkillIsUnlock(var_19_1[1].id) then
		if not getData("ash", "CowbotSkillLock1") then
			saveData("ash", "CowbotSkillLock1", true)
			self.skill1Anim_:Play("skill_unlock", 0, 0)
		end

		self.skill1UnlockController:SetSelectedState("state0")
	else
		self.skill1UnlockController:SetSelectedState("state1")
	end

	if AshSystemData:GetSkillIsUnlock(var_19_1[2].id) then
		if not getData("ash", var_19_0) then
			saveData("ash", var_19_0, true)
			self.skill2Anim_:Play("skill_unlock", 0, 0)
		end

		self.skill2UnlockController:SetSelectedState("state0")
	else
		self.skill2UnlockController:SetSelectedState("state1")
	end
end

function AshBattlePrepareView:HideWeaponTip(arg_20_1)
	for iter_20_0 = 1, 3 do
		if self.weaponList[iter_20_0]:CheckID(arg_20_1) then
			self.weaponList[iter_20_0]:ShowTip(true)
		else
			self.weaponList[iter_20_0]:ShowTip(false)
		end
	end
end

function AshBattlePrepareView:HideSkillTip()
	self.skillTipController:SetSelectedIndex(0)
end

function AshBattlePrepareView:OnExit()
	manager.windowBar:HideBar()
end

function AshBattlePrepareView:Dispose()
	for iter_23_0, iter_23_1 in ipairs(self.propList) do
		iter_23_1:Dispose()
	end

	for iter_23_2, iter_23_3 in ipairs(self.weaponList) do
		iter_23_3:Dispose()
	end

	self.propList = nil
	self.weaponList = nil

	AshBattlePrepareView.super.Dispose(self)
end

return AshBattlePrepareView
