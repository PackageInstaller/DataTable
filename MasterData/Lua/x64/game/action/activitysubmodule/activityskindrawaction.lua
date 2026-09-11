local var_0_0 = {}
local var_0_1 = false

manager.net:Bind(68155, function(arg_1_0)
	if #arg_1_0.skin_id > 0 then
		for iter_1_0, iter_1_1 in ipairs(arg_1_0.skin_id) do
			ActivitySkinDrawData:UpdatePopListData(iter_1_1, true)
		end

		if not var_0_0.isInDraw then
			manager.notify:Invoke(ACTIVITY_SKIN_MEMORY_COIN_POP)
		end
	end
end)

function var_0_0.Init()
	ActivitySkinDrawData:Init()

	if var_0_1 then
		return
	end

	manager.net:Bind(68151, function(arg_3_0)
		if ActivityCfg.get_id_list_by_sub_activity_list[arg_3_0.activity_id][1] == 312211 then
			return
		end

		ActivitySkinDrawData:InitDrawData(arg_3_0)
		var_0_0.RefreshRed(arg_3_0.activity_id)
	end)
	manager.net:Bind(68161, function(arg_4_0)
		if ActivityCfg.get_id_list_by_sub_activity_list[arg_4_0.activity_id][1] == 312211 then
			return
		end

		ActivitySkinDrawData:InitStoryData(arg_4_0)
	end)

	var_0_1 = true
end

function var_0_0.InitRedPointKey(arg_5_0)
	local var_5_0

	if not arg_5_0 then
		do return end

		var_5_0 = {}
	end

	var_5_0[1] = RedPointConst.ACTIVITY_TASK .. "_" .. ActivitySkinDrawTools.GetTaskActivityID(arg_5_0)

	manager.redPoint:addGroup(RedPointConst.ACTIVITY_DRAW .. "_" .. arg_5_0, var_5_0)
end

function var_0_0.StartDraw(arg_6_0, arg_6_1, arg_6_2)
	var_0_0.materialItem_ = {}

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[arg_6_1] or {}) do
		if ItemCfg[ActivityLimitedDrawPoolCfg[iter_6_1].reward[1][1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			if HeroTools.GetHasOwnedSkin(ActivityLimitedDrawPoolCfg[iter_6_1].reward[1][1]) then
				table.insert(var_6_0, iter_6_1)
			end
		elseif ItemCfg[ActivityLimitedDrawPoolCfg[iter_6_1].reward[1][1]].type == ItemConst.ITEM_TYPE.SCENE then
			if HomeSceneSettingData:GetUsedState(ActivityLimitedDrawPoolCfg[iter_6_1].reward[1][1]) == SceneConst.HOME_SCENE_TYPE.UNLOCK then
				table.insert(var_6_0, iter_6_1)
			end
		elseif ItemCfg[ActivityLimitedDrawPoolCfg[iter_6_1].reward[1][1]].type == ItemConst.ITEM_TYPE.FRAME then
			local var_6_1 = PlayerData:GetFrame(ActivityLimitedDrawPoolCfg[iter_6_1].reward[1][1])

			if var_6_1 and var_6_1.unlock == 1 and var_6_1.lasted_time == 0 then
				table.insert(var_6_0, iter_6_1)
			end
		elseif ItemCfg[ActivityLimitedDrawPoolCfg[iter_6_1].reward[1][1]].type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
			if ChatStickerCfg[ItemCfg[ActivityLimitedDrawPoolCfg[iter_6_1].reward[1][1]].param[1]] then
				if not (ChatStickerCfg[ItemCfg[ActivityLimitedDrawPoolCfg[iter_6_1].reward[1][1]].param[1]].free == 0 and ChatStickerData:IsLockSticker(ItemCfg[ActivityLimitedDrawPoolCfg[iter_6_1].reward[1][1]].param[1]) or false) then
					table.insert(var_6_0, iter_6_1)
				end
			end
		else
			var_0_0.materialItem_[iter_6_1] = iter_6_1
		end
	end

	var_0_0.isInDraw = true

	manager.net:SendWithLoadingNew(68152, {
		activity_id = arg_6_0,
		pool_id = arg_6_1,
		drop_type = arg_6_2
	}, 68153, function(arg_7_0)
		var_0_0.isInDraw = false

		if isSuccess(arg_7_0.result) then
			JumpTools.OpenPageByJump("/activitySkinDrawStart", {
				activityID = arg_6_0,
				mainActivityID = ActivityTools.GetMainActivityId(arg_6_0),
				poolID = arg_6_1,
				draw_list = arg_7_0.drop_list,
				replaceList = var_6_0
			})
		else
			ShowTips(arg_7_0.result)
		end
	end)
end

function var_0_0.GetIsCanReplace(arg_8_0)
	return var_0_0.materialItem_[arg_8_0] == nil
end

function var_0_0.RefreshRed(arg_9_0)
	local var_9_0 = ActivitySkinDrawData:GetSceneId(arg_9_0)

	if var_9_0 and var_9_0 ~= 0 then
		manager.redPoint:setTip(RedPointConst.SCENE .. "_" .. var_9_0, getData("scene", tostring(var_9_0)) or 0)
	end
end

function var_0_0.SendFinishPop(arg_10_0, arg_10_1)
	manager.net:SendWithLoadingNew(68156, {
		skin_id = arg_10_1
	}, 68157, function(arg_11_0, arg_11_1)
		arg_10_0:OnSendFinishPop(arg_11_0, arg_11_1)
	end)
end

function var_0_0.OnSendFinishPop(arg_12_0, arg_12_1, arg_12_2)
	if isSuccess(arg_12_1.result) then
		local var_12_0 = ActivitySkinDrawTools.GetSkinDrawCfg((ActivitySkinDrawData:GetSkinDrawMainActivityBySkinID(arg_12_2.skin_id)))

		if var_12_0.story_item < 0 then
			return
		end

		getReward2({
			{
				num = 1,
				id = var_12_0.story_item
			}
		})
		ActivitySkinDrawData:UpdatePopListData(arg_12_2.skin_id, false)
	end
end

return var_0_0
