local EquipLevelUpView = class("EquipLevelUpView", EquipBaseView)

function EquipLevelUpView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.params_ = arg_1_3

	self:Init()
end

function EquipLevelUpView:Init()
	self:InitUI()
	self:AddUIListener()
	EquipLevelUpView.super.Init(self)
end

function EquipLevelUpView:InitUI()
	self:BindCfgUI()

	self.scrollHelper = LuaList.New(handler(self, self.indexItem), self.listGo_, CommonItemView)
	self.attrs = {}

	for iter_3_0 = 1, 2 do
		local var_3_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_3_0, self["property_" .. iter_3_0])
		table.insert(self.attrs, var_3_0)
	end

	self.maxAttrs = {}

	for iter_3_1 = 1, 2 do
		local var_3_1 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_3_1, self["maxAttr_" .. iter_3_1])
		table.insert(self.maxAttrs, var_3_1)
	end

	self.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	self.maxLvController_ = self.transCon_:GetController("levelMax")
	self.equipStrengthHandler_ = handler(self, self.OnEquipStrengthSuccess)
end

function EquipLevelUpView:AddUIListener()
	self:AddBtnListener(self.btnAutoSelect_, nil, function()
		if self.nextLv_ >= self.equipMaxLv_ then
			return
		end

		local var_5_1 = {}

		table.insert(var_5_1, self.equipId_)

		local var_5_2, var_5_3 = EquipTools.QuickSelectList(EquipTools.CountNeedExp(self.equip_, self.equipMaxLv_, self.equip_.now_break_level) - self.equip_.exp, var_5_1)

		self.usedMaterialList_ = var_5_2
		self.usedEquipList_ = var_5_3

		self:RefreshListSelect()
	end)
	self:AddBtnListener(self.btnLevelup_, nil, function()
		local var_6_0 = false

		for iter_6_0, iter_6_1 in pairs(self.usedMaterialList_) do
			if iter_6_1 > 0 then
				var_6_0 = true
			end
		end

		if not var_6_0 and next(self.usedEquipList_) == nil then
			ShowTips(GetTips("PLEASE_SELECT_ITEM"))

			return
		end

		if not checkGold(self.cost_) then
			return
		end

		local var_6_1 = false

		for iter_6_2, iter_6_3 in pairs(self.usedEquipList_) do
			if iter_6_3.equip_star >= 5 then
				var_6_1 = true

				break
			end
		end

		local var_6_2 = false
		local var_6_3 = self.equip_.exp + EquipTools.CountAddExp(self.usedMaterialList_, self.usedEquipList_) - EquipTools.CountNeedExp(self.equip_, self.equipMaxLv_, self.equip_.now_break_level)
		local var_6_4 = MaterialTools.materialGiveBack(var_6_3, ItemConst.STR_ITEM.EQUIP)

		local function var_6_5(arg_7_0, arg_7_1)
			for iter_7_0, iter_7_1 in pairs(arg_7_1) do
				arg_7_0[#arg_7_0 + 1] = iter_7_1
			end
		end

		for iter_6_4, iter_6_5 in pairs(self.usedEquipList_) do
			var_6_5(var_6_4, (EquipData:GetEquipData(iter_6_4):GetBreakCostReturn()))
		end

		local var_6_6 = unformatRewardCfgList((sortReward((mergeReward((formatRewardCfgList(var_6_4)))))))

		if #var_6_6 > 0 then
			var_6_2 = true
		end

		local var_6_7 = ""

		if var_6_1 and var_6_2 then
			var_6_7 = string.format(GetTips("EQUIP_STRENGTH_EXP_OVERFLOW_AND_RARE"))
		elseif var_6_1 and not var_6_2 then
			var_6_7 = GetTips("EQUIP_STRENGTH_COST_RARE")
		elseif not var_6_1 and var_6_2 then
			var_6_7 = string.format(GetTips("EQUIP_STRENGTH_EXP_OVERFLOW"))
		else
			EquipAction.ApplyStrengthEquip(tonumber(self.equipId_), self.usedEquipList_, self.usedMaterialList_, self.cost_, var_6_3)

			return
		end

		if var_6_1 and not var_6_2 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = var_6_7,
				OkCallback = function()
					EquipAction.ApplyStrengthEquip(tonumber(self.equipId_), self.usedEquipList_, self.usedMaterialList_, self.cost_)
				end
			})

			return
		end

		JumpTools.OpenPageByJump("materialPreview", {
			content = var_6_7,
			OkCallback = function()
				EquipAction.ApplyStrengthEquip(tonumber(self.equipId_), self.usedEquipList_, self.usedMaterialList_, self.cost_, var_6_3)
			end,
			itemList = var_6_6
		})
	end)
	self:AddBtnListener(self.btnFilter_, nil, function()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.Equip_Filter_List
		})
	end)
	self:AddBtnListener(self.btnOneKeyCulture_, nil, function()
		JumpTools.OpenPageByJump("equipOneKeyCulturePopView", {
			equipId = self.equipId_
		})
	end)
