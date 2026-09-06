-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/anheimm/AnheimmresultViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.anheimm.AnheimmresultViewPresentor", package.seeall)

local AnheimmresultViewPresentor = class("AnheimmresultViewPresentor", ViewPresentor)

function AnheimmresultViewPresentor:ctor()
	AnheimmresultViewPresentor.super.ctor(self)
end

function AnheimmresultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AnheimmresultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/anheimm/anheimmresultview.prefab"
	}
end

function AnheimmresultViewPresentor:buildViews()
	return {
		AnheimmresultView.New()
	}
end

return AnheimmresultViewPresentor
