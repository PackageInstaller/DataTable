local var_0_0 = {
	30,
	250
}
local var_0_1 = g.core.model.User.richmanData
local RichmanLevelComp = class("RichmanLevelComp", require("app.fairyGUI.richman.UI_RichmanLevelComp"))

function RichmanLevelComp:ctor()
	self:addClickListener(handler(self, self._onLevelCompClick))
	self:updateRichmanLvShow()
end

function RichmanLevelComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CLICK_FINISH, self._onGameTouchFinish, self)
end

function RichmanLevelComp:updateRichmanLvShow()
	local var_3_0 = var_0_1:getCurRobData()

	self.m_eff:removeAllEffect()

	self._loopEff = nil

	if not var_3_0 then
		local var_3_1 = var_0_1:getMapLevel()

		self.m_curLvTxt:setText(var_3_1)
		self.m_nextLvTxt:setText(math.min(var_3_1 + 1, var_0_1:getMapMaxLevel()))

		local var_3_2 = var_0_1:getMapExp()
		local var_3_3 = var_0_1:getCurLvMaxExp()

		self.m_progressTxt:setText(var_3_2 .. "/" .. var_3_3)

		if var_3_3 <= var_3_2 then
			if var_0_1:getMapMaxLevel() == var_3_1 then
				self.m_stateController:setSelectedIndex(1)
			else
				self.m_stateController:setSelectedIndex(2)

				self._loopEff = self._loopEff or self.m_eff:addEffectSpine({
					anim = "play2",
					name = "eff_ui_richman_bar",
					isLoop = true
				})
			end
		else
			self.m_stateController:setSelectedIndex(0)
		end

		self:setProgress(var_3_2 / var_3_3)

		if self._curLv and var_3_1 > self._curLv then
			self.m_eff:addEffectSpine({
				anim = "play1",
				name = "eff_ui_richman_bar",
				remove = true,
				isLoop = false
			})
		end

		self._curLv = var_3_1

		self.m_nextLv:setVisible(true)
		self.m_progressImg:setVisible(true)
	else
		self.m_nextLv:setVisible(false)
		self.m_progressImg:setVisible(false)
		self.m_stateController:setSelectedIndex(0)
		self:setProgress(0)
		self.m_curLvTxt:setText(var_3_0.map_level)
		self.m_nextLvTxt:setText(math.min(var_3_0.map_level + 1, var_0_1:getMapMaxLevel()))
		self.m_progressTxt:setText("")
	end
end

function RichmanLevelComp:setProgress(arg_4_1)
	self.m_progress:setWidth((math.min(var_0_0[2], (var_0_0[2] - var_0_0[1]) * arg_4_1 + var_0_0[1])))
end

function RichmanLevelComp:_onLevelCompClick()
	if var_0_1:getCurRobData() then
		return
	end

	if var_0_1:getMapExp() >= var_0_1:getCurLvMaxExp() then
		if var_0_1:getMapLevel() < var_0_1:getMapMaxLevel() then
			g.core.network.GameNetProxy:send_C2S_RichMan_MapUpLevel({})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(426008))
		end
	else
		self.m_levelTipComp:setVisible(true)
	end
end

function RichmanLevelComp:_onGameTouchFinish()
	self.m_levelTipComp:setVisible(false)
end

return RichmanLevelComp
