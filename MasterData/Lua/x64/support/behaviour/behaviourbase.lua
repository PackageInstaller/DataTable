local BehaviourBase = class("BehaviourBase")

function BehaviourBase:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.name_ = arg_1_1
	self.depends_ = arg_1_2
	self.priority_ = arg_1_3 or 0
	self.refCnt_ = 0
end

function BehaviourBase:GetName()
	return self.name_
end

function BehaviourBase:GetDepends()
	return self.depends_
end

function BehaviourBase:GetPriority()
	return self.priority_
end

function BehaviourBase:GetTarget()
	return self.target_
end

function BehaviourBase:Reset()
	return
end

function BehaviourBase:ExportMethods_(arg_7_1)
	self.exportedMethods_ = arg_7_1

	local var_7_0 = self

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if not self.target_[iter_7_1] then
			local var_7_1 = self[iter_7_1]

			self.target_[iter_7_1] = function(arg_8_0, ...)
				return var_7_1(var_7_0, ...)
			end
		end
	end

	return self
end

function BehaviourBase:Bind_(arg_9_1)
	self.target_ = arg_9_1

	if self.depends_ then
		for iter_9_0, iter_9_1 in ipairs(self.depends_) do
			arg_9_1:AddBehaviour(iter_9_1)
		end
	end

	self:OnBind_(arg_9_1)
end

function BehaviourBase:AddRef_(arg_10_1)
	self.refCnt_ = self.refCnt_ + 1

	if self.refCnt_ == 1 then
		self:Bind_(arg_10_1)
		self.target_:AddBehaviour_(self.name_, self)
	end
end

function BehaviourBase:Unbind_()
	if self.exportedMethods_ then
		for iter_11_0, iter_11_1 in ipairs(self.exportedMethods_) do
			self.target_[iter_11_1] = nil
		end
	end

	self:OnUnbind_()

	if self.depends_ then
		for iter_11_2, iter_11_3 in ipairs(self.depends_) do
			self.target_:RemoveBehaviour(iter_11_3)
		end
	end
end

function BehaviourBase:SubRef_()
	self.refCnt_ = self.refCnt_ - 1

	if self.refCnt_ <= 0 then
		self:Unbind_()
		self.target_:RemoveBehaviour_(self.name_)
	end
end

function BehaviourBase:OnBind_()
	return
end

function BehaviourBase:OnUnbind_()
	return
end

return BehaviourBase
