-- chunkname: @IQIGame\\Net\\NetLotteryResponse.lua

function net_draw.drawResult(code, drawResultPODS)
	LotteryModule.LotteryResult(drawResultPODS)
end

function net_draw.drawRecordResult(code, drawRecordPODS)
	LotteryModule.LotteryRecords(drawRecordPODS)
end

function net_draw.notifyUpdateDraw(DrawPODs)
	LotteryModule.NotifyLotteryUpdate(DrawPODs)
end

function net_draw.notifyAddDraw(DrawPODs)
	LotteryModule.NotifyLotteryAdd(DrawPODs)
end

function net_draw.notifyRemoveDraw(DrawPODs)
	LotteryModule.NotifyLotteryRemove(DrawPODs)
end

function net_draw.historyResult()
	LotteryModule.RecordDrawResult()
end

function net_draw.cancelResult()
	LotteryModule.CancelDrawResult()
end

function net_draw.confirmResult()
	LotteryModule.ConfrimDrawResult()
end

function net_draw.chooseShowGroupResult(code, showGroupId, cardId)
	LotteryModule.UpdateShowGroupRecordData(showGroupId, cardId, true)
end
