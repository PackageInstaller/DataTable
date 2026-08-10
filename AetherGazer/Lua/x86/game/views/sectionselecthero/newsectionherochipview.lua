local var_0_0 = class("NewSectionHeroChipView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Show(true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.lockController_ = arg_3_0.controllerExCollection_:GetController("lock")
	arg_3_0.managerController_ = arg_3_0.controllerExCollection_:GetController("chipManager")
end

function var_0_0.AddListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.isLock_ then
			return
		end

		if arg_4_0.isCustom_ then
			ShowTips("CANNOT_CHANGE_CHIP")

			return
		end

		ChipAction:UpdateChipRed()
		arg_4_0:Go("/battleChipManager", {
			stageType = arg_4_0.stageType_,
			stageID = arg_4_0.stageID_,
			reserveParams = arg_4_0.reserveParams_
		})
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.stageType_ = arg_6_1
	arg_6_0.stageID_ = arg_6_2
	arg_6_0.reserveParams_ = arg_6_3
	arg_6_0.isCustom_ = false

	local var_6_0 = BattleStageTools.GetStageCfg(arg_6_1, arg_6_2)

	if var_6_0 and type(var_6_0.chip_list) == "table" then
		arg_6_0.isCustom_ = true
		arg_6_0.enabledID_ = var_6_0.chip_list[1]
		arg_6_0.chipList_ = {}

		for iter_6_0 = 2, 3 do
			arg_6_0.chipList_[iter_6_0 - 1] = var_6_0.chip_list[iter_6_0]
		end

		arg_6_0:RefreshUI()

		return
	end

	arg_6_0.enabledID_ = arg_6_0:GetChipManagerID()
	arg_6_0.chipList_ = arg_6_0:GetChipList()

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshLock()
	arg_7_0:RefreshChipManager()
	arg_7_0:RefreshChipList()
end

function var_0_0.RefreshLock(arg_8_0)
	arg_8_0.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER) == true

	arg_8_0.lockController_:SetSelectedState(tostring(arg_8_0.isLock_))
end

function var_0_0.RefreshChipManager(arg_9_0)
	local var_9_0 = arg_9_0.enabledID_ or 0

	if var_9_0 ~= 0 then
		arg_9_0.managerController_:SetSelectedState("true")

		arg_9_0.chipManagerIcon_.sprite = ChipTools.GetChipManagerIcon(var_9_0)
	else
		arg_9_0.managerController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshChipList(arg_10_0)
	local var_10_0 = arg_10_0.chipList_
	local var_10_1 = GameSetting.ai_secondary_chip_equip_num.value[1]

	if var_10_1 < #arg_10_0.chipList_ then
		for iter_10_0 = #arg_10_0.chipList_, var_10_1 + 1, -1 do
			arg_10_0.chipList_[iter_10_0] = nil
		end
	end

	for iter_10_1, iter_10_2 in ipairs(var_10_0) do
		if iter_10_2 == nil or iter_10_2 == 0 then
			break
		end

		SetActive(arg_10_0[string.format("chipIconGo_%s", iter_10_1)], true)

		if ChipCfg[iter_10_2] == nil then
			print(string.format("ChipCfg[%s] is nil", iter_10_2))
		end

		arg_10_0[string.format("chipIcon_%s", iter_10_1)].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[iter_10_2].picture_id)
	end

	for iter_10_3 = #var_10_0 + 1, var_10_1 do
		SetActive(arg_10_0[string.format("chipIconGo_%s", iter_10_3)], false)
	end
end

function var_0_0.GetChipManagerID(arg_11_0)
	return ReserveTools.GetMimirID(arg_11_0.reserveParams_)
end

function var_0_0.GetChipList(arg_12_0)
	return ReserveTools.GetMimirChipList(arg_12_0.reserveParams_)
end

function var_0_0.GetCurEnabledID(arg_13_0)
	return arg_13_0.enabledID_ or 0
end

function var_0_0.GetCurChipList(arg_14_0)
	return arg_14_0.chipList_ or {}
end

function var_0_0.Show(arg_15_0, arg_15_1)
	SetActive(arg_15_0.gameObject_, arg_15_1)
end

return var_0_0
