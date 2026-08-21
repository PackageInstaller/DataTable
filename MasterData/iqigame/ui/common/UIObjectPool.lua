-- chunkname: @IQIGame\\UI\\Common\\UIObjectPool.lua

local UIObjectPool = {
	Size = 8,
	Pool = {}
}

function UIObjectPool.New(size, createFunc, disposeFunc)
	local uiObjectPool = Clone(UIObjectPool)

	uiObjectPool.Size = size
	uiObjectPool.CreateFunc = createFunc
	uiObjectPool.DisposeFunc = disposeFunc

	return uiObjectPool
end

function UIObjectPool:Obtain()
	local obj

	if #self.Pool > 0 then
		obj = table.remove(self.Pool, 1)
	else
		obj = self.CreateFunc()
	end

	self:ResetObject(obj)

	return obj
end

function UIObjectPool:ResetObject(obj)
	return
end

function UIObjectPool:Release(obj)
	if #self.Pool < self.Size then
		table.insert(self.Pool, obj)
	elseif self.DisposeFunc == nil then
		if UIObjectPool.ISGameObject(obj) then
			UnityEngine.Object.Destroy(obj)
		end
	else
		self.DisposeFunc(obj)
	end
end

function UIObjectPool:Clear()
	if #self.Pool > 0 then
		local obj

		for i = 1, #self.Pool do
			obj = self.Pool[i]

			if self.DisposeFunc ~= nil then
				self.DisposeFunc(obj)
			elseif UIObjectPool.ISGameObject(obj) then
				UnityEngine.Object.Destroy(obj)
			end
		end

		self.Pool = {}
	end
end

function UIObjectPool:ClearReferences()
	for i = 1, #self.Pool do
		self.Pool[i] = nil
	end

	self.CreateFunc = nil
	self.DisposeFunc = nil
end

function UIObjectPool:Dispose()
	self:Clear()

	self.CreateFunc = nil
	self.DisposeFunc = nil
end

function UIObjectPool.ISGameObject(obj)
	return obj.GetType ~= nil and obj:GetType() == typeof(UnityEngine.GameObject)
end

return UIObjectPool
