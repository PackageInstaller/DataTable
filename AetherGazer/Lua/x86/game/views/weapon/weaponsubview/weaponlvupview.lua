local var_0_0 = class("WeaponLvupView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:buildController()
	arg_2_0:buildContext()

	arg_2_0.scrollHelper_ = LuaList.New(handler(arg_2_0, arg_2_0.RenderItem), arg_2_0.itemList_, CommonItemView)

	arg_2_0:AddUIListener()
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0:RegistEventListener(COMMON_FILTER_OK, handler(arg_3_0, arg_3_0.OnFilterChange))
	arg_3_0:RegistEventListener(WEAPON_STR, function(arg_4_0, arg_4_1)
		arg_3_0:OnWeaponUpgrade(arg_4_0, arg_4_1)
	end)
end

function var_0_0.OnExit(arg_5_0)
	CommonFilterData:ClearFilter(Filter_Root_Define.Weapon_LevelUp_Cost_List.filter_id)
	arg_5_0:RemoveAllEventListener()
end

function var_0_0.buildController(arg_6_0)
	arg_6_0.controller_ = {
		comps = arg_6_0.gameObject_:GetComponent("ControllerExCollection"),
		state = {
			levelMax = {
				Max = "max",
				name = "levelMax",
				Normal = "normal"
			}
		}
	}
	arg_6_0.addStatusController = arg_6_0.controller_.comps:GetController("addStatus")
end

function var_0_0.SwitchControllerState(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.controller_.comps:GetController(arg_7_1)

	if var_7_0 then
		var_7_0:SetSelectedState(arg_7_2)
	end
end

function var_0_0.buildContext(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_8_0.context = {
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
	arg_8_0.constVar = {
		yellow = "363A42",
		sliderBarWidth = 501,
		red = "CD421E"
	}
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.quickSelectBtn_, nil, function()
		arg_9_0:QuickSelectBtnClick()
	end)
	arg_9_0:AddBtnListener(arg_9_0.upgradeBtn_, nil, function()
		arg_9_0:OnUpgradeBtnClick()
	end)
	arg_9_0:AddBtnListener(arg_9_0.filterBtn_, nil, function()
		arg_9_0:OnFilterBtnClick()
	end)
	arg_9_0:AddBtnListener(arg_9_0.quickLvUpBtn_, nil, function()
		JumpTools.OpenPageByJump("weaponQuickLevelUp", {
			heroID = arg_9_0.context.heroId,
			weaponInfo = arg_9_0.context.weaponInfo
		})
	end)
end

function var_0_0.ShowWeaponInfoLocal(arg_14_0)
	arg_14_0:UpdateWeaponInfo()
	arg_14_0:ShowWeaponInfo(arg_14_0.context.heroId, arg_14_0.context.weaponInfo)
end

function var_0_0.ShowWeaponInfo(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0:buildContext(arg_15_3)

	arg_15_0.context.weaponInfo = arg_15_2
	arg_15_0.context.heroId = arg_15_1

	arg_15_0:RenderView()

	if not arg_15_0:CheckWeaponIsMaxLevel() then
		arg_15_0:RefreshMaterialList()
		arg_15_0.scrollHelper_:StartScroll(arg_15_0.context.totalCount, 0)
	end
end

function var_0_0.RenderView(arg_16_0)
	if not arg_16_0:CheckWeaponIsMaxLevel() then
		arg_16_0:SwitchControllerState(arg_16_0.controller_.state.levelMax.name, arg_16_0.controller_.state.levelMax.Normal)
		arg_16_0:RenderNormalView()
	else
		arg_16_0:SwitchControllerState(arg_16_0.controller_.state.levelMax.name, arg_16_0.controller_.state.levelMax.Max)
		arg_16_0:RenderMaxView()
	end
end

function var_0_0.RenderNormalView(arg_17_0)
	local var_17_0 = arg_17_0.context.weaponInfo
	local var_17_1 = var_17_0.breakthrough
	local var_17_2 = WeaponTools.WeaponAtk(var_17_0.level, var_17_1)
	local var_17_3, var_17_4, var_17_5, var_17_6 = WeaponTools.AddWeaponExp(var_17_0.exp, var_17_1, arg_17_0.context.totalSelect)
	local var_17_7 = GameLevelSetting[var_17_4].weapon_level_exp
	local var_17_8 = WeaponTools.WeaponAtk(var_17_4, var_17_1)

	arg_17_0.originatkText_.text = string.format("%d", var_17_2)
	arg_17_0.originatk2Text_.text = string.format("%d", var_17_2)
	arg_17_0.afteratkText_.text = string.format("%d", var_17_8)

	if var_17_8 ~= var_17_2 then
		arg_17_0.atkArrowImg_.color = Color.New(1, 0.4431373, 0, 1)
	else
		arg_17_0.atkArrowImg_.color = Color.New(0.2117647, 0.227451, 0.2588235, 1)
	end

	local var_17_9 = var_17_3 / var_17_7 * arg_17_0.constVar.sliderBarWidth
	local var_17_10, var_17_11, var_17_12 = WeaponTools.AddWeaponExp(var_17_0.exp, var_17_0.breakthrough, 0)
	local var_17_13 = var_17_10 / GameLevelSetting[var_17_0.level].weapon_level_exp * arg_17_0.constVar.sliderBarWidth

	if var_17_4 > var_17_0.level then
		arg_17_0.realExpTrans_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 0)
		arg_17_0.fakeExpTrans_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, var_17_9)
	else
		arg_17_0.realExpTrans_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, var_17_13)
		arg_17_0.fakeExpTrans_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, var_17_9)
	end

	arg_17_0.afterlvText_.text = var_17_4

	if var_17_4 >= HeroConst.WEAPON_LV_MAX then
		arg_17_0.exptextText_.text = "-/-"
	else
		arg_17_0.exptextText_.text = var_17_3 .. "/" .. var_17_7
	end

	arg_17_0.totalexpText_.text = "+" .. arg_17_0.context.totalSelect
	arg_17_0.originlvText_.text = var_17_0.level

	if arg_17_0.context.totalSelect == 0 and var_17_0.level == var_17_4 then
		arg_17_0.addStatusController:SetSelectedState("normal")
	else
		SetActive(arg_17_0.showMax_, var_17_6)
		arg_17_0.addStatusController:SetSelectedState("add")
	end

	arg_17_0:RenderCost()
