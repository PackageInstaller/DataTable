local var_0_0 = class("HellaPinballHeroView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Hel/Activity_Hel_Main/Activity_Hel_HeroUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.activeSkillUIList_ = LuaList.New(handler(arg_4_0, arg_4_0.OnCreateActiveSkillItem), arg_4_0.activeSkillListGo_, HellaPinballActiveSkillItem)
	arg_4_0.passiveSkillUIList_ = LuaList.New(handler(arg_4_0, arg_4_0.OnCreatePassiveSkillItem), arg_4_0.passiveSkillListGo_, HellaPinballPassiveSkillItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		SetActive(arg_5_0.maskBtn_.gameObject, false)

		for iter_6_0, iter_6_1 in ipairs(arg_5_0.passiveSkillUIList_:GetItemList()) do
			iter_6_1:SetSelectedState("off")
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.selectRole_ = arg_7_0.params_.roleID
	arg_7_0.selectTypeTab_ = 1

	arg_7_0:UpdateData()
	arg_7_0:RefreshUI()
end

function var_0_0.UpdateData(arg_8_0)
	arg_8_0.activityID_ = PinballData:GetActivityID()
	arg_8_0.level_ = PinballData:GetRoleLevel(arg_8_0.selectRole_)
	arg_8_0.currentHp_ = PinballTools.CalcRoleProp(arg_8_0.selectRole_, 1)
	arg_8_0.currentAtk_ = PinballTools.CalcRoleProp(arg_8_0.selectRole_, 2)
	arg_8_0.maxHp_ = PinballData:GetRoleMaxAttributes(arg_8_0.selectRole_)[1]
	arg_8_0.maxAtk_ = PinballData:GetRoleMaxAttributes(arg_8_0.selectRole_)[2]
	arg_8_0.activeSkillList_ = PinballSkillCfg.get_id_list_by_activity_id_skill_type[arg_8_0.activityID_][1]
	arg_8_0.passiveSkillList_ = PinballData:GetPassiveSkillList()

	arg_8_0.activeSkillUIList_:StartScroll(#arg_8_0.activeSkillList_)
	arg_8_0.passiveSkillUIList_:StartScroll(#arg_8_0.passiveSkillList_)
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.levelText_.text = string.format(GetTips("DORM_LEVEL_TIPS"), arg_9_0.level_)
	arg_9_0.hpText_.text = arg_9_0.currentHp_
	arg_9_0.atkText_.text = arg_9_0.currentAtk_
	arg_9_0.hpSlider_.value = 1
	arg_9_0.atkSlider_.value = 1

	local var_9_0 = "<color=#FFFFFF>"

	if #PinballData:GetEquipedActiveSkill() == 2 then
		var_9_0 = "<color=#C5AE65>"
	end

	arg_9_0.equipNumText_.text = var_9_0 .. #PinballData:GetEquipedActiveSkill() .. "/2</color>"
end

function var_0_0.OnCreateActiveSkillItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, arg_10_0.activeSkillList_[arg_10_1])
end

function var_0_0.OnCreatePassiveSkillItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_1, arg_11_0.passiveSkillList_[arg_11_1])
	arg_11_2:SetClickCallBack(handler(arg_11_0, arg_11_0.OnClickPassiveSkill))
end

function var_0_0.OnClickPassiveSkill(arg_12_0, arg_12_1)
	SetActive(arg_12_0.maskBtn_.gameObject, true)

	arg_12_0.selectPassiveSkillIndex_ = arg_12_1
end

function var_0_0.OnTop(arg_13_0)
	arg_13_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_14_0:Back()
		PinballBridge.PlayTimelineWithCallBack("skill_stand_home", function()
			PinballBridge.SetPlayerAniState("home_stand")
		end)
	end)
	manager.windowBar:RegistInfoCallBack(function()
		local var_17_0 = GetTips("PINBALLGAME_GAME_ENTRANCE_TITLE")

		JumpTools.OpenPageByJump("gameHelp", {
			title = GetTips("STAGE_DESCRIPE"),
			content = var_17_0
		})
	end)
end

function var_0_0.OnHellaPinballEquipSkill(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.activeSkillUIList_:GetItemList()) do
		iter_18_1:UpdateData()
		iter_18_1:RefreshUI()
	end

	arg_18_0:RefreshUI()
end

function var_0_0.OnExit(arg_19_0)
	TimelineTools.StopAllCallBack()
	SetActive(arg_19_0.maskBtn_.gameObject, false)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.activeSkillUIList_ then
		arg_20_0.activeSkillUIList_:Dispose()

		arg_20_0.activeSkillUIList_ = nil
	end

	if arg_20_0.passiveSkillUIList_ then
		arg_20_0.passiveSkillUIList_:Dispose()

		arg_20_0.passiveSkillUIList_ = nil
	end

	arg_20_0.super.Dispose(arg_20_0)
	TimelineTools.StopAllCallBack()
end

return var_0_0
