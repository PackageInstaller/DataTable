require("game.data.DormDataTemplate")

local var_0_0 = import("game.dorm.DormEnum")
local var_0_1 = singletonClass("DormData")
local var_0_2
local var_0_3
local var_0_4
local var_0_5
local var_0_6
local var_0_7

function var_0_1.InitSimplaDormData(arg_1_0, arg_1_1)
	arg_1_0:UpdateReceivedWeekGiftNum(arg_1_1.received_be_visited_gift_num)
	var_0_1:InitHeroInfo(arg_1_1)
	BackHomeNpcData:InitNpcInfo(arg_1_1)
	var_0_1:InitFurnitureInfoList(arg_1_1.furnitures)
end

function var_0_1.InitDetailDormData(arg_2_0, arg_2_1)
	var_0_1:InitFurnitureInfoList(arg_2_1.furnitures)
end

function var_0_1.RefreshDailyZero(arg_3_0)
	if var_0_2 then
		for iter_3_0, iter_3_1 in pairs(var_0_2) do
			iter_3_1:ResetFeedTime()
		end
	end
end

function var_0_1.InitVisitDormData(arg_4_0, arg_4_1)
	var_0_5 = {
		hasGift = false,
		visitUser = {}
	}
	var_0_5.hasGift = arg_4_1.is_have_gift

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.visited_user_list) do
		table.insert(var_0_5.visitUser, {
			name = iter_4_1.nick,
			heroID = iter_4_1.hero_id
		})
	end
end

function var_0_1.GetVisitInfo(arg_5_0)
	if var_0_5 == nil then
		var_0_5 = {
			hasGift = false,
			visitUser = {}
		}
	end

	return var_0_5
end

function var_0_1.CanReceiveVisitReward(arg_6_0)
	if var_0_5 then
		return var_0_5.hasGift
	else
		return false
	end
end

function var_0_1.SetReceiveVisitReward(arg_7_0, arg_7_1)
	if var_0_5 then
		var_0_5.hasGift = arg_7_1
	end
end

function var_0_1.UpdateReceivedWeekGiftNum(arg_8_0, arg_8_1)
	manager.notify:Invoke(BACKHOME_VISIT_INFO_UPDATE)

	var_0_6 = arg_8_1 or 0
end

function var_0_1.GetWeekReceivedGiftNum(arg_9_0)
	return var_0_6
end

function var_0_1.GetMaxWeekReceivedGiftNum(arg_10_0)
	return GameSetting.dorm_visit_gift_week_num.value[1]
end

function var_0_1.Init(arg_11_0)
	var_0_7 = false
	var_0_4 = nil
end

function var_0_1.InitHeroInfo(arg_12_0, arg_12_1)
	var_0_2 = {}

	if arg_12_1.backhome_hero then
		for iter_12_0, iter_12_1 in ipairs(arg_12_1.backhome_hero) do
			local var_12_0 = {
				archives_id = iter_12_1.archives_id,
				hero_id = iter_12_1.hero_id,
				feed_times = iter_12_1.feed_times or 0,
				fatigue = iter_12_1.fatigue,
				totalFeedTime = iter_12_1.total_feed_times,
				isLock = iter_12_1.is_lock
			}

			if DormHeroTools:GetTemplateIDInDorm(iter_12_1.archives_id) then
				local var_12_1 = DormHeroTemplate.New(var_12_0)

				var_0_2[iter_12_1.archives_id] = var_12_1
			end
		end
	end

	if arg_12_1.hero_setting then
		for iter_12_2, iter_12_3 in ipairs(arg_12_1.hero_setting) do
			local var_12_2 = iter_12_3.hero_id
			local var_12_3 = HeroRecordCfg.get_id_list_by_hero_id[var_12_2][1]

			var_0_2[var_12_3]:SetHeroSkinID(var_12_2, iter_12_3.skin_id)
		end
	end
end

function var_0_1.GetHeroInfoList(arg_13_0)
	return var_0_2
end

function var_0_1.GetHeroInfo(arg_14_0, arg_14_1)
	if var_0_2 and DormHeroTools:GetTemplateIDInDorm(arg_14_1) then
		if not var_0_2[arg_14_1] then
			local var_14_0 = {
				archives_id = arg_14_1
			}

			if DormHeroTools:GetAllCanUseHeroIDInDorm(arg_14_1)[1] then
				var_0_2[arg_14_1] = DormHeroTemplate.New(var_14_0)
			end
		end

		return var_0_2[arg_14_1]
	else
		print(string.format("后宅不存在档案id为%s的可用角色", tostring(arg_14_1)))
	end
end

