local var_0_0 = class("SectionComboSelectItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.heroItemList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.heroItemList_ = nil
	arg_2_0.chooseCallback_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateController_ = arg_4_0.controllerExCollection_:GetController("state")
	arg_4_0.selectController_ = arg_4_0.btnControllerExCollection_:GetController("select")
	arg_4_0.heroItemList_ = {}
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.buttonSelect_, nil, function()
		if arg_5_0.comboSkillID_ ~= 0 and not arg_5_0.canUse_ then
			return
		end

		arg_5_0.chooseCallback_(arg_5_0.comboSkillID_)
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.descBtn_, nil, function()
		if arg_5_0.comboSkillID_ == 0 then
			return
		end

		arg_5_0:SwitchDescDisplay()
	end)
end

function var_0_0.RegistChooseCallback(arg_8_0, arg_8_1)
	arg_8_0.chooseCallback_ = arg_8_1
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	arg_9_0:Show(true)

	arg_9_0.stageType_ = arg_9_1
	arg_9_0.stageID_ = arg_9_2
	arg_9_0.comboSkillID_ = arg_9_3
	arg_9_0.isSelect_ = arg_9_4
	arg_9_0.heroList_ = arg_9_5
	arg_9_0.canUse_ = arg_9_0:CanUse()

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = arg_10_0.comboSkillID_ == 0

	if not var_10_0 then
		arg_10_0:RefreshInfo()
	end

	arg_10_0.isOpeningDesc_ = false

	arg_10_0:UpdateDescVisibe()
	arg_10_0.stateController_:SetSelectedState(tostring(not var_10_0))
	arg_10_0:RefreshSelect()
end

function var_0_0.Show(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

function var_0_0.CanUse(arg_12_0)
	if arg_12_0.comboSkillID_ == 0 then
		return true
	end

	local var_12_0 = ComboSkillCfg[arg_12_0.comboSkillID_]

	for iter_12_0, iter_12_1 in ipairs(var_12_0.cooperate_role_ids) do
		if not table.keyof(arg_12_0.heroList_, iter_12_1) then
			return false
		end
	end

	return true
end

function var_0_0.RefreshInfo(arg_13_0)
	local var_13_0 = ComboSkillCfg[arg_13_0.comboSkillID_]
	local var_13_1 = HeroSkillCfg[var_13_0.skill_id]
	local var_13_2 = ComboSkillData:GetCurComboSkillLevel(arg_13_0.comboSkillID_)

	arg_13_0.textLv_.text = GetTips("LEVEL") .. string.format("%s", var_13_2)
	arg_13_0.titleText_.text = GetI18NText(var_13_1.name)
	arg_13_0.skillIcon.sprite = getSpriteViaConfig("ComboSkill", var_13_0.skill_id)

	local var_13_3 = deepClone(var_13_0.cooperate_role_ids)

	CommonTools.UniversalSortEx(var_13_3, {
		ascend = true,
		map = function(arg_14_0)
			return arg_14_0
		end
	})

	for iter_13_0, iter_13_1 in ipairs(var_13_3) do
		if not arg_13_0.heroItemList_[iter_13_0] then
			local var_13_4 = Object.Instantiate(arg_13_0.heroItemGo_, arg_13_0.heroContentTrans_)

			arg_13_0.heroItemList_[iter_13_0] = SectionSmallHeroItem.New(var_13_4)
		end

		arg_13_0.heroItemList_[iter_13_0]:SetData(iter_13_1)
		arg_13_0.heroItemList_[iter_13_0]:RefreshValid(table.keyof(arg_13_0.heroList_, iter_13_1) ~= nil)
	end

	for iter_13_2 = #var_13_0.cooperate_role_ids + 1, 3 do
		if arg_13_0.heroItemList_[iter_13_2] then
			arg_13_0.heroItemList_[iter_13_2]:Show(false)
		end
	end
end

function var_0_0.RefreshSelect(arg_15_0)
	if arg_15_0.canUse_ then
		if arg_15_0.isSelect_ then
			arg_15_0.selectController_:SetSelectedState("true")
		else
			arg_15_0.selectController_:SetSelectedState("false")
		end
	else
		arg_15_0.selectController_:SetSelectedState("none")
	end
end

function var_0_0.UpdateDesc(arg_16_0)
	local var_16_0 = ComboSkillCfg[arg_16_0.comboSkillID_]
	local var_16_1 = HeroSkillCfg[var_16_0.skill_id]
	local var_16_2 = ComboSkillData:GetCurComboSkillLevel(arg_16_0.comboSkillID_)

	arg_16_0.descText_.text = GetI18NText(GetCfgDescription(var_16_1.desc[1], var_16_2, 2, var_16_0.maxLevel))
end

function var_0_0.SwitchDescDisplay(arg_17_0)
	arg_17_0.isOpeningDesc_ = not arg_17_0.isOpeningDesc_

	if arg_17_0.isOpeningDesc_ then
		arg_17_0:UpdateDesc()
	end

	arg_17_0:UpdateDescVisibe()
end

function var_0_0.UpdateDescVisibe(arg_18_0)
	SetActive(arg_18_0.descGo_, arg_18_0.isOpeningDesc_)
end

return var_0_0
