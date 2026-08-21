local var_0_0 = singletonClass("WarChessData")
local var_0_1 = 0
local var_0_2
local var_0_3
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = {}
local var_0_7
local var_0_8
local var_0_9 = {}
local var_0_10 = {}
local var_0_11
local var_0_12 = {}
local var_0_13 = {}
local var_0_14 = 0
local var_0_15 = {}
local var_0_16 = {}
local var_0_17 = 0
local var_0_18 = 0
local var_0_19 = {}
local var_0_20 = {}

function var_0_0.Init(arg_1_0)
	var_0_2 = nil
	var_0_3 = nil
	var_0_4 = {}

	local var_1_0 = {}
	local var_1_1

	var_0_8 = nil
	var_0_14 = 0
	var_0_15 = {}
	var_0_1 = 0
	var_0_16 = {}
	var_0_17 = 0
	var_0_18 = 0
	var_0_19 = {}
end

function var_0_0.SetWarChessData(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = NewWarChessLevelCfg[arg_2_1]

	var_0_2 = var_2_0.activity
	var_0_3 = ActivityTools.GetMainActivityId(var_0_2)
	var_0_4.mapId = var_2_0.id_level
	var_0_4.bronPos = {
		x = arg_2_2.pos.x,
		z = arg_2_2.pos.z
	}

	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_2.task) do
		table.insert(var_2_1, {
			taskID = iter_2_1.id,
			progress = iter_2_1.progress
		})
	end

	var_0_4.taskList = var_2_1

	local var_2_2 = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_2.buff) do
		table.insert(var_2_2, {
			buffID = iter_2_3.id,
			duration = iter_2_3.duration
		})
	end

	var_0_4.buffList = var_2_2

	local var_2_3 = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_2.global_event) do
		table.insert(var_2_3, iter_2_5.global_event_id)
	end

	var_0_4.globalEventList = var_2_3
	var_0_9 = {}

	for iter_2_6, iter_2_7 in ipairs(arg_2_2.attribute) do
		var_0_9[iter_2_7.id] = iter_2_7.value
	end

	var_0_10 = {}

	for iter_2_8, iter_2_9 in ipairs(arg_2_2.dice) do
		table.insert(var_0_10, iter_2_9)
	end

	var_0_11 = nil
	var_0_13 = {}
	var_0_14 = 0

	for iter_2_10, iter_2_11 in ipairs(arg_2_2.skill) do
		local var_2_4 = NewWarChessDiceSkillCfg[iter_2_11.id]
		local var_2_5

		if var_2_4.use_limit ~= 0 then
			var_2_5 = var_2_4.use_limit
			var_2_5 = var_2_5 - iter_2_11.times
		else
			var_2_5 = -1
		end

		table.insert(var_0_13, {
			skillID = iter_2_11.id,
			useLimit = var_2_5,
			skillIndex = var_0_14
		})

		var_0_14 = var_0_14 + 1
	end

	var_0_12 = {}

	for iter_2_12, iter_2_13 in ipairs(arg_2_2.hero) do
		table.insert(var_0_12, {
			iter_2_13.id,
			iter_2_13.hp_ratio
		})
	end

	local var_2_6 = {}

	for iter_2_14, iter_2_15 in ipairs(arg_2_2.floor) do
		var_2_6[NewChessTools.TwoDToOneD(iter_2_15.pos.x, iter_2_15.pos.z)] = {
			tag = iter_2_15.tag,
			pos = {
				x = iter_2_15.pos.x,
				z = iter_2_15.pos.z
			},
			status = iter_2_15.state or 0,
			direction = (iter_2_15.rotation or 0) / 60
		}
	end

	var_0_4.mapChangeInfo = var_2_6

	local var_2_7 = {}

	for iter_2_16, iter_2_17 in ipairs(arg_2_2.object) do
		var_2_7[NewChessTools.TwoDToOneD(iter_2_17.pos.x, iter_2_17.pos.z)] = {
			objecttag = iter_2_17.tag,
			pos = {
				x = iter_2_17.pos.x,
				z = iter_2_17.pos.z
			},
			objectdirection = (iter_2_17.rotation or 0) / 60
		}
	end

	var_0_4.objectChangeInfo = var_2_7
	var_0_4.fogInfo = WarChessTools.DecodeFogInfo(arg_2_2.fog)
	var_0_4.direction = arg_2_2.direction
	var_0_4.curChanceID = arg_2_2.choose_list.chance_id
	var_0_4.curChancePosx = arg_2_2.choose_list.pos.x
	var_0_4.curChancePosz = arg_2_2.choose_list.pos.z
	var_0_17 = arg_2_2.choose_list.chance_id
	var_0_19 = {}

	for iter_2_18, iter_2_19 in ipairs(arg_2_2.choose_list.choose_list) do
		table.insert(var_0_19, {
			chanceItemID = iter_2_19.id,
			state = iter_2_19.state,
			ispre = iter_2_19.is_pre
		})
	end
