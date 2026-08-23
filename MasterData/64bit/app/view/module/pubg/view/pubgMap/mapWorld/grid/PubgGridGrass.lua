local PubgGridGrass = class("PubgGridGrass", require("app.fairyGUI.pubg.UI_PubgGridGrass"))

function PubgGridGrass:ctor()
	self.m_eff:addEffectSpine({
		isLoop = true,
		remove = false,
		anim = "play",
		name = "eff_ui_pubg_sand"
	})
end

return PubgGridGrass
