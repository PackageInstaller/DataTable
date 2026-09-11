local WeaponLvupView = class("WeaponLvupView", ReduxView)

function WeaponLvupView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:Init()
end

function WeaponLvupView:Init()
	self:buildController()
	self:buildContext()

	self.scrollHelper_ = LuaList.New(handler(self, self.RenderItem), self.itemList_, CommonItemView)

	self:AddUIListener()
end

function WeaponLvupView:OnEnter()
	self:RegistEventListener(COMMON_FILTER_OK, handler(self, self.OnFilterChange))
	self:RegistEventListener(WEAPON_STR, function(arg_4_0, arg_4_1)
		self:OnWeaponUpgrade(arg_4_0, arg_4_1)
	end)
end

function WeaponLvupView:OnExit()
	CommonFilterData:ClearFilter(Filter_Root_Define.Weapon_LevelUp_Cost_List.filter_id)
	self:RemoveAllEventListener()
end

function WeaponLvupView:buildController()
	self.controller_ = {
		comps = self.gameObject_:GetComponent("ControllerExCollection"),
		state = {
			levelMax = {
				Max = "max",
				name = "levelMax",
				Normal = "normal"
			}
		}
	}
	self.addStatusController = self.controller_.comps:GetController("addStatus")
end

function WeaponLvupView:SwitchControllerState(arg_7_1, arg_7_2)
	local var_7_0 = self.controller_.comps:GetController(arg_7_1)

	if var_7_0 then
		var_7_0:SetSelectedState(arg_7_2)
	end
end

function WeaponLvupView:buildContext(arg_8_1)
	arg_8_1 = arg_8_1 or HeroConst.HERO_DATA_TYPE.DEFAULT
	self.context = {
		totalCount = 0,
		materialCount = 0,
		totalSelect = 0,
		heroId = 0,
		servantCount = 0,
		materialList = {},
		servantList = {},
		weaponInfo = {},
		type = arg_8_1,
		dataPorxy = HeroViewDataProxy.New(arg_8_1)
	}
	self.constVar = {
		yellow = "363A42",
		sliderBarWidth = 501,
		red = "CD421E"
	}
end

function WeaponLvupView:AddUIListener()
	self:AddBtnListener(self.quickSelectBtn_, nil, function()
		self:QuickSelectBtnClick()
	end)
	self:AddBtnListener(self.upgradeBtn_, nil, function()
		self:OnUpgradeBtnClick()
	end)
	self:AddBtnListener(self.filterBtn_, nil, function()
		self:OnFilterBtnClick()
	end)
	self:AddBtnListener(self.quickLvUpBtn_, nil, function()
		JumpTools.OpenPageByJump("weaponQuickLevelUp", {
			heroID = self.context.heroId,
			weaponInfo = self.context.weaponInfo
		})
	end)
end

function WeaponLvupView:ShowWeaponInfoLocal()
	self:UpdateWeaponInfo()
	self:ShowWeaponInfo(self.context.heroId, self.context.weaponInfo)
end

function WeaponLvupView:ShowWeaponInfo(arg_15_1, arg_15_2, arg_15_3)
	self:buildContext(arg_15_3)

	self.context.weaponInfo = arg_15_2
	self.context.heroId = arg_15_1

	self:RenderView()

	if not self:CheckWeaponIsMaxLevel() then
		self:RefreshMaterialList()
		self.scrollHelper_:StartScroll(self.context.totalCount, 0)
	end
end

function WeaponLvupView:RenderView()
	if not self:CheckWeaponIsMaxLevel() then
		self:SwitchControllerState(self.controller_.state.levelMax.name, self.controller_.state.levelMax.Normal)
		self:RenderNormalView()
	else
		self:SwitchControllerState(self.controller_.state.levelMax.name, self.controller_.state.levelMax.Max)
		self:RenderMaxView()
	end
end

