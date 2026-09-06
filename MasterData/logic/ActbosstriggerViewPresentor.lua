-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/ActbosstriggerViewPresentor.lua

module("logic.extensions.aceteam.view.ActbosstriggerViewPresentor", package.seeall)

local ActbosstriggerViewPresentor = class("ActbosstriggerViewPresentor", ViewPresentor)

function ActbosstriggerViewPresentor:ctor()
	ActbosstriggerViewPresentor.super.ctor(self)
end

function ActbosstriggerViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ActbosstriggerViewPresentor:dependWhatResources()
	return {
		"ui/views/aceteam/actbosstriggerview.prefab"
	}
end

function ActbosstriggerViewPresentor:buildViews()
	return {
		ActbosstriggerView.New()
	}
end

function ActbosstriggerViewPresentor:setGrayMaskGO(grayMaskGO)
	ActbosstriggerViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	goutil.setActive(grayMaskGO, false)
end

return ActbosstriggerViewPresentor
