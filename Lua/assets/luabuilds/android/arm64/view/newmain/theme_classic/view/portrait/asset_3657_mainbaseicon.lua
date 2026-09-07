local MainBaseIcon = class("MainBaseIcon")

function MainBaseIcon:Ctor(arg_1_1)
	self._tf = arg_1_1
	self._go = arg_1_1.gameObject
	self.loading = false

	return
end

function MainBaseIcon:Resume()
	return
end

function MainBaseIcon:Pause()
	return
end

function MainBaseIcon:Load(arg_4_1)
	return
end

function MainBaseIcon:Unload()
	return
end

function MainBaseIcon:IsLoading()
	return self.loading
end

function MainBaseIcon:Dispose()
	self.exited = true

	self:Unload()

	return
end

return MainBaseIcon
