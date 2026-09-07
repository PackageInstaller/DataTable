local LevelSecondMapBtn = class("LevelSecondMapBtn", import(".MainBaseActivityBtn"))

function LevelSecondMapBtn:GetEventName()
	return "event_second_map"
end

function LevelSecondMapBtn:GetActivity()
	if self.config and self.config.time and self.config.time[1] == "default" then
		local var_2_0 = getProxy(ActivityProxy):getActivityById(self.config.time[2])

		if var_2_0 and not var_2_0:isEnd() then
			if self.config.time[2] ~= getProxy(ActivityProxy):getEnterReadyActivity()[1] then
				return var_2_0
			end
		end
	end

	return nil
end

function LevelSecondMapBtn:GetActivityID()
	local var_3_0 = self:GetActivity()

	return var_3_0 and var_3_0.id
end

function LevelSecondMapBtn:OnInit()
	setActive(self.tipTr.gameObject, self:IsShowTip())

	return
end

function LevelSecondMapBtn:IsShowTip()
	local var_5_0 = self:GetActivityID()

	if var_5_0 == ActivityConst.OTHER_WORLD_TERMINAL_BATTLE_ID then
		return OtherworldMapScene.IsShowTip()
	end

	local var_5_1 = getProxy(ChapterProxy):IsActivitySPChapterActive(var_5_0)

	var_5_1 = var_5_1 and SettingsProxy.IsShowActivityMapSPTip()

	return var_5_1
end

function LevelSecondMapBtn:CustomOnClick()
	local var_6_0 = self:GetActivity()

	if var_6_0 then
		switch(var_6_0:getConfig("type"), {
			[ActivityConst.ACTIVITY_TYPE_ZPROJECT] = function()
				self:emit(LevelMediator2.ON_ACTIVITY_MAP, var_6_0.id)

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2] = function()
				self:emit(LevelMediator2.ON_OPEN_ACT_BOSS_BATTLE)

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSSRUSH] = function()
				self:emit(LevelMediator2.ON_BOSSRUSH_MAP)

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSSSINGLE] = function()
				self:emit(LevelMediator2.ON_BOSSSINGLE_MAP, {
					mode = OtherworldMapScene.MODE_BATTLE
				})

				return
			end,
			[ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE] = function()
				self:emit(LevelMediator2.ON_CLUE_MAP)

				return
			end
		})
	end

	return
end

function LevelSecondMapBtn:ResPath()
	return "LinkButton_mellow"
end

return LevelSecondMapBtn
