local WeaponQuickView = class("WeaponQuickView", ReduxView)
local var_0_1 = {
	can_level_up = "CAN_LEVEL_UP",
	break_material_limit = "UPGRADE_MATERIAL_LACK",
	level_material_limit = "LEVELUP_MATERIAL_LACK",
	gold_limit = "LACK_CURRENCY",
	user_level_limit = "ERROR_USER_LEVEL_LIMIT"
}

function WeaponQuickView:UIName()
	return "Widget/System/Hero_key/HeroKeyPopUI"
end

function WeaponQuickView:UIParent()
	return manager.ui.uiPop.transform
end

function WeaponQuickView:Init()
	self:BindCfgUI()
	self:BindController()
	self:AddUIListener()

	self.scrollHelper_ = LuaList.New(handler(self, self.RenderItem), self.uiListGo_, CommonItemView)
end

function WeaponQuickView:OnEnter()
	self:InitContext()
	self:InitData()
	self:InitSlider()
	self:OnTargetLevelChanged()
	self:RefreshUI()
end

function WeaponQuickView:OnTop()
	if self.heroID then
		local var_5_0 = deepClone(HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT):GetHeroWeaponInfo(self.heroID))

		if var_5_0.level == HeroConst.WEAPON_LV_MAX then
			JumpTools.Back()

			return
		end

		if not self:DeepCompare(var_5_0, self.weaponInfo) then
			self.weaponInfo = var_5_0

			self:InitContext()
			self:InitData()
			self:InitSlider()
			self:OnTargetLevelChanged()
		else
			self:InitContext()
			self:InitData()
			self:OnTargetLevelChanged()
		end
	end

	self:RefreshUI()
	manager.windowBar:SetAsLastSibling()
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_GOLD
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
end

function WeaponQuickView:OnBehind()
	manager.windowBar:HideBar()
end

function WeaponQuickView:OnExit()
	return
end

function WeaponQuickView:BindController()
	self.tipController_ = self.tipControllerEx_:GetController("tip")
	self.toggleController_ = self.toggleControllerEx_:GetController("select")
	self.btnController_ = self.mainControllerEx_:GetController("btnState")
end

function WeaponQuickView:Dispose()
	self.scrollHelper_:Dispose()
	self:RemoveAllListeners()
	WeaponQuickView.super.Dispose(self)
end

function WeaponQuickView:InitContext()
	self.context = {
		cost = 0,
		breakNum = 0,
		state = "",
		can_level_up = false,
		totalExp = 0,
		needExp = 0,
		material_list = {},
		servant_list = {},
		break_material_list = {}
	}
end

function WeaponQuickView:InitData()
	self.all_material_list = {}
	self.all_servant_list = {}
	self.weaponInfo = {}
	self.heroID = 0
	self.targetLevel = 0
	self.isBreak = false
	self.addInteract_ = true
	self.subInteract_ = true
	self.sliderInteract_ = true

	self:InitMaterialList()

	self.heroID = self.params_.heroID
	self.weaponInfo = deepClone(HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT):GetHeroWeaponInfo(self.heroID))
end

