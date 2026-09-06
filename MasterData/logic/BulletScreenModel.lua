-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bulletscreen/model/BulletScreenModel.lua

module("logic.extensions.bulletscreen.model.BulletScreenModel", package.seeall)

local BulletScreenModel = class("BulletScreenModel", BaseModel)

function BulletScreenModel:onInit()
	self:onReset()
end

function BulletScreenModel:onReset()
	self._localBullets = {}

	self:setEnum(nil)
	self:setKey(nil)
end

function BulletScreenModel:setEnum(value)
	self._curEnum = value
end

function BulletScreenModel:setKey(value)
	self._curKey = value
end

function BulletScreenModel:getCurKeys()
	return self._curEnum, self._curKey
end

function BulletScreenModel:getBulletsByKeys(enum, key)
	enum = self._curEnum
	key = self._curKey

	local t1 = BulletScreenConfig.instance:getCfgList(self._curEnum, self._curKey)
	local t2 = self:getLocalBullets(enum, key)
	local t = {}

	for _, v in ipairs(t1) do
		table.insert(t, v)
	end

	for _, v in ipairs(t2) do
		table.insert(t, v)
	end

	table.sort(t, function(a, b)
		return a.time < b.time
	end)

	return t
end

function BulletScreenModel:localAddBullet(enum, key, content, time)
	if enum ~= nil and key ~= nil then
		local data = {}

		data.content = content
		data.time = time
		data.isMe = true
		self._localBullets[enum] = self._localBullets[enum] or {}
		self._localBullets[enum][key] = self._localBullets[enum][key] or {}

		table.insert(self._localBullets[enum][key], data)
	end
end

function BulletScreenModel:getLocalBullets(enum, key)
	if self._localBullets[enum] then
		return self._localBullets[enum][key] or {}
	end

	return {}
end

BulletScreenModel.instance = BulletScreenModel.New()

return BulletScreenModel
