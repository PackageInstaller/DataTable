local NewSectionHeroChipView = class("NewSectionHeroChipView", ReduxView)

function NewSectionHeroChipView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Show(true)
	self:Init()
end

function NewSectionHeroChipView:Init()
	self:InitUI()
	self:AddListener()
end

function NewSectionHeroChipView:InitUI()
	self:BindCfgUI()

	self.lockController_ = self.controllerExCollection_:GetController("lock")
	self.managerController_ = self.controllerExCollection_:GetController("chipManager")
end

function NewSectionHeroChipView:AddListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.isLock_ then
			return
		end

		if self.isCustom_ then
			ShowTips("CANNOT_CHANGE_CHIP")

			return
		end

		ChipAction:UpdateChipRed()
		self:Go("/battleChipManager", {
			stageType = self.stageType_,
			stageID = self.stageID_,
			reserveParams = self.reserveParams_
		})
	end)
end

function NewSectionHeroChipView:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.stageType_ = arg_6_1
	self.stageID_ = arg_6_2
	self.reserveParams_ = arg_6_3
	self.isCustom_ = false

	local var_6_0 = BattleStageTools.GetStageCfg(arg_6_1, arg_6_2)

	if var_6_0 and type(var_6_0.chip_list) == "table" then
		self.isCustom_ = true
		self.enabledID_ = var_6_0.chip_list[1]
		self.chipList_ = {}

		for iter_6_0 = 2, 3 do
			self.chipList_[iter_6_0 - 1] = var_6_0.chip_list[iter_6_0]
		end

		self:RefreshUI()

		return
	end

	self.enabledID_ = self:GetChipManagerID()
	self.chipList_ = self:GetChipList()

	self:RefreshUI()
end

function NewSectionHeroChipView:RefreshUI()
	self:RefreshLock()
	self:RefreshChipManager()
	self:RefreshChipList()
end

function NewSectionHeroChipView:RefreshLock()
	self.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER) == true

	self.lockController_:SetSelectedState(tostring(self.isLock_))
end

function NewSectionHeroChipView:RefreshChipManager()
	local var_9_0 = self.enabledID_ or 0

	if var_9_0 ~= 0 then
		self.managerController_:SetSelectedState("true")

		self.chipManagerIcon_.sprite = ChipTools.GetChipManagerIcon(var_9_0)
	else
		self.managerController_:SetSelectedState("false")
	end
end

function NewSectionHeroChipView:RefreshChipList()
	if GameSetting.ai_secondary_chip_equip_num.value[1] < #self.chipList_ then
		for iter_10_0 = #self.chipList_, GameSetting.ai_secondary_chip_equip_num.value[1] + 1, -1 do
			self.chipList_[iter_10_0] = nil
		end
	end

	for iter_10_1, iter_10_2 in ipairs(self.chipList_) do
		if iter_10_2 == nil or iter_10_2 == 0 then
			break
		end

		SetActive(self[string.format("chipIconGo_%s", iter_10_1)], true)

		if ChipCfg[iter_10_2] == nil then
			print(string.format("ChipCfg[%s] is nil", iter_10_2))
		end

		self[string.format("chipIcon_%s", iter_10_1)].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[iter_10_2].picture_id)
	end

	for iter_10_3 = #self.chipList_ + 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		SetActive(self[string.format("chipIconGo_%s", iter_10_3)], false)
	end
end

function NewSectionHeroChipView:GetChipManagerID()
	return ReserveTools.GetMimirID(self.reserveParams_)
end

function NewSectionHeroChipView:GetChipList()
	return ReserveTools.GetMimirChipList(self.reserveParams_)
end

function NewSectionHeroChipView:GetCurEnabledID()
	return self.enabledID_ or 0
end

function NewSectionHeroChipView:GetCurChipList()
	return self.chipList_ or {}
end

function NewSectionHeroChipView:Show(arg_15_1)
	SetActive(self.gameObject_, arg_15_1)
end

return NewSectionHeroChipView