function WeaponQuickView:InitMaterialList()
	local var_12_0 = {}
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.MATERIAL]) do
		local var_12_2 = ItemTools.getItemNum(iter_12_1)

		if ItemCfg[iter_12_1].sub_type == MaterialConst.MATERIAL_TYPE.WEAPON_LEVEL_UP and var_12_2 > 0 then
			local var_12_3 = clone(ItemTemplateData)

			var_12_3.type = ItemConst.ITEM_TYPE.MATERIAL
			var_12_3.id = iter_12_1
			var_12_3.number = var_12_2
			var_12_3.index = 0
			var_12_3.selectStyle = false

			table.insert(var_12_0, var_12_3)
		end
	end

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		return ItemCfg[arg_13_0.id].rare < ItemCfg[arg_13_1.id].rare
	end)

	for iter_12_2, iter_12_3 in ipairs((ServantTools.GetServantLimited(true, true))) do
		local var_12_4 = clone(ItemTemplateData)

		var_12_4.type = ItemConst.ITEM_TYPE.WEAPON_SERVANT
		var_12_4.uid = iter_12_3.uid
		var_12_4.id = iter_12_3.id
		var_12_4.number = iter_12_3.stage
		var_12_4.addLevel = iter_12_3.stage
		var_12_4.index = 0
		var_12_4.selectStyle = false

		table.insert(var_12_1, var_12_4)
	end

	table.sort(var_12_1, function(arg_14_0, arg_14_1)
		local var_14_0 = WeaponServantCfg[arg_14_0.id].starlevel
		local var_14_1 = WeaponServantCfg[arg_14_1.id].starlevel
		local var_14_2 = arg_14_0.number
		local var_14_3 = arg_14_1.number
		local var_14_4 = WeaponServantCfg[arg_14_0.id].race
		local var_14_5 = WeaponServantCfg[arg_14_1.id].race
		local var_14_6 = arg_14_0.id
		local var_14_7 = arg_14_1.id

		if not selectTrain and var_14_0 ~= var_14_1 then
			if selectDescSort then
				return var_14_1 < var_14_0
			else
				return var_14_0 < var_14_1
			end
		end

		if var_14_2 ~= var_14_3 then
			if selectDescSort then
				return var_14_3 < var_14_2
			else
				return var_14_2 < var_14_3
			end
		end

		if selectTrain and var_14_0 ~= var_14_1 then
			if selectDescSort then
				return var_14_1 < var_14_0
			else
				return var_14_0 < var_14_1
			end
		end

		if var_14_4 ~= var_14_5 then
			return var_14_4 < var_14_5
		end

		if var_14_6 ~= var_14_7 then
			if selectDescSort then
				return var_14_7 < var_14_6
			else
				return var_14_6 < var_14_7
			end
		end

		return arg_14_0.uid < arg_14_1.uid
	end)

	self.all_material_list = var_12_0
	self.all_servant_list = var_12_1
end

function WeaponQuickView:InitSlider()
	local var_15_0, var_15_1 = self:GetStartAndEndLevel()

	self.levelSlider_.minValue = var_15_0
	self.levelSlider_.maxValue = var_15_1

	local var_15_2 = 0

	for iter_15_0 = var_15_0, var_15_1 do
		if self:BuildContext(iter_15_0, false) then
			var_15_2 = iter_15_0
		else
			break
		end
	end

	self.levelSlider_.value = var_15_2

	if var_15_0 == var_15_1 then
		self.addInteract_ = false
		self.subInteract_ = false
		self.sliderInteract_ = false
		self.levelSlider_.minValue = var_15_0 - 1
		self.levelSlider_.value = var_15_1
	else
		self.addInteract_ = true
		self.subInteract_ = true
		self.sliderInteract_ = true
	end
end

function WeaponQuickView:AddUIListener()
	self:AddBtnListener(self.btn_noBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.btn_yesBtn_, nil, function()
		self:OnYesBtnClicked()
	end)
	self:AddBtnListener(self.toggle_, nil, function()
		self:ChangeBreak(not self.isBreak)
	end)
	self:AddPressingByTimeListener(self.addBtn_.gameObject, 3, 0.5, 0.2, function()
		if self.addInteract_ == false or self.sliderInteract_ == false then
			return
		end

		if self.levelSlider_.value < self.levelSlider_.maxValue then
			self.levelSlider_.value = math.min(self.levelSlider_.value + 1, self.levelSlider_.maxValue)

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.subBtn_.gameObject, 3, 0.5, 0.2, function()
		if self.subInteract_ == false or self.sliderInteract_ == false then
			return
		end

		if self.levelSlider_.value > self.levelSlider_.minValue then
			self.levelSlider_.value = math.max(self.levelSlider_.value - 1, self.levelSlider_.minValue)

			return true
		end

		return false
	end)
	self.levelSlider_.onValueChanged:AddListener(function()
		self:OnTargetLevelChanged()
	end)
end

function WeaponQuickView:OnYesBtnClicked()
	if checkGold(self.context.cost, false) then
		WeaponAction.WeaponLvUp(self.heroID, self.context.material_list, self.context.servant_list, self.targetLevel, self.context.breakNum, self.context.needExp, self.weaponInfo.breakthrough, self.weaponInfo.level)
		JumpTools.Back()
	else
		local var_23_0 = false

		for iter_23_0, iter_23_1 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND] or {}) do
			if ItemTools.getItemNum(iter_23_1) > 0 then
				var_23_0 = true

				break
			end
		end

		if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] or var_23_0 then
			JumpTools.OpenPopUp("currencyBuyGold", nil, ViewConst.SYSTEM_ID.BUY_GOLD)
		end
	end