end

function var_0_0.RenderMaxView(arg_18_0)
	local var_18_0 = arg_18_0.context.heroId
	local var_18_1 = arg_18_0.context.weaponInfo
	local var_18_2 = var_18_1.breakthrough
	local var_18_3 = WeaponTools.WeaponAtk(var_18_1.level, var_18_2)
	local var_18_4 = HeroCfg[var_18_0].weapon_break_attribute[var_18_1.breakthrough]
	local var_18_5, var_18_6 = SkillTools.GetAttr(var_18_4)

	arg_18_0.maxLevelTxt_.text = HeroConst.WEAPON_LV_MAX
	arg_18_0.maxAttackNumTxt_.text = math.floor(var_18_3)
	arg_18_0.maxSubNameTxt_.text = var_18_5
	arg_18_0.maxSubNumTxt_.text = var_18_6
end

function var_0_0.RenderItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = 1

	if arg_19_1 > arg_19_0.context.materialCount then
		var_19_0 = 2
		arg_19_1 = arg_19_1 - arg_19_0.context.materialCount
	end

	local var_19_1

	if var_19_0 == 1 then
		var_19_1 = arg_19_0.context.materialList[arg_19_1]
	elseif var_19_0 == 2 then
		var_19_1 = arg_19_0.context.servantList[arg_19_1]
	end

	var_19_1.index = arg_19_1

	if var_19_1.type == ItemConst.ITEM_TYPE.MATERIAL then
		function var_19_1.longClickFun(arg_20_0)
			local var_20_0 = arg_19_0:OnMaterialLongPress(var_19_1, arg_19_2)

			arg_19_0:RenderView(true)

			return var_20_0
		end
	elseif var_19_1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		function var_19_1.clickFun(arg_21_0)
			arg_19_0:OnServantClick(var_19_1, arg_19_2)
			arg_19_0:RenderView(true)
		end
	end

	function var_19_1.clickAmountFun(arg_22_0)
		local var_22_0 = arg_19_0:OnMaterialCutClick(var_19_1, arg_19_2)

		arg_19_0:RenderView(true)

		return var_22_0
	end

	arg_19_2:SetData(var_19_1)
	arg_19_2:RefreshGray(var_19_1.topAmountValue and var_19_1.topAmountValue > 0)

	arg_19_2.infoProxy = var_19_1
