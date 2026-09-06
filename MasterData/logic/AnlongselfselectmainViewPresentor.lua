-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anlongselfselect/view/AnlongselfselectmainViewPresentor.lua

module("logic.extensions.anlongselfselect.view.AnlongselfselectmainViewPresentor", package.seeall)

local AnlongselfselectmainViewPresentor = class("AnlongselfselectmainViewPresentor", ViewPresentor)

function AnlongselfselectmainViewPresentor:ctor()
	AnlongselfselectmainViewPresentor.super.ctor(self)
end

function AnlongselfselectmainViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AnlongselfselectmainViewPresentor:dependWhatResources()
	return {
		"ui/views/anlongselfselect/anlongselfselectmainview.prefab"
	}
end

function AnlongselfselectmainViewPresentor:buildViews()
	return {
		AnlongselfselectmainView.New()
	}
end

return AnlongselfselectmainViewPresentor