function WeaponLvupView:RenderNormalView()
	local var_17_0 = self.context.weaponInfo
	local var_17_1 = WeaponTools.WeaponAtk(self.context.weaponInfo.level, self.context.weaponInfo.breakthrough)
	local var_17_2, var_17_3, var_17_4, var_17_5 = WeaponTools.AddWeaponExp(self.context.weaponInfo.exp, self.context.weaponInfo.breakthrough, self.context.totalSelect)
	local var_17_6 = GameLevelSetting[var_17_3].weapon_level_exp
	local var_17_7 = WeaponTools.WeaponAtk(var_17_3, self.context.weaponInfo.breakthrough)

	self.originatkText_.text = string.format("%d", var_17_1)
	self.originatk2Text_.text = string.format("%d", var_17_1)
	self.afteratkText_.text = string.format("%d", var_17_7)
	self.atkArrowImg_.color = var_17_7 ~= var_17_1 and Color.New(1, 0.4431373, 0, 1) or Color.New(0.2117647, 0.227451, 0.2588235, 1)

	local var_17_8 = var_17_2 / var_17_6 * self.constVar.sliderBarWidth
	local var_17_9, var_17_10, var_17_11 = WeaponTools.AddWeaponExp(var_17_0.exp, var_17_0.breakthrough, 0)

	if var_17_3 > var_17_0.level then
		self.realExpTrans_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 0)
		self.fakeExpTrans_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, var_17_8)
	else
		self.realExpTrans_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, var_17_9 / GameLevelSetting[var_17_0.level].weapon_level_exp * self.constVar.sliderBarWidth)
		self.fakeExpTrans_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, var_17_8)
	end

	self.afterlvText_.text = var_17_3
	self.exptextText_.text = var_17_3 >= HeroConst.WEAPON_LV_MAX and "-/-" or var_17_2 .. "/" .. var_17_6
	self.totalexpText_.text = "+" .. self.context.totalSelect
	self.originlvText_.text = var_17_0.level

	if self.context.totalSelect == 0 and var_17_0.level == var_17_3 then
		self.addStatusController:SetSelectedState("normal")
	else
		SetActive(self.showMax_, var_17_5)
		self.addStatusController:SetSelectedState("add")
	end

	self:RenderCost()
end

function WeaponLvupView:RenderMaxView()
	local var_18_0, var_18_1 = SkillTools.GetAttr(HeroCfg[self.context.heroId].weapon_break_attribute[self.context.weaponInfo.breakthrough])

	self.maxLevelTxt_.text = HeroConst.WEAPON_LV_MAX
	self.maxAttackNumTxt_.text = math.floor((WeaponTools.WeaponAtk(self.context.weaponInfo.level, self.context.weaponInfo.breakthrough)))
	self.maxSubNameTxt_.text = var_18_0
	self.maxSubNumTxt_.text = var_18_1
end

function WeaponLvupView:RenderItem(arg_19_1, arg_19_2)
	local var_19_0 = 1

	if arg_19_1 > self.context.materialCount then
		var_19_0 = 2
		arg_19_1 = arg_19_1 - self.context.materialCount
	end

	local var_19_1

	if var_19_0 == 1 then
		var_19_1 = self.context.materialList[arg_19_1]
	elseif var_19_0 == 2 then
		var_19_1 = self.context.servantList[arg_19_1]
	end

	var_19_1.index = arg_19_1

	if var_19_1.type == ItemConst.ITEM_TYPE.MATERIAL then
		function var_19_1.longClickFun(arg_20_0)
			self:RenderView(true)

			return (self:OnMaterialLongPress(var_19_1, arg_19_2))
		end
	elseif var_19_1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		function var_19_1.clickFun(arg_21_0)
			self:OnServantClick(var_19_1, arg_19_2)
			self:RenderView(true)
		end
	end

	function var_19_1.clickAmountFun(arg_22_0)
		self:RenderView(true)

		return (self:OnMaterialCutClick(var_19_1, arg_19_2))
	end

	arg_19_2:SetData(var_19_1)
	arg_19_2:RefreshGray(var_19_1.topAmountValue and var_19_1.topAmountValue > 0)

	arg_19_2.infoProxy = var_19_1
end

function WeaponLvupView:RenderCost()
	self.tokenTxt_.text = setTextColor(self.constVar.yellow, self.constVar.red, self.context.totalSelect * GameSetting.weapon_strengthen_gold_cost.value[1], (ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)))
end

function WeaponLvupView:OnGoldChange()
	self:RenderCost()
	self:RenderView()
end

function WeaponLvupView:OnWeaponUpgrade(arg_25_1, arg_25_2)
	local var_25_0, var_25_1, var_25_2 = WeaponTools.AddWeaponExp(self.context.weaponInfo.exp, self.context.weaponInfo.breakthrough, self.context.totalSelect)

	if self.context.weaponInfo.level == var_25_1 then
		ShowTips("SUCCESS_STRENGTHEN")
		self:ShowWeaponInfoLocal()

		return
	end

	self:ShowWeaponInfoLocal()
	JumpTools.OpenPageByJump("weaponStr", {
		oriLv = self.context.weaponInfo.level,
		afterLv = var_25_1,
		breakthrough = self.context.weaponInfo.breakthrough,
		callback = function()
			getReward(formatRewardCfgList((MaterialTools.materialGiveBack(var_25_2, ItemConst.STR_ITEM.WEAPON))))
		end
	})
