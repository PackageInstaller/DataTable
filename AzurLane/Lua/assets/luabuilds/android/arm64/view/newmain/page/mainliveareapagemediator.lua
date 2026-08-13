class = var_0_10000

local var_0_0 = "MainLiveAreaPageMediator"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.Mediator)

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	pg = var_1

	local var_1_0 = var_1.m02

	var_1.registerMediator(var_1_0, arg_1_0)

	return
end

function var_0_1.GoScene(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.sendNotification

	GAME = var_1_10006

	var_2_1(var_2_0, var_1_10006.GO_SCENE, arg_2_1, arg_2_2)

	return
end

function var_0_1.OpenDormSelectLayer(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.sendNotification

	GAME = var_1_10004

	local var_3_2 = var_1_10004.GO_SCENE

	SCENE = var_1_10005

	var_3_1(var_3_0, var_3_2, var_1_10005.DORM3DSELECT)

	return
end

function var_0_1.GoIsland(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.sendNotification

	GAME = var_1_10005

	var_4_1(var_4_0, var_1_10005.ISLAND_ENTER, {
		id = arg_4_1
	})

	return
end

function var_0_1.Dispose(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.m02

	var_1.removeMediator(var_5_0, arg_5_0.__cname)

	return
end

return var_0_1
