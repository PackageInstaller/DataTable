local LuaItemPool = class("LuaItemPool")

function LuaItemPool:Ctor(arg_1_1, arg_1_2)
	self.uselessParent_ = GameObject.Find("/Pool").transform
	self._templatePath = arg_1_2
	self._class = arg_1_1
	self._pool = {}
end

function LuaItemPool:LoadItem(arg_2_1)
	self._template = Asset.Load(self._templatePath)

	for iter_2_0 = 1, arg_2_1 do
		self:AddPool()
	end
end

function LuaItemPool:AddPool(arg_3_1)
	self._template = self._template or Asset.Load(self._templatePath)
	self._pool[#self._pool + 1] = self._class.New(arg_3_1 and Object.Instantiate(self._template, arg_3_1.transform) or Object.Instantiate(self._template, self.uselessParent_.transform))
end

function LuaItemPool:Get(arg_4_1)
	if #self._pool >= 1 then
		self._pool[#self._pool] = nil

		self._pool[#self._pool].gameObject_.transform:SetParent(arg_4_1.transform, false)

		return self._pool[#self._pool]
	end

	self:AddPool(arg_4_1)

	self._pool[#self._pool] = nil

	return self._pool[#self._pool]
end

function LuaItemPool:Release(arg_5_1)
	arg_5_1.transform_:SetParent(self.uselessParent_, false)

	self._pool[#self._pool + 1] = arg_5_1
end

function LuaItemPool:Dispose()
	for iter_6_0, iter_6_1 in ipairs(self._pool) do
		Object.Destroy(iter_6_1.gameObject_)
		iter_6_1:Dispose()
	end

	self._pool = nil
	self._template = nil
end

return LuaItemPool
