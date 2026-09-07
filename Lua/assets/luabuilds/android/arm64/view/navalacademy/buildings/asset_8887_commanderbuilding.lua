local CommanderBuilding = class("CommanderBuilding", import(".NavalAcademyBuilding"))

function CommanderBuilding:GetGameObjectName()
	return "commander"
end

function CommanderBuilding:GetTitle()
	return i18n("school_title_zhihuimiao")
end

function CommanderBuilding:OnClick()
	self:emit(NavalAcademyMediator.ON_OPEN_COMMANDER)

	return
end

function CommanderBuilding:IsTip()
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

function CommanderBuilding:OnInit()
	setActive(self._tf:Find("name/lock"), not self:IsUnlock())

	return
end

function CommanderBuilding:IsUnlock()
	return pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "CommanderCatMediator")
end

return CommanderBuilding
