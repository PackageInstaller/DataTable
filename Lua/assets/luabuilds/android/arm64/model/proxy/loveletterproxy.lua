local var_0_0 = class("LoveLetterProxy", import(".NetProxy"))

var_0_0.UPDATE_LOVE_LETTER = "LoveLetterProxy.UPDATE_LOVE_LETTER"

function var_0_0.register(arg_1_0)
	arg_1_0.letterTextContent = {}

	return
end

function var_0_0.SetGroupList(arg_2_0, arg_2_1)
	arg_2_0.data = {}
	arg_2_0.levelAll = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.medal_list) do
		arg_2_0.data[iter_2_1.group_id] = LoveLetter.New(iter_2_1)
		arg_2_0.levelAll = arg_2_0.levelAll + arg_2_0.data[iter_2_1.group_id]:GetDisplayLevel()
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.letter_list) do
		arg_2_0:GetGroupData(iter_2_3.group_id):SetUnlockLetters(iter_2_3.letter_id_list)
	end

	arg_2_0.giftRecord = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.converted_list) do
		table.insert(arg_2_0.giftRecord, {
			year = iter_2_5.year,
			group_id = iter_2_5.group_id,
			item_id = iter_2_5.item_id
		})
	end

	arg_2_0.rewardMarkDic = {}

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.rewarded_list) do
		arg_2_0.rewardMarkDic[iter_2_7] = true
	end

	return
end

function var_0_0.GetGroupData(arg_3_0, arg_3_1)
	arg_3_0.data[arg_3_1] = arg_3_0.data[arg_3_1] or LoveLetter.New({
		group_id = arg_3_1
	})

	return arg_3_0.data[arg_3_1]
end

