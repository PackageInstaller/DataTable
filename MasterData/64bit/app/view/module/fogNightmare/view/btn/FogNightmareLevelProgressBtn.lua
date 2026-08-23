local var_0_0 = g.core.config.fog_level_info
local var_0_1 = g.core.model.User.fogNightmareData
local FogNightmareLevelProgressBtn = class("FogNightmareLevelProgressBtn", require("app.fairyGUI.fogNightmare.UI_FogNightmareLevelProgressBtn"))

function FogNightmareLevelProgressBtn:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_RESOURCE, handler(self, self.updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_UPGRADELEVEL, handler(self, self.updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_GETINFO, handler(self, self.updateView), self)
	self:updateView()
end

function FogNightmareLevelProgressBtn:updateView()
	local var_2_0 = var_0_1:getFogLevel()
	local var_2_2 = (var_0_0.fetch(var_2_0) or {}).exp or 0
	local var_2_4 = ((var_0_0.fetch(var_2_0 + 1) or {}).exp or 0) - var_2_2

	self.m_levelText:setText(var_2_0)
	self:setMax(math.max(0, var_2_4))
	self:setValue(math.max(0, var_0_1:getFogLevelExp() - var_2_2))
end

return FogNightmareLevelProgressBtn
