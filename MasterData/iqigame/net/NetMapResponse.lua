-- chunkname: @IQIGame\\Net\\NetMapResponse.lua

function net_mapData.enterMapResult(code, mapDatas)
	MapModule.EnterMapResult(mapDatas)
end

function net_mapData.exitMapResult(code)
	MapModule.ExitMapResult()
end

function net_mapData.notifyUpdateMapSmall(mapDatas)
	MapModule.NotifyUpdateMapSmall(mapDatas)
end

function net_mapData.notifyUpdateMapItem(mapDatas)
	MapModule.NotifyUpdateMapItem(mapDatas)
end

function net_mapData.takeNotesEffectIdResult(code)
	MapModule.TakeNotesEffectIdResult()
end

function net_randomDup.enterDupResult(code)
	GameChapterModule.EnterDup(Constant.ChapterPassType.TYPE_RANDOMDAILY)
end

function net_randomDup.notifyDup(dupPODs)
	MapModule.NotifyDailyDup(dupPODs)
end

function net_randomDup.notifyFinishDup(randomDupPOD)
	MapModule.NotifyFinishDup(randomDupPOD)
end

function net_challengeDup.enterDupResult(code)
	GameChapterModule.EnterDup(Constant.ChapterPassType.TYPE_Challenge)
end

function net_challengeDup.notifyFinishDup(challengeDupPOD)
	PlayerModule.PlayerInfo.challengeDups[challengeDupPOD.cid] = challengeDupPOD
end
