local var_0_0 = {}
local var_0_1
local var_0_2
local var_0_3
local var_0_4
local var_0_5 = {}

function var_0_0.InitDormVisitData(arg_1_0, arg_1_1)
	var_0_2 = arg_1_1.exhibition_id or 0
end

function var_0_0.InitExhibitList(arg_2_0)
	var_0_1 = {}
end

function var_0_0.SetListIndex(arg_3_0, arg_3_1, arg_3_2)
	var_0_4 = {
		index = arg_3_1,
		subIndex = arg_3_2
	}
end

function var_0_0.GetListIndex(arg_4_0)
	return var_0_4
end

function var_0_0.GetLayoutID(arg_5_0)
	return var_0_3 or 0
end

function var_0_0.CheckCurIsVisitRoom(arg_6_0)
	local var_6_0 = DormData:GetCurrectSceneID()

	if var_6_0 and var_6_0 > DormConst.DORM_VISIT_ROOM_MIN then
		return true
	end

	return false
end

function var_0_0.GetTemplateExhibitList(arg_7_0, arg_7_1)
	if not var_0_1 then
		var_0_1 = {}
	end

	if not var_0_1[arg_7_1] then
		DormAction:AskFurTemplateExhibitList(arg_7_1)
	else
		return var_0_1[arg_7_1]
	end
end

function var_0_0.RefreshTemplateExhibit(arg_8_0, arg_8_1, arg_8_2)
	var_0_1[arg_8_2] = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		repeat
			if iter_8_1.architecture_id == 0 then
				break
			end

			local var_8_0 = {}

			var_0_1[arg_8_2][iter_8_1.user_id] = {
				user_id = iter_8_1.user_id,
				nick = iter_8_1.profile_base.nick,
				level = iter_8_1.level,
				icon = iter_8_1.profile_base.icon,
				iconFrame = iter_8_1.profile_base.icon_frame or 2001,
				architecture_id = iter_8_1.architecture_id,
				furniture_num = iter_8_1.furniture_num,
				likeNum = iter_8_1.liked_num or 0,
				heroIDList = var_8_0,
				visitNum = iter_8_1.visited_num or 0,
				sign = (iter_8_1.sign or ""):gsub("\n", ""),
				picture_link = iter_8_1.picture_link or "",
				info_background = iter_8_1.info_background or 0
			}

			for iter_8_2, iter_8_3 in ipairs(iter_8_1.skin_id_list) do
				table.insert(var_8_0, iter_8_3)
			end
		until true
	end
end

