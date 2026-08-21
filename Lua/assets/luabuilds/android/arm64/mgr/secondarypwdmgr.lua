pg = pg or {}

local var_0_0 = pg

pg.SecondaryPWDMgr = singletonClass("SecondaryPWDMgr")

local var_0_1 = pg.SecondaryPWDMgr

pg.SecondaryPWDMgr.UNLOCK_SHIP = 1
pg.SecondaryPWDMgr.UNLOCK_COMMANDER = 2
pg.SecondaryPWDMgr.RESOLVE_EQUIPMENT = 3
pg.SecondaryPWDMgr.CREATE_INHERIT = 4
pg.SecondaryPWDMgr.CLOSE_PASSWORD = 98
pg.SecondaryPWDMgr.SET_PASSWORD = 99
pg.SecondaryPWDMgr.CHANGE_SETTING = 100

local function var_0_2()
	if not PLATFORM_CODE then
		return
	end

	local var_1_0 = {
		var_0_1.UNLOCK_SHIP,
		var_0_1.RESOLVE_EQUIPMENT
	}

	if PLATFORM_CODE ~= PLATFORM_US then
		table.insert(var_1_0, 2, var_0_1.UNLOCK_COMMANDER)
	end

	if PLATFORM_CODE == PLATFORM_JP then
		-- block empty
	end

	return var_1_0
end

function pg.SecondaryPWDMgr.Init(arg_2_0, arg_2_1)
	var_0_1.LIMITED_OPERATION = var_0_2()

	if arg_2_1 then
		arg_2_1()
	end

	return
end

function pg.SecondaryPWDMgr.LimitedOperation(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = getProxy(SecondaryPWDProxy)
	local var_3_1 = var_3_0:getRawData()

	if not table.contains(var_3_1.system_list, arg_3_1) then
		if arg_3_3 then
			arg_3_3()
		end

		return
	end

	if var_3_1.state == 0 then
		if arg_3_3 then
			arg_3_3()
		end

		return
	end

	local var_3_2, var_3_3 = var_3_0:GetPermissionState()

	if not var_3_2 then
		arg_3_0:ShowWarningWindow()
		var_0_0.m02:sendNotification(GAME.CANCEL_LIMITED_OPERATION)

		return
	end

	if var_3_1.state == 2 then
		if arg_3_3 then
			arg_3_3()
		end

		return
	end

	arg_3_0:LoadLayer((Context.New({
		mediator = SecondaryPasswordMediator,
		viewComponent = SecondaryPasswordLayer,
		data = {
			mode = SecondaryPasswordLayer.InputView,
			type = arg_3_1,
			info = arg_3_2,
			callback = arg_3_3
		}
	})))

	return
end

function pg.SecondaryPWDMgr.ChangeSetting(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = getProxy(SecondaryPWDProxy)

	if table.equal(arg_4_1, var_4_0:getRawData().system_list) then
		return
	end

	local var_4_1, var_4_2 = var_4_0:GetPermissionState()

	if not var_4_1 then
		arg_4_0:ShowWarningWindow()
		var_0_0.m02:sendNotification(GAME.CANCEL_LIMITED_OPERATION)

		return
	end

	local var_4_4 = {
		mediator = SecondaryPasswordMediator,
		viewComponent = SecondaryPasswordLayer
	}
	local var_4_5 = {
		mode = SecondaryPasswordLayer.InputView
	}

	if #arg_4_1 == 0 then
		var_4_5.type = var_0_1.CLOSE_PASSWORD or var_0_1.CHANGE_SETTING
		var_4_5.settings = arg_4_1
		var_4_5.callback = arg_4_2
		var_4_4.data = var_4_5

		arg_4_0:LoadLayer((var_4_3(var_4_4)))

		return
	end
end

function pg.SecondaryPWDMgr.SetPassword(arg_5_0, arg_5_1)
	if getProxy(SecondaryPWDProxy):getRawData().state > 0 then
		return
	end

	arg_5_0:LoadLayer((Context.New({
		mediator = SecondaryPasswordMediator,
		viewComponent = SecondaryPasswordLayer,
		data = {
			mode = SecondaryPasswordLayer.SetView,
			type = var_0_1.SET_PASSWORD,
			settings = var_0_1.LIMITED_OPERATION,
			callback = arg_5_1
		}
	})))

	return
end

function pg.SecondaryPWDMgr.LoadLayer(arg_6_0, arg_6_1)
	local var_6_0 = getProxy(ContextProxy):getCurrentContext()
	local var_6_1 = var_6_0:getContextByMediator(var_6_0.mediator)

	while var_6_1.parent do
		var_6_1 = var_6_1.parent
	end

	var_0_0.m02:sendNotification(GAME.LOAD_LAYERS, {
		parentContext = var_6_1,
		context = arg_6_1
	})

	return
end

function pg.SecondaryPWDMgr.ShowWarningWindow(arg_7_0)
	var_0_0.MsgboxMgr.GetInstance():ShowMsgBox({
		mode = "showresttime",
		title = "warning",
		hideNo = true,
		type = MSGBOX_TYPE_SECONDPWD
	})

	return
end

function pg.SecondaryPWDMgr.FetchData(arg_8_0)
	var_0_0.m02:sendNotification(GAME.FETCH_PASSWORD_STATE)

	return
end

function pg.SecondaryPWDMgr.IsNormalOp(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return false
	end

	return table.contains(var_0_1.LIMITED_OPERATION, arg_9_1)
end

function pg.SecondaryPWDMgr.Dispose(arg_10_0)
	return
end

return pg.SecondaryPWDMgr
