local var_0_0 = g.core.config.daily_dungeon_stage_info
local var_0_1 = g.core.config.play_num_info
local DailyDungeonMainItem = class("DailyDungeonMainItem", require("app.fairyGUI.dailyDungeon.UI_DailyDungeonMainItem"))

function DailyDungeonMainItem:ctor()
	self:_initUIListeners()
	self:_reset()

	self.m_icon = self:getChild("icon")
	self._iconPos = self.m_icon:getPosition()
end

function DailyDungeonMainItem:_initUIListeners()
	self:addClickListener(handler(self, self._onClickItem))
	self.m_enterTransition:setHook("play", handler(self, self._playEnterSpine))
	self.m_enterTransition:setHook("play2Loop", handler(self, self._playLoop))
end

function DailyDungeonMainItem:_playEnterSpine()
	self._spineNode = self.m_effLedLoop:addEffectSpine({
		name = "eff_ui_dailyDungeon_ledLoop",
		scale = 1,
		isLoop = false
	})
end

function DailyDungeonMainItem:_playLoop()
	if self._spineNode then
		self._spineNode:stop()
		self._spineNode:dispose()

		self._spineNode = nil
	end

	self.m_effLedLoop:addEffectSpine({
		name = "eff_ui_dailyDungeon_ledLoop",
		scale = 1,
		anim = "play2",
		isLoop = true
	})
end

function DailyDungeonMainItem:_resetOther()
	self._tabInfo = nil
	self._data = nil
	self._openState = nil
end

function DailyDungeonMainItem:_reset()
	self:_resetOther()
end

function DailyDungeonMainItem:updateItem(arg_7_1)
	self._data = arg_7_1

	self.m_nameText:setText(arg_7_1.name)
	self.m_nameTextCopy:setText(arg_7_1.name)
	self.m_bgLoader:setURL((g.core.common.Path:getDailyDungeonImg("pic_fuben_0" .. arg_7_1.id)))
	self:setIcon((g.core.common.Path:getIconByTypeValue(arg_7_1.show_type, arg_7_1.show_value)))

	local var_7_0 = clone(self._iconPos)

	var_7_0.x = var_7_0.x + ({
		0,
		10,
		10,
		15
	})[arg_7_1.id]

	self.m_icon:setPosition(var_7_0)
	self:_updateDailyDungeon()

	if self._openState ~= 0 then
		self.m_isLockController:setSelectedIndex(1)
	else
		self.m_isLockController:setSelectedIndex(0)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPoint,
			customData = {
				type = arg_7_1.daily_dungeon_type,
				stageId = arg_7_1.id
			}
		})
	end
end

function DailyDungeonMainItem:_onClickItem()
	if self:_checkDailyDungeon() then
		self:dispatchCompEvent("enterDetailDungeon", unpack(self._enterParams))
	end
end

function DailyDungeonMainItem:_updateDailyDungeon()
	self._openState = g.core.model.User.dailyDungeonData:checkChapterOpenState(self._data.id)

	local var_9_0 = ""

	if self._data.time == 1 then
		var_9_0 = g.core.lang:get(300511)
	elseif self._data.time - 2 == 0 then
		var_9_0 = g.core.lang:get(300501)
	elseif self._data.time - 2 == 1 then
		var_9_0 = g.core.lang:get(300502)
	end

	self.m_timeTxt:setText(var_9_0)
	self.m_timeTxtCopy:setText(var_9_0)

	local var_9_1 = g.core.model.User.shopData:getLeftCount(self._data.dungeon_num)

	self.m_explorCurText:setText(var_9_1)
	self.m_explorMaxText:setText(g.core.lang:get(109537, {
		num = var_0_1.get(self._data.dungeon_num).reset
	}))

	if var_9_1 == 0 then
		self.m_isZeroController:setSelectedIndex(1)
	else
		self.m_isZeroController:setSelectedIndex(0)
	end

	local var_9_2 = self._data.daily_dungeon_type

	self._subDungeonList = var_0_0.match(function(arg_10_0)
		return arg_10_0.daily_dungeon_type == var_9_2
	end)
end

function DailyDungeonMainItem:_checkDailyDungeon()
	self._enterParams = {}

	local var_11_0

	if self._openState ~= 0 then
		if self._openState == 1 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1069, {
				name = self._data.name
			}))
		elseif self._openState == 2 then
			g.core.module.ModuleManager:tip(g.core.lang:get(300513, {
				name = self._data.name,
				level = g.core.model.User.dailyDungeonData:getChapterOpenLevel(self._data.id)
			}))
		end

		do return false end

		var_11_0 = {
			self._subDungeonList
		}
	end

	var_11_0[2] = {
		info = self._data
	}
	self._enterParams = var_11_0

	return true
end

return DailyDungeonMainItem
