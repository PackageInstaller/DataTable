-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/datastruct/SignalAmount.lua

module("framework.datastruct.SignalAmount", package.seeall)

local defaultKey = "default_key"
local SignalAmount = class("SignalAmount")

function SignalAmount:ctor(name)
	self._name = name
	self._key2Num = nil
	self._count = 0
end

function SignalAmount:add(key)
	key = key or defaultKey
	self._key2Num = self._key2Num or {}
	self._key2Num[key] = self._key2Num[key] and self._key2Num[key] + 1 or 1
	self._count = self._count + 1
end

function SignalAmount:remove(key)
	key = key or defaultKey

	if self._key2Num and self._key2Num[key] then
		local num = self._key2Num[key] - 1

		if num == 0 then
			self._key2Num[key] = nil
		else
			self._key2Num[key] = 0
		end

		self._count = self._count - 1
	end
end

function SignalAmount:isActive()
	return self:getCount() > 0
end

function SignalAmount:isUnactive()
	return not self:isActive()
end

function SignalAmount:getCount()
	return self._count
end

function SignalAmount:getKeyCount(key)
	key = key or defaultKey

	if self._key2Num and self._key2Num[key] then
		return self._key2Num[key]
	end

	return 0
end

function SignalAmount:hasKey(key)
	return self:getKeyCount(key) > 0
end

function SignalAmount:clear()
	if self._key2Num then
		self._key2Num = nil
		self._count = 0
	end
end

function SignalAmount:toString()
	local sb = StringBuffer.New()

	sb:append("Signal Name:"):append(self._name):appendLine()
	sb:append("Total Count:"):append(self._count):appendLine()

	for k, v in pairs(self._key2Num) do
		sb:append(k):append(":"):append(v):appendLine()
	end

	local s = sb:toString()

	sb:clear()

	return s
end

function SignalAmount:dump()
	print(self:toString())
end

return SignalAmount
