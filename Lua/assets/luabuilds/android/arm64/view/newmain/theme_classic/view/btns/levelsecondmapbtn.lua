local var_0_0 = class("LevelSecondMapBtn", import(".MainBaseActivityBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_second_map"
end

function var_0_0.GetActivity(arg_2_0)
	if arg_2_0.config and arg_2_0.config.time and arg_2_0.config.time[1] == "default" then
		local var_2_0 = getProxy(ActivityProxy):getActivityById(arg_2_0.config.time[2])

		if var_2_0 and not var_2_0:isEnd() then
			if arg_2_0.config.time[2] ~= getProxy(ActivityProxy):getEnterReadyActivity()[1] then
				return var_2_0
			end
		end
	end

	return nil
end

function var_0_0.GetActivityID(arg_3_0)
	local var_3_0 = arg_3_0:GetActivity()

	return var_3_0 and var_3_0.id
end

function var_0_0.OnInit(arg_4_0)
	setActive(arg_4_0.tipTr.gameObject, arg_4_0:IsShowTip())

	return
end

function var_0_0.IsShowTip(arg_5_0)
	local var_5_0 = arg_5_0:GetActivityID()

	if var_5_0 == ActivityConst.OTHER_WORLD_TERMINAL_BATTLE_ID then
		return OtherworldMapScene.IsShowTip()
	end

	local var_5_1 = getProxy(ChapterProxy):IsActivitySPChapterActive(var_5_0)

	var_5_1 = var_5_1 and SettingsProxy.IsShowActivityMapSPTip()

	return var_5_1
end

function var_0_0.CustomOnClick(arg_6_0)
	local var_6_0 = arg_6_0:GetActivity()

	if var_6_0 then
		switch(var_6_0:getConfig("type"), {
			[ActivityConst.ACTIVITY_TYPE_ZPROJECT] = function()
				arg_6_0:emit(LevelMediator2.ON_ACTIVITY_MAP, var_6_0.id)

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2] = function()
				arg_6_0:emit(LevelMediator2.ON_OPEN_ACT_BOSS_BATTLE)

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSSRUSH] = function()
				arg_6_0:emit(LevelMediator2.ON_BOSSRUSH_MAP)

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSSSINGLE] = function()
				arg_6_0:emit(LevelMediator2.ON_BOSSSINGLE_MAP, {
					mode = OtherworldMapScene.MODE_BATTLE
				})

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE] = function()
				arg_6_0:emit(LevelMediator2.ON_CLUE_MAP)

				return
			end
		})
	end

	return
end

function var_0_0.ResPath(arg_12_0)
	return "LinkButton_mellow"
end

return var_0_0
