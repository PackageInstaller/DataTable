local var_0_0 = class("CommanderBuilding", import(".NavalAcademyBuilding"))

function var_0_0.GetGameObjectName(arg_1_0)
	return "commander"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("school_title_zhihuimiao")
end

function var_0_0.OnClick(arg_3_0)
	arg_3_0:emit(NavalAcademyMediator.ON_OPEN_COMMANDER)

	return
end

function var_0_0.IsTip(arg_4_0)
	if getProxy(PlayerProxy):getRawData().level < 40 then
		return false
	end

	local var_4_0 = getProxy(CommanderProxy):haveFinishedBox()

	if not LOCK_CATTERY then
		local var_4_1

		if not var_4_0 then
			::label_4_0::

			var_4_1 = getProxy(CommanderProxy):AnyCatteryExistOP()
			var_4_1 = var_4_1 or getProxy(CommanderProxy):AnyCatteryCanUse()
		end

		return var_4_1
	else
		return var_4_0
	end

	return
end

function var_0_0.OnInit(arg_5_0)
	setActive(arg_5_0._tf:Find("name/lock"), not arg_5_0:IsUnlock())

	return
end

function var_0_0.IsUnlock(arg_6_0)
	return pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "CommanderCatMediator")
end

return var_0_0