end

function WeaponLvupView:OnMaterialLongPress(arg_27_1, arg_27_2)
	local var_27_0, var_27_1, var_27_2, var_27_3 = WeaponTools.AddWeaponExp(self.context.weaponInfo.exp, self.context.weaponInfo.breakthrough, self.context.totalSelect)

	if var_27_3 then
		ShowTips("LEVEL_MAX")

		return false
	end

	if arg_27_1.number > arg_27_1.topAmountValue then
		arg_27_1.topAmountValue = arg_27_1.topAmountValue + 1
		self.context.totalSelect = self.context.totalSelect + ItemCfg[arg_27_1.id].param[1]

		manager.audio:PlayUIAudio(2)
		arg_27_2:RefreshTopAmount(arg_27_1.topAmountValue)

		return true
	else
		return false
	end
end

function WeaponLvupView:OnServantClick(arg_28_1, arg_28_2)
	local var_28_0, var_28_1, var_28_2, var_28_3 = WeaponTools.AddWeaponExp(self.context.weaponInfo.exp, self.context.weaponInfo.breakthrough, self.context.totalSelect)

	if arg_28_1.topAmountValue == 1 then
		arg_28_1.topAmountValue = 0
		self.context.totalSelect = self.context.totalSelect - GameSetting.base_exp_weapon_servant.value[ItemCfg[arg_28_1.id].rare]
	elseif arg_28_1.topAmountValue == 0 then
		if var_28_3 then
			ShowTips("LEVEL_MAX")

			return false
		end

		arg_28_1.topAmountValue = 1
		self.context.totalSelect = self.context.totalSelect + GameSetting.base_exp_weapon_servant.value[ItemCfg[arg_28_1.id].rare]
	end

	arg_28_2:RefreshTopAmount(arg_28_1.topAmountValue)
end

function WeaponLvupView:OnMaterialCutClick(arg_29_1, arg_29_2)
	if arg_29_1.type == ItemConst.ITEM_TYPE.MATERIAL then
		if arg_29_1.topAmountValue >= 1 then
			arg_29_1.topAmountValue = arg_29_1.topAmountValue - 1
			self.context.totalSelect = self.context.totalSelect - ItemCfg[arg_29_1.id].param[1]

			arg_29_2:RefreshTopAmount(arg_29_1.topAmountValue)
			manager.audio:PlayUIAudio(2)

			return true
		end
	elseif arg_29_1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		arg_29_1.topAmountValue = math.max(arg_29_1.topAmountValue - 1, 0)
		self.context.totalSelect = self.context.totalSelect - GameSetting.base_exp_weapon_servant.value[ItemCfg[arg_29_1.id].rare]

		arg_29_2:RefreshTopAmount(arg_29_1.topAmountValue)
	end

	return false
end

function WeaponLvupView:QuickSelectBtnClick()
	self.context.totalSelect = self:QuickSelectList(self.context.materialList, self.context.servantList, WeaponTools.CurMaxExp(self.context.weaponInfo.breakthrough) - self.context.weaponInfo.exp)

	for iter_30_0, iter_30_1 in pairs((self.scrollHelper_:GetItemList())) do
		iter_30_1:RefreshTopAmount(iter_30_1.infoProxy.topAmountValue)
	end

	self:RenderView()
end

