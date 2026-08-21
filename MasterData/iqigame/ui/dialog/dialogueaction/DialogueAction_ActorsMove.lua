-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_ActorsMove.lua

local DialogueBase = require("IQIGame/UI/Dialog/DialogueAction/DialogueActionBase")
local m = classF(DialogueBase)

function m:ctor(args)
	self.args = args
	self.isComplete = false
end

function m:OnStart()
	if self.isComplete then
		return
	end

	self.moveActorArray = {}

	local len = #self.args.moveData

	for i = 1, len do
		local actor = HomeModule.GetRoomComponentWithId(self.args.moveData[i].actorId)

		if not actor then
			logError("【RPG】多人移动，没有找到角色id = " .. self.args.moveData[i].actorId)

			return
		end

		actor.controller.autoMoveController:SetWalkingAnimateName(self.args.moveData[i].animationName)
		actor.controller.autoMoveController:SetSpeed(self.args.moveData[i].moveSpeed)

		local index = i

		actor:StartMove(self.args.moveData[i].endPos, function()
			self.moveActorArray[index].moveSuccess = true
		end)

		local data = {}

		data.actor = actor
		data.startTime = Time.time
		data.startPos = actor.transform.position
		data.moveSuccess = false

		table.insert(self.moveActorArray, data)
	end

	self.dStartTime = Time.time
end

function m:OnUpdate()
	if self.isComplete then
		return
	end

	local len = #self.moveActorArray
	local isAllPass = true

	for i = 1, len do
		if not self.moveActorArray[i].moveSuccess then
			local actor = self.moveActorArray[i].actor

			if Time.time - self.dStartTime > 1 and Vector3.Distance(actor.transform.position, self.moveActorArray[i].startPos) <= 0.01 then
				actor:StopMove()

				actor.transform.position = self.args.moveData[i].endPos
				self.moveActorArray[i].moveSuccess = true
			end
		end

		if not self.moveActorArray[i].moveSuccess then
			isAllPass = false

			break
		end
	end

	if isAllPass then
		self.isComplete = true
	end
end

function m:OnSkip()
	local len = #self.moveActorArray

	for i = 1, len do
		self.moveActorArray[i].actor:StopMove()

		self.moveActorArray[i].actor.transform.position = self.args.moveData[i].endPos
	end

	self.isComplete = true
end

return m
