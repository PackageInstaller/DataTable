local var_0_0 = class("IslandManageSystem", import("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.scheduleList = {}
	arg_1_0.isShowing = false

	return
end

function var_0_0.OnStart(arg_2_0)
	if not arg_2_0.behaviourTreeOwner then
		return
	end

	if arg_2_0.data:GetStatus() == IslandRestaurant.STATUS.OPENING then
		arg_2_0:StartManage(arg_2_0.data)
	end

	return
end

function var_0_0.StartManage(arg_3_0, arg_3_1)
	if not arg_3_0.behaviourTreeOwner then
		return
	end

	arg_3_0.isShowing = true
	arg_3_0.restId = arg_3_0.data:GetRestId()
	arg_3_0.postList = arg_3_0.data:GetPostList()

	table.insert(arg_3_0.scheduleList, arg_3_1)

	return
end

function var_0_0.ExecuteManage(arg_4_0, arg_4_1)
	arg_4_0.behaviourTreeOwner:SendEvent("manage_add_post", arg_4_1:GetPostUnitNodeList(), nil)
	arg_4_0.behaviourTreeOwner:SendEvent("manage_add_assistant", arg_4_1:GetAssistantUnitNodeList(), nil)
	arg_4_0.behaviourTreeOwner:SendEvent("manage_add_customer", arg_4_1:GetCustomerUnitNodeList(), nil)
	LuaHelper.NodeCanvasSetIntVariableValue(arg_4_0.behaviourTreeOwner, "systemId", arg_4_1.id)

	for iter_4_0, iter_4_1 in ipairs(arg_4_1:GetFoodUnitIds()) do
		local var_4_0 = _IslandFindUnit(IslandConst.UNIT_LIST_MANAGE, iter_4_1)

		if var_4_0 then
			setActive(var_4_0, true)
		end
	end

	return
end

function var_0_0.EndManage(arg_5_0, arg_5_1)
	arg_5_0.isShowing = false

	for iter_5_0, iter_5_1 in ipairs(arg_5_1:GetFoodUnitIds()) do
		local var_5_0 = _IslandFindUnit(IslandConst.UNIT_LIST_MANAGE, iter_5_1)

		if var_5_0 then
			setActive(var_5_0, false)
		end
	end

	return
end

function var_0_0.OnUpdate(arg_6_0)
	if arg_6_0.isShowing and arg_6_0.data:GetStatus() ~= IslandRestaurant.STATUS.OPENING then
		getProxy(IslandProxy):GetIsland():DispatchEvent(IslandCloseRestaurantCommand.CLOSE_RESTAURANT, {
			restId = arg_6_0.restId,
			postList = arg_6_0.postList
		})
	end

	if #arg_6_0.scheduleList == 0 then
		return
	end

	local var_6_0 = arg_6_0:GetView()

	if not var_6_0:IsLoaded() then
		return
	end

	if not arg_6_0._go:GetComponent(typeof(ParadoxNotion.Services.EventRouter)) then
		return
	end

	local var_6_1 = arg_6_0.scheduleList[1]

	for iter_6_0, iter_6_1 in ipairs((arg_6_0.scheduleList[1]:GetUnits())) do
		local var_6_2 = arg_6_0:GetView():GetUnitModuleWithType(IslandConst.UNIT_LIST_MANAGE, iter_6_1.id)

		if not var_6_2:IsLoaded() then
			return
		end

		if iter_6_1.type == IslandConst.UNIT_TYPE_MANAGE_CHARA and not var_6_2._go:GetComponent(typeof(ParadoxNotion.Services.EventRouter)) then
			return
		end
	end

	table.remove(arg_6_0.scheduleList, 1)
	arg_6_0:ExecuteManage(var_6_1)

	return
end

function var_0_0.OnDestroy(arg_7_0)
	table.clear(arg_7_0.scheduleList)

	return
end

return var_0_0
