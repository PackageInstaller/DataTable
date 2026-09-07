local MinigameHallBuilding = class("MinigameHallBuilding", import(".NavalAcademyBuilding"))

function MinigameHallBuilding:GetGameObjectName()
	return "minigamehall"
end

function MinigameHallBuilding:GetTitle()
	return i18n("school_title_xiaoyouxiting")
end

function MinigameHallBuilding:OnInit()
	setActive(self._tf, not LOCK_MINIGAME_HALL)
	setActive(self._tf:Find("name/lock"), not self:IsUnlock())

	return
end

function MinigameHallBuilding:OnClick()
	self:emit(NavalAcademyMediator.ON_OPEN_MINIGAMEHALL)

	return
end

function MinigameHallBuilding:IsUnlock()
	return pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "GameHallMediator")
end

function MinigameHallBuilding:IsTip()
	return false
end

return MinigameHallBuilding
