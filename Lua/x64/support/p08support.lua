function formatRewardCfgList(arg_1_0)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
		table.insert(var_1_0, formatReward(iter_1_1))
	end

	return var_1_0
end

function unformatRewardCfgList(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		table.insert(var_2_0, {
			iter_2_1.id,
			iter_2_1.num,
			[4] = iter_2_1.time_valid
		})
	end

	return var_2_0
end

function formatReward(arg_3_0)
	if arg_3_0[1] then
		return {
			id = arg_3_0[1],
			num = arg_3_0[2],
			time_valid = arg_3_0[4]
		}
	elseif arg_3_0.id then
		return arg_3_0
	end

	error("传入的reward结构既非{id:number, num:number, timeValid:number}也非number[4]")
end

local function var_0_0(arg_4_0)
	ShowPopItem(POP_ITEM, arg_4_0)
end

function rewardToItemTemplate(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1 or clone(ItemTemplateData)

	var_5_0.id = arg_5_0.id
	var_5_0.number = arg_5_0.num
	var_5_0.timeValid = arg_5_0.time_valid

	if arg_5_2 then
		var_5_0.clickFun = var_0_0
	end

	return var_5_0
end

local var_0_1 = {}

local function var_0_2(arg_6_0)
	local var_6_0 = var_0_1[arg_6_0]

	if var_6_0 == nil then
		function var_6_0(arg_7_0)
			ShowPopItem(arg_6_0, arg_7_0)
		end

		var_0_1[arg_6_0] = var_6_0
	end

	return var_6_0
end

function rewardToPopableItemTemplate(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = rewardToItemTemplate(arg_8_0, arg_8_1)

	var_8_0.clickFun = var_0_2(arg_8_2 or POP_ITEM)

	return var_8_0
end

function getReward(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	if type(arg_9_2) ~= "function" then
		arg_9_2 = nil
	end

	if arg_9_0 and #arg_9_0 > 0 then
		showRewardUI(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_5)
	end
end

getReward2 = getReward

function sortMergeGetReward(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_0 = mergeReward(arg_10_0)

	sortReward(arg_10_0, true)
	getReward(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
end

function showRewardUI(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = arg_11_2
	local var_11_3 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0) do
		local var_11_4 = ItemWillConvert(iter_11_1) and iter_11_1.convert_from.id or iter_11_1.id
		local var_11_5 = ItemCfg[var_11_4]

		if arg_11_1 ~= nil and type(arg_11_1) == "table" and table.indexof(arg_11_1, var_11_5.type) then
			return
		end

		if ItemConst.ITEM_TYPE.WEAPON_SERVANT == var_11_5.type then
			if var_11_5.display_rare > 3 or IllustratedData:GetNewObtainedServant(var_11_4) then
				table.insert(var_11_1, iter_11_1)
			end
		elseif ItemConst.ITEM_TYPE.HERO == var_11_5.type then
			table.insert(var_11_1, iter_11_1)
		elseif ItemConst.ITEM_TYPE.HERO_SKIN == var_11_5.type then
			if var_11_5.id ~= var_11_5.param[1] then
				function var_11_2()
					if arg_11_2 then
						arg_11_2()
					end

					PlayerAction.RefreshSkinGiftRedPoint()
				end
			end

			table.insert(var_11_1, iter_11_1)

			if arg_11_4 and arg_11_4.isBuy == true then
				var_11_3.isBuy = true
			end
		elseif ItemConst.ITEM_TYPE.SCENE == var_11_5.type then
			table.insert(var_11_1, iter_11_1)
		elseif ItemConst.ITEM_SUB_TYPE.OATH_RING == var_11_5.sub_type then
			table.insert(var_11_1, iter_11_1)
		end
	end

	local var_11_6
	local var_11_7 = 0

	for iter_11_2, iter_11_3 in ipairs(arg_11_0) do
		if ItemCfg[iter_11_3.id].sub_type == ItemConst.ITEM_SUB_TYPE.LIMIT_TIME_SKIN_ITEM then
			var_11_6 = iter_11_3
			var_11_7 = var_11_7 + 1
		end
	end

	if var_11_7 == 1 then
		local var_11_8 = deepClone(var_11_2)

		function var_11_2()
			if var_11_8 then
				var_11_8()
			end

			JumpTools.OpenPageByJump("limitTimeSkinUsePop", {
				itemData = var_11_6
			})
		end
	end

	IllustratedData:ConsumeNewObtainedServant()

	if #var_11_1 > 0 then
		local function var_11_9()
			JumpTools.OpenPageByJump("switchHeroReward", {
				list = arg_11_0,
				needShowVitalityBox = needShowVitalityFullBox(),
				needShowEquipBox = needShowBagFullBox(),
				callBack = var_11_2,
				lateCallback = arg_11_3
			})
		end

		local var_11_10 = formatRewardCfgList(var_11_1)
		local var_11_11 = sortReward4Obtain(var_11_10)
		local var_11_12 = {
			doNextHandler = var_11_9,
			itemList = var_11_11,
			obtainsParams = var_11_3
		}

		gameContext:Go("obtainView", var_11_12)
	else
		JumpTools.OpenPageByJump("switchHeroReward", {
			list = arg_11_0,
			needShowVitalityBox = needShowVitalityFullBox(),
			needShowEquipBox = needShowBagFullBox(),
			callBack = var_11_2,
			lateCallback = arg_11_3
		})
	end
end

function rewardSortFunc(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.id
	local var_15_1 = arg_15_1.id
	local var_15_2 = ItemCfg[var_15_0]
	local var_15_3 = ItemCfg[var_15_1]
	local var_15_4 = var_15_2.rare
	local var_15_5 = var_15_3.rare

	if var_15_4 ~= var_15_5 then
		return var_15_5 < var_15_4
	end

	local var_15_6 = var_15_2.display_rare
	local var_15_7 = var_15_3.display_rare

	if var_15_6 ~= var_15_7 then
		return var_15_7 < var_15_6
	end

	local var_15_8 = var_15_2.type
	local var_15_9 = var_15_3.type

	if var_15_8 ~= var_15_9 then
		return var_15_9 < var_15_8
	elseif var_15_8 == ItemConst.ITEM_TYPE.EQUIP then
		local var_15_10 = 0
		local var_15_11 = 0
		local var_15_12 = EquipCfg[var_15_0].starlevel
		local var_15_13 = EquipCfg[var_15_1].starlevel

		if var_15_12 == var_15_13 then
			return var_15_1 < var_15_0
		else
			return var_15_13 < var_15_12
		end
	else
		return var_15_1 < var_15_0
	end
end

function sortReward(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1 and arg_16_0 or clone(arg_16_0)

	table.sort(var_16_0, rewardSortFunc)

	return var_16_0
end

local var_0_3 = require("game.const.ItemConst")
local var_0_4 = {
	[var_0_3.ITEM_TYPE.HERO] = 3,
	[var_0_3.ITEM_TYPE.SCENE] = 2,
	[var_0_3.ITEM_TYPE.HERO_SKIN] = 1
}

function sortReward4Obtain(arg_17_0)
	local var_17_0 = {}
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0) do
		local var_17_2 = ItemWillConvert(iter_17_1) and iter_17_1.convert_from.id or iter_17_1.id
		local var_17_3 = ItemCfg[var_17_2]
		local var_17_4 = var_17_3.type
		local var_17_5

		if var_17_4 == var_0_3.ITEM_TYPE.SCENE then
			local var_17_6 = var_17_2

			if var_17_3.sub_type == var_0_3.ITEM_SUB_TYPE.SCENE_LIMITED then
				var_17_6 = var_17_3.param[1]
			end

			local var_17_7 = CustomCenterTools.GetMatchSkinByScene(var_17_6)

			var_17_5 = SkinCfg[var_17_7].hero
		elseif var_17_4 == var_0_3.ITEM_TYPE.HERO_SKIN then
			local var_17_8

			if var_17_3.sub_type == var_0_3.ITEM_SUB_TYPE.LIMIT_SKIN then
				var_17_8 = var_17_3.param[1]
			else
				var_17_8 = var_17_2
			end

			var_17_5 = SkinCfg[var_17_8].hero
		elseif var_17_4 == var_0_3.ITEM_TYPE.HERO then
			var_17_5 = var_17_2
		end

		if var_17_5 then
			local var_17_9 = var_17_0[var_17_5] or {}

			table.insert(var_17_9, iter_17_1)

			var_17_0[var_17_5] = var_17_9
		else
			table.insert(var_17_1, iter_17_1)
		end
	end

	local var_17_10 = {}

	for iter_17_2, iter_17_3 in pairs(var_17_0) do
		table.insert(var_17_10, iter_17_2)
		CommonTools.UniversalSortEx(iter_17_3, {
			map = function(arg_18_0)
				local var_18_0 = ItemWillConvert(arg_18_0) and arg_18_0.convert_from.id or arg_18_0.id
				local var_18_1 = ItemCfg[var_18_0].type

				return nullable(var_0_4, var_18_1) or 0
			end
		})
	end

	table.sort(var_17_10)

	local var_17_11 = {}

	for iter_17_4, iter_17_5 in ipairs(var_17_10) do
		local var_17_12 = var_17_0[iter_17_5]

		for iter_17_6, iter_17_7 in ipairs(var_17_12) do
			table.insert(var_17_11, iter_17_7)
		end
	end

	for iter_17_8, iter_17_9 in ipairs(var_17_1) do
		table.insert(var_17_11, iter_17_9)
	end

	return var_17_11
end

function getItemStar(arg_19_0)
	local var_19_0 = ItemCfg[arg_19_0]
	local var_19_1 = 0

	if var_19_0.type == var_0_3.ITEM_TYPE.EQUIP then
		var_19_1 = EquipCfg[arg_19_0].starlevel
	end

	if var_19_1 > 6 then
		var_19_1 = 6
	end

	return var_19_1
end

function ItemWillConvert(arg_20_0)
	return (nullable(arg_20_0, "convert_from", "id") or 0) ~= 0
end

local function var_0_5(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.id
	local var_21_1 = arg_21_1.num
	local var_21_2 = arg_21_1.time_valid
	local var_21_3 = ItemCfg[var_21_0]

	if var_21_3.type == var_0_3.ITEM_TYPE.EQUIP or var_21_3.type == var_0_3.ITEM_TYPE.WEAPON_SERVANT then
		return false
	elseif var_21_0 ~= arg_21_0.id then
		return false
	elseif var_21_2 ~= arg_21_0.time_valid then
		return false
	elseif ItemWillConvert(arg_21_0) or ItemWillConvert(arg_21_1) then
		return false
	end

	return true
end

function mergeRewardItem(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0) do
		if var_0_5(iter_22_1, arg_22_1) then
			iter_22_1.num = arg_22_1.num + iter_22_1.num

			return arg_22_0
		end
	end

	table.insert(arg_22_0, arg_22_1)

	return arg_22_0
end

function mergeRewardList(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		mergeRewardItem(arg_23_0, iter_23_1)
	end

	return arg_23_0
end

function mergeReward(arg_24_0)
	return mergeRewardList({}, arg_24_0)
end

mergeReward2 = mergeReward

function IsConditionAchieved(arg_25_0, arg_25_1)
	local var_25_0 = ConditionCfg[arg_25_0]

	if var_25_0 == nil then
		return true, 0, 0
	end

	local var_25_1 = false
	local var_25_2 = 0
	local var_25_3 = var_25_0.params[1]

	if var_25_0.type == 100 then
		if QWorldQuestTool.IsMainQuestFinish(var_25_0.params[1]) then
			return true, 1, 1
		else
			return false, 0, 1
		end
	elseif var_25_0.type == 101 then
		var_25_3 = SandplayTaskCfg[var_25_0.params[1]].need

		local var_25_4 = QWorldQuestData:GetQuestData(var_25_0.params[1])

		if var_25_4 then
			var_25_1 = var_25_4.status == QWorldQuestConst.QUEST_STATUS.FINISH
			var_25_2 = var_25_4.progress
		else
			var_25_1 = false
			var_25_2 = 0
		end
	elseif var_25_0.type == 102 then
		if QWorldQuestTool.IsChapterFinish(var_25_0.params[1]) then
			return true, 1, 1
		else
			return false, 0, 1
		end
	elseif var_25_0.type == 1001 then
		var_25_2 = HeroData:GetHeroData(arg_25_1.heroId).level
		var_25_3 = var_25_0.params[1]
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 1002 then
		var_25_2 = HeroTools.CountHeroTotalSkilllv(arg_25_1.heroId)
		var_25_3 = var_25_0.params[1]
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 1003 then
		var_25_2 = HeroData:GetHeroData(arg_25_1.heroId).star / 100
		var_25_3 = var_25_0.params[1]
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 1004 then
		var_25_2 = HeroTools.GetHeroProficiency(arg_25_1.heroId)
		var_25_3 = var_25_0.params[1]
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 1005 then
		var_25_2 = #HeroData:GetHeroData(arg_25_1.heroId).unlocked_astrolabe
		var_25_3 = var_25_0.params[1]
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 1006 then
		local var_25_5 = HeroData:GetHeroData(arg_25_1.heroId)

		var_25_3 = 1

		for iter_25_0, iter_25_1 in pairs(var_25_0.params) do
			if table.keyof(var_25_5.clear_mission_list, iter_25_1) then
				var_25_2 = 1
				var_25_1 = true

				break
			end
		end
	elseif var_25_0.type == 1007 then
		var_25_2 = HeroData:GetHeroData(arg_25_1.heroId).weapon_info.level or 0
		var_25_3 = var_25_0.params[1]
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 1008 then
		var_25_3 = 1

		local var_25_6 = HeroCfg[arg_25_1.heroId].study_stage[1]

		if BattleTeachData:GetHeroTeachInfo(arg_25_1.heroId, var_25_6) > 0 then
			var_25_2 = 1
			var_25_1 = true
		end
	elseif var_25_0.type == 1009 then
		local var_25_7 = HeroTools.GetExSkillId(arg_25_1.heroId)
		local var_25_8 = HeroTools.GetSkillLv(arg_25_1.heroId, var_25_7)
		local var_25_9 = HeroData:GetHeroData(arg_25_1.heroId)

		var_25_2 = var_25_8 + HeroTools.GetHeroSkillAddLevel(var_25_9, var_25_7)
		var_25_3 = var_25_0.params[1]
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 1010 then
		var_25_2 = HeroData:GetHeroData(arg_25_1.heroId).break_level
		var_25_3 = var_25_0.params[1]
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 1011 or var_25_0.type == 5002 then
		local var_25_10 = BattleStageData:GetStageData()[var_25_0.params[1]]

		var_25_2 = var_25_10 and var_25_10.clear_times > 0 and 1 or 0
		var_25_3 = 1
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 1012 then
		local var_25_11 = HeroTools.GetHeroOntologyID(arg_25_1.heroId)
		local var_25_12 = ArchiveData:GetArchive(var_25_11).lv

		var_25_1 = var_25_3 <= var_25_12
		var_25_2 = var_25_12
	elseif var_25_0.type == 1013 then
		local var_25_13 = HeroTools.GetHeroOntologyID(arg_25_1.heroId)
		local var_25_14 = HeroRecordCfg[var_25_13].gift_like_id1[1]

		var_25_2 = ArchiveData:GetArchive(var_25_13).gift_list[var_25_14] or 0
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 1014 then
		var_25_2 = PlayerData:GetPlayerInfo().userLevel
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 1015 then
		local var_25_15 = HeroData:GetHeroData(var_25_0.params[1])

		var_25_2 = var_25_15 and var_25_15.level or 0
		var_25_3 = var_25_0.params[2]
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 1016 then
		local var_25_16 = HeroTools.GetHeroOntologyID(arg_25_1.heroId)
		local var_25_17 = ArchiveData:GetArchive(var_25_16).lv

		var_25_1 = var_25_3 <= var_25_17
		var_25_2 = var_25_17
	elseif var_25_0.type == 1017 then
		var_25_3 = 1

		local var_25_18 = var_25_0.params[1]
		local var_25_19 = var_25_0.params[2]

		if HeroTools.IsSkinUnlock(var_25_18) and HomeSceneSettingData:IsHaveScene(var_25_19) then
			var_25_2 = 1
			var_25_1 = true
		end
	elseif var_25_0.type == 1018 then
		var_25_3 = 1

		local var_25_20 = var_25_0.params[1]

		if HeroTools.IsSkinUnlock(var_25_20) then
			var_25_2 = 1
			var_25_1 = true
		end
	elseif var_25_0.type == 1019 then
		local var_25_21 = ArchiveData:GetTrustLevel(arg_25_1.heroId)

		var_25_1 = var_25_3 <= var_25_21
		var_25_2 = var_25_21
	elseif var_25_0.type == 1023 then
		local var_25_22 = var_25_0.params[1]
		local var_25_23 = var_25_0.params[2]
		local var_25_24 = var_25_0.params[3]

		var_25_1 = OathTools.IsOath(var_25_22) and HeroTools.GetHasOwnedSkin(var_25_23) and ShopTools.CheckDlcPurchased(var_25_24)
		var_25_3 = 1
		var_25_2 = var_25_1 and 1 or 0
	elseif var_25_0.type == 1024 then
		var_25_2 = HeroData:GetHeroData(arg_25_1.heroId).star
		var_25_3 = var_25_0.params[1]
	elseif var_25_0.type == 1025 then
		var_25_2 = HeroTools.CountHeroTotalSkillAttrLv(var_25_0.params[1])
		var_25_3 = var_25_0.params[2]
		var_25_1 = var_25_3 <= var_25_2
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 1026 then
		var_25_2 = HeroData:GetHeroData(var_25_0.params[1]).star
		var_25_3 = var_25_0.params[2]
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 1027 then
		local var_25_25 = HeroTools.GetHeroOntologyID(var_25_0.params[1])

		var_25_2 = ArchiveData:GetArchive(var_25_25).lv
		var_25_3 = var_25_0.params[2]
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 1028 then
		local var_25_26 = HeroTools.GetHeroOntologyID(var_25_0.params[1])

		var_25_2 = ArchiveData:GetTrustLevel(var_25_0.params[1])
		var_25_3 = var_25_0.params[2]
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 1101 then
		local var_25_27 = var_25_0.params[1]
		local var_25_28 = var_25_0.params[2]

		var_25_2 = nullable(ShopData.GetGoodInfo(var_25_27, var_25_28), "buy_times") or 0

		return var_25_2 >= var_25_0.params[3], var_25_2, var_25_0.params[3]
	elseif var_25_0.type == 1102 then
		local var_25_29 = var_25_0.params[1]
		local var_25_30 = var_25_0.params[2]

		return TowerData:CheckIsOverStage(var_25_29, var_25_30)
	elseif var_25_0.type == 2001 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= 1, var_25_2, 1
	elseif var_25_0.type == 2002 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 2003 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 2004 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 2005 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 1

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 2101 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= 1, var_25_2, 1
	elseif var_25_0.type == 2201 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 2202 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= 1, var_25_2, 1
	elseif var_25_0.type == 2301 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= 1, var_25_2, 1
	elseif var_25_0.type == 2401 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= 1, var_25_2, 1
	elseif var_25_0.type == 3001 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[2], var_25_2, var_25_0.params[2]
	elseif var_25_0.type == 3002 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 3003 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 3004 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= 1, var_25_2, 1
	elseif var_25_0.type == 3005 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 3006 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 3007 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 3008 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 3009 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 5001 then
		local var_25_31 = var_25_0.params[1]
		local var_25_32 = HeroTools.GetHeroOntologyID(var_25_31)
		local var_25_33 = HeroRecordCfg[var_25_32].plot_id

		for iter_25_2, iter_25_3 in ipairs(var_25_33) do
			if not ArchiveData:IsStoryRead(var_25_32, iter_25_3) then
				return false
			end
		end

		return true
	elseif var_25_0.type == 5003 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[3], var_25_2, var_25_0.params[3]
	elseif var_25_0.type == 8013 then
		var_25_2 = CanteenData:GetFurnitureLevel(var_25_0.params[1]) or 0

		return var_25_2 >= var_25_0.params[2], var_25_2, var_25_0.params[2]
	elseif var_25_0.type == 8014 then
		var_25_2 = CanteenData:GetCurEarning() or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 8021 then
		local var_25_34 = arg_25_1.heroId
		local var_25_35 = HeroTools.GetHeroOntologyID(var_25_34)
		local var_25_36 = DormRoomTools:GetDormIDViaArchive(var_25_35)

		var_25_2 = DormRoomTools:GetGiftNumByRoomID(var_25_36) or 0
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 8022 then
		local var_25_37 = arg_25_1.heroId
		local var_25_38 = HeroTools.GetHeroOntologyID(var_25_37)

		var_25_2 = DormHeroTools:GetDormLevelByHeroID(var_25_38)
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 8023 then
		local var_25_39 = arg_25_1.heroId
		local var_25_40 = DormData:GetHeroTemplateInfo(var_25_39)

		if var_25_40 then
			var_25_2 = var_25_40:GetHeroTotalFeedTime() or 0
		else
			var_25_2 = 0
		end

		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 8101 then
		var_25_2 = DormRoomTools:GetUnlockRoomNum() or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 9001 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 9002 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 9003 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 9004 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= 1, var_25_2, 1
	elseif var_25_0.type == 9005 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= 1, var_25_2, 1
	elseif var_25_0.type == 9011 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 9012 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[2], var_25_2, var_25_0.params[2]
	elseif var_25_0.type == 9013 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 9014 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= 1, var_25_2, 1
	elseif var_25_0.type == 9015 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= 1, var_25_2, 1
	elseif var_25_0.type == 9016 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[1], var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 9017 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[2], var_25_2, var_25_0.params[2]
	elseif var_25_0.type == 11200 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 > 0, var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 11201 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 > 0, var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 11202 then
		var_25_2 = ActivityData:GetActivityIsOpen(var_25_0.params[1]) and 1 or 0

		return var_25_2 > 0, var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 11203 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[2], var_25_2, var_25_0.params[2]
	elseif var_25_0.type == 11204 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 > 0, var_25_2, var_25_0.params[1]
	elseif var_25_0.type == 11205 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 > 0, var_25_2, var_25_0.params[2]
	elseif var_25_0.type == 11206 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= var_25_0.params[2], var_25_2, var_25_0.params[2]
	elseif var_25_0.type == 11501 then
		var_25_2 = HistoryData:GetHistoryData(var_25_0.id) or 0

		return var_25_2 >= 1, var_25_2, 1
	elseif var_25_0.type == 11503 then
		var_25_2 = ActivityRhythmGameData:GetStageDataList()
		var_25_3 = var_25_0.params[1]

		local var_25_41 = false

		for iter_25_4, iter_25_5 in pairs(var_25_2) do
			if iter_25_4 == var_25_3 then
				var_25_41 = true

				break
			end
		end

		var_25_1 = var_25_41
	elseif var_25_0.type == 11502 then
		local var_25_42 = MonsterCosplayData:GetDataByPara("monsterData")
		local var_25_43 = false

		for iter_25_6, iter_25_7 in pairs(var_25_42) do
			if iter_25_7.finishedStage[var_25_0.params[1]] then
				var_25_43 = true
			end
		end

		return var_25_43, var_25_2, 1
	elseif var_25_0.type == 11802 then
		local var_25_44 = QWorldQuestData:GetMainQuestData(var_25_0.params[1])

		if var_25_44 and var_25_44.status == QWorldQuestConst.MAIN_QUEST_STATUS.FINISH then
			return true, 1, 1
		else
			return false, 0, 1
		end
	elseif var_25_0.type == 11901 then
		local var_25_45 = var_25_0.params

		if TetrisGameTools:CheckIsFinishChapter(var_25_45[2][1]) then
			return true
		else
			return false
		end
	elseif var_25_0.type == 11902 then
		local var_25_46 = var_25_0.params
		local var_25_47 = var_25_46[2][1][1]
		local var_25_48 = var_25_46[2][1][2]
		local var_25_49 = TetrisGameData:GetStageInfoByStageID(var_25_47)

		if var_25_49 and var_25_49.isClear == true and var_25_48 <= var_25_49.topScore then
			return true
		else
			return false
		end
	elseif var_25_0.type == 11903 then
		local var_25_50 = var_25_0.params
		local var_25_51 = var_25_50[2]
		local var_25_52 = var_25_50[3]
		local var_25_53 = TetrisGameData:GetStageInfoByStageID(var_25_51)
		local var_25_54 = TetrisGameTools:IsUseSkillClear(var_25_51, var_25_52)

		if var_25_53 and var_25_53.isClear == true and var_25_54 then
			return true
		else
			return false
		end
	elseif var_25_0.type == 12001 then
		local var_25_55 = var_25_0.params

		var_25_2 = ChallengeRogueTeamData:GetHistoryDifficultyClearCnt(var_25_55[1], var_25_55[2])

		return var_25_2 >= var_25_55[3], var_25_2, var_25_55[3]
	elseif var_25_0.type == 12002 then
		return ChallengeRogueTeamData:GetHistoryEndingPassCnt(arg_25_1[1], arg_25_1[2]) >= arg_25_1[2]
	elseif var_25_0.type == 12003 then
		local var_25_56 = ChallengeRogueTeamData:GetHeroTeamProxy():GetHeroIDList()
		local var_25_57 = var_25_0.params[1]
		local var_25_58 = var_25_0.params[2]
		local var_25_59 = 0
		local var_25_60 = {}

		for iter_25_8, iter_25_9 in ipairs(var_25_56) do
			if iter_25_9 ~= 0 then
				local var_25_61 = HeroCfg[iter_25_9].ATK_attribute[1]

				if var_25_61 == var_25_57 or var_25_61 == HeroConst.HERO_ATTACK_TYPE.RANDOM then
					var_25_59 = var_25_59 + 1
				end
			end
		end

		return var_25_58 <= var_25_59
	elseif var_25_0.type == 12101 then
		return WeekBossData:GetBossConsumeHp() / WeekBossData:GetBossTotalHp() * 100 >= var_25_0.params[1]
	elseif var_25_0.type == 12102 then
		return GodEaterData.hubLv >= var_25_0.params[1]
	elseif var_25_0.type == 12103 then
		return WeekBossData:GetIsPassDiff(var_25_0.params[1])
	elseif var_25_0.type == 12201 then
		local var_25_62 = var_25_0.params[1]
		local var_25_63 = var_25_0.params[2] or nil

		if HeroTools.GetHasOwnedSkin(var_25_62) then
			var_25_2 = 1
			var_25_1 = true
		end

		if var_25_1 == false and var_25_63 then
			local var_25_64 = ItemTools.getItemNum(var_25_63)

			if var_25_64 and var_25_64 > 0 then
				var_25_2 = 1
				var_25_1 = true
			end
		end
	elseif var_25_0.type == 12501 then
		if ActivityAreaBattleData:GetStageUnlock(var_25_0.params[1], var_25_0.params[2]) then
			return true, 1, 1
		else
			return false, 0, 1
		end
	elseif var_25_0.type == 12601 then
		local var_25_65 = var_25_0.params[1]
		local var_25_66 = var_25_0.params[2]
		local var_25_67 = var_25_0.params[3]
		local var_25_68 = ChapterV2MapTools.GetMapTimestamp(var_25_65)

		var_25_2 = (var_25_66 <= var_25_68 or var_25_68 <= var_25_67) and 1 or 0
		var_25_3 = 1
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 12602 then
		local var_25_69 = var_25_0.params

		var_25_2 = 0

		for iter_25_10, iter_25_11 in ipairs(var_25_69) do
			if ChapterV2MapTools.IsEventCompleted(iter_25_11) then
				var_25_2 = var_25_2 + 1
			end
		end

		var_25_3 = #var_25_69
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 12604 then
		local var_25_70 = var_25_0.params

		var_25_2 = 0

		for iter_25_12, iter_25_13 in ipairs(var_25_70) do
			if ChapterV2MapTools.IsEventCompleted(iter_25_13) then
				var_25_2 = 1

				break
			end
		end

		var_25_3 = 1
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 12605 then
		local var_25_71 = var_25_0.params[1]
		local var_25_72 = var_25_0.params[2]
		local var_25_73 = var_25_0.params[3]
		local var_25_74 = ChapterV2MapTools.GetMapTimestamp(var_25_71)

		var_25_2 = (var_25_72 <= var_25_74 or var_25_74 <= var_25_73) and 1 or 0
		var_25_3 = 1
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 12606 then
		local var_25_75 = var_25_0.params

		var_25_2 = 0

		for iter_25_14, iter_25_15 in ipairs(var_25_75) do
			if ChapterV2MapData:IsEventCompleted(iter_25_15) then
				var_25_2 = var_25_2 + 1
			end
		end

		var_25_3 = #var_25_75
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 330000 then
		local var_25_76 = var_25_0.params[1]

		var_25_3 = 1
		var_25_1 = OathTools.IsOath(var_25_76)
		var_25_2 = var_25_1 and 1 or 0
	elseif var_25_0.type == 330001 then
		local var_25_77 = var_25_0.params[1]

		var_25_3, var_25_2 = var_25_0.params[2] or 1, ItemTools.getItemNum(var_25_77)
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 330002 then
		local var_25_78 = var_25_0.params[1]

		var_25_3, var_25_2 = var_25_0.params[2] or 0, OathCollectionContentData:GetOathLevel(var_25_78)
		var_25_1 = var_25_3 <= var_25_2
	elseif var_25_0.type == 330003 then
		local var_25_79 = HeroTools.GetHeroIsUnlock(var_25_0.params[1])

		var_25_2 = var_25_79 and 1 or 0
		var_25_3 = 1
		var_25_1 = var_25_79
	end

	return var_25_1, var_25_2, var_25_3
end

function GetConditionProgressText(arg_26_0, arg_26_1, arg_26_2)
	if ConditionCfg[arg_26_0].progress_show == 1 then
		return string.format("%s/%s", arg_26_1, arg_26_2)
	else
		return ""
	end
end

function isMeetAllCondition(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0) do
		if not isMeetCondition(iter_27_1) then
			return false
		end
	end

	return true
end

function isMeetCondition(arg_28_0)
	if arg_28_0[1] == 101 then
		return ChapterTools.IsClearStage(arg_28_0[2])
	elseif arg_28_0[1] == 102 then
		local var_28_0 = arg_28_0[2]

		return ChapterTools.IsClearChapter(var_28_0)
	else
		return false
	end
end

function getConditionText(arg_29_0)
	if arg_29_0[1] == 101 then
		local var_29_0 = arg_29_0[2]
		local var_29_1 = getChapterIDByStageID(var_29_0)
		local var_29_2 = BattleStageTools.GetStageCfg(ChapterCfg[var_29_1].type, var_29_0)

		return string.format(GetTips("NOTE_TASK_UNLOCK"), GetI18NText(var_29_2.name))
	elseif arg_29_0[1] == 102 then
		return string.format(GetTips("NOTE_TASK_UNLOCK"), GetI18NText(ChapterCfg[arg_29_0[2]].subhead))
	else
		return ""
	end
end

function needShowBagFullBox()
	if EquipData:GetEquipBagFull() then
		EquipAction.EquipBagFull(false)

		return true
	end

	return false
end

function isBagFull(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0) do
		if ItemCfg[iter_31_1[1]].type == var_0_3.ITEM_TYPE.EQUIP and EquipTools.GetEquipNum() >= GameSetting.max_equip.value[1] then
			return true
		end
	end

	return false
end

function showEquipSendMail(arg_32_0)
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("EQUIP_SEND_MAIL"),
		OkCallback = function()
			if arg_32_0 then
				arg_32_0()
			end
		end
	})
end

function showBagFullBox()
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("EQUIP_NUM_MAX"),
		OkCallback = function()
			JumpTools.GoToSystem("/bag", {
				type = "equip"
			}, ViewConst.SYSTEM_ID.BAG)
		end
	})
end

function needShowVitalityFullBox()
	if CurrencyData:GetVitalityFull() then
		ActionCreators.VitalityFull(false)

		return true
	end

	return false
end

function isVitalityFull()
	return ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) >= ItemCfg[CurrencyConst.CURRENCY_TYPE_VITALITY].max
end

function showVitalitySendMail(arg_38_0)
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("VITALITY_FULL"),
		OkCallback = function()
			if arg_38_0 then
				arg_38_0()
			end
		end
	})
end

function canAddVitalityByProp(arg_40_0)
	if table.keyof(GameSetting.vitality_exchange_id_list.value, arg_40_0) then
		return not isVitalityFull()
	else
		return true
	end
end

function hasVitalityProp()
	for iter_41_0, iter_41_1 in ipairs(GameSetting.vitality_exchange_id_list.value) do
		if ItemTools.getItemNum(iter_41_1) > 0 then
			return true
		end
	end

	return false
end

function isOpenMission(arg_42_0)
	local var_42_0 = BattleStageData:GetStageData()
	local var_42_1 = getChapterIDByStageID(arg_42_0)

	if ChapterTools.IsFinishPreChapter(var_42_1) and var_42_0[arg_42_0] then
		if arg_42_0 == GameSetting.travel_skuld_new_ending_stage_id.value[1] and var_42_0[arg_42_0].clear_times < 1 then
			return false
		end

		return true
	end

	return false
end

function getMaxOpenSection(arg_43_0)
	local var_43_0 = getChapterIDByStageID(arg_43_0)

	if isOpenMission(arg_43_0) then
		return arg_43_0, var_43_0
	end

	for iter_43_0 = ChapterCfg[var_43_0].difficulty, 1, -1 do
		local var_43_1 = getChapterListByDifficulty(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, iter_43_0)

		for iter_43_1 = table.keyof(var_43_1, var_43_0), 1, -1 do
			local var_43_2 = ChapterCfg[var_43_1[iter_43_1]]

			for iter_43_2 = table.keyof(var_43_2.section_id_list, arg_43_0) or #var_43_2.section_id_list, 1, -1 do
				local var_43_3 = var_43_2.section_id_list[iter_43_2]

				if isOpenMission(var_43_3) then
					return var_43_3, var_43_1[iter_43_1]
				end
			end
		end
	end

	return arg_43_0, var_43_0
end

function getHeroAffixs(arg_44_0)
	if type(arg_44_0) ~= "table" then
		return {}
	end

	local var_44_0 = {}

	for iter_44_0, iter_44_1 in pairs(arg_44_0) do
		if iter_44_1[3] and iter_44_1[3] == 3 then
			table.insert(var_44_0, iter_44_1)
		end
	end

	return var_44_0
end

function getMosterAffix(arg_45_0)
	if type(arg_45_0) ~= "table" then
		return {}
	end

	local var_45_0 = {}

	for iter_45_0, iter_45_1 in pairs(arg_45_0) do
		if iter_45_1[3] and iter_45_1[3] ~= 3 then
			table.insert(var_45_0, iter_45_1)
		end
	end

	return var_45_0
end

function getAffixName(arg_46_0)
	local var_46_0 = arg_46_0[1]

	if var_46_0 == nil then
		return ""
	end

	local var_46_1 = AffixTypeCfg[var_46_0]

	if var_46_1 == nil then
		-- block empty
	end

	return GetI18NText(var_46_1.name)
end

function getAffixDesc(arg_47_0)
	local var_47_0 = arg_47_0[1]
	local var_47_1 = arg_47_0[2]
	local var_47_2 = ""

	if var_47_0 == nil then
		return var_47_2
	end

	local var_47_3 = {}
	local var_47_4 = AffixTypeCfg[var_47_0]

	if var_47_4 == nil then
		-- block empty
	end

	local var_47_5 = GetCfgDescription(var_47_4.description[1], var_47_1)

	return GetI18NText(var_47_5)
end

function getAffixSprite(arg_48_0)
	local var_48_0 = arg_48_0[1]

	if var_48_0 == nil then
		return ""
	end

	local var_48_1 = AffixTypeCfg[var_48_0]

	if var_48_1 == nil then
		-- block empty
	end

	local var_48_2 = PublicBuffCfg[var_48_1.affix_buff_id].icon

	if var_48_2 == "" then
		Debug.Log(string.format("PublicBuffCfg[%s].icon没有值", var_48_1.affix_buff_id))
	end

	return getSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. var_48_2)
end

function getEquipSkillSprite(arg_49_0)
	if arg_49_0 == nil then
		return ""
	end

	local var_49_0 = EquipSkillCfg[arg_49_0]

	if var_49_0 == nil then
		-- block empty
	end

	local var_49_1 = var_49_0.icon

	return getSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. var_49_1)
