-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/smallsummary/ActivitySmallSummaryThreeView.lua

module("logic.extensions.operationsummary.view.smallsummary.ActivitySmallSummaryThreeView", package.seeall)

local ActivitySmallSummaryThreeView = class("ActivitySmallSummaryThreeView", ActivityGrandSummaryView)

function ActivitySmallSummaryThreeView:onEnter()
	ActivitySmallSummaryThreeView.super.onEnter(self)
	AudioPlayerEx.instance:playMusic(12003)
end

function ActivitySmallSummaryThreeView:_getSumActivityId()
	local key = self._viewPresentor.viewName
	local data = OperationSummaryConfig.instance:getSummaryStartUpData(key)

	if data == nil then
		printError(string.format("key错误,无法读到正确配置.( key = %s )", key))

		return
	end

	return data.activityId
end

function ActivitySmallSummaryThreeView:onExit()
	ActivitySmallSummaryThreeView.super.onExit(self)

	local scene = SceneMgr.instance:getCurScene()

	if scene then
		local bgmId

		if scene.bgm and scene.bgm.getBgmId then
			bgmId = scene.bgm:getBgmId()
		end

		if bgmId and bgmId ~= 0 then
			AudioPlayerEx.instance:playMusic(bgmId)
		end
	end
end

function ActivitySmallSummaryThreeView:ShowActivityTimeUI()
	return
end

return ActivitySmallSummaryThreeView
