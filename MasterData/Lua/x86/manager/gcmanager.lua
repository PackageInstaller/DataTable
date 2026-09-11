local GCManager = class("GCManager")

function GCManager:Ctor()
	self.gctick = 0
	self.gccost = 0
	self.running = false
end

function GCManager:Collect(arg_2_1)
	self:InAdvance()

	if not arg_2_1 then
		collectgarbage("collect")
	elseif not self.running then
		self.running = true

		self:CalcStep()

		self.gctick = 0
		self.gccost = 0
		self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

		UpdateBeat:AddListener(self.handle)
	end
end

function GCManager:InAdvance()
	return
end

function GCManager:Afterward()
	LuaHelper.UnityGC()
end

function GCManager:CollectStep()
	if collectgarbage("step", self.step) then
		self.running = false

		if self.handle then
			UpdateBeat:RemoveListener(self.handle)

			self.handle = nil
		end

		self:Afterward()
	else
		local var_5_0 = os.clock() * 1000 - os.clock() * 1000

		if self.gccost > 0 then
			self.gccost = (self.gccost + var_5_0) * 0.5 or var_5_0
		end

		self.gctick = self.gctick + 1

		if self.gctick > 300 and self.gctick % 30 == 0 then
			self:CalcStep()
		end
	end
end

function GCManager:CalcStep()
	self.step = math.max(self.gctick - 60, 30) / 30 * 150 * math.max(1 - math.max(self.gccost - 3, 0) * 0.1, 0.1)
end

return GCManager
