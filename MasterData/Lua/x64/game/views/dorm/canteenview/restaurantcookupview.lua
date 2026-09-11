local RestaurantCookUpView = class("RestaurantCookUpView", ReduxView)

function RestaurantCookUpView:UIName()
	return "Widget/BackHouseUI/Dining/PotUpgradeUI"
end

function RestaurantCookUpView:UIParent()
	return manager.ui.uiMain.transform
end

function RestaurantCookUpView:OnCtor()
	return
end

function RestaurantCookUpView:Init()
	self:InitUI()
	self:AddUIListener()

	self.sceneID = DormConst.CANTEEN_ID
	self.unlockScroll = LuaList.New(handler(self, self.unLockItem), self.materialListGo_, CommonItemView)
	self.conditionScroll = LuaList.New(handler(self, self.conditionItem), self.conditionListGo_, RestaurantCookConditionItem)
	self.skillScroll = LuaList.New(handler(self, self.skillItem), self.skillListGo_, RestaurantCookConditionItem)
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.skillListController = ControllerUtil.GetController(self.skillListGo_.transform, "empty")
end

function RestaurantCookUpView:InitUI()
	self:BindCfgUI()

	self.tree_ = LuaTree.New(self.uitreeGo_)
end

function RestaurantCookUpView:OnEnter()
	manager.windowBar:SwitchBar({
		CanteenConst.COOK_LEVEL_UP_CURRENCY
	})
	manager.windowBar:SetBarCanAdd(CanteenConst.COOK_LEVEL_UP_CURRENCY, true)
	self:RefreshTree()

	self.type = self.params_.type or 1
	self.furEID = self.params_.furEID or CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Pan)
	self.unLockFlag = true

	self:RegisterEvent()

	self.furCfgID = BackHomeCanteenFurnitureIDCfg[self.furEID].type_id
	self.currentGroupIndex_ = not self.type and 1 or self.type
	self.currentItemIndex_ = 1

	if self.furEID then
		for iter_6_0 = 0, self.treeData_.groupDatas[self.currentGroupIndex_ - 1].itemDatas.Count - 1 do
			if self.treeData_.groupDatas[self.currentGroupIndex_ - 1].itemDatas[iter_6_0].id == self.furEID then
				self.currentItemIndex_ = iter_6_0 + 1

				break
			end
		end
	end

	self.tree_:SelectItem(self.currentGroupIndex_, self.currentItemIndex_)
	self:BindRedPoint()
end

function RestaurantCookUpView:BindRedPoint()
	for iter_7_0, iter_7_1 in pairs(self.titles) do
		manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(iter_7_0), string.format("%s_%s", RedPointConst.CANTEEN_UPGRADE_AVAILABLE, tostring(iter_7_0)))
	end
end

function RestaurantCookUpView:UnBindRedPoint()
	for iter_8_0, iter_8_1 in pairs(self.titles) do
		manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(iter_8_0), string.format("%s_%s", RedPointConst.CANTEEN_UPGRADE_AVAILABLE, tostring(iter_8_0)))
	end
end

function RestaurantCookUpView:OnExit()
	manager.windowBar:HideBar()

	if self.upFlag then
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Close then
			manager.notify:Invoke(DORM_RESTAURANT_UPDATE_SCENE_ITEM)
		elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto then
			manager.notify:Invoke(DORM_RESTAURANT_START_AUTO)
		end
	end

	self.upFlag = nil

	self:RemoveAllEventListener()
	self:UnBindRedPoint()
end

function RestaurantCookUpView:RegisterEvent()
	self:RegistEventListener(CANTEEN_FUR_LEVEL_UP, function()
		self.upFlag = true

		self.tree_:SelectItem(self.currentGroupIndex_, self.currentItemIndex_)
	end)
end

