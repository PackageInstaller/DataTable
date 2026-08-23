local var_0_0 = g.core.common.Path
local PubgGridBuff = class("PubgGridBuff", require("app.fairyGUI.pubg.UI_PubgGridBuff"))

function PubgGridBuff:ctor()
	self._buff = nil
end

function PubgGridBuff:resetComp()
	self.m_resetTransition:play()
	self.m_effRefresh:removeChildren()
	self.m_effGet:removeChildren()
end

function PubgGridBuff:setBuff(arg_3_1)
	if not self._buff or self._buff:getUid() ~= arg_3_1:getUid() then
		self._buff = arg_3_1
	end

	self:refreshBuff()
end

function PubgGridBuff:refreshBuff()
	self:setIcon(var_0_0:getPubgBuff(self._buff:getBuffCfg().icon))
	self.m_buffTypeController:setSelectedIndex(self._buff:getBuffCfg().buff_type == 1 and 0 or 1)
end

function PubgGridBuff:playRefreshEventEff(arg_5_1)
	self.m_refreshTransition:play(function()
		if arg_5_1 then
			arg_5_1()
		end
	end)
	self.m_effRefresh:addEffectSpine({
		name = "eff_ui_pubg_buffRefresh",
		remove = true,
		isLoop = false,
		anim = self._buff:getBuffCfg().buff_type == 1 and "play_yellow" or "play_blue"
	})
end

function PubgGridBuff:playGetBuffEff(arg_7_1)
	self.m_getTransition:play(function()
		if arg_7_1 then
			arg_7_1()
		end
	end)
	self.m_effGet:addEffectSpine({
		name = "eff_ui_pubg_buffGet",
		remove = true,
		isLoop = false,
		anim = self._buff:getBuffCfg().buff_type == 1 and "play_yellow" or "play_blue"
	})
end

return PubgGridBuff