function var_0_1.GetHeroTemplateInfo(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:GetHeroArchiveID(arg_15_1)

	return (arg_15_0:GetHeroInfo(var_15_0))
end

function var_0_1.GetCharacterInfo(arg_16_0, arg_16_1)
	if DormNpcTools:CheckIDIsNpc(arg_16_1) then
		return BackHomeNpcData:GetBackHomeNpcInfoList()[arg_16_1]
	else
		return var_0_1:GetHeroTemplateInfo(arg_16_1)
	end
end

function var_0_1.GetHeroFatigue(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:GetHeroArchiveID(arg_17_1)
	local var_17_1 = arg_17_0:GetHeroInfo(var_17_0)

	if var_17_1 then
		return var_17_1.fatigue
	else
		return 0
	end
end

function var_0_1.SetHeroFatigue(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0:GetHeroArchiveID(arg_18_1)

	if not var_0_2 then
		var_0_2 = {}
	end

	if DormHeroTools:GetTemplateIDInDorm(var_18_0) then
		if not var_0_2[var_18_0] then
			local var_18_1 = {
				archives_id = var_18_0
			}

			var_0_2[var_18_0] = DormHeroTemplate.New(var_18_1)
		end

		var_0_2[var_18_0]:SetFatigue(arg_18_2)
	else
		print(string.format("后宅不存在档案id为%s的可用角色", tostring(var_18_0)))
	end
end

function var_0_1.GetHeroArchiveID(arg_19_0, arg_19_1)
	if HeroRecordCfg.get_id_list_by_hero_id[arg_19_1] then
		return HeroRecordCfg.get_id_list_by_hero_id[arg_19_1][1]
	end

	return arg_19_1
end

function var_0_1.RefreshInDormHeroInfo(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if not arg_20_1 or not arg_20_2 then
		return
	end

	local var_20_0 = DormitoryData:GetDormSceneData(arg_20_1)
	local var_20_1 = arg_20_0:GetHeroInfoList()

	if BackHomeCfg[arg_20_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		var_20_0.archiveIDList = {}

		for iter_20_0, iter_20_1 in ipairs(arg_20_2) do
			local var_20_2 = DormData:GetHeroArchiveID(iter_20_1)
			local var_20_3 = arg_20_0:GetHeroTemplateInfo(var_20_2)

			var_20_3:SetCurHeroID(iter_20_1)

			var_20_3.dancePos = nil

			table.insert(var_20_0.archiveIDList, var_20_2)
			var_20_1[var_20_2]:ResetHeroSkill()
		end
	elseif BackHomeCfg[arg_20_1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		local var_20_4 = arg_20_2[1]
		local var_20_5 = DormData:GetHeroArchiveID(var_20_4)

		if var_20_0.archiveIDList[1] ~= var_20_5 and var_20_0.archiveIDList and #var_20_0.archiveIDList > 0 then
			print("该房间已被其他角色使用")

			return
		end

		var_20_0.archiveIDList = {}

		table.insert(var_20_0.archiveIDList, var_20_5)

		local var_20_6 = arg_20_0:GetHeroTemplateInfo(var_20_5)

		if not arg_20_3 then
			var_20_6:SetCurHeroID(var_20_4)

			var_20_6.dancePos = nil
		end

		var_20_1[var_20_5]:ResetHeroSkill()
	end
end

function var_0_1.SetCurrentScene(arg_21_0, arg_21_1)
	var_0_4 = arg_21_1
end

function var_0_1.GetCurrectSceneID(arg_22_0)
	return var_0_4
end

function var_0_1.GetDormSceneData(arg_23_0, arg_23_1)
	if arg_23_1 then
		local var_23_0 = BackHomeCfg[arg_23_1]

		if var_23_0 then
			local var_23_1 = var_23_0.type

			if var_23_1 == DormConst.BACKHOME_TYPE.Canteen then
				return CanteenData:GetCanteenSceneData()
			elseif var_23_1 == DormConst.BACKHOME_TYPE.PublicDorm or var_23_1 == DormConst.BACKHOME_TYPE.PrivateDorm or var_23_1 == DormConst.BACKHOME_TYPE.VISITPUBLICDORM or var_23_1 == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
				return DormitoryData:GetDormMapList()[arg_23_1]
			end
		else
			Debug.LogError("不存在" .. arg_23_1 .. "场景的配置信息")
		end
	else
		Debug.LogError("id为空")
	end
end

function var_0_1.GetDormSceneDataList(arg_24_0, arg_24_1)
	if arg_24_1 == var_0_0.DormSystemType.Canteen then
		return {
			CanteenData:GetCanteenSceneData()
		}
	elseif arg_24_1 == var_0_0.DormSystemType.Dormitory then
		return (DormitoryData:GetDormMapList())
	end
end

function var_0_1.InitFurnitureInfoList(arg_25_0, arg_25_1)
	var_0_3 = {}

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		var_0_3[iter_25_1.furniture_id] = {}
		var_0_3[iter_25_1.furniture_id].num = iter_25_1.num
		var_0_3[iter_25_1.furniture_id].give_num = iter_25_1.give_num or 0
		var_0_3[iter_25_1.furniture_id].hasPlaceNum = 0
	end
end

function var_0_1.GetFurnitureInfoList(arg_26_0)
	return var_0_3
end

function var_0_1.GetFurNumInfo(arg_27_0, arg_27_1)
	if not var_0_3 then
		var_0_3 = {}
	end

	if var_0_3[arg_27_1] then
		return var_0_3[arg_27_1]
	else
		var_0_3[arg_27_1] = {
			hasPlaceNum = 0,
			num = 0,
			give_num = 0
		}

		return var_0_3[arg_27_1]
	end
end

function var_0_1.AddFurTotalNum(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	if var_0_3 then
		local var_28_0 = arg_28_0:GetFurNumInfo(arg_28_1)

		if var_28_0.num == 0 then
			local var_28_1 = DormIlluTools.GetThemeID(arg_28_1)

			DormRedPointTools:SetIlluNewTagRed("furNew", RedPointConst.DORM_ILLU_FUR_THEME, true, var_28_1)
		end

		var_28_0.num = arg_28_2
		var_28_0.give_num = arg_28_3
	end

	if BackHomeFurniture[arg_28_1].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.SPECIFY then
		local var_28_2 = BackHomeFurniture[arg_28_1].hero_id
		local var_28_3 = DormRoomTools:GetDormIDViaArchive(var_28_2)

		if var_28_3 then
			local var_28_4 = DormitoryData:GetDormLevel(var_28_3)

			DormRoomTools:RefreshDormExp(var_28_3, arg_28_1, arg_28_2)

			local var_28_5 = DormitoryData:GetDormLevel(var_28_3)

			if var_28_4 ~= var_28_5 then
				DormRoomTools:GetDormLevelAward(var_28_2, var_28_4, var_28_5)
				manager.notify:Invoke(DORM_PRIVATE_LEVEL_UP, var_28_3, var_28_2)
			end
		end
	end
end

local function var_0_8()
	for iter_29_0, iter_29_1 in pairs(var_0_3) do
		if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(iter_29_0) then
			iter_29_1.hasPlaceNum = 0
		end
	end

	local var_29_0 = DormitoryData:GetDormMapList()

	for iter_29_2, iter_29_3 in pairs(var_29_0) do
		local var_29_1, var_29_2 = DormFurnitureTools:GetHasPlaceFurNumInfoInMap(iter_29_2)

		for iter_29_4, iter_29_5 in pairs(var_29_2) do
			if not var_0_3[iter_29_4] then
				var_0_3[iter_29_4] = {
					hasPlaceNum = 0,
					num = 0,
					give_num = 0
				}
			end

			if not var_0_3[iter_29_4].hasPlaceNum then
				var_0_3[iter_29_4].hasPlaceNum = 0
			end

			var_0_3[iter_29_4].hasPlaceNum = var_0_3[iter_29_4].hasPlaceNum + iter_29_5
		end
	end
end

local function var_0_9()
	local var_30_0 = DormitoryData:GetDormMapList()

	for iter_30_0, iter_30_1 in pairs(var_0_3) do
		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(iter_30_0) then
			iter_30_1.hasPlaceNum = 0
		end
	end

	for iter_30_2, iter_30_3 in pairs(var_30_0) do
		local var_30_1 = var_30_0[iter_30_2].specialFur

		for iter_30_4, iter_30_5 in pairs(var_30_1) do
			if not var_0_3[iter_30_5] then
				var_0_3[iter_30_5] = {
					hasPlaceNum = 0,
					num = 0,
					give_num = 0
				}
			end

			var_0_3[iter_30_5].hasPlaceNum = var_0_3[iter_30_5].hasPlaceNum + 1
		end
	end
end

local function var_0_10()
	local var_31_0 = DormitoryData:GetDormMapList()

	for iter_31_0, iter_31_1 in pairs(var_31_0) do
		local var_31_1 = var_31_0[iter_31_0].suitInfo

		for iter_31_2, iter_31_3 in pairs(var_31_1) do
			local var_31_2 = DormSuitData:GetNeedUseFurNumInfoBySuitID(iter_31_2)

			if var_31_2 then
				for iter_31_4, iter_31_5 in ipairs(var_31_2) do
					if not var_0_3[iter_31_5[1]] then
						var_0_3[iter_31_5[1]] = {
							hasPlaceNum = 0,
							num = 0,
							give_num = 0
						}
					end

					var_0_3[iter_31_5[1]].hasPlaceNum = var_0_3[iter_31_5[1]].hasPlaceNum + iter_31_5[2]
				end
			else
				for iter_31_6 = 0, iter_31_3.furList.Length - 1 do
					local var_31_3 = iter_31_3.furList[iter_31_6]

					if not var_0_3[var_31_3.id] then
						var_0_3[var_31_3.id] = {
							hasPlaceNum = 0,
							num = 0,
							give_num = 0
						}
					end

					var_0_3[var_31_3.id].hasPlaceNum = var_0_3[var_31_3.id].hasPlaceNum + 1
				end
			end
		end
	end
end

function var_0_1.UpdateAllPlaceFurNumList(arg_32_0)
	var_0_8()
	var_0_9()
	var_0_10()
end

function var_0_1.ChangeDevModelFlag(arg_33_0, arg_33_1)
	if Application.isEditor then
		var_0_7 = arg_33_1
	end
end

function var_0_1.GetDevModelFlag(arg_34_0)
	if Application.isEditor then
		return var_0_7
	end
end

return var_0_1
