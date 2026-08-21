local var_0_0 = class("RestaurantCookConditionItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController = ControllerUtil.GetController(arg_2_0.transform_, "state")
	arg_2_0.conditionController = ControllerUtil.GetController(arg_2_0.tickTrs_, "state")
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.cfgID
	local var_3_1 = arg_3_1.type
	local var_3_2 = arg_3_1.level

	if var_3_1 == 1 then
		local var_3_3 = arg_3_1.furID

		arg_3_0.stateController:SetSelectedState("skill")

		if not var_3_0 then
			arg_3_0.skillText_.text = ""

			return
		end

		local var_3_4 = BackHomeHeroSkillCfg[var_3_0]

		if var_3_4 then
			local var_3_5 = false
			local var_3_6 = DormSkillData:GetSkillDesc(var_3_0)

			if BackHomeCanteenFurnitureCfg[var_3_3].skill[var_3_2 + 1] then
				local var_3_7 = BackHomeCanteenFurnitureCfg[var_3_3].skill[var_3_2 + 1]

				for iter_3_0, iter_3_1 in ipairs(var_3_7) do
					if BackHomeHeroSkillCfg[iter_3_1].type == var_3_4.type then
						if var_3_4.type == 1 or var_3_4.type == 2 then
							if var_3_4.param[1] == BackHomeHeroSkillCfg[iter_3_1].param[1] then
								arg_3_0.skillText_.text = var_3_6 .. "<color=#e48a00> >>> " .. BackHomeHeroSkillCfg[iter_3_1].param[2] .. "%</color>"
							end
						else
							arg_3_0.skillText_.text = var_3_6 .. "<color=#e48a00> >>> " .. BackHomeHeroSkillCfg[iter_3_1].param[1] .. "</color>"
						end

						var_3_5 = true

						break
					end
				end
			end

			if not var_3_5 then
				arg_3_0.skillText_.text = var_3_6
			end
		else
			print("传入技能id错误")
		end
	elseif var_3_1 == 2 then
		arg_3_0.stateController:SetSelectedState("condition")

		if not var_3_0 then
			arg_3_0.conditionText_.text = ""

			return
		end

		if ConditionCfg[var_3_0] then
			arg_3_0.conditionText_.text = BackHomeTools:GetBackHomeConditionDes(var_3_0)

			if BackHomeTools:CheckBackHomeConditionAccord(var_3_0) then
				arg_3_0.conditionController:SetSelectedState("true")
			else
				arg_3_0.conditionController:SetSelectedState("false")

				if arg_3_0.conFunc then
					arg_3_0.conFunc(false)
				else
					print("未注册升级条件方法")
				end
			end
		end
	elseif var_3_1 == 3 then
		arg_3_0.stateController:SetSelectedState("skill")

		local var_3_8 = arg_3_1.level

		if arg_3_1.effectType == CanteenConst.FurEffectType.Storage then
			local var_3_9 = BackHomeCanteenFurnitureCfg[var_3_0].canteen_storage_max[var_3_8]
			local var_3_10 = BackHomeCanteenFurnitureCfg[var_3_0].canteen_storage_max[var_3_8 + 1]

			if var_3_9 and var_3_9 > 0 then
				if not var_3_10 then
					arg_3_0.skillText_.text = string.format(GetTips("CANTEEN_STORAGE_MAX_UP"), var_3_9)
				else
					arg_3_0.skillText_.text = string.format(GetTips("CANTEEN_STORAGE_MAX_UP"), var_3_9) .. var_0_0:GetLevelUpDesc(" >>> " .. var_3_10)
				end
			end
		elseif arg_3_1.effectType == CanteenConst.FurEffectType.SellMax then
			local var_3_11 = BackHomeCanteenFurnitureCfg[var_3_0].canteen_sell_max[var_3_8]
			local var_3_12 = BackHomeCanteenFurnitureCfg[var_3_0].canteen_sell_max[var_3_8 + 1]

			if var_3_11 and var_3_11 > 0 then
				if not var_3_12 then
					arg_3_0.skillText_.text = string.format(GetTips("CANTEEN_FOOD_SET_MAX_UP"), var_3_11)
				else
					arg_3_0.skillText_.text = string.format(GetTips("CANTEEN_FOOD_SET_MAX_UP"), var_3_11) .. var_0_0:GetLevelUpDesc(" >>> " .. var_3_12)
				end
			end
		elseif arg_3_1.effectType == CanteenConst.FurEffectType.UnLockFood then
			local var_3_13 = arg_3_1.unLockNum
			local var_3_14 = arg_3_1.cfgID
			local var_3_15 = CanteenTools:GetFootTypeName(BackHomeFurniture[var_3_14].type)

			if not BackHomeCanteenFurnitureCfg[var_3_0].canteen_sell_max[var_3_8 + 1] then
				arg_3_0.skillText_.text = string.format(GetTips("CANTEEN_FOOD_UNLOCK_NUM"), var_3_15, tostring(var_3_13))
			else
				local var_3_16 = #DormSkillData:GetCookCanUnlockFoodList(var_3_14, var_3_8 + 1)

				if var_3_13 and var_3_13 > 0 then
					if not var_3_16 then
						arg_3_0.skillText_.text = string.format(GetTips("CANTEEN_FOOD_UNLOCK_NUM"), var_3_15, tostring(var_3_13))
					else
						arg_3_0.skillText_.text = string.format(GetTips("CANTEEN_FOOD_UNLOCK_NUM"), var_3_15, tostring(var_3_13)) .. var_0_0:GetLevelUpDesc(" >>> " .. string.format(GetTips("DORM_CANTEEN_INFO_NUM"), var_3_16))
					end
				end
			end
		end
	elseif var_3_1 == 4 then
		arg_3_0.stateController:SetSelectedState("skill")

		local var_3_17 = arg_3_1.level

		if BackHomeHeroSkillCfg[var_3_0] then
			arg_3_0.skillText_.text = var_0_0:GetLevelUpDesc(string.format(GetTips("CANTEEN_UNLOCK_ITEM"), var_3_17, GetI18NText(BackHomeHeroSkillCfg[var_3_0].desc)))
		elseif arg_3_1.effectType == CanteenConst.FurEffectType.Storage then
			local var_3_18 = BackHomeCanteenFurnitureCfg[var_3_0].canteen_storage_max[var_3_17]

			arg_3_0.skillText_.text = var_0_0:GetLevelUpDesc(string.format(GetTips("CANTEEN_UNLOCK_ITEM"), var_3_17, string.format(GetTips("CANTEEN_STORAGE_MAX_UP"), var_3_18)))
		elseif arg_3_1.effectType == CanteenConst.FurEffectType.SellMax then
			local var_3_19 = BackHomeCanteenFurnitureCfg[var_3_0].canteen_sell_max[var_3_17]

			arg_3_0.skillText_.text = var_0_0:GetLevelUpDesc(string.format(GetTips("CANTEEN_UNLOCK_ITEM"), var_3_17, string.format(GetTips("CANTEEN_FOOD_SET_MAX_UP"), var_3_19)))
		elseif arg_3_1.effectType == CanteenConst.FurEffectType.UnLockFood then
			local var_3_20 = arg_3_1.unLockNum

			arg_3_0.skillText_.text = var_0_0:GetLevelUpDesc(string.format(GetTips("CANTEEN_UNLOCK_ITEM"), var_3_17, string.format(GetTips("CANTEEN_FOOD_UNLOCK_NUM"), tostring(var_3_20))))
		end
	end
end

function var_0_0.UpdataCondition(arg_4_0, arg_4_1)
	if arg_4_1 then
		arg_4_0.conFunc = arg_4_1
	end
end

function var_0_0.GetLevelUpDesc(arg_5_0, arg_5_1)
	return "<color=#e48a00>" .. arg_5_1 .. "</color>"
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