end

function WeaponQuickView:OnTargetLevelChanged()
	self.targetLevel = self.levelSlider_.value
	self.addInteract_ = self.levelSlider_.value ~= self.levelSlider_.maxValue
	self.subInteract_ = self.levelSlider_.value ~= self.levelSlider_.minValue

	self:ChangeBreak(false)
	self:BuildContext(self.targetLevel, false)

	local var_24_0, var_24_1 = self:CheckQuickLv(self.targetLevel, false)

	self:RefreshUI()
end

function WeaponQuickView:ChangeBreak(arg_25_1)
	self.isBreak = arg_25_1

	self.toggleController_:SetSelectedState(arg_25_1 and "on" or "off")

	if arg_25_1 then
		self:RefreshBreak()
		self:BuildContext(self.targetLevel, self.isBreak)
	else
		self:BuildContext(self.targetLevel, self.isBreak)
		self:RefreshBreak()
	end

	self:RefreshUI()
end

function WeaponQuickView:RefreshUI()
	self:RefreshText()
	self:RefreshState()
	self:RefreshItem()
	self:RefreshInteract()
end

function WeaponQuickView:RefreshBreak()
	if self:CanChooseBreak(self.targetLevel) and (self:CheckQuickLv(self.targetLevel, false) or self.context.state == var_0_1.gold_limit) then
		SetActive(self.toggle_.gameObject, true)
	else
		SetActive(self.toggle_.gameObject, false)
	end
end

function WeaponQuickView:RefreshText()
	self.leftLvTxt_.text = tostring(self.weaponInfo.level)
	self.rightLvTxt_.text = tostring(self.targetLevel)
	self.goldText_.text = not checkGold(self.context.cost, false) and "<color='#FF0000'>" .. tostring(self.context.cost) .. "</color>" or tostring(self.context.cost)
	self.lvNumText_.text = string.format(string.format(GetTips("LEVELUP_DIFF"), self.targetLevel - self.weaponInfo.level))
	self.breakText_.text = string.format(GetTips("UPGRADE_TIP"), self.targetLevel + 10)

	local var_28_0 = ""

	if self.context.state == var_0_1.user_level_limit then
		var_28_0 = GetTips(self.context.state)
	elseif self.context.state == var_0_1.break_material_limit then
		var_28_0 = GetTips(self.context.state)
	elseif self.context.state == var_0_1.level_material_limit then
		local var_28_1, var_28_2 = WeaponTools.GetMaterialAndNum(GameLevelSetting[self.targetLevel].weapon_lv_exp_sum - self.weaponInfo.exp - self.context.totalExp)

		var_28_0 = string.format(GetTips("LEVELUP_MATERIAL_LACK"), GameLevelSetting[self.targetLevel].weapon_lv_exp_sum - self.weaponInfo.exp - self.context.totalExp, var_28_1, var_28_2)
	elseif self.context.state == var_0_1.gold_limit then
		var_28_0 = GetTips(self.context.state)
	end

	self.conditionText_.text = var_28_0
end

function WeaponQuickView:RefreshState()
	if self.context.can_level_up or self.context.state == var_0_1.gold_limit then
		if self:CanChooseBreak(self.targetLevel) then
			self.tipController_:SetSelectedState("break")

			if not self.isBreak and self.weaponInfo.level == self.targetLevel then
				self.btnController_:SetSelectedState("hide")
			else
				self.btnController_:SetSelectedState("show")
			end
		else
			self.tipController_:SetSelectedState("yes")
			self.btnController_:SetSelectedState("show")
		end
	else
		self.tipController_:SetSelectedState("no")
		self.btnController_:SetSelectedState("hide")
	end
end

