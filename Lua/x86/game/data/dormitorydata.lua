local var_0_0 = singletonClass("DormitoryData")
local var_0_1
local var_0_2
local var_0_3
local var_0_4
local var_0_5
local var_0_6
local var_0_7
local var_0_8
local var_0_9
local var_0_10

function var_0_0.IsUnlockScene(arg_1_0, arg_1_1)
	if arg_1_0:GetDormSceneData(arg_1_1) == nil then
		return false
	end

	return true
end

local function var_0_11(arg_2_0)
	var_0_7 = arg_2_0 or 0
end

local function var_0_12(arg_3_0)
	var_0_1 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.dorm) do
		var_0_1[iter_3_1.id] = {
			pos_id = iter_3_1.pos_id,
			exp = iter_3_1.exp or 0,
			likeNum = iter_3_1.liked_num or 0
		}
		var_0_1[iter_3_1.id].archiveIDList = {}

		for iter_3_2, iter_3_3 in ipairs(iter_3_1.archives_id) do
			table.insert(var_0_1[iter_3_1.id].archiveIDList, iter_3_3)
		end

		var_0_1[iter_3_1.id].give_furnitures = {}

		if iter_3_1.give_furnitures then
			for iter_3_4, iter_3_5 in ipairs(iter_3_1.give_furnitures) do
				if BackHomeFurniture[iter_3_5.id].is_give == 1 then
					var_0_1[iter_3_1.id].give_furnitures[iter_3_5.id] = iter_3_5.num
				end
			end
		end

		if BackHomeCfg[iter_3_1.id].type == DormConst.BACKHOME_TYPE.PrivateDorm and var_0_1[iter_3_1.id].archiveIDList[1] then
			DormData:GetHeroInfo(var_0_1[iter_3_1.id].archiveIDList[1]):InitHeroRoomID(iter_3_1.id)
		end
	end
end

local function var_0_13(arg_4_0)
	var_0_1 = {}

	if not var_0_1 then
		print("地图集合数据为空")
	end

	if arg_4_0 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
			DormRoomTools:InitNewSingleRoomData(iter_4_1, var_0_1)
		end

		for iter_4_2, iter_4_3 in pairs(var_0_1) do
			DormRoomTools:RefreshDormExp(iter_4_2)
		end
	end

	DormData:UpdateAllPlaceFurNumList()
end

local function var_0_14()
	var_0_5 = getData("Dorm", "feedAllHeroFlag") or false
	var_0_6 = getData("Dorm", "buyFurCurrencyID")

	if not var_0_6 then
		var_0_6 = DormConst.DORM_CURRENCY_ID
	end
end

local function var_0_15()
	DormRedPointTools:SaveFurPlaceRedPointData()
	DormFurnitureTools:SaveFurEditFlag()

	if var_0_5 then
		saveData("Dorm", "feedAllHeroFlag", var_0_5)
	end

	if var_0_6 then
		saveData("Dorm", "buyFurCurrencyID", var_0_6)
	end
end

local function var_0_16()
	DormFurnitureTemplateData:Dispose()
	DormRoomTools:Dispose()
	DormSuitData:DisposeDormSuitData()
end

local function var_0_17()
	for iter_8_0, iter_8_1 in pairs(var_0_1) do
		iter_8_1.roomInfo = nil
		iter_8_1.specialFur = nil
	end
end

