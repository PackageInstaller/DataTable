local CowboyTownMediator = class("CowboyTownMediator", import("..TemplateMV.BackHillMediatorTemplate"))

CowboyTownMediator.MINI_GAME = "MINI_GAME"
CowboyTownMediator.TASK = "TASK"
CowboyTownMediator.EXPANSION = "EXPANSION"
CowboyTownMediator.STORY = "STORY"
CowboyTownMediator.SKIN = "SKIN"
CowboyTownMediator.MINI_GAME_ID = 28

function CowboyTownMediator:register()
	self:BindEvent()

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN)

	assert(var_1_0, "Building Activity Not Found")

	self.activity = var_1_0

	self.viewComponent:UpdateActivity(var_1_0)

	return
end

function CowboyTownMediator:BindEvent()
	CowboyTownMediator.super.BindEvent(self)
	self:bind(CowboyTownMediator.MINI_GAME, function()
		self:sendNotification(GAME.GO_MINI_GAME, CowboyTownMediator.MINI_GAME_ID)

		return
	end)
	self:bind(CowboyTownMediator.STORY, function()
		self:addSubLayers(Context.New({
			mediator = TownSkinMediator,
			viewComponent = TownSkinPage
		}))

		return
	end)
	self:bind(CowboyTownMediator.SKIN, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	self:bind(CowboyTownMediator.EXPANSION, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.TOWN)

		return
	end)
	self:bind(CowboyTownMediator.TASK, function(arg_7_0, arg_7_1)
		self:addSubLayers(Context.New({
			mediator = SixYearUsTaskMediator,
			viewComponent = SixYearUsTaskScene
		}))

		return
	end)

	return
end

function CowboyTownMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function CowboyTownMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()

	if var_9_0 == ActivityProxy.ACTIVITY_UPDATED then
		if arg_9_1:getBody():getConfig("type") == ActivityConst.ACTIVITY_TYPE_TownSkinStory then
			self.viewComponent:UpdateStoryView()
		end
	elseif var_9_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:UpdateTaskTips()
	end

	return
end

return CowboyTownMediator