function WeaponQuickView:RefreshItem()
	self.scrollHelper_:StartScroll(#self.context.material_list + #self.context.break_material_list + #self.context.servant_list)
end

function WeaponQuickView:RefreshInteract()
	self.addBtn_.interactable = self.addInteract_ ~= false
	self.subBtn_.interactable = self.subInteract_ ~= false

	if self.sliderInteract_ == false then
		self.addBtn_.interactable = false
		self.subBtn_.interactable = false
		self.levelSlider_.interactable = false
	else
		self.levelSlider_.interactable = true
	end
end

function WeaponQuickView:RenderItem(arg_32_1, arg_32_2)
	local var_32_0 = 1

	if arg_32_1 > #self.context.material_list + #self.context.break_material_list then
		var_32_0 = 3
		arg_32_1 = arg_32_1 - #self.context.material_list - #self.context.break_material_list
	elseif #self.context.material_list < arg_32_1 then
		var_32_0 = 2
		arg_32_1 = arg_32_1 - #self.context.material_list
	end

	if var_32_0 == 1 then
		local var_32_2 = ItemTools.getItemNum(self.context.material_list[arg_32_1].id)
		local var_32_3 = clone(ItemTemplateData)

		var_32_3.index = arg_32_1
		var_32_3.bottomText = {
			var_32_2,
			self.context.material_list[arg_32_1].num
		}
		var_32_3.id = self.context.material_list[arg_32_1].id
		var_32_3.number = nil

		function var_32_3:clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
				self.id,
				var_32_2
			})
		end

		arg_32_2:SetData(var_32_3)

		arg_32_2.infoProxy = self.context.material_list[arg_32_1]
	elseif var_32_0 == 2 then
		self.context.break_material_list[arg_32_1].index = arg_32_1

		local var_32_4 = ItemTools.getItemNum(self.context.break_material_list[arg_32_1][1])
		local var_32_5 = clone(ItemTemplateData)

		var_32_5.index = arg_32_1
		var_32_5.bottomText = {
			var_32_4,
			self.context.break_material_list[arg_32_1][2]
		}
		var_32_5.id = self.context.break_material_list[arg_32_1][1]
		var_32_5.number = nil

		function var_32_5:clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
				self.id,
				var_32_4
			})
		end

		arg_32_2:SetData(var_32_5)
	elseif var_32_0 == 3 then
		local var_32_6 = WeaponTools.GetServantByUid(self.all_servant_list, self.context.servant_list[arg_32_1])
		local var_32_7 = ItemTools.getItemNum(var_32_6.id)
		local var_32_8 = clone(ItemTemplateData)

		var_32_8.index = arg_32_1
		var_32_8.id = var_32_6.id
		var_32_8.number = nil

		function var_32_8:clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
				self.id,
				var_32_7
			})
		end

		arg_32_2:SetData(var_32_8)

		arg_32_2.infoProxy = var_32_6
	end
end

function WeaponQuickView:GetStartAndEndLevel()
	local var_36_0 = 0

	if self.context.materialList then
		for iter_36_0 = 1, #self.context.materialList do
			var_36_0 = var_36_0 == 0 and ItemCfg[self.context.materialList[iter_36_0].id].param[1] or math.min(var_36_0, ItemCfg[self.context.materialList[iter_36_0].id].param[1])
		end
	end

	if self.context.servantList then
		for iter_36_1 = 1, #self.context.servantList do
			local var_36_1 = self.context.servantList[iter_36_1]

			if not (ItemCfg[self.context.servantList[iter_36_1].id].rare >= 4 or var_36_1.number ~= 1) then
				var_36_0 = var_36_0 == 0 and GameSetting.base_exp_weapon_servant.value[ItemCfg[var_36_1.id].rare] or math.min(var_36_0, GameSetting.base_exp_weapon_servant.value[ItemCfg[var_36_1.id].rare])
			end
		end
	end

	local var_36_2, var_36_3, var_36_4, var_36_5 = WeaponTools.AddWeaponExp(self.weaponInfo.exp, self.weaponInfo.breakthrough, var_36_0)

	if var_36_3 == self.weaponInfo.level then
		var_36_3 = var_36_3 + 1
	end

	return var_36_3, HeroConst.WEAPON_LV_MAX
end

