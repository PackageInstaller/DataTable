local WalkLine = class("WalkLine")

function WalkLine:ctor()
	self._startPos = nil
	self._endPos = nil
	self._lineDist = nil
	self._normalizeX = 0
	self._normalizeY = 0
	self._walkDist = 0
end

function WalkLine:setLine(arg_2_1, arg_2_2)
	self._startPos = arg_2_1
	self._endPos = arg_2_2
	self._walkDist = 0
	self._lineDist = math.sqrt((self._endPos.x - self._startPos.x) * (self._endPos.x - self._startPos.x) + (self._endPos.y - self._startPos.y) * (self._endPos.y - self._startPos.y))

	if self._lineDist <= 0 then
		return false
	end

	self._normalizeX = (self._endPos.x - self._startPos.x) / self._lineDist
	self._normalizeY = (self._endPos.y - self._startPos.y) / self._lineDist

	return true
end

function WalkLine:step(arg_3_1)
	self._walkDist = self._walkDist + arg_3_1

	if self._walkDist - self._lineDist >= 0 then
		return self._endPos, self._walkDist - self._lineDist
	end

	return cc.p(self._startPos.x + self._normalizeX * self._walkDist, self._startPos.y + self._normalizeY * self._walkDist), self._walkDist - self._lineDist
end

return WalkLine