function var_0_0.LevelUp(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:GetGroupData(arg_4_1)

	arg_4_0.levelAll = arg_4_0.levelAll - var_4_0:GetDisplayLevel()

	var_4_0:MaxLevelUp()

	arg_4_0.levelAll = arg_4_0.levelAll + var_4_0:GetDisplayLevel()

	arg_4_0:sendNotification(LoveLetterProxy.UPDATE_LOVE_LETTER)

	return
end

function var_0_0.UnlockLetter(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:GetGroupData(arg_5_1):SetUnlockLetters({
		arg_5_2
	})

	return
end

function var_0_0.CanGetReward(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		assert(pg.lover_reward[iter_6_1])

		if arg_6_0.rewardMarkDic[iter_6_1] then
			return false
		end

		if arg_6_0.levelAll < pg.lover_reward[iter_6_1].total_level then
			return false
		end
	end

	return true
end

function var_0_0.MarkReward(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		arg_7_0.rewardMarkDic[iter_7_1] = true
	end

	return
end

function var_0_0.GetLoveLetterItemDic(arg_8_0)
	if not var_0_0.letterItemDic then
		var_0_0.letterItemDic = {}
		var_0_0.letterIdMap = {}

		for iter_8_0, iter_8_1 in ipairs(pg.lover_letter_content.all) do
			if not pg.lover_character_template[pg.lover_letter_content[iter_8_1].ship_group] then
				-- block empty
			else
				var_0_0.letterIdMap[pg.lover_letter_content[iter_8_1].ship_group .. "_" .. pg.lover_letter_content[iter_8_1].year] = iter_8_1

				for iter_8_2, iter_8_3 in ipairs(pg.lover_letter_content[iter_8_1].love_item) do
					for iter_8_4, iter_8_5 in ipairs(table.insertto({
						pg.lover_letter_content[iter_8_1].ship_group
					}, pg.lover_character_template[pg.lover_letter_content[iter_8_1].ship_group].relate_group_id)) do
						for iter_8_6, iter_8_7 in ipairs({
							0,
							iter_8_5
						}) do
							var_0_0.letterItemDic[iter_8_3 .. "_" .. iter_8_7] = var_0_0.letterItemDic[iter_8_3 .. "_" .. iter_8_7] or {}
							var_0_0.letterItemDic[iter_8_3 .. "_" .. iter_8_7][pg.lover_letter_content[iter_8_1].year] = pg.lover_letter_content[iter_8_1].ship_group
						end
					end
				end
			end
		end
	end

	return var_0_0.letterItemDic, var_0_0.letterIdMap
end

function var_0_0.CanRealizeGift(arg_9_0)
	local var_9_0 = arg_9_0:GetLoveLetterItemDic()
	local var_9_1 = getProxy(BagProxy):GetAllLoveLetterItem()

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2, var_9_3 = unpack(iter_9_1)
		local var_9_4 = var_9_2 .. "_" .. underscore.values(var_9_0[var_9_2 .. "_" .. (var_9_3 or 0)])[1]

		;({})[var_9_4] = defaultValue(({})[var_9_4], 0) + 1
	end

	local var_9_5 = false

	for iter_9_2, iter_9_3 in ipairs(arg_9_0.giftRecord) do
		if not var_9_0[iter_9_3.item_id .. "_" .. iter_9_3.group_id] then
			var_9_5 = true

			break
		end

		local var_9_6 = iter_9_3.item_id .. "_" .. underscore.values(var_9_0[iter_9_3.item_id .. "_" .. iter_9_3.group_id])[1]

		;({})[var_9_6] = defaultValue(({})[var_9_6], 0) - 1
	end

	if var_9_5 and #var_9_1 > 0 then
		return var_9_1
	end

	for iter_9_4, iter_9_5 in pairs({}) do
		if iter_9_5 > 0 then
			return var_9_1
		end
	end

	return nil
end

function var_0_0.UpdateRealizeGift(arg_10_0, arg_10_1)
	local var_10_0, var_10_1 = arg_10_0:GetLoveLetterItemDic()
	local var_10_2 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_3 = underscore.values(var_10_0[iter_10_1.item_id .. "_" .. iter_10_1.group_id])[1]

		var_10_2[var_10_3] = var_10_2[var_10_3] or {}

		table.insert(var_10_2[var_10_3], iter_10_1)
	end

	local var_10_4 = {}

	for iter_10_2, iter_10_3 in ipairs(arg_10_0.giftRecord) do
		local var_10_5
		local var_10_6

		if not var_10_0[iter_10_3.item_id .. "_" .. iter_10_3.group_id] then
			var_10_5 = nil
			var_10_6 = pg.lover_character_template[iter_10_3.group_id] and iter_10_3.group_id or underscore.detect(pg.lover_character_template.all, function(arg_11_0)
				return underscore.any(pg.lover_character_template[arg_11_0].relate_group_id, function(arg_12_0)
					return iter_10_3.group_id == arg_12_0
				end)
			end)
		else
			var_10_6 = underscore.values(var_10_0[iter_10_3.item_id .. "_" .. iter_10_3.group_id])[1]

			local var_10_7 = var_10_2[var_10_6] or {}

			for iter_10_4, iter_10_5 in ipairs(var_10_7) do
				if iter_10_5.item_id == iter_10_3.item_id and iter_10_5.year == iter_10_3.year then
					var_10_5 = iter_10_4

					break
				end
			end
		end

		if var_10_5 then
			table.remove(var_10_2[var_10_6], var_10_5)
		else
			var_10_4[var_10_6] = var_10_4[var_10_6] or {}

			table.insert(var_10_4[var_10_6], iter_10_3)
		end
	end

	for iter_10_6, iter_10_7 in pairs(var_10_4) do
		local var_10_8 = arg_10_0:GetGroupData(iter_10_6)

		arg_10_0.levelAll = arg_10_0.levelAll - #iter_10_7

		var_10_8:AddGiftExp(-#iter_10_7)

		for iter_10_8, iter_10_9 in ipairs(iter_10_7) do
			var_10_8.unlockLetterDic[var_10_1[iter_10_6 .. "_" .. iter_10_9.year]] = var_10_8.unlockLetterDic[var_10_1[iter_10_6 .. "_" .. iter_10_9.year]] - 1
		end
	end

	for iter_10_10, iter_10_11 in pairs(var_10_2) do
		local var_10_9 = arg_10_0:GetGroupData(iter_10_10)

		arg_10_0.levelAll = arg_10_0.levelAll + #iter_10_11

		var_10_9:AddGiftExp(#iter_10_11)

		for iter_10_12, iter_10_13 in ipairs(iter_10_11) do
			var_10_9.unlockLetterDic[var_10_1[iter_10_10 .. "_" .. iter_10_13.year]] = defaultValue(var_10_9.unlockLetterDic[var_10_1[iter_10_10 .. "_" .. iter_10_13.year]], 0) + 1
		end
	end

	arg_10_0.giftRecord = arg_10_1
	arg_10_0.giftTip = false

	arg_10_0:sendNotification(LoveLetterProxy.UPDATE_LOVE_LETTER)

	return
end

function var_0_0.AddLoveLetterExp(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2 = arg_13_0:GetGroupData(arg_13_1):AddExp(arg_13_2)

	return arg_13_2
end

function var_0_0.GetDisplayGroupList(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.data) do
		if iter_14_1.exp ~= 0 then
			table.insert({}, iter_14_1.groupId)
		end
	end

	table.sort({})

	return underscore.map({}, function(arg_15_0)
		return ShipGroup.New({
			id = arg_15_0
		})
	end)
end

function var_0_0.GetAllLevel(arg_16_0)
	return arg_16_0.levelAll
end

function var_0_0.GetAllLevelNextAwardIndex(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(pg.lover_reward.all) do
		if not arg_17_0.rewardMarkDic[iter_17_1] then
			return iter_17_0
		end
	end

	return nil
end

function var_0_0.GetAllLevelAwardDisplayIndex(arg_18_0)
	local var_18_0

	for iter_18_0, iter_18_1 in ipairs(pg.lover_reward.all) do
		var_18_0 = iter_18_0

		if pg.lover_reward[iter_18_1].total_level > arg_18_0.levelAll then
			break
		end
	end

	return var_18_0
end

function var_0_0.GetAllLevelProgress(arg_19_0)
	local var_19_0 = arg_19_0:GetAllLevelNextAwardIndex()
	local var_19_1 = pg.lover_reward.all

	if not var_19_0 then
		do return 0, 0 end

		goto label_19_0
	end

	::label_19_0::

	if var_19_0 > 1 then
		do
			local var_19_2 = pg.lover_reward[var_19_1[var_19_0 - 1]].total_level or 0

			return arg_19_0.levelAll - var_19_2, pg.lover_reward[var_19_1[var_19_0]].total_level - var_19_2
		end

		return
	end
end

function var_0_0.GetAllLevelNextAward(arg_20_0)
	local var_20_0 = arg_20_0:GetAllLevelNextAwardIndex() or #pg.lover_reward.all

	return underscore.map(pg.lover_reward[pg.lover_reward.all[var_20_0]].show_reward, function(arg_21_0)
		return Drop.Create(arg_21_0)
	end)
end

function var_0_0.GetAllLevelRewardMarkDic(arg_22_0)
	return arg_22_0.rewardMarkDic
end

function var_0_0.GetAllLevelReadyReward(arg_23_0)
	local var_23_0 = arg_23_0:GetAllLevelRewardMarkDic()

	for iter_23_0, iter_23_1 in ipairs(pg.lover_reward.all) do
		if pg.lover_reward[iter_23_1].total_level > arg_23_0.levelAll then
			break
		elseif not var_23_0[iter_23_1] then
			table.insert({}, iter_23_1)
		end
	end

	return {}
end

function var_0_0.RecordLoveLetterContent(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0.letterTextContent[arg_24_1] = HXSet.hxLan(arg_24_2)

	return
end

function var_0_0.GetLoveLetterContent(arg_25_0, arg_25_1)
	return arg_25_0.letterTextContent[arg_25_1]
end

function var_0_0.GetDisPlayerGroupDatas(arg_26_0)
	local var_26_0 = arg_26_0.data or {}

	for iter_26_0, iter_26_1 in pairs(var_26_0) do
		if iter_26_1.exp > 0 then
			table.insert({}, iter_26_1)
		end
	end

	return {}
end

function var_0_0.GetTrophyList(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0:GetDisPlayerGroupDatas()) do
		table.insertto({}, iter_27_1:GetTrophyList())
	end

	return {}
end

function var_0_0.GetDisplayLetterList(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.data) do
		if iter_28_1.exp > 0 and #iter_28_1:GetDisplayLetterList() > 0 then
			table.insert({}, iter_28_0)
		end
	end

	table.sort({}, CompareFuncs({
		function(arg_29_0)
			return -arg_28_0.data[arg_29_0].level
		end,
		function(arg_30_0)
			return -arg_28_0.data[arg_30_0].exp
		end,
		function(arg_31_0)
			return arg_31_0
		end
	}))

	local var_28_0 = getProxy(CollectionProxy):RawgetGroups()

	return underscore.map({}, function(arg_32_0)
		return var_28_0[arg_32_0] or ShipGroup.New({
			id = arg_32_0
		})
	end)
end

function var_0_0.GetRecordGiftLetters(arg_33_0, arg_33_1)
	local var_33_0, var_33_1 = arg_33_0:GetLoveLetterItemDic()

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.giftRecord) do
		if not var_33_0[iter_33_1.item_id .. "_" .. iter_33_1.group_id] then
			-- block empty
		elseif underscore.values(var_33_0[iter_33_1.item_id .. "_" .. iter_33_1.group_id])[1] == arg_33_1 then
			table.insert({}, var_33_1[arg_33_1 .. "_" .. iter_33_1.year])
		end
	end

	return {}
end

function var_0_0.IsTipRealizeGift(arg_34_0)
	if not arg_34_0.data then
		return false
	end

	if arg_34_0.giftTip == nil then
		arg_34_0.giftTip = arg_34_0:CanRealizeGift()
	end

	return arg_34_0.giftTip
end

function var_0_0.IsTipLevelUp(arg_35_0)
	for iter_35_0, iter_35_1 in pairs(arg_35_0.data) do
		if iter_35_1:GetDisplayLevel() < iter_35_1:GetMaxLevel() and iter_35_1:CanLevelUp() then
			return true
		end
	end

	return false
end

function var_0_0.IsTipAllLevelReward(arg_36_0)
	local var_36_0, var_36_1 = arg_36_0:GetAllLevelProgress()

	return var_36_1 > 0 and var_36_1 <= var_36_0
end

function var_0_0.IsTipUnlockLetter(arg_37_0)
	for iter_37_0, iter_37_1 in pairs(arg_37_0.data) do
		for iter_37_2, iter_37_3 in ipairs(pg.lover_letter_content.get_id_list_by_ship_group[iter_37_0]) do
			if iter_37_1:CanUnlockLetter(iter_37_3) and not iter_37_1:GetLetterUnlock(iter_37_3) then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetSystemData(arg_38_0, arg_38_1)
	if not arg_38_0.data then
		arg_38_0:sendNotification(GAME.GET_ALL_LOVE_LETTER_DATA, {
			callback = arg_38_1
		})
	else
		arg_38_1()
	end

	return
end

function var_0_0.remove(arg_39_0)
	arg_39_0.data = nil

	return
end

return var_0_0
