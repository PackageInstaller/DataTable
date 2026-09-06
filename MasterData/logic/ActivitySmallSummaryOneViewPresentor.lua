-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/smallsummary/ActivitySmallSummaryOneViewPresentor.lua

module("logic.extensions.operationsummary.view.smallsummary.ActivitySmallSummaryOneViewPresentor", package.seeall)

local ActivitySmallSummaryOneViewPresentor = class("ActivitySmallSummaryOneViewPresentor", ViewPresentor)

function ActivitySmallSummaryOneViewPresentor:ctor()
	ActivitySmallSummaryOneViewPresentor.super.ctor(self)
end

function ActivitySmallSummaryOneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivitySmallSummaryOneViewPresentor:dependWhatResources()
	local key = self.viewName
	local data = OperationSummaryConfig.instance:getSummaryStartUpData(key)

	if data == nil then
		printError(string.format("key错误,无法读到正确配置.( key = %s )", key))
	end

	local resources = {}

	table.insert(resources, string.format("ui/views/operationsummary/%s.prefab", data.viewPrefab))

	local cfg = OperationSummaryConfig.instance:getTaskBaseCfg(data.activityId)

	if cfg then
		if not string.nilorempty(cfg.effect) then
			table.insert(resources, string.format("effect/prefabs/ui/%s.prefab", cfg.effect))
		end

		if not string.nilorempty(cfg.bgName) then
			table.insert(resources, string.format(string.format("ui/bigbg/%s.png", cfg.bgName)))
		end
	end

	return resources
end

function ActivitySmallSummaryOneViewPresentor:buildViews()
	return {
		ActivitySmallSummaryOneView.New()
	}
end

return ActivitySmallSummaryOneViewPresentor
