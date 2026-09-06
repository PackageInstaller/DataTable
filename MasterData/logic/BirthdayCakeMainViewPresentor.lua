-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaycake/view/BirthdayCakeMainViewPresentor.lua

module("logic.extensions.birthdaycake.view.BirthdayCakeMainViewPresentor", package.seeall)

local BirthdayCakeMainViewPresentor = class("BirthdayCakeMainViewPresentor", ViewPresentor)

function BirthdayCakeMainViewPresentor:ctor()
	BirthdayCakeMainViewPresentor.super.ctor(self)
end

function BirthdayCakeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BirthdayCakeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/birthdaycake/birthdaycakemainview.prefab"
	}
end

function BirthdayCakeMainViewPresentor:buildViews()
	return {
		BirthdayCakeMainView.New()
	}
end

return BirthdayCakeMainViewPresentor
