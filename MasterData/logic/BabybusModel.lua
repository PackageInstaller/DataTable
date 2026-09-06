-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/babybus/model/BabybusModel.lua

module("logic.extensions.babybus.view.BabybusModel", package.seeall)

local BabybusModel = class("BabybusModel", BaseModel)

function BabybusModel:ctor()
	return
end

function BabybusModel:onInit()
	self:onReset()
end

function BabybusModel:onReset()
	self._curprogress = 0
	self._haswalkedtoday = false
	self._gainedprizeids = {}
	self._codeinfos = {}
end

function BabybusModel:setInfo(msg)
	self._curprogress = msg.curProgress
	self._haswalkedtoday = msg.hasWalkedToday
	self._gainedprizeids = msg.gainedPrizeIds
	self._codeinfos = {}

	GameUtil.pbToTable(msg.codeInfos, self._codeinfos)
end

function BabybusModel:getCurprogress()
	return self._curprogress
end

function BabybusModel:isWalkedToday()
	return self._haswalkedtoday
end

function BabybusModel:setWaledToday()
	self._haswalkedtoday = true
	self._curprogress = self._curprogress + 1
end

function BabybusModel:isGainPrize(prizeId)
	for i, v in ipairs(self._gainedprizeids) do
		if v == prizeId then
			return true
		end
	end
end

function BabybusModel:isCanGainPrize(prizeId, progress)
	if self:isGainPrize(prizeId) then
		return false
	end

	if progress <= self._curprogress then
		return true
	end
end

function BabybusModel:gainPrize(prizeId, code)
	self._gainedprizeids:append(prizeId)

	local hit = false

	for i, v in ipairs(self._codeinfos) do
		if v.prizeId == prizeId then
			v.code = code
			hit = true

			break
		end
	end

	if not hit then
		table.insert(self._codeinfos, {
			prizeId = prizeId,
			code = code
		})
	end
end

function BabybusModel:getExchangeCode(prizeId)
	for i, v in ipairs(self._codeinfos) do
		if v.prizeId == prizeId then
			return v.code
		end
	end

	return ""
end

BabybusModel.instance = BabybusModel.New()

return BabybusModel
