local MainLiveAreaPageMediator = class("MainLiveAreaPageMediator", pm.Mediator)

function MainLiveAreaPageMediator:Ctor()
	MainLiveAreaPageMediator.super.Ctor(self)
	pg.m02:registerMediator(self)

	return
end

function MainLiveAreaPageMediator:GoScene(arg_2_1, arg_2_2)
	self:sendNotification(GAME.GO_SCENE, arg_2_1, arg_2_2)

	return
end

function MainLiveAreaPageMediator:OpenDormSelectLayer()
	self:sendNotification(GAME.GO_SCENE, SCENE.DORM3DSELECT)

	return
end

function MainLiveAreaPageMediator:GoIsland(arg_4_1)
	self:sendNotification(GAME.ISLAND_ENTER, {
		id = arg_4_1
	})

	return
end

function MainLiveAreaPageMediator:Dispose()
	pg.m02:removeMediator(self.__cname)

	return
end

return MainLiveAreaPageMediator
