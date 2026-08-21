local var_0_0 = class("NewSectionComboSkillView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Show(true)
	arg_1_0:Init()
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.heroItemList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.heroItemList_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitController()
	arg_4_0:InitCallback()

	arg_4_0.heroItemList_ = {}
end

function var_0_0.InitController(arg_5_0)
	arg_5_0.activeController_ = arg_5_0.controllerExCollection_:GetController("active")
	arg_5_0.stateController_ = arg_5_0.controllerExCollection_:GetController("state")
end

function var_0_0.InitCallback(arg_6_0)
	arg_6_0.selectComboSkillHandler_ = handler(arg_6_0, arg_6_0.OnComboSkillSelect)
end

function var_0_0.AddListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.btn_, nil, function()
		if not arg_7_0.sectionProxy_.canChangeComboSkill then
			ShowTips("CANNOT_CHANGE_COMBO_SKILL")

			return
		end

		arg_7_0:ClickComboSkillBtn()
	end)
end

function var_0_0.ClickComboSkillBtn(arg_9_0)
	JumpTools.OpenPageByJump("sectionComboSelect", {
		stageType = arg_9_0.sectionProxy_.stageType,
		stageID = arg_9_0.sectionProxy_.stageID,
		heroList = arg_9_0.sectionProxy_:GetHeroIDList(),
		trialList = arg_9_0.sectionProxy_:GetTrialIDList(),
		customComboSkillID = arg_9_0.sectionProxy_.customComboSkill,
		comboSkillID = arg_9_0.comboSkillID_,
		targetSectionProxy = arg_9_0.sectionProxy_
	})
end

function var_0_0.SetProxy(arg_10_0, arg_10_1)
	arg_10_0.sectionProxy_ = arg_10_1
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListener()
end

function var_0_0.AddEventListener(arg_12_0)
	arg_12_0:RegistEventListener(COMBO_SKILL_SELECT, arg_12_0.selectComboSkillHandler_)
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.Refresh(arg_14_0)
	arg_14_0.comboSkillID_ = arg_14_0:GetComboSkillID()

	arg_14_0:RefreshActive()

	if arg_14_0.sectionProxy_.needComboSkillPanel then
		arg_14_0:RefreshState()
	end
end

function var_0_0.GetComboSkillID(arg_15_0)
	return arg_15_0.sectionProxy_:GetComboSkillID()
end

function var_0_0.RefreshActive(arg_16_0)
	arg_16_0.activeController_:SetSelectedState(tostring(arg_16_0.sectionProxy_.needComboSkillPanel))
end

function var_0_0.RefreshState(arg_17_0)
	if arg_17_0.comboSkillID_ == 0 then
		arg_17_0.stateController_:SetSelectedState("unEquip")
	else
		arg_17_0.stateController_:SetSelectedState("equip")
		arg_17_0:RefreshEquipUI()
	end
end

function var_0_0.RefreshEquipUI(arg_18_0)
	local var_18_0 = ComboSkillCfg[arg_18_0.comboSkillID_]
	local var_18_1 = HeroSkillCfg[var_18_0.skill_id]

	arg_18_0.skillIcon_.sprite = getSpriteViaConfig("ComboSkill", var_18_0.skill_id)
	arg_18_0.titleText_.text = var_18_1.name

	for iter_18_0, iter_18_1 in ipairs(var_18_0.cooperate_role_ids) do
		if not arg_18_0.heroItemList_[iter_18_0] then
			local var_18_2 = Object.Instantiate(arg_18_0.heroItemGo_, arg_18_0.heroContentTrans_)

			arg_18_0.heroItemList_[iter_18_0] = SectionSmallHeroItem.New(var_18_2)
		end

		arg_18_0.heroItemList_[iter_18_0]:SetData(iter_18_1)
	end

	for iter_18_2 = #var_18_0.cooperate_role_ids + 1, 3 do
		if arg_18_0.heroItemList_[iter_18_2] then
			arg_18_0.heroItemList_[iter_18_2]:Show(false)
		end
	end
end

function var_0_0.GetCurComboSkill(arg_19_0)
	return arg_19_0.comboSkillID_ or 0
end

function var_0_0.Show(arg_20_0, arg_20_1)
	SetActive(arg_20_0.gameObject_, arg_20_1)
end

function var_0_0.OnComboSkillSelect(arg_21_0)
	arg_21_0:Refresh()
end

return var_0_0
