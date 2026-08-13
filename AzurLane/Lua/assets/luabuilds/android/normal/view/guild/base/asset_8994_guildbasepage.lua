class = var_0_10000

local var_0_0 = "GuildBasePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	local var_1_0, var_1_1 = arg_1_0:getTargetUI()

	getProxy = var_1_10003
	GuildProxy = var_1_10004

	local var_1_2 = var_1_10003(var_1_10004)

	if not var_3.getRawData(var_1_2) then
		return arg_1_0.uiname
	end

	local var_1_3 = var_3
	local var_1_4 = var_3.getFaction(var_1_3)

	GuildConst = var_1_3

	if var_1_4 == var_1_3.FACTION_TYPE_BLHX then
		arg_1_0.uiname = var_1_0
	else
		GuildConst = var_5

		if var_1_4 == var_5.FACTION_TYPE_CSZZ then
			arg_1_0.uiname = var_1_1
		end
	end

	return arg_1_0.uiname
end

function var_0_1.getTargetUI(arg_2_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.Destroy(arg_3_0)
	if arg_3_0._state == var_0_1.STATES.DESTROY then
		return
	end

	if not arg_3_0:GetLoaded() then
		arg_3_0._state = var_0_1.STATES.DESTROY

		return
	end

	arg_3_0._state = var_0_1.STATES.DESTROY
	pg = var_1

	var_1.DelegateInfo.Dispose(arg_3_0)
	arg_3_0:OnDestroy()
	arg_3_0:disposeEvent()
	arg_3_0:cleanManagedTween()

	arg_3_0._tf = nil
	PoolMgr = var_1

	local var_3_0 = var_1.GetInstance()
	local var_3_1 = arg_3_0.uiname

	if arg_3_0._go ~= nil and var_3_1 then
		var_3_0:ReturnUI(var_3_1, arg_3_0._go)

		arg_3_0._go = nil
	end

	return
end

return var_0_1
