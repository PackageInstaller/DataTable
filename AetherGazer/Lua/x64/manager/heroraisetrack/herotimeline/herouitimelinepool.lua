local var_0_0 = class("HeroUITimelinePool")
local var_0_1 = 4
local var_0_2 = "UICharTimeline"
local var_0_3 = "UITimeLine/Charactor"

function var_0_0.GetTimelineAction(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_1 == nil or arg_1_2 == nil or arg_1_3 == nil then
		Debug.LogError("无法获取Timeline 参数存在nil值")

		return nil, nil
	end

	local var_1_0 = arg_1_0:_LRU_Get(arg_1_1, arg_1_2, arg_1_3)

	if var_1_0 then
		if isNil(var_1_0.timelineGo) then
			table.removebyvalue(arg_1_0.timelineCache_, var_1_0)
			Asset.Unload(var_1_0.assetPath)
		else
			return var_1_0.playableDirector, var_1_0.timelineGo
		end
	end

	local var_1_1
	local var_1_2

	if string.find(arg_1_2, "_custom") then
		var_1_2 = arg_1_3
		var_1_1 = string.format("%s/%s/%s", var_0_3, arg_1_1, arg_1_3)
	else
		var_1_2 = string.format("%d_%s_p", arg_1_1, arg_1_3)
		var_1_1 = string.format("%s/%s/%s", var_0_2, arg_1_2, var_1_2)
	end

	local var_1_3 = Asset.Load(var_1_1)

	if var_1_3 == nil then
		Debug.LogError(string.format("无法读取Timeline %s %s: %s", arg_1_2, string.format("%d_%s", arg_1_1, arg_1_3), var_1_1))

		return nil, nil
	end

	local var_1_4 = Object.Instantiate(var_1_3)

	var_1_4.name = var_1_2

	local var_1_5 = var_1_4:GetComponent("PlayableDirector")

	if var_1_5 then
		local var_1_6 = {
			skinId = arg_1_1,
			modelId = arg_1_2,
			name = arg_1_3,
			timelineGo = var_1_4,
			playableDirector = var_1_5,
			assetPath = var_1_1
		}

		table.insert(arg_1_0.timelineCache_, var_1_6)
	end

	arg_1_0:Reserve(var_0_1)

	return var_1_5, var_1_4
end

function var_0_0.ReturnTimelineAction(arg_2_0, arg_2_1)
	if not isNil(arg_2_1) then
		SetActive(arg_2_1, false)
	end
end

function var_0_0.Cleanup(arg_3_0)
	arg_3_0:Reserve(0)
end

function var_0_0.Reserve(arg_4_0, arg_4_1)
	while arg_4_1 < #arg_4_0.timelineCache_ do
		local var_4_0 = table.remove(arg_4_0.timelineCache_, 1)

		if not isNil(var_4_0.timelineGo) then
			Object.Destroy(var_4_0.timelineGo)
		end

		Asset.Unload(var_4_0.assetPath)
	end
end

function var_0_0.Ctor(arg_5_0)
	arg_5_0.timelineCache_ = {}
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:Cleanup()

	arg_6_0.timelineCache_ = {}
end

function var_0_0._LRU_Get(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.timelineCache_) do
		if iter_7_1.name == arg_7_3 and iter_7_1.skinId == arg_7_1 and iter_7_1.modelId == arg_7_2 then
			table.removebyvalue(arg_7_0.timelineCache_, iter_7_1)
			table.insert(arg_7_0.timelineCache_, iter_7_1)

			return iter_7_1
		end
	end

	return nil
end

return var_0_0
