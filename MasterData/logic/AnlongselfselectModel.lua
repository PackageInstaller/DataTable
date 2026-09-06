-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anlongselfselect/model/AnlongselfselectModel.lua

module("logic.extensions.anlongselfselect.view.AnlongselfselectModel", package.seeall)

local AnlongselfselectModel = class("AnlongselfselectModel", BaseModel)

function AnlongselfselectModel:ctor()
	return
end

function AnlongselfselectModel:onInit()
	self:onReset()
end

function AnlongselfselectModel:onReset()
	self._hasGainDailyPrize = false
	self._packInfos = {}
end

function AnlongselfselectModel:setInfo(msg)
	self._hasGainDailyPrize = msg.hasGainDailyPrize
	self._packInfos = {}

	for i, v in ipairs(msg.packInfos) do
		self._packInfos[v.packId] = v
	end
end

function AnlongselfselectModel:hasGainDailyPrize()
	return self._hasGainDailyPrize
end

function AnlongselfselectModel:getPackInfos()
	return self._packInfos
end

function AnlongselfselectModel:addBuyTime(packId, time)
	if self._packInfos[packId] then
		self._packInfos[packId].buyTimes = self._packInfos[packId].buyTimes + time
	else
		self._packInfos[packId] = {
			buyTimes = time,
			packId = packId
		}
	end
end

AnlongselfselectModel.instance = AnlongselfselectModel.New()

return AnlongselfselectModel
