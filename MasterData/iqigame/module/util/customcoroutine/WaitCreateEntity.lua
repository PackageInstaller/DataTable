-- chunkname: @IQIGame\\Module\\Util\\CustomCoroutine\\WaitCreateEntity.lua

WaitCreateEntity = class({
	waitType = "WaitCreateEntity"
}, CustomWait)
WaitCreateEntity.IsLog = false

function WaitCreateEntity:ctor(waitLoadingEntityID, callback)
	self.waitLoadingEntityID = waitLoadingEntityID
	self.loadCompleteCallBack = callback

	function self.delegateOnShowEntitySucess(sender, args)
		self:OnShowEntitySucess(args)
	end

	function self.delegateOnShowEntityFailure(sender, args)
		self:OnShowEntityFailure(args)
	end

	self:OnAddListeners()
end

function WaitCreateEntity:OnAddListeners()
	GameEntry.LuaEvent:Subscribe(ShowEntitySuccessEventArgs.EventId, self.delegateOnShowEntitySucess)
	GameEntry.LuaEvent:Subscribe(ShowEntityFailureEventArgs.EventId, self.delegateOnShowEntityFailure)
end

function WaitCreateEntity:OnRemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(ShowEntitySuccessEventArgs.EventId, self.delegateOnShowEntitySucess)
	GameEntry.LuaEvent:Unsubscribe(ShowEntityFailureEventArgs.EventId, self.delegateOnShowEntityFailure)
end

function WaitCreateEntity:OnShowEntitySucess(args)
	if args ~= nil then
		local entityId = args.Entity.Id

		if entityId == self.waitLoadingEntityID then
			self:OnRemoveListeners()

			if WaitCreateEntity.IsLog then
				logDebug("WaitCreateEntity:OnShowEntitySucess:  entityId={0}", entityId)
			end

			if self.loadCompleteCallBack ~= nil then
				self.loadCompleteCallBack(args.Entity, true)
			end

			self.result = entityId
			self.isComplete = true
		end
	end
end

function WaitCreateEntity:OnShowEntityFailure(args)
	if args ~= nil then
		local entityId = args.Entity.Id

		if entityId == self.waitLoadingEntityID then
			self:OnRemoveListeners()
			logError("WaitCreateEntity:OnShowEntityFailure:  waitLoadingEntityID={0}  entityId={1}", self.waitLoadingEntityID, entityId)

			if self.loadCompleteCallBack ~= nil then
				self.loadCompleteCallBack(args.Entity, false)
			end

			self.result = entityId
			self.isComplete = true
		end
	end
end

return WaitCreateEntity
