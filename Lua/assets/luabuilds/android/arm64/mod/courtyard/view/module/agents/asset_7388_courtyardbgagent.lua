local CourtYardBGAgent = class("CourtYardBGAgent", import(".CourtYardAgent"))

function CourtYardBGAgent:Ctor(arg_1_1)
	CourtYardBGAgent.super.Ctor(self, arg_1_1)

	self.prefab = nil

	return
end

function CourtYardBGAgent:Switch(arg_2_1, arg_2_2)
	if not arg_2_2 then
		return
	end

	if self.prefab then
		local var_2_0 = self.prefab.name or ""

		if arg_2_1 and var_2_0 ~= arg_2_2 then
			self:LoadBG(arg_2_2)
		elseif arg_2_1 and var_2_0 == arg_2_2 then
			-- block empty
		elseif not arg_2_1 and var_2_0 == arg_2_2 then
			self:Clear()
		end
	end

	assert(false)

	return
end

function CourtYardBGAgent:LoadBG(arg_3_1)
	PoolMgr.GetInstance():GetPrefab("BackyardBG/" .. arg_3_1, arg_3_1, true, function(arg_4_0)
		if self.exited then
			PoolMgr.GetInstance():ReturnPrefab("BackyardBG/" .. arg_3_1, arg_3_1, arg_4_0)
		end

		arg_4_0.name = arg_3_1

		setParent(arg_4_0, self._tf)
		arg_4_0.transform:SetAsFirstSibling()
		setActive(arg_4_0, true)

		self.prefab = arg_4_0

		return
	end)

	return
end

function CourtYardBGAgent:Clear()
	if self.prefab then
		PoolMgr.GetInstance():ReturnPrefab("BackyardBG/" .. self.prefab.name, self.prefab.name, self.prefab)

		self.prefab = nil
	end

	return
end

function CourtYardBGAgent:ClearByName(arg_6_1)
	if self.prefab and self.prefab.name == arg_6_1 then
		self:Clear()
	end

	return
end

function CourtYardBGAgent:Dispose()
	self:Clear(true)

	self.exited = true

	return
end

return CourtYardBGAgent
