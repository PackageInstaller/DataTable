-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/MultiFunctionViewPresentor.lua

module("logic.extensions.common.view.MultiFunctionViewPresentor", package.seeall)

local M = class("MultiFunctionViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.MultiFunciton_common_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Authority)
	}
end

function M:buildViews()
	local views = {}

	self._mainView = MultiFuncitonView.New()

	table.insert(views, self._mainView)

	self._timelineGadget = GuiTimelineGadgetView.New()

	table.insert(views, self._timelineGadget)

	return views
end

function M:onClickOutside()
	self._mainView:onClickOutside(self._timelineGadget:getOpenAniFinish())
end

return M
