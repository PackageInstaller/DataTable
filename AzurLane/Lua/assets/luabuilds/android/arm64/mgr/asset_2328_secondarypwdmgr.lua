pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.SecondaryPWDMgr = var_0_10001("SecondaryPWDMgr")

local var_0_1 = var_0.SecondaryPWDMgr

var_0_1.UNLOCK_SHIP = 1
var_0_1.UNLOCK_COMMANDER = 2
var_0_1.RESOLVE_EQUIPMENT = 3
var_0_1.CREATE_INHERIT = 4
var_0_1.CLOSE_PASSWORD = 98
var_0_1.SET_PASSWORD = 99
var_0_1.CHANGE_SETTING = 100

local function var_0_2()
	PLATFORM_CODE = var_1_10000

	if not var_1_10000 then
		return
	end

	local var_1_0 = {
		var_0_1.UNLOCK_SHIP,
		var_0_1.RESOLVE_EQUIPMENT
	}

	PLATFORM_CODE = var_1
	PLATFORM_US = var_1_10002

	if var_1 ~= var_1_10002 then
		table = var_1

		var_1.insert(var_1_0, 2, var_0_1.UNLOCK_COMMANDER)
	end

	PLATFORM_CODE = var_1
	PLATFORM_JP = var_1_10002

	if var_1 == var_1_10002 then
		-- block empty
	end

	return var_1_0
end

function var_0_1.Init(arg_2_0, arg_2_1)
	var_0_1.LIMITED_OPERATION = var_0_2()

	if arg_2_1 then
		arg_2_1()
	end

	return
end

function var_0_1.LimitedOperation(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	getProxy = var_1_10004
	SecondaryPWDProxy = var_1_10006

	local var_3_0 = var_1_10004(var_1_10006)
	local var_3_1 = var_4.getRawData(var_3_0)

	table = var_1_10006

	if not var_1_10006.contains(var_3_1.system_list, arg_3_1) then
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

	local var_3_2, var_3_3 = var_4:GetPermissionState()

	if not var_3_2 then
		arg_3_0:ShowWarningWindow()

		local var_3_4 = var_0.m02
		local var_3_5 = var_8.sendNotification

		GAME = var_1_10011

		var_3_5(var_3_4, var_1_10011.CANCEL_LIMITED_OPERATION)

		return
	end

	if var_3_1.state == 2 then
		if arg_3_3 then
			arg_3_3()
		end

		return
	end

	Context = var_8

	local var_3_6 = var_8.New
	local var_3_7 = {}

	SecondaryPasswordMediator = var_1_10011
	var_3_7.mediator = var_1_10011
	SecondaryPasswordLayer = var_1_10011
	var_3_7.viewComponent = var_1_10011

	local var_3_8 = {}

	SecondaryPasswordLayer = var_1_10012
	var_3_8.mode = var_1_10012.InputView
	var_3_8.type = arg_3_1
	var_3_8.info = arg_3_2
	var_3_8.callback = arg_3_3
	var_3_7.data = var_3_8

	local var_3_9 = var_3_6(var_3_7)

	arg_3_0:LoadLayer(var_3_9)

	return
end

function var_0_1.ChangeSetting(arg_4_0, arg_4_1, arg_4_2)
	getProxy = var_1_10003
	SecondaryPWDProxy = var_1_10005

	local var_4_0 = var_1_10003(var_1_10005)
	local var_4_1 = var_3.getRawData(var_4_0)

	table = var_1_10005

	if var_1_10005.equal(arg_4_1, var_4_1.system_list) then
		return
	end

	local var_4_2 = var_3
	local var_4_3, var_4_4 = var_3.GetPermissionState(var_4_2)

	if not var_4_3 then
		arg_4_0:ShowWarningWindow()

		local var_4_5 = var_0.m02

		var_4_2 = var_4_2.sendNotification
		GAME = var_1_10010

		var_4_2(var_4_5, var_1_10010.CANCEL_LIMITED_OPERATION)

		return
	end

	Context = var_4_2

	local var_4_6 = var_4_2.New
	local var_4_7 = {}

	SecondaryPasswordMediator = var_1_10010
	var_4_7.mediator = var_1_10010
	SecondaryPasswordLayer = var_1_10010
	var_4_7.viewComponent = var_1_10010

	local var_4_8 = {}

	SecondaryPasswordLayer = var_1_10011
	var_4_8.mode = var_1_10011.InputView

	local var_4_9

	if #arg_4_1 ~= 0 or not var_0_1.CLOSE_PASSWORD then
		var_4_9 = var_0_1.CHANGE_SETTING
	end

	var_4_8.type = var_4_9
	var_4_8.settings = arg_4_1
	var_4_8.callback = arg_4_2
	var_4_7.data = var_4_8

	local var_4_10 = var_4_6(var_4_7)

	arg_4_0:LoadLayer(var_4_10)

	return
end

function var_0_1.SetPassword(arg_5_0, arg_5_1)
	getProxy = var_1_10002
	SecondaryPWDProxy = var_1_10004

	local var_5_0 = var_1_10002(var_1_10004)

	if var_2.getRawData(var_5_0).state > 0 then
		return
	end

	Context = var_4

	local var_5_1 = var_4.New
	local var_5_2 = {}

	SecondaryPasswordMediator = var_1_10007
	var_5_2.mediator = var_1_10007
	SecondaryPasswordLayer = var_1_10007
	var_5_2.viewComponent = var_1_10007

	local var_5_3 = {}

	SecondaryPasswordLayer = var_1_10008
	var_5_3.mode = var_1_10008.SetView
	var_5_3.type = var_0_1.SET_PASSWORD
	var_5_3.settings = var_0_1.LIMITED_OPERATION
	var_5_3.callback = arg_5_1
	var_5_2.data = var_5_3

	local var_5_4 = var_5_1(var_5_2)

	arg_5_0:LoadLayer(var_5_4)

	return
end

function var_0_1.LoadLayer(arg_6_0, arg_6_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_6_0 = var_1_10002(var_1_10004)
	local var_6_1 = var_2.getCurrentContext(var_6_0)
	local var_6_2 = var_3.getContextByMediator(var_6_1, var_3.mediator)

	while var_6_2.parent do
		var_6_2 = var_6_2.parent
	end

	local var_6_3 = var_0.m02
	local var_6_4 = var_4.sendNotification

	GAME = var_7

	var_6_4(var_6_3, var_7.LOAD_LAYERS, {
		parentContext = var_6_2,
		context = arg_6_1
	})

	return
end

function var_0_1.ShowWarningWindow(arg_7_0)
	local var_7_0 = {
		mode = "showresttime",
		title = "warning",
		hideNo = true
	}

	MSGBOX_TYPE_SECONDPWD = var_1_10002
	var_7_0.type = var_1_10002

	local var_7_1 = var_0.MsgboxMgr.GetInstance()

	var_2.ShowMsgBox(var_7_1, var_7_0)

	return
end

function var_0_1.FetchData(arg_8_0)
	local var_8_0 = var_0.m02
	local var_8_1 = var_1.sendNotification

	GAME = var_1_10004

	var_8_1(var_8_0, var_1_10004.FETCH_PASSWORD_STATE)

	return
end

function var_0_1.IsNormalOp(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return false
	end

	table = var_1_10002

	return var_1_10002.contains(var_0_1.LIMITED_OPERATION, arg_9_1)
end

function var_0_1.Dispose(arg_10_0)
	return
end

return var_0_1
