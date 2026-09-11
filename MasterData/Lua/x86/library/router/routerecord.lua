local RouteRecord = class("RouteRecord")

function RouteRecord:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.name_ = arg_1_1
	self.path_ = arg_1_2
	self.parent_ = arg_1_3
	self.components_ = {}
	self.componentNames_ = arg_1_4
	self.wraps_ = arg_1_5 or {}
end

function RouteRecord:NewComponents()
	if self.componentNames_.__cname then
		self.components_.default = self.componentNames_.New()
	else
		for iter_2_0, iter_2_1 in pairs(self.componentNames_) do
			self.components_[iter_2_0] = iter_2_1.New()
		end
	end
end

function RouteRecord:GetName()
	return self.name_
end

function RouteRecord:GetPath()
	return self.path_
end

function RouteRecord:SetParent(arg_5_1)
	self.parent_ = arg_5_1
end

function RouteRecord:GetParent()
	return self.parent_
end

function RouteRecord:GetComponent()
	return self.components_
end

function RouteRecord:SetParams(arg_8_1)
	self.params_ = arg_8_1
end

function RouteRecord:GetParams()
	return self.params_
end

function RouteRecord:GetWraps()
	return self.wraps_
end

function RouteRecord:Init(arg_11_1)
	self:NewComponents()

	for iter_11_0, iter_11_1 in pairs(self.components_) do
		iter_11_1:SyncInit(arg_11_1)
	end
end

function RouteRecord:OnTop()
	for iter_12_0, iter_12_1 in pairs(self.components_) do
		iter_12_1:OnTop()
	end
end

function RouteRecord:OnBehind()
	for iter_13_0, iter_13_1 in pairs(self.components_) do
		iter_13_1:OnBehind()
	end
end

function RouteRecord:OnUpdate(arg_14_1)
	for iter_14_0, iter_14_1 in pairs(self.components_) do
		if arg_14_1 then
			iter_14_1:SetParams(arg_14_1)
		end

		iter_14_1:OnUpdate()
	end
end

function RouteRecord:Dispose()
	for iter_15_0, iter_15_1 in pairs(self.components_) do
		iter_15_1:OnUnload()
	end

	self:DestroyComponents()
end

function RouteRecord:DestroyComponents()
	for iter_16_0, iter_16_1 in pairs(self.components_) do
		self.components_[iter_16_0] = nil
	end
end

return RouteRecord
