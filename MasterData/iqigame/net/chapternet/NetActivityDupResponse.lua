-- chunkname: @IQIGame\\Net\\ChapterNet\\NetActivityDupResponse.lua

function net_activityDup.enterDupResult(code)
	GameChapterModule.EnterDup(Constant.ChapterPassType.TYPE_BattleActivity)
end

function net_activityDup.receiveRewardResult(code, itemShowPODS)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShowPODS)
	EventDispatcher.Dispatch(EventID.ActivityDupReceiveRewardResultEvent)
end

function net_activityDup.notifyDup(dupPODs)
	local len = #dupPODs

	for i = 1, len do
		local isHave = false

		for j, v in pairs(PlayerModule.PlayerInfo.activityDups) do
			if v.chapterId == dupPODs[i].chapterId then
				PlayerModule.PlayerInfo.activityDups[j] = dupPODs[i]
				isHave = true

				break
			end
		end

		if not isHave then
			table.insert(PlayerModule.PlayerInfo.activityDups, dupPODs[i])
		end
	end

	RedDotModule.CheckRedDot_BattleActivity()
	EventDispatcher.Dispatch(EventID.BattleActivityNotifyDupEvent)
end

function net_activityDup.notifyRemoveDup(dupPOD)
	for j, v in pairs(PlayerModule.PlayerInfo.activityDups) do
		if v.chapterId == dupPOD.chapterId then
			PlayerModule.PlayerInfo.activityDups[j] = nil

			break
		end
	end
end

function net_activityDup.notifyFinishDup(fightOverPOD)
	return
end
