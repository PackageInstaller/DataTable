local RestaurantCookConditionItem = class("RestaurantCookConditionItem", ReduxView)

function RestaurantCookConditionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function RestaurantCookConditionItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.conditionController = ControllerUtil.GetController(self.tickTrs_, "state")
end

function RestaurantCookConditionItem:RefreshUI(arg_3_1)
	if arg_3_1.type == 1 then
		self.stateController:SetSelectedState("skill")

		if not arg_3_1.cfgID then
			self.skillText_.text = ""

			return
		end

		local var_3_0 = BackHomeHeroSkillCfg[arg_3_1.cfgID]

		if BackHomeHeroSkillCfg[arg_3_1.cfgID] then
			local var_3_1 = false
			local var_3_2 = DormSkillData:GetSkillDesc(arg_3_1.cfgID)

			if BackHomeCanteenFurnitureCfg[arg_3_1.furID].skill[arg_3_1.level + 1] then
				for iter_3_0, iter_3_1 in ipairs(BackHomeCanteenFurnitureCfg[arg_3_1.furID].skill[arg_3_1.level + 1]) do
					if BackHomeHeroSkillCfg[iter_3_1].type == var_3_0.type then
						if var_3_0.type == 1 or var_3_0.type == 2 then
							if var_3_0.param[1] == BackHomeHeroSkillCfg[iter_3_1].param[1] then
								self.skillText_.text = var_3_2 .. "<color=#e48a00> >>> " .. BackHomeHeroSkillCfg[iter_3_1].param[2] .. "%</color>"
							end
						else
							self.skillText_.text = var_3_2 .. "<color=#e48a00> >>> " .. BackHomeHeroSkillCfg[iter_3_1].param[1] .. "</color>"
						end

						var_3_1 = true

						break
					end
				end
			end

			if not var_3_1 then
				self.skillText_.text = var_3_2
			end
		else
			print("传入技能id错误")
		end
	elseif arg_3_1.type == 2 then
		self.stateController:SetSelectedState("condition")

		if not arg_3_1.cfgID then
			self.conditionText_.text = ""

			return
		end

		if ConditionCfg[arg_3_1.cfgID] then
			self.conditionText_.text = BackHomeTools:GetBackHomeConditionDes(arg_3_1.cfgID)

			if BackHomeTools:CheckBackHomeConditionAccord(arg_3_1.cfgID) then
				self.conditionController:SetSelectedState("true")
			else
				self.conditionController:SetSelectedState("false")

				if self.conFunc then
					self.conFunc(false)
				else
					print("未注册升级条件方法")
				end
			end
		end
	elseif arg_3_1.type == 3 then
		self.stateController:SetSelectedState("skill")

		if arg_3_1.effectType == CanteenConst.FurEffectType.Storage then
			if BackHomeCanteenFurnitureCfg[arg_3_1.cfgID].canteen_storage_max[arg_3_1.level] and BackHomeCanteenFurnitureCfg[arg_3_1.cfgID].canteen_storage_max[arg_3_1.level] > 0 then
				self.skillText_.text = not BackHomeCanteenFurnitureCfg[arg_3_1.cfgID].canteen_storage_max[arg_3_1.level + 1] and string.format(GetTips("CANTEEN_STORAGE_MAX_UP"), BackHomeCanteenFurnitureCfg[arg_3_1.cfgID].canteen_storage_max[arg_3_1.level]) or string.format(GetTips("CANTEEN_STORAGE_MAX_UP"), BackHomeCanteenFurnitureCfg[arg_3_1.cfgID].canteen_storage_max[arg_3_1.level]) .. RestaurantCookConditionItem:GetLevelUpDesc(" >>> " .. BackHomeCanteenFurnitureCfg[arg_3_1.cfgID].canteen_storage_max[arg_3_1.level + 1])
			end
		elseif arg_3_1.effectType == CanteenConst.FurEffectType.SellMax then
			if BackHomeCanteenFurnitureCfg[arg_3_1.cfgID].canteen_sell_max[arg_3_1.level] and BackHomeCanteenFurnitureCfg[arg_3_1.cfgID].canteen_sell_max[arg_3_1.level] > 0 then
				self.skillText_.text = not BackHomeCanteenFurnitureCfg[arg_3_1.cfgID].canteen_sell_max[arg_3_1.level + 1] and string.format(GetTips("CANTEEN_FOOD_SET_MAX_UP"), BackHomeCanteenFurnitureCfg[arg_3_1.cfgID].canteen_sell_max[arg_3_1.level]) or string.format(GetTips("CANTEEN_FOOD_SET_MAX_UP"), BackHomeCanteenFurnitureCfg[arg_3_1.cfgID].canteen_sell_max[arg_3_1.level]) .. RestaurantCookConditionItem:GetLevelUpDesc(" >>> " .. BackHomeCanteenFurnitureCfg[arg_3_1.cfgID].canteen_sell_max[arg_3_1.level + 1])
			end
		elseif arg_3_1.effectType == CanteenConst.FurEffectType.UnLockFood then
			local var_3_3 = CanteenTools:GetFootTypeName(BackHomeFurniture[arg_3_1.cfgID].type)

			if not BackHomeCanteenFurnitureCfg[arg_3_1.cfgID].canteen_sell_max[arg_3_1.level + 1] then
				self.skillText_.text = string.format(GetTips("CANTEEN_FOOD_UNLOCK_NUM"), var_3_3, tostring(arg_3_1.unLockNum))
			else
				local var_3_4 = #DormSkillData:GetCookCanUnlockFoodList(arg_3_1.cfgID, arg_3_1.level + 1)

				if arg_3_1.unLockNum and arg_3_1.unLockNum > 0 then
					self.skillText_.text = not var_3_4 and string.format(GetTips("CANTEEN_FOOD_UNLOCK_NUM"), var_3_3, tostring(arg_3_1.unLockNum)) or string.format(GetTips("CANTEEN_FOOD_UNLOCK_NUM"), var_3_3, tostring(arg_3_1.unLockNum)) .. RestaurantCookConditionItem:GetLevelUpDesc(" >>> " .. string.format(GetTips("DORM_CANTEEN_INFO_NUM"), var_3_4))
				end
			end
		end
	elseif arg_3_1.type == 4 then
		self.stateController:SetSelectedState("skill")

		if BackHomeHeroSkillCfg[arg_3_1.cfgID] then
			self.skillText_.text = RestaurantCookConditionItem:GetLevelUpDesc(string.format(GetTips("CANTEEN_UNLOCK_ITEM"), arg_3_1.level, GetI18NText(BackHomeHeroSkillCfg[arg_3_1.cfgID].desc)))
		elseif arg_3_1.effectType == CanteenConst.FurEffectType.Storage then
			self.skillText_.text = RestaurantCookConditionItem:GetLevelUpDesc(string.format(GetTips("CANTEEN_UNLOCK_ITEM"), arg_3_1.level, string.format(GetTips("CANTEEN_STORAGE_MAX_UP"), BackHomeCanteenFurnitureCfg[arg_3_1.cfgID].canteen_storage_max[arg_3_1.level])))
		elseif arg_3_1.effectType == CanteenConst.FurEffectType.SellMax then
			self.skillText_.text = RestaurantCookConditionItem:GetLevelUpDesc(string.format(GetTips("CANTEEN_UNLOCK_ITEM"), arg_3_1.level, string.format(GetTips("CANTEEN_FOOD_SET_MAX_UP"), BackHomeCanteenFurnitureCfg[arg_3_1.cfgID].canteen_sell_max[arg_3_1.level])))
		elseif arg_3_1.effectType == CanteenConst.FurEffectType.UnLockFood then
			self.skillText_.text = RestaurantCookConditionItem:GetLevelUpDesc(string.format(GetTips("CANTEEN_UNLOCK_ITEM"), arg_3_1.level, string.format(GetTips("CANTEEN_FOOD_UNLOCK_NUM"), tostring(arg_3_1.unLockNum))))
		end
	end
end

function RestaurantCookConditionItem:UpdataCondition(arg_4_1)
	if arg_4_1 then
		self.conFunc = arg_4_1
	end
end

function RestaurantCookConditionItem:GetLevelUpDesc(arg_5_1)
	return "<color=#e48a00>" .. arg_5_1 .. "</color>"
end

function RestaurantCookConditionItem:Dispose()
	RestaurantCookConditionItem.super.Dispose(self)
end

return RestaurantCookConditionItem