end

function getAttributeAffix(arg_50_0, arg_50_1)
	local var_50_0 = clone(EquipBreakThroughMaterialItemCfg[arg_50_0].params)
	local var_50_1 = PublicBuffCfg[AffixTypeCfg[var_50_0[1]].buffid[1]]

	if arg_50_1 > var_50_1.max_level then
		var_50_0[2] = var_50_1.max_level
	else
		var_50_0[2] = arg_50_1
	end

	return var_50_0
end

function getAttributeAffixValue(arg_51_0, arg_51_1)
	local var_51_0 = clone(EquipBreakThroughMaterialItemCfg[arg_51_0].params)
	local var_51_1 = PublicBuffCfg[AffixTypeCfg[var_51_0[1]].buffid[1]]

	if arg_51_1 > var_51_1.max_level then
		arg_51_1 = var_51_1.max_level
	end

	return var_51_1.buffparam_base[2] + var_51_1.buffparam_factor[2] * (arg_51_1 - 1)
end

function MergeActivityID(arg_52_0, arg_52_1)
	if arg_52_0 then
		local var_52_0 = ActivityCfg[arg_52_0]

		if var_52_0 and var_52_0.activity_template == ActivityTemplateConst.STORY_STAGE then
			for iter_52_0, iter_52_1 in pairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STORY]) do
				if table.keyof(ActivityCfg[iter_52_1].sub_activity_list, arg_52_0) then
					return iter_52_1
				end
			end
		elseif var_52_0 and var_52_0.activity_template == ActivityTemplateConst.ACTIVITY_AFFIX_SELECT_SUBMODULE then
			for iter_52_2, iter_52_3 in pairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_AFFIX_SELECT]) do
				if table.keyof(ActivityCfg[iter_52_3].sub_activity_list, arg_52_0) then
					return iter_52_3
				end
			end
		end
	end

	return arg_52_0
