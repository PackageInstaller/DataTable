local Observer = import("..patterns.observer.Observer")
local View = class("View")

function View:Ctor(arg_1_1)
	if View.instanceMap[arg_1_1] ~= nil then
		error(View.MULTITON_MSG)
	end

	self.multitonKey = arg_1_1
	View.instanceMap[self.multitonKey] = self
	self.mediatorMap = {}
	self.observerMap = {}

	self:initializeView()

	return
end

function View:initializeView()
	return
end

function View:getInstance()
	if self == nil then
		return nil
	end

	if View.instanceMap[self] == nil then
		return View.New(self)
	else
		return View.instanceMap[self]
	end

	return
end

function View:registerObserver(arg_4_1, arg_4_2)
	if self.observerMap[arg_4_1] ~= nil then
		table.insert(self.observerMap[arg_4_1], arg_4_2)
	else
		self.observerMap[arg_4_1] = {
			arg_4_2
		}
	end

	return
end

function View:notifyObservers(arg_5_1)
	local var_5_0 = self.observerMap[arg_5_1:getName()]

	if var_5_0 ~= nil then
		for iter_5_0, iter_5_1 in pairs((table.shallowCopy(var_5_0))) do
			if table.contains(var_5_0, iter_5_1) then
				iter_5_1:notifyObserver(arg_5_1)
			end
		end
	end

	return
end

function View:removeObserver(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in pairs(self.observerMap[arg_6_1]) do
		if iter_6_1:compareNotifyContext(arg_6_2) then
			table.remove(self.observerMap[arg_6_1], iter_6_0)

			break
		end
	end

	if #self.observerMap[arg_6_1] == 0 then
		self.observerMap[arg_6_1] = nil
	end

	return
end

function View:registerMediator(arg_7_1)
	if self.mediatorMap[arg_7_1:getMediatorName()] ~= nil then
		return
	end

	arg_7_1:initializeNotifier(self.multitonKey)

	self.mediatorMap[arg_7_1:getMediatorName()] = arg_7_1

	local var_7_0 = arg_7_1:listNotificationInterests()

	if #var_7_0 > 0 then
		local var_7_1 = Observer.New(arg_7_1.handleNotification, arg_7_1)

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			self:registerObserver(iter_7_1, var_7_1)
		end
	end

	arg_7_1:onRegister()

	return
end

function View:retrieveMediator(arg_8_1)
	return self.mediatorMap[arg_8_1]
end

function View:removeMediator(arg_9_1)
	if self.mediatorMap[arg_9_1] ~= nil then
		for iter_9_0, iter_9_1 in pairs((self.mediatorMap[arg_9_1]:listNotificationInterests())) do
			self:removeObserver(iter_9_1, self.mediatorMap[arg_9_1])
		end

		self.mediatorMap[arg_9_1] = nil

		self.mediatorMap[arg_9_1]:onRemove()
	end

	return self.mediatorMap[arg_9_1]
end

function View:hasMediator(arg_10_1)
	return self.mediatorMap[arg_10_1] ~= nil
end

function View:removeView()
	View.instanceMap[self] = nil

	return
end

View.instanceMap = {}
View.MULTITON_MSG = "View instance for this Multiton key already constructed!"

return View
