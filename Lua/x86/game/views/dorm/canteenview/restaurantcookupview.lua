local var_0_0 = class("RestaurantCookUpView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dining/PotUpgradeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.sceneID = DormConst.CANTEEN_ID
	arg_4_0.unlockScroll = LuaList.New(handler(arg_4_0, arg_4_0.unLockItem), arg_4_0.materialListGo_, CommonItemView)
	arg_4_0.conditionScroll = LuaList.New(handler(arg_4_0, arg_4_0.conditionItem), arg_4_0.conditionListGo_, RestaurantCookConditionItem)
	arg_4_0.skillScroll = LuaList.New(handler(arg_4_0, arg_4_0.skillItem), arg_4_0.skillListGo_, RestaurantCookConditionItem)
	arg_4_0.stateController = ControllerUtil.GetController(arg_4_0.transform_, "state")
	arg_4_0.skillListController = ControllerUtil.GetController(arg_4_0.skillListGo_.transform, "empty")
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.tree_ = LuaTree.New(arg_5_0.uitreeGo_)
end

function var_0_0.OnEnter(arg_6_0)
	manager.windowBar:SwitchBar({
		CanteenConst.COOK_LEVEL_UP_CURRENCY
	})
	manager.windowBar:SetBarCanAdd(CanteenConst.COOK_LEVEL_UP_CURRENCY, true)
	arg_6_0:RefreshTree()

	arg_6_0.type = arg_6_0.params_.type or 1
	arg_6_0.furEID = arg_6_0.params_.furEID or CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Pan)
	arg_6_0.unLockFlag = true

	arg_6_0:RegisterEvent()

	arg_6_0.furCfgID = BackHomeCanteenFurnitureIDCfg[arg_6_0.furEID].type_id

	if not arg_6_0.type then
		arg_6_0.currentGroupIndex_ = 1
	else
		arg_6_0.currentGroupIndex_ = arg_6_0.type
	end

	arg_6_0.currentItemIndex_ = 1

	if arg_6_0.furEID then
		local var_6_0 = arg_6_0.treeData_.groupDatas[arg_6_0.currentGroupIndex_ - 1]

		for iter_6_0 = 0, var_6_0.itemDatas.Count - 1 do
			if var_6_0.itemDatas[iter_6_0].id == arg_6_0.furEID then
				arg_6_0.currentItemIndex_ = iter_6_0 + 1

				break
			end
		end
	end

	arg_6_0.tree_:SelectItem(arg_6_0.currentGroupIndex_, arg_6_0.currentItemIndex_)
	arg_6_0:BindRedPoint()
end

function var_0_0.BindRedPoint(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.titles) do
		manager.redPoint:bindUIandKey(arg_7_0.tree_:GetGroupRedPointContainerById(iter_7_0), string.format("%s_%s", RedPointConst.CANTEEN_UPGRADE_AVAILABLE, tostring(iter_7_0)))
	end
end

function var_0_0.UnBindRedPoint(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.titles) do
		manager.redPoint:unbindUIandKey(arg_8_0.tree_:GetGroupRedPointContainerById(iter_8_0), string.format("%s_%s", RedPointConst.CANTEEN_UPGRADE_AVAILABLE, tostring(iter_8_0)))
	end
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()

	if arg_9_0.upFlag then
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Close then
			manager.notify:Invoke(DORM_RESTAURANT_UPDATE_SCENE_ITEM)
		elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto then
			manager.notify:Invoke(DORM_RESTAURANT_START_AUTO)
		end
	end

	arg_9_0.upFlag = nil

	arg_9_0:RemoveAllEventListener()
	arg_9_0:UnBindRedPoint()
end

function var_0_0.RegisterEvent(arg_10_0)
	arg_10_0:RegistEventListener(CANTEEN_FUR_LEVEL_UP, function()
		arg_10_0.upFlag = true

		arg_10_0.tree_:SelectItem(arg_10_0.currentGroupIndex_, arg_10_0.currentItemIndex_)
	end)
end

