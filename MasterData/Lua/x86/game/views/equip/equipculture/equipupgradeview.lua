local EquipUpgradeView = class("EquipUpgradeView", EquipBaseView)

function EquipUpgradeView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.params_ = arg_1_3

	self:Init()
end

function EquipUpgradeView:Init()
	self:InitUI()
	self:AddUIListener()
	self.super.Init(self)
end

function EquipUpgradeView:InitUI()
	self:BindCfgUI()

	self.attrs = {}

	for iter_3_0 = 1, 2 do
		local var_3_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_3_0, self["property_" .. iter_3_0])
		table.insert(self.attrs, var_3_0)
	end

	self.costScroller_ = LuaList.New(handler(self, self.indexItem), self.costListGo_, CommonItemView)
	self.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	self.conditionController_ = self.transCon_:GetController("condition")
	self.clearController_ = self.conditionCon_:GetController("clear")
	self.btnStateController_ = self.transCon_:GetController("btnState")
	self.equipStrengthHandler_ = handler(self, self.OnEquipStrengthSuccess)
end

function EquipUpgradeView:AddUIListener()
	self:AddBtnListener(self.upgradeBtn_, nil, function()
		EquipAction.ApplyUpgradeEquip(tonumber(self.equipId))
	end)
	self:AddBtnListener(self.noBtn_, nil, function()
		if self.showTips_ then
			ShowTips(GetTips("EQUIP_BREAK_LIMITED"))
		else
			EquipAction.ApplyUpgradeEquip(tonumber(self.equipId))
		end
	end)
	self:AddBtnListener(self.btnOneKeyCulture_, nil, function()
		JumpTools.OpenPageByJump("equipOneKeyCulturePopView", {
			equipId = self.equipId
		})
	end)
end

function EquipUpgradeView:OnEquipStrengthSuccess(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_3.equipId == self.equipId then
		if self.handler_:RefreshSideBar(self.equipId) ~= 2 then
			self:RefreshEquipUpgrade()
		end
	else
		self:RefreshEquipUpgrade()
	end

	if arg_8_2 then
		JumpTools.OpenPageByJump("equipCulturePopView", arg_8_3)
	end
end

function EquipUpgradeView:OnEnter()
	self:OnEquipChange(self.params_.equipId)
	self:RegistEventListener(EQUIP_STRENGTH_SUCCESS, self.equipStrengthHandler_)
end

function EquipUpgradeView:OnTop()
	self:ChangeBar()
	self:RefreshEquipUpCost()
	self:RefreshEquipUpLimit()
	self.btnStateController_:SetSelectedIndex((self.isLack_ or self.showTips_) and 1 or 0)
end

function EquipUpgradeView:ChangeBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
end

function EquipUpgradeView:OnEquipChange(arg_12_1)
	self.equipId = arg_12_1
	self.equip = EquipData:GetEquipData(self.equipId)

	if self.equip:GetLevel() >= EquipCfg[self.equip.prefab_id].max_level[EquipCfg[self.equip.prefab_id].break_times_max + 1] then
		self.handler_:RefreshSideBar(self.equipId)

		return
	end

	self:RefreshEquipUpgrade()
	self:ChangeBar()
end

function EquipUpgradeView:RefreshEquipUpgrade()
	self:RefreshEquipUpInfo()
	self:RefreshEquipUpCost()
	self:RefreshEquipUpLimit()
	self.btnStateController_:SetSelectedIndex((self.isLack_ or self.showTips_) and 1 or 0)
end

function EquipUpgradeView:RefreshEquipUpInfo()
	self.oldLv_.text = EquipCfg[self.equip.prefab_id].max_level[self.equip.now_break_level + 1]
	self.newLv_.text = EquipCfg[self.equip.prefab_id].max_level[self.equip.now_break_level + 2]

	for iter_14_0 = 1, 2 do
		self.attrs[iter_14_0].icon_.sprite = getSprite("Atlas/SystemCommonAtlas", PublicAttrCfg[EquipCfg[self.equip.prefab_id].fixed_attributes[self.equip.now_break_level + 1][iter_14_0][1]].icon)
		self.attrs[iter_14_0].name_.text = string.format(GetTips("EQUIP_UPGRADE_ATTR_DES"), GetI18NText(PublicAttrCfg[EquipCfg[self.equip.prefab_id].fixed_attributes[self.equip.now_break_level + 1][iter_14_0][1]].name))
		self.attrs[iter_14_0].oldVal_.text = EquipCfg[self.equip.prefab_id].fixed_attributes[self.equip.now_break_level + 1][iter_14_0][3]
		self.attrs[iter_14_0].newVal_.text = EquipCfg[self.equip.prefab_id].fixed_attributes[self.equip.now_break_level + 2][iter_14_0][3]
	end
end

function EquipUpgradeView:RefreshEquipUpCost()
	local var_15_0 = self.equip:GetUpgradeCost()

	if not var_15_0 then
		return
	end

	self.isLack_ = false
	self.moneyCost_ = var_15_0.money

	local var_15_1 = tostring(self.moneyCost_)

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < var_15_0.money then
		self.isLack_ = true
		var_15_1 = "<color='#EB0000'>" .. var_15_1 .. "</color>"
	end

	self.costNum_.text = var_15_1

	for iter_15_0, iter_15_1 in ipairs(var_15_0.item_list) do
		if ItemTools.getItemNum(iter_15_1[1]) < iter_15_1[2] then
			self.isLack_ = true

			break
		end
	end

	self.costMaterialList_ = var_15_0.item_list

	self.costScroller_:StartScroll(#self.costMaterialList_)
end

function EquipUpgradeView:indexItem(arg_16_1, arg_16_2)
	local var_16_0 = clone(ItemTemplateData)

	var_16_0.id = self.costMaterialList_[arg_16_1][1]

	function var_16_0:clickFun()
		ShowPopItem(POP_SOURCE_ITEM, {
			self.id,
			self.number
		})
	end

	var_16_0.bottomText = {
		ItemTools.getItemNum(self.costMaterialList_[arg_16_1][1]),
		self.costMaterialList_[arg_16_1][2]
	}
	var_16_0.hideBottomRightTextFlag = true

	arg_16_2:SetData(var_16_0)
end

function EquipUpgradeView:RefreshEquipUpLimit()
	if EquipCfg[self.equip.prefab_id].hero_slot_open_level[1] and EquipCfg[self.equip.prefab_id].max_level[self.equip.now_break_level + 2] == EquipCfg[self.equip.prefab_id].hero_slot_open_level[1] then
		self.conditionController_:SetSelectedState("show")

		self.conditionDesc_.text = GetTips("EQUIP_BREAK_LIMITED")

		if self.equip.race ~= 0 and table.keyof(RaceEffectCfg.all, self.equip.race) == nil then
			self.showTips_ = false

			self.clearController_:SetSelectedState("clear")
		else
			self.showTips_ = true

			self.clearController_:SetSelectedState("notclear")
		end
	else
		self.showTips_ = false

		self.conditionController_:SetSelectedState("hide")
	end
end

function EquipUpgradeView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function EquipUpgradeView:Dispose()
	self:RemoveAllListeners()

	if self.costScroller_ then
		self.costScroller_:Dispose()

		self.costScroller_ = nil
	end

	EquipUpgradeView.super.Dispose(self)
end

return EquipUpgradeView