end

function var_0_0.GetCurrentWarChessMapData(arg_3_0)
	return var_0_4
end

function var_0_0.GetCurrentWarChessMapID(arg_4_0)
	if var_0_4.mapId then
		return var_0_4.mapId
	else
		return arg_4_0:GetTemporaryData("CurEnterMapID")
	end
end

function var_0_0.GetCurrentActivity(arg_5_0)
	return var_0_2
end

function var_0_0.GetCurrentMainActivity(arg_6_0)
	return var_0_3
end

function var_0_0.SetExtendMap(arg_7_0, arg_7_1)
	var_0_5 = arg_7_1
end

function var_0_0.SetExtendObjectMap(arg_8_0, arg_8_1)
	var_0_6 = arg_8_1
end

function var_0_0.SetJsonMap(arg_9_0, arg_9_1)
	var_0_7 = arg_9_1
end

function var_0_0.AboutToStart(arg_10_0)
	var_0_8 = true
end

function var_0_0.IsAboutToStart(arg_11_0)
	local var_11_0 = var_0_8

	var_0_8 = false

	return var_11_0
end

function var_0_0.GetAttribute(arg_12_0, arg_12_1)
	local var_12_0
	local var_12_1

	if type(arg_12_1) == "string" then
		var_12_0 = arg_12_1
		var_12_1 = NewWarChessAttributeCfg[var_12_0].id
	elseif type(arg_12_1) == "number" then
		var_12_1 = arg_12_1

		for iter_12_0, iter_12_1 in pairs(NewWarChessAttributeCfg) do
			if iter_12_1.id == arg_12_1 then
				var_12_0 = iter_12_0

				break
			end
		end
	end

	if var_0_9[var_12_1] then
		if var_0_9[var_12_1] < NewWarChessAttributeCfg[var_12_0].min then
			return NewWarChessAttributeCfg[var_12_0].min
		end

		return var_0_9[var_12_1]
	else
		return NewWarChessAttributeCfg[var_12_0].default
	end
end

function var_0_0.SubAttribute(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0
	local var_13_1

	if type(arg_13_1) == "string" then
		var_13_0 = arg_13_1
		var_13_1 = NewWarChessAttributeCfg[var_13_0].id
	elseif type(arg_13_1) == "number" then
		var_13_1 = arg_13_1

		for iter_13_0, iter_13_1 in pairs(NewWarChessAttributeCfg) do
			if iter_13_1.id == arg_13_1 then
				var_13_0 = iter_13_0

				break
			end
		end
	end

	if var_0_9[var_13_1] then
		var_0_9[var_13_1] = var_0_9[var_13_1] + arg_13_2
	else
		var_0_9[var_13_1] = NewWarChessAttributeCfg[var_13_0].default + arg_13_2
	end

	if var_13_0 == "GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT" then
		manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATEMOVEPOINT)
	end
end

function var_0_0.SetAttribute(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0
	local var_14_1

	if type(arg_14_1) == "string" then
		var_14_0 = arg_14_1
		var_14_1 = NewWarChessAttributeCfg[var_14_0].id
	elseif type(arg_14_1) == "number" then
		var_14_1 = arg_14_1

		for iter_14_0, iter_14_1 in pairs(NewWarChessAttributeCfg) do
			if iter_14_1.id == arg_14_1 then
				var_14_0 = iter_14_0

				break
			end
		end
	end

	var_0_9[var_14_1] = arg_14_2

	if var_14_0 == "GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT" then
		manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATEMOVEPOINT)
	end

	return var_0_9[var_14_1]
end

function var_0_0.FixCurMapNewDayMovePoint(arg_15_0)
	if var_0_4 and var_0_4.mapId then
		arg_15_0:SetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT", arg_15_0:GetMovePoint(var_0_4.mapId))
	end
end

