-- chunkname: @IQIGame\\Net\\NetPlotStageResponse.lua

function net_plotStage.saveLevelResult(code, plotStageDupPOD)
	StoryModule.saveLevelResult(code, plotStageDupPOD)
end

function net_plotStage.enterFightResult(code)
	EventDispatcher.Dispatch(EventID.StoryStartFight)
end

function net_plotStage.completeLevelResult(code, exit)
	return
end

function net_generalDup.notifyFinishDup(completePOD, stageCid)
	StoryChapterModule.NotifyFinishDup(completePOD, stageCid)
end

function net_plotStage.notifyStartPlot(plotStageDupPODs)
	StoryModule.notifyStartPlot(plotStageDupPODs)
end

function net_generalDup.notifyDup(dups)
	StoryChapterModule.RefreshFinishDup(dups)
end

function net_plotStage.notifyTempWarehouse(items, notify)
	StoryModule.NotifyTempWarehouse(items, notify)
end

function net_plotStage.setExtensionResult(code, add, extension)
	StoryModule.setExtensionResult(code, add, extension)
end

function net_plotStage.removeExtensionResult(code, keys)
	StoryModule.removeExtensionResult(code, keys)
end

function net_plotStage.triggerActionResult_delegate(code, items)
	NetCommController.Responded()
	StoryModule.triggerActionResult(code, items)
end
