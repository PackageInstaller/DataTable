local var_0_0 = class("GuildBasePage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	local var_1_0, var_1_1 = arg_1_0:getTargetUI()
	local var_1_2 = getProxy(GuildProxy):getRawData()

	if not var_1_2 then
		return arg_1_0.uiname
	end

	local var_1_3 = var_1_2:getFaction()

	if var_1_3 == GuildConst.FACTION_TYPE_BLHX then
		arg_1_0.uiname = var_1_0
	elseif var_1_3 == GuildConst.FACTION_TYPE_CSZZ then
		arg_1_0.uiname = var_1_1
	end

	return arg_1_0.uiname
end

function var_0_0.getTargetUI(arg_2_0)
	assert(false)

	return
end

function var_0_0.Destroy(arg_3_0)
	if arg_3_0._state == var_0_0.STATES.DESTROY then
		return
	end

	if not arg_3_0:GetLoaded() then
		arg_3_0._state = var_0_0.STATES.DESTROY

		return
	end

	arg_3_0._state = var_0_0.STATES.DESTROY

	pg.DelegateInfo.Dispose(arg_3_0)
	arg_3_0:OnDestroy()
	arg_3_0:disposeEvent()
	arg_3_0:cleanManagedTween()

	arg_3_0._tf = nil

	if arg_3_0._go ~= nil and arg_3_0.uiname then
		PoolMgr.GetInstance():ReturnUI(arg_3_0.uiname, arg_3_0._go)

		arg_3_0._go = nil
	end

	return
end

return var_0_0
