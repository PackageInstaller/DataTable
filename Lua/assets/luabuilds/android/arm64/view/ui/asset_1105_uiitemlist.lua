local UIItemList = class("UIItemList")

UIItemList.EventInit = 1
UIItemList.EventUpdate = 2
UIItemList.EventExcess = 3

function UIItemList:Ctor(arg_1_1, arg_1_2)
	assert(not IsNil(arg_1_1))
	assert(not IsNil(arg_1_2))

	self.container = arg_1_1
	self.item = arg_1_2
	self.currentCount = 0

	return
end

function UIItemList:make(arg_2_1)
	assert(arg_2_1 == nil or type(arg_2_1) == "function")

	self.callback = arg_2_1

	return
end

function UIItemList:align(arg_3_1, arg_3_2)
	assert(arg_3_1 >= 0)

	local var_3_0 = self.container

	for iter_3_0 = self.container.childCount, arg_3_1 - 1 do
		local var_3_1 = cloneTplTo(self.item, self.container)
	end

	if self.callback then
		for iter_3_1 = self.currentCount, arg_3_1 - 1 do
			self.callback(UIItemList.EventInit, iter_3_1, (self.container:GetChild(iter_3_1)))
		end

		for iter_3_2 = arg_3_1, self.currentCount - 1 do
			self.callback(UIItemList.EventExcess, iter_3_2, (self.container:GetChild(iter_3_2)))
		end

		self.currentCount = arg_3_1
	end

	arg_3_2 = arg_3_2 or 0

	for iter_3_3 = arg_3_1, self.container.childCount - 1 do
		setActive(self.container:GetChild(iter_3_3), false)
	end

	if arg_3_2 > 0 then
		for iter_3_4 = 0, arg_3_1 - 1 do
			setActive(self.container:GetChild(iter_3_4), false)
		end

		local var_3_2 = 0

		self:StopTimer()

		self.timer = Timer.New(function()
			local var_4_0 = var_3_0:GetChild(var_3_2)

			setActive(var_4_0, true)

			if self.callback then
				self.callback(UIItemList.EventUpdate, var_3_2, var_4_0)
			end

			var_3_2 = var_3_2 + 1

			if var_3_2 >= arg_3_1 then
				self:StopTimer()
			end

			return
		end, arg_3_2, arg_3_1)

		self.timer.func()
		self.timer:Start()
	else
		for iter_3_5 = 0, arg_3_1 - 1 do
			local var_3_3 = self.container:GetChild(iter_3_5)

			setActive(var_3_3, true)

			if self.callback then
				self.callback(UIItemList.EventUpdate, iter_3_5, var_3_3)
			end
		end
	end

	return
end

function UIItemList:each(arg_5_1)
	for iter_5_0 = self.container.childCount - 1, 0, -1 do
		arg_5_1(iter_5_0, (self.container:GetChild(iter_5_0)))
	end

	return
end

function UIItemList:eachActive(arg_6_1)
	for iter_6_0 = 0, self.container.childCount - 1 do
		local var_6_0 = self.container:GetChild(iter_6_0)

		if isActive(var_6_0) then
			arg_6_1(iter_6_0, var_6_0)
		end
	end

	return
end

function UIItemList:StaticAlign(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = UIItemList.New(self, arg_7_1)

	var_7_0:make(arg_7_3)
	var_7_0:align(arg_7_2)

	return
end

function UIItemList:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function UIItemList:Dispose()
	self:StopTimer()

	return
end

return UIItemList