function var_0_0.AddUIListener(arg_12_0)
	arg_12_0:AddBtnListenerScale(arg_12_0.upBtn_, nil, function()
		if arg_12_0.furEID then
			if not arg_12_0.unLockFlag then
				ShowTips(GetTips("DORM_CANTEEN_CANT_LEVEL_UP"))

				return
			end

			if arg_12_0:CheckCurrency() then
				CanteenAction:CanteenFurnitureUpgrade(arg_12_0.furEID)
			else
				ShowTips(GetTips("DORM_CANTEEN_LEVEL_NOT_ENOUGH"))
			end
		end
	end)
	arg_12_0:AddBtnListener(arg_12_0.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnGroupSelect(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.currentGroupIndex_ = arg_15_1

	if not arg_15_0.currentItemIndex_ then
		arg_15_0.currentItemIndex_ = 1
	end

	DormRedPointTools:ConsumeNotification(string.format("%s_%s", RedPointConst.CANTEEN_UPGRADE_AVAILABLE, arg_15_1), DormRedPointTools.RedPointType.Session)
	arg_15_0:UpdataCookLevelUpInfo(arg_15_0.currentGroupIndex_)
end

function var_0_0.OnItemSelect(arg_16_0, arg_16_1)
	arg_16_0.currentItemIndex_ = arg_16_1
	arg_16_0.unLockFlag = true

	arg_16_0:RefreshView()
end

function var_0_0.RefreshTree(arg_17_0)
	arg_17_0.titles = {
		GetTips("DORM_CANTEEN_FURNITURE_KITCHEN"),
		(GetTips("DORM_CANTEEN_FURNITURE"))
	}

	arg_17_0.tree_:SetSelectedHandler(nil, nil)

	local var_17_0 = UITreeData.New()

	for iter_17_0 = 1, #arg_17_0.titles do
		local var_17_1 = UITreeGroupData.New()

		var_17_1.id = iter_17_0
		var_17_1.text = GetI18NText(arg_17_0.titles[iter_17_0])

		if iter_17_0 == 1 then
			local var_17_2
			local var_17_3
			local var_17_4 = UITreeItemData.New()

			var_17_4.id = CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Pan)

			local var_17_5 = BackHomeCanteenFurnitureIDCfg[var_17_4.id].type_id

			var_17_4.text = ItemTools.getItemName(var_17_5)
			var_17_4.extraData = BackHomeCanteenFurnitureCfg[var_17_5].type

			var_17_1.itemDatas:Add(var_17_4)

			local var_17_6 = UITreeItemData.New()

			var_17_6.id = CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Oven)

			local var_17_7 = BackHomeCanteenFurnitureIDCfg[var_17_6.id].type_id

			var_17_6.text = ItemTools.getItemName(var_17_7)
			var_17_6.extraData = BackHomeCanteenFurnitureCfg[var_17_7].type

			var_17_1.itemDatas:Add(var_17_6)

			local var_17_8 = UITreeItemData.New()

			var_17_8.id = CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Steamer)

			local var_17_9 = BackHomeCanteenFurnitureIDCfg[var_17_8.id].type_id

			var_17_8.text = ItemTools.getItemName(var_17_9)
			var_17_8.extraData = BackHomeCanteenFurnitureCfg[var_17_9].type

			var_17_1.itemDatas:Add(var_17_8)

			local var_17_10 = UITreeItemData.New()

			var_17_10.id = CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Pot)

			local var_17_11 = BackHomeCanteenFurnitureIDCfg[var_17_10.id].type_id

			var_17_10.text = ItemTools.getItemName(var_17_11)
			var_17_10.extraData = BackHomeCanteenFurnitureCfg[var_17_11].type

			var_17_1.itemDatas:Add(var_17_10)
		end

		if iter_17_0 == 2 then
			for iter_17_1, iter_17_2 in ipairs(BackHomeCanteenFurnitureCfg.all) do
				if BackHomeCanteenFurnitureCfg[iter_17_2].type == 2 then
					local var_17_12 = CanteenTools:GetCanteenEIDByFurCfgID(iter_17_2)
					local var_17_13
					local var_17_14 = UITreeItemData.New()

					var_17_14.id = var_17_12

					local var_17_15 = BackHomeCanteenFurnitureIDCfg[var_17_14.id].type_id

					var_17_14.text = ItemTools.getItemName(var_17_15)
					var_17_14.extraData = BackHomeCanteenFurnitureCfg[var_17_15].type

					var_17_1.itemDatas:Add(var_17_14)
				end
			end
		end

		var_17_0.groupDatas:Add(var_17_1)
	end

	arg_17_0.tree_:SetData(var_17_0)
	arg_17_0.tree_:SetSelectedHandler(handler(arg_17_0, arg_17_0.OnGroupSelect), handler(arg_17_0, arg_17_0.OnItemSelect))

	arg_17_0.treeData_ = var_17_0
	arg_17_0.upControllerList = {}

	for iter_17_3 = 1, arg_17_0.treeData_.groupDatas.Count do
		local var_17_16 = arg_17_0.treeData_.groupDatas[iter_17_3 - 1]

		for iter_17_4 = 1, var_17_16.itemDatas.Count do
			local var_17_17 = var_17_16.itemDatas[iter_17_4 - 1].id
			local var_17_18 = arg_17_0.tree_:GetItemGameObjectById(iter_17_3, var_17_17)
			local var_17_19 = ControllerUtil.GetController(var_17_18.transform, "levelUp")

			if not arg_17_0.upControllerList[iter_17_3] then
				arg_17_0.upControllerList[iter_17_3] = {}
			end

			table.insert(arg_17_0.upControllerList[iter_17_3], var_17_19)
		end
	end
