-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/BlackScreenViewPresentor.lua

module("logic.extensions.story.view.BlackScreenViewPresentor", package.seeall)

local BlackScreenViewPresentor = class("BlackScreenViewPresentor", ViewPresentor)

function BlackScreenViewPresentor:attachToWhichRoot()
	return nil
end

function BlackScreenViewPresentor:dependWhatResources()
	return {
		"ui/views/story/blackscreen.prefab"
	}
end

function BlackScreenViewPresentor:buildViews()
	local views = {}
	local blackScreenView = BlackScreenView.New()

	table.insert(views, blackScreenView)

	return views
end

return BlackScreenViewPresentor
