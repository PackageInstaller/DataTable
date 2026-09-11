local NewSectionMimirView = class("NewSectionMimirView", ReduxView)

function NewSectionMimirView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Show(true)
	self:Init()
end

function NewSectionMimirView:Init()
	self:InitUI()
	self:AddListener()
end

function NewSectionMimirView:InitUI()
	self:BindCfgUI()

	self.activeController_ = self.controllerExCollection_:GetController("active")
	self.chipPanelController_ = self.chipPanelConEx_:GetController("chipPanel")
	self.riseController_ = self.charChipConEx_:GetController("rise")
end

function NewSectionMimirView:AddListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.isLock_ then
			return
		end

		if not self.sectionProxy_.canChangeMimir then
			ShowTips("CANNOT_CHANGE_CHIP")

			return
		end

		ChipAction:UpdateChipRed()

		if self.sectionProxy_:IsUseMimirChip() then
			self:Go("/adminSelectChip", {
				isMimir = true,
				isFroming = true,
				selectID = self.mimirID_,
				stageType = self.stageType_,
				stageID = self.stageID_,
				sectionProxy = self.sectionProxy_
			})
		elseif self.sectionProxy_:IsUseCharChip() then
			self:Go("/adminSelectChip", {
				isMimir = false,
				isFroming = true,
				selectID = self.sectionProxy_:GetCharChipBaseID(),
				stageType = self.stageType_,
				stageID = self.stageID_,
				sectionProxy = self.sectionProxy_
			})
		else
			self:Go("/adminSelectChip", {
				isFroming = true,
				selectID = 0,
				stageType = self.stageType_,
				stageID = self.stageID_,
				sectionProxy = self.sectionProxy_
			})
		end
	end)
	self:AddBtnListener(self.detailBtn_, nil, function()
		if self.isLock_ then
			return
		end

		if not self.sectionProxy_.canChangeMimir then
			ShowTips("CANNOT_CHANGE_CHIP")

			return
		end

		ChipAction:UpdateChipRed()

		if self.sectionProxy_:IsUseMimirChip() then
			self:Go("/battleChipManager", {
				chipManagerID = self.selectID_,
				stageType = self.stageType_,
				stageID = self.stageID_,
				sectionProxy = self.sectionProxy_
			})
		elseif self.sectionProxy_:IsUseCharChip() then
			self:Go("/charChip", {
				baseID = self.sectionProxy_:GetCharChipBaseID(),
				stageType = self.stageType_,
				stageID = self.stageID_,
				sectionProxy = self.sectionProxy_
			})
		else
			self:Go("/adminSelectChip", {
				isFroming = true,
				selectID = 0,
				stageType = self.stageType_,
				stageID = self.stageID_,
				sectionProxy = self.sectionProxy_
			})
		end
	end)
end

function NewSectionMimirView:SetProxy(arg_7_1)
	self.sectionProxy_ = arg_7_1
	self.stageType_ = arg_7_1.stageType
	self.stageID_ = arg_7_1.stageID
	self.reserveParams_ = arg_7_1:GetReserveParams()
end

function NewSectionMimirView:Refresh()
	self:RefreshData()
	self:RefreshActive()

	if self.sectionProxy_.needMimirPanel then
		self:RefreshChipPanel()
	end
end

function NewSectionMimirView:RefreshData()
	self.mimirID_ = self:GetMimirID()
	self.chipList_ = self.mimirID_ ~= 0 and self:GetMimirChipList() or {}
end

function NewSectionMimirView:RefreshActive()
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER) then
		self.activeController_:SetSelectedState("false")

		return
	end

	if not self.sectionProxy_.canChangeMimir and not self.sectionProxy_:IsUseMimirChip() and not self.sectionProxy_:IsUseCharChip() then
		self.activeController_:SetSelectedState("false")
	else
		self.activeController_:SetSelectedState(tostring(self.sectionProxy_.needMimirPanel))
	end
end

function NewSectionMimirView:RefreshChipPanel()
	self:RefreshChipPanelType()
	self:RefreshMimirUI()
	self:RefreshChipList()
	self:RefreshCharChipUI()
end

function NewSectionMimirView:RefreshChipPanelType()
	self.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER) == true

	if self.isLock_ then
		self.chipPanelController_:SetSelectedState("Lock")
	elseif self.sectionProxy_:IsUseMimirChip() then
		self.chipPanelController_:SetSelectedState("ManageMeowChips")
	elseif self.sectionProxy_:IsUseCharChip() then
		self.chipPanelController_:SetSelectedState("CorrectorChip")
	else
		self.chipPanelController_:SetSelectedState("EmptyChips")
	end
end

function NewSectionMimirView:RefreshMimirUI()
	local var_13_0 = self.mimirID_ or 0

	if var_13_0 ~= 0 then
		self.chipManagerIcon_.sprite = ChipTools.GetChipManagerIcon(var_13_0)
	end
end

function NewSectionMimirView:RefreshChipList()
	if GameSetting.ai_secondary_chip_equip_num.value[1] < #self.chipList_ then
		for iter_14_0 = #self.chipList_, GameSetting.ai_secondary_chip_equip_num.value[1] + 1, -1 do
			self.chipList_[iter_14_0] = nil
		end
	end

	for iter_14_1, iter_14_2 in ipairs(self.chipList_) do
		if iter_14_2 == nil or iter_14_2 == 0 then
			break
		end

		SetActive(self[string.format("chipIconGo_%s", iter_14_1)], true)

		if ChipCfg[iter_14_2] == nil then
			print(string.format("ChipCfg[%s] is nil", iter_14_2))
		end

		self[string.format("chipIcon_%s", iter_14_1)].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[iter_14_2].picture_id)
	end

	for iter_14_3 = #self.chipList_ + 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		SetActive(self[string.format("chipIconGo_%s", iter_14_3)], false)
	end
end

function NewSectionMimirView:RefreshCharChipUI()
	local var_15_0 = self.sectionProxy_:GetCharChipBaseID()

	if var_15_0 == 0 then
		return
	end

	local var_15_1 = self.sectionProxy_:GetCharChipExtraIDList()

	self.charChipIcon_.sprite = ChipTools.GetCharChipIcon(var_15_0, true)

	self.riseController_:SetSelectedState(tostring(#var_15_1 + 1))
end

function NewSectionMimirView:GetMimirID()
	return self.sectionProxy_:GetMimirID()
end

function NewSectionMimirView:GetMimirChipList()
	return self.sectionProxy_:GetMimirChipList()
end

function NewSectionMimirView:Show(arg_18_1)
	SetActive(self.gameObject_, arg_18_1)
end

return NewSectionMimirView
