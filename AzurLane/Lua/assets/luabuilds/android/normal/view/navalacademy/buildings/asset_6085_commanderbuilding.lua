class = var_0_10000

local var_0_0 = "CommanderBuilding"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NavalAcademyBuilding"))

function var_0_1.GetGameObjectName(arg_1_0)
	return "commander"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("school_title_zhihuimiao")
end

function var_0_1.OnClick(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.emit

	NavalAcademyMediator = var_1_10003

	var_3_1(var_3_0, var_1_10003.ON_OPEN_COMMANDER)

	return
end

function var_0_1.IsTip(arg_4_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)

	if var_1.getRawData(var_4_0).level < 40 then
		return false
	end

	getProxy = var_1
	CommanderProxy = var_2

	local var_4_1 = var_1(var_2)
	local var_4_2 = var_1.haveFinishedBox(var_4_1)

	LOCK_CATTERY = var_4_1

	if not var_4_1 then
		if not var_4_2 then
			::label_4_0::

			getProxy = var_4_1
			CommanderProxy = var_1_10003

			local var_4_3 = var_4_1(var_1_10003)

			if not var_4_1.AnyCatteryExistOP(var_4_3) then
				getProxy = var_4_1
				CommanderProxy = var_4_3

				local var_4_4 = var_4_1(var_4_3)

				var_4_1 = var_4_1.AnyCatteryCanUse(var_4_4)
			end
		end

		return var_4_1
	else
		return var_4_2
	end

	return
end

function var_0_1.OnInit(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.IsUnlock(var_5_0)

	setActive = var_5_0

	local var_5_2 = arg_5_0._tf

	var_5_0(var_3.Find(var_5_2, "name/lock"), not var_5_1)

	return
end

function var_0_1.IsUnlock(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.SystemOpenMgr.GetInstance()
	local var_6_1 = var_1.isOpenSystem

	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_6_2 = var_1_10003(var_1_10004)

	return var_6_1(var_6_0, var_3.getRawData(var_6_2).level, "CommanderCatMediator")
end

return var_0_1
