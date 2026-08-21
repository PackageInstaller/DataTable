local var_0_0 = {
	GetDormAdditionByHeroID = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
		local var_1_0 = {
			attribute = {},
			voice = {}
		}
		local var_1_1 = DormData:GetHeroArchiveID(arg_1_1)
		local var_1_2 = table.indexof(DormHeroTools:GetCanUseHeroInDorm(), var_1_1)

		if not arg_1_2 and not var_1_2 then
			return var_1_0
		end

		local var_1_3 = DormHeroTools:GetTemplateIDInDorm(var_1_1)
		local var_1_4 = 0

		if not arg_1_3 then
			var_1_4 = arg_1_2 or DormHeroTools:GetDormLevelByHeroID(var_1_3)
		end

		for iter_1_0 = 1, var_1_4 do
			local var_1_5 = BackHomeHeroCfg[var_1_3].level_reward[iter_1_0]

			for iter_1_1, iter_1_2 in ipairs(var_1_5) do
				local var_1_6 = BackHomeDormLevelRewardCfg[iter_1_2]

				if var_1_6.type == 1 then
					if not var_1_0.attribute[var_1_6.reward[1]] then
						var_1_0.attribute[var_1_6.reward[1]] = 0
					end

					var_1_0.attribute[var_1_6.reward[1]] = var_1_0.attribute[var_1_6.reward[1]] + var_1_6.reward[2]
				elseif var_1_6.type == 2 then
					table.insert(var_1_0.voice, var_1_6.reward[1])
				end
			end
		end

		return var_1_0
	end,
	SecondSwitchTime = function(arg_2_0, arg_2_1)
		local var_2_0 = math.ceil(arg_2_1 / 60)
		local var_2_1 = math.modf(var_2_0 / 60)
		local var_2_2 = var_2_0 % 60
		local var_2_3 = GetTips("HOUR")
		local var_2_4 = GetTips("MINUTE")

		return string.format("%d%s%02d%s", var_2_1, var_2_3, var_2_2, var_2_4)
	end,
	MinSwitchTime = function(arg_3_0, arg_3_1)
		if arg_3_1 then
			local var_3_0, var_3_1 = math.modf(arg_3_1 / 60)

			return string.format("%02d:%02d:%02d", var_3_0, var_3_1, 0)
		end
	end,
	GetRoomTypeName = function(arg_4_0, arg_4_1)
		if arg_4_1 == DormConst.BACKHOME_TYPE.PublicDorm then
			return GetTips("DORM_FUR_INFO_TAG5")
		elseif arg_4_1 == DormConst.BACKHOME_TYPE.PrivateDorm then
			return GetTips("DORM_FUR_INFO_TAG6")
		elseif arg_4_1 == DormConst.BACKHOME_TYPE.Canteen then
			return GetTips("DORM_HERO_AT_CANTEEN")
		end
	end,
	GetAllDormShopIDList = function(arg_5_0)
		return ShopTools.CollectShopInGroup(GameSetting.dorm_shop_display_group_furniture.value)
	end,
	AnyShopInDiscount = function(arg_6_0)
		return ShopTools.IsAnyShopDiscount(arg_6_0:GetAllDormShopIDList())
	end,
	GetShopStyleImage = function(arg_7_0)
		return getSpriteViaConfig("DormShopPreview", arg_7_0)
	end,
	GetShopStyleHallImage = function(arg_8_0)
		return getSpriteViaConfig("DormShopHallPreview", arg_8_0)
	end,
	GetFurLable = function(arg_9_0, arg_9_1)
		local var_9_0 = {}
		local var_9_1 = BackHomeFurniture[arg_9_1]

		table.insert(var_9_0, "is_give")
		table.insert(var_9_0, "dorm_exp")
		table.insert(var_9_0, "hero_id")
		table.insert(var_9_0, "scene_id")

		return var_9_0
	end,
	GetFurLableDesc = function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = ""

		if arg_10_2 == "is_give" then
			if BackHomeFurniture[arg_10_1].is_give == 1 then
				local var_10_1 = BackHomeFurniture[arg_10_1].give_max

				var_10_0 = string.format(GetTips("DORM_FUR_INFO_TAG2"), var_10_1)
			else
				var_10_0 = GetTips("DORM_FUR_INFO_TAG1")
			end
		elseif arg_10_2 == "dorm_exp" then
			var_10_0 = string.format(GetTips("DORM_FUR_INFO_TAG7"), BackHomeFurniture[arg_10_1].dorm_exp)
		elseif arg_10_2 == "hero_id" then
			local var_10_2 = BackHomeFurniture[arg_10_1].hero_id

			if HeroRecordCfg[var_10_2] then
				local var_10_3 = HeroRecordCfg[var_10_2].name

				var_10_0 = string.format(GetTips("DORM_FUR_INFO_TAG3"), var_10_3)
			end
		elseif arg_10_2 == "scene_id" then
			local var_10_4 = BackHomeFurniture[arg_10_1].scene_id

			var_10_0 = GetTips("DORM_FUR_INFO_TAG4")

			for iter_10_0, iter_10_1 in ipairs(var_10_4) do
				var_10_0 = var_10_0 .. arg_10_0:GetRoomTypeName(iter_10_1) .. " "
			end

			string.sub(var_10_0, 1, -2)
		end

		return var_10_0
	end,
	GetFurGiftTypeDesc = function(arg_11_0, arg_11_1)
		local var_11_0 = ""

		if BackHomeFurniture[arg_11_1].is_give == 1 then
			local var_11_1 = BackHomeFurniture[arg_11_1].give_max

			var_11_0 = GetTips("DORM_FUR_INFO_CAN_GIFT")
		elseif BackHomeFurniture[arg_11_1].is_give == 0 then
			var_11_0 = GetTips("DORM_FUR_INFO_TAG1")
		elseif BackHomeFurniture[arg_11_1].is_give == 3 then
			local var_11_2 = BackHomeFurniture[arg_11_1].hero_id

			if HeroRecordCfg[var_11_2] then
				local var_11_3 = HeroRecordCfg[var_11_2].name

				var_11_0 = string.format(GetTips("DORM_FUR_INFO_TAG3"), GetI18NText(var_11_3))
			end
		end

		return var_11_0
	end,
	GetFurPlaceSceneDesc = function(arg_12_0, arg_12_1)
		local var_12_0 = ""
		local var_12_1 = BackHomeFurniture[arg_12_1].scene_id
		local var_12_2 = GetTips("DORM_FUR_INFO_TAG4")

		for iter_12_0, iter_12_1 in ipairs(var_12_1) do
			var_12_2 = var_12_2 .. arg_12_0:GetRoomTypeName(iter_12_1) .. " "
		end

		string.sub(var_12_2, 1, -2)

		return var_12_2
	end,
	GetFurGiftMaxDesc = function(arg_13_0, arg_13_1)
		if BackHomeFurniture[arg_13_1].give_max > 0 then
			return tostring(BackHomeFurniture[arg_13_1].give_max)
		else
			return GetTips("DORM_FUR_GIFT_NUM_NONE")
		end
	end,
	GetFurComfortDesc = function(arg_14_0, arg_14_1)
		if BackHomeFurniture[arg_14_1].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT then
			return GetTips("DORM_FUR_COMFORT_NONE")
		else
			return tostring(BackHomeFurniture[arg_14_1].dorm_exp)
		end
	end,
	PlayDormAudioEffect = function(arg_15_0, arg_15_1)
		manager.audio:PlayEffect("ui_dorm", arg_15_1, "")
	end,
	ShouldShowBirthdayBtn = function(arg_16_0, arg_16_1)
		return false
	end
}
local var_0_1 = {}

