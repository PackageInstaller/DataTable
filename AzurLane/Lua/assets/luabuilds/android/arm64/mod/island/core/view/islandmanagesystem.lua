class = var_0_10000

local var_0_0 = "IslandManageSystem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.scheduleList = {}
	arg_1_0.isShowing = false

	return
end

function var_0_1.OnStart(arg_2_0)
	if not arg_2_0.behaviourTreeOwner then
		return
	end

	local var_2_0 = arg_2_0.data
	local var_2_1 = var_1.GetStatus(var_2_0)

	IslandRestaurant = var_1_10002

	if var_2_1 == var_1_10002.STATUS.OPENING then
		arg_2_0:StartManage(arg_2_0.data)
	end

	return
end

function var_0_1.StartManage(arg_3_0, arg_3_1)
	if not arg_3_0.behaviourTreeOwner then
		return
	end

	arg_3_0.isShowing = true

	local var_3_0 = arg_3_0.data

	arg_3_0.restId = var_2.GetRestId(var_3_0)

	local var_3_1 = arg_3_0.data

	arg_3_0.postList = var_2.GetPostList(var_3_1)
	table = var_2

	var_2.insert(arg_3_0.scheduleList, arg_3_1)

	return
end

function var_0_1.ExecuteManage(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.behaviourTreeOwner

	var_2.SendEvent(var_4_0, "manage_add_post", arg_4_1:GetPostUnitNodeList(), nil)

	local var_4_1 = arg_4_0.behaviourTreeOwner

	var_2.SendEvent(var_4_1, "manage_add_assistant", arg_4_1:GetAssistantUnitNodeList(), nil)

	local var_4_2 = arg_4_0.behaviourTreeOwner
	local var_4_3 = var_2.SendEvent
	local var_4_4 = "manage_add_customer"
	local var_4_5 = arg_4_1

	var_4_3(var_4_2, var_4_4, arg_4_1.GetCustomerUnitNodeList(var_4_5), nil)

	LuaHelper = var_4_3

	var_4_3.NodeCanvasSetIntVariableValue(arg_4_0.behaviourTreeOwner, "systemId", arg_4_1.id)

	ipairs = var_2

	for iter_4_0, iter_4_1 in var_2(arg_4_1:GetFoodUnitIds()) do
		_IslandFindUnit = var_7
		IslandConst = var_1_10009

		if var_7(var_1_10009.UNIT_LIST_MANAGE, iter_4_1) then
			setActive = var_4_5

			var_4_5(var_7, true)
		end
	end

	return
end

function var_0_1.EndManage(arg_5_0, arg_5_1)
	arg_5_0.isShowing = false
	ipairs = var_2

	for iter_5_0, iter_5_1 in var_2(arg_5_1:GetFoodUnitIds()) do
		_IslandFindUnit = var_1_10007
		IslandConst = var_1_10009

		if var_1_10007(var_1_10009.UNIT_LIST_MANAGE, iter_5_1) then
			setActive = var_1_10008

			var_1_10008(var_1_10007, false)
		end
	end

	return
end

function var_0_1.OnUpdate(arg_6_0)
	local var_6_0 = arg_6_0.data
	local var_6_1 = var_1.GetStatus(var_6_0)

	if arg_6_0.isShowing then
		IslandRestaurant = var_2

		if var_6_1 ~= var_2.STATUS.OPENING then
			getProxy = var_2
			IslandProxy = var_1_10004

			local var_6_2 = var_2(var_1_10004)

			var_1_10005 = var_2.GetIsland(var_6_2)

			local var_6_3 = var_2.DispatchEvent

			IslandCloseRestaurantCommand = var_1_10006

			var_6_3(var_1_10005, var_1_10006.CLOSE_RESTAURANT, {
				restId = arg_6_0.restId,
				postList = arg_6_0.postList
			})
		end
	end

	if #arg_6_0.scheduleList == 0 then
		return
	end

	local var_6_4 = arg_6_0:GetView()

	if not var_2.IsLoaded(var_6_4) then
		return
	end

	local var_6_5 = arg_6_0._go
	local var_6_6 = var_2.GetComponent

	typeof = var_1_10005
	ParadoxNotion = var_1_10007

	if not var_6_6(var_6_5, var_1_10005(var_1_10007.Services.EventRouter)) then
		return
	end

	local var_6_7 = arg_6_0.scheduleList[1]
	local var_6_8 = var_3.GetUnits(var_6_7)

	ipairs = var_5

	for iter_6_0, iter_6_1 in var_5(var_6_8) do
		local var_6_9 = arg_6_0:GetView()
		local var_6_10 = var_10.GetUnitModuleWithType

		IslandConst = var_1_10013
		var_1_10013 = var_6_10(var_6_9, var_1_10013.UNIT_LIST_MANAGE, iter_6_1.id)

		if not var_10.IsLoaded(var_1_10013) then
			return
		end

		local var_6_11 = iter_6_1.type

		IslandConst = var_6_9

		if var_6_11 == var_6_9.UNIT_TYPE_MANAGE_CHARA then
			var_1_10013 = var_10._go

			local var_6_12 = var_11.GetComponent

			typeof = var_14
			ParadoxNotion = var_1_10016

			if not var_6_12(var_1_10013, var_14(var_1_10016.Services.EventRouter)) then
				return
			end
		end
	end

	table = var_5

	var_5.remove(arg_6_0.scheduleList, 1)
	arg_6_0:ExecuteManage(var_3)

	return
end

function var_0_1.OnDestroy(arg_7_0)
	table = var_1_10001

	var_1_10001.clear(arg_7_0.scheduleList)

	return
end

return var_0_1
