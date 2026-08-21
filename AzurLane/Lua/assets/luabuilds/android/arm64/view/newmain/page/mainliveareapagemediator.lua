local var_0_0 = class("MainLiveAreaPageMediator", pm.Mediator)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	pg.m02:registerMediator(arg_1_0)

	return
end

function var_0_0.GoScene(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:sendNotification(GAME.GO_SCENE, arg_2_1, arg_2_2)

	return
end

function var_0_0.OpenDormSelectLayer(arg_3_0)
	arg_3_0:sendNotification(GAME.GO_SCENE, SCENE.DORM3DSELECT)

	return
end

function var_0_0.GoIsland(arg_4_0, arg_4_1)
	arg_4_0:sendNotification(GAME.ISLAND_ENTER, {
		id = arg_4_1
	})

	return
end

function var_0_0.Dispose(arg_5_0)
	pg.m02:removeMediator(arg_5_0.__cname)

	return
end

return var_0_0
