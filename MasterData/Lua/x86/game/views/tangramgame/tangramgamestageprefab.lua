local TangramGameStagePrefab = class("TangramGameStagePrefab", ReduxView)

function TangramGameStagePrefab:OnCtor(arg_1_1, arg_1_2)
	self.stageID = arg_1_2
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function TangramGameStagePrefab:Init()
	return
end

function TangramGameStagePrefab:Dispose()
	TangramGameStagePrefab.super.Dispose(self)
end

return TangramGameStagePrefab
