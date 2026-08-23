local ObjectPoolItem = class("ObjectPoolItem")

ObjectPoolItem.isItem = true

function ObjectPoolItem:__ctor()
	self._pool = nil
end

function ObjectPoolItem:setPool(arg_2_1)
	self._pool = arg_2_1
end

function ObjectPoolItem:dispose()
	self:releaseToPool()
end

function ObjectPoolItem:releaseToPool()
	if self._pool then
		self._pool:releaseObj(self)
	end
end

function ObjectPoolItem:onReset()
	return
end

function ObjectPoolItem:onGet(arg_6_1)
	return
end

return ObjectPoolItem
