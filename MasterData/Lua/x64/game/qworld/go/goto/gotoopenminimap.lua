local GotoOpenMiniMap = class("GotoOpenMiniMap", BaseGoto)

function GotoOpenMiniMap:Go()
	JumpTools.GoToSystem("/qWorldMaxMapView")
end

return GotoOpenMiniMap