end

function EquipLevelUpView:OnEnter()
	self:OnEquipChange(self.params_.equipId)
	self:RegistEventListener(COMMON_FILTER_OK, handler(self, self.OnFilterChange))
	self:RegistEventListener(CURRENCY_UPDATE, handler(self, self.OnGoldChange))
	self:RegistEventListener(EQUIP_STRENGTH_SUCCESS, self.equipStrengthHandler_)
end

function EquipLevelUpView:OnEquipChange(arg_13_1)
	self.usedMaterialList_ = {}
	self.usedEquipList_ = {}
	self.equipId_ = arg_13_1
	self.equip_ = EquipData:GetEquipData(self.equipId_)
	self.equipMaxLv_ = EquipTools.CountEquipMaxLv(self.equip_)
	self.equipLv_ = self.equip_:GetLevel()

	if self.equipLv_ == self.equipMaxLv_ then
		self.maxLvController_:SetSelectedState("max")
		self:RefreshMax()
	else
		self.maxLvController_:SetSelectedState("normal")
		self:RefreshEquipStrength()
		self:ChangeEquipSelectView(EquipConst.EQUIP_SORT.LEVEL, ItemConst.SORT_TYPE.UP)
	end

	self:ChangeBar()
end

function EquipLevelUpView:OnTop()
	self:ChangeBar()
end

function EquipLevelUpView:ChangeBar()
	local var_15_0 = {
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	}

	if self.equipLv_ == self.equipMaxLv_ then
		manager.windowBar:SwitchBar(var_15_0)
	else
		table.insert(var_15_0, CurrencyConst.CURRENCY_TYPE_GOLD)
		manager.windowBar:SwitchBar(var_15_0)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	end
end

function EquipLevelUpView:RefreshMax()
	self.maxLv_.text = self.equipMaxLv_

	for iter_16_0, iter_16_1 in pairs((EquipTools.CountEquipAttribute(self.equip_))) do
		local var_16_0 = math.floor(iter_16_1)

		if PublicAttrCfg[iter_16_0].percent and PublicAttrCfg[iter_16_0].percent == 1 then
			var_16_0 = iter_16_1 / 10 .. "%"
		end

		self.maxAttrs[1].name_.text = GetI18NText(PublicAttrCfg[iter_16_0].name)
		self.maxAttrs[1].icon_.sprite = getSprite("Atlas/SystemCommonAtlas", PublicAttrCfg[iter_16_0].icon)
		self.maxAttrs[1].num_.text = var_16_0
	end
end

function EquipLevelUpView:RefreshEquipStrength()
	local var_17_0 = EquipTools.CountAddExp(self.usedMaterialList_, self.usedEquipList_)
	local var_17_1 = deepClone(self.equip_)

	var_17_1.exp = self.equip_.exp + var_17_0

	self:RefreshExp(var_17_0, self.equip_.exp + var_17_0, self.equip_, var_17_1)
	self:RefreshAttr(self.equip_, var_17_1)
	self:RefreshCost()
