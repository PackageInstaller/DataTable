local FogNightmareExploreKnightCompMini = class("FogNightmareExploreKnightCompMini", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreKnightCompMini"))

function FogNightmareExploreKnightCompMini:ctor()
	self._knightStruct = nil
end

function FogNightmareExploreKnightCompMini:updateComp(arg_2_1)
	self._knightStruct = arg_2_1

	self.m_knight:updateComp(self._knightStruct)
end

return FogNightmareExploreKnightCompMini
