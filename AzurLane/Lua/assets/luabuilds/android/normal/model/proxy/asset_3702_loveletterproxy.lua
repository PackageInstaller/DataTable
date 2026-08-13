class = var_0_10000

local var_0_0 = "LoveLetterProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

var_0_1.UPDATE_LOVE_LETTER = "LoveLetterProxy.UPDATE_LOVE_LETTER"

function var_0_1.register(arg_1_0)
	arg_1_0.letterTextContent = {}

	return
end

function var_0_1.SetGroupList(arg_2_0, arg_2_1)
	arg_2_0.data = {}
	arg_2_0.levelAll = 0
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_1.medal_list) do
		var_1_10007 = arg_2_0.data

		local var_2_0 = iter_2_1.group_id

		LoveLetter = var_1_10009
		var_1_10007[var_2_0] = var_1_10009.New(iter_2_1)
		var_1_10007 = arg_2_0.levelAll
		var_1_10009 = arg_2_0.data[iter_2_1.group_id]
		arg_2_0.levelAll = var_1_10007 + var_8.GetDisplayLevel(var_1_10009)
	end

	ipairs = var_2

	for iter_2_2, iter_2_3 in var_2(arg_2_1.letter_list) do
		local var_2_1 = arg_2_0:GetGroupData(iter_2_3.group_id)

		var_1_10007.SetUnlockLetters(var_2_1, iter_2_3.letter_id_list)
	end

	arg_2_0.giftRecord = {}
	ipairs = var_2

	for iter_2_4, iter_2_5 in var_2(arg_2_1.converted_list) do
		table = var_1_10007

		var_1_10007.insert(arg_2_0.giftRecord, {
			year = iter_2_5.year,
			group_id = iter_2_5.group_id,
			item_id = iter_2_5.item_id
		})
	end

	arg_2_0.rewardMarkDic = {}
	ipairs = var_2

	for iter_2_6, iter_2_7 in var_2(arg_2_1.rewarded_list) do
		arg_2_0.rewardMarkDic[iter_2_7] = true
	end

	return
end

function var_0_1.GetGroupData(arg_3_0, arg_3_1)
	if not arg_3_0.data[arg_3_1] then
		local var_3_0 = arg_3_0.data

		LoveLetter = var_1_10003
		var_3_0[arg_3_1] = var_1_10003.New({
			group_id = arg_3_1
		})
	end

	return arg_3_0.data[arg_3_1]
end

function var_0_1.LevelUp(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:GetGroupData(arg_4_1)

	arg_4_0.levelAll = arg_4_0.levelAll - var_4_0:GetDisplayLevel()

	var_4_0:MaxLevelUp()

	local var_4_1 = arg_4_0.levelAll
	local var_4_2 = var_4_0

	arg_4_0.levelAll = var_4_1 + var_4_0.GetDisplayLevel(var_4_2)

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.sendNotification

	LoveLetterProxy = var_4_2

	var_4_4(var_4_3, var_4_2.UPDATE_LOVE_LETTER)

	return
end

function var_0_1.UnlockLetter(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:GetGroupData(arg_5_1)

	var_3.SetUnlockLetters(var_5_0, {
		arg_5_2
	})

	return
end

function var_0_1.CanGetReward(arg_6_0, arg_6_1)
	ipairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_1) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.lover_reward[iter_6_1]
		assert = var_1_10008

		var_1_10008(var_1_10007)

		if arg_6_0.rewardMarkDic[iter_6_1] then
			return false
		end

		if arg_6_0.levelAll < var_1_10007.total_level then
			return false
		end
	end

	return true
end

function var_0_1.MarkReward(arg_7_0, arg_7_1)
	ipairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_1) do
		arg_7_0.rewardMarkDic[iter_7_1] = true
	end

	return
end

