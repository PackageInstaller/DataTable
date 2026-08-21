-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_SetActorActive.lua

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

	local actor = HomeModule.GetRoomComponentWithId(self.args.actorId)

	if not actor then
		logError("【RPG】设置角色显隐，没有找到角色id = " .. self.args.actorId)

		return
	end

	if self.args.state == 1 then
		actor:Show()
	elseif self.args.state == 2 then
		actor:Hide()
	end

	self.isComplete = true
end

return m
