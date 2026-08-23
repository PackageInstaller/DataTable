local var_0_0 = {
	LOCKED = 0,
	FINISH = 2,
	FIGHTING = 1
}
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.model.User.stormData
local StormBigWorldMiddle = class("StormBigWorldMiddle", require("app.fairyGUI.storm.UI_StormBigWorldMiddle"))

function StormBigWorldMiddle:ctor()
	self:addClickListener(handler(self, self._onClick))
	self.m_redPointComp:setId(300)

	self._effHolder = self.m_openEffComp:getChild("eff")
end

function StormBigWorldMiddle:onLoad()
	if self._stormId then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				id = self._stormId
			}
		})
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_STORMINFO, handler(self, self._onRcvStormInfo), self)
end

function StormBigWorldMiddle:updateCompShow(arg_3_1, arg_3_2)
	if arg_3_1 then
		self._stormId = arg_3_1.middle

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				id = self._stormId
			}
		})

		local var_3_0 = g.core.config.storm_info.get(arg_3_1.middle)

		self.m_iconLoader:setURL((g.core.common.Path:getStormPic(var_3_0.icon)))

		local var_3_1 = self:_calcCurPage(arg_3_1.middle)

		self._effHolder:removeAllEffect()

		self._spine = nil

		if var_0_2:getCityState(var_3_0.preset_id) ~= var_0_0.FINISH then
			self.m_redPointComp:setShow(false)

			var_3_1 = 0
		elseif not var_0_2:isMiddleCityInOpenTime() then
			var_3_1 = 0
		elseif not g.core.model.User.stormData:isStormRequested(self._stormId) then
			g.core.network.GameNetProxy:send_C2S_Storm_StormInfo({
				storm_id = self._stormId
			})
		end

		self.m_processComp:setMax(100)
		self.m_processComp:setValue(var_3_1 * 25)

		local var_3_2 = 0

		if var_0_2:getCityState(var_3_0.preset_id) == 2 then
			var_3_2 = 1
		end

		self.m_stateController:setSelectedIndex(var_3_2)
		self.m_openEffComp:setVisible(false)

		if var_3_2 == var_0_0.LOCKED then
			self.m_stateController:setSelectedIndex(0)
		else
			self.m_stateController:setSelectedIndex(1)
			self.m_openController:setSelectedIndex(0)

			if var_0_2:isMiddleCityInOpenTime() then
				self.m_openController:setSelectedIndex(1)

				self._spine = self._effHolder:addEffectSpine({
					name = "eff_ui_baseNew_bubble",
					anim = "play",
					isLoop = false,
					eventHandler = handler(self, self._onSpineEnd)
				})

				local var_3_3 = not g.core.model.User.stormData:isMiddleCityCleared(self._stormId)

				if g.core.model.User.shopData:getLeftCount(g.core.model.User.stormData:getMiddleCityPlayNumId(self._stormId)) > 0 then
					self.m_openEffComp:setVisible(true)
					self.m_openEffComp:getChild("title"):setText(g.core.lang:get(304541))
				elseif var_3_3 then
					self.m_openEffComp:setVisible(true)
					self.m_openEffComp:getChild("title"):setText(g.core.lang:get(304542))
				end
			end
		end
	end
end

function StormBigWorldMiddle:_onSpineEnd(arg_4_1)
	if arg_4_1.type == "complete" and self._spine then
		self._spine:setAnimation(0, "play2", true)
	end
end

function StormBigWorldMiddle:_onRcvStormInfo(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if self._stormId == arg_5_4.storm_id then
		self.m_processComp:setMax(100)
		self.m_processComp:setValue(self:_calcCurPage(self._stormId) * 25)
	end
end

function StormBigWorldMiddle:_calcCurPage(arg_6_1)
	local StormConst = require("app.view.module.storm.const.StormConst")
	local var_6_1 = g.core.model.User.stormData:getMiddleCityData(arg_6_1).events or {}
	local var_6_2 = {}

	for iter_6_0 = 1, g.core.model.User.stormData:getCityMaxPage(arg_6_1) do
		var_6_2[iter_6_0] = false
	end

	for iter_6_1, iter_6_2 in ipairs(var_6_1) do
		local var_6_3 = g.core.config.storm_event_info.get(iter_6_2.ev_id)

		if var_6_3.event_type == StormConst.EVENT_TYPE.NORMAL_AWARD or var_6_3.event_type == StormConst.EVENT_TYPE.BOX then
			var_6_2[g.core.config.storm_cell_event_info.get(iter_6_2.cell_id).page] = true
		end
	end

	for iter_6_3 = 1, #var_6_2 do
		if var_6_2[iter_6_3] then
			return iter_6_3 - 1
		end
	end

	return #var_6_2
end

function StormBigWorldMiddle:_onClick()
	if self._stormId and self._stormId > 0 then
		local var_7_0 = g.core.config.storm_info.get(self._stormId)

		if var_0_2:getCityState(var_7_0.preset_id) ~= var_0_0.FINISH then
			local var_7_1 = g.core.config.storm_info.get(var_7_0.preset_id)

			var_0_1:tip(g.core.lang:get(304525, {
				name = var_7_1.id .. "." .. var_7_1.name,
				name2 = var_7_0.name
			}))

			return
		elseif var_0_2:isMiddleCityInOpenTime() then
			var_0_1:pushModule(g.view.entrance.STORM_MIDDLE_CITY, {
				stormId = var_7_0.id
			})
		else
			var_0_1:tip(g.core.lang:get(304526))

			return
		end
	end
end

return StormBigWorldMiddle
