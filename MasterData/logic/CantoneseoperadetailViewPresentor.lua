-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantoneseopera/view/CantoneseoperadetailViewPresentor.lua

module("logic.extensions.cantoneseopera.view.CantoneseoperadetailViewPresentor", package.seeall)

local CantoneseoperadetailViewPresentor = class("CantoneseoperadetailViewPresentor", ViewPresentor)

function CantoneseoperadetailViewPresentor:ctor()
	CantoneseoperadetailViewPresentor.super.ctor(self)
end

function CantoneseoperadetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CantoneseoperadetailViewPresentor:dependWhatResources()
	return {
		"ui/views/cantoneseopera/cantoneseoperadetailview.prefab"
	}
end

function CantoneseoperadetailViewPresentor:buildViews()
	return {
		CantoneseoperadetailView.New()
	}
end

return CantoneseoperadetailViewPresentor
