local var_0_0 = g.core.module.ModuleManager
local var_0_1 = g.core.model.User.stormData
local var_0_2 = {
	FINISH = 2,
	FIGHTING = 1,
	LOCKED = 0
}
local var_0_3 = require("app.view.module.storm.const.StormConst").CITY_TYPE
local StormMainCpComp = class("StormMainCpComp", require("app.fairyGUI.storm.UI_StormMainCpComp1"))

function StormMainCpComp:ctor()
	self._type = 0
	self._state = -1
	self._cfg = nil

	self:addClickListener(handler(self, self._onClick))
end

function StormMainCpComp:updateShow(arg_2_1, arg_2_2)
	self._type = arg_2_2
	self._cfg = arg_2_1

	self.m_icon:setURL((g.core.common.Path:getStormPic(arg_2_1.icon)))
	self:_updateCity(arg_2_2, arg_2_1.id)
end

function StormMainCpComp:_updateCity(arg_3_1, arg_3_2)
	if arg_3_1 == var_0_3.SMALL_CITY then
		self:_updateSmallComp(arg_3_2)

		if self.m_redPointComp then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = self.m_redPointComp,
				customData = {
					id = self._cfg.id
				}
			})
		end
	elseif arg_3_1 == var_0_3.MIDDLE_CITY then
		self:_updateMiddleComp(arg_3_2)

		if self.m_redPointComp and var_0_1:isMiddleCityInOpenTime() then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = self.m_redPointComp,
				customData = {
					id = self._cfg.id
				}
			})
		end
	elseif arg_3_1 == var_0_3.BIG_CITY then
		self:_updateBigComp(arg_3_2)
	end
end

function StormMainCpComp:_updateSmallComp(arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = g.core.config.storm_info.get(arg_4_1)
	local var_4_1 = g.core.utils.Number.getFormatNum(2, var_4_0.order)

	self.m_indexTxt:setText(var_4_1)
	self.m_index2Txt:setText(var_4_1)
	self.m_titleTxt:setText(var_4_0.name)
	self.m_processComp:setMax(100)
	self.m_processComp:setValue(g.core.model.User.stormData:getCityPercent(arg_4_1) * 100 * 0.7)

	local var_4_2 = var_0_1:getCityState(arg_4_1)

	if not self._unlockState then
		self.m_stateController:setSelectedIndex(var_4_2)
	end

	if var_4_2 == var_0_2.LOCKED then
		-- block empty
	elseif var_4_2 == var_0_2.FIGHTING then
		-- block empty
	elseif var_4_2 == var_0_2.FINISH then
		-- block empty
	end

	self._state = var_4_2
end

function StormMainCpComp:_calcCurPage(arg_5_1)
	local StormConst = require("app.view.module.storm.const.StormConst")
	local var_5_1 = g.core.model.User.stormData:getMiddleCityData(arg_5_1).events or {}
	local var_5_2 = {}

	for iter_5_0 = 1, g.core.model.User.stormData:getCityMaxPage(arg_5_1) do
		var_5_2[iter_5_0] = false
	end

	for iter_5_1, iter_5_2 in ipairs(var_5_1) do
		local var_5_3 = g.core.config.storm_event_info.get(iter_5_2.ev_id)

		if var_5_3.event_type == StormConst.EVENT_TYPE.NORMAL_AWARD or var_5_3.event_type == StormConst.EVENT_TYPE.BOX then
			var_5_2[g.core.config.storm_cell_event_info.get(iter_5_2.cell_id).page] = true
		end
	end

	for iter_5_3 = 1, #var_5_2 do
		if var_5_2[iter_5_3] then
			return iter_5_3 - 1
		end
	end

	return #var_5_2
end

function StormMainCpComp:_updateMiddleComp(arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0 = self:_calcCurPage(arg_6_1)

	if var_0_1:getCityState(self._cfg.preset_id) ~= var_0_2.FINISH then
		var_6_0 = 0
	elseif not var_0_1:isMiddleCityInOpenTime() then
		var_6_0 = 0
	end

	self.m_processComp:setMax(100)
	self.m_processComp:setValue(var_6_0 * 25)

	local var_6_1 = g.core.config.storm_info.get(arg_6_1)

	self.m_titleTxt:setText(var_6_1.name)

	local var_6_2 = 0

	if var_0_1:getCityState(var_6_1.preset_id) == 2 then
		var_6_2 = 1
	end

	self.m_stateController:setSelectedIndex(var_6_2)

	if var_6_2 == var_0_2.LOCKED then
		-- block empty
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				id = arg_6_1
			}
		})

		if var_0_1:isMiddleCityInOpenTime() then
			local var_6_3 = var_0_1:isMiddleCityStageClear(arg_6_1)

			if var_0_1:getMiddleCityPlayNum(arg_6_1) > 0 and not var_6_3 then
				-- block empty
			elseif not var_0_1:isMiddleCityCleared(arg_6_1) and (not var_0_1:isUnlockBlitz(arg_6_1) or true) then
				-- block empty
			elseif var_6_3 then
				-- block empty
			end
		end
	end
