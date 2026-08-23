local var_0_0 = {
	FIGHTING = 1,
	LOCKED = 0,
	FINISH = 2
}
local var_0_1 = g.core.model.User.stormData
local StormBigWorldStation = class("StormBigWorldStation", require("app.fairyGUI.storm.UI_StormBigWorldStation"))

function StormBigWorldStation:ctor()
	self:addClickListener(handler(self, self._onClick))

	self._effHolder = self.m_openEffComp:getChild("eff")
end

function StormBigWorldStation:onLoad()
	if self._stormId then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				id = self._stormId
			}
		})
	end
end

function StormBigWorldStation:updateCompShow(arg_3_1, arg_3_2)
	self.m_effOpen:removeAllEffect()
	self._effHolder:removeAllEffect()
	self.m_openEffComp:setVisible(false)

	if arg_3_1 then
		self.m_rankController = self.m_rankController or self:getController("rank")
		self.m_rankTxt = self.m_rankTxt or self:getChild("rankTxt")
		self.m_lordIcon = self.m_lordIcon or self:getChild("lordIcon")
		self._stormId = arg_3_1.big

		local var_3_0 = g.core.config.storm_info.get(arg_3_1.big)

		self.m_cityLoader:setURL((g.core.common.Path:getStormPic(var_3_0.icon)))

		if arg_3_1.big == g.core.model.User.stormCityData:getOwnCityId() then
			self.m_rankTxt:setText(g.core.lang:get(304538, {
				num = g.core.model.User.stormCityData:getOwnRank()
			}))

			local var_3_1 = g.core.model.User.stormCityData:getOfficialInfoByRank()

			if var_3_1 then
				self.m_lordIcon:setURL((g.core.common.Path:getOfficialIcon(var_3_1.res)))
			end

			self.m_rankController:setSelectedIndex(1)
		else
			self.m_rankController:setSelectedIndex(0)
		end

		if var_0_1:getCityState(var_3_0.preset_id) ~= var_0_0.FINISH then
			self.m_stateController:setSelectedIndex(0)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = self.m_redPointComp,
				customData = {
					id = self._stormId
				}
			})
			self.m_stateController:setSelectedIndex(1)

			if g.core.model.User.stormCityData:isProcess() then
				self.m_effOpen:addEffectSpine({
					isLoop = true,
					name = "eff_ui_storm_open"
				})
				self.m_openController:setSelectedIndex(1)

				if g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.STORM_CITY) > 0 then
					self.m_openEffComp:setVisible(true)
				end

				self._spine = self._effHolder:addEffectSpine({
					anim = "play",
					name = "eff_ui_baseNew_bubble",
					isLoop = false,
					eventHandler = handler(self, self._onSpineEnd)
				})
			else
				self.m_openController:setSelectedIndex(0)
			end
		end
	end
end

function StormBigWorldStation:_onSpineEnd(arg_4_1)
	if arg_4_1.type == "complete" and self._spine then
		self._spine:setAnimation(0, "play2", true)
	end
end

function StormBigWorldStation:_onClick()
	if self._stormId then
		local var_5_0 = g.core.config.storm_info.get(self._stormId)

		if g.core.model.User.stormData:getCityState(var_5_0.preset_id) ~= 2 then
			local var_5_1 = g.core.config.storm_info.get(var_5_0.preset_id)

			g.core.module.ModuleManager:tip(g.core.lang:get(304623, {
				name = var_5_1.id .. "." .. var_5_1.name,
				name2 = var_5_0.name
			}))

			return
		else
			g.core.module.ModuleManager:pushModule(g.view.entrance.STORM_CITY_MAIN_LAYER, {
				cityId = var_5_0.id
			})
		end
	end
end

return StormBigWorldStation
