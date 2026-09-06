-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivityMagicSchoolsummaryViewPresentor.lua

module("logic.extensions.operationsummary.view.ActivityMagicSchoolsummaryViewPresentor", package.seeall)

local ActivityMagicSchoolsummaryViewPresentor = class("ActivityMagicSchoolsummaryViewPresentor", ViewPresentor)

function ActivityMagicSchoolsummaryViewPresentor:ctor()
	ActivityMagicSchoolsummaryViewPresentor.super.ctor(self)
end

function ActivityMagicSchoolsummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivityMagicSchoolsummaryViewPresentor:dependWhatResources()
	local key = self.viewName
	local data = OperationSummaryConfig.instance:getSummaryStartUpData(key)

	if data == nil then
		printError(string.format("key错误,无法读到正确配置.( key = %s )", key))
	end

	local viewprefab = data.viewPrefab

	return {
		"ui/views/operationsummary/" .. viewprefab .. ".prefab"
	}
end

function ActivityMagicSchoolsummaryViewPresentor:buildViews()
	return {
		ActivityMagicSchoolsummaryView.New()
	}
end

return ActivityMagicSchoolsummaryViewPresentor
