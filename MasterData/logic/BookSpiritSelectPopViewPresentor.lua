-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/BookSpiritSelectPopViewPresentor.lua

module("logic.extensions.formation.view.BookSpiritSelectPopViewPresentor", package.seeall)

local BookSpiritSelectPopViewPresentor = class("BookSpiritSelectPopViewPresentor", ViewPresentor)

function BookSpiritSelectPopViewPresentor:ctor()
	BookSpiritSelectPopViewPresentor.super.ctor(self)
end

function BookSpiritSelectPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function BookSpiritSelectPopViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/bookspiritselectpopview.prefab"
	}
end

function BookSpiritSelectPopViewPresentor:buildViews()
	return {
		BookSpiritSelectPopView.New()
	}
end

return BookSpiritSelectPopViewPresentor