function RestaurantCookUpView:AddUIListener()
	self:AddBtnListenerScale(self.upBtn_, nil, function()
		if self.furEID then
			if not self.unLockFlag then
				ShowTips(GetTips("DORM_CANTEEN_CANT_LEVEL_UP"))

				return
			end

			if self:CheckCurrency() then
				CanteenAction:CanteenFurnitureUpgrade(self.furEID)
			else
				ShowTips(GetTips("DORM_CANTEEN_LEVEL_NOT_ENOUGH"))
			end
		end
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function RestaurantCookUpView:OnGroupSelect(arg_15_1, arg_15_2)
	self.currentGroupIndex_ = arg_15_1
	self.currentItemIndex_ = self.currentItemIndex_ or 1

	DormRedPointTools:ConsumeNotification(string.format("%s_%s", RedPointConst.CANTEEN_UPGRADE_AVAILABLE, arg_15_1), DormRedPointTools.RedPointType.Session)
	self:UpdataCookLevelUpInfo(self.currentGroupIndex_)
end

function RestaurantCookUpView:OnItemSelect(arg_16_1)
	self.currentItemIndex_ = arg_16_1
	self.unLockFlag = true

	self:RefreshView()
end

function RestaurantCookUpView:RefreshTree()
	self.titles = {
		GetTips("DORM_CANTEEN_FURNITURE_KITCHEN"),
		(GetTips("DORM_CANTEEN_FURNITURE"))
	}

	self.tree_:SetSelectedHandler(nil, nil)

	local var_17_0 = UITreeData.New()

	for iter_17_0 = 1, #self.titles do
		local var_17_1 = UITreeGroupData.New()

		var_17_1.id = iter_17_0
		var_17_1.text = GetI18NText(self.titles[iter_17_0])

		if iter_17_0 == 1 then
			local var_17_2 = UITreeItemData.New()

			var_17_2.id = CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Pan)
			var_17_2.text = ItemTools.getItemName(BackHomeCanteenFurnitureIDCfg[var_17_2.id].type_id)
			var_17_2.extraData = BackHomeCanteenFurnitureCfg[nil].type

			var_17_1.itemDatas:Add(var_17_2)

			local var_17_4 = UITreeItemData.New()

			var_17_4.id = CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Oven)
			var_17_4.text = ItemTools.getItemName(BackHomeCanteenFurnitureIDCfg[var_17_4.id].type_id)
			var_17_4.extraData = BackHomeCanteenFurnitureCfg[nil].type

			var_17_1.itemDatas:Add(var_17_4)

			local var_17_5 = UITreeItemData.New()

			var_17_5.id = CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Steamer)
			var_17_5.text = ItemTools.getItemName(BackHomeCanteenFurnitureIDCfg[var_17_5.id].type_id)
			var_17_5.extraData = BackHomeCanteenFurnitureCfg[nil].type

			var_17_1.itemDatas:Add(var_17_5)

			local var_17_6 = UITreeItemData.New()

			var_17_6.id = CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Pot)
			var_17_6.text = ItemTools.getItemName(BackHomeCanteenFurnitureIDCfg[var_17_6.id].type_id)
			var_17_6.extraData = BackHomeCanteenFurnitureCfg[nil].type

			var_17_1.itemDatas:Add(var_17_6)
		end

		if iter_17_0 == 2 then
			for iter_17_1, iter_17_2 in ipairs(BackHomeCanteenFurnitureCfg.all) do
				if BackHomeCanteenFurnitureCfg[iter_17_2].type == 2 then
					local var_17_7 = UITreeItemData.New()

					var_17_7.id = CanteenTools:GetCanteenEIDByFurCfgID(iter_17_2)
					var_17_7.text = ItemTools.getItemName(BackHomeCanteenFurnitureIDCfg[var_17_7.id].type_id)
					var_17_7.extraData = BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[var_17_7.id].type_id].type

					var_17_1.itemDatas:Add(var_17_7)
				end
			end
		end

		var_17_0.groupDatas:Add(var_17_1)
	end

	self.tree_:SetData(var_17_0)
	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect), handler(self, self.OnItemSelect))

	self.treeData_ = var_17_0
	self.upControllerList = {}

	for iter_17_3 = 1, self.treeData_.groupDatas.Count do
		for iter_17_4 = 1, self.treeData_.groupDatas[iter_17_3 - 1].itemDatas.Count do
			self.upControllerList[iter_17_3] = self.upControllerList[iter_17_3] or {}

			table.insert(self.upControllerList[iter_17_3], (ControllerUtil.GetController(self.tree_:GetItemGameObjectById(iter_17_3, self.treeData_.groupDatas[iter_17_3 - 1].itemDatas[iter_17_4 - 1].id).transform, "levelUp")))
		end
	end
