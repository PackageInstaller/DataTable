local var_0_0 = class("QWPerformMgr")
local var_0_1
local var_0_2
local var_0_3

function var_0_0.Ctor(arg_1_0)
	var_0_1 = import("game.qworld.perform.backhome.QWDormPerformAdaptor")
	var_0_2 = import("game.qworld.perform.backhome.QWDormInteractBehaviourAdaptor")
end

function var_0_0.Init(arg_2_0)
	var_0_1:Init()

	arg_2_0.context = {
		needBackHome = false,
		activeThing = -1,
		luaInterrupt = false
	}
end

function var_0_0.GetCManager(arg_3_0)
	if isNil(var_0_3) then
		var_0_3 = QWPerformManager.Instance
	end

	return var_0_3
end

function var_0_0.SetActivityPerformDirty(arg_4_0)
	arg_4_0.activityPerformDirty = true
end

function var_0_0.IsInActivityPerform(arg_5_0)
	return arg_5_0.activityPerformDirty
end

function var_0_0.TryClearPerformDirty(arg_6_0)
	if arg_6_0.activityPerformDirty then
		arg_6_0.activityPerformDirty = false

		arg_6_0:ForceStopPlayerPerform()

		return true
	end

	return false
end

function var_0_0.TryClearPerformWithBlackFade(arg_7_0, arg_7_1)
	if arg_7_0.activityPerformDirty then
		arg_7_0.activityPerformDirty = false

		arg_7_0:ForceStopPlayerPerform(arg_7_1)
	elseif arg_7_1 then
		arg_7_1()
	end
end

function var_0_0.IsInPerform(arg_8_0)
	return arg_8_0.isInPerform
end

function var_0_0.GetCurPreformThingID(arg_9_0)
	return arg_9_0.context.activeThing
end

function var_0_0.StartPerform(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_1:GetId()

	arg_10_0.isInPerform = true
	arg_10_0.context.luaInterrupt = false
	arg_10_0.context.activeThing = var_10_0
	arg_10_0.context.onFinish = arg_10_3

	manager.notify:Invoke(QWORLD_ENTER_PERFORM, true, QWorldLuaBridge.GetFurnitureCanAutoExit(arg_10_1.entity))
	arg_10_0:GetCManager():StartFurniturInteract(arg_10_1.entity, function()
		arg_10_0:NextPerform(arg_10_1, arg_10_2, function()
			if arg_10_3 then
				arg_10_3()
			end

			arg_10_0.context.activeThing = -1

			manager.notify:Invoke(QWORLD_ENTER_PERFORM, false)

			arg_10_0.isInPerform = false
		end)
	end)
end

function var_0_0.NextPerform(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1:GetId()

	var_0_1:StartPerformTask(function(arg_14_0)
		var_0_2.SetupInteractTask(var_13_0, arg_13_2, arg_14_0, function(arg_15_0)
			if arg_15_0.nextAction then
				local var_15_0 = QWorldLuaBridge.GetFuniturePerformExitAction(arg_13_1.entity)

				if not var_15_0 or var_15_0 == -1 or var_15_0 == 0 then
					arg_13_0:NextPerform(arg_13_1, arg_15_0.nextAction, arg_13_3)

					return
				else
					if arg_13_0.context.luaInterrupt then
						arg_13_0:NextPerform(arg_13_1, var_15_0, arg_13_3)

						return
					end

					if arg_13_0:GetCManager():CheckFuniturePerformInterrupt(arg_13_1.entity) then
						arg_13_0:NextPerform(arg_13_1, var_15_0, arg_13_3)

						return
					else
						arg_13_0:GetCManager():MarkFuniturePerformWaitInterrupt(arg_13_1.entity)
					end
				end

				arg_13_0:NextPerform(arg_13_1, arg_15_0.nextAction, arg_13_3)
			else
				arg_13_0:GetCManager():EndFurniturInteract(arg_13_1.entity)

				if arg_13_3 then
					arg_13_3()
				end

				arg_13_0.context.activeThing = -1
			end
		end)
	end)
end

function var_0_0.ForceStopPlayerPerform(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.context.activeThing ~= -1 then
		if arg_16_2 then
			var_0_1:StopRunner()

			local var_16_0 = QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_16_0.context.activeThing)

			arg_16_0:GetCManager():EndFurniturInteract(var_16_0.entity)
			arg_16_0:ForceStopAllTask(true, arg_16_1)
		else
			QWorldMgr:StartBlackFade(0.3, 0.3, 0.2, function()
				var_0_1:StopRunner()

				local var_17_0 = QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_16_0.context.activeThing)

				arg_16_0:GetCManager():EndFurniturInteract(var_17_0.entity)
				arg_16_0:ForceStopAllTask(true, arg_16_1)
			end)
		end
	elseif arg_16_1 then
		arg_16_1()
	end
end

function var_0_0.ForceStopAllTask(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.context.activeThing ~= -1 then
		if not arg_18_1 then
			var_0_1:StopRunner()
		end

		if arg_18_0.context.onFinish then
			arg_18_0.context.onFinish()
		end

		manager.notify:Invoke(QWORLD_ENTER_PERFORM, false)

		arg_18_0.isInPerform = false

		if arg_18_2 then
			arg_18_2()
		end

		arg_18_0.context.activeThing = -1
	end
end

function var_0_0.MarkFuniturePerformWaitInterrupt(arg_19_0)
	if arg_19_0.context.activeThing ~= -1 then
		local var_19_0 = QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_19_0.context.activeThing)

		arg_19_0.context.luaInterrupt = true
	else
		manager.notify:Invoke(QWORLD_ENTER_PERFORM, false)
	end
end

function var_0_0.Dispose(arg_20_0)
	var_0_3 = nil

	var_0_1:Dispose()

	var_0_1 = nil
	var_0_2 = nil
end

return var_0_0