end

function StormMainCpComp:_updateBigComp(arg_7_1)
	if not arg_7_1 then
		return
	end

	self.m_rankController = self.m_rankController or self:getController("rank")
	self.m_rankTxt = self.m_rankTxt or self:getChild("rankTxt")
	self.m_lordIcon = self.m_lordIcon or self:getChild("lordIcon")

	local var_7_0 = g.core.config.storm_info.get(arg_7_1)

	self.m_titleTxt:setText(var_7_0.name)

	if arg_7_1 == g.core.model.User.stormCityData:getOwnCityId() then
		self.m_rankTxt:setText((g.core.model.User.stormCityData:getOwnRank()))

		local var_7_1 = g.core.model.User.stormCityData:getOfficialInfoByRank()

		if var_7_1 then
			self.m_lordIcon:setURL((g.core.common.Path:getOfficialIcon(var_7_1.res)))
		end

		if g.core.model.User.stormCityData:isProcess() then
			self.m_rankController:setSelectedIndex(1)
			self:getChild("effSign"):addEffectSpine({
				name = "eff_ui_storm_sign",
				isLoop = true
			})
		end
	else
		self:getChild("effSign"):removeAllEffect()
		self.m_rankController:setSelectedIndex(0)
	end

	if var_0_1:getCityState(var_7_0.preset_id) ~= var_0_2.FINISH and (var_7_0.preset_id <= 0 or true) then
		self.m_stateController:setSelectedIndex(0)
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self:getChild("redPointComp")
		})

		if g.core.model.User.stormCityData:isProcess() then
			self.m_stateController:setSelectedIndex(1)
		else
			self.m_stateController:setSelectedIndex(2)
		end
	end

	if not g.core.model.User.stormCityData:isProcess() then
		local var_7_2 = var_0_1:getCityOwner(arg_7_1)

		if var_7_2 and var_7_2.user then
			-- block empty
		end
	end
end

function StormMainCpComp:_onClick()
	if self._cfg.id and self._cfg.id > 0 then
		if self._cfg.city_type == var_0_3.SMALL_CITY then
			if self._cfg.map_id == 0 then
				var_0_0:tip(g.core.lang:get(304522))

				return
			end

			local var_8_0 = var_0_1:getCityState(self._cfg.id)

			if var_8_0 == var_0_2.LOCKED then
				var_0_0:tip(g.core.lang:get(304523))
			elseif var_8_0 == var_0_2.FINISH then
				var_0_0:tip(g.core.lang:get(304524))
			else
				var_0_0:pushModule(g.view.entrance.STORM_SMALL_CITY, {
					stormId = self._cfg.id
				})
			end
		elseif self._cfg.city_type == var_0_3.MIDDLE_CITY then
			if var_0_1:getCityState(self._cfg.preset_id) ~= var_0_2.FINISH then
				local var_8_1 = g.core.config.storm_info.get(self._cfg.preset_id)

				var_0_0:tip(g.core.lang:get(304525, {
					name = var_8_1.id .. "." .. var_8_1.name,
					name2 = self._cfg.name
				}))

				return
			elseif var_0_1:isMiddleCityInOpenTime() then
				var_0_0:pushModule(g.view.entrance.STORM_MIDDLE_CITY, {
					stormId = self._cfg.id
				})
			else
				var_0_0:tip(g.core.lang:get(304526))

				return
			end
		elseif self._cfg.city_type == var_0_3.BIG_CITY then
			if g.core.model.User.stormData:getCityState(self._cfg.preset_id) ~= 2 then
				local var_8_2 = g.core.config.storm_info.get(self._cfg.preset_id)

				g.core.module.ModuleManager:tip(g.core.lang:get(304623, {
					name = var_8_2.id .. "." .. var_8_2.name,
					name2 = self._cfg.name
				}))

				return
			else
				var_0_0:pushModule(g.view.entrance.STORM_CITY_MAIN_LAYER, {
					cityId = self._cfg.id
				})
			end
		end
	end
end

function StormMainCpComp:playFinishAnim(arg_9_1)
	if arg_9_1 then
		self.m_passOpenTransition:play(arg_9_1)
	else
		self.m_passOpenTransition:play()
	end

	self.m_passOpenTransition:setHook("effPass", handler(self, self._onPlayOpenTrans))
end

function StormMainCpComp:_onPlayOpenTrans()
	self.m_effPass:addEffectSpine({
		isLoop = false,
		remove = true,
		name = "eff_ui_dungeon_pass"
	})
end

function StormMainCpComp:setDelayUnlock()
	self.m_stateController:setSelectedIndex(0)

	self._unlockState = true
end

function StormMainCpComp:playUnlock()
	self._unlockState = false

	self.m_stateController:setSelectedIndex(1)
	self:_onPlayUnlockEff()
end

function StormMainCpComp:_onPlayUnlockEff()
	self.m_effLock:addEffectSpine({
		isLoop = false,
		remove = true,
		name = "eff_ui_storm_unlock",
		scale = 0.7
	})
end

return StormMainCpComp
