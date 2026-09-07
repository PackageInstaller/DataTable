local CourtYardEffectAgent = class("CourtYardEffectAgent", import(".CourtYardAgent"))

function CourtYardEffectAgent:Ctor(arg_1_1)
	CourtYardEffectAgent.super.Ctor(self, arg_1_1)

	self.effects = {}
	self.counts = {}

	return
end

function CourtYardEffectAgent:EnableEffect(arg_2_1)
	if not arg_2_1 then
		return
	end

	if self.effects[arg_2_1] then
		self.counts[arg_2_1] = (self.counts[arg_2_1] or 0) + 1

		return
	end

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetPrefab("ui/" .. arg_2_1, arg_2_1, true, function(arg_3_0)
		pg.UIMgr.GetInstance():LoadingOff()

		if not self.effects or self.effects[arg_2_1] then
			PoolMgr.GetInstance():ReturnPrefab("ui/" .. arg_2_1, arg_2_1, arg_3_0)

			return
		end

		arg_3_0.name = arg_2_1

		setParent(arg_3_0, self.effectContainer)
		setActive(arg_3_0, true)

		self.effects[arg_2_1] = arg_3_0
		self.counts[arg_2_1] = (self.counts[arg_2_1] or 0) + 1

		return
	end)

	return
end

function CourtYardEffectAgent:DisableEffect(arg_4_1)
	if not self.effects[arg_4_1] then
		return
	end

	self.counts[arg_4_1] = (self.counts[arg_4_1] or 0) - 1

	if self.counts[arg_4_1] <= 0 then
		local var_4_0 = findTF(self.effectContainer, arg_4_1)

		if var_4_0 then
			PoolMgr.GetInstance():ReturnPrefab("ui/" .. arg_4_1, arg_4_1, var_4_0.gameObject)

			self.effects[arg_4_1] = nil
		end
	end

	return
end

function CourtYardEffectAgent:Dispose()
	for iter_5_0, iter_5_1 in pairs(self.effects) do
		PoolMgr.GetInstance():ReturnPrefab("ui/" .. iter_5_0, iter_5_0, iter_5_1)
	end

	self.effects = nil
	self.counts = nil

	return
end

return CourtYardEffectAgent