function WeaponQuickView:CanChooseBreak(arg_37_1)
	for iter_37_0 = 1, #GameSetting.weapon_exp_limit.value - 1 do
		if GameSetting.weapon_exp_limit.value[iter_37_0] == arg_37_1 then
			return true
		end
	end

	return false
end

function WeaponQuickView:BuildContext(arg_38_1, arg_38_2)
	self:InitContext()

	self.targetLevel = arg_38_1
	self.context.material_list, self.context.servant_list, self.context.totalExp = WeaponTools.QuickSelectList(self.all_material_list, self.all_servant_list, GameLevelSetting[arg_38_1].weapon_lv_exp_sum - self.weaponInfo.exp)
	self.context.needExp = GameLevelSetting[arg_38_1].weapon_lv_exp_sum - self.weaponInfo.exp
	self.context.cost = self.context.cost + (GameLevelSetting[arg_38_1].weapon_lv_exp_sum - self.weaponInfo.exp) * GameSetting.weapon_strengthen_gold_cost.value[1]

	local var_38_0 = 0

	self.context.break_material_list = {}

	for iter_38_0, iter_38_1 in ipairs(GameSetting.weapon_exp_limit.value) do
		if iter_38_1 < arg_38_1 then
			var_38_0 = var_38_0 + 1
		end
	end

	if arg_38_2 then
		var_38_0 = var_38_0 + 1
	end

	for iter_38_2 = self.weaponInfo.breakthrough, var_38_0 - 1 do
		local var_38_1, var_38_2 = WeaponTools.BreakMaterial(iter_38_2)

		self.context.cost = self.context.cost + var_38_1
		self.context.break_material_list = WeaponTools.MergeMaterialList(self.context.break_material_list, var_38_2)
	end

	self.context.breakNum = var_38_0 - self.weaponInfo.breakthrough
	self.context.can_level_up, self.context.state = self:CheckQuickLv(self.targetLevel, arg_38_2)

	return self.context.can_level_up
end

function WeaponQuickView:CheckQuickLv(arg_39_1, arg_39_2)
	local var_39_0 = 0

	for iter_39_0, iter_39_1 in ipairs(GameSetting.weapon_exp_limit.value) do
		if iter_39_1 < self.targetLevel then
			var_39_0 = var_39_0 + 1
		end

		if self.targetLevel == iter_39_1 and arg_39_2 then
			var_39_0 = var_39_0 + 1
		end
	end

	if var_39_0 > 0 and PlayerData:GetPlayerInfo().userLevel < GameSetting.weapon_user_limit.value[var_39_0] then
		return false, var_0_1.user_level_limit
	end

	for iter_39_2, iter_39_3 in pairs(self.context.break_material_list) do
		if ItemTools.getItemNum(iter_39_3[1]) < iter_39_3[2] then
			return false, var_0_1.break_material_limit
		end
	end

	if GameLevelSetting[arg_39_1].weapon_lv_exp_sum - self.weaponInfo.exp > self.context.totalExp then
		return false, var_0_1.level_material_limit
	end

	if not checkGold(self.context.cost, false) then
		return false, var_0_1.gold_limit
	end

	return true, var_0_1.can_level_up
end

function WeaponQuickView:DeepCompare(arg_40_1, arg_40_2)
	if type(arg_40_1) ~= "table" or type(arg_40_2) ~= "table" then
		return arg_40_1 == arg_40_2
	end

	for iter_40_0, iter_40_1 in pairs(arg_40_1) do
		if not self:DeepCompare(arg_40_2[iter_40_0], iter_40_1) then
			return false
		end
	end

	for iter_40_2, iter_40_3 in pairs(arg_40_2) do
		if not self:DeepCompare(arg_40_1[iter_40_2], iter_40_3) then
			return false
		end
	end

	return true
end

function WeaponQuickView:CheckCanBreak(arg_41_1)
	local var_41_0 = 1

	for iter_41_0, iter_41_1 in ipairs(GameSetting.weapon_exp_limit.value) do
		if iter_41_1 < arg_41_1 then
			var_41_0 = var_41_0 + 1
		end
	end

	if var_41_0 > 0 and PlayerData:GetPlayerInfo().userLevel < GameSetting.weapon_user_limit.value[var_41_0] then
		return false, var_0_1.user_level_limit
	end

	return true
end

return WeaponQuickView