end

function GetTrialHeroList(arg_53_0, arg_53_1, arg_53_2)
	if arg_53_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or arg_53_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
		local var_53_0 = getChapterIDByStageID(arg_53_1)
		local var_53_1 = ChapterCfg[var_53_0]
		local var_53_2 = var_53_1.activity_id

		if var_53_2 ~= 0 and ActivityTools.GetActivityStatus(var_53_2) ~= 1 then
			return {}
		end

		return type(var_53_1.trial_list) == "table" and var_53_1.trial_list or {}
	end

	if arg_53_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		if GetChessLevelIDByStageID(arg_53_1) then
			local var_53_3 = WarchessLevelCfg[GetChessLevelIDByStageID(arg_53_1)]

			return type(var_53_3.trial_list) == "table" and var_53_3.trial_list or {}
		else
			return {}
		end
	end

	if arg_53_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS then
		local var_53_4 = {}
		local var_53_5 = NewWarChessData:GetHeroInfoList()

		for iter_53_0, iter_53_1 in pairs(var_53_5) do
			if iter_53_1[2] > 0 then
				table.insert(var_53_4, NewWarChessHeroCfg[iter_53_1[1]].temp_id)
			end
		end

		return var_53_4
	end

	if arg_53_0 == BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON then
		local var_53_6 = SoloHeartDemonData:GetDataByPara("openEditor")
		local var_53_7 = SoloHeartDemonCfg[var_53_6]

		if SoloHeartDemonData:GetDataByPara("stageToDifficulty")[arg_53_1] < 3 then
			return var_53_7.trial_hero
		end

		return {}
	end

	if arg_53_0 == BattleConst.STAGE_TYPE_NEW.AREA_BATTLE then
		return ActivityAreaBattleCfg[arg_53_2].hero
	end

	if arg_53_0 == BattleConst.STAGE_TYPE_NEW.MULT_HEART_DEMON then
		return MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[arg_53_2][1]].trial_hero
	end

	if arg_53_0 == BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME then
		local var_53_8 = DestroyBoxGameCfg.get_id_list_by_activity_id[arg_53_2][1]
		local var_53_9 = DestroyBoxGameCfg[var_53_8].main_activity_id
		local var_53_10 = DestroyBoxGameData:GetSelectID(var_53_9)

		return DestroyBoxGameCfg[var_53_10].trial_hero
	end

	if arg_53_0 == BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM then
		return ChallengeRogueTeamData:GetTrialHeroList()
	end

	if arg_53_0 == BattleConst.STAGE_TYPE_NEW.OSIRIS_PLAY_GAME then
		return OsirisPlayGameTempHeroData:GetTrialHeroList()
	end

	if arg_53_0 == BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE then
		if HodurTools.CheckSpecialAffix() then
			return GameSetting.limit_character_id.value
		else
			local var_53_11 = GetHeroTeamActivityID(arg_53_0, arg_53_2, true)

			return BattleTeamData:GetHeroTrial(var_53_11) or {}
		end

		return {}
	end

	local var_53_12 = GetHeroTeamActivityID(arg_53_0, arg_53_2, true)

	return BattleTeamData:GetHeroTrial(var_53_12) or {}