function var_0_0.SystemStayTime(arg_17_0, arg_17_1, arg_17_2)
	if not var_0_1 then
		var_0_1 = {}
	end

	if arg_17_2 == true then
		if var_0_1[arg_17_1] then
			local var_17_0 = manager.time:GetServerTime()

			SDKTools.SendMessageToSDK("backhome_dorm_opt", {
				backhome_type = arg_17_1,
				opt_time = var_17_0 - var_0_1[arg_17_1]
			})

			var_0_1[arg_17_1] = nil
		else
			CustomLog.log("未记录系统开始时间")
		end
	else
		var_0_1[arg_17_1] = manager.time:GetServerTime()

		SDKTools.SendMessageToSDK("backhome_dorm_opt", {
			opt_time = -1,
			backhome_type = arg_17_1
		})
	end
end

function dump_value_(arg_18_0)
	if type(arg_18_0) == "string" then
		arg_18_0 = "\"" .. arg_18_0 .. "\""
	end

	return tostring(arg_18_0)
end

function split(arg_19_0, arg_19_1)
	arg_19_0 = tostring(arg_19_0)
	arg_19_1 = tostring(arg_19_1)

	if arg_19_1 == "" then
		return false
	end

	local var_19_0 = 0
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in function()
		return string.find(arg_19_0, arg_19_1, var_19_0, true)
	end do
		table.insert(var_19_1, string.sub(arg_19_0, var_19_0, iter_19_0 - 1))

		var_19_0 = iter_19_1 + 1
	end

	table.insert(var_19_1, string.sub(arg_19_0, var_19_0))

	return var_19_1
