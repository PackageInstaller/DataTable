local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	return
end

function var_0_0.InitRedPointKey(arg_2_0)
	local var_2_0 = ActivitySkinDrawToolsOld.GetTaskActivityID(arg_2_0)
	local var_2_1 = RedPointConst.ACTIVITY_TASK .. "_" .. var_2_0
	local var_2_2 = ActivitySkinDrawToolsOld.GetScenePoolActivityID(arg_2_0)
	local var_2_3 = ActivitySkinDrawToolsOld.GetSceneID(var_2_2)

	if var_2_3 and var_2_3 ~= 0 then
		local var_2_4 = RedPointConst.SCENE .. "_" .. var_2_3

		manager.redPoint:addGroup(RedPointConst.ACTIVITY_DRAW .. "_" .. arg_2_0, {
			var_2_1,
			var_2_4
		})
	else
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_DRAW .. "_" .. arg_2_0, {
			var_2_1
		})
	end
end

function var_0_0.StartDraw(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {
		activity_id = arg_3_0,
		pool_id = arg_3_1,
		drop_type = arg_3_2
	}

	var_0_0.materialItem_ = {}

	local var_3_1 = {}
	local var_3_2 = ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[arg_3_1] or {}

	for iter_3_0, iter_3_1 in ipairs(var_3_2) do
		local var_3_3 = ActivityLimitedDrawPoolCfg[iter_3_1].reward[1][1]
		local var_3_4 = ItemCfg[var_3_3]

		if var_3_4.type == ItemConst.ITEM_TYPE.HERO_SKIN then
			if HeroTools.GetHasOwnedSkin(var_3_3) then
				table.insert(var_3_1, iter_3_1)
			end
		elseif var_3_4.type == ItemConst.ITEM_TYPE.SCENE then
			if HomeSceneSettingData:GetUsedState(var_3_3) == SceneConst.HOME_SCENE_TYPE.UNLOCK then
				table.insert(var_3_1, iter_3_1)
			end
		elseif var_3_4.type == ItemConst.ITEM_TYPE.FRAME then
			local var_3_5 = PlayerData:GetFrame(var_3_3)

			if var_3_5 and var_3_5.unlock == 1 and var_3_5.lasted_time == 0 then
				table.insert(var_3_1, iter_3_1)
			end
		elseif var_3_4.type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
			local var_3_6 = var_3_4.param[1]
			local var_3_7 = ChatStickerCfg[var_3_6]

			if var_3_7 and not (var_3_7.free == 0 and ChatStickerData:IsLockSticker(var_3_6) or false) then
				table.insert(var_3_1, iter_3_1)
			end
		else
			var_0_0.materialItem_[iter_3_1] = iter_3_1
		end
	end

	manager.net:SendWithLoadingNew(68152, var_3_0, 68153, function(arg_4_0)
		if isSuccess(arg_4_0.result) then
			local var_4_0 = arg_4_0.drop_list

			ActivitySkinDrawDataOld:RefreshData(arg_3_0, var_4_0)

			local var_4_1 = ActivityTools.GetMainActivityId(arg_3_0)
			local var_4_2 = {
				activityID = arg_3_0,
				mainActivityID = var_4_1,
				poolID = arg_3_1,
				draw_list = var_4_0,
				replaceList = var_3_1
			}

			JumpTools.OpenPageByJump("/activitySkinDrawStartOld", var_4_2)
		else
			ShowTips(arg_4_0.result)
		end
	end)
end

function var_0_0.GetIsCanReplace(arg_5_0)
	return var_0_0.materialItem_[arg_5_0] == nil
end

function var_0_0.RefreshRed(arg_6_0)
	local var_6_0 = ActivitySkinDrawToolsOld.GetSceneID(arg_6_0)

	if var_6_0 and var_6_0 ~= 0 then
		local var_6_1 = getData("scene", tostring(var_6_0)) or 0

		manager.redPoint:setTip(RedPointConst.SCENE .. "_" .. var_6_0, var_6_1)
	end
end

return var_0_0
