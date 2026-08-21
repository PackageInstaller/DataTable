local var_0_0 = {}
local var_0_1
local var_0_2

function var_0_0.SetFurListInMap(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	if arg_1_2 == nil then
		local var_1_0 = {}
		local var_1_1 = arg_1_3.furInfoList

		var_0_1 = arg_1_3.furInfoList

		local var_1_2 = {}
		local var_1_3 = {}
		local var_1_4 = {}
		local var_1_5 = {}
		local var_1_6 = {}
		local var_1_7 = {
			architecture_id = arg_1_1,
			furniture_layout = {
				temp_id = 0
			},
			picture_link = arg_1_4 or ""
		}

		for iter_1_0 = 0, var_1_1.Length - 1 do
			local var_1_8 = {
				furniture_id = var_1_1[iter_1_0].id,
				x = math.floor(var_1_1[iter_1_0].pos.x * DormConst.POS_PRECISION),
				y = math.floor(var_1_1[iter_1_0].pos.y * DormConst.POS_PRECISION),
				rotation = math.floor(var_1_1[iter_1_0].rotation * DormConst.POS_PRECISION)
			}

			if DormFurnitureTools:CheckFurTileType(var_1_1[iter_1_0].id, var_1_1[iter_1_0].tileType) then
				if var_1_1[iter_1_0].tileType == DormConst.TILE_TYPE.FLOOR then
					table.insert(var_1_6, var_1_8)
				elseif var_1_1[iter_1_0].tileType == DormConst.TILE_TYPE.WALL_LEFT then
					table.insert(var_1_2, var_1_8)
				elseif var_1_1[iter_1_0].tileType == DormConst.TILE_TYPE.WALL_RIGHT then
					table.insert(var_1_3, var_1_8)
				elseif var_1_1[iter_1_0].tileType == DormConst.TILE_TYPE.WALL_BEHIND then
					table.insert(var_1_5, var_1_8)
				elseif var_1_1[iter_1_0].tileType == DormConst.TILE_TYPE.WALL_FRONT then
					table.insert(var_1_4, var_1_8)
				end
			else
				var_0_1 = nil

				print("同步家具失败，" .. var_1_1[iter_1_0].id .. "家具所在地块和配置地块不匹配")

				return
			end
		end

		local var_1_9 = arg_1_3.specialInfo

		if var_1_9 then
			for iter_1_1, iter_1_2 in pairs(var_1_9) do
				local var_1_10 = {
					rotation = 0,
					x = 0,
					y = 0,
					furniture_id = iter_1_2
				}

				table.insert(var_1_6, var_1_10)
			end
		end

		if arg_1_3.suitInfo then
			var_0_2 = arg_1_3.suitInfo

			local var_1_11 = arg_1_3.suitInfo
			local var_1_12 = {}

			for iter_1_3, iter_1_4 in pairs(var_1_11) do
				if iter_1_3 > 1000 then
					local var_1_13 = {
						furniture_id = iter_1_3,
						x = math.floor(iter_1_4.pos.x * DormConst.POS_PRECISION),
						y = math.floor(iter_1_4.pos.y * DormConst.POS_PRECISION),
						rotation = math.floor(iter_1_4.pos.rotation * DormConst.POS_PRECISION)
					}

					table.insert(var_1_6, var_1_13)
					table.insert(var_1_12, iter_1_3)
				end
			end

			SDKTools.SendMessageToSDK("backhome_dorm_edit", {
				suit_list = var_1_12
			})
		end

		var_1_7.furniture_layout.furniture_pos_list = {
			{
				default_suit_id = 0,
				type = 1,
				furniture_pos = var_1_2
			},
			{
				default_suit_id = 0,
				type = 2,
				furniture_pos = var_1_3
			},
			{
				default_suit_id = 0,
				type = 3,
				furniture_pos = var_1_4
			},
			{
				default_suit_id = 0,
				type = 4,
				furniture_pos = var_1_5
			},
			{
				default_suit_id = 0,
				type = 5,
				furniture_pos = var_1_6
			}
		}

		if arg_1_3.suitInfo then
			local var_1_14 = arg_1_3.suitInfo
			local var_1_15 = 100

			for iter_1_5, iter_1_6 in pairs(var_1_14) do
				if iter_1_5 < 1000 then
					local var_1_16 = {
						type = var_1_15
					}
					local var_1_17 = {}

					for iter_1_7 = 0, iter_1_6.furList.Length - 1 do
						local var_1_18 = {
							furniture_id = iter_1_6.furList[iter_1_7].id,
							x = math.floor(iter_1_6.furList[iter_1_7].pos.x * DormConst.POS_PRECISION),
							y = math.floor(iter_1_6.furList[iter_1_7].pos.y * DormConst.POS_PRECISION),
							rotation = math.floor(iter_1_6.furList[iter_1_7].rotation * DormConst.POS_PRECISION)
						}

						table.insert(var_1_17, var_1_18)
					end

					var_1_16.furniture_pos = var_1_17

					if iter_1_6.oriSuitID then
						var_1_16.default_suit_id = iter_1_6.oriSuitID
					else
						var_1_16.default_suit_id = 0
					end

					var_1_15 = var_1_15 + 1

					table.insert(var_1_7.furniture_layout.furniture_pos_list, var_1_16)
				end
			end
		end

		if DormData:GetDevModelFlag() then
			local var_1_19 = DormSuitData:GetSuitSerializeData()
			local var_1_20 = clone(var_1_7.furniture_layout.furniture_pos_list)

			DormSuitTools:SerializeDormSuitData(var_1_20, var_1_19)
		end

		manager.net:SendWithLoadingNew(58010, var_1_7, 58011, var_0_0.SetFurListInMapCallBack)
	else
		manager.net:SendWithLoadingNew(58010, {
			architecture_id = arg_1_1,
			furniture_layout = {
				temp_id = arg_1_2,
				furniture_pos_list = {}
			},
			picture_link = arg_1_4 or ""
		}, 58011, var_0_0.SetFurListInMapCallBack)
	end
end

function var_0_0.SetFurListInMapCallBack(arg_2_0, arg_2_1)
	if isSuccess(arg_2_0.result) then
		local var_2_0

		if not var_0_1 then
			local var_2_1 = arg_2_1.furniture_layout.temp_id
			local var_2_2 = DormFurnitureTemplateData:GetDormTemplateInfo(var_2_1)

			var_0_1 = var_2_2:GetDormTemplateFurList()

			local var_2_3 = var_2_2:GetTemplateWallAndFloorInfo()

			var_2_0 = {}

			for iter_2_0, iter_2_1 in pairs(var_2_3) do
				local var_2_4 = {
					furniture_id = iter_2_1
				}

				table.insert(var_2_0, var_2_4)
			end
		end

		DormFurEditStateData:SyncRoomFurniture(arg_2_1, var_0_1, var_2_0, var_0_2)
		DormLuaBridge.SyncRoomFurniture(var_0_1)

		var_0_1 = nil
		var_0_2 = nil
	end
end

function var_0_0.UnLockDormArchitecture(arg_3_0, arg_3_1, arg_3_2)
	manager.net:SendWithLoadingNew(58130, {
		architecture_id = arg_3_1,
		pos_id = arg_3_2
	}, 58131, var_0_0.UnLockDormArchitectureCallBack)
end

function var_0_0.UnLockDormArchitectureCallBack(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		DormitoryData:UnLockDormArchitecture(arg_4_1.architecture_id, arg_4_1.pos_id)
		DormRedPointTools:CheckUnLockEntrustRedPoint()
		manager.notify:Invoke(DORM_PRIVATE_DORM_CHANGE, arg_4_1.architecture_id)
	else
		ShowTips(arg_4_0.result)
	end
end

local var_0_3

function var_0_0.DeployHeroInRoom(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	var_0_3 = arg_5_3

	manager.net:SendWithLoadingNew(58132, {
		architecture_id = arg_5_1,
		hero_id = arg_5_2
	}, 58133, var_0_0.DeployHeroInRoomCallBack)
end

function var_0_0.DeployHeroInRoomPromise(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	var_0_3 = arg_6_3

	local var_6_0 = {
		architecture_id = arg_6_1,
		hero_id = arg_6_2
	}

	manager.net:SendWithLoading(58132, var_6_0, 58133):next(function(arg_7_0)
		var_0_0.DeployHeroInRoomCallBack(arg_7_0, var_6_0)

		return arg_7_0
	end)
end

function var_0_0.DeployHeroInRoomCallBack(arg_8_0, arg_8_1)
	if isSuccess(arg_8_0.result) then
		if var_0_3 == DormEnum.DormDeployType.Place then
			DormData:RefreshInDormHeroInfo(arg_8_1.architecture_id, arg_8_1.hero_id)
			manager.notify:Invoke(DORM_DRAG_HERO_SUCCESS)
			manager.notify:Invoke(DORM_REGENERATE_HERO)
			manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
		elseif var_0_3 == DormEnum.DormDeployType.ReCall then
			DormData:RefreshInDormHeroInfo(arg_8_1.architecture_id, arg_8_1.hero_id)
			manager.notify:Invoke(DORM_REGENERATE_HERO)
			manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
		elseif var_0_3 == DormEnum.DormDeployType.Occupy then
			DormData:RefreshInDormHeroInfo(arg_8_1.architecture_id, arg_8_1.hero_id, true)

			local var_8_0 = arg_8_1.hero_id[1]
			local var_8_1 = DormData:GetHeroArchiveID(var_8_0)

			DormData:GetHeroInfo(var_8_1):InitHeroRoomID(arg_8_1.architecture_id)
			DormRoomTools:GetDormLevelAward(var_8_1, 0, 1)
			DormitoryData:UpdatePrivateDormRedPoint()

			local var_8_2 = DormitoryData:GetDormLevel(arg_8_1.architecture_id)

			DormRoomTools:RefreshDormExp(arg_8_1.architecture_id)

			local var_8_3 = DormitoryData:GetDormLevel(arg_8_1.architecture_id)

			if var_8_2 ~= var_8_3 then
				DormRoomTools:GetDormLevelAward(var_8_1, var_8_2, var_8_3)
				manager.notify:Invoke(DORM_PRIVATE_LEVEL_UP, arg_8_1.architecture_id, var_8_1)
			end

			manager.notify:Invoke(DORM_HERO_OCCUPY, {
				var_8_1
			})
		end

		var_0_3 = nil
	else
		ShowTips(arg_8_0.result)
	end
end

function var_0_0.RecallHeroInPrivateDorm(arg_9_0, arg_9_1, arg_9_2)
	manager.net:SendWithLoadingNew(58134, {
		architecture_id = arg_9_1,
		hero_id = arg_9_2
	}, 58135, var_0_0.RecallHeroInPrivateDormCallBack)
end

function var_0_0.RecallHeroInPrivateDormCallBack(arg_10_0, arg_10_1)
	if isSuccess(arg_10_0.result) then
		local var_10_0 = DormitoryData:GetDormMapList()[arg_10_1.architecture_id].archiveIDList[1]
		local var_10_1 = 0

		for iter_10_0, iter_10_1 in ipairs(BackHomeCfg.all) do
			if BackHomeCfg[iter_10_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
				var_10_1 = iter_10_1

				break
			end
		end

		local var_10_2 = DormitoryData:GetDormSceneData(var_10_1)

		for iter_10_2 = 1, #var_10_2.archiveIDList do
			if var_10_2.archiveIDList[iter_10_2] == var_10_0 then
				table.remove(var_10_2.archiveIDList, iter_10_2)

				break
			end
		end

		DormData:RefreshInDormHeroInfo(arg_10_1.architecture_id, {
			arg_10_1.hero_id
		})
		manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
	else
		ShowTips(arg_10_0.result)
	end
end

local var_0_4

function var_0_0.GiftFurToHero(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {}

	var_0_4 = arg_11_3

	for iter_11_0, iter_11_1 in pairs(arg_11_2) do
		if iter_11_1 > 0 then
			local var_11_1 = {
				id = iter_11_0,
				num = iter_11_1
			}

			table.insert(var_11_0, var_11_1)
		end
	end

	if #var_11_0 <= 0 then
		return
	end

	manager.net:SendWithLoadingNew(58136, {
		hero_id = arg_11_1,
		furniture = var_11_0
	}, 58137, var_0_0.GiftFurToHeroCallBack)
end

function var_0_0.GiftFurToHeroCallBack(arg_12_0, arg_12_1)
	if isSuccess(arg_12_0.result) then
		local var_12_0 = arg_12_1.hero_id
		local var_12_1 = DormData:GetHeroTemplateInfo(var_12_0)
		local var_12_2 = DormRoomTools:GetDormIDViaArchive(var_12_0)

		for iter_12_0, iter_12_1 in ipairs(arg_12_1.furniture) do
			local var_12_3 = iter_12_1.id
			local var_12_4 = iter_12_1.num

			var_12_1:GiftFur(var_12_3, var_12_4, var_0_4)
		end

		var_0_4 = nil

		if not var_12_2 then
			Debug.LogError("未获取到场景id")

			return
		end

		manager.notify:Invoke(DORM_REFRESH_GIFT_FUR_LIST, arg_12_1.furniture)

		local var_12_5 = DormitoryData:GetDormLevel(var_12_2)

		DormRoomTools:RefreshDormExp(var_12_2)

		local var_12_6 = DormitoryData:GetDormLevel(var_12_2)

		if var_12_5 ~= var_12_6 then
			DormRoomTools:GetDormLevelAward(var_12_0, var_12_5, var_12_6)
			manager.notify:Invoke(DORM_PRIVATE_LEVEL_UP, var_12_2, var_12_0)
		end
	else
		ShowTips(arg_12_0.result)
	end
end

function var_0_0.GiftFoodToHero(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	manager.net:SendWithLoadingNew(58138, {
		type = arg_13_3,
		hero_id = arg_13_3 == 1 and 0 or arg_13_1
	}, 58139, var_0_0.GiftFoodToHeroCallBack(arg_13_4, arg_13_1, arg_13_2, arg_13_5))
end

function var_0_0.GiftFoodToHeroCallBack(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	return function(arg_15_0, arg_15_1)
		if isSuccess(arg_15_0.result) then
			if arg_14_0 then
				arg_14_0(arg_15_1.type, arg_14_1, arg_14_2)
			end

			for iter_15_0, iter_15_1 in ipairs(arg_15_0.fatigue_list) do
				local var_15_0 = DormData:GetHeroInfo(iter_15_1.archives_id)

				if var_15_0:GetFatigue() ~= iter_15_1.fatigue then
					var_15_0:FeedFoodTime(1)
				end

				var_15_0:SetFatigue(iter_15_1.fatigue)
			end

			manager.notify:Invoke(BACKHOME_HERO_FATIGUR_REFRESH)
		elseif arg_14_3 then
			arg_14_3()
		else
			ShowTips(arg_15_0.result)
		end
	end
end

function var_0_0.SaveFurTemplate(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8)
	local var_16_0

	if arg_16_8 then
		var_16_0 = {
			user_id = arg_16_8.user_id or PlayerData.INVALID_PLAYER,
			layout_uid = tonumber(arg_16_8.layout_uid) or 0
		}
	end

	local var_16_1 = {
		id = arg_16_1,
		type = arg_16_2,
		name = arg_16_3,
		architecture_id = arg_16_4,
		furniture_pos_list = {},
		pos = arg_16_6,
		host_info = var_16_0
	}

	if arg_16_4 == 0 or arg_16_4 > 1000 then
		var_16_1.architecture_id = 0

		local var_16_2, var_16_3, var_16_4, var_16_5, var_16_6, var_16_7 = arg_16_0:SwitchFurInfoToLayout(arg_16_5)

		if var_16_7 then
			for iter_16_0, iter_16_1 in pairs(arg_16_7) do
				if iter_16_1 then
					local var_16_8 = {
						rotation = 0,
						x = 0,
						y = 0,
						furniture_id = iter_16_1
					}

					table.insert(var_16_6, var_16_8)
				end
			end

			var_16_1.furniture_pos_list = {
				{
					default_suit_id = 0,
					type = 1,
					furniture_pos = var_16_2
				},
				{
					default_suit_id = 0,
					type = 2,
					furniture_pos = var_16_3
				},
				{
					default_suit_id = 0,
					type = 3,
					furniture_pos = var_16_4
				},
				{
					default_suit_id = 0,
					type = 4,
					furniture_pos = var_16_5
				},
				{
					default_suit_id = 0,
					type = 5,
					furniture_pos = var_16_6
				}
			}
		else
			print("家具所在墙面类型错误")

			return
		end
	end

	manager.net:SendWithLoadingNew(58040, var_16_1, 58041, var_0_0.SaveFurTemplateCallBack)
end

function var_0_0.SwitchFurInfoToLayout(arg_17_0, arg_17_1)
	local var_17_0 = {}
	local var_17_1 = {}
	local var_17_2 = {}
	local var_17_3 = {}
	local var_17_4 = {}
	local var_17_5 = true

	for iter_17_0 = 0, arg_17_1.Length - 1 do
		local var_17_6 = {
			furniture_id = arg_17_1[iter_17_0].id,
			x = math.floor(arg_17_1[iter_17_0].pos.x * DormConst.POS_PRECISION),
			y = math.floor(arg_17_1[iter_17_0].pos.y * DormConst.POS_PRECISION),
			rotation = math.floor(arg_17_1[iter_17_0].rotation * DormConst.POS_PRECISION)
		}

		if DormFurnitureTools:CheckFurTileType(arg_17_1[iter_17_0].id, arg_17_1[iter_17_0].tileType) then
			if arg_17_1[iter_17_0].tileType == DormConst.TILE_TYPE.FLOOR then
				table.insert(var_17_4, var_17_6)
			elseif arg_17_1[iter_17_0].tileType == DormConst.TILE_TYPE.WALL_LEFT then
				table.insert(var_17_0, var_17_6)
			elseif arg_17_1[iter_17_0].tileType == DormConst.TILE_TYPE.WALL_RIGHT then
				table.insert(var_17_1, var_17_6)
			elseif arg_17_1[iter_17_0].tileType == DormConst.TILE_TYPE.WALL_BEHIND then
				table.insert(var_17_2, var_17_6)
			elseif arg_17_1[iter_17_0].tileType == DormConst.TILE_TYPE.WALL_FRONT then
				table.insert(var_17_3, var_17_6)
			end
		else
			var_17_5 = false

			break
		end
	end

	return var_17_0, var_17_1, var_17_2, var_17_3, var_17_4, var_17_5
end

function var_0_0.SaveFurTemplateCallBack(arg_18_0, arg_18_1)
	if isSuccess(arg_18_0.result) then
		DormFurnitureTemplateData:SaveFurTemplateInfo(arg_18_1)
		manager.notify:Invoke(DORM_TEMPLATE_CHANGE)
		ShowTips(GetTips("DORM_MOULD_SAVE_SUCCESS"))
	else
		ShowTips(arg_18_0.result)
	end
end

function var_0_0.ReviseFurTemplateName(arg_19_0, arg_19_1, arg_19_2)
	manager.net:SendWithLoadingNew(58142, {
		id = arg_19_1,
		name = arg_19_2
	}, 58143, var_0_0.ReviseFurTemplateNameCallBack)
end

function var_0_0.ReviseFurTemplateNameCallBack(arg_20_0, arg_20_1)
	if isSuccess(arg_20_0.result) then
		local var_20_0 = DormFurnitureTemplateData:GetDormTemplateInfo(arg_20_1.id)
		local var_20_1 = arg_20_1.name

		var_20_0:ReviseFurTemplateNameInfo(var_20_1)
		manager.notify:Invoke(DOMR_RENAME_TEMPLATE_SUCCESS)
	else
		ShowTips(arg_20_0.result)
	end
end

function var_0_0.DeleteFurTemplate(arg_21_0, arg_21_1)
	manager.net:SendWithLoadingNew(58144, {
		id = arg_21_1
	}, 58145, var_0_0.DeleteFurTemplateCallBack)
end

function var_0_0.DeleteFurTemplateCallBack(arg_22_0, arg_22_1)
	if isSuccess(arg_22_0.result) then
		DormFurnitureTemplateData:DeleteDormTemplateInfo(arg_22_1.id)
		manager.notify:Invoke(DORM_TEMPLATE_CHANGE)
	else
		ShowTips(arg_22_0.result)
	end
end

function var_0_0.RevisePrivateDormPos(arg_23_0, arg_23_1)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		local var_23_1 = {
			architecture_id = iter_23_1.roomID,
			pos_id = iter_23_1.posID
		}

		table.insert(var_23_0, var_23_1)
	end

	manager.net:SendWithLoadingNew(58146, {
		dorm_pos_list = var_23_0
	}, 58147, var_0_0.RevisePrivateDormPosCallBack)
end

function var_0_0.RevisePrivateDormPosCallBack(arg_24_0, arg_24_1)
	if isSuccess(arg_24_0.result) then
		DormitoryData:RevisePrivateDormPosData(arg_24_1)
	else
		ShowTips(arg_24_0.result)
	end
end

function var_0_0.AskFurTemplateExhibitList(arg_25_0, arg_25_1)
	manager.net:SendWithLoadingNew(58148, {
		type = arg_25_1
	}, 58149, var_0_0.AskFurTemplateExhibitListCallBack)
end

function var_0_0.AskFurTemplateExhibitListCallBack(arg_26_0, arg_26_1)
	if isSuccess(arg_26_0.result) then
		DormVisitTools:RefreshTemplateExhibit(arg_26_0.exhibition_brief, arg_26_1.type)
		manager.notify:Invoke(DORM_REFRESH_TEMPLATE_EXHI, #arg_26_0.exhibition_brief, arg_26_1.type)
	else
		ShowTips(arg_26_0.result)
	end
end

local var_0_5

function var_0_0.AskSingleFurTemplateExhibit(arg_27_0, arg_27_1)
	var_0_5 = arg_27_1

	local function var_27_0()
		local var_28_0 = {
			user_id = arg_27_1
		}

		manager.net:SendWithLoadingNew(58050, var_28_0, 58051, function(arg_29_0)
			if isSuccess(arg_29_0.result) then
				DormVisitTools:RefreshCurTemplateExhibit(arg_29_0, arg_27_1, false)

				if arg_29_0.architecture_id then
					local var_29_0 = BackHomeCfg[arg_29_0.architecture_id].type

					if var_29_0 == DormConst.BACKHOME_TYPE.PublicDorm then
						BackHomeDataManager:GotoBackHomeScene(DormConst.DORM_VISIT_LOBBY)
					elseif var_29_0 == DormConst.BACKHOME_TYPE.PrivateDorm then
						BackHomeDataManager:GotoBackHomeScene(DormConst.DORM_VISIT_PRIVATE)
					end
				end
			else
				ShowTips(arg_29_0.result)
			end
		end)
	end

	BackHomeAction:GetAllDetailInfo(var_27_0)
end

function var_0_0.OtherSystemAskSingleFurTemplateExhibit(arg_30_0, arg_30_1)
	local function var_30_0()
		local var_31_0 = {
			user_id = arg_30_1
		}

		manager.net:SendWithLoadingNew(58050, var_31_0, 58051, function(arg_32_0)
			if isSuccess(arg_32_0.result) then
				DormVisitTools:RefreshCurTemplateExhibit(arg_32_0, arg_30_1, true)

				if arg_32_0.architecture_id then
					local var_32_0 = BackHomeCfg[arg_32_0.architecture_id].type

					if var_32_0 == DormConst.BACKHOME_TYPE.PublicDorm then
						BackHomeDataManager:GotoBackHomeScene(DormConst.DORM_VISIT_LOBBY)
					elseif var_32_0 == DormConst.BACKHOME_TYPE.PrivateDorm then
						BackHomeDataManager:GotoBackHomeScene(DormConst.DORM_VISIT_PRIVATE)
					end
				end
			else
				ShowTips(arg_32_0.result)
			end
		end)
	end

	BackHomeAction:GetAllDetailInfo(var_30_0)
end

function var_0_0.SetFurTemplateExhibit(arg_33_0, arg_33_1, arg_33_2)
	manager.net:SendWithLoadingNew(58152, {
		architecture_id = arg_33_1,
		picture_link = arg_33_2 or ""
	}, 58153, var_0_0.SetFurTemplateExhibitCallBack)
end

function var_0_0.SetFurTemplateExhibitCallBack(arg_34_0, arg_34_1)
	if isSuccess(arg_34_0.result) then
		DormVisitTools:SetCurTemplateExhibit(arg_34_1.architecture_id)
		manager.notify:Invoke(DORM_REFRESH_EXIBIT)
	else
		ShowTips(arg_34_0.result)
	end
end

function var_0_0.WatchTheatre(arg_35_0, arg_35_1)
	manager.net:SendWithLoadingNew(58128, {
		theatrical_id = arg_35_1
	}, 58129, var_0_0.WatchTheatreCallBack)
end

function var_0_0.WatchTheatreCallBack(arg_36_0, arg_36_1)
	if isSuccess(arg_36_0.result) then
		manager.notify:Invoke(DORM_BIRTHDAY_THEATRE_WATCHED, arg_36_1.theatrical_id)
	else
		ShowTips(arg_36_0.result)
	end
end

function var_0_0.SettlementRhythmGame(arg_37_0, arg_37_1)
	manager.net:SendWithLoadingNew(58154, {
		stage_id = arg_37_1.stage_id,
		percentage_complete = arg_37_1.percentage_complete,
		hero_id = arg_37_1.hero_id
	}, 58155, var_0_0.SettlementRhythmGameCallBack)
end

function var_0_0.SettlementRhythmGameCallBack(arg_38_0, arg_38_1)
	if isSuccess(arg_38_0.result) then
		DormData:GetHeroTemplateInfo(arg_38_1.hero_id):SetFatigue(arg_38_0.fatigue)
		manager.notify:Invoke(BACKHOME_HERO_FATIGUR_REFRESH)

		local var_38_0 = {}

		for iter_38_0, iter_38_1 in ipairs(arg_38_0.reward_list) do
			local var_38_1 = {
				id = iter_38_1.id,
				num = iter_38_1.num
			}

			table.insert(var_38_0, var_38_1)
		end

		if var_38_0[1] then
			DormitoryData:AddDailCurrencyNum(var_38_0[1].num)
		else
			DormitoryData:AddDailCurrencyNum(0)
		end

		manager.notify:Invoke(DORM_STOP_RHYTHM_GAME, true, var_38_0 or {})
	else
		ShowTips(arg_38_0.result)
	end
end

function var_0_0.SetHeroSkin(arg_39_0, arg_39_1, arg_39_2)
	if BackHomeHeroSkinCfg[arg_39_1] then
		local var_39_0 = BackHomeHeroSkinCfg[arg_39_1].hero_id
		local var_39_1 = {
			hero_id = var_39_0,
			skin_id = arg_39_1,
			source = arg_39_2
		}

		manager.net:SendWithLoadingNew(58126, var_39_1, 58127, var_0_0.SetHeroSkinCallBack)
	else
		print("不存在的皮肤配置信息" .. arg_39_1)
	end
end

function var_0_0.SetHeroSkinCallBack(arg_40_0, arg_40_1)
	if isSuccess(arg_40_0.result) then
		local var_40_0 = arg_40_1.skin_id
		local var_40_1 = BackHomeHeroSkinCfg[var_40_0].hero_id

		DormData:GetHeroTemplateInfo(var_40_1):SetHeroSkinID(var_40_1, var_40_0)
		manager.notify:Invoke(DORM_HERO_SKIN_CHANGE, var_40_0)
		ShowTips("DORM_HERO_SKIN_CHANGE_SUCCESS")
	else
		ShowTips(arg_40_0.result)
	end
end

manager.net:Bind(58157, function(arg_41_0)
	DormSuitData:RefreshUnLockSuitList(arg_41_0.suit_id_list)
end)

function var_0_0.SetFurnitureTemplatCanSave(arg_42_0)
	manager.net:SendWithLoadingNew(58158, {
		is_open = arg_42_0
	}, 58159, var_0_0.SetFurnitureTemplatCanSaveCallBack)
end

function var_0_0.SetFurnitureTemplatCanSaveCallBack(arg_43_0, arg_43_1)
	if isSuccess(arg_43_0.result) then
		DormFurnitureTemplateData:SetOtherCanSave(arg_43_1.is_open)
		manager.notify:Invoke(DOMR_SAVE_FLAG_CHANGE)
	else
		ShowTips(arg_43_0.result)
	end
end

function var_0_0.ModifyFurniture(arg_44_0, arg_44_1, arg_44_2)
	DormData:AddFurTotalNum(arg_44_0, arg_44_1, arg_44_2)
end

function var_0_0.LikeDormRoom(arg_45_0, arg_45_1, arg_45_2)
	manager.net:SendWithLoadingNew(58052, {
		user_id = arg_45_0,
		architecture_id = arg_45_1
	}, 58053, function(arg_46_0, arg_46_1)
		if isSuccess(arg_46_0.result) then
			local var_46_0, var_46_1 = DormVisitTools:GetExhibitListByUserID(arg_45_0)

			if var_46_0 and var_46_1 then
				var_46_0.likeNum = var_46_0.likeNum + 1
			end

			local var_46_2 = DormVisitTools:GetCurVisitRoomData()

			var_46_2.likeNum = var_46_2.likeNum + 1
			var_46_2.todayLikeNum = var_46_2.todayLikeNum + 1

			manager.notify:Invoke(DORM_LIKE_NUM_REFRESH)

			if arg_45_2 then
				arg_45_2(arg_46_0, arg_46_1)
			end
		else
			ShowTips(arg_46_0.result)
		end
	end)
end

function var_0_0.AskDormRoomLikeNum(arg_47_0, arg_47_1)
	manager.net:SendWithLoadingNew(58054, {
		architecture_id = arg_47_0
	}, 58055, function(arg_48_0, arg_48_1)
		if isSuccess(arg_48_0.result) then
			local var_48_0 = DormitoryData:GetDormSceneData(arg_48_1.architecture_id)

			if var_48_0 then
				var_48_0.likeNum = arg_48_0.liked_num
			end

			manager.notify:Invoke(DORM_LIKE_NUM_REFRESH)

			if arg_47_1 then
				arg_47_1()
			end
		else
			ShowTips(arg_48_0.result)
		end
	end)
end

manager.net:Bind(58063, function(arg_49_0)
	DormInfomationData:RefreshData(arg_49_0)
end)

return var_0_0
