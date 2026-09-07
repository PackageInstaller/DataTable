local BeachGuardGrid = class("BeachGuardGrid")

function BeachGuardGrid:Ctor(arg_1_1, arg_1_2)
	self._gridTf = arg_1_1
	self._event = arg_1_2
	self.preIcon = findTF(self._gridTf, "charPos/preIcon")

	setActive(self.preIcon, false)

	self.collider = findTF(self._gridTf, "gridCollider")
	self.minX = self.collider.rect.min.x
	self.minY = self.collider.rect.min.y
	self.maxX = self.collider.rect.max.x
	self.maxY = self.collider.rect.max.y
	self.select = findTF(self._gridTf, "select")

	setActive(self.select, false)

	self.char = nil
	self.range = findTF(self._gridTf, "range")

	setActive(self.range, false)

	self.full = findTF(self._gridTf, "full")

	setActive(self.full, false)

	self.recycle = findTF(self._gridTf, "recycle")

	setActive(self.recycle, false)

	self.pos = findTF(self._gridTf, "charPos")

	return
end

function BeachGuardGrid:setLineIndex(arg_2_1)
	self._lineIndex = arg_2_1

	return
end

function BeachGuardGrid:getLineIndex()
	return self._lineIndex
end

function BeachGuardGrid:setIndex(arg_4_1)
	self._index = arg_4_1

	return
end

function BeachGuardGrid:getIndex()
	return self._index
end

function BeachGuardGrid:getPos()
	return self.pos
end

function BeachGuardGrid:active(arg_7_1)
	setActive(self._lineTf, arg_7_1)

	return
end

function BeachGuardGrid:prechar(arg_8_1)
	local var_8_0 = GetComponent(self.preIcon, typeof(Image))

	var_8_0.sprite = BeachGuardAsset.getCardIcon(BeachGuardConst.chars[arg_8_1].name)

	var_8_0:SetNativeSize()
	setActive(self.preIcon, true)
	setActive(self.select, true)

	return
end

function BeachGuardGrid:unPreChar()
	setActive(self.preIcon, false)
	setActive(self.select, false)

	return
end

function BeachGuardGrid:inGridWorld(arg_10_1)
	local var_10_0 = self._gridTf:InverseTransformPoint(arg_10_1)

	if var_10_0.x > self.minX and var_10_0.x < self.maxX and var_10_0.y > self.minY and var_10_0.y < self.maxY then
		return true
	end

	return false
end

function BeachGuardGrid:setChar(arg_11_1)
	if self.char then
		return
	end

	self.char = arg_11_1

	return
end

function BeachGuardGrid:getChar()
	return self.char
end

function BeachGuardGrid:removeChar()
	self.char = nil

	setActive(self.full, false)

	return
end

function BeachGuardGrid:isEmpty()
	return self.char == nil
end

function BeachGuardGrid:start()
	return
end

function BeachGuardGrid:step(arg_16_1)
	if self.char and self.char:getRecycleFlag() then
		setActive(self.recycle, true)
	else
		setActive(self.recycle, false)
	end

	return
end

function BeachGuardGrid:clear()
	setActive(self.select, false)
	setActive(self.preIcon, false)
	setActive(self.full, false)

	self.char = nil

	return
end

function BeachGuardGrid:preDistance()
	setActive(self.range, true)

	return
end

function BeachGuardGrid:unPreDistance()
	setActive(self.range, false)

	return
end

return BeachGuardGrid