end

function SetHeroTeam(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4, arg_54_5, arg_54_6, arg_54_7, arg_54_8, arg_54_9)
	local var_54_0 = ReserveParams.New(nil, arg_54_7, arg_54_8, {
		stageType = arg_54_0,
		stageID = arg_54_1,
		activityID = arg_54_2
	})
	local var_54_1 = arg_54_6.mimir_id or 0
	local var_54_2 = arg_54_6.chip_list or {}

	ReserveTools.SetTeam(var_54_0, arg_54_3, arg_54_4, arg_54_5, var_54_1, var_54_2, arg_54_9 or 0)
end

function GetHeroTeamActivityID(arg_55_0, arg_55_1, arg_55_2)
	if arg_55_0 == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON then
		if DemonChallengeCfg[arg_55_1] then
			return DemonChallengeCfg[arg_55_1].activity_id
		else
			return arg_55_1
		end
	elseif arg_55_1 and arg_55_1 ~= 0 then
		return arg_55_2 and arg_55_1 or MergeActivityID(arg_55_1)
	elseif arg_55_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or arg_55_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE or arg_55_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or arg_55_0 == BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE or arg_55_0 == BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE or arg_55_0 == BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL or arg_55_0 == BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY or arg_55_0 == BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP or arg_55_0 == BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO or arg_55_0 == BattleConst.STAGE_TYPE_NEW.POLYHEDRON then
		return arg_55_0
	else
		return 0
	end
