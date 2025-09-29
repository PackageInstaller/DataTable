-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveCutlineViewPresentor.lua

module("logic.extensions.retrieve.view.RetrieveCutlineViewPresentor", package.seeall)

local M = class("RetrieveCutlineViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.RetrievePreviewTips,
		ResName.RetrieveHeroPreviewItem,
		ResName.RetrievePreviewScrollItem,
		ResName.DynSpriteAtlas_RetrieveMainView
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RetrieveCutlineView.New())

	self._blurView = BlurBgView.New("common_blur_rt")

	table.insert(views, self._blurView)

	return views
end

function M:getBlurView()
	return self._blurView
end

return M
