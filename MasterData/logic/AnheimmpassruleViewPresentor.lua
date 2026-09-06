-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/anheimm/AnheimmpassruleViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.anheimm.AnheimmpassruleViewPresentor", package.seeall)

local AnheimmpassruleViewPresentor = class("AnheimmpassruleViewPresentor", ViewPresentor)

function AnheimmpassruleViewPresentor:ctor()
	AnheimmpassruleViewPresentor.super.ctor(self)
end

function AnheimmpassruleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AnheimmpassruleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/anheimm/anheimmpassruleview.prefab"
	}
end

function AnheimmpassruleViewPresentor:buildViews()
	return {
		AnheimmpassruleView.New()
	}
end

return AnheimmpassruleViewPresentor