end

function var_0_0.skillItem(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2:RefreshUI(arg_18_0.skillList[arg_18_1], 1)
end

function var_0_0.unLockItem(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2:SetData(arg_19_0.materialList[arg_19_1])

	local var_19_0 = arg_19_0.materialList[arg_19_1]
	local var_19_1 = ItemTools.getItemNum(var_19_0.id)

	arg_19_2:RefreshBottomText({
		var_19_1,
		var_19_0.number
	})
end

function var_0_0.conditionItem(arg_20_0, arg_20_1, arg_20_2)
	arg_20_2:UpdataCondition(function(arg_21_0)
		arg_20_0.unLockFlag = arg_21_0
	end)
	arg_20_2:RefreshUI(arg_20_0.conditionList[arg_20_1], 2)

	if arg_20_0.unLockFlag and arg_20_0:CheckCurrency() then
		arg_20_0.stateController:SetSelectedState("false")
	else
		arg_20_0.stateController:SetSelectedState("no")
	end
end

function var_0_0.UpdataCookLevelUpInfo(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.upControllerList[arg_22_1]

	for iter_22_0 = 1, #var_22_0 do
		local var_22_1 = arg_22_0.treeData_.groupDatas[arg_22_1 - 1].itemDatas[iter_22_0 - 1].id

		if CanteenTools:CheckFurCanLevelUp(var_22_1) then
			arg_22_0.upControllerList[arg_22_1][iter_22_0]:SetSelectedState("true")
		else
			arg_22_0.upControllerList[arg_22_1][iter_22_0]:SetSelectedState("false")
		end
	end
end

function var_0_0.RefreshView(arg_23_0)
	arg_23_0.furEID = arg_23_0.treeData_.groupDatas[arg_23_0.currentGroupIndex_ - 1].itemDatas[arg_23_0.currentItemIndex_ - 1].id

	arg_23_0:RefreshFurInfo(arg_23_0.furEID)
end

function var_0_0.RefreshFurInfo(arg_24_0, arg_24_1)
	local var_24_0 = BackHomeCanteenFurnitureIDCfg[arg_24_1].type_id
	local var_24_1 = CanteenData:GetFurnitureLevel(arg_24_1)

	arg_24_0.num0Text_.text = string.format(GetTips("DORM_CANTEEN_LEVEL"), var_24_1)
	arg_24_0.titleText_.text = ItemTools.getItemName(var_24_0)
	arg_24_0.iconImg_.sprite = ItemTools.getItemSprite(var_24_0)

	arg_24_0:RefreshSkillEffectList(var_24_0, var_24_1)

	if var_24_1 ~= #BackHomeCanteenFurnitureCfg[var_24_0].cost_material then
		arg_24_0.stateController:SetSelectedState("false")

		local var_24_2 = var_24_1 + 1

		arg_24_0.num1Text_.text = string.format(GetTips("DORM_CANTEEN_LEVEL"), var_24_2)

		if var_24_1 == 0 then
			arg_24_0.conditionTitle.text = GetTips("DORM_CANTEEN_UNLOCK_CONDITION")
			arg_24_0.btnText.text = GetTips("DORM_CANTEEN_LEVEL_UNLOCK")
		else
			arg_24_0.conditionTitle.text = GetTips("DORM_CANTEEN_LEVEL_CONDITION")
			arg_24_0.btnText.text = GetTips("TEXT_UPGRADE")
		end

		arg_24_0:RefreshLevelUpInfo(var_24_0, var_24_2)
		arg_24_0:RefreshMaterialList(var_24_0, var_24_2)
	else
		arg_24_0.stateController:SetSelectedState("true")
	end
end

function var_0_0.RefreshSkillEffectList(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0.skillList = {}

	arg_25_0:AddSkillList(arg_25_1, arg_25_2)
	arg_25_0:AddUnSkillList(arg_25_1, arg_25_2)
	CommonTools.UniversalSortEx(arg_25_0.skillList, {
		ascend = true,
		map = function(arg_26_0)
			return arg_26_0.type
		end
	})

	if arg_25_0.skillList then
		arg_25_0.skillScroll:StartScroll(#arg_25_0.skillList)
	else
		arg_25_0.skillScroll:StartScroll(0)
		arg_25_0.skillListController:SetSelectedState("false")
	end
end

function var_0_0.AddSkillList(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = BackHomeCanteenFurnitureCfg[arg_27_1].skill[arg_27_2]

	if var_27_0 then
		for iter_27_0, iter_27_1 in ipairs(var_27_0) do
			if BackHomeHeroSkillCfg[iter_27_1] then
				local var_27_1 = {
					type = 1,
					cfgID = iter_27_1,
					level = arg_27_2,
					furID = arg_27_1
				}

				table.insert(arg_27_0.skillList, var_27_1)
			end
		end
	end

	local var_27_2 = BackHomeCanteenFurnitureCfg[arg_27_1].skill[arg_27_2 + 1]

	if var_27_2 then
		for iter_27_2, iter_27_3 in ipairs(var_27_2) do
			local var_27_3 = false

			if var_27_0 then
				for iter_27_4, iter_27_5 in ipairs(var_27_0) do
					if BackHomeHeroSkillCfg[iter_27_3].type == BackHomeHeroSkillCfg[iter_27_5].type then
						if BackHomeHeroSkillCfg[iter_27_3].type == 2 or BackHomeHeroSkillCfg[iter_27_3].type == 1 then
							if BackHomeHeroSkillCfg[iter_27_3].param[1] == BackHomeHeroSkillCfg[iter_27_5].param[1] then
								var_27_3 = true

								break
							end
						else
							var_27_3 = true

							break
						end
					end
				end
			end

			if not var_27_3 then
				local var_27_4 = {
					type = 4,
					cfgID = iter_27_3,
					level = arg_27_2 + 1
				}

				table.insert(arg_27_0.skillList, var_27_4)
			end
		end
	end
end

function var_0_0.AddUnSkillList(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = BackHomeCanteenFurnitureCfg[arg_28_1].canteen_storage_max[arg_28_2]

	if var_28_0 and var_28_0 > 0 then
		local var_28_1 = {
			type = 3,
			effectType = CanteenConst.FurEffectType.Storage,
			level = arg_28_2,
			cfgID = arg_28_1
		}

		table.insert(arg_28_0.skillList, var_28_1)
	else
		local var_28_2 = BackHomeCanteenFurnitureCfg[arg_28_1].canteen_storage_max[arg_28_2 + 1]

		if var_28_2 and var_28_2 > 0 then
			local var_28_3 = {
				type = 4,
				effectType = CanteenConst.FurEffectType.Storage,
				level = arg_28_2 + 1,
				cfgID = arg_28_1
			}

			table.insert(arg_28_0.skillList, var_28_3)
		end
	end

	local var_28_4 = BackHomeCanteenFurnitureCfg[arg_28_1].canteen_sell_max[arg_28_2]

	if var_28_4 and var_28_4 > 0 then
		local var_28_5 = {
			type = 3,
			effectType = CanteenConst.FurEffectType.SellMax,
			level = arg_28_2,
			cfgID = arg_28_1
		}

		table.insert(arg_28_0.skillList, var_28_5)
	else
		local var_28_6 = BackHomeCanteenFurnitureCfg[arg_28_1].canteen_sell_max[arg_28_2 + 1]

		if var_28_6 and var_28_6 > 0 then
			local var_28_7 = {
				type = 4,
				effectType = CanteenConst.FurEffectType.SellMax,
				level = arg_28_2 + 1,
				cfgID = arg_28_1
			}

			table.insert(arg_28_0.skillList, var_28_7)
		end
	end

	local var_28_8 = #DormSkillData:GetCookCanUnlockFoodList(arg_28_1, arg_28_2)

	if var_28_8 and var_28_8 > 0 then
		local var_28_9 = {
			type = 3,
			effectType = CanteenConst.FurEffectType.UnLockFood,
			level = arg_28_2,
			cfgID = arg_28_1,
			unLockNum = var_28_8
		}

		table.insert(arg_28_0.skillList, var_28_9)
	else
		local var_28_10 = #DormSkillData:GetCookCanUnlockFoodList(arg_28_1, arg_28_2 + 1)

		if var_28_10 and var_28_10 > 0 then
			local var_28_11 = {
				type = 4,
				effectType = CanteenConst.FurEffectType.UnLockFood,
				level = arg_28_2 + 1,
				cfgID = arg_28_1,
				unLockNum = var_28_10
			}

			table.insert(arg_28_0.skillList, var_28_11)
		end
	end
end

function var_0_0.RefreshLevelUpInfo(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0.conditionList = {}

	local var_29_0 = BackHomeCanteenFurnitureCfg[arg_29_1].condition[arg_29_2]

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		local var_29_1 = {
			type = 2,
			cfgID = iter_29_1
		}

		table.insert(arg_29_0.conditionList, var_29_1)
	end

	if arg_29_0.conditionList then
		arg_29_0.conditionScroll:StartScroll(#arg_29_0.conditionList)
	else
		arg_29_0.conditionScroll:StartScroll(0)
	end
end

function var_0_0.RefreshMaterialList(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = BackHomeCanteenFurnitureCfg[arg_30_1].cost_material[arg_30_2]

	if var_30_0 then
		arg_30_0.materialList = {}

		for iter_30_0, iter_30_1 in ipairs(var_30_0) do
			local var_30_1 = {
				id = iter_30_1[1],
				number = iter_30_1[2],
				clickFun = function(arg_31_0)
					ShowPopItem(POP_ITEM, {
						arg_31_0.id,
						arg_31_0.num
					})
				end
			}

			table.insert(arg_30_0.materialList, var_30_1)
		end

		arg_30_0.unlockScroll:StartScroll(#arg_30_0.materialList)

		arg_30_0.curIcon.sprite = ItemTools.getItemSprite(var_30_0[1][1])
		arg_30_0.costText_.text = var_30_0[1][2]

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_0.costTrs_)
	else
		arg_30_0.unlockScroll:StartScroll(0)
	end
end

function var_0_0.CheckCurrency(arg_32_0)
	local var_32_0 = BackHomeCanteenFurnitureIDCfg[arg_32_0.furEID].type_id
	local var_32_1 = CanteenData:GetFurInfoList()[arg_32_0.furEID]
	local var_32_2 = 0

	if var_32_1 then
		var_32_2 = var_32_1.level
	end

	local var_32_3 = BackHomeCanteenFurnitureCfg[var_32_0].cost_material[var_32_2 + 1]

	for iter_32_0, iter_32_1 in ipairs(var_32_3) do
		if ItemTools.getItemNum(iter_32_1[1]) < iter_32_1[2] then
			return false
		end
	end

	return true
end

function var_0_0.Dispose(arg_33_0)
	if arg_33_0.tree_ then
		arg_33_0.tree_:Dispose()

		arg_33_0.tree_ = nil
	end

	if arg_33_0.unlockScroll then
		arg_33_0.unlockScroll:Dispose()

		arg_33_0.unlockScroll = nil
	end

	if arg_33_0.conditionScroll then
		arg_33_0.conditionScroll:Dispose()

		arg_33_0.conditionScroll = nil
	end

	if arg_33_0.skillScroll then
		arg_33_0.skillScroll:Dispose()

		arg_33_0.skillScroll = nil
	end

	var_0_0.super.Dispose(arg_33_0)
end

return var_0_0
