local Dorm3dBaseScene = class("Dorm3dBaseScene", import("view.base.BaseUI"))

function Dorm3dBaseScene.GetDefaultSystemClasses()
	return DormConst.GetDefaultSystemClasses()
end

function Dorm3dBaseScene:InitExtraSystem(arg_2_1)
	self.systemManager = self.systemManager or ExtraSystemManager.New(self.event, self)
	arg_2_1 = arg_2_1 or self.GetDefaultSystemClasses()

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		self.systemManager:Register(iter_2_1)
	end

	return
end

function Dorm3dBaseScene:RemoveExtraSystem(arg_3_1)
	if not self.systemManager then
		return
	end

	arg_3_1 = arg_3_1 or self.GetDefaultSystemClasses()

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		self.systemManager:Remove(iter_3_1)
	end

	return
end

function Dorm3dBaseScene:GetExtraSystem(arg_4_1)
	if not self.systemManager then
		return nil
	end

	return self.systemManager:Get(arg_4_1)
end

function Dorm3dBaseScene:willExit()
	self:RemoveExtraSystem()

	if self.systemManager then
		self.systemManager:Dispose()

		self.systemManager = nil
	end

	return
end

return Dorm3dBaseScene
