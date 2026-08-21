-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_SetStandPaintPos.lua

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

	EventDispatcher.Dispatch(EventID.CommonDialogPanel_SetLREvent, self.args.dir)

	self.isComplete = true
end

return m