end

function RestaurantCookUpView:skillItem(arg_18_1, arg_18_2)
	arg_18_2:RefreshUI(self.skillList[arg_18_1], 1)
end

function RestaurantCookUpView:unLockItem(arg_19_1, arg_19_2)
	arg_19_2:SetData(self.materialList[arg_19_1])
	arg_19_2:RefreshBottomText({
		ItemTools.getItemNum(self.materialList[arg_19_1].id),
		self.materialList[arg_19_1].number
	})
end

function RestaurantCookUpView:conditionItem(arg_20_1, arg_20_2)
	arg_20_2:UpdataCondition(function(arg_21_0)
		self.unLockFlag = arg_21_0
	end)
	arg_20_2:RefreshUI(self.conditionList[arg_20_1], 2)

	if self.unLockFlag and self:CheckCurrency() then
		self.stateController:SetSelectedState("false")
	else
		self.stateController:SetSelectedState("no")
	end
end

function RestaurantCookUpView:UpdataCookLevelUpInfo(arg_22_1)
	for iter_22_0 = 1, #self.upControllerList[arg_22_1] do
		if CanteenTools:CheckFurCanLevelUp(self.treeData_.groupDatas[arg_22_1 - 1].itemDatas[iter_22_0 - 1].id) then
			self.upControllerList[arg_22_1][iter_22_0]:SetSelectedState("true")
		else
			self.upControllerList[arg_22_1][iter_22_0]:SetSelectedState("false")
		end
	end
end

function RestaurantCookUpView:RefreshView()
	self.furEID = self.treeData_.groupDatas[self.currentGroupIndex_ - 1].itemDatas[self.currentItemIndex_ - 1].id

	self:RefreshFurInfo(self.furEID)
end

function RestaurantCookUpView:RefreshFurInfo(arg_24_1)
	local var_24_0 = BackHomeCanteenFurnitureIDCfg[arg_24_1].type_id
	local var_24_1 = CanteenData:GetFurnitureLevel(arg_24_1)

	self.num0Text_.text = string.format(GetTips("DORM_CANTEEN_LEVEL"), var_24_1)
	self.titleText_.text = ItemTools.getItemName(var_24_0)
	self.iconImg_.sprite = ItemTools.getItemSprite(var_24_0)

	self:RefreshSkillEffectList(var_24_0, var_24_1)

	if var_24_1 ~= #BackHomeCanteenFurnitureCfg[var_24_0].cost_material then
		self.stateController:SetSelectedState("false")

		local var_24_2 = var_24_1 + 1

		self.num1Text_.text = string.format(GetTips("DORM_CANTEEN_LEVEL"), var_24_1 + 1)

		if var_24_1 == 0 then
			self.conditionTitle.text = GetTips("DORM_CANTEEN_UNLOCK_CONDITION")
			self.btnText.text = GetTips("DORM_CANTEEN_LEVEL_UNLOCK")
		else
			self.conditionTitle.text = GetTips("DORM_CANTEEN_LEVEL_CONDITION")
			self.btnText.text = GetTips("TEXT_UPGRADE")
		end

		self:RefreshLevelUpInfo(var_24_0, var_24_2)
		self:RefreshMaterialList(var_24_0, var_24_2)
	else
		self.stateController:SetSelectedState("true")
	end
