local PacGameItem = class("PacGameItem")

function PacGameItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._index = arg_1_2
	self._data = arg_1_3

	return
end

function PacGameItem:SetParent(arg_2_1)
	setParent(self._tf, arg_2_1, false)

	return
end

function PacGameItem:SetPosition(arg_3_1)
	self._tf.anchoredPosition = arg_3_1

	return
end

function PacGameItem:GetPosition()
	return self._tf.anchoredPosition
end

function PacGameItem:SetScale(arg_5_1)
	self._tf.localScale = arg_5_1

	return
end

function PacGameItem:SetActive(arg_6_1)
	setActive(self._tf, arg_6_1)

	return
end

function PacGameItem:GetIndex()
	return self._index
end

function PacGameItem:GetConfig(arg_8_1)
	return self._data[arg_8_1]
end

function PacGameItem:Dispose()
	if self._tf then
		Destroy(self._tf)

		self._tf = nil
	end

	self._index = nil
	self._data = nil

	return
end

return PacGameItem