function var_0_1.GetLoveLetterItemDic(arg_8_0)
	if not var_0_1.letterItemDic then
		var_0_1.letterItemDic = {}

		local var_8_0 = var_0_1

		var_8_0.letterIdMap = {}
		ipairs = var_8_0
		pg = var_2

		for iter_8_0, iter_8_1 in var_8_0(var_2.lover_letter_content.all) do
			pg = var_1_10006
			var_1_10006 = var_1_10006.lover_letter_content[iter_8_1]
			pg = var_1_10007

			if not var_1_10007.lover_character_template[var_1_10006.ship_group] then
				-- block empty
			else
				var_1_10007 = var_0_1.letterIdMap
				var_1_10007[var_1_10006.ship_group .. "_" .. var_1_10006.year] = iter_8_1
				ipairs = var_1_10007

				for iter_8_2, iter_8_3 in var_1_10007(var_1_10006.love_item) do
					ipairs = var_1_10012
					table = var_1_10013
					var_1_10013 = var_1_10013.insertto

					local var_8_1 = {
						var_1_10006.ship_group
					}

					pg = var_15

					for iter_8_4, iter_8_5 in var_1_10012(var_1_10013(var_8_1, var_15.lover_character_template[var_1_10006.ship_group].relate_group_id)) do
						ipairs = var_1_10017

						for iter_8_6, iter_8_7 in var_1_10017({
							0,
							iter_8_5
						}) do
							local var_8_2 = iter_8_3 .. "_" .. iter_8_7
							local var_8_3 = var_0_1.letterItemDic
							local var_8_4

							if not var_0_1.letterItemDic[var_8_2] then
								var_8_4 = {}
							end

							var_8_3[var_8_2] = var_8_4
							var_0_1.letterItemDic[var_8_2][var_1_10006.year] = var_1_10006.ship_group
						end
					end
				end
			end
		end
	end

	return var_0_1.letterItemDic, var_0_1.letterIdMap
end