function var_0_0.RefreshCurTemplateExhibit(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	var_0_5 = {}
	var_0_5.userID = arg_9_2

	local var_9_0

	var_0_3 = arg_9_1.layout_uid

	local var_9_1 = BackHomeCfg[arg_9_1.architecture_id].type

	if var_9_1 == DormConst.BACKHOME_TYPE.PublicDorm then
		var_9_0 = DormConst.DORM_VISIT_LOBBY
	elseif var_9_1 == DormConst.BACKHOME_TYPE.PrivateDorm then
		var_9_0 = DormConst.DORM_VISIT_PRIVATE
	end

	local var_9_2 = DormitoryData:GetDormMapList()

	if var_9_0 then
		local var_9_3 = BackHomeCfg[var_9_0]

		var_0_5.roomInfo = RoomInfo.New()
		var_0_5.architecture_id = arg_9_1.architecture_id
		var_0_5.roomInfo.id = var_9_0
		var_0_5.roomInfo.sceneName = var_9_3.scene

		local var_9_4, var_9_5, var_9_6 = DormFurnitureTools:ResolverFurnitureInfo(arg_9_1.furniture_pos_list, var_9_0)

		var_0_5.specialFur = var_9_5
		var_0_5.suitInfo = var_9_6
		var_0_5.roomInfo.furnitureInfoS = var_9_4
		var_0_5.likeNum = arg_9_1.liked_num or 0
		var_0_5.todayLikeNum = arg_9_1.own_today_liked_num or 0
		var_0_5.sign = (arg_9_1.sign or ""):gsub("\n", "")

		local var_9_7 = {}
		local var_9_8 = {}
		local var_9_9 = {}

		if arg_9_1.skin_id_list then
			for iter_9_0, iter_9_1 in ipairs(arg_9_1.skin_id_list) do
				local var_9_10 = BackHomeHeroSkinCfg[iter_9_1].hero_id
				local var_9_11 = HeroRecordCfg.get_id_list_by_hero_id[var_9_10][1]

				var_9_7[var_9_11] = iter_9_1

				table.insert(var_9_8, var_9_10)
				table.insert(var_9_9, var_9_11)
			end
		end

		var_0_5.archiveIDList = var_9_9
		var_0_5.heroSkinDict = var_9_7
		var_0_5.visitNum = arg_9_1.visited_num or 0

		if not arg_9_3 then
			local var_9_12, var_9_13 = arg_9_0:GetExhibitListByUserID(arg_9_2)

			var_9_12.architecture_id = arg_9_1.architecture_id or var_9_12.architecture_id
			var_9_12.likeNum = arg_9_1.liked_num or 0
			var_9_12.visitNum = arg_9_1.visited_num or 0
			var_9_12.heroIDList = var_9_8
			var_0_5.friendType = var_9_13

			arg_9_0:SetIsOtherSystem(false)
		else
			local var_9_14 = ForeignInfoData:GetCurForeignDetailInfo()
			local var_9_15 = 2
			local var_9_16 = FriendsData:GetInfoByID(arg_9_2)

			if var_9_16 and var_9_16.relationship == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
				var_9_15 = 1
			end

			var_0_5.friendType = var_9_15
			var_9_14.backhome_architecture_id = arg_9_1.architecture_id or var_9_14.backhome_architecture_id
			var_9_14.hero_id_list = var_9_8
		end
	end

	var_9_2[var_9_0] = var_0_5
end

function var_0_0.CheckCanSaveTemplate(arg_10_0)
	if var_0_5 then
		if var_0_5.friendType ~= 1 then
			return false, "DORM_NEED_FRIEND_TEMPLATE_COPY"
		else
			return true
		end
	end
end

function var_0_0.SetCurTemplateExhibit(arg_11_0, arg_11_1)
	var_0_2 = arg_11_1
end

function var_0_0.GetCurTemplateExhibit(arg_12_0)
	if var_0_2 then
		return var_0_2
	end
end

function var_0_0.GetExhibitListByUserID(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in pairs(var_0_1) do
		local var_13_0 = iter_13_1[arg_13_1]

		if var_13_0 then
			return var_13_0, iter_13_0
		end
	end

	local var_13_1 = ForeignInfoData:GetCurForeignDetailInfo()

	if var_13_1.user_id == arg_13_1 then
		return var_13_1
	end
end

local var_0_6 = false
local var_0_7

function var_0_0.SetIsOtherSystem(arg_14_0, arg_14_1)
	var_0_6 = arg_14_1
end

function var_0_0.GetIsOtherSystem(arg_15_0)
	return var_0_6
end

function var_0_0.SetBackFunc(arg_16_0, arg_16_1)
	function var_0_7()
		BackHomeTools:OtherSystemVisitExit()
		arg_16_1()

		var_0_7 = nil
	end
end

function var_0_0.GetBackFunc(arg_18_0)
	return var_0_7
end

function var_0_0.GetCurVisitHeroList(arg_19_0)
	return var_0_5.archiveIDList
end

function var_0_0.GetCurVisitHeroSkinDict(arg_20_0)
	return var_0_5.heroSkinDict
end

function var_0_0.GetCurVisitHeroSkin(arg_21_0, arg_21_1)
	return var_0_5.heroSkinDict[arg_21_1]
end

function var_0_0.GetCurVisitPlayerType(arg_22_0)
	return var_0_5.friendType
end

function var_0_0.GetVisitUserID(arg_23_0)
	local var_23_0

	if var_0_5 then
		return var_0_5.userID
	end
end

function var_0_0.GetCurVisitRoomData(arg_24_0)
	return var_0_5
end

function var_0_0.ClearVisitRoomData(arg_25_0)
	local var_25_0 = DormitoryData:GetDormMapList()

	if var_25_0[DormConst.DORM_VISIT_LOBBY] then
		var_25_0[DormConst.DORM_VISIT_LOBBY] = nil
	end

	if var_25_0[DormConst.DORM_VISIT_PRIVATE] then
		var_25_0[DormConst.DORM_VISIT_PRIVATE] = nil
	end

	var_0_5 = nil
	var_0_3 = nil
end

function var_0_0.GetTodayLikeNum(arg_26_0)
	local var_26_0 = 0

	if var_0_5 then
		var_26_0 = var_0_5.todayLikeNum
	end

	return var_26_0
end

function var_0_0.Dispose(arg_27_0)
	var_0_1 = nil
end

return var_0_0
