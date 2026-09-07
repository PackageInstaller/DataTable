local BasePanel = class("BasePanel")

function BasePanel:Ctor(arg_1_1)
	assert(arg_1_1)

	self._go = arg_1_1
	self._tf = arg_1_1.transform

	function self.emit()
		assert(false, "can not emit event beforce attach to a parent ui.")

		return
	end

	bindComponent(self, self._go)
	self:init()

	return
end

function BasePanel:init()
	return
end

function BasePanel:attach(arg_4_1)
	assert(arg_4_1)

	self.exited = false
	self.parent = arg_4_1
	self.contextData = arg_4_1.contextData

	function self:emit(arg_5_1, ...)
		if self.parent then
			self.parent:emit(arg_5_1, ...)
		end

		return
	end

	function self:bind(...)
		if self.parent then
			self.parent:bind(...)
		end

		return
	end

	function self:disconnect(arg_7_1)
		if self.parent then
			self.parent:disconnect(arg_7_1)
		end

		return
	end

	setActive(self._go, true)
	pg.DelegateInfo.New(self)

	return
end

function BasePanel:detach()
	if not self.exited then
		setActive(self._go, false)
		pg.DelegateInfo.Dispose(self)
		self:clear()
		bindComponent(self, self._go, true)

		self.parent = nil
		self.emit = nil
		self.bind = nil
		self.disconnect = nil
		self.exited = true
	end

	return
end

function BasePanel:getTpl(arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2:Find(arg_9_1)

	var_9_0:SetParent(self._tf, false)
	SetActive(var_9_0, false)

	return var_9_0
end

function BasePanel:clear()
	return
end

return BasePanel
