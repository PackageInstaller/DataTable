local var_0_0 = class("MinigameHallBuilding", import(".NavalAcademyBuilding"))

function var_0_0.GetGameObjectName(arg_1_0)
	return "minigamehall"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("school_title_xiaoyouxiting")
end

function var_0_0.OnInit(arg_3_0)
	setActive(arg_3_0._tf, not LOCK_MINIGAME_HALL)
	setActive(arg_3_0._tf:Find("name/lock"), not arg_3_0:IsUnlock())

	return
end

function var_0_0.OnClick(arg_4_0)
	arg_4_0:emit(NavalAcademyMediator.ON_OPEN_MINIGAMEHALL)

	return
end

function var_0_0.IsUnlock(arg_5_0)
	return pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "GameHallMediator")
end

function var_0_0.IsTip(arg_6_0)
	return false
end

return var_0_0
