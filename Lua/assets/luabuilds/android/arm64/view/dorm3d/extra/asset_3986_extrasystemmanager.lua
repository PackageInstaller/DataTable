local ExtraSystemManager = class("ExtraSystemManager")

function ExtraSystemManager:Ctor(arg_1_1, arg_1_2)
	self.event = arg_1_1
	self.scene = arg_1_2
	self.systems = {}
	self.systemOrder = {}

	return
end

function ExtraSystemManager:Register(arg_2_1, ...)
	local var_2_0 = arg_2_1.__cname or tostring(arg_2_1)

	warning("Trying to register Extra System:", var_2_0)

	if self.systems[var_2_0] then
		warning("System " .. var_2_0 .. " already registered")

		return self.systems[var_2_0]
	end

	if arg_2_1.IsOpen and not arg_2_1.IsOpen(self.scene.room, ...) then
		return nil
	end

	local var_2_1 = arg_2_1.New(self.event, self.scene, ...)

	self.systems[var_2_0] = var_2_1

	warning("Register Extra System:", var_2_0)
	table.insert(self.systemOrder, var_2_0)
	var_2_1:Init()

	return var_2_1
end

function ExtraSystemManager:Get(arg_3_1)
	return self.systems[type(arg_3_1) == "string" and arg_3_1 or arg_3_1.__cname or tostring(arg_3_1)]
end

function ExtraSystemManager:Remove(arg_4_1)
	warning("Trying to remove Extra System:", arg_4_1)

	local var_4_0 = type(arg_4_1) == "string" and arg_4_1 or arg_4_1.__cname or tostring(arg_4_1)
	local var_4_1 = self.systems[var_4_0]

	if not self.systems[var_4_0] then
		return
	end

	var_4_1:Dispose()

	self.systems[var_4_0] = nil

	table.removebyvalue(self.systemOrder, var_4_0)
	warning("Remove Extra System:", var_4_0)

	return
end

function ExtraSystemManager:Update(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self.systemOrder) do
		if self.systems[iter_5_1] then
			self.systems[iter_5_1]:Update(arg_5_1)
		end
	end

	return
end

function ExtraSystemManager:LateUpdate(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(self.systemOrder) do
		if self.systems[iter_6_1] then
			self.systems[iter_6_1]:LateUpdate(arg_6_1)
		end
	end

	return
end

function ExtraSystemManager:BroadcastNotification(arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(self.systemOrder) do
		if self.systems[iter_7_1] and table.contains(self.systems[iter_7_1].GetInterests(), arg_7_1) then
			self.systems[iter_7_1]:HandleNotification(arg_7_1, arg_7_2)
		end
	end

	return
end

function ExtraSystemManager:GetAllInterests()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(self.systemOrder) do
		if self.systems[iter_8_1] then
			for iter_8_2, iter_8_3 in ipairs((self.systems[iter_8_1].GetInterests())) do
				if not table.contains(var_8_0, iter_8_3) then
					table.insert(var_8_0, iter_8_3)
				end
			end
		end
	end

	return var_8_0
end

function ExtraSystemManager:Dispose()
	for iter_9_0 = #self.systemOrder, 1, -1 do
		if self.systems[self.systemOrder[iter_9_0]] then
			self.systems[self.systemOrder[iter_9_0]]:Dispose()
		end
	end

	self.systems = {}
	self.systemOrder = {}
	self.event = nil
	self.scene = nil

	return
end

return ExtraSystemManager
