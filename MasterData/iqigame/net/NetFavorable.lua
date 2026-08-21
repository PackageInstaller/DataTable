-- chunkname: @IQIGame\\Net\\NetFavorable.lua

function net_favorable.enterDupResult(code)
	warning("please override this function -> net_favorable.enterDupResult!")
end

function net_favorable.playSoundResult(code)
	EventDispatcher.Dispatch(EventID.RolePlaySoundEvent)
end

function net_favorable.viewDeedResult(code)
	EventDispatcher.Dispatch(EventID.RoleDeedsSelect)
end

function net_favorable.notifyFinishDup(fightOverPOD)
	EventDispatcher.Dispatch(EventID.RoleStageViewRefreshEvent)
end
