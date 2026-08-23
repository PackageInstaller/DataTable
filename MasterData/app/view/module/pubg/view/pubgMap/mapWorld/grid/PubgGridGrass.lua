local PubgGridGrass = class("PubgGridGrass", require("app.fairyGUI.pubg.UI_PubgGridGrass"))

function PubgGridGrass:ctor()
	self.m_eff:addEffectSpine({
		anim = "play",
		name = "eff_ui_pubg_sand",
		remove = false,
		isLoop = true
	})
end

return PubgGridGrass