function var_0_0.Init(arg_9_0)
	var_0_9 = nil
	var_0_10 = nil

	DormVisitTools:InitExhibitList()

	var_0_8 = {}

	local var_9_0 = getData("Dorm", "likeInfo") or {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		var_0_8[iter_9_1.roomID] = iter_9_1.num
	end
end

function var_0_0.InitSimpleDormInfo(arg_10_0, arg_10_1)
	DormRoomTools:InitDormHasPlaceFurInfo(arg_10_1)
	DormVisitTools:InitDormVisitData(arg_10_1)
	DormFurnitureTemplateData:InitTemplateSimpleDorm(arg_10_1)
	DormSuitData:InitDormSuitList(arg_10_1)
	var_0_12(arg_10_1)
	var_0_11(arg_10_1.daily_game_currency_num)
end

function var_0_0.InitDetialDormData(arg_11_0, arg_11_1)
	DormRoomTools:InitDormHasPlaceFurInfo(arg_11_1)
	DormFurnitureTemplateData:InitDormFurnitureTemplate(arg_11_1)
	DormVisitTools:InitDormVisitData(arg_11_1)
	var_0_13(arg_11_1.dorms)
	DormFurnitureTools:InitFurEditFlag()
	var_0_14()
end

function var_0_0.EnterCurSystem(arg_12_0)
	DormTools:SystemStayTime(DormConst.BACKHOME_SYSTEM_TYPE.Dorm, false)
	DormRedPointTools:EnterDormitorySystem()
	DormSuitData:EnterDormSystem()
end

function var_0_0.ExitCurSystem(arg_13_0)
	DormTools:SystemStayTime(DormConst.BACKHOME_SYSTEM_TYPE.Dorm, true)

	var_0_9 = nil
	var_0_10 = nil

	DormRhythmGameData:Dispose()
	DormRedPointTools:ExitDormitorySystem()
	DormSuitData:ExitDormSystem()
end

function var_0_0.ExitBackHomeSystem(arg_14_0)
	var_0_17()
	var_0_15()
	var_0_16()
end

function var_0_0.OtherSystemVisitBack(arg_15_0)
	var_0_17()
	var_0_16()
end

function var_0_0.RefreshDormDailyZero(arg_16_0)
	var_0_11(0)
end

function var_0_0.GetDormMapList(arg_17_0)
	if var_0_1 then
		return var_0_1
	end

	print("宿舍地图数据不存在")
end

function var_0_0.GetDormSceneData(arg_18_0, arg_18_1)
	if var_0_1 and var_0_1[arg_18_1] then
		return var_0_1[arg_18_1]
	end
end

function var_0_0.GetArchiveIDViaRoomID(arg_19_0, arg_19_1)
	if var_0_1[arg_19_1] then
		return var_0_1[arg_19_1].archiveIDList
	end
end

function var_0_0.GetDormExp(arg_20_0, arg_20_1)
	if not var_0_1[arg_20_1].exp then
		var_0_1[arg_20_1].exp = 0
	end

	return var_0_1[arg_20_1].exp
end

function var_0_0.GetDormLevel(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return
	end

	local var_21_0
	local var_21_1 = arg_21_0:GetDormExp(arg_21_1)
	local var_21_2 = 0

	if var_21_1 then
		for iter_21_0, iter_21_1 in ipairs(BackHomeDormLevel.all) do
			var_21_2 = BackHomeDormLevel[iter_21_1].exp + var_21_2

			if var_21_1 < var_21_2 then
				var_21_0 = iter_21_1

				break
			end
		end

		var_21_0 = var_21_0 or #BackHomeDormLevel.all

		return var_21_0
	end
end

function var_0_0.GetDormArchivesByArchitecture(arg_22_0, arg_22_1)
	local var_22_0 = {}

	if var_0_1[arg_22_1].archiveIDList then
		for iter_22_0, iter_22_1 in ipairs(var_0_1[arg_22_1].archiveIDList) do
			table.insert(var_22_0, iter_22_1)
		end
	end

	return var_22_0
end

function var_0_0.GetDormHerosByArchitecture(arg_23_0, arg_23_1)
	local var_23_0 = DormData:GetHeroInfoList()
	local var_23_1 = {}

	if var_0_1[arg_23_1].archiveIDList then
		for iter_23_0, iter_23_1 in ipairs(var_0_1[arg_23_1].archiveIDList) do
			table.insert(var_23_1, var_23_0[iter_23_1].hero_id)
		end
	end

	return var_23_1
end

function var_0_0.GetRoomIDByPosID(arg_24_0, arg_24_1)
	if var_0_1 then
		for iter_24_0, iter_24_1 in pairs(var_0_1) do
			if iter_24_1.pos_id == arg_24_1 then
				return iter_24_0
			end
		end
	end
end

function var_0_0.GetDormFurListByRoomID(arg_25_0, arg_25_1)
	if var_0_1 and var_0_1[arg_25_1].roomInfo then
		return var_0_1[arg_25_1].roomInfo.furnitureInfoS
	else
		print("场景数据缺少roomInfo,场景id为" .. arg_25_1)
	end
end

function var_0_0.GetAllFeedFlag(arg_26_0)
	return var_0_5
end

function var_0_0.GetBuyFurCurrencyID(arg_27_0)
	return var_0_6
end

function var_0_0.SetBuyFurCurrencyID(arg_28_0, arg_28_1)
	var_0_6 = arg_28_1
end

function var_0_0.GetDailyCurrency(arg_29_0)
	return var_0_7 or 0
end

function var_0_0.AddDailCurrencyNum(arg_30_0, arg_30_1)
	var_0_7 = var_0_7 + arg_30_1
end

function var_0_0.SetLastLikeNum(arg_31_0, arg_31_1, arg_31_2)
	arg_31_2 = arg_31_2 or DormData:GetCurrectSceneID()

	if not arg_31_2 or not BackHomeCfg[arg_31_2] then
		return
	end

	if not var_0_8[arg_31_2] then
		var_0_8[arg_31_2] = 0
	end

	var_0_8[arg_31_2] = arg_31_1

	local var_31_0 = {}

	for iter_31_0, iter_31_1 in pairs(var_0_8) do
		local var_31_1 = {
			roomID = iter_31_0,
			num = iter_31_1
		}

		table.insert(var_31_0, var_31_1)
	end

	saveData("Dorm", "likeInfo", var_31_0)
end

function var_0_0.GetLastLikeNum(arg_32_0, arg_32_1)
	arg_32_1 = arg_32_1 or DormData:GetCurrectSceneID()

	if not arg_32_1 or not BackHomeCfg[arg_32_1] then
		return 0
	end

	if not var_0_8[arg_32_1] then
		var_0_8[arg_32_1] = 0
	end

	return var_0_8[arg_32_1]
end

function var_0_0.SetAllFeedFlag(arg_33_0, arg_33_1)
	var_0_5 = arg_33_1
end

function var_0_0.RevisePrivateDormPosData(arg_34_0, arg_34_1)
	for iter_34_0, iter_34_1 in ipairs(arg_34_1.dorm_pos_list) do
		var_0_1[iter_34_1.architecture_id].pos_id = iter_34_1.pos_id
	end
end

function var_0_0.UnLockDormArchitecture(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = {
		pos_id = arg_35_2,
		id = arg_35_1
	}

	DormRoomTools:InitNewSingleRoomData(var_35_0, var_0_1, true)

	local var_35_1 = BackHomeCfg[arg_35_1].default_item

	for iter_35_0, iter_35_1 in ipairs(var_35_1) do
		local var_35_2 = DormData:GetFurNumInfo(iter_35_1[1])

		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(iter_35_1[1]) then
			var_35_2.num = var_35_2.num + iter_35_1[2]
			var_35_2.hasPlaceNum = var_35_2.hasPlaceNum + iter_35_1[2]
		else
			var_35_2.num = var_35_2.num + iter_35_1[2]
		end
	end
end

function var_0_0.FinishDorm(arg_36_0)
	return
end

function var_0_0.StartNextDayTimer(arg_37_0)
	arg_37_0:StopNextDayTimer()

	var_0_4 = Timer.New(function()
		if manager.time:GetServerTime() > var_0_3 then
			arg_37_0:StopNextDayTimer()
			arg_37_0:UpdatePrivateDormRedPoint()
		end
	end, 1, -1)

	var_0_4:Start()
end

function var_0_0.StopNextDayTimer(arg_39_0)
	if var_0_4 then
		var_0_4:Stop()

		var_0_4 = nil
	end
end

function var_0_0.UpdatePrivateDormRedPoint(arg_40_0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		for iter_40_0, iter_40_1 in pairs(var_0_1) do
			if DormTools:ShouldShowBirthdayBtn(iter_40_0) then
				manager.redPoint:setTip(RedPointConst.DORM_PLACEMENT_ROOM .. iter_40_0, 1)
			else
				manager.redPoint:setTip(RedPointConst.DORM_PLACEMENT_ROOM .. iter_40_0, 0)
			end
		end
	end
end

function var_0_0.HaveWatchedTheatre(arg_41_0, arg_41_1)
	for iter_41_0, iter_41_1 in ipairs(var_0_2) do
		if arg_41_1 == iter_41_1.id then
			local var_41_0 = iter_41_1.timestamp_list[1]

			if var_41_0 ~= nil and tonumber(os.date("!%Y", var_41_0)) == tonumber(os.date("!%Y", manager.time:GetServerTime())) then
				return true
			end

			break
		end
	end

	return false
end

function var_0_0.SetTheatreWatched(arg_42_0, arg_42_1)
	local var_42_0 = var_0_2[arg_42_1]

	if var_42_0 == nil then
		var_42_0 = {
			id = arg_42_1,
			timestamp_list = {}
		}

		table.insert(var_0_2, var_42_0)
	end

	table.insert(var_42_0.timestamp_list, 1, manager.time:GetServerTime())
end

function var_0_0.VisitFlag(arg_43_0, arg_43_1)
	var_0_9 = arg_43_1
end

function var_0_0.GetFlag(arg_44_0)
	return var_0_9
end

function var_0_0.SetFloor(arg_45_0, arg_45_1)
	var_0_10 = arg_45_1
end

function var_0_0.GetFloor(arg_46_0)
	return var_0_10
end

return var_0_0
