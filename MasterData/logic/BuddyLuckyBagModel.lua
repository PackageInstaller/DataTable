-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/model/BuddyLuckyBagModel.lua

module("logic.extensions.buddyluckybag.model.BuddyLuckyBagModel", package.seeall)

local BuddyLuckyBagModel = class("BuddyLuckyBagModel", BaseModel)

function BuddyLuckyBagModel:onInit()
	self:onReset()
end

function BuddyLuckyBagModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end
end

function BuddyLuckyBagModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = BuddyLuckyBagSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

BuddyLuckyBagModel.instance = BuddyLuckyBagModel.New()

return BuddyLuckyBagModel
