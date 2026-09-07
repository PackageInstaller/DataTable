local IslandManageSystem = class("IslandManageSystem", import("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function IslandManageSystem:Ctor(arg_1_1, arg_1_2)
	IslandManageSystem.super.Ctor(self, arg_1_1, arg_1_2)

	self.scheduleList = {}
	self.isShowing = false

	return
end

function IslandManageSystem:OnStart()
	if not self.behaviourTreeOwner then
		return
	end

	if self.data:GetStatus() == IslandRestaurant.STATUS.OPENING then
		self:StartManage(self.data)
	end

	return
end

function IslandManageSystem:StartManage(arg_3_1)
	if not self.behaviourTreeOwner then
		return
	end

	self.isShowing = true
	self.restId = self.data:GetRestId()
	self.postList = self.data:GetPostList()

	table.insert(self.scheduleList, arg_3_1)

	return
end

function IslandManageSystem:ExecuteManage(arg_4_1)
	self.behaviourTreeOwner:SendEvent("manage_add_post", arg_4_1:GetPostUnitNodeList(), nil)
	self.behaviourTreeOwner:SendEvent("manage_add_assistant", arg_4_1:GetAssistantUnitNodeList(), nil)
	self.behaviourTreeOwner:SendEvent("manage_add_customer", arg_4_1:GetCustomerUnitNodeList(), nil)
	LuaHelper.NodeCanvasSetIntVariableValue(self.behaviourTreeOwner, "systemId", arg_4_1.id)

	for iter_4_0, iter_4_1 in ipairs(arg_4_1:GetFoodUnitIds()) do
		local var_4_0 = _IslandFindUnit(IslandConst.UNIT_LIST_MANAGE, iter_4_1)

		if var_4_0 then
			setActive(var_4_0, true)
		end
	end

	return
end

function IslandManageSystem:EndManage(arg_5_1)
	self.isShowing = false

	for iter_5_0, iter_5_1 in ipairs(arg_5_1:GetFoodUnitIds()) do
		local var_5_0 = _IslandFindUnit(IslandConst.UNIT_LIST_MANAGE, iter_5_1)

		if var_5_0 then
			setActive(var_5_0, false)
		end
	end

	return
end

function IslandManageSystem:OnUpdate()
	if self.isShowing and self.data:GetStatus() ~= IslandRestaurant.STATUS.OPENING then
		getProxy(IslandProxy):GetIsland():DispatchEvent(IslandCloseRestaurantCommand.CLOSE_RESTAURANT, {
			restId = self.restId,
			postList = self.postList
		})
	end

	if #self.scheduleList == 0 then
		return
	end

	if not self:GetView():IsLoaded() then
		return
	end

	if not self._go:GetComponent(typeof(ParadoxNotion.Services.EventRouter)) then
		return
	end

	local var_6_0 = self.scheduleList[1]

	for iter_6_0, iter_6_1 in ipairs((self.scheduleList[1]:GetUnits())) do
		local var_6_1 = self:GetView():GetUnitModuleWithType(IslandConst.UNIT_LIST_MANAGE, iter_6_1.id)

		if not var_6_1:IsLoaded() then
			return
		end

		if iter_6_1.type == IslandConst.UNIT_TYPE_MANAGE_CHARA and not var_6_1._go:GetComponent(typeof(ParadoxNotion.Services.EventRouter)) then
			return
		end
	end

	table.remove(self.scheduleList, 1)
	self:ExecuteManage(var_6_0)

	return
end

function IslandManageSystem:OnDestroy()
	table.clear(self.scheduleList)

	return
end

return IslandManageSystem