end

function RestaurantCookUpView:RefreshSkillEffectList(arg_25_1, arg_25_2)
	self.skillList = {}

	self:AddSkillList(arg_25_1, arg_25_2)
	self:AddUnSkillList(arg_25_1, arg_25_2)
	CommonTools.UniversalSortEx(self.skillList, {
		ascend = true,
		map = function(self)
			return self.type
		end
	})

	if self.skillList then
		self.skillScroll:StartScroll(#self.skillList)
	else
		self.skillScroll:StartScroll(0)
		self.skillListController:SetSelectedState("false")
	end
end

function RestaurantCookUpView:AddSkillList(arg_27_1, arg_27_2)
	if BackHomeCanteenFurnitureCfg[arg_27_1].skill[arg_27_2] then
		for iter_27_0, iter_27_1 in ipairs(BackHomeCanteenFurnitureCfg[arg_27_1].skill[arg_27_2]) do
			if BackHomeHeroSkillCfg[iter_27_1] then
				table.insert(self.skillList, {
					type = 1,
					cfgID = iter_27_1,
					level = arg_27_2,
					furID = arg_27_1
				})
			end
		end
	end

	if BackHomeCanteenFurnitureCfg[arg_27_1].skill[arg_27_2 + 1] then
		for iter_27_2, iter_27_3 in ipairs(BackHomeCanteenFurnitureCfg[arg_27_1].skill[arg_27_2 + 1]) do
			local var_27_0 = false

			if BackHomeCanteenFurnitureCfg[arg_27_1].skill[arg_27_2] then
				for iter_27_4, iter_27_5 in ipairs(BackHomeCanteenFurnitureCfg[arg_27_1].skill[arg_27_2]) do
					if BackHomeHeroSkillCfg[iter_27_3].type == BackHomeHeroSkillCfg[iter_27_5].type then
						if BackHomeHeroSkillCfg[iter_27_3].type == 2 or BackHomeHeroSkillCfg[iter_27_3].type == 1 then
							if BackHomeHeroSkillCfg[iter_27_3].param[1] == BackHomeHeroSkillCfg[iter_27_5].param[1] then
								var_27_0 = true

								break
							end
						else
							var_27_0 = true

							break
						end
					end
				end
			end

			if not var_27_0 then
				table.insert(self.skillList, {
					type = 4,
					cfgID = iter_27_3,
					level = arg_27_2 + 1
				})
			end
		end
	end
end

function RestaurantCookUpView:AddUnSkillList(arg_28_1, arg_28_2)
	if BackHomeCanteenFurnitureCfg[arg_28_1].canteen_storage_max[arg_28_2] and BackHomeCanteenFurnitureCfg[arg_28_1].canteen_storage_max[arg_28_2] > 0 then
		table.insert(self.skillList, {
			type = 3,
			effectType = CanteenConst.FurEffectType.Storage,
			level = arg_28_2,
			cfgID = arg_28_1
		})
	elseif BackHomeCanteenFurnitureCfg[arg_28_1].canteen_storage_max[arg_28_2 + 1] and BackHomeCanteenFurnitureCfg[arg_28_1].canteen_storage_max[arg_28_2 + 1] > 0 then
		table.insert(self.skillList, {
			type = 4,
			effectType = CanteenConst.FurEffectType.Storage,
			level = arg_28_2 + 1,
			cfgID = arg_28_1
		})
	end

	if BackHomeCanteenFurnitureCfg[arg_28_1].canteen_sell_max[arg_28_2] and BackHomeCanteenFurnitureCfg[arg_28_1].canteen_sell_max[arg_28_2] > 0 then
		table.insert(self.skillList, {
			type = 3,
			effectType = CanteenConst.FurEffectType.SellMax,
			level = arg_28_2,
			cfgID = arg_28_1
		})
	elseif BackHomeCanteenFurnitureCfg[arg_28_1].canteen_sell_max[arg_28_2 + 1] and BackHomeCanteenFurnitureCfg[arg_28_1].canteen_sell_max[arg_28_2 + 1] > 0 then
		table.insert(self.skillList, {
			type = 4,
			effectType = CanteenConst.FurEffectType.SellMax,
			level = arg_28_2 + 1,
			cfgID = arg_28_1
		})
	end

	local var_28_0 = #DormSkillData:GetCookCanUnlockFoodList(arg_28_1, arg_28_2)

	if var_28_0 and var_28_0 > 0 then
		table.insert(self.skillList, {
			type = 3,
			effectType = CanteenConst.FurEffectType.UnLockFood,
			level = arg_28_2,
			cfgID = arg_28_1,
			unLockNum = var_28_0
		})
	else
		local var_28_1 = #DormSkillData:GetCookCanUnlockFoodList(arg_28_1, arg_28_2 + 1)

		if var_28_1 and var_28_1 > 0 then
			table.insert(self.skillList, {
				type = 4,
				effectType = CanteenConst.FurEffectType.UnLockFood,
				level = arg_28_2 + 1,
				cfgID = arg_28_1,
				unLockNum = var_28_1
			})
		end
	end
end

function RestaurantCookUpView:RefreshLevelUpInfo(arg_29_1, arg_29_2)
	self.conditionList = {}

	for iter_29_0, iter_29_1 in ipairs(BackHomeCanteenFurnitureCfg[arg_29_1].condition[arg_29_2]) do
		table.insert(self.conditionList, {
			type = 2,
			cfgID = iter_29_1
		})
	end

	if self.conditionList then
		self.conditionScroll:StartScroll(#self.conditionList)
	else
		self.conditionScroll:StartScroll(0)
	end
end

function RestaurantCookUpView:RefreshMaterialList(arg_30_1, arg_30_2)
	if BackHomeCanteenFurnitureCfg[arg_30_1].cost_material[arg_30_2] then
		self.materialList = {}

		for iter_30_0, iter_30_1 in ipairs(BackHomeCanteenFurnitureCfg[arg_30_1].cost_material[arg_30_2]) do
			table.insert(self.materialList, {
				id = iter_30_1[1],
				number = iter_30_1[2],
				clickFun = function(self)
					ShowPopItem(POP_ITEM, {
						self.id,
						self.num
					})
				end
			})
		end

		self.unlockScroll:StartScroll(#self.materialList)

		self.curIcon.sprite = ItemTools.getItemSprite(BackHomeCanteenFurnitureCfg[arg_30_1].cost_material[arg_30_2][1][1])
		self.costText_.text = BackHomeCanteenFurnitureCfg[arg_30_1].cost_material[arg_30_2][1][2]

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.costTrs_)
	else
		self.unlockScroll:StartScroll(0)
	end
end

function RestaurantCookUpView:CheckCurrency()
	local var_32_0 = CanteenData:GetFurInfoList()[self.furEID]

	for iter_32_0, iter_32_1 in ipairs(BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[self.furEID].type_id].cost_material[((var_32_0 or nil) and var_32_0.level) + 1]) do
		if ItemTools.getItemNum(iter_32_1[1]) < iter_32_1[2] then
			return false
		end
	end

	return true
end

function RestaurantCookUpView:Dispose()
	if self.tree_ then
		self.tree_:Dispose()

		self.tree_ = nil
	end

	if self.unlockScroll then
		self.unlockScroll:Dispose()

		self.unlockScroll = nil
	end

	if self.conditionScroll then
		self.conditionScroll:Dispose()

		self.conditionScroll = nil
	end

	if self.skillScroll then
		self.skillScroll:Dispose()

		self.skillScroll = nil
	end

	RestaurantCookUpView.super.Dispose(self)
end

return RestaurantCookUpView