end

function trim(arg_21_0)
	return (string.gsub(arg_21_0, "^%s*(.-)%s*$", "%1"))
end

local function var_0_2(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0) do
		print(iter_22_1)
	end
end

function dump(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if type(arg_23_2) ~= "number" then
		arg_23_2 = 7
	end

	local var_23_0 = {}
	local var_23_1 = {}
	local var_23_2 = split(debug.traceback("", 2), "\n")

	local function var_23_3(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
		arg_24_1 = arg_24_1 or "<var>"

		local var_24_0 = ""

		if type(arg_24_4) == "number" then
			var_24_0 = string.rep(" ", arg_24_4 - string.len(dump_value_(arg_24_1)))
		end

		if type(arg_24_0) ~= "table" then
			var_23_1[#var_23_1 + 1] = string.format("%s%s%s = %s", arg_24_2, dump_value_(arg_24_1), var_24_0, dump_value_(arg_24_0))
		elseif var_23_0[tostring(arg_24_0)] then
			var_23_1[#var_23_1 + 1] = string.format("%s%s%s = *REF*", arg_24_2, dump_value_(arg_24_1), var_24_0)
		else
			var_23_0[tostring(arg_24_0)] = true

			if arg_24_3 > arg_23_2 then
				var_23_1[#var_23_1 + 1] = string.format("%s%s = *MAX NESTING*", arg_24_2, dump_value_(arg_24_1))
			else
				var_23_1[#var_23_1 + 1] = string.format("%s%s = {", arg_24_2, dump_value_(arg_24_1))

				local var_24_1 = arg_24_2 .. "    "
				local var_24_2 = {}
				local var_24_3 = 0
				local var_24_4 = {}

				for iter_24_0, iter_24_1 in pairs(arg_24_0) do
					var_24_2[#var_24_2 + 1] = iter_24_0

					local var_24_5 = dump_value_(iter_24_0)
					local var_24_6 = string.len(var_24_5)

					if var_24_3 < var_24_6 then
						var_24_3 = var_24_6
					end

					var_24_4[iter_24_0] = iter_24_1
				end

				table.sort(var_24_2, function(arg_25_0, arg_25_1)
					if type(arg_25_0) == "number" and type(arg_25_1) == "number" then
						return arg_25_0 < arg_25_1
					else
						return tostring(arg_25_0) < tostring(arg_25_1)
					end
				end)

				for iter_24_2, iter_24_3 in ipairs(var_24_2) do
					var_23_3(var_24_4[iter_24_3], iter_24_3, var_24_1, arg_24_3 + 1, var_24_3)
				end

				var_23_1[#var_23_1 + 1] = string.format("%s}", arg_24_2)
			end
		end
	end

	var_23_3(arg_23_0, arg_23_1, "- ", 1)

	arg_23_3 = arg_23_3 or var_0_2

	return arg_23_3(var_23_1)
end

function var_0_0.CheckMax(arg_26_0)
	local var_26_0 = IdolTraineeData:GetIdolHeroData(arg_26_0)
	local var_26_1 = IdolTraineeTools:GetHeroIdolMaxProperty(arg_26_0)
	local var_26_2 = true

	for iter_26_0 = 1, DormConst.IDOL_TRAINEE_PROPERTY_COUNT do
		if var_26_0[iter_26_0] < var_26_1[iter_26_0] then
			var_26_2 = false

			break
		end
	end

	return var_26_2
end

function var_0_0.GetTotalGoal(arg_27_0)
	local var_27_0 = 0
	local var_27_1 = IdolTraineeData:GetIdolHeroData(arg_27_0)

	for iter_27_0 = 1, DormConst.IDOL_TRAINEE_PROPERTY_COUNT do
		var_27_0 = var_27_0 + var_27_1[iter_27_0]
	end

	return var_27_0
end

function var_0_0.SortDormHeroList(arg_28_0)
	CommonTools.UniversalSortEx(arg_28_0, {
		map = function(arg_29_0)
			local var_29_0 = DormData:GetHeroTemplateInfo(arg_29_0)

			if not var_29_0 then
				return 0
			end

			local var_29_1 = var_29_0:GetHeroState()

			if var_29_1 == DormEnum.DormHeroState.InPublicDorm then
				return -1
			elseif var_29_1 == DormEnum.DormHeroState.OutDorm then
				return -2
			elseif var_29_1 == DormEnum.DormHeroState.InPrivateDorm then
				return -3
			elseif var_29_1 == DormEnum.DormHeroState.InCanteenJob then
				local var_29_2 = DormData:GetHeroTemplateInfo(arg_29_0).jobType

				if var_29_2 == DormNpcTools.BackHomeNpcType.cook then
					return -4
				elseif var_29_2 == DormNpcTools.BackHomeNpcType.waiter then
					return -5
				elseif var_29_2 == DormNpcTools.BackHomeNpcType.cashier then
					return -6
				end
			elseif var_29_1 == DormEnum.DormHeroState.InCanteenEntrust then
				return -7
			elseif var_29_1 == DormEnum.DormHeroState.InIdolTraineeCamp then
				return -8
			end
		end
	}, {
		map = function(arg_30_0)
			return -DormData:GetHeroTemplateInfo(arg_30_0):GetFatigue()
		end
	}, {
		map = function(arg_31_0)
			return (DormData:GetHeroArchiveID(arg_31_0))
		end
	}, {
		map = function(arg_32_0)
			return arg_32_0
		end
	})
end

function var_0_0.SortAttackHeroList(arg_33_0)
	CommonTools.UniversalSortEx(arg_33_0, {
		map = function(arg_34_0)
			if HeroTools.GetHeroIsUnlock(arg_34_0) then
				return 1
			else
				return 0
			end
		end
	}, {
		map = function(arg_35_0)
			local var_35_0 = 0

			if IdolTraineeTools:CheckHeroIsAttack(arg_35_0) then
				var_35_0 = var_35_0 + 2
			end

			if IdolTraineeTools:CheckHeroIsDefine(arg_35_0) then
				var_35_0 = var_35_0 + 1
			end

			return var_35_0
		end
	}, {
		map = function(arg_36_0)
			if BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_36_0) then
				return 1
			else
				return 0
			end
		end
	}, {
		map = function(arg_37_0)
			if var_0_0.CheckMax(arg_37_0) then
				return 0
			else
				return 1
			end
		end
	}, {
		map = function(arg_38_0)
			return var_0_0.GetTotalGoal(arg_38_0)
		end
	}, {
		map = function(arg_39_0)
			local var_39_0 = DormData:GetHeroTemplateInfo(arg_39_0)

			if not var_39_0 then
				return 0
			end

			local var_39_1 = var_39_0:GetHeroState()

			if var_39_1 == DormEnum.DormHeroState.InCanteenEntrust then
				return 1
			elseif var_39_1 == DormEnum.DormHeroState.InPublicDorm then
				return 6
			elseif var_39_1 == DormEnum.DormHeroState.InPrivateDorm then
				return 5
			elseif var_39_1 == DormEnum.DormHeroState.InCanteenJob then
				local var_39_2 = DormData:GetHeroTemplateInfo(arg_39_0).jobType

				if var_39_2 == DormNpcTools.BackHomeNpcType.cook then
					return 2
				elseif var_39_2 == DormNpcTools.BackHomeNpcType.waiter then
					return 3
				elseif var_39_2 == DormNpcTools.BackHomeNpcType.cashier then
					return 4
				end
			elseif var_39_1 == DormEnum.DormHeroState.OutDorm then
				return 7
			elseif var_39_1 == DormEnum.DormHeroState.InIdolTraineeCamp then
				return 8
			end
		end
	}, {
		map = function(arg_40_0)
			return (DormData:GetHeroArchiveID(arg_40_0))
		end
	}, {
		map = function(arg_41_0)
			return -arg_41_0
		end
	})
end

function var_0_0.SortBattleHeroList(arg_42_0)
	CommonTools.UniversalSortEx(arg_42_0, {
		map = function(arg_43_0)
			if HeroTools.GetHeroIsUnlock(arg_43_0) then
				return 1
			else
				return 0
			end
		end
	}, {
		map = function(arg_44_0)
			local var_44_0 = 0

			if IdolTraineeTools:CheckHeroIsAttack(arg_44_0) then
				var_44_0 = var_44_0 + 2
			end

			if IdolTraineeTools:CheckHeroIsDefine(arg_44_0) then
				var_44_0 = var_44_0 + 1
			end

			return var_44_0
		end
	}, {
		map = function(arg_45_0)
			if BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_45_0) then
				return 1
			else
				return 0
			end
		end
	}, {
		map = function(arg_46_0)
			return var_0_0.GetTotalGoal(arg_46_0)
		end
	}, {
		map = function(arg_47_0)
			local var_47_0 = DormData:GetHeroTemplateInfo(arg_47_0)

			if not var_47_0 then
				return 0
			end

			local var_47_1 = var_47_0:GetHeroState()

			if var_47_1 == DormEnum.DormHeroState.InCanteenEntrust then
				return 1
			elseif var_47_1 == DormEnum.DormHeroState.InPublicDorm then
				return 6
			elseif var_47_1 == DormEnum.DormHeroState.InPrivateDorm then
				return 5
			elseif var_47_1 == DormEnum.DormHeroState.InCanteenJob then
				local var_47_2 = DormData:GetHeroTemplateInfo(arg_47_0).jobType

				if var_47_2 == DormNpcTools.BackHomeNpcType.cook then
					return 2
				elseif var_47_2 == DormNpcTools.BackHomeNpcType.waiter then
					return 3
				elseif var_47_2 == DormNpcTools.BackHomeNpcType.cashier then
					return 4
				end
			elseif var_47_1 == DormEnum.DormHeroState.OutDorm then
				return 7
			elseif var_47_1 == DormEnum.DormHeroState.InIdolTraineeCamp then
				return 8
			end
		end
	}, {
		map = function(arg_48_0)
			return (DormData:GetHeroArchiveID(arg_48_0))
		end
	}, {
		map = function(arg_49_0)
			return -arg_49_0
		end
	})
end

function var_0_0.SortTrainHeroList(arg_50_0)
	CommonTools.UniversalSortEx(arg_50_0, {
		map = function(arg_51_0)
			if HeroTools.GetHeroIsUnlock(arg_51_0) then
				return 1
			else
				return 0
			end
		end
	}, {
		map = function(arg_52_0)
			local var_52_0 = DormData:GetHeroTemplateInfo(arg_52_0)

			if not var_52_0 then
				return 0
			end

			local var_52_1 = var_52_0:GetHeroState()

			if var_52_1 == DormEnum.DormHeroState.InCanteenEntrust then
				return 1
			elseif var_52_1 == DormEnum.DormHeroState.InPublicDorm then
				return 6
			elseif var_52_1 == DormEnum.DormHeroState.InPrivateDorm then
				return 5
			elseif var_52_1 == DormEnum.DormHeroState.InCanteenJob then
				local var_52_2 = DormData:GetHeroTemplateInfo(arg_52_0).jobType

				if var_52_2 == DormNpcTools.BackHomeNpcType.cook then
					return 2
				elseif var_52_2 == DormNpcTools.BackHomeNpcType.waiter then
					return 3
				elseif var_52_2 == DormNpcTools.BackHomeNpcType.cashier then
					return 4
				end
			elseif var_52_1 == DormEnum.DormHeroState.OutDorm then
				return 7
			elseif var_52_1 == DormEnum.DormHeroState.InIdolTraineeCamp then
				return 8
			end
		end
	}, {
		map = function(arg_53_0)
			local var_53_0 = 0

			if IdolTraineeTools:CheckHeroIsAttack(arg_53_0) then
				var_53_0 = var_53_0 + 2
			end

			if IdolTraineeTools:CheckHeroIsDefine(arg_53_0) then
				var_53_0 = var_53_0 + 1
			end

			return var_53_0
		end
	}, {
		map = function(arg_54_0)
			if BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_54_0) then
				return 1
			else
				return 0
			end
		end
	}, {
		map = function(arg_55_0)
			if var_0_0.CheckMax(arg_55_0) then
				return 0
			else
				return 1
			end
		end
	}, {
		map = function(arg_56_0)
			return var_0_0.GetTotalGoal(arg_56_0)
		end
	}, {
		map = function(arg_57_0)
			return (DormData:GetHeroArchiveID(arg_57_0))
		end
	}, {
		map = function(arg_58_0)
			return -arg_58_0
		end
	})
end

return var_0_0
