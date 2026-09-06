-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/bingqibu/BingQiBuSummaryView.lua

module("logic.extensions.operationsummary.view.bingqibu.BingQiBuSummaryView", package.seeall)

local BingQiBuSummaryView = class("BingQiBuSummaryView", ActivityGrandSummaryView)

function BingQiBuSummaryView:_getSumActivityId()
	local key = self._viewPresentor.viewName
	local data = OperationSummaryConfig.instance:getSummaryStartUpData(key)

	if data == nil then
		printError(string.format("key错误,无法读到正确配置.( key = %s )", key))

		return
	end

	return data.activityId
end

function BingQiBuSummaryView:buildUI()
	BingQiBuSummaryView.super.buildUI(self)

	self._itemPrize = self:getGo("prize/item")
end

function BingQiBuSummaryView:onExit()
	BingQiBuSummaryView.super.onExit(self)
	MaterialMgr.resetAll(self._itemPrize)
end

function BingQiBuSummaryView:setMainUI()
	BingQiBuSummaryView.super.setMainUI(self)
	MaterialMgr.setCellByCfg("100:11033:100:1", self._itemPrize)
end

return BingQiBuSummaryView
