local IslandGiftAllocator = class("IslandGiftAllocator", import(".IslandComparableAllocator"))

function IslandGiftAllocator:Ctor(arg_1_1)
	self.controller = arg_1_1
	self.signInAgency = arg_1_1:GetIsland():GetSignInAgency()

	IslandGiftAllocator.super.Ctor(self, arg_1_1)
	self:AddTimer()

	return
end

function IslandGiftAllocator:AddTimer()
	self:RemoveTimer()

	local var_2_0 = GetZeroTime() - pg.TimeMgr.GetInstance():GetServerTime()

	if var_2_0 > 0 then
		self.timer = Timer.New(function()
			self:Flush()

			return
		end, var_2_0, 1)

		self.timer:Start()
	end

	return
end

function IslandGiftAllocator:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandGiftAllocator:OnInitFlags()
	for iter_5_0, iter_5_1 in ipairs(self.controller.sceneData.giftUnits) do
		self.flags[iter_5_0] = self:IsVisible(iter_5_0)
	end

	return
end

function IslandGiftAllocator:OnCompareSample(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		if iter_6_1 ~= nil and arg_6_2[iter_6_0] ~= nil and iter_6_1 ~= arg_6_2[iter_6_0] then
			if iter_6_1 == true and arg_6_2[iter_6_0] == false then
				local var_6_1 = self:GetUnitData(iter_6_0)

				if var_6_1 then
					self:RemoveUnit(IslandConst.UNIT_LIST_OBJ, var_6_1.id)
				end
			elseif iter_6_1 == false and arg_6_2[iter_6_0] == true then
				local var_6_2 = self:GetUnitData(iter_6_0)

				if var_6_2 then
					self:GenUnit(var_6_2)
				end
			end
		end
	end

	return
end

function IslandGiftAllocator:IsVisible(arg_7_1)
	local var_7_0 = self.signInAgency:Visible(arg_7_1)

	if self.signInAgency:IsOutRange(arg_7_1) then
		return false
	end

	if self.controller:IsSelfIsland() then
		if self.signInAgency.signInCnt <= 0 then
			return false
		end

		return var_7_0 or self.signInAgency.signInCnt > 0 and self.signInAgency.fetchCnt == 0
	else
		local var_7_1 = self.controller:GetIsland()
		local var_7_2 = var_7_1:GetAccessAgency()

		return var_7_0 and (var_7_2:HasOpenFlag(IslandConst.OPEN_SIGNIN) or var_7_1:GetSignInAgency():InInInviteList(getProxy(PlayerProxy):getRawData().id)) and not var_7_1:GetSignInAgency().IsExpiration(var_7_2)
	end

	return
end

function IslandGiftAllocator:GetUnitData(arg_8_1)
	assert(self.controller.sceneData.giftUnits[arg_8_1], "unit data is nil ." .. arg_8_1)

	return self.controller.sceneData.giftUnits[arg_8_1]
end

function IslandGiftAllocator:OnDispose()
	self.signInAgency = nil

	self:RemoveTimer()

	return
end

return IslandGiftAllocator
