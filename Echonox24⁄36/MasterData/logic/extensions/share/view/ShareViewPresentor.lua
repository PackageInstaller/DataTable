-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/share/view/ShareViewPresentor.lua

module("logic.extensions.share.view.ShareViewPresentor", package.seeall)

local ShareViewPresentor = class("ShareViewPresentor", ViewPresentor)

function ShareViewPresentor:dependWhatResources()
	return {
		ResName.Share_share_view
	}
end

function ShareViewPresentor:buildViews()
	local views = {}

	self._mainView = ShareView.New()

	table.insert(views, self._mainView)
	table.insert(views, BlurBgView.New())

	return views
end

function ShareViewPresentor:attachToWhichRoot()
	return ViewRootType.PopupTop
end

return ShareViewPresentor
