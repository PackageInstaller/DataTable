local var_0_1 = g.core.config.daily_dungeon_stage_info
local DailyDungeonItem = class("DailyDungeonItem", require("app.fairyGUI.dailyDungeon.UI_DailyDungeonDetailItem"))

function DailyDungeonItem:ctor()
	self:addClickListener(handler(self, self._showTip))
end

function DailyDungeonItem:updateItem(arg_2_1, arg_2_2)
	self:_stopStageItemUnlock()

	if arg_2_2 >= 3 and arg_2_2 < 5 then
		self.m_lockController:setSelectedIndex(0)
	else
		if arg_2_2 < 3 then
			self.m_lockController:setSelectedIndex(1)
		else
			self.m_lockController:setSelectedIndex(0)
		end

		self.m_isCompletedController:setSelectedIndex(0)
	end

	self.m_nameTxt:setText(arg_2_1.name)
	self:_updateLockText(arg_2_1, arg_2_2)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPoint,
		customData = {
			id = arg_2_1.id,
			type = arg_2_1.daily_dungeon_type
		}
	})
end

function DailyDungeonItem:_updateLockText(arg_3_1, arg_3_2)
	self._tipStr = nil

	if arg_3_2 == 0 or arg_3_2 == 1 or arg_3_2 == 2 then
		local var_3_0 = arg_3_1.description

		if arg_3_2 == 1 then
			var_3_0 = g.core.lang:get(1071, {
				level = arg_3_1.stage_level
			})
		else
			local var_3_1 = string.upper(var_0_1.fetch(arg_3_1.premise_id).difficulty)

			if arg_3_2 == 0 then
				self._tipStr = g.core.lang:get(1072, {
					premise = g.core.lang:get(1230 + tonumber(string.split(var_3_1, "_")[2]))
				})
			else
				var_3_0 = g.core.lang:get(300512)
			end
		end

		self.m_lockTxt:setText(var_3_0)
	end
end

function DailyDungeonItem:playStageItemUnlock(arg_4_1)
	self._unlockAnimCall = arg_4_1

	self.m_effLock:addEffectSpine({
		remove = true,
		name = "eff_ui_dailyDungeon_lockTab",
		scale = 1,
		isLoop = false,
		eventHandler = handler(self, self._onSpineEventItem)
	})
end

function DailyDungeonItem:_onSpineEventItem(arg_5_1, arg_5_2)
	if arg_5_1.type == "complete" then
		if self._unlockAnimCall then
			self._unlockAnimCall()
		end

		self._unlockAnimCall = nil
	end
end

function DailyDungeonItem:_stopStageItemUnlock()
	return
end

function DailyDungeonItem:_showTip()
	if self._tipStr then
		-- block empty
	end
end

function DailyDungeonItem:playEff()
	self.m_effTab:addEffectSpine({
		name = "eff_ui_dailyDungeon_lefttab",
		remove = true,
		isLoop = false,
		scale = 1
	})
end

return DailyDungeonItem