end

function GetLocalHeroTeam(arg_56_0, arg_56_1, arg_56_2, arg_56_3, arg_56_4)
	local var_56_0 = {
		0,
		0,
		0
	}
	local var_56_1 = {
		false,
		false,
		false
	}
	local var_56_2 = {}
	local var_56_3 = {
		0,
		0,
		0
	}
	local var_56_4 = false

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == arg_56_0 then
		var_56_0 = MatrixData:GetMatrixBattleHeroTeam()

		local var_56_5 = not MatrixData:GetCanChangeCaptain()

		var_56_1 = {
			var_56_5,
			var_56_5,
			var_56_5
		}
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == arg_56_0 then
		var_56_0 = ActivityMatrixData:GetMatrixBattleHeroTeam(arg_56_2)

		local var_56_6 = not ActivityMatrixData:GetCanChangeCaptain(arg_56_2)

		var_56_1 = {
			var_56_6,
			var_56_6,
			var_56_6
		}
	elseif BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX == arg_56_0 then
		var_56_0 = StrategyMatrixData:GetMatrixBattleHeroTeam(arg_56_2)

		local var_56_7 = not StrategyMatrixData:GetCanChangeCaptain(arg_56_2)

		var_56_1 = {
			var_56_7,
			var_56_7,
			var_56_7
		}
	else
		local var_56_8 = ReserveParams.New(nil, arg_56_3, arg_56_4, {
			stageType = arg_56_0,
			stageID = arg_56_1,
			activityID = arg_56_2
		})

		return ReserveTools.GetHeroList(var_56_8)
	end

	return var_56_0, var_56_1, var_56_2, var_56_3, var_56_4
