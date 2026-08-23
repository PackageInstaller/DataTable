local FogNightExploreFloorComp = class("FogNightExploreFloorComp", require("app.fairyGUI.fogNightmare.UI_FogNightExploreFloorComp"))

function FogNightExploreFloorComp:ctor()
	self.m_effComTitle:addEffectSpine({
		anim = "play2",
		name = "eff_ui_FogNightmare_comTitle",
		isLoop = true
	})
end

function FogNightExploreFloorComp:updateFloor(arg_2_1)
	self:setTitle(g.core.lang:get(500222, {
		floor = arg_2_1
	}))
end

return FogNightExploreFloorComp
