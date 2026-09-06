-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantoneseopera/view/CantoneseoperaViewPresentor.lua

module("logic.extensions.cantoneseopera.view.CantoneseoperaViewPresentor", package.seeall)

local CantoneseoperaViewPresentor = class("CantoneseoperaViewPresentor", ViewPresentor)

function CantoneseoperaViewPresentor:ctor()
	CantoneseoperaViewPresentor.super.ctor(self)
end

function CantoneseoperaViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CantoneseoperaViewPresentor:dependWhatResources()
	return {
		"ui/views/cantoneseopera/cantoneseoperaview.prefab"
	}
end

function CantoneseoperaViewPresentor:buildViews()
	return {
		CantoneseoperaView.New()
	}
end

return CantoneseoperaViewPresentor