function var_0_1.CanRealizeGift(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.GetLoveLetterItemDic(var_9_0)

	getProxy = var_9_0
	BagProxy = var_1_10003

	local var_9_2 = var_9_0(var_1_10003)
	local var_9_3 = var_2.GetAllLoveLetterItem(var_9_2)
	local var_9_4 = {}

	ipairs = var_1_10004

	for iter_9_0, iter_9_1 in var_1_10004(var_9_3) do
		unpack = var_1_10009

		local var_9_5

		var_1_10009, var_9_5 = var_1_10009(iter_9_1)
		underscore = var_1_10011
		var_1_10011 = var_1_10011.values(var_9_1[var_1_10009 .. "_" .. (var_9_5 or 0)])[1]

		local var_9_6 = var_1_10009 .. "_" .. var_1_10011

		defaultValue = var_13
		var_9_4[var_9_6] = var_13(var_9_4[var_9_6], 0) + 1
	end

	local var_9_7 = false

	ipairs = var_5

	for iter_9_2, iter_9_3 in var_5(arg_9_0.giftRecord) do
		if not var_9_1[iter_9_3.item_id .. "_" .. iter_9_3.group_id] then
			var_9_7 = true

			break
		end

		underscore = var_10

		local var_9_8 = var_10.values(var_9_1[iter_9_3.item_id .. "_" .. iter_9_3.group_id])[1]
		local var_9_9 = iter_9_3.item_id .. "_" .. var_9_8

		defaultValue = var_12
		var_9_4[var_9_9] = var_12(var_9_4[var_9_9], 0) - 1
	end

	if var_9_7 and #var_9_3 > 0 then
		return var_9_3
	end

	pairs = var_5

	for iter_9_4, iter_9_5 in var_5(var_9_4) do
		if iter_9_5 > 0 then
			return var_9_3
		end
	end

	return nil
end

function var_0_1.UpdateRealizeGift(arg_10_0, arg_10_1)
	local var_10_0, var_10_1 = arg_10_0:GetLoveLetterItemDic()
	local var_10_2 = {}

	ipairs = var_1_10005

	for iter_10_0, iter_10_1 in var_1_10005(arg_10_1) do
		underscore = var_1_10010

		local var_10_3

		if not var_10_2[var_1_10010.values(var_10_0[iter_10_1.item_id .. "_" .. iter_10_1.group_id])[1]] then
			var_10_3 = {}
		end

		var_10_2[var_1_10010] = var_10_3
		table = var_10_3

		var_10_3.insert(var_10_2[var_1_10010], iter_10_1)
	end

	local var_10_4 = {}

	ipairs = var_6

	for iter_10_2, iter_10_3 in var_6(arg_10_0.giftRecord) do
		local var_10_5
		local var_10_6
		local var_10_7

		if not var_10_0[iter_10_3.item_id .. "_" .. iter_10_3.group_id] then
			var_10_5 = nil
			pg = var_10_7

			if not var_10_7.lover_character_template[iter_10_3.group_id] or not iter_10_3.group_id then
				::label_10_0::

				underscore = var_10_7
				var_10_7 = var_10_7.detect
				pg = var_14
				var_10_6 = var_10_7(var_14.lover_character_template.all, function(arg_11_0)
					underscore = var_2_10001

					local var_11_0 = var_2_10001.any

					pg = var_2_10002

					return var_11_0(var_2_10002.lover_character_template[arg_11_0].relate_group_id, function(arg_12_0)
						return iter_10_3.group_id == arg_12_0
					end)
				end)
			end
		else
			underscore = var_10_7
			var_10_6 = var_10_7.values(var_10_0[iter_10_3.item_id .. "_" .. iter_10_3.group_id])[1]
			ipairs = var_10_7

			local var_10_8

			if not var_10_2[var_10_6] then
				var_10_8 = {}
			end

			for iter_10_4, iter_10_5 in var_10_7(var_10_8) do
				if iter_10_5.item_id == iter_10_3.item_id and iter_10_5.year == iter_10_3.year then
					var_10_5 = iter_10_4

					break
				end
			end
		end

		if var_10_5 then
			table = var_10_7

			var_10_7.remove(var_10_2[var_10_6], var_10_5)
		else
			local var_10_9

			if not var_10_4[var_10_6] then
				var_10_9 = {}
			end

			var_10_4[var_10_6] = var_10_9
			table = var_10_9

			var_10_9.insert(var_10_4[var_10_6], iter_10_3)
		end
	end

	pairs = var_6

	for iter_10_6, iter_10_7 in var_6(var_10_4) do
		local var_10_10 = arg_10_0:GetGroupData(iter_10_6)

		arg_10_0.levelAll = arg_10_0.levelAll - #iter_10_7

		var_10_10:AddGiftExp(-#iter_10_7)

		ipairs = var_12

		for iter_10_8, iter_10_9 in var_12(iter_10_7) do
			local var_10_11 = var_10_1[iter_10_6 .. "_" .. iter_10_9.year]

			var_10_10.unlockLetterDic[var_10_11] = var_10_10.unlockLetterDic[var_10_11] - 1
		end
	end

	pairs = var_6

	for iter_10_10, iter_10_11 in var_6(var_10_2) do
		local var_10_12 = arg_10_0:GetGroupData(iter_10_10)

		arg_10_0.levelAll = arg_10_0.levelAll + #iter_10_11

		var_10_12:AddGiftExp(#iter_10_11)

		ipairs = var_12

		for iter_10_12, iter_10_13 in var_12(iter_10_11) do
			local var_10_13 = var_10_1[iter_10_10 .. "_" .. iter_10_13.year]
			local var_10_14 = var_10_12.unlockLetterDic

			defaultValue = var_19
			var_10_14[var_10_13] = var_19(var_10_12.unlockLetterDic[var_10_13], 0) + 1
		end
	end

	arg_10_0.giftRecord = arg_10_1
	arg_10_0.giftTip = false

	local var_10_15 = arg_10_0
	local var_10_16 = arg_10_0.sendNotification

	LoveLetterProxy = var_8

	var_10_16(var_10_15, var_8.UPDATE_LOVE_LETTER)

	return
end

function var_0_1.AddLoveLetterExp(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:GetGroupData(arg_13_1)

	return (var_3.AddExp(var_13_0, arg_13_2))
end

function var_0_1.GetDisplayGroupList(arg_14_0)
	local var_14_0 = {}

	pairs = var_1_10002

	for iter_14_0, iter_14_1 in var_1_10002(arg_14_0.data) do
		if iter_14_1.exp ~= 0 then
			table = var_7

			var_7.insert(var_14_0, iter_14_1.groupId)
		end
	end

	table = var_2

	var_2.sort(var_14_0)

	underscore = var_2

	return var_2.map(var_14_0, function(arg_15_0)
		ShipGroup = var_2_10001

		return var_2_10001.New({
			id = arg_15_0
		})
	end)
end

function var_0_1.GetAllLevel(arg_16_0)
	return arg_16_0.levelAll
end

function var_0_1.GetAllLevelNextAwardIndex(arg_17_0)
	ipairs = var_1_10001
	pg = var_1_10002

	for iter_17_0, iter_17_1 in var_1_10001(var_1_10002.lover_reward.all) do
		if not arg_17_0.rewardMarkDic[iter_17_1] then
			return iter_17_0
		end
	end

	return nil
end

function var_0_1.GetAllLevelAwardDisplayIndex(arg_18_0)
	local var_18_0

	ipairs = var_1_10002
	pg = var_1_10003

	for iter_18_0, iter_18_1 in var_1_10002(var_1_10003.lover_reward.all) do
		var_18_0 = iter_18_0
		pg = var_1_10007

		if var_1_10007.lover_reward[iter_18_1].total_level > arg_18_0.levelAll then
			break
		end
	end

	return var_18_0
end

function var_0_1.GetAllLevelProgress(arg_19_0)
	local var_19_0 = arg_19_0

	if not arg_19_0.GetAllLevelNextAwardIndex(var_19_0) then
		do return 0, 0 end

		goto label_19_0
	end

	pg = var_19_0

	local var_19_1 = var_19_0.lover_reward.all

	if 1 < var_1 then
		pg = var_3

		do
			local var_19_2

			if not var_3.lover_reward[var_19_1[var_1 - 1]].total_level then
				var_19_2 = 0
			end

			local var_19_3 = arg_19_0.levelAll - var_19_2

			pg = var_1_10005

			return var_19_3, var_1_10005.lover_reward[var_19_1[var_1]].total_level - var_19_2
		end

		::label_19_0::

		return
	end
end

function var_0_1.GetAllLevelNextAward(arg_20_0)
	pg = var_1_10001

	local var_20_0 = var_1_10001.lover_reward.all
	local var_20_1 = arg_20_0
	local var_20_2

	if not arg_20_0.GetAllLevelNextAwardIndex(var_20_1) then
		var_20_2 = #var_20_0
	end

	local var_20_3 = var_20_0[var_20_2]

	underscore = var_20_1

	local var_20_4 = var_20_1.map

	pg = var_1_10004

	return var_20_4(var_1_10004.lover_reward[var_20_3].show_reward, function(arg_21_0)
		Drop = var_2_10001

		return var_2_10001.Create(arg_21_0)
	end)
end

function var_0_1.GetAllLevelRewardMarkDic(arg_22_0)
	return arg_22_0.rewardMarkDic
end

function var_0_1.GetAllLevelReadyReward(arg_23_0)
	local var_23_0 = {}
	local var_23_1 = arg_23_0
	local var_23_2 = arg_23_0.GetAllLevelRewardMarkDic(var_23_1)

	ipairs = var_23_1
	pg = var_1_10004

	for iter_23_0, iter_23_1 in var_23_1(var_1_10004.lover_reward.all) do
		pg = var_1_10008

		if var_1_10008.lover_reward[iter_23_1].total_level > arg_23_0.levelAll then
			break
		elseif not var_23_2[iter_23_1] then
			table = var_9

			var_9.insert(var_23_0, iter_23_1)
		end
	end

	return var_23_0
end

function var_0_1.RecordLoveLetterContent(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.letterTextContent

	HXSet = var_1_10004
	var_24_0[arg_24_1] = var_1_10004.hxLan(arg_24_2)

	return
end

function var_0_1.GetLoveLetterContent(arg_25_0, arg_25_1)
	return arg_25_0.letterTextContent[arg_25_1]
end

function var_0_1.GetDisPlayerGroupDatas(arg_26_0)
	local var_26_0 = {}

	pairs = var_1_10002

	local var_26_1

	if not arg_26_0.data then
		var_26_1 = {}
	end

	for iter_26_0, iter_26_1 in var_1_10002(var_26_1) do
		if iter_26_1.exp > 0 then
			table = var_7

			var_7.insert(var_26_0, iter_26_1)
		end
	end

	return var_26_0
end

function var_0_1.GetTrophyList(arg_27_0)
	local var_27_0 = {}

	ipairs = var_1_10002

	for iter_27_0, iter_27_1 in var_1_10002(arg_27_0:GetDisPlayerGroupDatas()) do
		table = var_1_10007

		var_1_10007.insertto(var_27_0, iter_27_1:GetTrophyList())
	end

	return var_27_0
end

function var_0_1.GetDisplayLetterList(arg_28_0)
	local var_28_0 = {}

	pairs = var_1_10002

	for iter_28_0, iter_28_1 in var_1_10002(arg_28_0.data) do
		if iter_28_1.exp > 0 and #iter_28_1:GetDisplayLetterList() > 0 then
			table = var_7

			var_7.insert(var_28_0, iter_28_0)
		end
	end

	table = var_2

	local var_28_1 = var_2.sort
	local var_28_2 = var_28_0

	CompareFuncs = var_4

	var_28_1(var_28_2, var_4({
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

	getProxy = var_28_1
	CollectionProxy = var_28_2

	local var_28_3 = var_28_1(var_28_2)
	local var_28_4 = var_2.RawgetGroups(var_28_3)

	underscore = var_28_3

	return var_28_3.map(var_28_0, function(arg_32_0)
		local var_32_0

		if not var_28_4[arg_32_0] then
			ShipGroup = var_32_0
			var_32_0 = var_32_0.New({
				id = arg_32_0
			})
		end

		return var_32_0
	end)
end

function var_0_1.GetRecordGiftLetters(arg_33_0, arg_33_1)
	local var_33_0 = {}
	local var_33_1, var_33_2 = arg_33_0:GetLoveLetterItemDic()

	ipairs = var_1_10005

	for iter_33_0, iter_33_1 in var_1_10005(arg_33_0.giftRecord) do
		if not var_33_1[iter_33_1.item_id .. "_" .. iter_33_1.group_id] then
			-- block empty
		else
			underscore = var_10

			if var_10.values(var_33_1[iter_33_1.item_id .. "_" .. iter_33_1.group_id])[1] == arg_33_1 then
				table = var_11

				var_11.insert(var_33_0, var_33_2[arg_33_1 .. "_" .. iter_33_1.year])
			end
		end
	end

	return var_33_0
end

function var_0_1.IsTipRealizeGift(arg_34_0)
	if not arg_34_0.data then
		return false
	end

	if arg_34_0.giftTip == nil then
		arg_34_0.giftTip = arg_34_0:CanRealizeGift()
	end

	return arg_34_0.giftTip
end

function var_0_1.IsTipLevelUp(arg_35_0)
	pairs = var_1_10001

	for iter_35_0, iter_35_1 in var_1_10001(arg_35_0.data) do
		if iter_35_1:GetDisplayLevel() < iter_35_1:GetMaxLevel() and iter_35_1:CanLevelUp() then
			return true
		end
	end

	return false
end

function var_0_1.IsTipAllLevelReward(arg_36_0)
	local var_36_0, var_36_1 = arg_36_0:GetAllLevelProgress()

	return var_36_1 > 0 and var_36_1 <= var_36_0
end

function var_0_1.IsTipUnlockLetter(arg_37_0)
	pairs = var_1_10001

	for iter_37_0, iter_37_1 in var_1_10001(arg_37_0.data) do
		ipairs = var_1_10006
		pg = var_1_10007

		for iter_37_2, iter_37_3 in var_1_10006(var_1_10007.lover_letter_content.get_id_list_by_ship_group[iter_37_0]) do
			if iter_37_1:CanUnlockLetter(iter_37_3) and not iter_37_1:GetLetterUnlock(iter_37_3) then
				return true
			end
		end
	end

	return false
end

function var_0_1.GetSystemData(arg_38_0, arg_38_1)
	if not arg_38_0.data then
		local var_38_0 = arg_38_0
		local var_38_1 = arg_38_0.sendNotification

		GAME = var_1_10004

		var_38_1(var_38_0, var_1_10004.GET_ALL_LOVE_LETTER_DATA, {
			callback = arg_38_1
		})
	else
		arg_38_1()
	end

	return
end

function var_0_1.remove(arg_39_0)
	arg_39_0.data = nil

	return
end

return var_0_1