end

function getShopCfg(arg_57_0)
	return ShopCfg[arg_57_0]
end

function getGoodListByGiveID(arg_58_0)
	return ShopCfg.get_id_list_by_give_id[arg_58_0] or {}
end

function getShopIDListByShopID(arg_59_0)
	return ShopCfg.get_id_list_by_shop_id[arg_59_0] or {}
end

function getShopIDListByCurrency(arg_60_0)
	return ShopCfg.get_id_list_by_cost_id[arg_60_0] or {}
end

_G.SceneDataForExcehangeVar = nil

function GetSceneDataForExcehange()
	if _G.SceneDataForExcehangeVar == nil then
		_G.SceneDataForExcehangeVar = SceneDataForExcehange.New()
	end

	return _G.SceneDataForExcehangeVar
end

function ResetSceneDataForExcehange()
	_G.SceneDataForExcehangeVar = SceneDataForExcehange.New()
end

_G.MasterSkillDataForExchangeVar = nil

function GetMasterSkillDataForExcehange()
	if _G.MasterSkillDataForExchangeVar == nil then
		_G.MasterSkillDataForExchangeVar = MasterSkillDataForExchange.New()
	end

	return _G.MasterSkillDataForExchangeVar
end

function ResetMasterSkillDataForExcehange()
	_G.MasterSkillDataForExchangeVar = MasterSkillDataForExchange.New()
end

function TryToStartBattle()
	SetForceShowQuanquan(true)
	LuaExchangeHelper.Launcher(GetSceneDataForExcehange(), function()
		SetForceShowQuanquan(false)

		_G.BATTLE_SERVER_ERROR_TIME = 0

		DestroyLua()
		gameContext:SetSystemLayer("battle")
	end)
end

_G.ChessDataForExcehangeVar = nil

function GetChessDataForExcehange()
	if _G.ChessDataForExcehangeVar == nil then
		_G.ChessDataForExcehangeVar = ChessDataForExchange.New()
	end

	return _G.ChessDataForExcehangeVar
end

function ResetChessDataForExcehange()
	_G.ChessDataForExcehangeVar = ChessDataForExchange.New()
end

function StartChessBattleMode()
	SetForceShowQuanquan(true)
	ChessLuaBridge.Launcher(GetChessDataForExcehange(), function()
		SetForceShowQuanquan(false)

		_G.BATTLE_SERVER_ERROR_TIME = 0

		DestroyLua()
	end)

	_G.ChessDataForExcehangeVar = nil
end

_G.NewChessDataForExcehangeVar = nil

function GetNewChessDataForExcehange()
	if _G.NewChessDataForExcehangeVar == nil then
		_G.NewChessDataForExcehangeVar = NewChessDataForExchange.New()
	end

	return _G.NewChessDataForExcehangeVar
end

function ResetNewChessDataForExcehange()
	_G.NewChessDataForExcehangeVar = NewChessDataForExchange.New()
end

function StartNewChessBattleMode()
	SetForceShowQuanquan(true)
	NewChessLuaBridge.Launcher(GetNewChessDataForExcehange(), function()
		SetForceShowQuanquan(false)

		_G.BATTLE_SERVER_ERROR_TIME = 0

		DestroyLua()
		gameContext:SetSystemLayer("battle")
	end)

	_G.NewChessDataForExcehangeVar = nil
end

_G.ChessBoardDataForExcehangeVar = nil

