local MainActMapBtn = class("MainActMapBtn", import(".MainBaseActivityBtn"))

function MainActMapBtn:GetEventName()
	return "event_map"
end

function MainActMapBtn:GetActivity()
	if self.config and self.config.time and self.config.time[1] == "default" then
		local var_2_0 = getProxy(ActivityProxy):getActivityById(self.config.time[2])

		if var_2_0 and not var_2_0:isEnd() then
			return var_2_0
		end
	end

	return nil
end

function MainActMapBtn:GetActivityID()
	local var_3_0 = self:GetActivity()

	return var_3_0 and var_3_0.id
end

function MainActMapBtn:OnInit()
	setActive(self.tipTr.gameObject, self:IsShowTip())

	return
end

function MainActMapBtn:IsShowTip()
	local var_5_0 = self:GetActivityID()
	local var_5_1 = self:GetActivity()
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

function MainActMapBtn:CustomOnClick()
	local var_6_0 = self:GetActivity()

	if var_6_0 then
		local var_6_1 = var_6_0:getConfig("type")

		if var_6_1 == ActivityConst.ACTIVITY_TYPE_BOSSRUSH then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.BOSSRUSH_MAIN)
		elseif var_6_1 == ActivityConst.ACTIVITY_TYPE_ZPROJECT then
			self:emit(NewMainMediator.SKIP_ACTIVITY_MAP, var_6_0.id)
		end
	end

	return
end

return MainActMapBtn
