-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/op220701/Activityop220701vedioViewPresentor.lua

module("logic.extensions.operationsummary.view.op220701.Activityop220701vedioViewPresentor", package.seeall)

local Activityop220701vedioViewPresentor = class("Activityop220701vedioViewPresentor", ViewPresentor)

function Activityop220701vedioViewPresentor:ctor()
	Activityop220701vedioViewPresentor.super.ctor(self)
end

function Activityop220701vedioViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Activityop220701vedioViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/activityop220701vedioview.prefab"
	}
end

function Activityop220701vedioViewPresentor:buildViews()
	return {
		ActivityOP220701VedioView.New()
	}
end

return Activityop220701vedioViewPresentor
