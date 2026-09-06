-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/paladin/ActivitypaladinsummaryView.lua

module("logic.extensions.operationsummary.view.paladin.ActivitypaladinsummaryView", package.seeall)

local ActivitypaladinsummaryView = class("ActivitypaladinsummaryView", ActivityGrandSummaryView)

function ActivitypaladinsummaryView:onExit()
	ActivitypaladinsummaryView.super.onExit(self)

	if self._actCellList then
		for _, cell in pairs(self._actCellList) do
			if cell.petScroll then
				cell.petScroll:dispose()
			end
		end
	end
end

function ActivitypaladinsummaryView:_getSumActivityId()
	local key = self._viewPresentor.viewName
	local data = OperationSummaryConfig.instance:getSummaryStartUpData(key)

	if data == nil then
		printError(string.format("key错误,无法读到正确配置.( key = %s )", key))

		return
	end

	return data.activityId
end

function ActivitypaladinsummaryView:onEnter()
	ActivitypaladinsummaryView.super.onEnter(self)
	RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_PALADINSUMMARYFEATURE)
end

function ActivitypaladinsummaryView:updateActivityCell(cell)
	ActivitypaladinsummaryView.super.updateActivityCell(self, cell)

	if cell.data.paramObj and cell.data.paramObj.skinIdList then
		if cell.petScroll == nil then
			local tableCell = goutil.findChild(cell.mainGo, "node/tablecell")
			local tableView = goutil.findChild(cell.mainGo, "node/tableview")

			cell.petScroll = ScrollerList.create(tableView, tableCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

			GameUtil.SetActive(tableCell, false)
		end

		local skinList = string.split(cell.data.paramObj.skinIdList, "#")

		cell.petScroll:reloadData(skinList)
	end
end

function ActivitypaladinsummaryView:_updatePetCell(view, cell, data)
	MaterialMgr.setCell(MatType.Pet, data, cell)
end

function ActivitypaladinsummaryView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell)
end

return ActivitypaladinsummaryView
