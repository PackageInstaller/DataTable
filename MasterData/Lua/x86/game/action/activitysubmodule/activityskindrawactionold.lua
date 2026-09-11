local var_0_0 = {}

function var_0_0.Init()
	return
end

function var_0_0.InitRedPointKey(arg_2_0)
	local var_2_0 = RedPointConst.ACTIVITY_TASK .. "_" .. ActivitySkinDrawToolsOld.GetTaskActivityID(arg_2_0)
	local var_2_1 = ActivitySkinDrawToolsOld.GetSceneID((ActivitySkinDrawToolsOld.GetScenePoolActivityID(arg_2_0)))

	if var_2_1 and var_2_1 ~= 0 then
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_DRAW .. "_" .. arg_2_0, {
			var_2_0,
			RedPointConst.SCENE .. "_" .. var_2_1
		})
	else
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_DRAW .. "_" .. arg_2_0, {
			var_2_0
		})
	end
end

function var_0_0.StartDraw(arg_3_0, arg_3_1, arg_3_2)
	var_0_0.materialItem_ = {}

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[arg_3_1] or {}) do
		if ItemCfg[ActivityLimitedDrawPoolCfg[iter_3_1].reward[1][1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			if HeroTools.GetHasOwnedSkin(ActivityLimitedDrawPoolCfg[iter_3_1].reward[1][1]) then
				table.insert(var_3_0, iter_3_1)
			end
		elseif ItemCfg[ActivityLimitedDrawPoolCfg[iter_3_1].reward[1][1]].type == ItemConst.ITEM_TYPE.SCENE then
			if HomeSceneSettingData:GetUsedState(ActivityLimitedDrawPoolCfg[iter_3_1].reward[1][1]) == SceneConst.HOME_SCENE_TYPE.UNLOCK then
				table.insert(var_3_0, iter_3_1)
			end
		elseif ItemCfg[ActivityLimitedDrawPoolCfg[iter_3_1].reward[1][1]].type == ItemConst.ITEM_TYPE.FRAME then
			local var_3_1 = PlayerData:GetFrame(ActivityLimitedDrawPoolCfg[iter_3_1].reward[1][1])

			if var_3_1 and var_3_1.unlock == 1 and var_3_1.lasted_time == 0 then
				table.insert(var_3_0, iter_3_1)
			end
		elseif ItemCfg[ActivityLimitedDrawPoolCfg[iter_3_1].reward[1][1]].type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
			if ChatStickerCfg[ItemCfg[ActivityLimitedDrawPoolCfg[iter_3_1].reward[1][1]].param[1]] then
				if not (ChatStickerCfg[ItemCfg[ActivityLimitedDrawPoolCfg[iter_3_1].reward[1][1]].param[1]].free == 0 and ChatStickerData:IsLockSticker(ItemCfg[ActivityLimitedDrawPoolCfg[iter_3_1].reward[1][1]].param[1]) or false) then
					table.insert(var_3_0, iter_3_1)
				end
			end
		else
			var_0_0.materialItem_[iter_3_1] = iter_3_1
		end
	end

	manager.net:SendWithLoadingNew(68152, {
		activity_id = arg_3_0,
		pool_id = arg_3_1,
		drop_type = arg_3_2
	}, 68153, function(arg_4_0)
		if isSuccess(arg_4_0.result) then
			ActivitySkinDrawDataOld:RefreshData(arg_3_0, arg_4_0.drop_list)
			JumpTools.OpenPageByJump("/activitySkinDrawStartOld", {
				activityID = arg_3_0,
				mainActivityID = ActivityTools.GetMainActivityId(arg_3_0),
				poolID = arg_3_1,
				draw_list = arg_4_0.drop_list,
				replaceList = var_3_0
			})
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
		manager.redPoint:setTip(RedPointConst.SCENE .. "_" .. var_6_0, getData("scene", tostring(var_6_0)) or 0)
	end
end

return var_0_0
