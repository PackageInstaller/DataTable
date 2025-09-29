-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/view/LoadingBlackViewPresentor.lua

module("logic.extensions.loading.view.LoadingBlackViewPresentor", package.seeall)

local M = class("LoadingBlackViewPresentor", ViewPresentor)

BlackFadePresentorWrapper.extend(M)

function M:dependWhatResources()
	return {
		ResName.Loading_loading_black
	}
end

function M:attachToWhichRoot()
	return ViewRootType.NotifyTop
end

function M:buildViews()
	local views = {}

	table.insert(views, LoadingBlackView.New())

	return views
end

return M
