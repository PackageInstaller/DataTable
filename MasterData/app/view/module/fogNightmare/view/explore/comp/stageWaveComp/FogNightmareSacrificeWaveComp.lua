local FogNightmareExploreKnightComp = class("FogNightmareExploreKnightComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareSacrificeWaveComp"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareSacrificeWaveComp",
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = false,
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightmareExploreKnightComp:ctor()
	self._effectStruct = nil
end

function FogNightmareExploreKnightComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_DEMONCONVERT, self._onSacrificeSucc, self)
end

function FogNightmareExploreKnightComp:updateComp(arg_4_1)
	self._effectStruct = arg_4_1

	self.m_tipText:setText((g.core.utils.String.formatSkillDesc(arg_4_1:getEffectCfg().passive_skill_value)))
end

function FogNightmareExploreKnightComp:_doClickAction(arg_5_1)
	g.core.network.GameNetProxy:send_C2S_Fog_DemonConvert({
		tp = true
	})
end

function FogNightmareExploreKnightComp:doClickCancelAction(arg_6_1)
	g.core.network.GameNetProxy:send_C2S_Fog_DemonConvert({
		tp = false
	})
end

function FogNightmareExploreKnightComp:_onSacrificeSucc()
	local var_7_0 = self._effectStruct:getRandSeals()

	if var_7_0 and next(var_7_0) then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.keepsake.FogNightmareKeepsakeSelectPop").new(), {
			touchDisappear = false
		})
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FLOOR_STATE, false)
	end
end

return FogNightmareExploreKnightComp