function GetChessBoardDataForExcehange()
	if _G.ChessBoardDataForExcehangeVar == nil then
		_G.ChessBoardDataForExcehangeVar = ChessBoardDataForExchange.New()
	end

	return _G.ChessBoardDataForExcehangeVar
end

function StartChessBoardBattleMode()
	SetForceShowQuanquan(true)
	ChessBoardLuaBridge.Launcher(GetChessBoardDataForExcehange(), function()
		SetForceShowQuanquan(false)

		_G.BATTLE_SERVER_ERROR_TIME = 0

		DestroyLua()
	end)

	_G.ChessBoardDataForExcehangeVar = nil
end

_G.MusicDataForExchangeVar = nil

function GetMusicDataForExchange()
	if _G.MusicDataForExchangeVar == nil then
		_G.MusicDataForExchangeVar = MusicDataForExchange.New()
	end

	return _G.MusicDataForExchangeVar
end

function StartMusicMode()
	DestroyLua()
	MusicLuaBridge.Launcher(GetMusicDataForExchange())
end

_G.MusicDataForExchangeVar2 = nil

function GetMusicDataForExchange2()
	if _G.MusicDataForExchangeVar2 == nil then
		_G.MusicDataForExchangeVar2 = MusicDataForExchange2.New()
	end

	return _G.MusicDataForExchangeVar2
end

function StartMusicMode2()
	DestroyLua()
	MusicLuaBridge2.Launcher(GetMusicDataForExchange2())
end

_G.ZumaDataForExchangeVar = nil

function GetZumaDataForExchange()
	if _G.ZumaDataForExchangeVar == nil then
		_G.ZumaDataForExchangeVar = ZumaDataForExchange.New()
	end

	return _G.ZumaDataForExchangeVar
end

_G.PinballDataForExchangeVar = nil

function GetPinballDataForExchange()
	if _G.PinballDataForExchangeVar == nil then
		_G.PinballDataForExchangeVar = PinballDataForExchange.New()
		_G.PinballDataForExchangeVar.mapData = PinballMapGenerateData.New()
		_G.PinballDataForExchangeVar.playerData = PinballRoleBattleData.New()
	end

	return _G.PinballDataForExchangeVar
end

function TableTo2DArray(arg_84_0, arg_84_1)
	local var_84_0 = typeof(arg_84_1)
	local var_84_1 = System.Array.CreateInstance(var_84_0:MakeArrayType(), #arg_84_0)

	for iter_84_0 = 1, #arg_84_0 do
		local var_84_2 = arg_84_0[iter_84_0]
		local var_84_3 = System.Array.CreateInstance(var_84_0, #var_84_2)

		for iter_84_1 = 1, #var_84_2 do
			var_84_3[iter_84_1 - 1] = var_84_2[iter_84_1]
		end

		var_84_1[iter_84_0 - 1] = var_84_3
	end

	return var_84_1
end

_G.DormDataForExcehangeVar = nil

function GetDormDataForExcehange()
	if _G.DormDataForExcehangeVar == nil then
		_G.DormDataForExcehangeVar = DormDataForExchange.New()
	end

	return _G.DormDataForExcehangeVar
end

function ResetDormDataForExcehange()
	_G.DormDataForExcehangeVar = DormDataForExchange.New()
end

function StartDormMode(arg_87_0)
	SetForceShowQuanquan(true)
	DormLuaBridge.Launcher(arg_87_0 or GetDormDataForExcehange(), function()
		SetForceShowQuanquan(false)
		DestroyLua()
	end)

	_G.DormDataForExcehangeVar = nil
end

_G.GuildActivityDataForExchangeVar = nil

function GetGuildActivityDataForExchange(arg_89_0, arg_89_1)
	if _G.GuildActivityDataForExchangeVar == nil then
		_G.GuildActivityDataForExchangeVar = GuildActivityDataForExchange.New()
	end

	if arg_89_0 ~= nil and arg_89_0 > 0 then
		_G.GuildActivityDataForExchangeVar.nodeId = arg_89_0
		_G.GuildActivityDataForExchangeVar.level = arg_89_1
	else
		_G.GuildActivityDataForExchangeVar.nodeId = 11001
		_G.GuildActivityDataForExchangeVar.level = 1
	end

	return _G.GuildActivityDataForExchangeVar
end

function ResetGuildActivityDataForExchange()
	_G.GuildActivityDataForExchangeVar = GuildActivityDataForExchange.New()
end

function StartGuildActivity(arg_91_0)
	SetForceShowQuanquan(true)

	local var_91_0

	if arg_91_0 ~= nil and arg_91_0 > 0 then
		local var_91_1 = ActivityClubCfg[arg_91_0].map_id

		var_91_0 = table.indexof(ActivityClubMapCfg.all, var_91_1)
	else
		var_91_0 = 1
	end

	GuildActivityLuaBridge.Launcher(GetGuildActivityDataForExchange(arg_91_0, var_91_0), function()
		SetForceShowQuanquan(false)

		_G.BATTLE_SERVER_ERROR_TIME = 0

		manager.windowBar:SetWhereTag("guildActivity")
		DestroyLua()
		gameContext:SetSystemLayer("guildActivity")
	end, function()
		manager.uiInit()
		GuildActivityAction.EnterGuildWarField(function()
			JumpTools.OpenPageByJump("/guildActivityWarField", {
				activityID = ActivityConst.GUILD_ACTIVITY_START,
				level = var_91_0
			})
			GuildActivityLuaBridge.StartGuildActivity(arg_91_0)
		end)
	end)

	_G.GuildActivityDataForExchangeVar = nil
end

_G.GuildActivitySPDataForExchangeVar = nil

function GetGuildSPActivityDataForExchange(arg_95_0, arg_95_1)
	if _G.GuildActivitySPDataForExchangeVar == nil then
		_G.GuildActivitySPDataForExchangeVar = GuildActivitySPDataForExchange.New()
	end

	if arg_95_0 ~= nil and arg_95_0 > 0 then
		_G.GuildActivitySPDataForExchangeVar.nodeId = arg_95_0
		_G.GuildActivitySPDataForExchangeVar.level = arg_95_1
		_G.GuildActivitySPDataForExchangeVar.activityID = GuildActivitySPData:GetCurMainActivityID()
	else
		_G.GuildActivitySPDataForExchangeVar.nodeId = 11001
		_G.GuildActivitySPDataForExchangeVar.level = 1
		_G.GuildActivitySPDataForExchangeVar.activityID = ActivityConst.GUILD_ACTIVITY_SP_2_4
	end

	return _G.GuildActivitySPDataForExchangeVar
end

function ResetGuildActivitySPDataForExchange()
	_G.GuildActivitySPDataForExchangeVar = GuildActivitySPDataForExchange.New()
end

function StartGuildActivitySP(arg_97_0)
	SetForceShowQuanquan(true)

	local var_97_0

	if arg_97_0 ~= nil and arg_97_0 > 0 then
		local var_97_1 = ActivityClubSPCfg[arg_97_0].map_id
		local var_97_2 = GuildActivitySPData:GetCurRunActivityID()
		local var_97_3 = ActivityClubSPMapCfg.get_id_list_by_activity[var_97_2]

		var_97_0 = table.indexof(var_97_3, var_97_1)
	else
		var_97_0 = 1
	end

	if type(var_97_0) ~= "number" then
		SetForceShowQuanquan(false)
		print("未找到当前点位对应的地图索引,节点id为" .. arg_97_0)

		return
	end

	GuildActivitySPLuaBridge.Launcher(GetGuildSPActivityDataForExchange(arg_97_0, var_97_0), function()
		SetForceShowQuanquan(false)

		_G.BATTLE_SERVER_ERROR_TIME = 0

		manager.windowBar:SetWhereTag("guildActivitySP")
		DestroyLua()
		gameContext:SetSystemLayer("guildActivitySP")
	end, function()
		manager.uiInit()
		GuildActivitySPAction.EnterGuildWarField(function()
			GuildActivitySPLuaBridge.StartGuildActivity(arg_97_0)

			local var_100_0 = GuildActivitySPData:GetCurRunActivityID()

			JumpTools.OpenPageByJump("/guildActivitySPWarField", {
				nodeID = arg_97_0,
				activityID = var_100_0,
				level = var_97_0,
				totalActivityID = var_100_0
			})
		end)
	end)

	_G.GuildActivitySPDataForExchangeVar = nil
end

function StartCaptureGameMode(arg_101_0)
	SetForceShowQuanquan(true)
	Capture.Runtime.CaptureGameLuaBridge.Launcher(arg_101_0, function()
		SetForceShowQuanquan(false)
		DestroyLua()
		gameContext:SetSystemLayer("battle")
	end)
end

function getRewardFromDropCfg(arg_103_0, arg_103_1)
	if arg_103_0 == nil then
		return {}
	end

	local var_103_0 = DropCfg[arg_103_0]

	if arg_103_0 == 0 then
		return {}
	end

	if var_103_0 == nil then
		return {}
	end

	local var_103_1 = {}

	if arg_103_1 and #var_103_0.base_drop >= 1 then
		if var_103_0.base_drop ~= "" then
			for iter_103_0, iter_103_1 in pairs(var_103_0.base_drop) do
				table.insert(var_103_1, formatReward(iter_103_1))
			end
		end
	else
		if var_103_0.random_drop ~= "" then
			for iter_103_2, iter_103_3 in pairs(var_103_0.random_drop) do
				table.insert(var_103_1, formatReward(iter_103_3))
			end
		end

		if var_103_0.weight_drop ~= "" then
			for iter_103_4, iter_103_5 in pairs(var_103_0.weight_drop) do
				table.insert(var_103_1, formatReward(iter_103_5))
			end
		end
	end

	local var_103_2 = mergeReward(var_103_1)

	return (sortReward(var_103_2))
end

function checkGold(arg_104_0, arg_104_1)
	if arg_104_1 == nil then
		arg_104_1 = true
	end

	if arg_104_0 > ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) then
		if arg_104_1 then
			local var_104_0 = false
			local var_104_1 = ItemCfg.get_id_list_by_sub_type[var_0_3.ITEM_SUB_TYPE.PROPS_BOND]

			for iter_104_0, iter_104_1 in ipairs(var_104_1 or {}) do
				if ItemTools.getItemNum(iter_104_1) > 0 then
					var_104_0 = true

					break
				end
			end

			if CurrencyData:GetGoldBuyTimes() >= GameSetting.coin_max_buy_time.value[1] and not var_104_0 then
				ShowTips("ERROR_ITEM_NOT_ENOUGH_GOLD")
			else
				JumpTools.OpenPopUp("currencyBuyGold")
			end
		end

		return false
	end

	return true
end

function checkMaterial(arg_105_0, arg_105_1)
	if arg_105_0 == nil then
		arg_105_0 = {}
	end

	if arg_105_1 == nil then
		arg_105_1 = true
	end

	for iter_105_0, iter_105_1 in ipairs(arg_105_0) do
		local var_105_0 = iter_105_1[1]

		if iter_105_1[2] > ItemTools.getItemNum(var_105_0) then
			if arg_105_1 then
				ShowPopItem(POP_SOURCE_ITEM, {
					var_105_0
				})
			end

			return false
		end
	end

	return true
end

function checkMoney(arg_106_0, arg_106_1)
	if arg_106_1 == nil then
		arg_106_1 = true
	end

	if arg_106_0 > ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) then
		if arg_106_1 then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_DIAMOND")
		end

		return false
	end

	return true