function var_0_0.SetCurrentIndex(arg_16_0, arg_16_1, arg_16_2)
	if var_0_4.bronPos.x == arg_16_1 and var_0_4.bronPos.z == arg_16_2 then
		return false
	end

	var_0_4.bronPos = {
		x = arg_16_1,
		z = arg_16_2
	}

	return true
end

function var_0_0.GetCurrentIndex(arg_17_0)
	return var_0_4.bronPos
end

function var_0_0.GetCharacterDirection(arg_18_0)
	return var_0_4.direction
end

function var_0_0.SetCharacterDirection(arg_19_0, arg_19_1)
	var_0_4.direction = arg_19_1
end

function var_0_0.ChangeFogInfo(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in pairs(arg_20_1) do
		-- block empty
	end
end

function var_0_0.ChangeGridLua(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = var_0_4.mapChangeInfo[NewChessTools.TwoDToOneD(arg_21_1, arg_21_2)]
	local var_21_1

	if var_21_0 then
		if arg_21_3 ~= 0 then
			var_21_1 = NewChessTools.CreateChessData(arg_21_1, arg_21_2, var_0_5, arg_21_3)
		else
			var_21_1 = NewChessTools.CreateChessData(arg_21_1, arg_21_2, var_0_7, NewChessTools.TwoDToOneD(arg_21_1, arg_21_2))
		end

		var_21_0.direction = var_21_1.direction
		var_21_0.status = var_21_1.status
		var_21_0.attribute = var_21_1.attribute
	elseif arg_21_3 ~= 0 then
		local var_21_2 = NewChessTools.CreateChessData(arg_21_1, arg_21_2, var_0_5, arg_21_3)

		var_21_0 = NewChessTools.CreateChessData(arg_21_1, arg_21_2, var_0_7, NewChessTools.TwoDToOneD(arg_21_1, arg_21_2))
		var_21_0.direction = var_21_2.direction
		var_21_0.status = var_21_2.status
		var_21_0.attribute = var_21_2.attribute
	else
		var_21_0 = NewChessTools.CreateChessData(arg_21_1, arg_21_2, var_0_7, NewChessTools.TwoDToOneD(arg_21_1, arg_21_2))
	end

	var_21_0.tag = arg_21_3
	var_0_4.mapChangeInfo[NewChessTools.TwoDToOneD(arg_21_1, arg_21_2)] = var_21_0
end

function var_0_0.ChangeGridLuaInheritDir(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = var_0_4.mapChangeInfo[NewChessTools.TwoDToOneD(arg_22_1, arg_22_2)]
	local var_22_1

	if var_22_0 then
		if arg_22_3 ~= 0 then
			var_22_1 = NewChessTools.CreateChessData(arg_22_1, arg_22_2, var_0_5, arg_22_3)
		else
			var_22_1 = NewChessTools.CreateChessData(arg_22_1, arg_22_2, var_0_7, NewChessTools.TwoDToOneD(arg_22_1, arg_22_2))
		end

		var_22_0.direction = var_22_0.direction
		var_22_0.status = var_22_1.status
		var_22_0.attribute = var_22_1.attribute
	elseif arg_22_3 ~= 0 then
		local var_22_2 = NewChessTools.CreateChessData(arg_22_1, arg_22_2, var_0_5, arg_22_3)

		var_22_0 = NewChessTools.CreateChessData(arg_22_1, arg_22_2, var_0_7, NewChessTools.TwoDToOneD(arg_22_1, arg_22_2))
		var_22_0.direction = var_22_0.direction
		var_22_0.status = var_22_2.status
		var_22_0.attribute = var_22_2.attribute
	else
		var_22_0 = NewChessTools.CreateChessData(arg_22_1, arg_22_2, var_0_7, NewChessTools.TwoDToOneD(arg_22_1, arg_22_2))
	end

	var_22_0.tag = arg_22_3
	var_0_4.mapChangeInfo[NewChessTools.TwoDToOneD(arg_22_1, arg_22_2)] = var_22_0
end

function var_0_0.ChangeObjectLua(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = var_0_4.objectChangeInfo[NewChessTools.TwoDToOneD(arg_23_1, arg_23_2)]
	local var_23_1

	if var_23_0 then
		if arg_23_3 ~= 0 then
			var_23_1 = NewChessTools.CreateChessData(arg_23_1, arg_23_2, var_0_6, arg_23_3)
		else
			var_23_1 = NewChessTools.CreateChessData(arg_23_1, arg_23_2, var_0_7, NewChessTools.TwoDToOneD(arg_23_1, arg_23_2))
		end

		var_23_0.objectdirection = var_23_1.objectdirection
	elseif arg_23_3 ~= 0 then
		local var_23_2 = NewChessTools.CreateChessData(arg_23_1, arg_23_2, var_0_6, arg_23_3)

		var_23_0 = NewChessTools.CreateChessData(arg_23_1, arg_23_2, var_0_7, NewChessTools.TwoDToOneD(arg_23_1, arg_23_2))
		var_23_0.objectdirection = var_23_2.objectdirection
	else
		var_23_0 = NewChessTools.CreateChessData(arg_23_1, arg_23_2, var_0_7, NewChessTools.TwoDToOneD(arg_23_1, arg_23_2))
	end

	var_23_0.objecttag = arg_23_3
	var_0_4.objectChangeInfo[NewChessTools.TwoDToOneD(arg_23_1, arg_23_2)] = var_23_0
end

function var_0_0.DeleteObjectLua(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = var_0_4.objectChangeInfo[NewChessTools.TwoDToOneD(arg_24_1, arg_24_2)]

	if var_24_0 then
		-- block empty
	else
		var_24_0 = NewChessTools.CreateChessData(arg_24_1, arg_24_2, var_0_7, NewChessTools.TwoDToOneD(arg_24_1, arg_24_2))
	end

	var_24_0.objecttag = -1
	var_24_0.objectdirection = 0
	var_0_4.objectChangeInfo[NewChessTools.TwoDToOneD(arg_24_1, arg_24_2)] = var_24_0
end

function var_0_0.GetGridLua(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = var_0_4.mapChangeInfo[NewChessTools.TwoDToOneD(arg_25_1, arg_25_2)]

	if not var_25_0 then
		return NewChessTools.CreateChessData(arg_25_1, arg_25_2, var_0_7, NewChessTools.TwoDToOneD(arg_25_1, arg_25_2))
	end

	return var_25_0
end

function var_0_0.ChangeGridDirection(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = var_0_4.mapChangeInfo[NewChessTools.TwoDToOneD(arg_26_1, arg_26_2)] or NewChessTools.CreateChessData(arg_26_1, arg_26_2, var_0_7, NewChessTools.TwoDToOneD(arg_26_1, arg_26_2))

	var_26_0.direction = math.fmod(var_26_0.direction + arg_26_3, 6)
	var_0_4.mapChangeInfo[NewChessTools.TwoDToOneD(arg_26_1, arg_26_2)] = var_26_0
end

function var_0_0.ChangeObjectDirection(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = var_0_4.objectChangeInfo[NewChessTools.TwoDToOneD(arg_27_1, arg_27_2)] or NewChessTools.CreateChessData(arg_27_1, arg_27_2, var_0_7, NewChessTools.TwoDToOneD(arg_27_1, arg_27_2))

	var_27_0.objectdirection = math.fmod(var_27_0.objectdirection + arg_27_3, 6)
	var_0_4.objectChangeInfo[NewChessTools.TwoDToOneD(arg_27_1, arg_27_2)] = var_27_0
end

function var_0_0.GetGridDirection(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = var_0_4.mapChangeInfo[NewChessTools.TwoDToOneD(arg_28_1, arg_28_2)] or NewChessTools.CreateChessData(arg_28_1, arg_28_2, var_0_7, NewChessTools.TwoDToOneD(arg_28_1, arg_28_2))

	var_0_4.mapChangeInfo[NewChessTools.TwoDToOneD(arg_28_1, arg_28_2)] = var_28_0

	return var_28_0.direction
end

function var_0_0.GetDiceContinuousList(arg_29_0)
	if var_0_11 == nil then
		var_0_11 = {}

		for iter_29_0, iter_29_1 in pairs(var_0_10) do
			table.insert(var_0_11, {
				iter_29_1
			})
		end
	end

	return var_0_11
end

function var_0_0.ClearDiceContinuousList(arg_30_0)
	var_0_11 = nil
end

function var_0_0.ClearAniCache(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(var_0_11) do
		iter_31_1.IsNew = false
	end
end

function var_0_0.ReCacheDiceData(arg_32_0)
	var_0_11 = {}

	for iter_32_0, iter_32_1 in pairs(var_0_10) do
		table.insert(var_0_11, {
			iter_32_1
		})
	end
end

function var_0_0.CheckDiceNum(arg_33_0)
	if arg_33_0:GetDiceNum() >= arg_33_0:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_DICE_MAX") then
		return true
	end

	return false
end

function var_0_0.AddDice(arg_34_0, arg_34_1)
	table.insert(var_0_10, arg_34_1)

	local var_34_0 = {
		arg_34_1
	}

	var_34_0.IsNew = true

	table.insert(var_0_11, var_34_0)
end

function var_0_0.RemoveDice(arg_35_0, arg_35_1)
	for iter_35_0, iter_35_1 in pairs(arg_35_1) do
		local var_35_0 = false

		for iter_35_2, iter_35_3 in pairs(var_0_10) do
			if iter_35_3 == iter_35_1 then
				var_0_10[iter_35_2] = 0
				var_35_0 = true

				break
			end
		end

		if not var_35_0 then
			print("lrq 移除了当前没有的骰子！！！")
		end
	end

	local var_35_1 = {}

	for iter_35_4, iter_35_5 in pairs(var_0_10) do
		if iter_35_5 ~= 0 then
			table.insert(var_35_1, iter_35_5)
		end
	end

	var_0_10 = var_35_1
	var_0_11 = nil

	manager.notify:CallUpdateFunc(NEWWARCHESS_DICE_UPDATE)
end

function var_0_0.GetDiceNum(arg_36_0)
	return #var_0_10
end

function var_0_0.RemoveFrontDice(arg_37_0, arg_37_1)
	local var_37_0 = {}

	for iter_37_0 = arg_37_1 + 1, #var_0_10 do
		table.insert(var_37_0, var_0_10[iter_37_0])
	end

	var_0_10 = var_37_0
	var_0_11 = nil

	manager.notify:CallUpdateFunc(NEWWARCHESS_DICE_UPDATE)
end

function var_0_0.SubDiceListNum(arg_38_0, arg_38_1)
	for iter_38_0, iter_38_1 in pairs(var_0_10) do
		var_0_10[iter_38_0] = iter_38_1 + arg_38_1

		if var_0_10[iter_38_0] > 6 then
			var_0_10[iter_38_0] = 6
		end

		if var_0_10[iter_38_0] < 1 then
			var_0_10[iter_38_0] = 1
		end
	end

	var_0_11 = nil

	manager.notify:CallUpdateFunc(NEWWARCHESS_DICE_UPDATE)
end

function var_0_0.RemoveAllDice(arg_39_0)
	var_0_10 = {}
	var_0_11 = nil

	manager.notify:CallUpdateFunc(NEWWARCHESS_DICE_UPDATE)
end

function var_0_0.SetAllDice(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in pairs(var_0_10) do
		var_0_10[iter_40_0] = arg_40_1
	end

	var_0_11 = nil

	manager.notify:CallUpdateFunc(NEWWARCHESS_DICE_UPDATE)
end

function var_0_0.AddNewSkill(arg_41_0, arg_41_1)
	local var_41_0 = NewWarChessDiceSkillCfg[arg_41_1]
	local var_41_1

	if var_41_0.use_limit ~= 0 then
		var_41_1 = var_41_0.use_limit
	else
		var_41_1 = -1
	end

	table.insert(var_0_13, {
		skillID = arg_41_1,
		useLimit = var_41_1
	})
end

function var_0_0.GetSkillList(arg_42_0)
	return var_0_13
end

function var_0_0.UseSkill(arg_43_0, arg_43_1)
	for iter_43_0, iter_43_1 in pairs(var_0_13) do
		if iter_43_1.skillID == arg_43_1 then
			if iter_43_1.useLimit <= 0 then
				Debug.LogError("该技能使用次数为0")
			else
				iter_43_1.useLimit = iter_43_1.useLimit - 1
			end
		end
	end
end

function var_0_0.AddAllSkillCount(arg_44_0)
	for iter_44_0, iter_44_1 in pairs(var_0_13) do
		local var_44_0 = NewWarChessDiceSkillCfg[iter_44_1.skillID]

		if var_44_0.use_limit ~= 0 then
			iter_44_1.useLimit = var_44_0.use_limit
		else
			iter_44_1.useLimit = -1
		end
	end
end

function var_0_0.GetSkillInfo(arg_45_0, arg_45_1)
	for iter_45_0, iter_45_1 in pairs(var_0_13) do
		if iter_45_1.skillID == arg_45_1 then
			return iter_45_1
		end
	end

	return 0
end

function var_0_0.AddNewHero(arg_46_0, arg_46_1)
	for iter_46_0, iter_46_1 in pairs(var_0_12) do
		if arg_46_1 == iter_46_1[1] then
			return false
		end
	end

	table.insert(var_0_12, {
		arg_46_1,
		NewChessConst.HERO_HP_RATE
	})

	return true
end

function var_0_0.SetServerHeroList(arg_47_0, arg_47_1)
	var_0_12 = arg_47_1
end

function var_0_0.GetHeroInfoList(arg_48_0)
	return var_0_12
end

function var_0_0.GetHeroInfo(arg_49_0, arg_49_1)
	for iter_49_0, iter_49_1 in pairs(var_0_12) do
		if arg_49_1 == iter_49_1[1] then
			return iter_49_1
		end
	end
end

function var_0_0.GetHeroHp(arg_50_0, arg_50_1)
	for iter_50_0, iter_50_1 in pairs(var_0_12) do
		if arg_50_1 == NewWarChessHeroCfg[iter_50_1[1]].hero_id then
			return iter_50_1[2]
		end
	end

	return NewChessConst.HERO_HP_RATE
end

function var_0_0.SubAllHeroHp(arg_51_0, arg_51_1)
	for iter_51_0, iter_51_1 in pairs(var_0_12) do
		iter_51_1[2] = iter_51_1[2] + arg_51_1

		if iter_51_1[2] < 0 then
			iter_51_1[2] = 0
		end

		if iter_51_1[2] > NewChessConst.HERO_HP_RATE then
			iter_51_1[2] = NewChessConst.HERO_HP_RATE
		end
	end
end

function var_0_0.CheckIsAllDie(arg_52_0)
	for iter_52_0, iter_52_1 in pairs(var_0_12) do
		if iter_52_1[2] > 0 then
			return false
		end
	end

	return true
end

function var_0_0.GetHeroIDList(arg_53_0)
	local var_53_0 = {}
	local var_53_1 = NewWarChessData:GetHeroInfoList()

	for iter_53_0, iter_53_1 in pairs(var_53_1) do
		table.insert(var_53_0, NewWarChessHeroCfg[iter_53_1[1]].temp_id)
	end

	return var_53_0
end

function var_0_0.GetCurChanceID(arg_54_0)
	local var_54_0 = var_0_17

	var_0_17 = 0

	return var_54_0, var_0_4.curChancePosx, var_0_4.curChancePosz
end

function var_0_0.SetChanceInfo(arg_55_0, arg_55_1, arg_55_2)
	var_0_18 = arg_55_1
	var_0_19 = arg_55_2
end

function var_0_0.GetChanceItemState(arg_56_0, arg_56_1)
	for iter_56_0, iter_56_1 in pairs(var_0_19) do
		if iter_56_1.chanceItemID == arg_56_1 then
			return iter_56_1
		end
	end
end

function var_0_0.GetCurChanceItemList(arg_57_0)
	return var_0_19
end

function var_0_0.GetServerChanceID(arg_58_0)
	local var_58_0 = var_0_18

	var_0_18 = 0

	return var_58_0
end

function var_0_0.AddServerEvent(arg_59_0, arg_59_1)
	table.insert(var_0_20, arg_59_1)
end

function var_0_0.GetServerEvent(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = 0

	for iter_60_0, iter_60_1 in pairs(var_0_20) do
		if arg_60_1 == iter_60_1.timing then
			if (arg_60_1 == NewChessConst.TIMING_WALK_OUT or arg_60_1 == NewChessConst.TIMING_WALK_INTO or arg_60_1 == NewChessConst.TIMING_INTERACT or arg_60_1 == NewChessConst.TIMING_WALK_OUT_OBJECT or arg_60_1 == NewChessConst.TIMING_WALK_INTO_OBJECT or arg_60_1 == NewChessConst.TIMING_INTERACT_OBJECT or arg_60_1 == NewChessConst.TIMING_FARCLICK_OBJECT) and arg_60_2[1] == iter_60_1.timingParams[1] and arg_60_2[2] == iter_60_1.timingParams[2] then
				var_60_0 = iter_60_0

				break
			end

			if (arg_60_1 == NewChessConst.TIMING_CHANCE_CHOOSE or arg_60_1 == NewChessConst.TIMING_BUFF or arg_60_1 == NewChessConst.TIMING_TASK or arg_60_1 == NewChessConst.TIMING_GLOBAL_EVENT) and arg_60_2[1] == iter_60_1.timingParams[1] then
				var_60_0 = iter_60_0

				break
			end

			if arg_60_1 == NewChessConst.TIMING_START then
				var_60_0 = iter_60_0

				break
			end
		end
	end

	if var_60_0 ~= 0 then
		local var_60_1 = var_0_20[var_60_0].eventList

		var_0_20[var_60_0] = nil

		return var_60_1
	end

	print("lrq 触发了服务端没下发的事件！！timing:", arg_60_1)
	trace("timingParams %o", arg_60_2)

	return nil
end

function var_0_0.SetTemporaryData(arg_61_0, arg_61_1, arg_61_2)
	var_0_16[arg_61_1] = arg_61_2
end

function var_0_0.GetTemporaryData(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0 = var_0_16[arg_62_1]

	var_0_16[arg_62_1] = nil

	return var_62_0
end

local var_0_21 = {}

function var_0_0.SetSystemServerData(arg_63_0, arg_63_1)
	var_0_21 = {}

	if arg_63_1.value_list then
		for iter_63_0, iter_63_1 in ipairs(arg_63_1.value_list) do
			var_0_21[iter_63_1.chapter_id] = {
				exploreValue = iter_63_1.explore_value,
				movePoint = iter_63_1.move_value,
				isFinish = iter_63_1.is_finish,
				getRewardLevelList = cleanProtoTable(iter_63_1.value_list)
			}
		end
	end
end

function var_0_0.GetExploreValue(arg_64_0, arg_64_1)
	if var_0_21[arg_64_1] then
		return var_0_21[arg_64_1].exploreValue
	else
		return 0
	end
end

function var_0_0.GetMovePoint(arg_65_0, arg_65_1)
	if var_0_21[arg_65_1] then
		return var_0_21[arg_65_1].movePoint
	else
		return NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT.default
	end
end

function var_0_0.GetRewardIsGet(arg_66_0, arg_66_1, arg_66_2)
	if var_0_21[arg_66_1] then
		if table.indexof(var_0_21[arg_66_1].getRewardLevelList, arg_66_2) then
			return true
		else
			return false
		end
	else
		return false
	end
end

function var_0_0.SetCurMapExploreValue(arg_67_0, arg_67_1, arg_67_2)
	if var_0_21[arg_67_1] then
		var_0_21[arg_67_1].exploreValue = arg_67_2
	else
		var_0_21[arg_67_1] = {
			isFinish = 0,
			exploreValue = arg_67_2,
			movePoint = NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT.default,
			getRewardLevelList = {}
		}
	end
end

function var_0_0.ReceiveReward(arg_68_0, arg_68_1, arg_68_2)
	if var_0_21[arg_68_1] then
		table.insert(var_0_21[arg_68_1].getRewardLevelList, arg_68_2)
	else
		var_0_21[arg_68_1] = {
			exploreValue = 0,
			isFinish = 0,
			movePoint = NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT.default,
			getRewardLevelList = {
				arg_68_2
			}
		}
	end
end

function var_0_0.GetLevelIsFinish(arg_69_0, arg_69_1)
	if var_0_21[arg_69_1] then
		return var_0_21[arg_69_1].isFinish
	else
		return false
	end
end

function var_0_0.SaveDataToSystem(arg_70_0)
	local var_70_0 = var_0_4.mapId

	if var_0_21[var_70_0] == nil then
		var_0_21[var_70_0] = {
			movePoint = 0,
			exploreValue = 0,
			isFinish = 0,
			getRewardLevelList = {}
		}
	end

	var_0_21[var_70_0].movePoint = arg_70_0:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT")

	local var_70_1 = arg_70_0:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_FINISH")

	if var_0_21[var_70_0].isFinish == 0 and var_70_1 == 1 then
		for iter_70_0, iter_70_1 in pairs(NewWarChessLevelCfg.all) do
			if NewWarChessLevelCfg[iter_70_1].front_level_id == var_70_0 then
				local var_70_2 = RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. ActivityConst.ACTIVITY_NEWWARCHESS_2_6

				manager.redPoint:setTip(var_70_2, 1)

				break
			end
		end
	end

	var_0_21[var_70_0].isFinish = var_70_1
end

return var_0_0
