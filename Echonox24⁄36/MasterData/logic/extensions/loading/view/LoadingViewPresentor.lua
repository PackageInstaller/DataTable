-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/view/LoadingViewPresentor.lua

module("logic.extensions.loading.view.LoadingViewPresentor", package.seeall)

local LoadingViewPresentor = class("LoadingViewPresentor", ViewPresentor)

BlackFadePresentorWrapper.extend(LoadingViewPresentor)

function LoadingViewPresentor:dependWhatResources()
	return {
		ResName.Loading_loading
	}
end

function LoadingViewPresentor:attachToWhichRoot()
	return ViewRootType.NotifyTop
end

function LoadingViewPresentor:buildViews()
	local views = {}

	table.insert(views, LoadingView.New())

	return views
end

return LoadingViewPresentor
