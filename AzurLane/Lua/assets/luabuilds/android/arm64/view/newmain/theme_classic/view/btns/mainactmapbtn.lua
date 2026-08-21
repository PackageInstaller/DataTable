local var_0_0 = class("MainActMapBtn", import(".MainBaseActivityBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_map"
end

function var_0_0.GetActivity(arg_2_0)
	if arg_2_0.config and arg_2_0.config.time and arg_2_0.config.time[1] == "default" then
		local var_2_0 = getProxy(ActivityProxy):getActivityById(arg_2_0.config.time[2])

		if var_2_0 and not var_2_0:isEnd() then
			return var_2_0
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
	local var_5_1 = arg_5_0:GetActivity()
	local var_5_2 = var_5_1:getConfig("type")

	if var_5_0 == ActivityConst.OTHER_WORLD_TERMINAL_BATTLE_ID then
		return OtherworldMapScene.IsShowTip()
	elseif var_5_2 == ActivityConst.ACTIVITY_TYPE_BOSSRUSH or var_5_2 == ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB then
		return false
	elseif var_5_2 == ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
		local var_5_3 = getProxy(ActivityProxy):getActivityById(var_5_1:GetBindPtActID())

		if not var_5_3 then
			return false
		end

		return ActivityBossPtData.New(var_5_3):CanGetAward()
	elseif var_5_2 == ActivityConst.ACTIVITY_TYPE_TOWN2 then
		return false
	end

	local var_5_4 = getProxy(ChapterProxy):IsActivitySPChapterActive(var_5_0)

	var_5_4 = var_5_4 and SettingsProxy.IsShowActivityMapSPTip()

	return var_5_4
end

function var_0_0.CustomOnClick(arg_6_0)
	local var_6_0 = arg_6_0:GetActivity()

	if var_6_0 then
		local var_6_1 = var_6_0:getConfig("type")

		if var_6_1 == ActivityConst.ACTIVITY_TYPE_BOSSRUSH then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.BOSSRUSH_MAIN)
		elseif var_6_1 == ActivityConst.ACTIVITY_TYPE_ZPROJECT then
			arg_6_0:emit(NewMainMediator.SKIP_ACTIVITY_MAP, var_6_0.id)
		end
	end

	return
end

return var_0_0
