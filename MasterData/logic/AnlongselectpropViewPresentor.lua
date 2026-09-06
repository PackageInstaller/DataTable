-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anlongselfselect/view/AnlongselectpropViewPresentor.lua

module("logic.extensions.anlongselfselect.view.AnlongselectpropViewPresentor", package.seeall)

local AnlongselectpropViewPresentor = class("AnlongselectpropViewPresentor", ViewPresentor)

function AnlongselectpropViewPresentor:ctor()
	AnlongselectpropViewPresentor.super.ctor(self)
end

function AnlongselectpropViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AnlongselectpropViewPresentor:dependWhatResources()
	return {
		"ui/views/anlongselfselect/anlongselectpropview.prefab"
	}
end

function AnlongselectpropViewPresentor:buildViews()
	return {
		AnlongselectpropView.New()
	}
end

return AnlongselectpropViewPresentor