function WeaponLvupView:OnUpgradeBtnClick()
	if self.context.totalSelect == 0 then
		ShowTips("PLEASE_SELECT_ITEM")

		return
	end

	local var_31_0, var_31_1, var_31_2 = WeaponTools.AddWeaponExp(self.context.weaponInfo.exp, self.context.weaponInfo.breakthrough, self.context.totalSelect)

	if not checkGold((self.context.totalSelect - var_31_2) * GameSetting.weapon_strengthen_gold_cost.value[1], true) then
		return
	end

	local var_31_3 = false
	local var_31_4 = self.context.heroId
	local var_31_5 = {}

	for iter_31_0, iter_31_1 in pairs(self.context.materialList) do
		if iter_31_1.topAmountValue ~= 0 then
			table.insert(var_31_5, {
				id = iter_31_1.id,
				num = iter_31_1.topAmountValue
			})
		end
	end

	local var_31_6 = {}

	for iter_31_2, iter_31_3 in pairs(self.context.servantList) do
		if iter_31_3.topAmountValue ~= 0 then
			if ItemCfg[iter_31_3.id].rare == 5 then
				var_31_3 = true
			end

			table.insert(var_31_6, iter_31_3.uid)
		end
	end

	local var_31_7
	local var_31_8 = MaterialTools.materialGiveBack(var_31_2, ItemConst.STR_ITEM.WEAPON)

	if #var_31_8 > 0 then
		var_31_7 = var_31_3 and string.format(GetTips("WEAPON_STRENGTH_EXP_OVERFLOW_AND_RARE")) or string.format(GetTips("WEAPON_STRENGTH_EXP_OVERFLOW"))

		self:Go("materialPreview", {
			content = var_31_7,
			OkCallback = function()
				WeaponAction.WeaponStr(var_31_4, var_31_5, var_31_6, self.context.totalSelect)
			end,
			itemList = var_31_8
		})

		return
	end

	if var_31_3 then
		ShowMessageBox({
			title = "Warning",
			content = string.format(GetTips("WEAPON_STRENGTH_COST_RARE")),
			OkCallback = function()
				OperationRecorder.Record("hero", "weaponOKUpgrade")
				WeaponAction.WeaponStr(var_31_4, var_31_5, var_31_6, self.context.totalSelect)
			end,
			CancelCallback = function()
				OperationRecorder.Record("hero", "weaponCancelUpgrade")
			end
		})

		return
	end

	WeaponAction.WeaponStr(self.context.heroId, var_31_5, var_31_6, self.context.totalSelect)
end

function WeaponLvupView:OnFilterBtnClick()
	JumpTools.OpenPageByJump("commonFilterView", {
		filterGroup = Filter_Root_Define.Weapon_LevelUp_Cost_List
	})
end

function WeaponLvupView:OnFilterChange()
	self:ShowWeaponInfoLocal()
end

function WeaponLvupView:CheckWeaponIsMaxLevel()
	if self.context.weaponInfo then
		return self.context.weaponInfo.level == HeroConst.WEAPON_LV_MAX
	end

	return false
end

function WeaponLvupView:RefreshMaterialList()
	local var_38_0 = {}
	local var_38_1 = {}
	local var_38_2 = CommonFilterData:HasIndexFlag(Filter_Root_Define.Weapon_LevelUp_Cost_List.filter_id, Filter_Group_Define.TYPE.groupID, Filter_Tags_Define.Train)
	local var_38_3 = CommonFilterData:HasIndexFlag(Filter_Root_Define.Weapon_LevelUp_Cost_List.filter_id, Filter_Group_Define.TYPE.groupID, Filter_Tags_Define.StarLevel)
	local var_38_4 = CommonFilterData:HasIndexFlag(Filter_Root_Define.Weapon_LevelUp_Cost_List.filter_id, Filter_Group_Define.SORT.groupID, Filter_Tags_Define.DESCending)

	for iter_38_0, iter_38_1 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.MATERIAL]) do
		local var_38_5 = ItemTools.getItemNum(iter_38_1)

		if ItemCfg[iter_38_1].sub_type == MaterialConst.MATERIAL_TYPE.WEAPON_LEVEL_UP and var_38_5 > 0 then
			local var_38_6 = clone(ItemTemplateData)

			var_38_6.type = ItemConst.ITEM_TYPE.MATERIAL
			var_38_6.id = iter_38_1
			var_38_6.number = var_38_5
			var_38_6.index = 0
			var_38_6.selectStyle = false

			table.insert(var_38_0, var_38_6)
		end
	end

	table.sort(var_38_0, function(arg_39_0, arg_39_1)
		return ItemCfg[arg_39_0.id].rare < ItemCfg[arg_39_1.id].rare
	end)

	for iter_38_2, iter_38_3 in ipairs((ServantTools.GetServantLimited(true, true))) do
		local var_38_7 = clone(ItemTemplateData)

		var_38_7.type = ItemConst.ITEM_TYPE.WEAPON_SERVANT
		var_38_7.uid = iter_38_3.uid
		var_38_7.id = iter_38_3.id
		var_38_7.number = iter_38_3.stage
		var_38_7.addLevel = iter_38_3.stage
		var_38_7.index = 0
		var_38_7.selectStyle = false

		table.insert(var_38_1, var_38_7)
	end

	table.sort(var_38_1, function(arg_40_0, arg_40_1)
		local var_40_0 = WeaponServantCfg[arg_40_0.id].starlevel
		local var_40_1 = WeaponServantCfg[arg_40_1.id].starlevel
		local var_40_2 = arg_40_0.number
		local var_40_3 = arg_40_1.number
		local var_40_4 = WeaponServantCfg[arg_40_0.id].race
		local var_40_5 = WeaponServantCfg[arg_40_1.id].race
		local var_40_6 = arg_40_0.id
		local var_40_7 = arg_40_1.id

		if not var_38_2 and var_40_0 ~= var_40_1 then
			if var_38_4 then
				return var_40_1 < var_40_0
			else
				return var_40_0 < var_40_1
			end
		end

		if var_40_2 ~= var_40_3 then
			if var_38_4 then
				return var_40_3 < var_40_2
			else
				return var_40_2 < var_40_3
			end
		end

		if var_38_2 and var_40_0 ~= var_40_1 then
			if var_38_4 then
				return var_40_1 < var_40_0
			else
				return var_40_0 < var_40_1
			end
		end

		if var_40_4 ~= var_40_5 then
			return var_40_4 < var_40_5
		end

		if var_40_6 ~= var_40_7 then
			if var_38_4 then
				return var_40_7 < var_40_6
			else
				return var_40_6 < var_40_7
			end
		end

		return arg_40_0.uid < arg_40_1.uid
	end)

	self.context.servantList = var_38_1
	self.context.materialList = var_38_0
	self.context.totalCount = #var_38_1 + #var_38_0
	self.context.materialCount = #var_38_0
	self.context.servantCount = #var_38_1
