local PacGameGrid = class("PacGameGrid")

function PacGameGrid:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._index = arg_1_2
	self._id = arg_1_3

	if self._id == 0 then
		self._id = PacGameConst.default_grid
	end

	self._data = PacGameConst.grid_data[self._id]
	self._selectTF = findTF(arg_1_1, "ad/select")

	setActive(self._selectTF, false)

	self._scoreTF = findTF(arg_1_1, "ad/score")

	if self._scoreTF then
		setActive(self._scoreTF, false)
	end

	self._scoreFlag = false

	if self._data.score then
		self._score = self._data.score
	end

	return
end

function PacGameGrid:GetId()
	return self._id
end

function PacGameGrid:SetParent(arg_3_1)
	setParent(self._tf, arg_3_1, false)

	return
end

function PacGameGrid:SetPosition(arg_4_1)
	self._tf.anchoredPosition = arg_4_1

	return
end

function PacGameGrid:GetPosition()
	return self._tf.anchoredPosition
end

function PacGameGrid:SetScale(arg_6_1)
	self._tf.localScale = arg_6_1

	return
end

function PacGameGrid:HasScore()
	return not not self._data.score
end

function PacGameGrid:SetScoreFlag(arg_8_1)
	setActive(self._scoreTF, arg_8_1)

	self._scoreFlag = arg_8_1

	return
end

function PacGameGrid:SetVH(arg_9_1, arg_9_2)
	self._vetical = arg_9_1
	self._horizontal = arg_9_2

	return
end

function PacGameGrid:GetVH()
	return self._vetical, self._horizontal
end

function PacGameGrid:GetScoreFlag()
	return self._scoreFlag and isActive(self._scoreTF)
end

function PacGameGrid:GetScore()
	return (self._score or nil) and (self._score or 0)
end

function PacGameGrid:SetActive(arg_13_1)
	setActive(self._tf, arg_13_1)

	return
end

function PacGameGrid:GetIndex()
	return self._index
end

function PacGameGrid:GetPassAble()
	return self._data.pass
end

function PacGameGrid:Dispose()
	if self._tf then
		Destroy(self._tf)

		self._tf = nil
	end

	self._data = nil

	return
end

return PacGameGrid
