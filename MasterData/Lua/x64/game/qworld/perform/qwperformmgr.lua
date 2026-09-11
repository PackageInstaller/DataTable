local QWPerformMgr = class("QWPerformMgr")
local var_0_1
local var_0_2
local var_0_3

function QWPerformMgr:Ctor()
	var_0_1 = import("game.qworld.perform.backhome.QWDormPerformAdaptor")
	var_0_2 = import("game.qworld.perform.backhome.QWDormInteractBehaviourAdaptor")
end

function QWPerformMgr:Init()
	var_0_1:Init()

	self.context = {
		needBackHome = false,
		activeThing = -1,
		luaInterrupt = false
	}
end

function QWPerformMgr:GetCManager()
	if isNil(var_0_3) then
		var_0_3 = QWPerformManager.Instance
	end

	return var_0_3
end

function QWPerformMgr:SetActivityPerformDirty()
	self.activityPerformDirty = true
end

function QWPerformMgr:IsInActivityPerform()
	return self.activityPerformDirty
end

function QWPerformMgr:TryClearPerformDirty()
	if self.activityPerformDirty then
		self.activityPerformDirty = false

		self:ForceStopPlayerPerform()

		return true
	end

	return false
end

function QWPerformMgr:TryClearPerformWithBlackFade(arg_7_1)
	if self.activityPerformDirty then
		self.activityPerformDirty = false

		self:ForceStopPlayerPerform(arg_7_1)
	elseif arg_7_1 then
		arg_7_1()
	end
end

function QWPerformMgr:IsInPerform()
	return self.isInPerform
end

function QWPerformMgr:GetCurPreformThingID()
	return self.context.activeThing
end

function QWPerformMgr:StartPerform(arg_10_1, arg_10_2, arg_10_3)
	self.isInPerform = true
	self.context.luaInterrupt = false
	self.context.activeThing = arg_10_1:GetId()
	self.context.onFinish = arg_10_3

	manager.notify:Invoke(QWORLD_ENTER_PERFORM, true, QWorldLuaBridge.GetFurnitureCanAutoExit(arg_10_1.entity))
	self:GetCManager():StartFurniturInteract(arg_10_1.entity, function()
		self:NextPerform(arg_10_1, arg_10_2, function()
			if arg_10_3 then
				arg_10_3()
			end

			self.context.activeThing = -1

			manager.notify:Invoke(QWORLD_ENTER_PERFORM, false)

			self.isInPerform = false
		end)
	end)
end

function QWPerformMgr:NextPerform(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1:GetId()

	var_0_1:StartPerformTask(function(arg_14_0)
		var_0_2.SetupInteractTask(var_13_0, arg_13_2, arg_14_0, function(arg_15_0)
			if arg_15_0.nextAction then
				local var_15_0 = QWorldLuaBridge.GetFuniturePerformExitAction(arg_13_1.entity)

				if not var_15_0 or var_15_0 == -1 or var_15_0 == 0 then
					self:NextPerform(arg_13_1, arg_15_0.nextAction, arg_13_3)

					return
				else
					if self.context.luaInterrupt then
						self:NextPerform(arg_13_1, var_15_0, arg_13_3)

						return
					end

					if self:GetCManager():CheckFuniturePerformInterrupt(arg_13_1.entity) then
						self:NextPerform(arg_13_1, var_15_0, arg_13_3)

						return
					else
						self:GetCManager():MarkFuniturePerformWaitInterrupt(arg_13_1.entity)
					end
				end

				self:NextPerform(arg_13_1, arg_15_0.nextAction, arg_13_3)
			else
				self:GetCManager():EndFurniturInteract(arg_13_1.entity)

				if arg_13_3 then
					arg_13_3()
				end

				self.context.activeThing = -1
			end
		end)
	end)
end

function QWPerformMgr:ForceStopPlayerPerform(arg_16_1, arg_16_2)
	if self.context.activeThing ~= -1 then
		if arg_16_2 then
			var_0_1:StopRunner()
			self:GetCManager():EndFurniturInteract(QWorldMgr:GetQWorldEntityMgr():GetEnt(self.context.activeThing).entity)
			self:ForceStopAllTask(true, arg_16_1)
		else
			QWorldMgr:StartBlackFade(0.3, 0.3, 0.2, function()
				var_0_1:StopRunner()
				self:GetCManager():EndFurniturInteract(QWorldMgr:GetQWorldEntityMgr():GetEnt(self.context.activeThing).entity)
				self:ForceStopAllTask(true, arg_16_1)
			end)
		end
	elseif arg_16_1 then
		arg_16_1()
	end
end

function QWPerformMgr:ForceStopAllTask(arg_18_1, arg_18_2)
	if self.context.activeThing ~= -1 then
		if not arg_18_1 then
			var_0_1:StopRunner()
		end

		if self.context.onFinish then
			self.context.onFinish()
		end

		manager.notify:Invoke(QWORLD_ENTER_PERFORM, false)

		self.isInPerform = false

		if arg_18_2 then
			arg_18_2()
		end

		self.context.activeThing = -1
	end
end

function QWPerformMgr:MarkFuniturePerformWaitInterrupt()
	if self.context.activeThing ~= -1 then
		local var_19_0 = QWorldMgr:GetQWorldEntityMgr():GetEnt(self.context.activeThing)

		self.context.luaInterrupt = true
	else
		manager.notify:Invoke(QWORLD_ENTER_PERFORM, false)
	end
end

function QWPerformMgr:Dispose()
	var_0_3 = nil

	var_0_1:Dispose()

	var_0_1 = nil
	var_0_2 = nil
end

return QWPerformMgr
