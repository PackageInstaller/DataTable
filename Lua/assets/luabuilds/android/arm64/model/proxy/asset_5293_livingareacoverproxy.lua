local LivingAreaCoverProxy = class("LivingAreaCoverProxy", import(".NetProxy"))

LivingAreaCoverProxy.ON_UPDATE = "LivingAreaCoverProxy:ON_UPDATE"

function LivingAreaCoverProxy:register()
	self.data = {}
	self.coverId = 0

	for iter_1_0, iter_1_1 in ipairs(pg.livingarea_cover.all) do
		self.data[iter_1_1] = LivingAreaCover.New({
			id = iter_1_1,
			unlock = iter_1_1 == 0
		})
	end

	self:on(11003, function(arg_2_0)
		self.coverId = arg_2_0.cover.id

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.cover.covers or {}) do
			self.data[iter_2_1]:SetUnlock(true)
		end

		return
	end)

	return
end

function LivingAreaCoverProxy:GetCoverId()
	return self.coverId
end

function LivingAreaCoverProxy:GetCurCover()
	return self:GetCover(self:GetCoverId())
end

function LivingAreaCoverProxy:UpdateCoverId(arg_5_1)
	self.coverId = arg_5_1

	return
end

function LivingAreaCoverProxy:GetCover(arg_6_1)
	return self.data[arg_6_1]
end

function LivingAreaCoverProxy:GetCover(arg_7_1)
	return self.data[arg_7_1]
end

function LivingAreaCoverProxy:GetUnlockList()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self.data) do
		if iter_8_1:IsUnlock() then
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function LivingAreaCoverProxy:GetLockList()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self.data) do
		if not iter_9_1:IsUnlock() then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function LivingAreaCoverProxy:UpdateCover(arg_10_1)
	self.data[arg_10_1.id] = arg_10_1

	self:sendNotification(LivingAreaCoverProxy.ON_UPDATE)

	return
end

function LivingAreaCoverProxy:IsTip()
	for iter_11_0, iter_11_1 in pairs(self.data) do
		if iter_11_1:IsNew() then
			return true
		end
	end

	return false
end

function LivingAreaCoverProxy:remove()
	return
end

return LivingAreaCoverProxy
