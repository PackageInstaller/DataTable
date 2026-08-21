local var_0_0 = class("NewSectionMimirView", ReduxView)

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

	arg_3_0.activeController_ = arg_3_0.controllerExCollection_:GetController("active")
	arg_3_0.chipPanelController_ = arg_3_0.chipPanelConEx_:GetController("chipPanel")
	arg_3_0.riseController_ = arg_3_0.charChipConEx_:GetController("rise")
end

function var_0_0.AddListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.isLock_ then
			return
		end

		if not arg_4_0.sectionProxy_.canChangeMimir then
			ShowTips("CANNOT_CHANGE_CHIP")

			return
		end

		ChipAction:UpdateChipRed()

		if arg_4_0.sectionProxy_:IsUseMimirChip() then
			arg_4_0:Go("/adminSelectChip", {
				isMimir = true,
				isFroming = true,
				selectID = arg_4_0.mimirID_,
				stageType = arg_4_0.stageType_,
				stageID = arg_4_0.stageID_,
				sectionProxy = arg_4_0.sectionProxy_
			})
		elseif arg_4_0.sectionProxy_:IsUseCharChip() then
			arg_4_0:Go("/adminSelectChip", {
				isMimir = false,
				isFroming = true,
				selectID = arg_4_0.sectionProxy_:GetCharChipBaseID(),
				stageType = arg_4_0.stageType_,
				stageID = arg_4_0.stageID_,
				sectionProxy = arg_4_0.sectionProxy_
			})
		else
			arg_4_0:Go("/adminSelectChip", {
				isFroming = true,
				selectID = 0,
				stageType = arg_4_0.stageType_,
				stageID = arg_4_0.stageID_,
				sectionProxy = arg_4_0.sectionProxy_
			})
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.detailBtn_, nil, function()
		if arg_4_0.isLock_ then
			return
		end

		if not arg_4_0.sectionProxy_.canChangeMimir then
			ShowTips("CANNOT_CHANGE_CHIP")

			return
		end

		ChipAction:UpdateChipRed()

		if arg_4_0.sectionProxy_:IsUseMimirChip() then
			arg_4_0:Go("/battleChipManager", {
				chipManagerID = arg_4_0.selectID_,
				stageType = arg_4_0.stageType_,
				stageID = arg_4_0.stageID_,
				sectionProxy = arg_4_0.sectionProxy_
			})
		elseif arg_4_0.sectionProxy_:IsUseCharChip() then
			arg_4_0:Go("/charChip", {
				baseID = arg_4_0.sectionProxy_:GetCharChipBaseID(),
				stageType = arg_4_0.stageType_,
				stageID = arg_4_0.stageID_,
				sectionProxy = arg_4_0.sectionProxy_
			})
		else
			arg_4_0:Go("/adminSelectChip", {
				isFroming = true,
				selectID = 0,
				stageType = arg_4_0.stageType_,
				stageID = arg_4_0.stageID_,
				sectionProxy = arg_4_0.sectionProxy_
			})
		end
	end)
end

function var_0_0.SetProxy(arg_7_0, arg_7_1)
	arg_7_0.sectionProxy_ = arg_7_1
	arg_7_0.stageType_ = arg_7_1.stageType
	arg_7_0.stageID_ = arg_7_1.stageID
	arg_7_0.reserveParams_ = arg_7_1:GetReserveParams()
end

function var_0_0.Refresh(arg_8_0)
	arg_8_0:RefreshData()
	arg_8_0:RefreshActive()

	if arg_8_0.sectionProxy_.needMimirPanel then
		arg_8_0:RefreshChipPanel()
	end
end

function var_0_0.RefreshData(arg_9_0)
	arg_9_0.mimirID_ = arg_9_0:GetMimirID()

	if arg_9_0.mimirID_ ~= 0 then
		arg_9_0.chipList_ = arg_9_0:GetMimirChipList()
	else
		arg_9_0.chipList_ = {}
	end
end

function var_0_0.RefreshActive(arg_10_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER) then
		arg_10_0.activeController_:SetSelectedState("false")

		return
	end

	if not arg_10_0.sectionProxy_.canChangeMimir and not arg_10_0.sectionProxy_:IsUseMimirChip() and not arg_10_0.sectionProxy_:IsUseCharChip() then
		arg_10_0.activeController_:SetSelectedState("false")
	else
		arg_10_0.activeController_:SetSelectedState(tostring(arg_10_0.sectionProxy_.needMimirPanel))
	end
end

function var_0_0.RefreshChipPanel(arg_11_0)
	arg_11_0:RefreshChipPanelType()
	arg_11_0:RefreshMimirUI()
	arg_11_0:RefreshChipList()
	arg_11_0:RefreshCharChipUI()
end

function var_0_0.RefreshChipPanelType(arg_12_0)
	arg_12_0.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER) == true

	if arg_12_0.isLock_ then
		arg_12_0.chipPanelController_:SetSelectedState("Lock")
	elseif arg_12_0.sectionProxy_:IsUseMimirChip() then
		arg_12_0.chipPanelController_:SetSelectedState("ManageMeowChips")
	elseif arg_12_0.sectionProxy_:IsUseCharChip() then
		arg_12_0.chipPanelController_:SetSelectedState("CorrectorChip")
	else
		arg_12_0.chipPanelController_:SetSelectedState("EmptyChips")
	end
end

function var_0_0.RefreshMimirUI(arg_13_0)
	local var_13_0 = arg_13_0.mimirID_ or 0

	if var_13_0 ~= 0 then
		arg_13_0.chipManagerIcon_.sprite = ChipTools.GetChipManagerIcon(var_13_0)
	end
end

function var_0_0.RefreshChipList(arg_14_0)
	local var_14_0 = arg_14_0.chipList_
	local var_14_1 = GameSetting.ai_secondary_chip_equip_num.value[1]

	if var_14_1 < #arg_14_0.chipList_ then
		for iter_14_0 = #arg_14_0.chipList_, var_14_1 + 1, -1 do
			arg_14_0.chipList_[iter_14_0] = nil
		end
	end

	for iter_14_1, iter_14_2 in ipairs(var_14_0) do
		if iter_14_2 == nil or iter_14_2 == 0 then
			break
		end

		SetActive(arg_14_0[string.format("chipIconGo_%s", iter_14_1)], true)

		if ChipCfg[iter_14_2] == nil then
			print(string.format("ChipCfg[%s] is nil", iter_14_2))
		end

		arg_14_0[string.format("chipIcon_%s", iter_14_1)].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[iter_14_2].picture_id)
	end

	for iter_14_3 = #var_14_0 + 1, var_14_1 do
		SetActive(arg_14_0[string.format("chipIconGo_%s", iter_14_3)], false)
	end
end

function var_0_0.RefreshCharChipUI(arg_15_0)
	local var_15_0 = arg_15_0.sectionProxy_:GetCharChipBaseID()

	if var_15_0 == 0 then
		return
	end

	local var_15_1 = arg_15_0.sectionProxy_:GetCharChipExtraIDList()

	arg_15_0.charChipIcon_.sprite = ChipTools.GetCharChipIcon(var_15_0, true)

	arg_15_0.riseController_:SetSelectedState(tostring(#var_15_1 + 1))
end

function var_0_0.GetMimirID(arg_16_0)
	return arg_16_0.sectionProxy_:GetMimirID()
end

function var_0_0.GetMimirChipList(arg_17_0)
	return arg_17_0.sectionProxy_:GetMimirChipList()
end

function var_0_0.Show(arg_18_0, arg_18_1)
	SetActive(arg_18_0.gameObject_, arg_18_1)
end

return var_0_0