end

function checkVitality(arg_107_0, arg_107_1)
	if arg_107_1 == nil then
		arg_107_1 = true
	end

	if arg_107_0 > ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) then
		if arg_107_1 then
			if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] then
				JumpTools.OpenPopUp("currencyBuyFatigue")
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
			end
		end

		return false
	end

	return true
end

function setTextColor(arg_108_0, arg_108_1, arg_108_2, arg_108_3, arg_108_4)
	local var_108_0 = "<color=#%s>" .. arg_108_2 .. "</color>"
	local var_108_1

	arg_108_4 = arg_108_4 or function(arg_109_0, arg_109_1)
		return arg_109_0 <= arg_109_1
	end

	if arg_108_4(arg_108_2, arg_108_3) then
		var_108_1 = string.format(var_108_0, arg_108_0)
	else
		var_108_1 = string.format(var_108_0, arg_108_1)
	end

	return var_108_1
end

function GetServerTime()
	return manager.time:GetServerTime()
end

function formatText(arg_111_0)
	arg_111_0 = GetI18NText(arg_111_0)

	return (string.gsub(arg_111_0, "#{(%w+)}#", function(arg_112_0)
		if arg_112_0 == "nickname" then
			return PlayerData:GetPlayerInfo().nick
		else
			return arg_112_0
		end
	end))
end

function GetMonsterName(arg_113_0)
	local var_113_0

	if type(arg_113_0) ~= "table" then
		return var_113_0
	end

	for iter_113_0, iter_113_1 in pairs(arg_113_0) do
		if var_113_0 == nil then
			var_113_0 = GetI18NText(CharactorParamCfg[iter_113_1].Name)
		else
			var_113_0 = var_113_0 .. "&" .. string.match(GetI18NText(CharactorParamCfg[iter_113_1].Name), "<.*>")
		end
	end

	return var_113_0
end

function GetMonsterSkillDesList(arg_114_0)
	local var_114_0 = {}

	if type(arg_114_0) ~= "table" then
		return var_114_0
	end

	for iter_114_0, iter_114_1 in pairs(arg_114_0) do
		for iter_114_2 = 1, 6 do
			if string.len(MonsterCfg[iter_114_1]["skill" .. iter_114_2]) ~= 0 then
				table.insert(var_114_0, {
					name = MonsterCfg[iter_114_1]["skill" .. iter_114_2],
					info = MonsterCfg[iter_114_1]["skill_desc" .. iter_114_2]
				})
			end
		end
	end

	return var_114_0
end

function SetFile(arg_115_0, arg_115_1, arg_115_2, arg_115_3)
	local var_115_0 = arg_115_2
	local var_115_1 = PlayerPrefs.GetString("naive_angle_mode_key", "naive")
	local var_115_2

	for iter_115_0 in string.gmatch(arg_115_2, "[^/]+$") do
		var_115_2 = iter_115_0
	end

	local var_115_3 = VideoTrackCfg[var_115_2]

	if var_115_1 ~= "" and var_115_3 and var_115_3.has_non_native == 1 then
		var_115_0 = string.gsub(var_115_0, ".usm", "_alt.usm")
	end

	if not arg_115_3 then
		arg_115_0:SetFile(arg_115_1, var_115_0)
	else
		arg_115_0:SetFile(arg_115_1, var_115_0, arg_115_3)
	end
end

function ColorToHex(arg_116_0)
	local function var_116_0(arg_117_0)
		return string.format("%02X", arg_117_0)
	end

	return var_116_0(math.floor(arg_116_0.r * 255)) .. var_116_0(math.floor(arg_116_0.g * 255)) .. var_116_0(math.floor(arg_116_0.b * 255))
end

function DownloadSingleAsset(arg_118_0, arg_118_1, arg_118_2)
	local var_118_0 = {
		arg_118_0
	}

	if AssetDownloadManager.CheckResourcesNeedDownload(var_118_0) then
		manager.assetPend:StartDownloadAsset(arg_118_0, function()
			if arg_118_1 then
				arg_118_1()
			end
		end, function()
			if arg_118_2 then
				arg_118_2()
			end
		end)
	elseif arg_118_1 then
		arg_118_1()
	end
end

function DownloadSingleAssetQuanquan(arg_121_0, arg_121_1, arg_121_2)
	local var_121_0 = {
		arg_121_0
	}

	if AssetDownloadManager.CheckResourcesNeedDownload(var_121_0) then
		SetForceShowQuanquan(true)
		manager.assetPend:StartDownloadAsset(arg_121_0, function()
			SetForceShowQuanquan(false)

			if arg_121_1 then
				arg_121_1()
			end
		end, function()
			SetForceShowQuanquan(false)

			if arg_121_2 then
				arg_121_2()
			end
		end)
	elseif arg_121_1 then
		arg_121_1()
	end
end
