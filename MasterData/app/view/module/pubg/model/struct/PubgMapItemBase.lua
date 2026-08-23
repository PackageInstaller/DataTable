local var_0_0 = g.core.common.ServerTime
local PubgMapItemBase = class("PubgMapItemBase")

function PubgMapItemBase:ctor(arg_1_1)
	self._type = g.core.const.ConstMgr.PubgConst.map.itemType.none
	self._posX = 0
	self._posY = 0
	self._posTime = var_0_0:getTime()
	self._lastSeeTime = 0
	self._uid = arg_1_1.uid
	self._oid = nil
end

function PubgMapItemBase:getPos()
	return self._posX, self._posY
end

function PubgMapItemBase:setPos(arg_3_1)
	self._posTime = var_0_0:getTime()
	self._posX = arg_3_1.x
	self._posY = arg_3_1.y
end

function PubgMapItemBase:setPosXY(arg_4_1, arg_4_2)
	self._posTime = var_0_0:getTime()
	self._posX = arg_4_1
	self._posY = arg_4_2
end

function PubgMapItemBase:getPosTime()
	return self._posTime
end

function PubgMapItemBase:getUid()
	return self._uid
end

function PubgMapItemBase:getName()
	return ""
end

function PubgMapItemBase:setLastSee(arg_8_1)
	self._lastSeeTime = arg_8_1
end

function PubgMapItemBase:getLastSee()
	return self._lastSeeTime
end

function PubgMapItemBase:getType()
	return self._type
end

function PubgMapItemBase:getOnlyKey()
	self._oid = self._oid or table.concat({
		self:getType(),
		self:getUid()
	}, "_")

	return self._oid
end

return PubgMapItemBase
