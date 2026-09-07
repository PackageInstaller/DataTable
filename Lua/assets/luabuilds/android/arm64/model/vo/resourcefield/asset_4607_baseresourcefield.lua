local BaseResourceField = class("BaseResourceField", import("..BaseVO"))

function BaseResourceField:Ctor(arg_1_1)
	self.attrs = {}

	return
end

function BaseResourceField:SetLevel(arg_2_1)
	self._LV = arg_2_1
	self.configId = arg_2_1

	for iter_2_0, iter_2_1 in ipairs(self.attrs) do
		iter_2_1:Update(self._LV)
	end

	return
end

function BaseResourceField:SetUpgradeTimeStamp(arg_3_1)
	self._upgradeTimeStamp = arg_3_1

	return
end

function BaseResourceField:GetUpgradeTimeStamp()
	return self._upgradeTimeStamp
end

function BaseResourceField:GetDuration()
	if self._upgradeTimeStamp ~= 0 then
		return self._upgradeTimeStamp - pg.TimeMgr.GetInstance():GetServerTime()
	else
		return nil
	end

	return
end

function BaseResourceField:IsStarting()
	local var_6_0

	if self._upgradeTimeStamp > 0 then
		if self._upgradeTimeStamp <= pg.TimeMgr.GetInstance():GetServerTime() then
			var_6_0 = false

			goto label_6_0
		end
	end

	::label_6_0::

	return true
end

function BaseResourceField:GetSpendTime()
	return self:getConfig("time")
end

function BaseResourceField:GetLevel()
	return self._LV
end

function BaseResourceField:IsMaxLevel()
	local var_9_0 = self:bindConfigTable()

	return self._LV == var_9_0.all[#var_9_0.all]
end

function BaseResourceField:GetTargetLevel()
	return self:bindConfigTable()[self:GetLevel()].user_level
end

function BaseResourceField:IsReachLevel()
	return getProxy(PlayerProxy):getRawData().level >= self:bindConfigTable()[self:GetLevel()].user_level
end

function BaseResourceField:GetTargetRes()
	return self:bindConfigTable()[self:GetLevel()].use[2]
end

function BaseResourceField:IsReachRes()
	return getProxy(PlayerProxy):getRawData().gold >= self:bindConfigTable()[self:GetLevel()].use[2]
end

function BaseResourceField:CanUpgrade()
	if self:IsReachLevel() and self:IsReachRes() and not self:IsMaxLevel() and self._upgradeTimeStamp == 0 then
		return true
	end

	return false
end

function BaseResourceField:isCommissionNotify(arg_15_1)
	return self:getHourProduct() > self:getConfig("store") - arg_15_1
end

function BaseResourceField:GetCost()
	local var_16_0 = self:getConfig("use")

	return {
		type = DROP_TYPE_RESOURCE,
		id = var_16_0[1],
		count = var_16_0[2]
	}
end

function BaseResourceField:GetEffectAttrs()
	return self.attrs
end

function BaseResourceField:GetName()
	assert(false)

	return
end

function BaseResourceField:getHourProduct()
	assert(false)

	return
end

function BaseResourceField:GetKeyWord()
	assert(false)

	return
end

function BaseResourceField:bindConfigTable()
	assert(false)

	return
end

function BaseResourceField:GetUpgradeType()
	assert(false)

	return
end

function BaseResourceField:GetResourceType()
	assert(false)

	return
end

function BaseResourceField:GetDesc()
	assert(false)

	return
end

function BaseResourceField:GetPlayerRes()
	assert(false)

	return
end

function BaseResourceField:HasRes()
	return self:GetPlayerRes() > 0
end

return BaseResourceField
