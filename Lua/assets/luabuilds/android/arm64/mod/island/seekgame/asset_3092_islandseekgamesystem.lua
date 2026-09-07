local IslandSeekGameSystem = class("IslandSeekGameSystem", import("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function IslandSeekGameSystem:OnSceneInitEnd()
	self.MONITOR_LIST = self.data:GetInteractiveObjects()

	for iter_1_0, iter_1_1 in ipairs(self:GetObjUnitList()) do
		if iter_1_1.behaviourTreeOwner then
			LuaHelper.NodeCanvasSetIntVariableValue(iter_1_1.behaviourTreeOwner, "systemId", self.id)
		end
	end

	if self.behaviourTreeOwner then
		LuaHelper.NodeCanvasSetIntVariableValue(self.behaviourTreeOwner, "step", 0)
	end

	self:Start()

	return
end

function IslandSeekGameSystem:StartGame()
	for iter_2_0, iter_2_1 in ipairs(self:GetObjUnitList()) do
		iter_2_1:Start()
	end

	return
end

function IslandSeekGameSystem:OnLateUpdate()
	return
end

function IslandSeekGameSystem:StopGame()
	if self.behaviourTreeOwner then
		self:StopBt()
	end

	for iter_4_0, iter_4_1 in ipairs((self:GetObjUnitList())) do
		if table.contains(self.MONITOR_LIST, iter_4_1.id) then
			iter_4_1:StopBt()
		end
	end

	return
end

function IslandSeekGameSystem:RestartGame()
	for iter_5_0, iter_5_1 in ipairs(self:GetObjUnitList()) do
		if iter_5_1.behaviourTreeOwner then
			LuaHelper.NodeCanvasSetIntVariableValue(iter_5_1.behaviourTreeOwner, "step", 0)
		end

		iter_5_1:RestartBt()
	end

	if self.behaviourTreeOwner then
		LuaHelper.NodeCanvasSetIntVariableValue(self.behaviourTreeOwner, "step", 0)
		self:RestartBt()
	end

	return
end

function IslandSeekGameSystem:GetObjUnitList()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs((self:GetView():GetUnitListByKey(IslandConst.UNIT_LIST_OBJ))) do
		table.insert(var_6_0, iter_6_1)
	end

	table.insert(var_6_0, self:GetView().player)

	return var_6_0
end

function IslandSeekGameSystem:GetUnitById(arg_7_1)
	return self:GetView():GetUnitModule(arg_7_1)
end

return IslandSeekGameSystem