end

function EquipLevelUpView:RefreshExp(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = EquipTools.CountEquipLevel(arg_18_3)
	local var_18_1 = EquipTools.CountEquipLevel(arg_18_4)

	self.nextLv_ = var_18_1
	self.oldLv_.text = "" .. var_18_0
	self.newLv_.text = "" .. var_18_1

	local var_18_2 = self.equipMaxLv_

	SetActive(self.btnAutoSelectGo_, var_18_0 < self.equipMaxLv_)
	SetActive(self.btnStrengthGo_, var_18_0 < var_18_2)
	SetActive(self.btnAutoSelectNullGo_, var_18_0 == var_18_2)
	SetActive(self.newLevelContent_, arg_18_1 ~= 0)

	self.addExpText_.text = "+" .. arg_18_1

	local var_18_3 = EquipTools.CountNeedExp(arg_18_3, var_18_1, arg_18_3.now_break_level)
	local var_18_4 = arg_18_2 - var_18_3

	self.cost_ = 0

	if var_18_2 <= var_18_1 then
		self.cost_ = math.floor((var_18_3 - arg_18_3.exp < 0 and 0 or var_18_3 - arg_18_3.exp) * GameSetting.equip_strengthen_gold_cost.value[1])
		self.expNum_.text = "-/-"
		self.expProg_.fillAmount = 0
		self.newExpProg_.fillAmount = 1

		SetActive(self.maxGo_, true)
	else
		self.cost_ = math.floor(arg_18_1 * GameSetting.equip_strengthen_gold_cost.value[1])

		local var_18_5 = EquipExpCfg[var_18_1]["exp" .. arg_18_3.equipConfig.starlevel]

		self.expNum_.text = var_18_4 .. "/" .. EquipExpCfg[var_18_1]["exp" .. arg_18_3.equipConfig.starlevel]
		self.expProg_.fillAmount = var_18_1 == var_18_0 and (var_18_4 - arg_18_1) / var_18_5 or 0
		self.newExpProg_.fillAmount = var_18_4 / var_18_5

		SetActive(self.maxGo_, false)
	end
end

function EquipLevelUpView:RefreshAttr(arg_19_1, arg_19_2)
	local var_19_0 = EquipTools.CountEquipAttribute(arg_19_2)
	local var_19_1 = 1

	for iter_19_0, iter_19_1 in pairs((EquipTools.CountEquipAttribute(arg_19_1))) do
		if not self.attrs[var_19_1] then
			break
		end

		local var_19_2 = math.floor(iter_19_1)
		local var_19_3 = math.floor(var_19_0[iter_19_0])

		if PublicAttrCfg[iter_19_0].percent and PublicAttrCfg[iter_19_0].percent == 1 then
			var_19_2 = iter_19_1 / 10 .. "%"
			var_19_3 = var_19_0[iter_19_0] / 10 .. "%"
		end

		self.attrs[var_19_1].name_.text = GetI18NText(PublicAttrCfg[iter_19_0].name)
		self.attrs[var_19_1].icon_.sprite = getSprite("Atlas/SystemCommonAtlas", PublicAttrCfg[iter_19_0].icon)
		self.attrs[var_19_1].oldVal_.text = var_19_2

		if iter_19_1 ~= var_19_0[iter_19_0] then
			self.attrs[var_19_1].newVal_.text = string.format("<color='#E28000'>%s</color>", var_19_3)
			self.attrs[var_19_1].arrow_.color = Color.New(0.8941176, 0.5058823, 0, 1)
		else
			self.attrs[var_19_1].newVal_.text = string.format("<color='#3D4045'>%s</color>", var_19_3)
			self.attrs[var_19_1].arrow_.color = Color.New(0.2392156, 0.2509803, 0.2705882, 1)
		end

		var_19_1 = var_19_1 + 1
	end
end

function EquipLevelUpView:RefreshCost()
	local var_20_0 = tostring(self.cost_)

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < self.cost_ then
		var_20_0 = "<color='#FF0000'>" .. var_20_0 .. "</color>"
	end

	self.costNum_.text = var_20_0
end

function EquipLevelUpView:ChangeEquipSelectView(arg_21_1, arg_21_2)
	self.priority_ = arg_21_1
	self.order_ = arg_21_2
	self.itemList = self:GetItemList()

	self:RefreshList()
end

function EquipLevelUpView:RefreshList()
	self.scrollHelper:StartScroll(#self.itemList)
end

function EquipLevelUpView:RefreshListSelect()
	for iter_23_0, iter_23_1 in pairs(self.scrollHelper:GetItemList()) do
		local var_23_0 = iter_23_1:GetData()

		if var_23_0.type == ItemConst.ITEM_TYPE.MATERIAL then
			iter_23_1:RefreshTopAmount(self.usedMaterialList_[var_23_0.id] or 0)
		elseif var_23_0.type == ItemConst.ITEM_TYPE.EQUIP then
			iter_23_1:RefreshSelectState(self.usedEquipList_[var_23_0.equip_id] and true or false)
		end
	end

	self:RefreshEquipStrength()
end

function EquipLevelUpView:indexItem(arg_24_1, arg_24_2)
	local var_24_0 = self.itemList[arg_24_1]
	local var_24_1 = clone(ItemTemplateData)

	if self.itemList[arg_24_1].type == ItemConst.ITEM_TYPE.EQUIP then
		var_24_1.equip_info = var_24_0
		var_24_1.id = var_24_0.prefab_id
		var_24_1.equip_id = var_24_0.equip_id
		var_24_1.equip_star = getItemStar(var_24_0.prefab_id)
		var_24_1.equipLevel = EquipTools.CountEquipLevel(var_24_0)
		var_24_1.isEquiped = false
		var_24_1.equipedLocked = var_24_0.is_lock
		var_24_1.type = var_24_0.type

		function var_24_1.clickFun(arg_25_0)
			self:EquipClickFunc(arg_24_2, arg_25_0)
		end

		var_24_1.selectStyle = self.usedEquipList_[var_24_0.equip_id] ~= nil
	elseif var_24_0.type == ItemConst.ITEM_TYPE.MATERIAL then
		var_24_1.id = var_24_0.id
		var_24_1.number = var_24_0.number
		var_24_1.type = var_24_0.type

		function var_24_1.longClickFun(arg_26_0)
			return self:MaterialLongClickFunc(arg_24_2, arg_26_0)
		end

		function var_24_1.clickAmountFun(arg_27_0)
			return self:MaterialAmountClickFunc(arg_24_2, arg_27_0)
		end

		if self.usedMaterialList_[var_24_0.id] and self.usedMaterialList_[var_24_0.id] ~= 0 then
			var_24_1.topAmountValue = self.usedMaterialList_[var_24_0.id]
		end
	end

	arg_24_2:SetData(var_24_1)
end

function EquipLevelUpView:EquipClickFunc(arg_28_1, arg_28_2)
	if self.usedEquipList_[arg_28_2.equip_id] then
		self.usedEquipList_[arg_28_2.equip_id] = nil
		self.handler_.equipCommonItem_ = arg_28_1

		self.handler_:HidePop()
	else
		local var_28_0 = arg_28_2.equip_id

		if self.nextLv_ >= self.equipMaxLv_ then
			ShowTips("ERROR_USER_MAX_LV")

			return
		end

		if arg_28_2.equipedLocked then
			ShowTips("REMOVE_LOCK")
			self:ShowEquipInfo(var_28_0, arg_28_1)

			return
		end

		self:ShowEquipInfo(var_28_0, arg_28_1)
		arg_28_1:RefreshSelectState(true)

		self.usedEquipList_[var_28_0] = arg_28_2
	end

	self:RefreshEquipStrength()
end

function EquipLevelUpView:MaterialLongClickFunc(arg_29_1, arg_29_2)
	if self.nextLv_ >= self.equipMaxLv_ then
		ShowTips("ERROR_USER_MAX_LV")

		return false
	end

	self.usedMaterialList_[arg_29_2.id] = self.usedMaterialList_[arg_29_2.id] or 0

	if self.usedMaterialList_[arg_29_2.id] >= arg_29_2.number then
		return false
	end

	self.usedMaterialList_[arg_29_2.id] = self.usedMaterialList_[arg_29_2.id] + 1

	arg_29_1:RefreshTopAmount(self.usedMaterialList_[arg_29_2.id])
	self:RefreshEquipStrength()
	manager.audio:PlayUIAudio(2)

	return true
end

function EquipLevelUpView:MaterialAmountClickFunc(arg_30_1, arg_30_2)
	self.usedMaterialList_[arg_30_2.id] = self.usedMaterialList_[arg_30_2.id] or 0

	if self.usedMaterialList_[arg_30_2.id] <= 0 then
		return false
	end

	self.usedMaterialList_[arg_30_2.id] = self.usedMaterialList_[arg_30_2.id] - 1

	arg_30_1:RefreshTopAmount(self.usedMaterialList_[arg_30_2.id])
	self:RefreshEquipStrength()
	manager.audio:PlayUIAudio(2)

	return true
end

function EquipLevelUpView:GetEquip()
	return EquipData:GetEquipData(self.equipId_)
end

function EquipLevelUpView:GetItemList()
	return EquipTools.GetEquipLevelUpMaterial(self.order_, self.priority_, {
		self.equipId_
	})
end

function EquipLevelUpView:ShowEquipInfo(arg_33_1, arg_33_2)
	self.handler_:RefreshEquipInfo(EquipData:GetEquipData(arg_33_1), arg_33_2, function(arg_34_0)
		if arg_34_0 then
			arg_33_2:RefreshSelectState(false)

			self.usedEquipList_[arg_33_1] = nil

			self:RefreshEquipStrength()
		end

		arg_33_2:RefreshLock(arg_34_0)
	end)
end

function EquipLevelUpView:OnEquipStrengthSuccess(arg_35_1, arg_35_2, arg_35_3)
	if arg_35_3.equipId == self.equipId_ then
		self.handler_:RefreshSideBar(self.equipId_)
	end

	if arg_35_2 then
		JumpTools.OpenPageByJump("equipCulturePopView", arg_35_3)
	end

	self.handler_:HidePop()

	self.usedMaterialList_ = {}
	self.usedEquipList_ = {}
	self.itemList = self:GetItemList()

	self:RefreshListSelect()
	self:RefreshList()
end

function EquipLevelUpView:OnGoldChange(arg_36_1)
	if arg_36_1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		self:RefreshEquipStrength()
	end
end

function EquipLevelUpView:OnExit()
	CommonFilterData:ClearFilter(Filter_Root_Define.Equip_Filter_List.filter_id)
	self:RemoveAllEventListener()
end

function EquipLevelUpView:OnFilterChange()
	local var_38_0 = CommonFilterData:HasIndexFlag(2, 4, 13)
	local var_38_1 = CommonFilterData:HasIndexFlag(2, 5, 15)

	self:ChangeEquipSelectView((CommonFilterData:HasIndexFlag(2, 4, 14) or nil) and (EquipConst.EQUIP_SORT.RARE or EquipConst.EQUIP_SORT.LEVEL), CommonFilterData:HasIndexFlag(2, 5, 16) and 0 or 1)
end

function EquipLevelUpView:Dispose()
	self:RemoveAllListeners()

	if self.scrollHelper then
		self.scrollHelper:Dispose()

		self.scrollHelper = nil
	end

	EquipLevelUpView.super.Dispose(self)
end

return EquipLevelUpView