end

function var_0_0.RenderCost(arg_23_0)
	local var_23_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)
	local var_23_1 = arg_23_0.context.totalSelect * GameSetting.weapon_strengthen_gold_cost.value[1]
	local var_23_2 = setTextColor(arg_23_0.constVar.yellow, arg_23_0.constVar.red, var_23_1, var_23_0)

	arg_23_0.tokenTxt_.text = var_23_2
end

function var_0_0.OnGoldChange(arg_24_0)
	arg_24_0:RenderCost()
	arg_24_0:RenderView()
end

function var_0_0.OnWeaponUpgrade(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0.context.weaponInfo
	local var_25_1, var_25_2, var_25_3 = WeaponTools.AddWeaponExp(var_25_0.exp, var_25_0.breakthrough, arg_25_0.context.totalSelect)
	local var_25_4 = var_25_0.level
	local var_25_5 = var_25_2

	if var_25_4 == var_25_5 then
		ShowTips("SUCCESS_STRENGTHEN")
		arg_25_0:ShowWeaponInfoLocal()

		return
	end

	arg_25_0:ShowWeaponInfoLocal()

	local var_25_6 = arg_25_0.context.weaponInfo

	JumpTools.OpenPageByJump("weaponStr", {
		oriLv = var_25_4,
		afterLv = var_25_5,
		breakthrough = var_25_6.breakthrough,
		callback = function()
			local var_26_0 = MaterialTools.materialGiveBack(var_25_3, ItemConst.STR_ITEM.WEAPON)

			getReward(formatRewardCfgList(var_26_0))
		end
	})
end

function var_0_0.OnMaterialLongPress(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0.context.weaponInfo
	local var_27_1 = var_27_0.breakthrough
	local var_27_2, var_27_3, var_27_4, var_27_5 = WeaponTools.AddWeaponExp(var_27_0.exp, var_27_1, arg_27_0.context.totalSelect)

	if var_27_5 then
		ShowTips("LEVEL_MAX")

		return false
	end

	if arg_27_1.number > arg_27_1.topAmountValue then
		arg_27_1.topAmountValue = arg_27_1.topAmountValue + 1
		arg_27_0.context.totalSelect = arg_27_0.context.totalSelect + ItemCfg[arg_27_1.id].param[1]

		manager.audio:PlayUIAudio(2)
		arg_27_2:RefreshTopAmount(arg_27_1.topAmountValue)

		return true
	else
		return false
	end
end

function var_0_0.OnServantClick(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0.context.weaponInfo
	local var_28_1 = var_28_0.breakthrough
	local var_28_2 = ItemCfg[arg_28_1.id].rare
	local var_28_3 = GameSetting.base_exp_weapon_servant.value[var_28_2]
	local var_28_4, var_28_5, var_28_6, var_28_7 = WeaponTools.AddWeaponExp(var_28_0.exp, var_28_1, arg_28_0.context.totalSelect)

	if arg_28_1.topAmountValue == 1 then
		arg_28_1.topAmountValue = 0
		arg_28_0.context.totalSelect = arg_28_0.context.totalSelect - var_28_3
	elseif arg_28_1.topAmountValue == 0 then
		if var_28_7 then
			ShowTips("LEVEL_MAX")

			return false
		end

		arg_28_1.topAmountValue = 1
		arg_28_0.context.totalSelect = arg_28_0.context.totalSelect + var_28_3
	end

	arg_28_2:RefreshTopAmount(arg_28_1.topAmountValue)
end

function var_0_0.OnMaterialCutClick(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1.type == ItemConst.ITEM_TYPE.MATERIAL then
		if arg_29_1.topAmountValue >= 1 then
			arg_29_1.topAmountValue = arg_29_1.topAmountValue - 1
			arg_29_0.context.totalSelect = arg_29_0.context.totalSelect - ItemCfg[arg_29_1.id].param[1]

			arg_29_2:RefreshTopAmount(arg_29_1.topAmountValue)
			manager.audio:PlayUIAudio(2)

			return true
		end
	elseif arg_29_1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		local var_29_0 = ItemCfg[arg_29_1.id].rare
		local var_29_1 = GameSetting.base_exp_weapon_servant.value[var_29_0]

		arg_29_1.topAmountValue = math.max(arg_29_1.topAmountValue - 1, 0)
		arg_29_0.context.totalSelect = arg_29_0.context.totalSelect - var_29_1

		arg_29_2:RefreshTopAmount(arg_29_1.topAmountValue)
	end

	return false
end

function var_0_0.QuickSelectBtnClick(arg_30_0)
	local var_30_0 = arg_30_0.context.weaponInfo
	local var_30_1 = WeaponTools.CurMaxExp(var_30_0.breakthrough) - var_30_0.exp

	arg_30_0.context.totalSelect = arg_30_0:QuickSelectList(arg_30_0.context.materialList, arg_30_0.context.servantList, var_30_1)

	local var_30_2 = arg_30_0.scrollHelper_:GetItemList()

	for iter_30_0, iter_30_1 in pairs(var_30_2) do
		iter_30_1:RefreshTopAmount(iter_30_1.infoProxy.topAmountValue)
	end

	arg_30_0:RenderView()
end

function var_0_0.OnUpgradeBtnClick(arg_31_0)
	if arg_31_0.context.totalSelect == 0 then
		ShowTips("PLEASE_SELECT_ITEM")

		return
	end

	local var_31_0 = arg_31_0.context.weaponInfo
	local var_31_1, var_31_2, var_31_3 = WeaponTools.AddWeaponExp(var_31_0.exp, var_31_0.breakthrough, arg_31_0.context.totalSelect)
	local var_31_4 = (arg_31_0.context.totalSelect - var_31_3) * GameSetting.weapon_strengthen_gold_cost.value[1]

	if not checkGold(var_31_4, true) then
		return
	end

	local var_31_5 = false
	local var_31_6 = arg_31_0.context.heroId
	local var_31_7 = {}

	for iter_31_0, iter_31_1 in pairs(arg_31_0.context.materialList) do
		if iter_31_1.topAmountValue ~= 0 then
			table.insert(var_31_7, {
				id = iter_31_1.id,
				num = iter_31_1.topAmountValue
			})
		end
	end

	local var_31_8 = {}

	for iter_31_2, iter_31_3 in pairs(arg_31_0.context.servantList) do
		if iter_31_3.topAmountValue ~= 0 then
			if ItemCfg[iter_31_3.id].rare == 5 then
				var_31_5 = true
			end

			table.insert(var_31_8, iter_31_3.uid)
		end
	end

	local var_31_9
	local var_31_10 = MaterialTools.materialGiveBack(var_31_3, ItemConst.STR_ITEM.WEAPON)

	if #var_31_10 > 0 then
		if var_31_5 then
			var_31_9 = string.format(GetTips("WEAPON_STRENGTH_EXP_OVERFLOW_AND_RARE"))
		else
			var_31_9 = string.format(GetTips("WEAPON_STRENGTH_EXP_OVERFLOW"))
		end

		arg_31_0:Go("materialPreview", {
			content = var_31_9,
			OkCallback = function()
				WeaponAction.WeaponStr(var_31_6, var_31_7, var_31_8, arg_31_0.context.totalSelect)
			end,
			itemList = var_31_10
		})

		return
	end

	if var_31_5 then
		local var_31_11 = string.format(GetTips("WEAPON_STRENGTH_COST_RARE"))

		ShowMessageBox({
			title = "Warning",
			content = var_31_11,
			OkCallback = function()
				OperationRecorder.Record("hero", "weaponOKUpgrade")
				WeaponAction.WeaponStr(var_31_6, var_31_7, var_31_8, arg_31_0.context.totalSelect)
			end,
			CancelCallback = function()
				OperationRecorder.Record("hero", "weaponCancelUpgrade")
			end
		})

		return
	end

	WeaponAction.WeaponStr(var_31_6, var_31_7, var_31_8, arg_31_0.context.totalSelect)
end

function var_0_0.OnFilterBtnClick(arg_35_0)
	JumpTools.OpenPageByJump("commonFilterView", {
		filterGroup = Filter_Root_Define.Weapon_LevelUp_Cost_List
	})
end

function var_0_0.OnFilterChange(arg_36_0)
	arg_36_0:ShowWeaponInfoLocal()
end

function var_0_0.CheckWeaponIsMaxLevel(arg_37_0)
	local var_37_0 = arg_37_0.context.weaponInfo

	if var_37_0 then
		return var_37_0.level == HeroConst.WEAPON_LV_MAX
	end

	return false
end

function var_0_0.RefreshMaterialList(arg_38_0)
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

	local var_38_7 = ServantTools.GetServantLimited(true, true)

	for iter_38_2, iter_38_3 in ipairs(var_38_7) do
		local var_38_8 = clone(ItemTemplateData)

		var_38_8.type = ItemConst.ITEM_TYPE.WEAPON_SERVANT
		var_38_8.uid = iter_38_3.uid
		var_38_8.id = iter_38_3.id
		var_38_8.number = iter_38_3.stage
		var_38_8.addLevel = iter_38_3.stage
		var_38_8.index = 0
		var_38_8.selectStyle = false

		table.insert(var_38_1, var_38_8)
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

	arg_38_0.context.servantList = var_38_1
	arg_38_0.context.materialList = var_38_0
	arg_38_0.context.totalCount = #var_38_1 + #var_38_0
	arg_38_0.context.materialCount = #var_38_0
	arg_38_0.context.servantCount = #var_38_1
end

function var_0_0.QuickSelectList(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = arg_41_3
	local var_41_1 = {}

	for iter_41_0 = 1, #arg_41_1 do
		local var_41_2 = arg_41_1[iter_41_0]
		local var_41_3 = ItemCfg[var_41_2.id].param[1]

		var_41_1[iter_41_0] = math.max(math.min(math.ceil(var_41_0 / var_41_3), var_41_2.number), 0)
		var_41_0 = var_41_0 - var_41_1[iter_41_0] * var_41_3

		if var_41_0 < 0 and iter_41_0 > 1 then
			local var_41_4 = -var_41_0

			for iter_41_1 = iter_41_0 - 1, 1, -1 do
				local var_41_5 = arg_41_1[iter_41_1]
				local var_41_6 = ItemCfg[var_41_5.id].param[1]
				local var_41_7 = math.modf(var_41_4 / var_41_6)
				local var_41_8 = math.min(var_41_1[iter_41_1], var_41_7)

				var_41_1[iter_41_1] = math.max(0, var_41_1[iter_41_1] - var_41_8)
				var_41_4 = var_41_4 - var_41_6 * var_41_8
				var_41_0 = var_41_0 + var_41_6 * var_41_8
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
		local var_41_9 = arg_41_2[iter_41_3]

		if not (ItemCfg[var_41_9.id].rare >= 4 or var_41_9.number ~= 1) then
			local var_41_10 = ItemCfg[var_41_9.id].rare
			local var_41_11 = GameSetting.base_exp_weapon_servant.value[var_41_10]

			if var_41_0 <= 0 then
				var_41_9.topAmountValue = 0
			else
				var_41_9.topAmountValue = 1
				var_41_0 = var_41_0 - var_41_11
			end
		else
			var_41_9.topAmountValue = 0
		end
	end

	return arg_41_3 - var_41_0
end

function var_0_0.UpdateWeaponInfo(arg_42_0)
	local var_42_0 = arg_42_0.context.heroId

	if var_42_0 and var_42_0 ~= 0 then
		local var_42_1 = deepClone(arg_42_0.context.dataPorxy:GetHeroWeaponInfo(var_42_0))

		arg_42_0.context.weaponInfo = var_42_1
	end
end

function var_0_0.Dispose(arg_43_0)
	arg_43_0.scrollHelper_:Dispose()
	arg_43_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_43_0)
end

return var_0_0
