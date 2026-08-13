class = var_0_10000

local var_0_0 = "MinigameHallBuilding"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NavalAcademyBuilding"))

function var_0_1.GetGameObjectName(arg_1_0)
	return "minigamehall"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("school_title_xiaoyouxiting")
end

function var_0_1.OnInit(arg_3_0)
	setActive = var_1_10001

	local var_3_0 = arg_3_0._tf

	LOCK_MINIGAME_HALL = var_1_10003

	var_1_10001(var_3_0, not var_1_10003)

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.IsUnlock(var_3_1)

	setActive = var_3_1

	local var_3_3 = arg_3_0._tf

	var_3_1(var_3.Find(var_3_3, "name/lock"), not var_3_2)

	return
end

function var_0_1.OnClick(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.emit

	NavalAcademyMediator = var_1_10003

	var_4_1(var_4_0, var_1_10003.ON_OPEN_MINIGAMEHALL)

	return
end

function var_0_1.IsUnlock(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.SystemOpenMgr.GetInstance()
	local var_5_1 = var_1.isOpenSystem

	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_5_2 = var_1_10003(var_1_10004)

	return var_5_1(var_5_0, var_3.getRawData(var_5_2).level, "GameHallMediator")
end

function var_0_1.IsTip(arg_6_0)
	return false
end

return var_0_1
