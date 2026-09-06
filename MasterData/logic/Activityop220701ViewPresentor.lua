-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/op220701/Activityop220701ViewPresentor.lua

module("logic.extensions.operationsummary.view.op220701.Activityop220701ViewPresentor", package.seeall)

local Activityop220701ViewPresentor = class("Activityop220701ViewPresentor", ViewPresentor)

function Activityop220701ViewPresentor:ctor()
	Activityop220701ViewPresentor.super.ctor(self)
end

function Activityop220701ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Activityop220701ViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/activityop220701.prefab"
	}
end

function Activityop220701ViewPresentor:buildViews()
	return {
		ActivityOP220701View.New()
	}
end

return Activityop220701ViewPresentor
