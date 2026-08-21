local var_0_0 = singletonClass("QWorldData")
local var_0_1
local var_0_2
local var_0_3
local var_0_4
local var_0_5
local var_0_6
local var_0_7
local var_0_8

function var_0_0.Init(arg_1_0)
	var_0_1 = false
	var_0_2 = {}
	var_0_3 = 0
	var_0_4 = 0
	var_0_2[var_0_3] = {
		position = {},
		rotation = {},
		cameraPosition = {},
		cameraRotation = {}
	}
	var_0_7 = {
		hintsQueue = {},
		displayDuration = SandplaySettingCfg.pop_hint_display.value[1],
		intervalDuration = SandplaySettingCfg.pop_hint_interval.value[1]
	}
	var_0_8 = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.stage_list) do
		local var_2_0 = iter_2_1.stage_id
		local var_2_1 = clone(var_0_2[0])

		var_2_1.position = Vector3.New(iter_2_1.position_x, iter_2_1.position_y, iter_2_1.position_z)
		var_2_1.rotation = Quaternion.New(iter_2_1.rotation_x, iter_2_1.rotation_y, iter_2_1.rotation_z, iter_2_1.rotation_w)
		var_0_2[var_2_0] = var_2_1
	end
end

function var_0_0.InitUnlockFunction(arg_3_0, arg_3_1)
	arg_3_0.unLockFunctionIdList_ = arg_3_1.sys_id_list or {}
end

function var_0_0.GetQWorldContext(arg_4_0)
	return var_0_2[var_0_3]
end

function var_0_0.GetQWorldContextByMapId(arg_5_0, arg_5_1)
	return var_0_2[arg_5_1]
end

function var_0_0.SetQWorldContext(arg_6_0, ...)
	local var_6_0 = arg_6_0:GetQWorldContext()

	if not var_6_0 then
		var_6_0 = clone(var_0_2[0])
		var_0_2[var_0_3] = var_6_0
	end

	local var_6_1 = ...

	var_6_0.position = var_6_1.position or var_6_0.position
	var_6_0.rotation = var_6_1.rotation or var_6_0.rotation
	var_6_0.cameraPosition = var_6_1.cameraPosition or var_6_0.cameraPosition
	var_6_0.cameraRotation = var_6_1.cameraRotation or var_6_0.cameraRotation
	var_6_0.cacheTag = var_6_1.cacheTag or var_6_0.cacheTag
end

function var_0_0.GetCachedPosition(arg_7_0)
	if not arg_7_0:GetQWorldContext() then
		return {
			0,
			0,
			0
		}
	end

	local var_7_0 = arg_7_0:GetQWorldContext().position

	if var_7_0 and var_7_0.x then
		return {
			var_7_0.x,
			var_7_0.y,
			var_7_0.z
		}
	end

	return {
		0,
		0,
		0
	}
end

function var_0_0.GetCurMapId(arg_8_0)
	return var_0_3
end

function var_0_0.SetCurMapId(arg_9_0, arg_9_1)
	var_0_3 = arg_9_1
end

function var_0_0.SetCurActivityId(arg_10_0, arg_10_1)
	var_0_4 = arg_10_1
end

function var_0_0.GetCurActivityId(arg_11_0)
	return var_0_4
end

function var_0_0.SetCurSceneName(arg_12_0, arg_12_1)
	var_0_5 = arg_12_1
end

function var_0_0.GetCurSceneName(arg_13_0)
	return var_0_5
end

function var_0_0.SetCurHomeBgmId(arg_14_0, arg_14_1)
	var_0_6 = arg_14_1
end

function var_0_0.GetCurHomeBgmId(arg_15_0)
	return var_0_6 or 0
end

function var_0_0.SetIsBackQWorld(arg_16_0, arg_16_1)
	var_0_1 = arg_16_1
end

function var_0_0.GetIsBackQWorld(arg_17_0)
	return var_0_1
end

function var_0_0.SetCacheTag(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:GetQWorldContext()

	if not var_18_0 then
		return
	end

	var_18_0.cacheTag = arg_18_1
end

function var_0_0.GetCacheTag(arg_19_0)
	local var_19_0 = arg_19_0:GetQWorldContext()

	if not var_19_0 then
		return
	end

	return var_19_0.cacheTag
end

function var_0_0.ClearIsBack(arg_20_0)
	local var_20_0 = arg_20_0:GetQWorldContext()

	if var_20_0 then
		var_20_0.cacheTag = nil
	end

	var_0_1 = false
end

function var_0_0.GetHintData(arg_21_0)
	return var_0_7
end

function var_0_0.AddHint(arg_22_0, arg_22_1)
	table.insert(var_0_7.hintsQueue, arg_22_1)
	manager.notify:Invoke(QWORLD_HINT_UPDATE)
end

function var_0_0.PopHint(arg_23_0)
	return table.remove(var_0_7.hintsQueue, 1)
end

function var_0_0.HasHints(arg_24_0)
	return #var_0_7.hintsQueue > 0
end

function var_0_0.AddItemHint(arg_25_0, arg_25_1)
	table.insert(var_0_8, arg_25_1)
	manager.notify:Invoke(QWORLD_HINT_UPDATE)
end

function var_0_0.GetItemHintList(arg_26_0)
	if #var_0_8 < 1 then
		return nil
	else
		local var_26_0 = var_0_8

		var_0_8 = {}

		return var_26_0
	end
end

function var_0_0.HasItemHints(arg_27_0)
	return #var_0_8 > 0
end

function var_0_0.CleanHintDataQuque(arg_28_0)
	var_0_7.hintsQueue = {}
	var_0_8 = {}
end

function var_0_0.AddUnlockFunction(arg_29_0, arg_29_1)
	table.insert(arg_29_0.unLockFunctionIdList_, arg_29_1)
end

function var_0_0.IsUnlockFunction(arg_30_0, arg_30_1)
	return table.indexof(arg_30_0.unLockFunctionIdList_, arg_30_1)
end

function var_0_0.GetNowPhaseId(arg_31_0)
	local var_31_0 = 1

	for iter_31_0 = 2, #QuanzhouPhaseCfg.all do
		if QuanzhouPhaseCfg[iter_31_0].task_id ~= 0 and (QWorldQuestTool.GetQuestStatus(QuanzhouPhaseCfg[iter_31_0].task_id) == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS or QWorldQuestTool.IsSubQuestFinish(QuanzhouPhaseCfg[iter_31_0].task_id)) then
			var_31_0 = QuanzhouPhaseCfg.all[iter_31_0]
		end
	end

	return var_31_0
end

return var_0_0