end

function WeaponLvupView:QuickSelectList(arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = arg_41_3
	local var_41_1 = {}

	for iter_41_0 = 1, #arg_41_1 do
		var_41_1[iter_41_0] = math.max(math.min(math.ceil(var_41_0 / ItemCfg[arg_41_1[iter_41_0].id].param[1]), arg_41_1[iter_41_0].number), 0)
		var_41_0 = var_41_0 - var_41_1[iter_41_0] * ItemCfg[arg_41_1[iter_41_0].id].param[1]

		if var_41_0 < 0 and iter_41_0 > 1 then
			for iter_41_1 = iter_41_0 - 1, 1, -1 do
				local var_41_2 = math.min(var_41_1[iter_41_1], (math.modf(-var_41_0 / ItemCfg[arg_41_1[iter_41_1].id].param[1])))

				var_41_1[iter_41_1] = math.max(0, var_41_1[iter_41_1] - var_41_2)
				var_41_0 = var_41_0 + ItemCfg[arg_41_1[iter_41_1].id].param[1] * var_41_2
			end
		end

		if var_41_0 <= 0 then
			break
		end
	end

	for iter_41_2 = 1, #arg_41_1 do
		if var_41_1[iter_41_2] == nil then
			var_41_1[iter_41_2] = 0
		end

		arg_41_1[iter_41_2].selectNum_ = var_41_1[iter_41_2]
		arg_41_1[iter_41_2].topAmountValue = var_41_1[iter_41_2]
	end

	for iter_41_3 = 1, #arg_41_2 do
		local var_41_4 = arg_41_2[iter_41_3]

		if not (ItemCfg[arg_41_2[iter_41_3].id].rare >= 4 or var_41_4.number ~= 1) then
			if var_41_0 <= 0 then
				var_41_4.topAmountValue = 0
			else
				var_41_4.topAmountValue = 1
				var_41_0 = var_41_0 - GameSetting.base_exp_weapon_servant.value[ItemCfg[var_41_4.id].rare]
			end
		else
			var_41_4.topAmountValue = 0
		end
	end

	return arg_41_3 - var_41_0
end

function WeaponLvupView:UpdateWeaponInfo()
	if self.context.heroId and self.context.heroId ~= 0 then
		self.context.weaponInfo = deepClone(self.context.dataPorxy:GetHeroWeaponInfo(self.context.heroId))
	end
end

function WeaponLvupView:Dispose()
	self.scrollHelper_:Dispose()
	self:RemoveAllListeners()
	WeaponLvupView.super.Dispose(self)
end

return WeaponLvupView
