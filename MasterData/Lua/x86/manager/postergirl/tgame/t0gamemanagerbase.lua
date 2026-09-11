local T0GameManagerBase = class("T0GameManagerBase")

function T0GameManagerBase:Ctor()
	self.listener = EventListener.New()
end

function T0GameManagerBase:BindActorState(arg_2_1)
	self.actorState = arg_2_1
end

function T0GameManagerBase:GetBindActor()
	return nullable(self.actorState, "actor")
end

function T0GameManagerBase:GetCurMainActor()
	return nullable(manager.posterGirl, "actor")
end

function T0GameManagerBase:GetCurExtraActor(arg_5_1)
	return nullable(manager.posterGirl, "extraActor", arg_5_1)
end

function T0GameManagerBase:DisposeExtraActor(arg_6_1)
	self:GetCurExtraActor(arg_6_1):Dispose()
end

function T0GameManagerBase:Init()
	return
end

function T0GameManagerBase:Reset()
	if self.state then
		self.state:Exit(self)
	end

	self.state = nil

	self:RemoveAllStateEvents()
end

function T0GameManagerBase:RegisterStateEvents(arg_9_1, arg_9_2)
	if arg_9_2 then
		for iter_9_0, iter_9_1 in pairs(arg_9_2) do
			self.listener:Register(iter_9_0, function(...)
				iter_9_1(arg_9_1, self, ...)
			end)
		end
	end
end

function T0GameManagerBase:RemoveAllStateEvents()
	self.listener:RemoveAll()
end

function T0GameManagerBase:DoAction(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if self.actorState == nil then
		return
	end

	if arg_12_3 then
		self.actorState:PlayAniNotSkipable(arg_12_1, arg_12_2, arg_12_4)
	else
		self.actorState:PlayAni(arg_12_1, arg_12_2, arg_12_4)
	end
end

function T0GameManagerBase:DoActionByActor(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	if self.actorState == nil then
		return
	end

	if arg_13_4 then
		self.actorState:PlayAniNotSkipableByActor(arg_13_1, arg_13_2, arg_13_3, arg_13_5)
	else
		self.actorState:PlayAniByActor(arg_13_1, arg_13_2, arg_13_3, arg_13_5)
	end
end

function T0GameManagerBase:PlayTalk(arg_14_1, arg_14_2)
	self.actorState:PlaySpecialTalk(arg_14_1, arg_14_2)
end

function T0GameManagerBase:GoToState(arg_15_1, ...)
	if self.state then
		self.state:Exit(self)
	end

	self.state = arg_15_1.New()

	self.state:Enter(self, ...)
	manager.notify:Invoke("POSTERGIRL_T0_MINIGAME_ENTER_STATE", self.state, self)
end

function T0GameManagerBase:GetStateName()
	return nullable(self.state, "class", "__cname")
end

local function var_0_1(arg_17_0)
	local var_17_0 = arg_17_0:GetViewDirect()

	return var_17_0, var_17_0
end

T0GameManagerBase.SwipeToLeft = var_0_1
T0GameManagerBase.SwipeToRight = var_0_1

function T0GameManagerBase:GetViewDirect()
	return self:GetCurMainActor():GetViewDirect()
end

function T0GameManagerBase:ZoomToCamera(arg_19_1)
	return PosterTzeroPlusActor.DefaultZoomToCameraImpl(self:GetCurMainActor(), arg_19_1, 1, 0)
end

function T0GameManagerBase:StartGameImpl()
	local var_20_0 = self.New()

	manager.posterGirl.actor:ChangeState({
		class = T0PosterGameTimelineState,
		args = {
			gameInst = var_20_0
		}
	})
	var_20_0:Init()
end

return T0GameManagerBase
