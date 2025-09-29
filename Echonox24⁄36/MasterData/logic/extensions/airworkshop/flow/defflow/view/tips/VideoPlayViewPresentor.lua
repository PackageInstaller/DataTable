-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/tips/VideoPlayViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.tips.VideoPlayViewPresentor", package.seeall)

local M = class("VideoPlayViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Guide_imageguideview_copy
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, VideoPlayView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
