-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemopen/view/OpenFunctionsHintTipsPresentor.lua

module("logic.extensions.systemopen.view.OpenFunctionsHintTipsPresentor", package.seeall)

local M = class("OpenFunctionsHintTipsPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Open_functions_open_functions_hint_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, OpenFunctionsHintTips.New())
	table.insert(views, BlurBgView.New())

	self._timelineGadget = GuiTimelineGadgetView.New()

	table.insert(views, self._timelineGadget)

	return views
end

function M:getTimelineGadgetView()
	return self._timelineGadget
end

function M:onClickOutside()
	return
end

return M
