-- chunkname: @IQIGame\\Scene\\Home\\Controller\\ArticleController.lua

local ActorController = require("IQIGame/Scene/Home/Controller/ActorController")
local m = Clone(ActorController)
local chatStateClass = require("IQIGame/Scene/Home/FSM/RPGActorState_Chat")

function m:__OnInit()
	self:InitAction()
	self:InitFSM()
	self.actor.actorComponent.triggerEnterEvent:AddListener(self.onCollisionEnterEvent)
	self.actor.actorComponent.triggerExitEvent:AddListener(self.onCollisionEXitEvent)

	local componentData = WorldMapModule.GetComponentDataWithId(self.actor.componentId)

	self.actor:ChangeDirection(not componentData:GetCfg().IsToLeft)
	self:__OnControllerReady()
end

function m:__OnInitEventDelegate()
	function self.onCollisionEnterEvent(actorCom)
		self:onCollisionEnter(actorCom)
	end

	function self.onCollisionEXitEvent(actorCom)
		self:OnCollisionExit(actorCom)
	end
end

function m:__OnAddListeners()
	return
end

function m:__OnRemoveListeners()
	return
end

function m:__OnDispose()
	self.actor.actorComponent.triggerEnterEvent:RemoveListener(self.onCollisionEnterEvent)
	self.actor.actorComponent.triggerExitEvent:RemoveListener(self.onCollisionEXitEvent)
	FSMModule.RemoveFsm(self.fsm)
end

function m:onCollisionEnter(actorCom)
	WorldMapModule.OnActorInteractPlayer(self.actor)
end

function m:OnCollisionExit(actorCom)
	WorldMapModule.OnACtorDisInteractPlayer(self.actor)
end

function m:InitAction()
	self.haveTag = false

	local componentData = WorldMapModule.GetComponentDataWithId(self.actor.componentId)
	local actionList = componentData:GetActionList()
	local topTag

	for _, v in pairs(actionList) do
		local cfgAction = v:GetCfg()

		if v:CheckIsActiveTag() then
			if not topTag then
				topTag = cfgAction.IconType
			elseif topTag > cfgAction.IconType then
				topTag = cfgAction.IconType
			end
		end
	end

	if topTag then
		local actor = HomeModule.GetRoomComponentWithId(self.actor.componentId)

		EventDispatcher.Dispatch(EventID.MainUI_ShowNpcTagEvent, actor:GetTagMountPoint(), topTag, self.actor:GetComponentId())

		self.haveTag = true
		self.tagType = topTag
	end
end

function m:InitFSM()
	if not self.fsm then
		self.fsm = FSMModule.CreateFsm(Constant.FSMType.RPGActorFSM, {
			actor = self.actor
		})
	end

	self.fsm:AddState(chatStateClass())
end

function m:ChangeStateByName(stateName, args)
	self.fsm:ChangeStateByName(stateName, args)
end

return m
